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

import SwiftUI
import PopupView

struct GameView: View {
    
    @ObservedObject var gameControl: GameControl
    @ObservedObject var playerControl: PlayersControl
    
    @State private var backToMenu: Bool = false
    
    @State private var isReplay: Bool = false
    
    @State private var score: Int = 0
    
    @StateObject var soundControl: SoundControl = SoundControl()
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isStart: Bool = true
    
    @ObservedObject var userSettings: UserSettings
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isActive: Bool = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var timeRemaining : Int
    
    init(gameControl: GameControl, playerControl: PlayersControl, userSettings: UserSettings) {
        self.gameControl = gameControl
        self.playerControl = playerControl
        self.userSettings = userSettings
        _timeRemaining = State(wrappedValue: playerControl.levelOptions[userSettings.selectedLevel] ?? 60)
    }
    
    var body: some View {
        GeometryReader { bounds in
            VStack {
                if !isStart {
                    PauseTopBarView(timeRemaining: timeRemaining)
                        .onTapGesture {
                            self.gameControl.isPause = true
                        }
                }
                
                ZStack {
                    VStack {
                        HStack {
                            ItemView(shapeColor: self.gameControl.redButton, gameControl: self.gameControl, key: "1", width: bounds.size.width > 768 ? 350 : 190, height: bounds.size.height > 1024 ? 350 : 190)
                            
                            ItemView(shapeColor: self.gameControl.yellowButton, gameControl: self.gameControl, key: "2", width: bounds.size.width > 768 ? 350 : 190, height: bounds.size.height > 1024 ? 350 : 190)
                        }
                        
                        HStack {
                            ItemView(shapeColor: self.gameControl.greenButton, gameControl: self.gameControl, key: "4", width: bounds.size.width > 768 ? 350 : 190, height: bounds.size.height > 1024 ? 350 : 190)
                            ItemView(shapeColor: self.gameControl.blueButton, gameControl: self.gameControl, key: "3", width: bounds.size.width > 768 ? 350 : 190, height: bounds.size.height > 1024 ? 350 : 190)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    // MARK: player answered correctly
                    if self.gameControl.isCorrect {
                        withAnimation(.spring()) {
                            NotiView(title: "✅ Correct ✅")
                        }
                    }
                    
                    // MARK: player answered wrong
                    if self.gameControl.isWrong {
                        withAnimation(.spring()) {
                            NotiView(title: "❌ Wrong ❌")
                        }
                    }
                    
                    // MARK: start signal
                    if self.isStart {
                        withAnimation(.spring()) {
                            NotiView(title: "📣 START 📣")
                        }
                    }
                }
                
                // MARK: correct sound
                .onChange(of: self.gameControl.isCorrect) { value in
                    if value {
                        soundControl.playSound(soundName: "correct", fileType: "mp3", num: 0)
                    }
                }
                // MARK: wrong sound
                .onChange(of: self.gameControl.isWrong) { value in
                    if value {
                        soundControl.playSound(soundName: "wrong", fileType: "mp3", num: 0)
                    }
                }
                // MARK: score view
                ScoreView(score: self.gameControl.playerControl.player.currentScore, level: self.gameControl.playerControl.player.currentLevel)
            }
            // MARK: pop up gameover view
            .popup(isPresented:
                    Binding.constant(self.gameControl.hasLost || self.gameControl.isPause ), type: .toast, position: .bottom, dragToDismiss: false, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
                
                GameoverView(score: self.gameControl.playerControl.player.currentScore, backToMenu: $backToMenu, isReplay: self.$isReplay, isPause: self.$gameControl.isPause, playerControl: playerControl, gameControl: gameControl, userSettings: userSettings)
                
                    // MARK: resume action
                    .onChange(of: self.gameControl.isPause) { value in
                        if !value {
                            self.gameControl.numberOfTaps = 0
                            self.gameControl.currentItem = 0
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                self.gameControl.playNextItem()
                                self.timeRemaining = self.playerControl.levelOptions[userSettings.selectedLevel] ?? 60
                            }
                        }
                    }
            }
                    // MARK: play player lost sound
                    .onChange(of: self.gameControl.hasLost) { value in
                        if value {
                            self.soundControl.playSound(soundName: "losing", fileType: "mp3", num: 0)
                        }
                    }
                    // MARK: play new high score sound
                    .onChange(of: self.gameControl.isHighScore) { value in
                        if value {
                            self.soundControl.playSound(soundName: "highScore", fileType: "mp3", num: 0)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            self.soundControl.playSound(soundName: "start", fileType: "wav", num: 0)
                            self.gameControl.playerControl.updatePlayer(hasLost: false)
                            print("131 line")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                self.isStart = false
                                self.gameControl.startGame()
                            }
                        }
                    }
            
                    // MARK: set time countdown
                    .onReceive(timer) { _ in
                        guard !self.gameControl.isPause else {
                            return
                        }
                        
                        guard !self.gameControl.hasLost else {
                            return
                        }
                        
                        guard !self.gameControl.isCorrect else {
                            return
                        }
                        
                        guard !self.gameControl.isWrong else {
                            return
                        }
                        
                        guard self.isActive else {
                            return
                        }
                        
                        guard self.gameControl.readyForPlayer else {
                            self.timeRemaining = self.playerControl.levelOptions[userSettings.selectedLevel] ?? 60
                            return
                        }
                        
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        } else {
                            self.gameControl.hasLost = true
                            self.gameControl.resetGame()
                        }
                    }
                    // MARK: when screen in background
                    .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            self.isActive = true
                        } else {
                            self.isActive = false
                            self.gameControl.audioPlayer.stop()
                            self.gameControl.isPause = true
                        }
                    }
                    // MARK: when color mode change
                    .onChange(of: colorScheme) { _ in
                        self.gameControl.readyForPlayer = false
                        self.gameControl.isPause = true
                    }
            
                .navigationBarHidden(true)
        }
    }
    
    struct GameView_Previews: PreviewProvider {
        static var previews: some View {
            GameView(gameControl: GameControl(userSettings: UserSettings()), playerControl: PlayersControl(userSettings: UserSettings()), userSettings: UserSettings()).previewDevice("iPhone 11")
        }
    }
}
