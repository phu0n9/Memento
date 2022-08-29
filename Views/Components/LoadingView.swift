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

// MARK: transition view for waiting for complete API fetching
struct LoadingView: View {
    @State var isChange: Bool = false
    @ObservedObject var userSettings: UserSettings
    
    var playerControl: PlayersControl
        
    init(userSettings: UserSettings) {
        _userSettings = ObservedObject(wrappedValue: userSettings)
        self.playerControl = PlayersControl(userSettings: userSettings)
    }
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: GameView(gameControl: GameControl(userSettings: userSettings), playerControl: playerControl, userSettings: userSettings), isActive: $isChange) {
                ProgressView()
                    .frame(width: 200, height: 200, alignment: .center)
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isChange = true
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(userSettings: UserSettings())
    }
}
