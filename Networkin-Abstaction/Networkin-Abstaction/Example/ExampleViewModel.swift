//
//  ExampleViewModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


class ExampleViewModel : ExampleBaseViewModel, ObservableObject {

   let service = ExampleService(networkManager: networkManager)

 @Published  var example : Example? = [] {
      didSet{
         print("example did set")
      }
   }


   override init() {
      super.init()
      self.fetchExample()
   }




   func fetchExample()  {
      Task {
         let result = await service.fetchExample()
         if result != nil {
            DispatchQueue.main.async {
               self.example = result
            }
         }
      }
   }

}
