//
//  DiscoView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 4/23/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

let colors: [Color] = [.red, .green, .black, .yellow, .pink, .blue]

struct DiscoView: View {
  @Binding var period: TimeInterval

  @State var color: Int = 0
  @State var timer: Timer? = nil

  var body: some View {
    Text("DISCO - period: \(String(period))")
      .foregroundColor(colors[color])
      .onAppear {
        self.timer = Timer.scheduledTimer(withTimeInterval: self.period, repeats: true) { _ in
          self.color = (self.color + 1) % colors.count
        }
    }
    .onDisappear {
      self.timer?.invalidate()
    }
  }
}

struct DiscoManager: View {
  @State var period: TimeInterval = 1

  var body: some View {
    VStack {
      DiscoView(period: self.$period)
      HStack {
        Button("Slower") {
          self.period *= 2
        }
        Button("Faster") {
          self.period /= 2
        }
      }
    }
  }
}
