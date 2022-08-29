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

// MARK: button render to new view when clicked
struct NavigationButtonView<Destination: View>: View {
    @State var isTapped: Bool
    @State var title: String
    
    var gameControl: GameControl
    
    var destination: Destination
    var body: some View {
        Button(title) {
            self.isTapped.toggle()
        }
        .padding()
        .foregroundColor(.white)
        .font(.custom("Bluenesia", fixedSize: 25))
        .frame(width: 120, height: 60)
        .background(Color("DismissButton"))
        .cornerRadius(10)
        .onChange(of: self.isTapped) { value in
            if value && title == "Retry" {
                self.gameControl.restartGame()
            }
        }
        NavigationLink("", destination: destination, isActive: $isTapped)
        
    }
}

struct NavigationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonView(isTapped: false, title: "Resume", gameControl: GameControl(userSettings: UserSettings()), destination: MenuView())
    }
}
