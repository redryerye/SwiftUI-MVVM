//
//  MockApiClient.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation
@testable import SwiftUI_MVVM

final class MockApiClient: ApiClientType {
  var stubs: [Any] = []
  
  func stub(value: Any) {
    stubs.append(value)
  }
  
  func request<T>(
    for endpoint: any Endpoint
  ) async throws -> T where T : Decodable {
    if let stub = stubs.compactMap({ $0 as? T }).last {
      return stub
    } else {
      throw ApiError.unknown
    }
  }
}
