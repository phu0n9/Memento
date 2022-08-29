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

class SoundControl: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    
    // MARK: play sound by file name
    func playSound(soundName: String, fileType: String, num: Int) {
        let url = Bundle.main.url(forResource: soundName, withExtension: fileType)
        guard url != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = num
        } catch {
            print(error)
        }
    }
    
    // MARK: stop sound by file name
    func stopSound(soundName: String, fileType: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: fileType)
        guard url != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.setVolume(0, fadeDuration: 10)
            audioPlayer.stop()
        } catch {
            print(error)
        }
    }
    
}
