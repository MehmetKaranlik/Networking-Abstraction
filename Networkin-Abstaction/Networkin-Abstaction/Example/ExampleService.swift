//
//  ExampleService.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


struct ExampleService {
   let networkManager : NetworkManager

   func fetchExample() async -> Example?  {
      let result = try? await networkManager.send(
         networkPath: "https://jsonplaceholder.com/asda",
         parseModel: Example.self,
         requestType: RequestType.GET,
         queryParameters: nil, body: nil) {
         }
      return result?.data != nil ? result?.data : nil
   }
}
