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

public enum MKAPopupViewAnimation: Int {
    case fade
    case slideUp
    case slideDown
    case slideLeft
    case slideRight
    case none
}

public class MKAPopupView: UIView {

    /// A title view. It is shown when a title is specified.
    public let titleLabel:    MKALabel
    /// A container of main content view.
    public let containerView: UIView

    init() {
        titleLabel = MKALabel()
        containerView = UIView()

        super.init(frame: .zero)

        addSubview(titleLabel)
        addSubview(containerView)

        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }

    override init(frame: CGRect) {
        fatalError("`init(frame:) is not implemented.")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("`init(coder:) is not implemented.")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if let title = titleLabel.text, !title.isEmpty {
            titleLabel.sizeToFit()
        }
        else {
            titleLabel.bounds = .zero
        }

        titleLabel.center = CGPoint(x: frame.width / 2.0, y: titleLabel.frame.height / 2.0)
        containerView.frame = CGRect(x: 0,
                                     y: titleLabel.frame.maxY,
                                     width: frame.width,
                                     height: frame.height - titleLabel.frame.maxY)
    }

    func beginShowingAnimation(_ animation: MKAPopupViewAnimation) {
        switch animation {
            case .fade:
                alpha = 0
            case .slideUp:
                transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            case .slideDown:
                transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
            case .slideLeft:
                transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            case .slideRight:
                transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            default:
                break
        }
    }

    func show(with animation: MKAPopupViewAnimation, duration: TimeInterval, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: duration, animations: { [weak self] () -> Void in
            if let weakSelf = self {
                switch animation {
                    case .fade:
                        weakSelf.alpha = 1.0
                    case .slideUp:
                        fallthrough
                    case .slideDown:
                        fallthrough
                    case .slideLeft:
                        fallthrough
                    case .slideRight:
                        weakSelf.transform = CGAffineTransform(translationX: 0, y: 0)
                    default:
                        break
                }
            }
        }, completion: completion)
    }

    func hide(with animation: MKAPopupViewAnimation, duration: TimeInterval, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: duration, animations: { [weak self] () -> Void in
            if let weakSelf = self {
                switch animation {
                    case .fade:
                        weakSelf.alpha = 0
                    case .slideUp:
                        weakSelf.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
                    case .slideDown:
                        weakSelf.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                    case .slideLeft:
                        weakSelf.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    case .slideRight:
                        weakSelf.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    default:
                        break
                }
            }
        }, completion: completion)
    }
}
