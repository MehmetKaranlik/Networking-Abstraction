//
//  RefreshTokenModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


struct RefreshTokenResponse : Codable {
   let message : String
   let statusCode : Int
   let accesToken : String
}
