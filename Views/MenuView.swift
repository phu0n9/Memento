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

struct MenuView: View {
    @State private var isInstruction: Bool? = false
    @State private var isLeaderboard: Bool? = false
    @State private var isGame: Bool? = false
    @State private var isNewGame: Bool? = false
    @State private var backGroundMusic: Bool = true
    @State private var soundEffect: Bool = true
    @State private var isLoaded: Bool = true
    @State private var isDismissed: Bool? = false
    
    @StateObject private var gameControl: GameControl
    @StateObject private var soundControl: SoundControl = SoundControl()
    @StateObject private var playerControl: PlayersControl
    @ObservedObject var userSettings: UserSettings = UserSettings()
    
    @Environment(\.colorScheme) private var colorScheme
    
    init() {
        let userSettings = UserSettings()
        let playerControl = PlayersControl(userSettings: userSettings)
        _playerControl = StateObject(wrappedValue: playerControl)
        _gameControl = StateObject(wrappedValue: GameControl(userSettings: userSettings))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if self.isLoaded {
                    ProgressView()
                        .frame(width: 200, height: 200, alignment: .center)
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    // MARK: Image Background
                    Image(colorScheme == .dark ? Settings.nightBackground : Settings.dayBackground)
                        .resizable()
                    
                    VStack {
                        
                        // MARK: Menu buttons
                        if !(self.gameControl.playerControl.player.currentMusicList.isEmpty) {
                            NavigationLink(destination: TransitionView(LoadingView(userSettings: userSettings)), isActive: Binding<Bool>($isNewGame)!) {
                                ButtonView(title: "NEW GAME", isClicked: $isNewGame, buttonColor: "NewGameButton")
                            }
                            .onChange(of: self.isNewGame!) { value in
                                if value {
                                    self.gameControl.restartGame()
                                }
                            }
                        }
                        
                        NavigationLink(destination: TransitionView(LoadingView(userSettings: userSettings)), isActive: Binding<Bool>($isGame)!) {
                            ButtonView(title: self.gameControl.playerControl.player.currentMusicList.isEmpty ? "PLAY" : "CONTINUE", isClicked: $isGame, buttonColor: "PlayButton")
                        }
                        ButtonView(title: "LEADERBOARD", isClicked: $isLeaderboard, buttonColor: "LeaderboardButton")
                        ButtonView(title: "INSTRUCTION", isClicked: $isInstruction, buttonColor: "InstructionButton")
                        ButtonView(title: "SETTINGS", isClicked: $isDismissed, buttonColor: "InfoButton")
                    }
                    
                    // MARK: Pop up control
                    .popup(isPresented: Binding<Bool>($isLeaderboard)!, type: .toast, position: .top, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
                        LeaderboardView(isPresented: $isLeaderboard)
                    }
                    .popup(isPresented: Binding<Bool>($isInstruction)!, type: .`default`, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
                        InstructionView(isPresented: $isInstruction)
                    }
                    .popup(isPresented: Binding<Bool>($isDismissed)!, type: .`default`, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
                        SettingsView(userSettings: userSettings, playerControl: playerControl, isPresented: $isDismissed)
                    }
                }
            }
            .onAppear {
                // MARK: show user settings if name not set
                guard self.userSettings.currentPlayer != "player" else {
                    self.isLoaded = false
                    self.isDismissed = true
                    return
                }
              
                let group = DispatchGroup()
                group.enter()
                
                // MARK: check if player exist or not
                DispatchQueue.global().async {
                    self.gameControl.playerControl.updatePlayer(hasLost: false)
                    group.leave()
                }
                
                group.wait()
                
                // MARK: play music background
                group.notify(queue: .main) {
                    if self.userSettings.backgroundMusic {
                        self.soundControl.playSound(soundName: colorScheme == .dark ? Settings.nightBackground : Settings.dayMusicBackground, fileType: "wav", num: -1)
                    } else {
                        self.soundControl.stopSound(soundName: colorScheme == .dark ? Settings.nightBackground : Settings.dayMusicBackground, fileType: "wav")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isLoaded = false
                    }
                }
            }
            // MARK: check background music is enabled
            .onChange(of: self.userSettings.backgroundMusic) { value in
                if value {
                    self.soundControl.playSound(soundName: colorScheme == .dark ? Settings.nightBackground : Settings.dayMusicBackground, fileType: "wav", num: -1)
                } else {
                    self.soundControl.stopSound(soundName: colorScheme == .dark ? Settings.nightBackground : Settings.dayMusicBackground, fileType: "wav")
                }
            }
            // MARK: check when player setting is changed
            .onChange(of: self.isDismissed) { value in
                if value != nil {
                    self.gameControl.resetState(userSettings: userSettings)
                    DispatchQueue.main.async {
                        self.gameControl.playerControl.updatePlayer(hasLost: false)
                    }
                    self.isLoaded = true
                }
            }
            // MARK: refresh rendering view
            .onChange(of: self.isLoaded) { value in
                if value {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isLoaded = false
                    }
                }
            }
            // MARK: stop all sound to move to new view
            .onDisappear {
                self.soundControl.stopSound(soundName: colorScheme == .dark ? Settings.nightBackground : Settings.dayMusicBackground, fileType: "wav")
            }
            // MARK: change background music if color mode changes
            .onChange(of: colorScheme) { value in
                if self.userSettings.backgroundMusic {
                    self.soundControl.stopSound(soundName: value == .dark ? Settings.dayMusicBackground : Settings.nightMusicBackground, fileType: "wav")
                    self.soundControl.playSound(soundName: value == .dark ? Settings.nightMusicBackground : Settings.dayMusicBackground, fileType: "wav", num: -1)
                }
            }
            .ignoresSafeArea()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView()
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
