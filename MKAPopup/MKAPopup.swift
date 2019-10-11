//
// MKAPopup
//
// Copyright (c) 2019-present Hituzi Ando. All rights reserved.
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

public class MKAPopup: UIView {

    /// A popup view.
    public let popupView: MKAPopupView

    /// A delegate.
    public weak var delegate: MKAPopupDelegate?
    /// Tells whether a user can hide a popup when touches up outside it.
    public var canHideWhenTouchUpOutside = true
    /// An animation type for showing a popup.
    public var showingAnimation          = MKAPopupViewAnimation.fade
    /// An animation type for hiding a popup.
    public var hidingAnimation           = MKAPopupViewAnimation.fade
    /// An animation duration.
    public var duration:    TimeInterval = 0.3
    /// Returns true if a popup is shown, otherwise false.
    public var isShowing:   Bool {
        superview != nil
    }

    /// A popup view's size.
    public var popupSize:   CGSize {
        get {
            return popupView.bounds.size
        }
        set {
            let screenSize = UIScreen.main.bounds.size
            let width      = newValue.width < screenSize.width ? newValue.width : screenSize.width
            let height     = newValue.height < screenSize.height ? newValue.height : screenSize.height
            popupView.bounds.size = CGSize(width: width, height: height)
        }
    }

    /// Main content view.
    public var contentView: UIView? {
        return popupView.containerView.subviews.first
    }

    /// Creates an instance with a content view.
    ///
    /// - Parameters:
    ///   - contentView: Main content view.
    /// - Returns: An instance.
    public init(contentView: UIView) {
        popupView = MKAPopupView()

        super.init(frame: UIScreen.main.bounds)

        addSubview(popupView)

        backgroundColor = UIColor.black.withAlphaComponent(0.4)

        popupView.frame = CGRect(x: 0, y: 0, width: 300.0, height: 400.0)
        popupView.containerView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        popupView.containerView.addConstraints([
                                                   NSLayoutConstraint(item: contentView,
                                                                      attribute: .left,
                                                                      relatedBy: .equal,
                                                                      toItem: popupView.containerView,
                                                                      attribute: .left,
                                                                      multiplier: 1.0,
                                                                      constant: 0),
                                                   NSLayoutConstraint(item: contentView,
                                                                      attribute: .top,
                                                                      relatedBy: .equal,
                                                                      toItem: popupView.containerView,
                                                                      attribute: .top,
                                                                      multiplier: 1.0,
                                                                      constant: 0),
                                                   NSLayoutConstraint(item: contentView,
                                                                      attribute: .right,
                                                                      relatedBy: .equal,
                                                                      toItem: popupView.containerView,
                                                                      attribute: .right,
                                                                      multiplier: 1.0,
                                                                      constant: 0),
                                                   NSLayoutConstraint(item: contentView,
                                                                      attribute: .bottom,
                                                                      relatedBy: .equal,
                                                                      toItem: popupView.containerView,
                                                                      attribute: .bottom,
                                                                      multiplier: 1.0,
                                                                      constant: 0),
                                               ])
    }

    /// Not implemented.
    override init(frame: CGRect) {
        fatalError("Uses `init(contentView:)` instead of `init(frame:)`.")
    }

    /// Not implemented.
    required init?(coder aDecoder: NSCoder) {
        fatalError("Uses `init(contentView:)` instead of `init(coder:)`.")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        popupView.center = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let isBackgroundTouched = touches.first!.view == self

        if isBackgroundTouched && canHideWhenTouchUpOutside {
            hide()
        }
    }

    // MARK: public method

    /// Shows a popup using the set animation type and duration.
    public func show() {
        show(withAnimation: showingAnimation)
    }

    /// Shows a popup using given animation type and the set duration.
    ///
    /// - Parameters:
    ///   - animation: An animation to show a popup.
    public func show(withAnimation animation: MKAPopupViewAnimation) {
        show(withAnimation: animation, duration: duration)
    }

    /// Shows a popup using given animation type and duration.
    ///
    /// - Parameters:
    ///   - animation: An animation to show a popup.
    ///   - duration: An animation duration.
    public func show(withAnimation animation: MKAPopupViewAnimation, duration: TimeInterval) {
        if isShowing { return }

        delegate?.popupWillAppear(self)

        alpha = 0
        popupView.beginShowingAnimation(animation)

        UIApplication.shared.keyWindow?.subviews.last?.addSubview(self)

        UIView.animate(withDuration: 0.3) { [weak self] in
            if let weakSelf = self { weakSelf.alpha = 1.0 }
        }

        popupView.show(with: animation, duration: duration) { [weak self] finished in
            if let weakSelf = self { weakSelf.delegate?.popupDidAppear(weakSelf) }
        }
    }

    /// Hides a popup using the set animation type and duration.
    public func hide() {
        hide(with: hidingAnimation)
    }

    /// Hides a popup using given animation type and the set duration.
    ///
    /// - Parameters:
    ///   - animation: An animation to hide a popup.
    public func hide(with animation: MKAPopupViewAnimation) {
        hide(with: animation, duration: duration)
    }

    /// Hides a popup using given animation type and duration.
    ///
    /// - Parameters:
    ///   - animation: An animation to hide a popup.
    ///   - duration: An animation duration.
    public func hide(with animation: MKAPopupViewAnimation, duration: TimeInterval) {
        if !isShowing { return }

        delegate?.popupWillDisappear(self)

        UIView.animate(withDuration: 0.3) { [weak self] in
            if let weakSelf = self { weakSelf.alpha = 0 }
        }

        popupView.hide(with: animation, duration: duration) { [weak self] finished in
            if let weakSelf = self {
                weakSelf.removeFromSuperview()

                weakSelf.delegate?.popupDidDisappear(weakSelf)
            }
        }
    }
}

public protocol MKAPopupDelegate: class {

    func popupWillAppear(_ popup: MKAPopup)
    func popupDidAppear(_ popup: MKAPopup)
    func popupWillDisappear(_ popup: MKAPopup)
    func popupDidDisappear(_ popup: MKAPopup)
}

extension MKAPopupDelegate {

    public func popupWillAppear(_ popup: MKAPopup) {
    }

    public func popupDidAppear(_ popup: MKAPopup) {
    }

    public func popupWillDisappear(_ popup: MKAPopup) {
    }

    public func popupDidDisappear(_ popup: MKAPopup) {
    }
}
