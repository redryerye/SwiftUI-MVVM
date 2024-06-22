//
//  TestApiClient.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import Foundation

#if DEBUG
@Observable class TestApiClient: ApiClientType {
  func request<T: Decodable>(for endpoint: Endpoint) async throws -> T {
    guard
      let endpoint = endpoint as? RepositoryEndpoint,
      let data = mockData(for: endpoint).data(using: .utf8)
    else {
      throw ApiError.unknown
    }
    return try decodeJSON(data: data)
  }
  
  
  private func decodeJSON<T: Decodable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }
  
  private func mockData(for endpoint: RepositoryEndpoint) -> String {
    switch endpoint {
    case .repositoryIssues: """
      [
          {
              "id": 1,
              "title": "Mocked Issue 1",
              "number": 1,
              "created_at": "2023-01-01T00:00:00Z"
          },
          {
              "id": 2,
              "title": "Mocked Issue 2",
              "number": 2,
              "created_at": "2023-01-12T00:00:00Z"
          }
      ]
      """
      
    case .repo: """
      {
          "id": 1,
          "node_id": "abcf",
          "name": "grit",
          "full_name": "mock/grit",
          "private": false,
          "owner": {
              "login": "mock",
              "id": 1,
              "node_id": "MDQ6VXNlcjE=",
              "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/mock",
              "html_url": "https://github.com/mock",
              "followers_url": "https://api.github.com/users/mock/followers",
              "following_url": "https://api.github.com/users/mock/following{/other_user}",
              "gists_url": "https://api.github.com/users/mock/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/mock/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/mock/subscriptions",
              "organizations_url": "https://api.github.com/users/mock/orgs",
              "repos_url": "https://api.github.com/users/mock/repos",
              "events_url": "https://api.github.com/users/mock/events{/privacy}",
              "received_events_url": "https://api.github.com/users/mock/received_events",
              "type": "User",
              "site_admin": false
          },
          "html_url": "https://github.com/mock/grit",
          "description": "Description for the repository",
          "fork": false,
          "url": "https://api.github.com/repos/mock/grit",
          "forks_url": "https://api.github.com/repos/mock/grit/forks",
          "keys_url": "https://api.github.com/repos/mock/grit/keys{/key_id}",
          "collaborators_url": "https://api.github.com/repos/mock/grit/collaborators{/collaborator}",
          "teams_url": "https://api.github.com/repos/mock/grit/teams",
          "hooks_url": "https://api.github.com/repos/mock/grit/hooks",
          "issue_events_url": "https://api.github.com/repos/mock/grit/issues/events{/number}",
          "events_url": "https://api.github.com/repos/mock/grit/events",
          "assignees_url": "https://api.github.com/repos/mock/grit/assignees{/user}",
          "branches_url": "https://api.github.com/repos/mock/grit/branches{/branch}",
          "tags_url": "https://api.github.com/repos/mock/grit/tags",
          "blobs_url": "https://api.github.com/repos/mock/grit/git/blobs{/sha}",
          "git_tags_url": "https://api.github.com/repos/mock/grit/git/tags{/sha}",
          "git_refs_url": "https://api.github.com/repos/mock/grit/git/refs{/sha}",
          "trees_url": "https://api.github.com/repos/mock/grit/git/trees{/sha}",
          "statuses_url": "https://api.github.com/repos/mock/grit/statuses/{sha}",
          "languages_url": "https://api.github.com/repos/mock/grit/languages",
          "stargazers_url": "https://api.github.com/repos/mock/grit/stargazers",
          "contributors_url": "https://api.github.com/repos/mock/grit/contributors",
          "subscribers_url": "https://api.github.com/repos/mock/grit/subscribers",
          "subscription_url": "https://api.github.com/repos/mock/grit/subscription",
          "commits_url": "https://api.github.com/repos/mock/grit/commits{/sha}",
          "git_commits_url": "https://api.github.com/repos/mock/grit/git/commits{/sha}",
          "comments_url": "https://api.github.com/repos/mock/grit/comments{/number}",
          "issue_comment_url": "https://api.github.com/repos/mock/grit/issues/comments{/number}",
          "contents_url": "https://api.github.com/repos/mock/grit/contents/{+path}",
          "compare_url": "https://api.github.com/repos/mock/grit/compare/{base}...{head}",
          "merges_url": "https://api.github.com/repos/mock/grit/merges",
          "archive_url": "https://api.github.com/repos/mock/grit/{archive_format}{/ref}",
          "downloads_url": "https://api.github.com/repos/mock/grit/downloads",
          "issues_url": "https://api.github.com/repos/mock/grit/issues{/number}",
          "pulls_url": "https://api.github.com/repos/mock/grit/pulls{/number}",
          "milestones_url": "https://api.github.com/repos/mock/grit/milestones{/number}",
          "notifications_url": "https://api.github.com/repos/mock/grit/notifications{?since,all,participating}",
          "labels_url": "https://api.github.com/repos/mock/grit/labels{/name}",
          "releases_url": "https://api.github.com/repos/mock/grit/releases{/id}",
          "deployments_url": "https://api.github.com/repos/mock/grit/deployments",
          "created_at": "2007-10-29T14:37:16Z",
          "updated_at": "2024-05-10T12:06:11Z",
          "pushed_at": "2023-08-17T19:15:41Z",
          "git_url": "git://github.com/mock/grit.git",
          "ssh_url": "git@github.com:mock/grit.git",
          "clone_url": "https://github.com/mock/grit.git",
          "svn_url": "https://github.com/mock/grit",
          "homepage": "http://grit.rubyforge.org/",
          "size": 7954,
          "stargazers_count": 1967,
          "watchers_count": 1967,
          "language": "Ruby",
          "has_issues": true,
          "has_projects": true,
          "has_downloads": true,
          "has_wiki": true,
          "has_pages": false,
          "has_discussions": false,
          "forks_count": 515,
          "mirror_url": null,
          "archived": false,
          "disabled": false,
          "open_issues_count": 42,
          "license": {
              "key": "mit",
              "name": "MIT License",
              "spdx_id": "MIT",
              "url": "https://api.github.com/licenses/mit",
              "node_id": "MDc6TGljZW5zZTEz"
          },
          "allow_forking": true,
          "is_template": false,
          "web_commit_signoff_required": false,
          "topics": [],
          "visibility": "public",
          "forks": 515,
          "open_issues": 42,
          "watchers": 1967,
          "default_branch": "master",
          "permissions": {
              "admin": false,
              "maintain": false,
              "push": false,
              "triage": false,
              "pull": true
          },
          "temp_clone_token": "",
          "network_count": 515,
          "subscribers_count": 71
      }
      """
      
    case .repositories: """
      [
          {
              "id": 1,
              "node_id": "abcf",
              "name": "grit",
              "full_name": "mock/grit",
              "private": false,
              "owner": {
                  "login": "mock",
                  "id": 1,
                  "node_id": "MDQ6VXNlcjE=",
                  "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
                  "gravatar_id": "",
                  "url": "https://api.github.com/users/mock",
                  "html_url": "https://github.com/mock",
                  "followers_url": "https://api.github.com/users/mock/followers",
                  "following_url": "https://api.github.com/users/mock/following{/other_user}",
                  "gists_url": "https://api.github.com/users/mock/gists{/gist_id}",
                  "starred_url": "https://api.github.com/users/mock/starred{/owner}{/repo}",
                  "subscriptions_url": "https://api.github.com/users/mock/subscriptions",
                  "organizations_url": "https://api.github.com/users/mock/orgs",
                  "repos_url": "https://api.github.com/users/mock/repos",
                  "events_url": "https://api.github.com/users/mock/events{/privacy}",
                  "received_events_url": "https://api.github.com/users/mock/received_events",
                  "type": "User",
                  "site_admin": false
              },
              "html_url": "https://github.com/mock/grit",
              "description": "Description for the repository",
              "fork": false,
              "url": "https://api.github.com/repos/mock/grit",
              "forks_url": "https://api.github.com/repos/mock/grit/forks",
              "keys_url": "https://api.github.com/repos/mock/grit/keys{/key_id}",
              "collaborators_url": "https://api.github.com/repos/mock/grit/collaborators{/collaborator}",
              "teams_url": "https://api.github.com/repos/mock/grit/teams",
              "hooks_url": "https://api.github.com/repos/mock/grit/hooks",
              "issue_events_url": "https://api.github.com/repos/mock/grit/issues/events{/number}",
              "events_url": "https://api.github.com/repos/mock/grit/events",
              "assignees_url": "https://api.github.com/repos/mock/grit/assignees{/user}",
              "branches_url": "https://api.github.com/repos/mock/grit/branches{/branch}",
              "tags_url": "https://api.github.com/repos/mock/grit/tags",
              "blobs_url": "https://api.github.com/repos/mock/grit/git/blobs{/sha}",
              "git_tags_url": "https://api.github.com/repos/mock/grit/git/tags{/sha}",
              "git_refs_url": "https://api.github.com/repos/mock/grit/git/refs{/sha}",
              "trees_url": "https://api.github.com/repos/mock/grit/git/trees{/sha}",
              "statuses_url": "https://api.github.com/repos/mock/grit/statuses/{sha}",
              "languages_url": "https://api.github.com/repos/mock/grit/languages",
              "stargazers_url": "https://api.github.com/repos/mock/grit/stargazers",
              "contributors_url": "https://api.github.com/repos/mock/grit/contributors",
              "subscribers_url": "https://api.github.com/repos/mock/grit/subscribers",
              "subscription_url": "https://api.github.com/repos/mock/grit/subscription",
              "commits_url": "https://api.github.com/repos/mock/grit/commits{/sha}",
              "git_commits_url": "https://api.github.com/repos/mock/grit/git/commits{/sha}",
              "comments_url": "https://api.github.com/repos/mock/grit/comments{/number}",
              "issue_comment_url": "https://api.github.com/repos/mock/grit/issues/comments{/number}",
              "contents_url": "https://api.github.com/repos/mock/grit/contents/{+path}",
              "compare_url": "https://api.github.com/repos/mock/grit/compare/{base}...{head}",
              "merges_url": "https://api.github.com/repos/mock/grit/merges",
              "archive_url": "https://api.github.com/repos/mock/grit/{archive_format}{/ref}",
              "downloads_url": "https://api.github.com/repos/mock/grit/downloads",
              "issues_url": "https://api.github.com/repos/mock/grit/issues{/number}",
              "pulls_url": "https://api.github.com/repos/mock/grit/pulls{/number}",
              "milestones_url": "https://api.github.com/repos/mock/grit/milestones{/number}",
              "notifications_url": "https://api.github.com/repos/mock/grit/notifications{?since,all,participating}",
              "labels_url": "https://api.github.com/repos/mock/grit/labels{/name}",
              "releases_url": "https://api.github.com/repos/mock/grit/releases{/id}",
              "deployments_url": "https://api.github.com/repos/mock/grit/deployments"
          }
      ]
      """
    }
  }
}
#endif
