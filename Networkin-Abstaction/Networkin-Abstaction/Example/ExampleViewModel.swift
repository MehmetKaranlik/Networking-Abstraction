//
//  ExampleViewModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


class ExampleViewModel : ExampleBaseViewModel, ObservableObject {

   let service = ExampleService(networkManager: networkManager)

   var example : Example? = nil {
      didSet {
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
            example = result
         }
      }
   }

}
