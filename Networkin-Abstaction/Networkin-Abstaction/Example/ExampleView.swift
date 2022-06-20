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
           List {
              ForEach(viewModel.example!.indices,id:\.self) { index in
                 Text(viewModel.example![index].name ?? "")
              }
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
