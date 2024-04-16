//
//  DetailsView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import Foundation
import SnapKit
import UIKit

final class DetailsView: UIView {
    // - MARK: Views
    private let headerImageView = UIImageView()
    private let attentionImageView = UIImageView()
    private let backgroundView = UIView()
    private let cameraLabel = UILabel()
    private let addressLabel = UILabel()
    private var connectionView = DetailedView(name: "", value: "")
    private var ipView = DetailedView(name: "", value: "")
    private var mackView = DetailedView(name: "", value: "")
    private var hostView = DetailedView(name: "", value: "")
    
    // - MARK: Private properties
    private let screenSize: CGRect = UIScreen.main.bounds
    private var deviceData: DeviceDataModel
    private var ipAddress: String = ""
    private var isConnected: Bool = false
    
    // - MARK: Lifecycle
    init(deviceData: DeviceDataModel) {
        self.deviceData = deviceData
        self.isConnected = deviceData.isConnected
        self.ipAddress = deviceData.ipAddress
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension DetailsView {
    func setupViews() {
        backgroundColor = .black
        
        headerImageView.image = UIImage(named: "detailsHeader")
        
        attentionImageView.image = isConnected ? UIImage(named: "attentionPositiv") : UIImage(named: "attentionNegativ")
        
        backgroundView.backgroundColor = UIColor(named: "tableBackground")
        backgroundView.layer.cornerRadius = 8
        
        cameraLabel.text = "Camera"
        cameraLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        cameraLabel.textColor = UIColor(named: "purple")
        
        addressLabel.text = ipAddress
        addressLabel.font = UIFont.systemFont(ofSize: 15)
        addressLabel.textColor = .white
        
        connectionView = DetailedView(name: "Connection Type", value: deviceData.connectionType)
        
        ipView = DetailedView(name: "IP Address", value: deviceData.ipAddress)
        
        mackView = DetailedView(name: "MAC Address", value: deviceData.macAddress)
        
        hostView = DetailedView(name: "Hostname", value: deviceData.hostName)
    }
    
    func setupLayout() {
        addSubview(headerImageView) {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.screenSize.width / 1.2)
        }
        
        addSubview(attentionImageView) {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(headerImageView.snp.centerY).offset(20)
            $0.size.equalTo(self.screenSize.width / 3)
        }
        
        addSubview(backgroundView) {
            $0.top.equalTo(headerImageView.snp.bottom).offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(270)
        }
        
        addSubview(cameraLabel) {
            $0.top.equalTo(headerImageView.snp.bottom).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(addressLabel) {
            $0.top.equalTo(cameraLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(connectionView) {
            $0.top.equalTo(addressLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        let separatorOne = separator()
        addSubview(separatorOne) {
            $0.top.equalTo(connectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
        
        addSubview(ipView) {
            $0.top.equalTo(connectionView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        let separatorTwo = separator()
        addSubview(separatorTwo) {
            $0.top.equalTo(ipView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
        
        addSubview(mackView) {
            $0.top.equalTo(ipView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        let separatorThree = separator()
        addSubview(separatorThree) {
            $0.top.equalTo(mackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
        
        addSubview(hostView) {
            $0.top.equalTo(mackView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func separator() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        separatorView.alpha = 0.5
        return separatorView
    }
}
