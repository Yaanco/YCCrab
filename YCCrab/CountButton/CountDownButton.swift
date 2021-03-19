//
//  CountDownButton.swift
//  YCCrab
//
//  Created by Yaanco on 2021/3/19.
//

import UIKit

class CountDownButton: UIButton {
    
    var time: UInt = 0
    var name: String?

    func countDown(time: UInt) {
        isEnabled = false
        self.time = time
        name = YCTimer.excuteTask(target: self, selector: #selector(countDownAction), start: 0, interval: 1, asyns: false, repeats: true)
    }
    
    @objc func countDownAction() {
        if time == 0 {
            _configEnabled("重新发送")
            
        } else {
            setTitle("\(time)s后重发", for: .normal)
            setTitleColor(UIColor.lightGray, for: .normal)
            time -= 1
        }
    }
    
    func resetBtn() {
        _configEnabled("获取验证码")
    }
    
    func _configEnabled(_ title: String) {
        YCTimer.cancelTask(name: name)
        isEnabled = true
        setTitle(title, for: .normal)
        setTitleColor(UIColor.blue.withAlphaComponent(0.7), for: .normal)
    }

}
