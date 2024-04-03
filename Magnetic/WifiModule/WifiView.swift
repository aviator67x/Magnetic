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
    private let nameLabel = UILabel()
    private let tableView = UITableView()
    
    // - MARK: Private properties
    private var wifiData: [WifiDataModel] = []
    
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
    
    func updateTable(_ data: [WifiDataModel]) {
        wifiData  = data
        tableView.reloadData()
    }
}

// - MARK: private extension
private extension WifiView {
    func setupViews() {
        backgroundColor = .black
        
        numberLabel.text = "5"
        numberLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        numberLabel.textColor = UIColor(named: "purple")
        
        titleLabel.text = "Devices"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        
        nameLabel.text = "WIFI_Name"
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.alpha = 0.5
        
        tableView.dataSource = self
        tableView.register(WifiTableCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(named: "tableBackground")
        tableView.separatorColor = .gray
        tableView.separatorStyle = .singleLine
        
    }
    
    func setupLayout() {
        addSubview(numberLabel) {
            $0.centerX.equalToSuperview().offset(-50)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            $0.height.equalTo(25)
        }
        
        addSubview(titleLabel) {
            $0.centerY.equalTo(numberLabel.snp.centerY)
            $0.leading.equalTo(numberLabel.snp.trailing).offset(5)
            $0.height.equalTo(25)
        }
        
        addSubview(nameLabel) {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(numberLabel.snp.bottom).offset(5)
        }
        
        addSubview(tableView) {
            $0.top.equalTo(nameLabel.snp.bottom).offset(25)
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
