//
//  SmoothedView.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/02.
//

import UIKit

final class SmoothedView: UIView {

    var cornerRadius: CGFloat = 15.0

    private lazy var maskLayer: CAShapeLayer = {
        self.layer.mask = $0
        return $0
    }(CAShapeLayer())

    override var bounds: CGRect {
        set {
            super.bounds = newValue
            // Update the frame of the mask with the new bounds
            maskLayer.frame = newValue
            // Update the path of the mask with the new bounds
            let newPath = UIBezierPath(roundedRect: newValue, cornerRadius: cornerRadius).cgPath
            // If the bounds change is animated, copy the animation to mimic the timings
            if let animation = self.layer.animation(forKey: "bounds.size")?.copy() as? CABasicAnimation {
                animation.keyPath = "path"
                animation.fromValue = maskLayer.path
                animation.toValue = newPath
                maskLayer.path = newPath
                maskLayer.add(animation, forKey: "path")
            } else {
                maskLayer.path = newPath
            }
        }
        get { return super.bounds }
    }

}
