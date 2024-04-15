//
//  BackButtonSettable.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import UIKit

protocol BackButtonSettupable: AnyObject {
    func setupBackButton(action: @escaping UIActionHandler)
}

extension BackButtonSettupable where Self: UIViewController {
    func setupBackButton(action: @escaping UIActionHandler) {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "chevron.left")//Asset.Images.arrowBack.image
        button.setImage(buttonImage, for: .normal)

        button.addAction(UIAction(handler: action), for: .touchUpInside)

        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
