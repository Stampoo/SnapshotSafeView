//
//  MultiplatformBridgeView.swift
//  
//
//  Created by Илья Князьков on 19.01.2023.
//

import UIKit

open class MultiplatformBridgeView: UIView {

    // MARK: - Private Properties

    private let screenshotSafeContainer: ScreenshotInvincibleContainer
    private var setupInitialStateIsPerformed: Bool = false

    // MARK: - Initialization

    public init() {
        self.screenshotSafeContainer = ScreenshotInvincibleContainer(content: UIView())
        super.init(frame: .zero)

        configureScreenshotSafeContainer()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView

    override open func addSubview(_ view: UIView) {
        guard setupInitialStateIsPerformed else {
            return super.addSubview(view)
        }
        screenshotSafeContainer.content.addSubview(view)
    }

}

// MARK: - Private Methods

private extension MultiplatformBridgeView {

    func configureScreenshotSafeContainer() {
        screenshotSafeContainer.setupContanerAsHideContentInScreenshots()
        addSubview(screenshotSafeContainer)
        [
            screenshotSafeContainer.topAnchor.constraint(equalTo: topAnchor),
            screenshotSafeContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            screenshotSafeContainer.leftAnchor.constraint(equalTo: leftAnchor),
            screenshotSafeContainer.rightAnchor.constraint(equalTo: rightAnchor)
        ].forEach { $0.isActive = true }
        setupInitialStateIsPerformed = true
    }

}
