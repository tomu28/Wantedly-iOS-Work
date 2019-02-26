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
import AlamofireImage

var APIDataList: [[String: String?]] = []
var article: [[String: String?]] = []

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var table:UITableView!
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var APIDataCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getAPIData()
        print("viewDidLoad")
        print(APIDataCount)
        
        SearchBar.delegate = self as? UISearchBarDelegate
        
        //tapされた時の動作を宣言する: 一度タップされたらキーボードを隠す
        let hideTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)

    }
    
    func getAPIData() {
        
        let _ = Alamofire.request("https://www.wantedly.com/api/v1/projects?").responseJSON {
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
                    "avatar": dataObject["company"]["avatar"]["s_50"].string
                    ]
                APIDataList.append(APIData)
                self.APIDataCount = APIDataList.count
                
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
        let label5 = cell.viewWithTag(5)as! UIImageView
//        label1.text = "募集タイトル"
//        label2.text = "募集ポジション"

//        label4.text = "会社名"
//        label5.image = UIImage(named: "Label5")
        
        
        // label1~4を表示
        if APIDataList != [] {
            
            let article = APIDataList[indexPath.row]
            
            label1.text = article["title"]!
            label2.text = article["looking_for"]!
//            label3.image = UIImage(named: url)
            label4.text = article["companyName"]!
            // ロゴを表示
            cell.imageView?.af_setImage(withURL: URL(string: article["avatar"] as! String)!)
            
            // 会社名を表示
            let url: URL? = URL(string: article["image"] as! String)
            label5.loadImageAsynchronously(url: url)
            
        }
        
        return cell
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearch()
        searchBar.endEditing(true)
    }
    
    func getSearch(){
        article.removeAll()
        APIDataList.removeAll()
        Alamofire.request("https://www.wantedly.com/api/v1/projects?q=" + SearchBar.text!)
            .responseJSON{ response in
                guard let object = response.result.value else {
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
                        "avatar": dataObject["company"]["avatar"]["s_50"].string
                    ]
                    APIDataList.append(APIData)
                    self.APIDataCount = APIDataList.count
                    print(APIData)
                }
                // JSONデータをViewに反映する
                self.table.reloadData()
                
                
        }
        
        
    }
    
}
