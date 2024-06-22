//
//  RepoListViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Observation

@MainActor
@Observable class RepoListViewModel {
  var apiClient: ApiClientType?
  var isErrorDisplayed = false
  var repositoryOverviews = [RepositoryOverview]()
  
  func fetch() async {
    guard let apiClient else { return }
    
    let endpoint = RepositoryEndpoint.repositories
    
    do {
      repositoryOverviews = try await apiClient.request(for: endpoint)
    } catch {
      isErrorDisplayed = true
    }
  }
}
