//
//  ContentView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 2/21/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI


struct ContentView: View {
  let xs: [CGFloat] = [1.0, 2.0, 3.0]
  let ys: [CGFloat] = [1.0, 2.0, 3.0]
  
  var body: some View {
    GeometryReader { reader in
      ForEach(0..<3) { idx in
        Path { p in
          let xScaleFactor = reader.size.width / 10.0
          let yScaleFactor = reader.size.height / 10.0
          p.move(to: CGPoint(x: self.xs[idx] * xScaleFactor,
                             y: self.ys[idx] * yScaleFactor))
          p.addLine(to: CGPoint(x: (self.xs[idx] + 0.5) * xScaleFactor,
                                y: self.ys[idx] * yScaleFactor))
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
