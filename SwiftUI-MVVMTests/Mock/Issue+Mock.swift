//
//  Issue+Mock.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

@testable import SwiftUI_MVVM

extension Issue {
  static func mock(
    id: Int,
    createdAt: String
  ) -> Issue {
    .init(
      id: id,
      title: "Known Issue",
      number: 293,
      createdAt: createdAt
    )
  }
  
  static func mocksForTwoWeeks() -> [Issue] {
    [
      mock(id: 0, createdAt: "2024-01-31T14:56:27Z"),
      mock(id: 1, createdAt: "2024-02-07T14:56:27Z"),
      mock(id: 2, createdAt: "2024-02-08T14:56:27Z"),
      mock(id: 3, createdAt: "2024-02-10T14:56:27Z")
    ]
  }
}

