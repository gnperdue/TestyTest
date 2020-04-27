//
//  NavTestMaster.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 2/21/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

struct NavTestMaster: View {
  var body: some View {
    NavigationView {
      NavigationLink(destination: NavTestView()) {
        Text("Mellow, whirled")
      }
    }
  }
}

struct NavTestMaster_Previews: PreviewProvider {
  static var previews: some View {
    NavTestMaster()
  }
}
