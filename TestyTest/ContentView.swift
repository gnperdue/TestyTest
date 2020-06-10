//
//  ContentView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 2/21/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
//    DirectChartView()
    ScoresChartView()
  }
}


struct DirectChartView: View {
  let keys = ExampleGameData().scoreDict.keys.sorted()
  let scoreDict = ExampleGameData().scoreDict
  let highScore = 50
  let maxScoreDigits = 3
  let nYTicks = 10
  let nXTicks = 10  // TODO - distribute dates...
  
  // TODO -- need to think about scaling the x-axis to span the dates in the
  // set of scores, then marking ticks equally 10 times across that span, then
  // setting plot points proportionately across that span
  
  // how much horizontal space does each "day" in the set of scores take?
  // TODO -- adjust to actual date span instead of just list of days
  func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
    width / CGFloat(count)
  }
  
  // how much of the open vertical space does each score take?
  func scoreHeight(_ height: CGFloat, range: Int) -> CGFloat {
    height / CGFloat(range)
  }
  
  func dayOffset(_ day: Int, dWidth: CGFloat) -> CGFloat {
    CGFloat(day) * dWidth
  }
  
  func scorePosition(_ score: Double, scoreHeight: CGFloat) -> CGFloat {
    CGFloat(score + 1) * scoreHeight
  }
  
  func scoreLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
    height - self.scorePosition(
      Double(line * 10),
      scoreHeight: self.scoreHeight(height, range: self.highScore))
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
  
  // try to make this work for x and y-axes
  func tickLabelPos(
    dimension: CGFloat, padding: CGFloat, nTicks: Int, tick: Int
  ) -> CGFloat {
    let verticalSpan = dimension - padding
    let tickStep = verticalSpan / CGFloat(nTicks)
    let pos = dimension - padding / 2.0 - CGFloat(tick) * tickStep -
      tickStep / 3.5
    return pos
  }
  
  func tickLabel(highScore: Int, nTicks: Int, tick: Int) -> String {
    let marker: Double = Double(highScore) -
      Double(nTicks - tick) * Double(highScore) / Double(nTicks)
    let label = String(format: "%.0f", marker)
    // wherefore art thou, o' built-in String padding functions?...
    return String(
      repeating: " ", count: self.maxScoreDigits - label.count) + label
  }
  
  // TODO - how to make these a fraction of the screen size?
  // total vertical padding (bottom + top)
  let verticalPadding: CGFloat = 100.0
  // total horizontal padding (leading + trailing)
  let horizontalPadding: CGFloat = 80.0
  
  var body: some View {
    
    GeometryReader<AnyView> { reader in
      
      let bottomLeadingCorner = CGPoint(
        x: self.horizontalPadding / 2.0,
        y: reader.size.height - self.verticalPadding / 2.0)
      let bottomTrailingCorner = CGPoint(
        x: reader.size.width - self.horizontalPadding / 2.0,
        y: reader.size.height - self.verticalPadding / 2.0)
      let topLeadingCorner = CGPoint(
        x: self.horizontalPadding / 2.0,
        y: self.verticalPadding / 2.0)
      let topTrailingCorner = CGPoint(
        x: reader.size.width - self.horizontalPadding / 2.0,
        y: self.verticalPadding / 2.0)
      
      return AnyView(
        Group {
          // x-axis, bottom bar
          Path { p in
            p.move(to: bottomLeadingCorner)
            p.addLine(to: bottomTrailingCorner)
          }
          .stroke(Color.black, lineWidth: 5.0)
          // x-axis, top bar
          Path { p in
            p.move(to: topLeadingCorner)
            p.addLine(to: topTrailingCorner)
          }
          .stroke(Color.gray, lineWidth: 0.5)
          // y-axis, leading bar
          Path { p in
            p.move(to: bottomLeadingCorner)
            p.addLine(to: topLeadingCorner)
          }
          .stroke(Color.black, lineWidth: 5.0)
          // y-axis, trailing bar
          Path { p in
            p.move(to: bottomTrailingCorner)
            p.addLine(to: topTrailingCorner)
          }
          .stroke(Color.gray, lineWidth: 0.5)
          
          // Draw y-axis tick marks
          ForEach(0..<self.nYTicks) { tick in
            Group {
              Path { p in
                let yPos = self.tickPos(dimension: reader.size.height,
                                        padding: self.verticalPadding,
                                        nTicks: self.nYTicks,
                                        tick: tick)
                let tickStart = CGPoint(
                  x: self.horizontalPadding / 2.0 - self.horizontalPadding / 4.0,
                  y: yPos)
                let tickStop = CGPoint(
                  x: self.horizontalPadding / 2.0,
                  y: yPos)
                p.move(to: tickStart)
                p.addLine(to: tickStop)
              }
              .stroke(Color.black, lineWidth: 5.0)
              Text("\(self.tickLabel(highScore: self.highScore, nTicks: self.nYTicks, tick: tick))")
                .offset(x: self.horizontalPadding / 10.0,
                        y: self.tickLabelPos(dimension: reader.size.height,
                                             padding: self.verticalPadding,
                                             nTicks: self.nYTicks,
                                             tick: tick))
            }
          }
          
          // Draw x-axis tick marks
          ForEach(0..<self.nXTicks) { tick in
            Group {
              Path { p in
                let xPos = self.tickPos(dimension: reader.size.width,
                                        padding: self.horizontalPadding,
                                        nTicks: self.nXTicks,
                                        tick: tick)
                let tickStart = CGPoint(
                  x: xPos,
                  y: reader.size.height - self.verticalPadding / 2.0 +
                    self.verticalPadding / 4.0)
                let tickStop = CGPoint(
                  x: xPos,
                  y: reader.size.height - self.verticalPadding / 2.0)
                p.move(to: tickStart)
                p.addLine(to: tickStop)
              }
              .stroke(Color.black, lineWidth: 5.0)
            }
          }
          
          // Draw the scores
          ForEach(self.keys.indices[0..<self.keys.count-1]) { idx in
            Path { p in
              let dWidth = self.dayWidth(
                reader.size.width - self.horizontalPadding,
                count: self.keys.count + 1)
              let sHeight = self.scoreHeight(
                reader.size.height - self.verticalPadding, range: self.highScore)
              let dStart = self.dayOffset(idx + 1, dWidth: dWidth)
              let dStop = self.dayOffset(idx + 2, dWidth: dWidth)
              let scoreStart = self.scorePosition(
                self.scoreDict[self.keys[idx]]!, scoreHeight: sHeight)
              let scoreStop = self.scorePosition(
                self.scoreDict[self.keys[idx + 1]]!, scoreHeight: sHeight)
              let startPoint = CGPoint(
                x: dStart,
                y: reader.size.height - self.verticalPadding / 2.0 - scoreStart)
              let endPoint = CGPoint(
                x: dStop,
                y: reader.size.height - self.verticalPadding / 2.0 - scoreStop)
              p.move(to: startPoint)
              p.addLine(to: endPoint)
            }
            .stroke()
          }
          
        }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
