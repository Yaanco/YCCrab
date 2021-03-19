//
//  HomeVC.swift
//  YCCrab
//
//  Created by Yaanco on 2021/3/18.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _config()
        _layout()
    }
    
    private func _config() {
        view.addSubview(countBtn)
    }
    
    private func _layout() {
        countBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func countBtnAction(_ sender: CountDownButton) {
        sender.countDown(time: 60)
    }
    
    // MARK: - getter
    lazy var countBtn: CountDownButton = {
        let btn = CountDownButton(type: .custom)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor.blue.withAlphaComponent(0.7), for: .normal)
        btn.addTarget(self, action: #selector(countBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    
}
