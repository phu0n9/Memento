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

// MARK: set level, name and background music
struct SettingsView: View {
    
    @ObservedObject var userSettings: UserSettings
    @FocusState var nameFieldIsFocused: Bool
    @ObservedObject var playerControl : PlayersControl
    @Binding var isPresented: Bool?
    
    private let level = ["easy", "medium", "hard"]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Settings")
                .font(.custom("Bluenesia", size: 30))
                .padding()
            
            HStack {
                Text("Name: ")
                    .font(.custom("Roboto", size: 20))
                TextField("Enter your name", text: self.$userSettings.currentPlayer)
                    .focused($nameFieldIsFocused)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            if self.userSettings.currentPlayer == "" {
                Text("Please insert your name !")
                    .font(.custom("Bluenesia", size: 20))
                    .foregroundColor(Color.red)
            }
                        
            Toggle("Background music", isOn: self.$userSettings.backgroundMusic)
                .font(.custom("Roboto", size: 20))
                .font(Font.headline.weight(.bold))
                .toggleStyle(.switch)
                .padding()
            
            HStack {
                Text("Level")
                    .font(.custom("Roboto", size: 20))
                    .font(Font.headline.weight(.bold))
                Spacer()
                Picker("Level", selection: self.$userSettings.selectedLevel) {
                    ForEach(level, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding()
            
            ButtonView(title: "OK", isClicked: $isPresented, buttonColor: "DismissButton")
        }
        .padding()
        .frame(width: 350, height: 400)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(30.0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userSettings: UserSettings(), playerControl: PlayersControl(userSettings: UserSettings()), isPresented: Binding.constant(false)).previewLayout(.sizeThatFits)
    }
}
