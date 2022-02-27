//
//  SnapshotSafeProtocol.swift
//  
//
//  Created by Князьков Илья on 27.02.2022.
//

import UIKit

protocol SnapshotSafeProtocol {
    
    associatedtype SafeContent: UIView
    
    var content: SafeContent { get set }
    
    func setupAsHiddenFromSnapshots()
    func setupAsVisibleInSnapshots()
    
}
