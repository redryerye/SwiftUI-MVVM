//
//  RepoDetailViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI
import Observation

@MainActor
@Observable final class RepoDetailViewModel {
  var apiClient: ApiClientType?
  
  var isErrorDisplayed = false
  var issues: [Issue] = []
  let repositoryOverview: RepositoryOverview
  var repository: Repository?
  
  init(
    repositoryOverview: RepositoryOverview
  ) {
    self.repositoryOverview = repositoryOverview
  }
  
  func fetch() async {
    guard let apiClient else {
      return
    }
    
    do {
      // Fetch repository
      let repoEndpoint = RepositoryEndpoint.repo(
        fullName: repositoryOverview.fullName
      )
      repository = try await apiClient.request(
        for: repoEndpoint
      )
      
      // Fetching issues since an year
      let calendar = Calendar.current
      let today = Date()
      let dateThreeMonthBefore = calendar.date(
        byAdding: .year,
        value: -1,
        to: today
      )!
      
      let issuesEndpoint = RepositoryEndpoint.repositoryIssues(
        fullName: repositoryOverview.fullName,
        startDate: dateThreeMonthBefore
      )
      
      let response: [Issue] = try await apiClient.request(
        for: issuesEndpoint
      )
      issues = response.sorted(by: >)
    } catch {
      isErrorDisplayed = true
    }
  }
}
