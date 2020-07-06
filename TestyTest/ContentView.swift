//
//  ContentView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 2/21/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI


struct ContentView: View {
  @State var timerMinutes = 0
  @State var timerSeconds = 10
  
  var minutes = [Int](0..<3)
  var seconds = [Int](0..<60)
  
  var body: some View {
    // does NavigationView wrap Geometry Reader or vice versa?
    GeometryReader { reader in
      NavigationView { // We have a Nav view up the hierarchy...
        VStack {
          HStack {
            Picker(selection: self.$timerMinutes, label: Text("")) {
              ForEach(0..<self.minutes.count) { index in
                Text("\(self.minutes[index]) m").tag(index)
              }
            }
            .frame(width: reader.size.width / 2, alignment: .center)
            Picker(selection: self.$timerSeconds, label: Text("")) {
              ForEach(0..<self.seconds.count) { index in
                Text("\(self.seconds[index]) s").tag(index)
              }
            }
            .frame(width: reader.size.width / 2, alignment: .center)
          }
          NavigationLink(destination: CountDownIntervalView()) {
            Text("Start the countdown!")
          }
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}

struct CountDownIntervalView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  let length: TimeInterval = 12
  let startingTime = Date()
  @State var currentDate = Date()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var interval: TimeInterval {
    return length - currentDate.timeIntervalSince(startingTime)
  }
  @State var color: Int = 0
  let colors: [Color] = [.black, .red]

  func format(duration: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.maximumUnitCount = 2
    return formatter.string(from: duration)!
  }

  var body: some View {
    VStack {
      Text("Time remaining:")
        .padding()
      Text("\(format(duration: interval))").onReceive(timer) { input in
        self.currentDate = input
        if self.interval <= 30 {
          self.color = (self.color + 1) % self.colors.count
        }
        if self.interval <= 0 {
          self.mode.wrappedValue.dismiss()
        }
      }
      .foregroundColor(colors[color])
      .padding()
      Button(action: {
        self.mode.wrappedValue.dismiss()
      }) {
        Text("Quit early!")
      }
      .padding()
    }
    .navigationBarBackButtonHidden(true)
  }
}

struct TimerIntervalView: View {
  let startingTime = Date()
  @State var currentDate = Date()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  // https://stackoverflow.com/questions/35999022/how-to-format-time-intervals-for-user-display-social-network-like-in-swift
  func format(duration: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.day, .hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    formatter.maximumUnitCount = 1

    return formatter.string(from: duration)!
  }


  var body: some View {
    Text("\(format(duration: currentDate.timeIntervalSince(startingTime)))").onReceive(timer) { input in
      self.currentDate = input
    }
  }

}

struct CountDownView: View {
  @State var timeRemaining = 10
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    Text("\(timeRemaining)").onReceive(timer) { _ in
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      }
    }
  }
}

struct ShowTheDateView: View {
  @State var currentDate = Date()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    Text("\(currentDate)").onReceive(timer) { input in
      self.currentDate = input
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
