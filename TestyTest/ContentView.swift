//
//  ContentView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 2/21/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI


struct ContentView: View {
  let keys = ExampleGameData().scoreDict.keys.sorted()
  let scoreDict = ExampleGameData().scoreDict
  let highScore = 50

  // how much horizontal space does each "day" in the set of scores take?
  // TODO -- adjust to actual date span instead of just list of days
  func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
    width / CGFloat(count)
  }

  // how much vertical space does each score take?
  func scoreHeight(_ height: CGFloat, range: Int) -> CGFloat {
    height / CGFloat(range)
  }
  
  func dayOffset(_ day: Int, dWidth: CGFloat) -> CGFloat {
    CGFloat(day) * dWidth
  }

  func scoreOffset(_ score: Double, scoreHeight: CGFloat) -> CGFloat {
    CGFloat(score + 1) * scoreHeight
  }
  
  func scoreLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
    height - self.scoreOffset(
      Double(line * 10),
      scoreHeight: self.scoreHeight(height, range: self.highScore))
  }
  
  var body: some View {
    
    GeometryReader { reader in

      ForEach(self.keys.indices[0..<self.keys.count-1]) { idx in
        Path { p in
          let dWidth = self.dayWidth(reader.size.width,
                                     count: self.keys.count + 1)
          let sHeight = self.scoreHeight(reader.size.height,
                                         range: self.highScore)
          let dStart = self.dayOffset(idx + 1, dWidth: dWidth)
          let dStop = self.dayOffset(idx + 2, dWidth: dWidth)
          let scoreStart = self.scoreOffset(self.scoreDict[self.keys[idx]]!,
                                            scoreHeight: sHeight)
          let scoreStop = self.scoreOffset(self.scoreDict[self.keys[idx + 1]]!,
                                           scoreHeight: sHeight)
          let startPoint = CGPoint(x: dStart,
                                   y: reader.size.height - scoreStart)
          let endPoint = CGPoint(x: dStop,
                                 y: reader.size.height - scoreStop)
          p.move(to: startPoint)
          p.addLine(to: endPoint)
        }
        .stroke()
      }

    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
