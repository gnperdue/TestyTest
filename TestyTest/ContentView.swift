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
  let highScore = ExampleGameData().highScore
  
  var body: some View {
    
    GeometryReader { reader in
      
      ForEach(self.keys.indices[0..<self.keys.count-1]) { idx in
        Path { p in
          let xScaleFactor = reader.size.width / CGFloat(self.keys.count + 1)
          let yScaleFactor = reader.size.height / CGFloat(self.highScore * 1.1)
          let startPoint = CGPoint(
            x: CGFloat(idx + 1) * xScaleFactor,
            y: reader.size.height -
              CGFloat(self.scoreDict[self.keys[idx]]!) * yScaleFactor)
          let endPoint = CGPoint(
            x: CGFloat(idx + 2) * xScaleFactor,
            y: reader.size.height -
              CGFloat(self.scoreDict[self.keys[idx + 1]]!) * yScaleFactor)
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
