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
    var Description: String?
    var Location: String?
    var Location_suffix: String?
    var CompanyURL: String?
    
    var Image: URL?
    var Avatar: URL?
    
    @IBOutlet weak var RecruitmentTitleText: UITextView!
    @IBOutlet weak var Looking_forText: UITextView!
    @IBOutlet weak var CompanyNameText: UITextView!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var LocationText: UITextView!
    @IBOutlet weak var CompanyURLText: UITextView!
    
    @IBOutlet weak var AvatarImageView: UIImageView!
    @IBOutlet weak var CompanyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = CompanyName
        
        RecruitmentTitleText.text = Title
        Looking_forText.text = Looking_for
        CompanyNameText.text = CompanyName
        DescriptionText.text = Description
        
        DescriptionText.layer.borderColor = UIColor.blue.cgColor
        DescriptionText.layer.borderWidth = 1.2
        DescriptionText.layer.cornerRadius = 8.0
        DescriptionText.layer.masksToBounds = true
        
        AvatarImageView.loadImageAsynchronously(url: Avatar)
        CompanyImageView.loadImageAsynchronously(url: Image)
        
        LocationText.text = Location
        // LocationText.text = Location_suffix
        CompanyURLText.text = CompanyURL
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
