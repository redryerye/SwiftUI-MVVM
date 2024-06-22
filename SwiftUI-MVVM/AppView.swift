//
//  ContentView.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import SwiftUI

@MainActor
struct AppView: View {
  @State var apiClient = ApiClient()
  @State var routerPath = RouterPath()
  
  var body: some View {
    NavigationStack(path: $routerPath.path) {
      RepoListView()
        .withRouter()
        .navigationTitle(Constants.RepoList.title)
    }
    .environment(routerPath)
    .environment(\.apiClient, apiClient)
  }
}
