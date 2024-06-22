//
//  RepositoryOverview+Mock.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

@testable import SwiftUI_MVVM

extension RepositoryOverview {
  static func mock() -> RepositoryOverview {
    .init(
      id: 0,
      name: "MockedRepo",
      fullName: "name/MockedRepo",
      description: "Mocked repository."
    )
  }
}
