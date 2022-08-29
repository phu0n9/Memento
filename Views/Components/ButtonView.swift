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

// MARK: common button style
struct ButtonView: View {
    var title: String
    
    @Binding var isClicked: Bool?
    @StateObject private var soundControl: SoundControl = SoundControl()
    
    var buttonColor: String
    
    init(title: String, isClicked: Binding<Bool?> = .constant(nil), buttonColor: String) {
        self.title = title
        self._isClicked = isClicked
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        Button(self.title) {
            self.isClicked?.toggle()
        }
        .padding()
        .foregroundColor(.white)
        .font(.custom("Bluenesia", fixedSize: 30))
        .frame(width: 200, height: 50)
        .background(Color(buttonColor))
        .clipShape(Capsule())
        .padding(.top)
        .shadow(radius: 20)
    }
}
