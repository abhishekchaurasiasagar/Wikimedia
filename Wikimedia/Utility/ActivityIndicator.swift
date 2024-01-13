//
//  ActivityIndicator.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation
import UIKit

@IBDesignable
class SpinnerView : UIView {

    var strokeColor : UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    init(frame:  CGRect, color : UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
        super.init(frame: frame)
        self.strokeColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = self.frame.width * 0.1 > 2.5 ? 2 : self.frame.width * 0.1
        setPath()
    }

    override func didMoveToWindow() {
        animate()
    }

    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }

    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }

    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.8),
                Pose(0.4, 0.500, 0.5),
                Pose(0.4, 1.000, 0.3),
                Pose(0.4, 1.500, 0.15),
                Pose(0.4, 1.875, 0.15),
                Pose(0.4, 2.250, 0.3),
                Pose(0.4, 2.625, 0.5),
                Pose(0.4, 3.000, 0.8),
            ]
        }
    }

    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()

        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }

        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])

        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)

    }

    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}

extension UIView {

    struct LoaderAssociatedKeys {
        static var stateKey: UInt8 = 0
    }

    var loaderCount: Int {
        get {
            guard let value = objc_getAssociatedObject(self, &LoaderAssociatedKeys.stateKey) as? Int else {
                return 0
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &LoaderAssociatedKeys.stateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

final class LoaderContainer: UIView {

    static func showHUDAddedTo(view: UIView,color : UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)) {
        DispatchQueue.main.async {
            let hud = self.hudForView(view: view)
            if (hud != nil) {
               // already there in stack
            } else {
                let applicationFrame = view.bounds
                let hud = LoaderContainer.init(frame:  applicationFrame)
                let loader = SpinnerView.init(frame:  CGRect(x: 0, y: 0, width: applicationFrame.width > 66 ? 40 : applicationFrame.width  , height: applicationFrame.width > 66 ? 40 : applicationFrame.width), color: color)
                loader.center = hud.center
                hud.addSubview(loader)

                view.addSubview(hud)
            }

        }

    }

    static func hideHUDForView(view: UIView) {
        DispatchQueue.main.async {
        let hud = self.hudForView(view: view)
        if (hud != nil) {
            DispatchQueue.main.async {
                hud!.removeFromSuperview()
            }
        }
        }
    }

    static func hudForView(view: UIView) -> LoaderContainer? {
        let subviewsEnum = view.subviews.reversed()
        for subview in subviewsEnum {
            if subview.isKind(of: LoaderContainer.self) {
                return subview as? LoaderContainer
            }
        }
        return nil;
    }

    static func incrementLoaderCount(view: UIView, color : UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)) {
        let count = currentLoaderCount(view: view) + 1
        view.loaderCount = count
        refreshLoaderCount(view: view, color : color)

    }

    static func decrementLoaderCount(view: UIView) {
        let count = currentLoaderCount(view: view)
        if count > 0 {
            view.loaderCount = count - 1
        }
        refreshLoaderCount(view: view)
    }

    static func refreshLoaderCount(view: UIView,color : UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)) {
        let count = currentLoaderCount(view: view)
        if count <= 0 {
            hideHUDForView(view: view)
        }
        else {
            showHUDAddedTo(view: view, color : color)
        }
    }

    static func currentLoaderCount(view: UIView) -> Int {
        return view.loaderCount
    }

    static func resetLoaderCount(view: UIView) {
        view.loaderCount = 0
        refreshLoaderCount(view: view)
    }
}

final class BALoader  {

    static func show(currentViewController : UIViewController, color : UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))  {
        DispatchQueue.main.async {
        LoaderContainer.incrementLoaderCount(view: currentViewController.view, color: color)
        }
    }

    static func show(currentView: UIView, color : UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))  {
        DispatchQueue.main.async {
        LoaderContainer.incrementLoaderCount(view: currentView, color : color)
        }
    }

    static func dismiss(currentView: UIView) {
        DispatchQueue.main.async {
        LoaderContainer.decrementLoaderCount(view: currentView)
        }
    }

    static func dismiss(currentViewController : UIViewController) {
        DispatchQueue.main.async {
            LoaderContainer.decrementLoaderCount(view: currentViewController.view)
        }
    }

    static func isHUDVisible(currentViewController : UIViewController) -> Bool {
        return LoaderContainer.currentLoaderCount(view: currentViewController.view) > 0
    }
    static func setDefaultMaskType(_ colour : UIColor = .clear){
//        bgView.backgroundColor = colour
//        bgView.alpha = 0.5
    }
    static func resetLoaderCount(currentViewController : UIViewController) {
        DispatchQueue.main.async {
            LoaderContainer.resetLoaderCount(view: currentViewController.view)
        }
    }

}

