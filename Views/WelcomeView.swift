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

// MARK: floating icon welcome
struct WelcomeView: View {
    
    @State var userSettings: UserSettings
    @State private var isActive = false
    @State private var yAxis :CGFloat = 0
    @State private var addThis: CGFloat = 50
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: TransitionView(MenuView()), isActive: $isActive) {
                ZStack {
                    Image(colorScheme == .dark ? "DarkBrandLogo" : "BrandLogo")
                        .resizable()
                        .frame(maxWidth: 500, maxHeight: 500)
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 0, y: yAxis)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                withAnimation(.easeInOut(duration: 2.0)) {
                                    self.addThis = -self.addThis
                                    self.yAxis += self.addThis
                                }
                            }
                        }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.async {
                PlayersControl(userSettings: userSettings).updatePlayer(hasLost: false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(userSettings: UserSettings())
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 Pro Max")
            .previewInterfaceOrientation(.portraitUpsideDown)
        WelcomeView(userSettings: UserSettings())
            .previewDevice("iPad Air (5th generation)")
            .previewInterfaceOrientation(.portrait)
    }
}
