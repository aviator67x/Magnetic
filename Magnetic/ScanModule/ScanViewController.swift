//
//  ScanViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import UIKit

final class ScanViewController: UIViewController {
    // - MARK: Private properties
    private let scanView = ScanView()
//    private let model = ScanViewModel()

    private var cancellables = Set<AnyCancellable>()

//    private var timer: Timer?

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = scanView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
//        setupBinding()
    }
}

// - MARK: private extension
private extension ScanViewController {
    func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
