//
//  RepoListView.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Observation
import SwiftUI

@MainActor
struct RepoListView: View {
  @Environment(\.apiClient) private var apiClient: ApiClientType
  @Environment(RouterPath.self) private var routerPath
  
  @State private var viewModel = RepoListViewModel()
  
  var body: some View {
    List(viewModel.repositoryOverviews) { repository in
      RepoListRowView(
        repository: repository,
        routerPath: routerPath
      )
    }
    .alert(
      Constants.Error.title,
      isPresented: $viewModel.isErrorDisplayed,
      actions: {
        Button {} label: {
          Text(Constants.Error.buttonTitle)
        }
      },
      message: {
        Text(Constants.Error.message)
      }
    )
    .task {
      viewModel.apiClient = apiClient
      await viewModel.fetch()
    }
    .refreshable {
      await viewModel.fetch()
    }
  }
}

#Preview {
  RepoListView()
    .environment(\.apiClient, TestApiClient())
    .environment(RouterPath())
}
