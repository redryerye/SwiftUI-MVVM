//
//  RepositoryEndpoint.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

enum RepositoryEndpoint: Endpoint {
  case repositoryIssues(fullName: String, startDate: Date)
  case repo(fullName: String)
  case repositories
  
  func path() -> String {
    switch self {
    case let .repositoryIssues(fullName, _):
      "/repos/\(fullName)/issues"
      
    case let .repo(fullName):
      "/repos/\(fullName)"
      
    case .repositories:
      "/repositories"
    }
  }
  
  func queryItems() -> [URLQueryItem]? {
    switch self {
    case let .repositoryIssues(_, startDate):
      [
        // Only show results that were last updated after the given time.
        // This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
        .init(
          name: "since",
          value: SharedDateFormatter.shared.iso8601DateFormatter.string(
            from: startDate
          )
        ),
        // The number of results per page (max 100)
        .init(name: "per_page", value: String(100))
      ]
    case .repo, .repositories:
      []
    }
  }
}
