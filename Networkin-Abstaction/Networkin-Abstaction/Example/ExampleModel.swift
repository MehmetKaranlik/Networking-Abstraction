//
//  ExampleModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation




import Foundation

   // MARK: - ExampleElement
struct LoginModel: Codable {
   let id: Int
   let name, surname, mail, password: String
   let active: Int
   let dateOfStart: String
      //    let usergroup, team, premium, logs: String
}
