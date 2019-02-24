//
//  TopViewController.swift
//  Wantedly-iOS-Work
//
//  Created by 小幡 十矛 on 2019/02/23.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopViewController: UIViewController {

    var APIDataList: [[String: String?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getAPIData()
        
    }
    
    func getAPIData() {
        
        let _ = Alamofire.request("https://www.wantedly.com/api/v1/projects?q=swift&page=1").responseJSON {
            response in guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            
            // JSONのdataオブジェクトを取り出す
            let dataObject = json["data"]
            
            dataObject.forEach {(key, dataObject) in
                let APIData: [String: String?] = [
                    "title": dataObject["title"].string,
                    "looking_for": dataObject["looking_for"].string,
                    "companyName": dataObject["company"]["name"].string
                    ]
                 self.APIDataList.append(APIData)
            }
             print(self.APIDataList)
            
        }
        
    }
    
}
