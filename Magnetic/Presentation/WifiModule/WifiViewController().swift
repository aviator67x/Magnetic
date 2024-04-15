//
//  WifiViewController().swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import Foundation
import UIKit

final class WifiViewController: UIViewController {
    // - MARK: Private properties
    private let wifiView = WifiView()
    private let model = WifiViewModel()

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = wifiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        model.getNetData()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

// - MARK: private extension
private extension WifiViewController {
    func setupNavigationBar() {
        title = "Result"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationItem.backButtonTitle = ""
    }

    func setupBinding() {
        model.networkDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.wifiView.updateTable(data)
            }
            .store(in: &cancellables)
    }
}
