//
//  OnboardingViewController.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showMaster", sender: nil)
            }
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* create a conditional statement that will check the value of the status returned in the completion closure of the getAuthorizationStatus function.
        
        If the user has already authorized local notifications, then perform the manual segue to send them straight to the table view controller
 */
        
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .denied {
                NSLog("User denied authorization access")
            } else if status == .notDetermined {
                NSLog("User authorization status is undetermined")
            } else if status == .authorized {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showMaster", sender: nil)
                }
            }
        }
    }

}
