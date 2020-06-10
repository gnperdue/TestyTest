//
//  ScoresChartView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 6/10/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

struct ScoresChartView: View {
  var body: some View {
    Text("Mellow, whirled...")
  }
  
  func drawXAxis(with reader: GeometryProxy) -> some View {
    let verticalPaddingFraction: CGFloat = 0.05
    let horizontalPaddingFraction: CGFloat = 0.05

    let bottomLeadingCorner = CGPoint(
        x: reader.size.width * horizontalPaddingFraction,
        y: reader.size.height * (1 - verticalPaddingFraction))
    let bottomTrailingCorner = CGPoint(
        x: reader.size.width * (1 - horizontalPaddingFraction),
        y: reader.size.height * (1 - verticalPaddingFraction))
    let topLeadingCorner = CGPoint(
        x: reader.size.width * horizontalPaddingFraction,
        y: reader.size.height * verticalPaddingFraction)

    return Group {
        Path { p in
            p.move(to: bottomLeadingCorner)
            p.addLine(to: bottomTrailingCorner)
        }.stroke(Color.black, lineWidth: 5.0)
        Path { p in
            p.move(to: bottomLeadingCorner)
            p.addLine(to: topLeadingCorner)
        }.stroke(Color.black, lineWidth: 5.0)
        Path { p in
            p.move(to: topLeadingCorner)
            p.addLine(to: bottomTrailingCorner)
        }.stroke(Color.black, lineWidth: 5.0)
    }
  }
}

struct ScoresChartView_Previews: PreviewProvider {
  static var previews: some View {
    ScoresChartView()
  }
}
