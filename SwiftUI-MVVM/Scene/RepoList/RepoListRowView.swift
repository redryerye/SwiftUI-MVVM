//
//  RepoListRowView.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI

@MainActor
struct RepoListRowView: View {
  private let repository: RepositoryOverview
  private let routerPath: RouterPath
  
  init(repository: RepositoryOverview, routerPath: RouterPath) {
    self.repository = repository
    self.routerPath = routerPath
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(repository.fullName)
          .font(.headline)
        if let description = repository.description {
          Text(description)
            .font(.body)
        }
      }
      .padding(.vertical, 12)
      Spacer()
      Image(systemName: "chevron.forward")
    }
    .contentShape(Rectangle())
    .onTapGesture {
      routerPath.navigate(to: .repoDetail(repository))
    }
  }
}

#Preview {
  RepoListRowView(repository: .placeholder(), routerPath: RouterPath())
}
