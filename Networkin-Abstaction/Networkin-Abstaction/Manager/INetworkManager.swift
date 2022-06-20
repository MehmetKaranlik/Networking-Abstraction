//
//  INetworkManager.swift
//  Networkin-Abstaction
//
//  Created by mehmet karanlık on 20.06.2022.
//

import Foundation


struct BaseResponseModel<T:Codable>  {
   let response : URLResponse?
   let data : T?
}


protocol INetworkManager {

   var networkingOptions : NetworkingOptions { get set }

   func send<T: Codable>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      queryParameters: [String: String]?,
      body: [String: String]?,
      onFail: @escaping () -> ()
   ) async throws -> BaseResponseModel<T>

   func bodyGenerator(request : inout URLRequest, data :[String: String ]?)
   func headerGenerator(request : inout URLRequest)
   func queryGenerator(url : inout URL, queryParameters : [String: String]?)
   func handleRequest(urlRequest : URLRequest) async -> (Data,URLResponse)?
   func refreshToken() async -> String?
}



extension INetworkManager {

   func queryGenerator(url : inout URL, queryParameters : [String: String]?) {
      guard queryParameters != nil else { return }
      var queries = [URLQueryItem]()
      queryParameters!.forEach {
         queries.append(URLQueryItem(name: $0, value: $1))
      }
      url.append(queryItems: queries)
      print(url)
   }

   func headerGenerator(request : inout URLRequest) {
      request.allHTTPHeaderFields = [
         "Authorization" : "Bearer \(networkingOptions.accessToken)",
         "Content-Type": "application/json"
      ]
   }

   func bodyGenerator(request : inout URLRequest, data :[String: String ]? ) {
      guard data != nil else { return }
      let body = try? JSONSerialization.data(withJSONObject: data!,options: .prettyPrinted)
      request.httpBody = body
   }

   func handleRequest(urlRequest : URLRequest) async -> (Data,URLResponse)? {
      do {
         let (data,response) = try await URLSession.shared.data(for: urlRequest)
         return (data,response)
      }catch let e {
         print("Error while fetching data : \(e)")
      }
      return nil
   }
   
   func refreshToken() async -> String? {
      let url = URL(string: networkingOptions.accessTokenURL)!
      let (data,response) = try! await  URLSession.shared.data(from: url)
      guard let response = response as? HTTPURLResponse else { return nil }
      if response.statusCode > 199 && response.statusCode < 300 {
         let decodedData = try? JSONDecoder().decode(RefreshTokenResponse.self, from: data)
         return decodedData?.accesToken
      }
      return nil
   }
}
