//
//  ContentView.swift
//  Pick-A-Pal
//
//  Created by Joon on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    @State private var nameList: [String] = ["Asher", "Tom", "Jude", "Kevin"]
    @State private var nameToAdd = ""
    @State private var pickedName = ""


    var body: some View {
        VStack {
            Text(pickedName.isEmpty ? " " : pickedName)
            List {
                ForEach(nameList, id: \.description) { name in
                    Text(name)
                }
            }
            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty {
                        nameList.append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            Divider()
            Button("Pick Random Name") {
                            if let randomName = nameList.randomElement() {
                                pickedName = randomName
                            } else {
                                pickedName = ""
                            }
                        }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
