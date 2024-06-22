//
//  ApiClientKey.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI

private struct ApiClientKey: EnvironmentKey {
  static let defaultValue: ApiClientType = ApiClient()
}

extension EnvironmentValues {
  var apiClient: ApiClientType {
    get { self[ApiClientKey.self] }
    set { self[ApiClientKey.self] = newValue }
  }
}
