//
//  RepoDetailView.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI

@MainActor
struct RepoDetailView: View {
  @Environment(\.apiClient) private var apiClient: ApiClientType
  @Environment(RouterPath.self) private var routerPath
  
  @State private var viewModel: RepoDetailViewModel
  
  init(viewModel: RepoDetailViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 16) {
          VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.repositoryOverview.name)
              .font(.title)
              .fontWeight(.bold)
            Text(viewModel.repositoryOverview.fullName)
              .font(.subheadline)
              .foregroundColor(.gray)
          }
          
          if let description = viewModel.repositoryOverview.description {
            Text(description)
              .font(.body)
          }
          if let repository = viewModel.repository {
            statsSection(repository)
          }
          if let language = viewModel.repository?.language {
            VStack(alignment: .leading, spacing: 8) {
              Text("Primary Language")
                .font(.headline)
              
              Text(language)
                .font(.body)
                .padding(5)
                .background(.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .padding(.vertical, 8)
          }
        }
        .padding(.horizontal, 16)
        Divider()
        recentIssuesHeader
        if viewModel.issues.isEmpty {
          Text("No issues found in the last year ✨")
            .foregroundStyle(.gray.opacity(0.6))
            .padding(32)
        } else {
          LazyVStack {
            ForEach(viewModel.issues) { issue in
              selectedIssueRow(for: issue)
            }
            .padding(.vertical, 16)
          }
        }
      }
    }
    .navigationTitle(viewModel.repositoryOverview.name)
    .navigationBarTitleDisplayMode(.inline)
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
  }
  
  private func statsSection(_ repository: Repository) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        statView(
          icon: "star.fill",
          color: .yellow,
          title: "Stars",
          value: "\(repository.stargazersCount)"
        )
        Spacer()
        statView(
          icon: "tuningfork",
          color: .green,
          title: "Forks",
          value: "\(repository.forksCount)"
        )
        Spacer()
        statView(
          icon: "exclamationmark.circle.fill",
          color: .cyan,
          title: "Issues",
          value: "\(repository.openIssuesCount)"
        )
        Spacer()
      }
    }
  }
  
  private func statView(
    icon: String,
    color: Color,
    title: String,
    value: String
  ) -> some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(color)
      VStack(alignment: .leading) {
        Text(title)
          .font(.caption)
          .foregroundColor(.gray)
        Text(value)
          .font(.body)
          .fontWeight(.semibold)
      }
    }
  }
  
  private var recentIssuesHeader: some View {
    ZStack(alignment: .leading) {
      Color.gray.opacity(0.1)
      
      VStack(alignment: .leading) {
        Text("Recent Issues")
          .font(.headline)
          .padding(.bottom, 4)
      }
      .padding(.all, 16)
    }
  }
  
  private func selectedIssueRow(for issue: Issue) -> some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(issue.title)
            .font(.headline)
          Text("#\(issue.number)")
        }
        Spacer()
        Text(issue.formattedCreatedAt)
      }
      .padding(.horizontal, 16)
      Divider()
    }
  }
}

#Preview {
  RepoDetailView(
    viewModel: RepoDetailViewModel(
      repositoryOverview: .placeholder()
    )
  )
  .environment(\.apiClient, TestApiClient())
  .environment(RouterPath())
}
