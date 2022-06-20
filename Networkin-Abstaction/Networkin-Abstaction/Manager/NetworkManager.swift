//
//  NetworkManager.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation

enum RequestType: String, CaseIterable {
   case GET
   case PUT
   case DELETE
   case POST
}

class NetworkManager: INetworkManager {
   var networkingOptions: NetworkingOptions

   init(networkingOptions: NetworkingOptions) {
      self.networkingOptions = networkingOptions
   }

   func send<T: Codable>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      queryParameters: [String: String]? = nil,
      body: [String: String]? = nil,
      onFail: @escaping () -> ()
   ) async throws -> BaseResponseModel<T> {
      guard var url = URL(string: networkPath) else { return BaseResponseModel(response: nil, data: nil) }

      queryGenerator(url: &url, queryParameters: queryParameters)

      var request = URLRequest(url: url, timeoutInterval: 15)

      bodyGenerator(request: &request, data: body)

      headerGenerator(request: &request)

      let (data, response): (Data?, URLResponse?) = await handleRequest(urlRequest: request) ?? (nil, nil)

      guard data != nil, let response = response as? HTTPURLResponse else { return BaseResponseModel(response: nil, data: nil) }

      if response.statusCode > 199, response.statusCode < 300 {
         networkingOptions.resetRetryCount()
         let decodedData = decodeData(model: parseModel.self, data: data!)
         return BaseResponseModel(response: response, data: decodedData)

      } else {
         await handleRetry()
      }
      // retry on unsuccessfull statusCode
      func handleRetry() async {
         if networkingOptions.isEligibleToRetry {
            let newToken: String? = await refreshToken()

            if newToken != nil {
               networkingOptions.updateAccesToken(newToken!)

               try? await send(
                  networkPath: networkPath, parseModel: parseModel,
                  requestType: requestType, queryParameters: queryParameters, body: body
               ) { self.networkingOptions.increaseRetryCount() }

            } else { onFail() }

         } else { onFail() }
      }
      return BaseResponseModel(response: nil, data: nil)
   }
}

struct NetworkingOptions {
   // MARK: properties

   let retryCount = 3
   var currentCount = 0
   var accessToken: String
   var refreshToken: String
   var accessTokenURL: String {
      "https://xxxxxx.xxx/refresh/\(refreshToken)"
   }

   var isEligibleToRetry: Bool {
      currentCount <= retryCount
   }

   // MARK: functions

   mutating func increaseRetryCount() {
      currentCount += 1
   }

   mutating func updateAccesToken(_ newToken: String) {
      accessToken = newToken
   }

   mutating func resetRetryCount() {
      currentCount = 0
   }
}
