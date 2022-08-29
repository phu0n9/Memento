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

// MARK: show when player pause or lose
struct GameoverView: View {
    
    var score: Int
    
    @Binding var backToMenu: Bool
    
    @Binding var isReplay: Bool
    
    @Binding var isPause: Bool
    
    @ObservedObject var playerControl: PlayersControl
    
    @ObservedObject var gameControl: GameControl
    
    @ObservedObject var userSettings: UserSettings
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "flag.2.crossed.fill")
                .resizable()
                .frame(width: 70, height: 50, alignment: .top)
                .foregroundColor(Color.blue)
                .padding()
            
            Text(isPause ? "Game Paused": "Game over")
                .font(.custom("Bluenesia", size: 40))
            
            Text("Score \(score)")
                .font(.custom("Bluenesia", size: 20))
                .padding()
            
            if self.gameControl.isHighScore {
                Text("Congratulation! New record!")
                    .font(.custom("Bluenesia", size: 15))
                    .foregroundColor(Color.red)
                    .padding()
            }
            
            if isPause {
                Button("Resume") {
                    self.isPause.toggle()
                }
                .padding()
                .foregroundColor(.white)
                .font(.custom("Bluenesia", fixedSize: 25))
                .frame(width: 120, height: 60)
                .background(Color("DismissButton"))
                .cornerRadius(10)
                .padding()
            }
            
            NavigationButtonView(isTapped: isReplay, title: "Retry", gameControl: gameControl, destination: TransitionView(LoadingView(userSettings: userSettings)))
            
            NavigationButtonView(isTapped: backToMenu, title: "Menu", gameControl: gameControl, destination: TransitionView(MenuView()))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 500)
        .background(colorScheme == .dark ? Color.black.cornerRadius(20) : Color.white.cornerRadius(20))
        .shadow(radius: 5)
        .padding(.horizontal, 40)
    }
}
