//
//  Issue.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

struct Issue: Decodable, Identifiable, Hashable {
  let id: Int
  let title: String
  let number: Int
  let createdAt: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case number
    case createdAt = "created_at"
  }
  
  var createdAtDate: Date {
    return SharedDateFormatter.shared.iso8601DateFormatter.date(from: createdAt)!
  }
  
  var formattedCreatedAt: String {
    return SharedDateFormatter.shared.shortDateFormatter.string(
      from: createdAtDate
    )
  }
  
  static func placeholder(
    id: Int = 0,
    createdAt: String
  ) -> Issue {
    .init(
      id: id,
      title: "Known Issue",
      number: 293,
      createdAt: createdAt
    )
  }
  
  static func placeholders() -> [Issue] {
    [
      placeholder(id: 0, createdAt: "2024-07-01T14:56:27Z"),
      placeholder(id: 1, createdAt: "2024-07-10T14:56:27Z"),
      placeholder(id: 2, createdAt: "2024-07-17T14:56:27Z"),
      placeholder(id: 3, createdAt: "2024-07-25T14:56:27Z"),
      placeholder(id: 4, createdAt: "2024-06-21T14:56:27Z"),
      placeholder(id: 5, createdAt: "2024-06-14T14:56:27Z"),
      placeholder(id: 6, createdAt: "2024-06-07T14:56:27Z"),
      placeholder(id: 7, createdAt: "2024-06-01T14:56:27Z"),
      placeholder(id: 8, createdAt: "2024-05-25T14:56:27Z"),
      placeholder(id: 9, createdAt: "2024-05-18T14:56:27Z"),
      placeholder(id: 10, createdAt: "2024-05-10T14:56:27Z"),
      placeholder(id: 11, createdAt: "2024-05-01T14:56:27Z"),
      placeholder(id: 12, createdAt: "2024-05-02T14:56:27Z")
    ]
  }
}

extension Issue: Comparable {
  static func < (lhs: Issue, rhs: Issue) -> Bool {
    lhs.createdAtDate < rhs.createdAtDate
  }
}
