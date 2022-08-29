# Memento

<p align="center">
  <img width="250" src="https://github.com/phu0n9/Memento/blob/master/Screenshots/logo.png?raw=true">
</p>

## 📖 Description:

Memento is a unique and engaging interactive sound matching memory puzzle game. Computer will play first and players try to repeat the tiles. Try to remember as much as possible. Each round will give you 5 points. Game has 3 level: easy, medium and hard with respective of 60, 30 and 15 seconds. This cool sound game will challenge and sharpen your listening and memory skills.

## 👁️ 👄 👁️ Screenshot:

- Welcome View and Menu View
<table>
  <tr>
    <td>Light Mode</td>
     <td>Dark Mode</td>
     <td>Light Mode</td>
     <td>Dark Mode</td>
  </tr>
  <tr>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/welcome-light.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/welcome-dark.png?raw=true" width="200"></td>
     <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/menu-light.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/menu-dark.png?raw=true" width="200"></td>
  </tr>
</table>

- Continue View and Game View
<table>
  <tr>
    <td>Light Mode</td>
     <td>Dark Mode</td>
     <td>Light Mode</td>
     <td>Dark Mode</td>
  </tr>
  <tr>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/continue-light.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/continue-dark.png?raw=true" width="200"></td>
     <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/game-light.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/game-dark.png?raw=true" width="200"></td>
  </tr>
</table>

- Setting, Leaderboard, How to play, Pause View
<table>
  <tr>
    <td>Setting View</td>
     <td>Leaderboard View</td>
     <td>How to play View</td>
     <td>Pause View</td>
  </tr>
  <tr>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/settings.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/leaderboard.png?raw=true" width="200"></td>
     <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/howtoplay.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/pause-dark.png?raw=true" width="200"></td>
  </tr>
</table>

## 💅 Features:

- [x] Menu view:
      From this view, users can navigate these below views:
  - Game view
  - Leaderboard button.
  - How to play view
- [x] Leaderboard view:
      List of high scores (or past scores)
- [x] Game view:
  - The view where users can play with your game.
  - Show current score/status of the game.
  - User can take some actions to progress the game.
    Contains some animations during the game.
- [x] How to play view:
      Show user rules/how to play this game.
- [x] Background music for more than two views.
      Effect sounds when users at least:
  - Take action.
  - Winning with that action.
  - Losing with that action.
  - Result at the end (Ultimate win or lose).
- [x] User Interface (UIs) of your game should be fit in the screens for all iPhone >= 11, which are the devices I will test your game on.

- [x] Users can exit totally from the app during the game, when they open the app again, they can have an option to resume by click on “Continue” button on the menu view. (+5 points).

- [x] Users can register for different username before playing so the leaderboard will show different names for each score (+5 points).

- [x] The leaderboard shows different user achievement badges when you reach new milestones in the game (+5 points).

- [x] Add a setting menu for difficulty settings which actually modify the difficulty of the game (+5 points). This difficulty settings are supposed to make the game harder for users to challenge them.

- [ ] Instead of games based on pure random number generators, please create a simple AI game agent with some simple rules if-else or switch (rule-based decision) to play as an opponent to users (+10 points).

- [x] The app also works on iPads and MacOS (+5 points) `Only For Ipads`

- [x] UIs works well on the iPhone light mode and dark mode (+5 points)

## Diagram Flow:

<table>
  <tr>
    <td>Menu View</td>
     <td>Game View</td>
  </tr>
  <tr>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/menu%20view.png?raw=true" width="200"></td>
    <td><img src="https://github.com/phu0n9/Memento/blob/master/Screenshots/game%20view.png?raw=true" width="200"></td>
  </tr>
</table>

## 💥 Instalation:

- Pull this repository
- Reinstall two packages:
  - https://github.com/exyte/PopupView.git
  - https://github.com/firebase/firebase-ios-sdk.git
- Run again

## 🔧 Build Information

- Xcode 13.4.1
- SwiftUI Framework
- Target Deployment iOS >=15.5
