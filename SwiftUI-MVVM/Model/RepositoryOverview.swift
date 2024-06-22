//
//  RepositoryOverview.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

struct RepositoryOverview: Decodable, Identifiable {
  let id: Int
  let name: String
  let fullName: String
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case fullName = "full_name"
    case description
  }
  
  static func placeholder() -> RepositoryOverview {
    .init(
      id: 0,
      name: "MockedRepo",
      fullName: "name/MockedRepo",
      description: "Mocked repository."
    )
  }
}

extension RepositoryOverview: Hashable {
  static func == (lhs: RepositoryOverview, rhs: RepositoryOverview) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
