//
//  WifiViewController().swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import UIKit
import Combine

final class WifiViewController: UIViewController {
    
    // - MARK: Private properties
    private let magneticView = WifiView()
    private let model = WifiViewModel()

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = magneticView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Result"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setupBinding()
    }
}

// - MARK: private extension
private extension WifiViewController {
    func setupBinding() {
//        model
    }
}
