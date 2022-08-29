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

// MARK: notification view to alert player
struct NotiView: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.custom("Bluenesia", size: 30))
        }
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .padding([.top, .bottom], 20)
        .border(Color.gray, width: 3)
        .shadow(radius: 10)
        .background(Color(UIColor.systemBackground))
    }
}

struct NotiView_Previews: PreviewProvider {
    static var previews: some View {
        NotiView(title: "✅ Correct").previewLayout(.sizeThatFits)
    }
}
