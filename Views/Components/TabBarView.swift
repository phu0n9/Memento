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

// MARK: horizontal tab bar view
struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace

    var tabBarOptions: [String] = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { bounds in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 40) {
                        ForEach(Array(zip(self.tabBarOptions.indices,
                                          self.tabBarOptions)),
                                id: \.0,
                                content: { index, name in
                            TabBarItem(currentTab: self.$currentTab,
                                       namespace: namespace.self,
                                       tabBarItemName: name,
                                       tab: index)
                            .padding([.leading, .trailing], bounds.size.width > 712 ? bounds.size.width / 8 : bounds.size.width / 12)
                        })
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .background(Color(UIColor.systemBackground))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(currentTab: Binding.constant(0))
            .previewDevice("iPad Air (5th generation)")
    }
}
