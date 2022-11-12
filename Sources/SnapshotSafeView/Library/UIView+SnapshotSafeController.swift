//
//  UIView+SnapshotSafeController.swift
//  
//
//  Created by Илья Князьков on 10.11.2022.
//

import UIKit
import Foundation

public extension UIView {

    /// Wraps view in ``SnpashotSafeController`` with saving ``Auto Layout`` properties.
    /// But this is irreversible process and for much control use directly ``SnapshotSaveController`` instead.
    /// - Warning: May destroy layout of view!
    /**
     # Example
     ```swift
    let someView = UIView()

    someView.translatesAutoresizingMaskIntoConstraints = false
    someView.topAnchor.constraint(superView.topAnchor, constant: 12).isActive = true
    someView.setupAsHiddenFromScreenshot()
     ```
     */
    func setupAsHiddenFromSystemScreenshotsAndVideoRecordings() {
        guard
            let superview = self.superview,
            !HiddenContainerRecognizer().viewIsAlreadyInHiddenContainer(self)
        else {
            return
        }

        let alreadyUsedConstraints = copiedConstraints(from: self)
        let snapshotSafeController = ScreenshotProtectController(content: self)

        snapshotSafeController.setupContentAsHiddenInScreenshotMode()

        superview.addSubview(snapshotSafeController.container)
        snapshotSafeController.container.translatesAutoresizingMaskIntoConstraints = false

        alreadyUsedConstraints
            .fromRelationShip
            .map { constraint in
                generateConstraint(for: constraint.firstItem, to: snapshotSafeController.container, from: constraint)
            }
            .forEach(superview.addConstraint)

        alreadyUsedConstraints
            .toRelationship
            .map { constraint in
                generateConstraint(for: snapshotSafeController.container, to: constraint.secondItem, from: constraint)
            }
            .forEach(superview.addConstraint)
    }

}

private extension UIView {

    // MARK: - Nested Types

    struct Constraints {

        let toRelationship: [NSLayoutConstraint]
        let fromRelationShip: [NSLayoutConstraint]

        func insertedToRelatinshipConstraint(_ constraint: NSLayoutConstraint) -> Self {
            return Constraints(toRelationship: toRelationship + [constraint], fromRelationShip: fromRelationShip)
        }

        func insertedfromRelatinshipConstraint(_ constraint: NSLayoutConstraint) -> Self {
            return Constraints(toRelationship: toRelationship, fromRelationShip: fromRelationShip + [constraint])
        }

    }

    // MARK: - Private Methods

    func copiedConstraints(from view: UIView) -> Constraints {
        let constraints = Constraints(toRelationship: [], fromRelationShip: [])
        guard let superView = view.superview else {
            return constraints
        }

        return superView
            .constraints
            .reduce(constraints) { partialResult, constraint in
                if let firstItem = constraint.firstItem as? UIView, firstItem == view {
                    return partialResult.insertedToRelatinshipConstraint(constraint)
                } else if let secondItem = constraint.secondItem as? UIView, secondItem == view {
                    return partialResult.insertedfromRelatinshipConstraint(constraint)
                }
                return partialResult
            }
    }

    func generateConstraint(
        for forItem: Any?,
        to toItem: Any?,
        from constraint: NSLayoutConstraint
    ) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: forItem ?? Void(),
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: toItem,
            attribute: constraint.secondAttribute,
            multiplier: constraint.multiplier,
            constant: constraint.constant
        )
    }

}
