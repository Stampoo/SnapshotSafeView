//
//  RootControllerInterceptor.swift
//  
//
//  Created by Илья Князьков on 30.01.2023.
//

import UIKit

public final class RootControllerInterceptor: RootControllerInterceptorProtocol {

    // MARK: - Private Properties

    private var timerWhichListenWindowsRoot: DispatchSourceTimer?

    // MARK: - Deinitialization

    deinit {
        stopWaitingRootInWindow()
    }

    // MARK: - RootControllerInterceptorProtocol

    public func performSwitchView(
        in window: UIWindow,
        expectedContainer view: UIView,
        waitWhenRootBecome rootExpectation: RootControllerExpectation
    ) {
        guard
            isNeedPerformSwitching(window.rootViewController, expected: rootExpectation),
            let viewController = window.rootViewController
        else {
            return startWaitingExpectedController(in: window, expectedContainer: view, waitWhenRootBecome: rootExpectation)
        }
        moveContainerBehindDesiredView(view, desired: viewController.view, in: viewController)
    }

}


// MARK: - Private Methods

private extension RootControllerInterceptor {

    func startWaitingExpectedController(
        in window: UIWindow,
        expectedContainer view: UIView,
        waitWhenRootBecome rootExpectation: RootControllerExpectation
    ) {
        stopWaitingRootInWindow()

        timerWhichListenWindowsRoot = DispatchSource.makeTimerSource(queue: .main)
        timerWhichListenWindowsRoot?.setEventHandler { [weak self] in
            guard
                self?.isNeedPerformSwitching(window.rootViewController, expected: rootExpectation) == .some(true),
                let viewController = window.rootViewController
            else {
                return
            }
            self?.moveContainerBehindDesiredView(view, desired: viewController.view, in: viewController)
            self?.stopWaitingRootInWindow()
        }

        timerWhichListenWindowsRoot?.schedule(deadline: .now(), repeating: 0.005)
        timerWhichListenWindowsRoot?.resume()
    }

    func isNeedPerformSwitching(_ controller: UIViewController?, expected rootExpectation: RootControllerExpectation) -> Bool {
        guard let rootViewController = controller else {
            return false
        }
        let typeOfRootInString = String(describing: type(of: rootViewController))
        return typeOfRootInString == rootExpectation.typeInStringRepresentation
    }

    func moveContainerBehindDesiredView(_ container: UIView, desired view: UIView, in controller: UIViewController) {
        DispatchQueue.main.async {
            container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            controller.view = container

            container.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false
            [
                view.topAnchor.constraint(equalTo: container.topAnchor),
                view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ].forEach { constraint in
                constraint.isActive = true
            }
        }
    }

    func stopWaitingRootInWindow() {
        timerWhichListenWindowsRoot?.cancel()
    }

}
