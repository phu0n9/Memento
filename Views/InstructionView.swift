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

// MARK: show instruction
struct InstructionView: View {
    @Binding var isPresented: Bool?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
                VStack(alignment: .center, spacing: 12) {
                    Text("How to play")
                        .font(.custom("Bluenesia", size: 45))
                        .padding()
                    Text(Settings.rules)
                        .font(.custom("Roboto", size: 20))
                        .padding([.horizontal], 20)
                    ButtonView(title: "Got it", isClicked: $isPresented, buttonColor: "DismissButton")
                        .padding([.leading, .trailing], 50)
                }
            }
            .frame(width: bounds.size.width > 768 ? bounds.size.width - 250 : bounds.size.width - 60, height: bounds.size.height > 1024 ? bounds.size.height / 3 : bounds.size.height / 1.9)
            .background(Color(UIColor.systemBackground))
            .padding([.leading, .trailing], bounds.size.width > 768 ? 125 : 30)
            .padding(.top, bounds.size.height > 1024 ? bounds.size.height / 3 : bounds.size.height / 4)
            .shadow(radius: 5)
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView(isPresented: Binding.constant(false)).previewDevice("iPhone 11").previewLayout(.sizeThatFits)
    }
}
