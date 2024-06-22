//
//  SharedDateFormatter.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

class SharedDateFormatter {
  static let shared = SharedDateFormatter()
  
  let iso8601DateFormatter: ISO8601DateFormatter
  let shortDateFormatter: DateFormatter
  let mediumDateFormatter: DateFormatter
  
  init() {
    self.iso8601DateFormatter = ISO8601DateFormatter()
    
    let shortDateFormatted = DateFormatter()
    shortDateFormatted.dateStyle = .short
    shortDateFormatted.timeStyle = .none
    self.shortDateFormatter = shortDateFormatted
    
    let mediumdateFormatter = DateFormatter()
    mediumdateFormatter.dateStyle = .medium
    mediumdateFormatter.timeStyle = .medium
    self.mediumDateFormatter = mediumdateFormatter
  }
}
