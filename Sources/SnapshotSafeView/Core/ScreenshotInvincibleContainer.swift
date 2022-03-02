//
//  ScreenshotInvincibleContainer.swift
//  
//
//  Created by Князьков Илья on 01.03.2022.
//

import UIKit

final class ScreenshotInvincibleContainer: UITextField {
    
    /// - View, which will be hidden on screenshots and screen recording
    private(set) var content: UIView
    
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayoutOfContentAfterChangeLayoutInContainer()
    }
    
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
    }
    
    private func updateLayoutOfContentAfterChangeLayoutInContainer() {
        content.frame = self.bounds
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
    }
    
    public func setupContanerAsHideContentInScreenshots() {
        isSecureTextEntry = true
    }
    
    public func setupContanerAsDisplayContentInScreenshots() {
        isSecureTextEntry = false
    }
    
}
