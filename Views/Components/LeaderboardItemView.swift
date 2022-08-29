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

// MARK: leaderboard sort by level
struct LeaderboardItemView: View {
    
    @ObservedObject var playerControl: PlayersControl
    @Environment(\.colorScheme) var colorScheme
    @State var selectedLevel : Int
    let levelOptions = [0: "easy", 1: "medium", 2: "hard"]
    
    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .center) {
                Text("🏆 Leaderboard")
                    .font(.custom("Bluenesia", size: 30))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .padding()
                ScrollView {
                    VStack {
                        ForEach(Array(self.playerControl.playerResults.enumerated()), id: \.1.id) { index, player in
                            if player.highestScore != 0 {
                                HStack {
                                    Text(index == 0 ? "🥇 \(player.playerName)" : index == 1 ? "🥈 \(player.playerName)" : index == 2 ? "🥉 \(player.playerName)" : "\(player.playerName)")
                                        .font(.custom("Roboto", size: 20))
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    
                                    Spacer()
                                    Text(String(format: "%d", player.highestScore))
                                        .font(.custom("Roboto", size: 20))
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                Divider()
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: (bounds.size.height - bounds.safeAreaInsets.top - bounds.safeAreaInsets.bottom) / 3)
            .background(Color(UIColor.systemBackground))
            .onAppear {
                DispatchQueue.main.async {
                    self.playerControl.selectedLevel = self.levelOptions[selectedLevel] ?? "easy"
                    self.playerControl.fetchData()
                }
        }
        }
    }
}

struct LeaderboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemView(playerControl: PlayersControl(userSettings: UserSettings()), selectedLevel: 0)
    }
}
