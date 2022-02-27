//
//  SecureContainer.swift
//  
//
//  Created by Князьков Илья on 27.02.2022.
//

import UIKit

open class SecureContainer: UITextField, SecureContainerProtocol {
    
    // MARK: - Private properties
    
    var securedContent: UIView
    var protectedView: UIView {
        self
    }
    
    // MARK: - Initialization
    
    public required init(securedContent: UIView) {
        self.securedContent = securedContent
        super.init(frame: .zero)
        
        isSecureTextEntry = true
    }
    
    public required init?(coder: NSCoder) {
        securedContent = UIView()
        super.init(coder: coder)
        
        isSecureTextEntry = true
    }
    
    // MARK: - UITextField
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !securedContent.isHidden,
              securedContent.alpha > 0.01,
              securedContent.frame.contains(point),
              securedContent.isUserInteractionEnabled else {
                  return super.hitTest(point, with: event)
              }
        return securedContent
    }
    
}

