//
//  ContentView.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import SwiftUI

struct ContentView: View {
   @StateObject var viewModel = ExampleViewModel()
    var body: some View {
        VStack {
           Text("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
