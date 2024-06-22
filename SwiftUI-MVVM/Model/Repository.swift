//
//  Repository.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

struct Repository: Decodable, Identifiable {
  let id: Int
  let name: String
  let fullName: String
  let description: String?
  let createdAt: String
  let stargazersCount: Int
  let language: String?
  let openIssuesCount: Int
  let hasIssues: Bool
  let forksCount: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case fullName = "full_name"
    case description
    case createdAt = "created_at"
    case stargazersCount = "stargazers_count"
    case language
    case openIssuesCount = "open_issues_count"
    case hasIssues = "has_issues"
    case forksCount = "forks_count"
  }
  
  static func placeholder() -> Repository {
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

extension Repository: Hashable {
  static func == (lhs: Repository, rhs: Repository) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

