//
//  StateTestTopView.swift
//  TestyTest
//
//  Created by Gabriel Perdue on 4/19/20.
//  Copyright © 2020 Gabriel Perdue. All rights reserved.
//

import SwiftUI

struct Person { @Binding var name: String }
struct Character { @Binding var name: String }

struct StateTestTopView: View {
  @State private var name: String = "Bilbo"

  var body: some View {
    VStack {
      StateTestPickerView(name: $name)
      Spacer()
      Text("Global name selection is \(name)").font(.title)
    }
  }
}

struct StateTestPickerView: View {
  @Binding var name: String
  @State private var person: Person
  @State private var character: Character
  init(name: Binding<String>) {
    self._name = name
    self._person = State(initialValue: Person(name: name))
    self._character = State(initialValue: Character(name: name))
  }
  var body: some View {
    VStack{
      Picker(selection: $name,
             label: Text(verbatim: "Selected name: \(name)")) {
              ForEach(["Sam", "Gandalf", "Gollum"], id: \.self) { name in
                Text(name)
              }
      }
      Text("You picked \(name)")
      ShowPersonAndCharacter(
        person: self.$person, character: self.$character)
    }
  }
}

struct ShowPersonAndCharacter: View {
  @Binding var person: Person
  @Binding var character: Character

  var body: some View {
    Text("\(person.name) is great! \(character.name) is the same person!")
  }
}

struct StateTestTopView_Previews: PreviewProvider {
  static var previews: some View {
    StateTestTopView()
  }
}
