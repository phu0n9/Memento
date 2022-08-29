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

// MARK: pause and timer view
struct PauseTopBarView: View {
    var timeRemaining: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(String(format: "%d", timeRemaining))
                .font(.custom("Bluenesia", size: 30))
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(colorScheme == .dark ? .white.opacity(0.75): .black.opacity(0.75))
                .clipShape(Capsule())
            
            Spacer()
            Image(systemName: "pause.rectangle.fill")
                .font(.system(size: 50.0))
                .foregroundColor(Color.red)
        }
        .padding([.leading, .trailing], 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
    }
}

struct PauseTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        PauseTopBarView(timeRemaining: 60).previewLayout(.sizeThatFits)
    }
}
