//
//  RouterPath.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI

// MARK: - RouterDestination

enum RouterDestination: Hashable {
  case repoDetail(RepositoryOverview)
  case repoList
}

// MARK: - RouterPath
@MainActor
@Observable class RouterPath {
  var path: [RouterDestination] = []
  
  init() {}
  
  func navigate(to: RouterDestination) {
    path.append(to)
  }
}

// MARK: - View + withRouter

@MainActor
extension View {
  func withRouter() -> some View {
    navigationDestination(for: RouterDestination.self) { destination in
      switch destination {
      case let .repoDetail(repo):
        RepoDetailView(viewModel: RepoDetailViewModel(repositoryOverview: repo))
      case .repoList:
        RepoListView()
      }
    }
  }
}
