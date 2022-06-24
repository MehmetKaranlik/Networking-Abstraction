import Foundation


struct NetworkManager : INetworkManager {


   func send<T>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String : String]?,
      bodyType: BodyType,
      queryParameters: [String : String]?
   ) async -> BaseNetworkResponse<T> where T : Decodable, T : Encodable {
      guard var url = URL(string: networkPath) else { return  BaseNetworkResponse<T>(response: nil, data: nil) }
      var request = URLRequest(url: url)
      request.httpMethod = requestType.rawValue
      queryGenerator(requestURL: &url, queryParameters: queryParameters)
      headerGenerator(request: &request)
      bodyGenerator(request: &request, body: body,bodyType: bodyType)
      let (data,response) : (Data?,URLResponse?) = await handleRequest(request: request)
      guard let data else { print("Result : Data bos"); return BaseNetworkResponse<T>(response : nil ,data : nil)}
         let decodedData = decodeData(data: data, parseModel: parseModel.self)
         return BaseNetworkResponse<T>(response: response, data: decodedData)
   }


   




   struct TokenResponseModel: Codable {
      let tokenType: String?
      let expiresIn: Int?
      let accessToken, refreshToken, scope: String?

      enum CodingKeys: String, CodingKey {
         case tokenType = "token_type"
         case expiresIn = "expires_in"
         case accessToken = "access_token"
         case refreshToken = "refresh_token"
         case scope
      }
   }

}
