/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Huynh Anh Phuong
  ID: s3695662
  Created  date: 08/09/2022
  Last modified: 29/09/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import AVFoundation

class GameControl: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    @Published var redButton = "red"
    @Published var yellowButton = "yellow"
    @Published var blueButton = "blue"
    @Published var greenButton = "green"
    @Published var hasLost = false
    @Published var isPause = false
    @Published var numberOfTaps = 0
    @Published var currentItem = 0
    @Published var isCorrect = false
    @Published var isWrong = false
    @Published var isHighScore = false
    
    var readyForPlayer = false
    var audioPlayer: AVAudioPlayer!

    var playerControl: PlayersControl
    
    private var seletedLevel = UserDefaults.standard.string(forKey: Settings.selectedLevel) ?? "easy"
    
    init(userSettings: UserSettings) {
        self.playerControl = PlayersControl(userSettings: userSettings)
    }
    
    // MARK: play sound by number
    func playSound(key: String) {
        let url = Bundle.main.url(forResource: key, withExtension: "wav")
        guard url != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
            audioPlayer.delegate = self
        } catch {
            print(error)
        }
    }
    
    // MARK: generate random number
    func generateRandomTile() {
        let randomNumber = Int.random(in: 1..<5)
        self.playerControl.player.currentMusicList.append(randomNumber)
    }
    
    // MARK: start game
    func startGame() {
        if self.playerControl.player.currentMusicList.isEmpty {
            self.generateRandomTile()
        }
        self.playerControl.updatePlayer(hasLost: self.hasLost)
        
        self.playNextItem()
    }
    
    // MARK: start next round
    func nextRound() {
        self.playerControl.player.currentLevel += 1
        readyForPlayer = false
        numberOfTaps = 0
        currentItem = 0
        generateRandomTile()
        
        DispatchQueue.main.async {
            self.playerControl.updatePlayer(hasLost: self.hasLost)
        }
        
        self.playNextItem()
    }
    
    // MARK: play next item by index
    func playNextItem () {
        if !isPause {
            let selectedItem = self.playerControl.player.currentMusicList[currentItem]
            
            switch selectedItem {
            case 1:
                highlightButtonWithTag(tag: 1)
                playSound(key: "1")
            case 2:
                highlightButtonWithTag(tag: 2)
                playSound(key: "2")
            case 3:
                highlightButtonWithTag(tag: 3)
                playSound(key: "3")
            case 4:
                highlightButtonWithTag(tag: 4)
                playSound(key: "4")
            default:
                break
            }
            currentItem += 1
        } else {
            resetButtonHighlights()
        }
    }
    
    // MARK: detect if audio has stopped or not
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentItem <= self.playerControl.player.currentMusicList.count - 1 {
            playNextItem()
        } else {
            resetButtonHighlights()
            readyForPlayer = true
        }
    }
    
    // MARK: sound on press
    func soundButtonOnPressed(key: String) {
        if readyForPlayer {
            playSound(key: key)
            highlightButtonWithTag(tag: Int(key)!)
            checkIfCorrect(buttonPressed: Int(key)!)
        }
    }
    
    // MARK: checking correct button click
    func checkIfCorrect(buttonPressed:Int) {
        if buttonPressed == self.playerControl.player.currentMusicList[numberOfTaps] {
            if numberOfTaps == self.playerControl.player.currentMusicList.count - 1 { // we have arrived at the last item of the playlist
                self.playerControl.player.currentScore += 5
                self.isCorrect = true
                if self.isCorrect {
                    self.readyForPlayer = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isCorrect = false
                    self.nextRound()
                }
                return
            }
            numberOfTaps += 1
        } else { // GAME OVER
            self.isWrong = true
            self.readyForPlayer = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isWrong = false
                self.hasLost = true
                self.resetGame()
            }
        }
    }
    
    // MARK: restart game
    func restartGame() {
        let group = DispatchGroup()
        group.enter()

        DispatchQueue.global().async {
            self.playerControl.updatePlayer(hasLost: true)
            group.leave()
        }

        group.wait()
    }
    
    // MARK: reset game
    func resetGame() {
        let group = DispatchGroup()
        group.enter()

        DispatchQueue.main.async {
            self.playerControl.updatePlayer(hasLost: self.hasLost)
            group.leave()
        }

        group.notify(queue: .main) {
            self.numberOfTaps = 0
            self.currentItem = 0
            if self.playerControl.player.currentScore > self.playerControl.player.highestScore {
                self.isHighScore = true
            }
        }
    }
    
    // MARK: reset button by color
    func resetButtonHighlights () {
        redButton = "red"
        blueButton = "blue"
        greenButton = "green"
        yellowButton = "yellow"
    }
    
    // MARK: high light button with number
    func highlightButtonWithTag (tag:Int) {
        switch tag {
        case 1:
            resetButtonHighlights()
            redButton = "redPressed"
        case 2:
            resetButtonHighlights()
            yellowButton = "yellowPressed"
        case 3:
            resetButtonHighlights()
            blueButton = "bluePressed"
        case 4:
            resetButtonHighlights()
            greenButton = "greenPressed"
        default:
            break
        }
    }
    
    // MARK: reset player control object
    func resetState(userSettings: UserSettings) {
        self.playerControl = PlayersControl(userSettings: userSettings)
    }
    
}
