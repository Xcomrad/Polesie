//
//  OnboardingTests.swift
//  PolesieTests
//
//  Created by Владислав Бут-Гусаим on 20.03.25.
//

import XCTest
@testable import Polesie

class OnboardingTests: XCTestCase {
    var vm: OnboardingViewModel!
    
    override func setUp() {
        super.setUp()
        let steps: [OnboardingModel] = [
            OnboardingModel(image: nil, title: "dsa", description: "asd"),
            OnboardingModel(image: nil, title: "asd", description: "dsa")]
        vm = OnboardingViewModel(steps: steps)
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func testStepsInitialization() {
        XCTAssertEqual(vm.steps.count, 2)
        XCTAssertEqual(vm.steps[0].title, "dsa")
        XCTAssertEqual(vm.steps[1].title, "asd")
    }
    
    
    func testMoveToNextStep() {
        vm.moveToNextStep()
        XCTAssertEqual(vm.currentStep, 1)
    }
    
    func testCompleteOnboarding() {
        vm.moveToNextStep()
        vm.moveToNextStep()
        XCTAssertTrue(vm.isOnboardingCompleted)
        XCTAssertTrue(vm.navigateToMainView)
    }
    
    func testSkipOnboarding() {
        vm.skipOnboarding()
        XCTAssertTrue(vm.navigateToMainView)
        XCTAssertFalse(vm.isOnboardingCompleted)
    }
}
