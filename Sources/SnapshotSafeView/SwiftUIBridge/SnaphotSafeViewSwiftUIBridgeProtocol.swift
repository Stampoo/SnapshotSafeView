//
//  SnaphotSafeViewSwiftUIBridgeProtocol.swift
//  
//
//  Created by Илья Князьков on 10.09.2022.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
protocol SnaphotSafeViewSwiftUIBridgeProtocol {

    associatedtype ProtectedView: View

    func hiddenFromSystemSnaphot() -> ProtectedView
    
}
#endif
