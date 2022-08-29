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
import FirebaseFirestore
import SwiftUI

class PlayersControl: ObservableObject {
    @Published var playerResults = [PlayerResult]()
    @Published var player: Players = Players(currentScore: 0, currentLevel: 1, highestScore: 0, highestLevel: 1, currentMusicList: [])
    @Published var levelOptions: [String : Int] = ["easy": 60, "medium": 30, "hard": 15]
    @Published var selectedLevel: String
    
    private var userSettings: UserSettings
    private var db = Firestore.firestore()
    
    let levelData = [0: "easy", 1: "medium", 2: "hard"]
    
    init(userSettings: UserSettings, selectedLevel: Int = 0) {
        self.userSettings = userSettings
        self.selectedLevel = levelData[selectedLevel] ?? "easy"
    }
    
    // MARK: fetching data sorted by highest score
    func fetchData() {
        db.collection(Settings.playerResults).getDocuments(completion: { querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No data")
                return
            }
            
            self.playerResults = documents.map {(queryDocumentSnapshot) -> PlayerResult in
                let levelData = queryDocumentSnapshot.get(self.selectedLevel) as? [String: Any]
                let playerName = queryDocumentSnapshot.get("playerName") ?? "player"
                if let data = levelData {
                    let highestScore = data["highestScore"] as! Int
                    let highestLevel = data["highestLevel"] as! Int
                    return PlayerResult(playerName: playerName as! String, highestScore: highestScore, highestLevel: highestLevel)
                }
                return PlayerResult(playerName: playerName as! String, highestScore: 0, highestLevel: 1)
            }.sorted(by: {$0.highestScore > $1.highestScore })
        })
    }
    
    // MARK: add new player
    private func addPlayer() {
        var ref: DocumentReference?
        ref = db.collection(Settings.playerResults).addDocument(data: [
            self.userSettings.selectedLevel: [
                "currentScore": self.player.currentScore,
                "currentLevel": self.player.currentLevel,
                "highestScore": self.player.highestScore,
                "highestLevel": self.player.highestLevel,
                "currentMusicList": self.player.currentMusicList
            ],
            "playerName": self.userSettings.currentPlayer
        ]) { error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // MARK: check player and update or add
    func updatePlayer(hasLost: Bool) {
        db.collection(Settings.playerResults).whereField("playerName", isEqualTo: self.userSettings.currentPlayer).getDocuments(completion: { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            } else {
                
                guard let data = snapshot?.documents else {
                    return
                }
                
                // new player
                guard !data.isEmpty else {
                    self.addPlayer()
                    return
                }
                
                if let currentData = data[0].get(self.userSettings.selectedLevel) as? [String: Any] {
                    let currentScore = currentData["currentScore"] as! Int
                    let currentLevel = currentData["currentLevel"] as! Int
                    let highestScore = currentData["highestScore"] as! Int
                    let highestLevel = currentData["highestLevel"] as! Int
                    let arr = currentData["currentMusicList"] as! [Int]
                    // players lost
                    guard !hasLost else {
                        if currentScore > highestScore {
                            // update high score
                            data[0].reference.updateData([
                                self.userSettings.selectedLevel : ["currentScore": 0, "currentLevel": 1, "highestScore": currentScore, "highestLevel": currentLevel, "currentMusicList": []]
                            ])
                        } else {
                            // reset current score
                            data[0].reference.updateData([
                                self.userSettings.selectedLevel : ["currentScore": 0, "currentLevel": 1, "highestScore": highestScore, "highestLevel": highestLevel, "currentMusicList": []]
                            ])
                        }
                        return
                    }
                    
                    self.player.highestScore = highestScore
                    // game exists in database
                    if !arr.isEmpty {
                        if self.player.currentMusicList.count <= arr.count {
                            self.player.currentScore = currentScore
                            self.player.currentLevel = currentLevel
                            self.player.currentMusicList = arr
                        }
                        data[0].reference.updateData([
                            self.userSettings.selectedLevel : ["currentScore": self.player.currentScore, "currentLevel": self.player.currentLevel, "highestScore": highestScore, "highestLevel": highestLevel, "currentMusicList": self.player.currentMusicList]
                        ])
                    } else {
                        // new game
                        data[0].reference.updateData([
                            self.userSettings.selectedLevel : ["currentScore": self.player.currentScore, "currentLevel": self.player.currentLevel, "highestScore": highestScore, "highestLevel": highestLevel, "currentMusicList": self.player.currentMusicList]
                        ])
                    }
                } else {
                    // when new level is added
                    data[0].reference.updateData([
                        self.userSettings.selectedLevel : ["currentScore": self.player.currentScore, "currentLevel": self.player.currentLevel, "highestScore": self.player.highestScore, "highestLevel": self.player.highestLevel, "currentMusicList": self.player.currentMusicList]
                    ])
                }
            }
        })
    }
    
}
