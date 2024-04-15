//
//  DetailsViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import Combine
import Foundation
import UIKit

final class DetailsViewController: UIViewController {
    // - MARK: Private properties
    private let detailsView = DetailsView(deviceData: DeviceDataModel(connectionType: "expample1", ipAddress: "expample2", macAddress: "expample3", hostName: "expample4"), frame: .zero)
//    private let model = DetailsViewModel()

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
private extension DetailsViewController {
    func setupNavigationBar() {
        title = "Device Details"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationItem.backButtonTitle = ""
    }
}
