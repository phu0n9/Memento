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
import Combine

// MARK: handle user settings
class UserSettings: ObservableObject {
    @Published var currentPlayer: String {
        didSet {
            UserDefaults.standard.set(currentPlayer, forKey: Settings.currentPlayer)
        }
    }
    
    @Published var selectedLevel: String {
        didSet {
            UserDefaults.standard.set(selectedLevel, forKey: Settings.selectedLevel)
        }
    }
    
    @Published var backgroundMusic: Bool {
        didSet {
            UserDefaults.standard.set(backgroundMusic, forKey: Settings.backgroundMusic)
        }
    }
    
    init() {
        self.currentPlayer = UserDefaults.standard.string(forKey: Settings.currentPlayer) ?? "player"
        self.selectedLevel = UserDefaults.standard.string(forKey: Settings.selectedLevel) ?? "easy"
        self.backgroundMusic = UserDefaults.standard.bool(forKey: Settings.backgroundMusic)
    }
}
