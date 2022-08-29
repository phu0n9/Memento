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
import SwiftUI

struct PlayerResult: Codable, Identifiable {
    var id: String = UUID().uuidString
    var playerName : String
    var highestScore: Int
    var highestLevel: Int
}

struct Players: Codable, Identifiable {
    var id: String = UUID().uuidString
    var currentScore: Int
    var currentLevel: Int
    var highestScore : Int
    var highestLevel: Int
    var currentMusicList: [Int]
}
