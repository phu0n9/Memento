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

// MARK: show current score and level
struct ScoreView: View {
    var score: Int
    var level: Int
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("Score: \(self.score)")
                .font(.custom("Bluenesia", size: 30))
            Spacer()
            Text("Level: \(self.level)")
                .font(.custom("Bluenesia", size: 30))
        }
        .padding([.leading, .trailing], 20)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 30, level: 1).previewLayout(.sizeThatFits)
    }
}
