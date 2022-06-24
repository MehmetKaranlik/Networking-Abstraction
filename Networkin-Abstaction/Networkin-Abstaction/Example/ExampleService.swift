//
//  ExampleService.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


struct ExampleService {
   let networkManager : NetworkManager = NetworkManager()

   func fetchExample() async -> LoginModel?  {
      let result = try? await networkManager.send(
         networkPath: "https://jsonplaceholder.typicode.com/comments",
         parseModel: LoginModel.self,
         requestType: .POST,
         body: nil, bodyType: .JSON, queryParameters: nil)

      print("Result : \(result)")
      return result?.data != nil ? result?.data : nil
   }
}
