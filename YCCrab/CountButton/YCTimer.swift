//
//  YCTimer.swift
//  YCCrab
//
//  Created by Yaanco on 2021/3/18.
//

import UIKit


class YCTimer: NSObject {
    
    static var timers = [String: DispatchSourceTimer]()
    static let sem = DispatchSemaphore(value: 1)
    
    static func excuteTask(task: @escaping () -> Void, start: Double, interval: Double, async: Bool, repeats: Bool) -> String? {
        if start < 0 || (repeats && interval < 0) {
            return nil
        }
        
        let queue = async ? DispatchQueue.global() : DispatchQueue.main
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: DispatchTime(uptimeNanoseconds: UInt64(start) * NSEC_PER_SEC), repeating: interval, leeway: .seconds(0))
        sem.wait()
        let name = "\(timers.count)"
        timers[name] = timer
        sem.signal()
        timer.setEventHandler {
            task()
            if !repeats {
                cancelTask(name: name)
            }
        }
        timer.resume()
        return name
    }
    
    static func excuteTask(target: AnyObject, selector: Selector, start: Double, interval: Double, asyns: Bool, repeats: Bool) -> String? {
        return excuteTask(task: {
            if target.responds(to: selector) {
                let _ = target.perform(selector)
            }
        }, start: start, interval: interval, async: asyns, repeats: repeats)
    }
    
    static func cancelTask(name: String?) {
        if let name = name {
            sem.wait()
            let timer = timers[name]
            timer?.cancel()
            timers.removeValue(forKey: name)
            sem.signal()
        }
    }
    
}
