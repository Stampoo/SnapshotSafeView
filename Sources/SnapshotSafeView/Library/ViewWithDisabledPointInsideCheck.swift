//
//  ViewWithDisabledPointInsideCheck.swift
//  
//
//  Created by Илья Князьков on 21.02.2023.
//

import UIKit

final class ViewWithDisabledPointInsideCheck: UIView {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }

}
