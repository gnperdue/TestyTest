//
//  CombineTestView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 4/22/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI
import Combine

class GameData: ObservableObject {
  @Published var maxValue: Int {
    didSet { print("updated maxValue in GameData") }
  }
  @Published var player: String
  init(maxValue: Int, player: String) {
    self.maxValue = maxValue
    self.player = player
  }
}

class ProblemSpace: ObservableObject {
  var gameData: GameData
  init(gameData: GameData) {
    self.gameData = gameData
  }

  var maxValue: Int {
    set { self.gameData.maxValue = newValue }
    get { return self.gameData.maxValue }
  }

  var player: String {
    set { self.gameData.player = newValue }
    get { return self.gameData.player }
  }
}

class StatsManager: ObservableObject {
  var gameData: GameData
  init(gameData: GameData) {
    self.gameData = gameData
  }

  var maxValue: Int {
    set { self.gameData.maxValue = newValue }
    get { return self.gameData.maxValue }
  }

  var player: String {
    set { self.gameData.player = newValue }
    get { return self.gameData.player }
  }
}


struct CombineTestView: View {
  @EnvironmentObject var gameData: GameData
  @ObservedObject var problemSpace: ProblemSpace
  @ObservedObject var statsManager: StatsManager

  var body: some View {
    VStack {
      CombineTestPickerView(problemSpace: problemSpace,
                            statsManager: statsManager)
        .environmentObject(gameData)
      Spacer()
      Text("GameData Player is: \(gameData.player), Max is \(gameData.maxValue)")
        .font(.system(.title))
    }
  }
}

struct CombineTestPickerView: View {
  @EnvironmentObject var gameData: GameData
  @ObservedObject var problemSpace: ProblemSpace
  @ObservedObject var statsManager: StatsManager

  var body: some View {
    VStack{
      Picker(selection: $problemSpace.player,
             label: Text(verbatim: "Selected name: \(problemSpace.player)")) {
              ForEach(["Sam", "Gandalf", "Gollum"], id: \.self) { name in
                Text(name)
              }
      }
      Text("Picker ProblemSpace Player: \(problemSpace.player), Max: \(problemSpace.maxValue)")
      ShowStatsManager(statsManager: statsManager)
    }
  }
}

struct ShowStatsManager: View {
  // Note, the @EnvironmentObject is identified by _class_ in the hierarchy,
  // so we don't need to keep the same name...
  @EnvironmentObject var gd: GameData
  @ObservedObject var statsManager: StatsManager

  var body: some View {
    VStack {
      Stepper("Set max: ", value: $statsManager.maxValue)
      Text("ShowStatsManager Player: \(statsManager.player), Max: \(statsManager.maxValue)")
      Text("ShowStatsManager Env GameData: \(gd.player), \(gd.maxValue)")
    }
  }
}


struct CombineTestView_Previews: PreviewProvider {
  static var previews: some View {
    CombineTestView(
      problemSpace: ProblemSpace(
        gameData: GameData(maxValue: 10, player: "Player 1")),
      statsManager: StatsManager(
        gameData: GameData(maxValue: 10, player: "Player 1"))
    )
  }
}
