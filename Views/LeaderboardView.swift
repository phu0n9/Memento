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

// MARK: show leaderboard by level
struct LeaderboardView: View {
    
    @StateObject var playerControl: PlayersControl = PlayersControl(userSettings: UserSettings())
    @Environment(\.colorScheme) var colorScheme

    @State var currentTab: Int = 0
    @Binding var isPresented: Bool?
        
    let levelData = [0: "easy", 1: "medium", 2: "hard"]
    
    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Text("X")
                        .font(.custom("Bluenesia", size: 20))
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .background(colorScheme == .dark ? .white.opacity(0.75): .black.opacity(0.75))
                        .clipShape(Capsule())
                        .padding([.trailing, .top], 20)
                        .onTapGesture {
                            self.isPresented?.toggle()
                        }
                }
                
                TabBarView(currentTab: self.$currentTab)
                TabView(selection: self.$currentTab) {
                    LeaderboardItemView(playerControl: playerControl, selectedLevel: currentTab).tag(0)
                    LeaderboardItemView(playerControl: playerControl, selectedLevel: currentTab).tag(1)
                    LeaderboardItemView(playerControl: playerControl, selectedLevel: currentTab).tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .frame(width: bounds.size.width)
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(isPresented: Binding.constant(false))
            .previewDevice("iPhone 11")
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
