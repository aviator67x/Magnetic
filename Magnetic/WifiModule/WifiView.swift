//
//  WifiView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import SnapKit
import UIKit

final class WifiView: UIView {
    // - MARK: Views
    private let numberLabel = UILabel()
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    
    // - MARK: Private properties
    private var wifiData = [WifiDataModel]()
    
    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension WifiView {
    func setupViews() {
        backgroundColor = .cyan
        numberLabel.text = "5"
        numberLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        numberLabel.textColor = UIColor(named: "purple")
        
        titleLabel.text = "Devices"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        tableView.dataSource = self
        tableView.register(WifiTableCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(named: "tableBackground")
    }
    
    func setupLayout() {
        addSubview(numberLabel) {
            $0.centerX.equalToSuperview().offset(-50)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            $0.height.equalTo(25)
        }
        
        addSubview(titleLabel) {
            $0.centerY.equalTo(numberLabel.snp.centerY)
            $0.leading.equalTo(numberLabel.snp.trailing)
            $0.height.equalTo(25)
        }
        
        addSubview(tableView) {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// - MARK: private extension
extension WifiView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wifiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WifiTableCell = tableView.dequeueReusableCell(for: indexPath)
        let model = wifiData[indexPath.row]
        cell.setup(model)
        return cell
    }
}
