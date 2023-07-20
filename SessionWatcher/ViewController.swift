//
//  ViewController.swift
//  SessionWatcher
//
//  Created by Vijay Singh on 20/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

