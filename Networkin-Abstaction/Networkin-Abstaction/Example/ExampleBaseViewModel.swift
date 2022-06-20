//
//  ExampleBaseViewModel.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


class ExampleBaseViewModel {
  static let networkingOptions = NetworkingOptions(accessToken: "where is your acces token", refreshToken: "where is your refresh token")
  static let networkManager = NetworkManager(networkingOptions: networkingOptions)
}
