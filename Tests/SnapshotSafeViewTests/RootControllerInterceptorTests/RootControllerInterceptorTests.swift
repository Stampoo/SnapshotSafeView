//
//  RootControllerInterceptorTests.swift
//  
//
//  Created by Илья Князьков on 31.01.2023.
//

import XCTest
@testable import SnapshotSafeView

final class RootControllerInterceptorTests: XCTestCase {

    var interceptor: RootControllerInterceptorProtocol {
        RootControllerInterceptor()
    }

    func testOnCorrectInterceptingAndSwitchingViews() {
        let expectation = expectation(description: "Wait for switching")

        let expectedView = TestableView()
        let controller = TestableController()
        let frontView = controller.view

        let window = UIWindow()
        window.rootViewController = controller

        interceptor.performSwitchView(in: window, expectedContainer: expectedView, waitWhenRootBecome: TestableExpectation())

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            XCTAssertEqual(controller.view, expectedView)
            XCTAssertEqual(controller.view.subviews.first, frontView)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testOnCorrectWaitingForInterceptingAndSwitchingViews() {
        let expectation = expectation(description: "Wait for switching")

        let interceptor = self.interceptor
        let expectedView = TestableView()
        let controller = TestableController()
        let frontView = controller.view

        let window = UIWindow()

        interceptor.performSwitchView(in: window, expectedContainer: expectedView, waitWhenRootBecome: TestableExpectation())

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            window.rootViewController = controller
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(controller.view, expectedView)
            XCTAssertEqual(controller.view.subviews.first, frontView)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

}

// MARK: - Mocks

fileprivate final class TestableController: UIViewController { }

fileprivate struct TestableExpectation: RootControllerExpectation {

    var typeInStringRepresentation: String {
        String(describing: type(of: TestableController()))
    }

}

fileprivate final class TestableView: UIView { }
