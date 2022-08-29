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

// MARK: music tile
struct ItemView: View {
    var shapeColor: String
    var gameControl: GameControl
    var key: String
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        Image(shapeColor)
            .resizable()
            .frame(width: width, height: height)
            .onTapGesture {
                self.gameControl.soundButtonOnPressed(key: key)
            }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(shapeColor: "blue", gameControl: GameControl(userSettings: UserSettings()), key: "2", width: 200, height: 200)
        .previewDevice("iPad Air (5th generation)")
        
    }
}
