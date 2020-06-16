//
//  ScoresChartView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 6/10/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

struct ScoresChartView: View {
  let verticalPaddingFraction: CGFloat = 0.05
  let horizontalPaddingFraction: CGFloat = 0.05
  let highScore = 50
  let maxScoreDigits = 3
  let nYTicks = 10
  let nXTicks = 10  // TODO - distribute dates...
  let tickWidth: CGFloat = 5.0

  var body: some View {
    ZStack {
      GeometryReader(content: drawChart(with:))
    }
  }
  
  func drawChart(with reader: GeometryProxy) -> some View {
    let bottomLeading = bottomLeadingCorner(with: reader)
    let bottomTrailing = bottomTrailingCorner(with: reader)
    let topLeading = topLeadingCorner(with: reader)
    let topTrailing = topTrailingCorner(with: reader)

    return Group {
      Path { p in
        p.addLines([topLeading, topTrailing, bottomTrailing])
      }
      .stroke(Color.gray, lineWidth: 5.0)
      Path { p in
        p.addLines([topLeading, bottomLeading, bottomTrailing])
      }
      .stroke(Color.black, style: StrokeStyle(lineWidth: 5.0, lineCap: .square))

      // y-axis ticks and labels
      drawYAxisTicksAndLabels(with: reader)
      
      // x-axis ticks and labels
      drawXAxisTicksAndLabels(with: reader)
    }
  }

  func bottomLeadingCorner(with reader: GeometryProxy) -> CGPoint {
    return CGPoint(
      x: reader.size.width * horizontalPaddingFraction,
      y: reader.size.height * (1 - verticalPaddingFraction))
  }
  
  func bottomTrailingCorner(with reader: GeometryProxy) -> CGPoint {
    return CGPoint(
      x: reader.size.width * (1 - horizontalPaddingFraction),
      y: reader.size.height * (1 - verticalPaddingFraction))
  }
  
  func topLeadingCorner(with reader: GeometryProxy) -> CGPoint {
    return CGPoint(
      x: reader.size.width * horizontalPaddingFraction,
      y: reader.size.height * verticalPaddingFraction)
  }

  func topTrailingCorner(with reader: GeometryProxy) -> CGPoint {
    return CGPoint(
      x: reader.size.width * (1 - horizontalPaddingFraction),
      y: reader.size.height * verticalPaddingFraction)
  }

  // try to make this work for x and y-axes
  func tickPos(
    dimension: CGFloat, padding: CGFloat, nTicks: Int, tick: Int
  ) -> CGFloat {
    let verticalSpan = dimension - padding
    let tickStep = verticalSpan / CGFloat(nTicks)
    let pos = dimension - padding / 2.0 - CGFloat(tick) * tickStep
    return pos
  }

  func tickYLabel(highScore: Int, nTicks: Int, tick: Int) -> String {
    let marker: Double = Double(highScore) -
      Double(nTicks - tick) * Double(highScore) / Double(nTicks)
    let label = String(format: "%.0f", marker)
    // wherefore art thou, o' built-in String padding functions?...
    return String(
      repeating: " ", count: self.maxScoreDigits - label.count) + label
  }

  func drawYAxisTicksAndLabels(with reader: GeometryProxy) -> some View {
    ForEach(0..<self.nYTicks) { tick in
      Group {
        Path { p in
          let yPos = self.tickPos(
            dimension: reader.size.height,
            padding: self.verticalPaddingFraction * 2 * reader.size.height,
            nTicks: self.nYTicks,
            tick: tick)
          let tickStart = CGPoint(
            x: self.horizontalPaddingFraction * reader.size.width / 4.0,
            y: yPos)
          let tickStop = CGPoint(
            x: self.horizontalPaddingFraction * reader.size.width,
            y: yPos)
          p.move(to: tickStart)
          p.addLine(to: tickStop)
        }
        .stroke(Color.black, lineWidth: self.tickWidth)
        Text("\(self.tickYLabel(highScore: self.highScore, nTicks: self.nYTicks, tick: tick))")
          .offset(
            x: self.tickWidth / 4.0,
            y: self.tickPos(
              dimension: reader.size.height,
              padding: self.verticalPaddingFraction * 2 * reader.size.height,
              nTicks: self.nYTicks,
              tick: tick) + self.tickWidth / 2.0)
      }
    }
  }

  // TODO - write out plan for handling dates...
  func drawXAxisTicksAndLabels(with reader: GeometryProxy) -> some View {
    ForEach(0..<self.nXTicks) { tick in
      Group {
        Path { p in
          let xPos = self.tickPos(
            dimension: reader.size.width,
            padding: self.horizontalPaddingFraction * 2,
            nTicks: self.nXTicks,
            tick: tick)
          let tickStart = CGPoint(
            x: xPos,
            y: reader.size.height -
              self.verticalPaddingFraction * reader.size.height / 4.0)
          let tickStop = CGPoint(
            x: xPos,
            y: reader.size.height -
              self.verticalPaddingFraction * reader.size.height)
          p.move(to: tickStart)
          p.addLine(to: tickStop)
        }
        .stroke(Color.black, lineWidth: self.tickWidth)
      }
    }
  }
}


struct ScoresChartView_Previews: PreviewProvider {
  static var previews: some View {
    ScoresChartView()
  }
}
