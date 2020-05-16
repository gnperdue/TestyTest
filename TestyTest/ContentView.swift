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
    NavigationView { // We have a Nav view up the hierarchy...
      NavigationLink(destination: CountDownIntervalView()) {
        Text("Start the countdown!")
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
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
        if self.interval <= 0 {
          self.mode.wrappedValue.dismiss()
        }
      }
      .foregroundColor(self.interval > 10 ? Color.black : Color.red)
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
