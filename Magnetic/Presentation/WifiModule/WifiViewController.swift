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
    private var wifiData: [WifiDataModel] = []

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = wifiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wifiView.setTableDelelagate(self)
        wifiView.setTable(self)
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
        super.viewWillDisappear(animated)
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
    }

    func setupBinding() {
//        wifiView.actionPublisher
//            .sink { [weak self] action in
//                switch action {
//                case let .selectedItem(data):
//                    let vc = DetailsViewController(deviceData: data)
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//            .store(in: &cancellables)

        model.networkDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.wifiData = data
                self?.wifiView.updateTable()//(data)
            }
            .store(in: &cancellables)
    }
}

// - MARK: private extension UITableViewDataSource
extension WifiViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wifiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WifiTableCell = tableView.dequeueReusableCell(for: indexPath)
        guard let model = wifiData[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setup(model)
        return cell
    }
}

// - MARK: private extension UITableViewDelegate
extension WifiViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        guard let data = wifiData[safe: didSelectRowAt.row] else {
            return
        }
        let deviceData = DeviceDataModel(connectionType: data.type,
                                         ipAddress: data.address,
                                         macAddress: data.macAddress,
                                         hostName: data.hostName,
                                         isConnected: data.isAvailable)
        let vc = DetailsViewController(deviceData: deviceData)
        self.navigationController?.pushViewController(vc, animated: true)
//        actionSubject.send(.selectedItem(deviceData))
    }
}

