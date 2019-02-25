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

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table:UITableView!
    
    var APIDataList: [[String: String?]] = []
    var APIDataCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getAPIData()
        print("viewDidLoad")
        print(APIDataCount)
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
                    "companyName": dataObject["company"]["name"].string,
                    "image": dataObject["image"]["i_320_131"].string,
                    "avatar": dataObject["avatar"]["s_30"].string
                    ]
                self.APIDataList.append(APIData)
                self.APIDataCount = self.APIDataList.count
                
            }
            // JSONデータをViewに反映する
            self.table.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView  section内")
        print(self.APIDataCount)
        return self.APIDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableView内")
        print(self.APIDataCount)
        let cell = table.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let label1 = cell.viewWithTag(1)as! UILabel
        let label2 = cell.viewWithTag(2)as! UILabel
        let label4 = cell.viewWithTag(4)as! UILabel
//        label1.text = "募集タイトル"
//        label2.text = "募集ポジション"
//        label4.text = "会社名"
        
        if APIDataList != [] {
            
            let article = APIDataList[indexPath.row]

            print("title")
            print(self.APIDataList[0]["title"])
            label1.text = article["title"]!
            label2.text = article["looking_for"]!
            label4.text = article["companyName"]!
            
        }
        
        
        return cell
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
}
