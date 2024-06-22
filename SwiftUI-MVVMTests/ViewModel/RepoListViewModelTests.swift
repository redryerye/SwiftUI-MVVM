//
//  RepoListViewModelTests.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import XCTest
@testable import SwiftUI_MVVM

final class RepoListViewModelTests: XCTestCase {
  
  var viewModel: RepoListViewModel!
  var mockApiClient: MockApiClient!
  
  @MainActor
  override func setUp() {
    super.setUp()
    mockApiClient = MockApiClient()
    viewModel = RepoListViewModel()
    viewModel.apiClient = mockApiClient
  }
  
  override func tearDown() {
    viewModel = nil
    mockApiClient = nil
    super.tearDown()
  }
  
  @MainActor
  func testFetchSuccess() async {
    // Given
    let mockResponse: [RepositoryOverview] = [.mock()]
    mockApiClient.stub(value: mockResponse)
    
    // When
    await viewModel.fetch()
    
    // Then
    XCTAssertFalse(viewModel.isErrorDisplayed)
    XCTAssertEqual(viewModel.repositoryOverviews.count, mockResponse.count)
    XCTAssertEqual(viewModel.repositoryOverviews.first?.name, mockResponse.first?.name)
  }
  
  @MainActor
  func testFetchFailure() async {
    // Given
    // No stubs, so it will throw an error
    
    // When
    await viewModel.fetch()
    
    // Then
    XCTAssertTrue(viewModel.isErrorDisplayed)
    XCTAssertTrue(viewModel.repositoryOverviews.isEmpty)
  }
}
