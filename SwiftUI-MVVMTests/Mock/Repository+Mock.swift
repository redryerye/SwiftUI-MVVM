//
//  Repository+Mock.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

@testable import SwiftUI_MVVM

extension Repository {
  static func mock() -> Repository {
    .init(
      id: 0,
      name: "MockedRepo",
      fullName: "name/MockedRepo",
      description: "Mocked repository.",
      createdAt: "",
      stargazersCount: 7,
      language: "Swift",
      openIssuesCount: 7,
      hasIssues: true,
      forksCount: 10
    )
  }
}
