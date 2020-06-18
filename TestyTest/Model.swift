//
//  Model.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 5/26/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import Foundation

struct GameData {
  let date: Date
  let score: Double
}

class ExampleGameData {
  let fmt: DateFormatter
  init() {
    fmt = DateFormatter()
    fmt.dateFormat = "yyyy/MM/dd HH:mm"
  }
  
  var games: [GameData] {
    return [
      GameData(date: self.fmt.date(from: "2020/05/01 09:30")!, score: 13.0),
      GameData(date: self.fmt.date(from: "2020/05/10 14:45")!, score: 42.0),
      GameData(date: self.fmt.date(from: "2020/05/03 12:20")!, score: 22.0),
      GameData(date: self.fmt.date(from: "2020/05/03 13:20")!, score: 35.0),
      GameData(date: self.fmt.date(from: "2020/05/01 08:30")!, score: 15.0),
      GameData(date: self.fmt.date(from: "2020/05/03 11:20")!, score: 7.0),
    ]
  }
  
  var highScore: Double {
    var highScore: Double = 0.0
    for game in self.games {
      if game.score > highScore {
        highScore = game.score
      }
    }
    return highScore
  }
}
