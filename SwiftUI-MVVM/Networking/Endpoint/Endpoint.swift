//
//  Endpoint.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

protocol Endpoint {
  func path() -> String
  func queryItems() -> [URLQueryItem]?
}
