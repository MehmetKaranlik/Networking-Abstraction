//
//  ExampleModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation




import Foundation

   // MARK: - ExampleElement
struct ExampleElement: Codable {
   let postID, id: Int?
   let name, email, body: String?

   enum CodingKeys: String, CodingKey {
      case postID = "postId"
      case id, name, email, body
   }
}

typealias Example = [ExampleElement]
