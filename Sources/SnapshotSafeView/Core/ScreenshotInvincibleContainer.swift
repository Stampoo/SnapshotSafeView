//
//  ScreenshotInvincibleContainer.swift
//  
//
//  Created by Князьков Илья on 01.03.2022.
//

import UIKit

final class ScreenshotInvincibleContainer: UITextField {

    // MARK: - Private Properties

    private let hiddenContainerRecognizer = HiddenContainerRecognizer()
    private var container: UIView? {
        try? hiddenContainerRecognizer.getHiddenContainer(from: self)
    }

    // MARK: - Internal Properties

    /// - View, which will be hidden on screenshots and screen recording
    private(set) var content: UIView

    // MARK: - Initialization
    
    public init(content: UIView) {
        self.content = content
        super.init(frame: .zero)
        setupInitialState()
    }
    
    public required init?(coder: NSCoder) {
        self.content = UIView()
        super.init(coder: coder)
        setupInitialState()
    }

    // MARK: - UIView
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !isHidden,
              alpha > 0.01,
              frame.contains(point),
              isUserInteractionEnabled else {
                  return super.hitTest(point, with: event)
              }
        return self
    }
    
    // MARK: - Private methods
    
    private func setupInitialState() {
        appendContent(to: container)

        backgroundColor = .clear
        isUserInteractionEnabled = false
    }
    
    private func activateLayoutConstraintsOfContent(to view: UIView) {
        [
            content.topAnchor.constraint(equalTo: view.topAnchor),
            content.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            content.leftAnchor.constraint(equalTo: view.leftAnchor),
            content.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func appendContent(to view: UIView?) {
        guard let view = view else {
            return
        }
        view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        activateLayoutConstraintsOfContent(to: view)
    }
    
}

// MARK: - ScreenshotInvincibleContainerProtocol

extension ScreenshotInvincibleContainer: ScreenshotInvincibleContainerProtocol {
    
    public func eraseOldAndAddnewContent(_ newContent: UIView) {
        content.removeFromSuperview()
        content = newContent
        appendContent(to: container)
    }
    
    public func setupContanerAsHideContentInScreenshots() {
        isSecureTextEntry = true
    }
    
    public func setupContanerAsDisplayContentInScreenshots() {
        isSecureTextEntry = false
    }
    
}
