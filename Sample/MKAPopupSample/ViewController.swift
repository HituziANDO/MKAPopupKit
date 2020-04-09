//
// MKAPopupKit
//
// Copyright (c) 2020-present Hituzi Ando. All rights reserved.
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

import MKAPopupKit

extension UIView {

    static func fromNib(name: String) -> Self {
        return instantiate(nibName: name, bundle: Bundle.main)
    }

    private static func instantiate<T: UIView>(nibName: String, bundle: Bundle) -> T {
        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? T else {
            fatalError("\(nibName).nib is not found.")
        }

        return view
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var toastForever: MKAToast?
    private let popupList = ["Text Content View Popup",
                             "Web Content View Popup",
                             "Image Content View Popup",
                             "Fade Animation Sample",
                             "Slide Up Animation Sample",
                             "Slide Down Animation Sample",
                             "Slide Left Animation Sample",
                             "Slide Right Animation Sample",
                             "Toast Sample1",
                             "Toast Sample2",
                             "Toast Sample3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Create the cache of the style.
        let config = MKAToastStyleConfiguration()
        config.height = 64.0
        config.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        config.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        MKAToast.add(styleConfiguration: config, forKey: "Success")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popupList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = popupList[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        switch indexPath.row {
            case 0:
                let popup = createTextContentPopup()
                popup.tag = 0
                popup.show()
            case 1:
                let popup = createWebContentPopup()
                popup.tag = 1
                popup.show()
            case 2:
                let popup = createImageContentPopup()
                popup.tag = 2
                popup.show()
            case 3:
                let popup = createImageContentPopup()
                popup.showingAnimation = .fade
                popup.hidingAnimation = .fade
                popup.duration = 0.3
                popup.tag = 3
                popup.show()
            case 4:
                let popup = createImageContentPopup()
                popup.showingAnimation = .slideUp
                popup.hidingAnimation = .slideDown
                popup.duration = 0.5
                popup.tag = 4
                popup.show()
            case 5:
                let popup = createImageContentPopup()
                popup.showingAnimation = .slideDown
                popup.hidingAnimation = .slideUp
                popup.duration = 0.5
                popup.tag = 5
                popup.show()
            case 6:
                let popup = createImageContentPopup()
                popup.showingAnimation = .slideLeft
                popup.hidingAnimation = .slideRight
                popup.duration = 0.4
                popup.tag = 6
                popup.show()
            case 7:
                let popup = createImageContentPopup()
                popup.showingAnimation = .slideRight
                popup.hidingAnimation = .slideLeft
                popup.duration = 0.4
                popup.tag = 7
                popup.show()
            case 8:
                // Most simple usage of MKAToast.
                MKAToast("Display short message!").show()
            case 9:
                // Customize the toast view and show it.
                let config = MKAToastStyleConfiguration()
                config.width = 320.0
                config.height = 56.0
                config.backgroundColor = UIColor.red.withAlphaComponent(0.9)
                config.textColor = .black
                config.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
                MKAToast("Something error occurred!", style: config)
                    .withDelegate(self)
                    .withTag(1)
                    .withTime(MKAToastTimeLong)
                    .withAnimationDuration(0.5)
                    .withDelay(0.5)
                    .show(at: view.center)
            case 10:
                if let isShowing = toastForever?.isShowing, isShowing {
                    toastForever?.hide()
                    return
                }
                // Create the toast view using cached style.
                toastForever = MKAToast("Success!", forKey: "Success")
                    .withDelegate(self)
                    .withTag(2)
                    .withTime(MKAToastTimeForever)
                // Show the toast view forever (until `hide()` method is called).
                toastForever?.show()
            default:
                break
        }
    }
}

// MARK: MKAPopupDelegate
extension ViewController: MKAPopupDelegate {

    func popupDidAppear(_ popup: MKAPopup) {
        print("Popup(tag:\(popup.tag)) did appear!")
    }

    func popupDidDisappear(_ popup: MKAPopup) {
        print("Popup(tag:\(popup.tag)) did disappear!")
    }
}

// MARK: MKAToastDelegate
extension ViewController: MKAToastDelegate {

    func toastWillAppear(_ toast: MKAToast) {
        print("Toast(tag:\(toast.tag) will appear!")
    }

    func toastDidAppear(_ toast: MKAToast) {
        print("Toast(tag:\(toast.tag) did appear!")
    }

    func toastWillDisappear(_ toast: MKAToast) {
        print("Toast(tag:\(toast.tag) will disappear!")
    }

    func toastDidDisappear(_ toast: MKAToast) {
        print("Toast(tag:\(toast.tag) did disappear!")
    }
}

// MARK: private method
private extension ViewController {

    func createTextContentPopup() -> MKAPopup {
        // Creates your content view.
        let contentView = TextContentView.fromNib(name: String(describing: TextContentView.self))
        // Creates a popup using your content view.
        let popup = MKAPopup(contentView: contentView)
        // Title (default is nil)
        popup.popupView.titleLabel.text = "About Swift"
        // Title Text Color (default is system default color)
        popup.popupView.titleLabel.textColor = .white
        // Title Font (default is system default font)
        popup.popupView.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        // Title Text Padding (default is (16, 16, 16, 16))
        popup.popupView.titleLabel.padding = UIEdgeInsets(top: 24.0, left: 16.0, bottom: 24.0, right: 16.0)
        // Popup Background Color (default is white)
        popup.popupView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)
        // Popup Corner Radius (default is 5)
        popup.popupView.layer.cornerRadius = 20.0
        // Popup Size (default is (300, 400))
        popup.popupSize = CGSize(width: 320.0, height: 480.0)
        // Overlay Color (default is black with alpha=0.4)
        popup.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // Can hide when a user touches up outside a popup (default is true)
        popup.canHideWhenTouchUpOutside = false
        // Showing Animation (default is fade)
        popup.showingAnimation = .fade
        // Hiding Animation (default is fade)
        popup.hidingAnimation = .fade
        // Animation Duration (default is 0.3)
        popup.duration = 0.3
        // Delegate
        popup.delegate = self

        contentView.click = { popup.hide() }

        return popup
    }

    func createWebContentPopup() -> MKAPopup {
        let contentView = WebContentView.fromNib(name: String(describing: WebContentView.self))
        let popup = MKAPopup(contentView: contentView)
        contentView.webView.load(URLRequest(url: URL(string: "https://github.com/HituziANDO")!))
        popup.popupSize = CGSize(width: 320.0, height: 600.0)
        popup.delegate = self

        return popup
    }

    func createImageContentPopup() -> MKAPopup {
        let contentView = ImageContentView.fromNib(name: String(describing: ImageContentView.self))
        let popup = MKAPopup(contentView: contentView)
        popup.delegate = self

        contentView.click = { popup.hide() }

        return popup
    }
}
