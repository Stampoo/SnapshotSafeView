//
//  ScreenshotInvincibleContainer.swift
//  
//
//  Created by Князьков Илья on 01.03.2022.
//

import UIKit

final class ScreenshotInvincibleContainer: UITextField {

    // MARK: - Private Properties
    
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
        subviews.forEach(appendContent(to:))
        backgroundColor = .clear
        isUserInteractionEnabled = false
        activateLayoutConstraintsOfContent()
    }
    
    private func activateLayoutConstraintsOfContent() {
        [
            content.topAnchor.constraint(equalTo: topAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor),
            content.leftAnchor.constraint(equalTo: leftAnchor),
            content.rightAnchor.constraint(equalTo: rightAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func appendContent(to view: UIView?) {
        guard let view = view, type(of: view.self).description() == "_UITextLayoutCanvasView" else {
            return
        }
        view.addSubview(content)
    }
    
}

// MARK: - ScreenshotInvincibleContainerProtocol

extension ScreenshotInvincibleContainer: ScreenshotInvincibleContainerProtocol {
    
    public func eraseOldAndAddnewContent(_ newContent: UIView) {
        content.removeFromSuperview()
        content = newContent
        subviews.forEach(appendContent(to:))
        activateLayoutConstraintsOfContent()
    }
    
    public func setupContanerAsHideContentInScreenshots() {
        isSecureTextEntry = true
    }
    
    public func setupContanerAsDisplayContentInScreenshots() {
        isSecureTextEntry = false
    }
    
}
