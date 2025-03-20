//
//  OnboardingTests.swift
//  PolesieTests
//
//  Created by Владислав Бут-Гусаим on 20.03.25.
//

import XCTest
@testable import Polesie

class OnboardingTests: XCTestCase {
    var viewModel: OnboardingViewModel!
    
    override func setUp() {
        super.setUp()
        let steps: [OnboardingModel] = [OnboardingModel(image: "123", title: "dsa", description: "asd"), OnboardingModel(image: "321", title: "asd", description: "dsa")]
        viewModel = OnboardingViewModel(steps: steps)
    }
    
    override class func tearDown() { super.tearDown() }
    
    func testMoveToNextStep() {
        viewModel.moveToNextStep()
        XCTAssertEqual(viewModel.currentStep, 1)
    }
    
    func testCompleteOnboarding() {
        viewModel.moveToNextStep()
        viewModel.moveToNextStep()
        XCTAssertTrue(viewModel.isOnboardingCompleted)
        XCTAssertTrue(viewModel.navigateToMainView)
    }
    
    func testSkipOnboarding() {
        viewModel.skipOnboarding()
        XCTAssertFalse(viewModel.isOnboardingCompleted)
        XCTAssertTrue(viewModel.navigateToMainView)
    }
    
    func testAsyncOnboardingCompletion() {
            let expectation = XCTestExpectation(description: "Onboarding completion")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.completeOnboarding()
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 2)
            XCTAssertTrue(viewModel.isOnboardingCompleted)
            XCTAssertTrue(viewModel.navigateToMainView)
        }
}

class MockViewModel: OnboardingViewModelOutput {
    
    var moveToNextStepIsCalled = false
    func moveToNextStep() {
        moveToNextStepIsCalled = true
    }
    
    var completeOnboardingIsCalled = false
    let expectation = XCTestExpectation(description: "Onboarding completion")
    func completeOnboarding() {
        expectation.fulfill()
        completeOnboardingIsCalled = true
    }
    
    var skipOnboardingIsCalled = false
    func skipOnboarding() {
        skipOnboardingIsCalled = true
    }
}
