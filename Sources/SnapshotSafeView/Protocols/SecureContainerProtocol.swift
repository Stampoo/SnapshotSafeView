//
//  SecureContainerProtocol.swift
//  
//
//  Created by Князьков Илья on 27.02.2022.
//

import class UIKit.UIView

protocol SecureContainerProtocol {
    
    var protectedView: UIView { get }
    var securedContent: UIView { get }
    
    init(securedContent: UIView)
    
    func enableProtect()
    func disableProtect()
    
}

extension SecureContainerProtocol {
    
    func enableProtect() {
        addDependenceOnProtectedLayer()
    }
    func disableProtect() {
        removeDependenceOnProtectedLayer()
    }

}

// MARK: - Private methods

private extension SecureContainerProtocol {
    
    func removeDependenceOnProtectedLayer() {
        protectedView.layer.sublayers?.first?.sublayers?.first { layer in
            self.protectedView.layer == layer
        }?.removeFromSuperlayer()
        
        securedContent.subviews.first { view in
            view == self.protectedView
        }?.removeFromSuperview()
        
        securedContent.layer.removeFromSuperlayer()
    }
    
    func addDependenceOnProtectedLayer() {
        securedContent.addSubview(protectedView)
        securedContent.superview?.layer.addSublayer(protectedView.layer)
        protectedView.layer.sublayers?.first?.addSublayer(securedContent.layer)
        protectedView.layer.frame = protectedView.bounds
    }

}
