//
//  DetailViewController.swift
//  Wantedly-iOS-Work
//
//  Created by 小幡 十矛 on 2019/02/27.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var Title: String?
    var Looking_for: String?
    var CompanyName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Title")
        print(Title)
        print("Looking_for")
        print(Looking_for)
        print("CompanyName")
        print(CompanyName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
