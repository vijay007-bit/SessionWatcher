//
//  CustomApplication.swift
//  SessionWatcher
//
//  Created by Vijay Singh on 20/07/23.
//

import Foundation
import UIKit

class SessionWatcher: UIApplication{
    
    private var inactivityWatcher: Timer?
    private var screenSaverTime: TimeInterval {
        return 60
    }
    
    override init() {
        super.init()
        self.resetTimer()
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                currentWindow?.rootViewController?.dismiss(animated: false)
                self.resetTimer()
            }
        }
    }
    
    // reset the timer because there was user event
    private func resetTimer() {
        if let inactivityWatcher = inactivityWatcher {
            inactivityWatcher.invalidate()
        }
        
        inactivityWatcher = Timer.scheduledTimer(timeInterval: screenSaverTime,target: self,selector: #selector(SessionWatcher.showScreenSaver),userInfo: nil,repeats: false)
    }
    
    @objc private func showScreenSaver() {
        //Present screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowScreenSaverViewController")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        currentWindow?.rootViewController?.present(vc, animated: false)
       
    }
}

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}
