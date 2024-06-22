//
//  Constants.swift
//  SwiftUI-MVVM
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

enum Constants {
  
  // MARK: - Third Party
  
  enum GitHub {
    // TODO: - Replace with a valid access token
    static let accessToken = ""
  }
  
  // MARK: - Network
  
  enum Network {
    enum AuthType {
      static let bearer = "Bearer"
    }
    
    enum ContentType {
      static let json = "application/vnd.github+json"
    }
    
    enum HTTPHeaderField {
      static let accept = "Accept"
      static let authorization = "Authorization"
      static let githubApiVersion = "X-GitHub-Api-Version"
    }
    
    enum ResponseHeader {
      // Response headers regarding GitHub rate limit
      // https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api?apiVersion=2022-11-28#checking-the-status-of-your-rate-limit
      static let rateLimitLimitKey = "x-ratelimit-limit"
      static let rateLimitRemainingKey = "x-ratelimit-remaining"
      static let rateLimitUsedKey = "x-ratelimit-used"
      static let rateLimitResetKey = "x-ratelimit-reset"
      static let rateLimitResourceKey = "x-ratelimit-resource"
    }
  }
  
  // MARK: - RepoList
  
  enum RepoList {
    static let title = "Public Repositories"
  }
  
  // MARK: - Error
  
  enum Error {
    static let title = "Error has occured"
    static let message = "You may have reached the GitHub rate limit. Check the access token or try again later."
    static let buttonTitle = "Got it"
  }
}
