//
//  ApiError.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

enum ApiError: Error {
  case forbidden
  case invalidUrl
  case networkError
  case noResponse
  case parseError
  case responseError
  case timeout
  case unauthorised
  case unknown
}
