//
//  SwiftUI_MVVMTests.swift
//  SwiftUI-MVVMTests
//
//  Created by Yuki Yamamoto on 2024/06/22.
//

import XCTest
@testable import SwiftUI_MVVM

final class RepoDetailViewModelTests: XCTestCase {
  
  var viewModel: RepoDetailViewModel!
  var mockApiClient: MockApiClient!
  var repositoryOverview: RepositoryOverview!
  var repository: Repository!
  
  @MainActor
  override func setUp() {
    super.setUp()
    mockApiClient = MockApiClient()
    repositoryOverview = RepositoryOverview.mock()
    repository = Repository.mock()
    viewModel = RepoDetailViewModel(repositoryOverview: repositoryOverview)
    viewModel.apiClient = mockApiClient
  }
  
  override func tearDown() {
    viewModel = nil
    mockApiClient = nil
    repository = nil
    repositoryOverview = nil
    super.tearDown()
  }
  
  @MainActor
  func testFetchSuccess() async {
    // Given
    let mockRepository = Repository.mock()
    let mockIssues = Issue.mocksForTwoWeeks()
    mockApiClient.stub(value: mockRepository)
    mockApiClient.stub(value: mockIssues)
    
    // When
    await viewModel.fetch()
    
    // Then
    XCTAssertFalse(viewModel.isErrorDisplayed)
    XCTAssertEqual(viewModel.repository?.id, mockRepository.id)
    XCTAssertEqual(viewModel.repository?.fullName, mockRepository.fullName)
    XCTAssertEqual(viewModel.issues.count, mockIssues.count)
  }
  
  @MainActor
  func testFetchFailure() async {
    // Given
    // No stubs, so it will throw an error
    
    // When
    await viewModel.fetch()
    
    // Then
    XCTAssertTrue(viewModel.isErrorDisplayed)
    XCTAssertNil(viewModel.repository)
    XCTAssertTrue(viewModel.issues.isEmpty)
  }
}
