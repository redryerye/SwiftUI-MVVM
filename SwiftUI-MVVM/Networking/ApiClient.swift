//
//  ApiClient.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation
import OSLog
import Observation

protocol ApiClientType {
  func request<T: Decodable>(
    for endpoint: Endpoint
  ) async throws -> T
}

@Observable class ApiClient {
  
  // MARK: - Private properties
  
  private let baseURL: URL
  private static let logger = Logger()
  
  // MARK: - Life cycle
  
  init(baseURL: URL = URL(string: "https://api.github.com")!) {
    self.baseURL = baseURL
  }
}

extension ApiClient: ApiClientType {
  func request<T: Decodable>(
    for endpoint: Endpoint
  ) async throws -> T {
    
    guard
      let pathURL = URL(
        string: endpoint.path(),
        relativeTo: baseURL
      )
    else {
      throw ApiError.invalidUrl
    }
    
    var urlComponents = URLComponents(
      url: pathURL,
      resolvingAgainstBaseURL: true
    )!
    
    if let queryItems = endpoint.queryItems() {
      urlComponents.queryItems = queryItems
    }
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"
    request.addValue(
      Constants.Network.ContentType.json,
      forHTTPHeaderField: Constants.Network.HTTPHeaderField.accept
    )
    request.addValue(
      "2022-11-28",
      forHTTPHeaderField: Constants.Network.HTTPHeaderField.githubApiVersion
    )
    
    request.addValue(
      "\(Constants.Network.AuthType.bearer) \(Constants.GitHub.accessToken)",
      forHTTPHeaderField: Constants.Network.HTTPHeaderField.authorization
    )
    do {
      let (data, response) = try await URLSession.shared.data(
        for: request,
        delegate: nil
      )
      
      guard let response = response as? HTTPURLResponse else {
        throw ApiError.noResponse
      }
      // Log github rate limit related responses
      logRateLimitHeaderResponses(from: response.allHeaderFields)
      
      switch response.statusCode {
      case 200...299:
        do {
          let decoder = JSONDecoder()
          let decoded = try decoder.decode(T.self, from: data)
          return decoded
        } catch {
          throw ApiError.parseError
        }
      case 401:
        throw ApiError.unauthorised
      case 403:
        throw ApiError.forbidden
      default:
        throw ApiError.unknown
      }
    } catch URLError.Code.notConnectedToInternet {
      throw ApiError.networkError
    } catch URLError.Code.timedOut {
      throw ApiError.timeout
    } catch {
      throw ApiError.unknown
    }
  }
}

private extension ApiClient {
  func logRateLimitHeaderResponses(from headerFields:  [AnyHashable : Any]) {
    if let rateLimitLimit = headerFields[Constants.Network.ResponseHeader.rateLimitLimitKey] as? String {
      Self.logger.log("Rate Limit Limit: \(rateLimitLimit)")
    }
    if let rateLimitRemaining = headerFields[Constants.Network.ResponseHeader.rateLimitRemainingKey] as? String {
      Self.logger.log("Rate Limit Remaining: \(rateLimitRemaining)")
    }
    if let rateLimitUsed = headerFields[Constants.Network.ResponseHeader.rateLimitUsedKey] as? String {
      Self.logger.log("Rate Limit Used: \(rateLimitUsed)")
    }
    if let rateLimitResource = headerFields[Constants.Network.ResponseHeader.rateLimitResourceKey] as? String {
      Self.logger.log("Rate Limit Resource: \(rateLimitResource)")
    }
    
    if let rateLimitReset = headerFields[Constants.Network.ResponseHeader.rateLimitResetKey] as? String,
       let resetInterval = TimeInterval(rateLimitReset) {
      let resetDate = Date(timeIntervalSince1970: resetInterval)
      let resetDateString = SharedDateFormatter.shared.mediumDateFormatter.string(
        from: resetDate
      )
      
      Self.logger.log("Rate Limit Reset Time: \(resetDateString)")
    }
  }
}
