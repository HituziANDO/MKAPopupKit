//
//  ViewController.swift
//  MKAPopupSample
//
//  Created by Masaki Ando on 2019/03/14.
//  Copyright © 2019年 Hituzi Ando. All rights reserved.
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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKAPopupDelegate {

    @IBOutlet weak var tableView: UITableView!
    private let        popupList = ["Text Content View Popup",
                                    "Web Content View Popup",
                                    "Image Content View Popup",
                                    "Fade Animation Sample",
                                    "Slide Up Animation Sample",
                                    "Slide Down Animation Sample",
                                    "Slide Left Animation Sample",
                                    "Slide Right Animation Sample"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
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
            default:
                break
        }
    }

    // MARK: MKAPopupDelegate

    func popupDidAppear(_ popup: MKAPopup) {
        print("Popup(tag:\(popup.tag)) did appear!")
    }

    func popupDidDisappear(_ popup: MKAPopup) {
        print("Popup(tag:\(popup.tag)) did disappear!")
    }

    // MARK: private method

    private func createTextContentPopup() -> MKAPopup {
        // Creates your content view.
        let contentView = TextContentView.fromNib(name: String(describing: TextContentView.self))
        // Creates a popup using your content view.
        let popup       = MKAPopup(contentView: contentView)
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

    private func createWebContentPopup() -> MKAPopup {
        let contentView = WebContentView.fromNib(name: String(describing: WebContentView.self))
        let popup       = MKAPopup(contentView: contentView)
        contentView.webView.load(URLRequest(url: URL(string: "https://github.com/HituziANDO")!))
        popup.popupSize = CGSize(width: 320.0, height: 600.0)
        popup.delegate = self

        return popup
    }

    private func createImageContentPopup() -> MKAPopup {
        let contentView = ImageContentView.fromNib(name: String(describing: ImageContentView.self))
        let popup       = MKAPopup(contentView: contentView)
        popup.delegate = self

        contentView.click = { popup.hide() }

        return popup
    }
}
