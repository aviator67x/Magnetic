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
    private let detailsView: DetailsView

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    init(deviceData: DeviceDataModel) {
        self.detailsView = DetailsView(deviceData: deviceData)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        super.viewWillDisappear(animated)
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

        let myimage = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(buttonAction))
    }

    @objc
    func buttonAction() {
        navigationController?.popViewController(animated: true)
    }
}
