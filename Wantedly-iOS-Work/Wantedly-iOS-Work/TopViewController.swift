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
var Article: [String: String?] = [:]

var selectTitle: String!
var selectLooking_for: String!
var selectCompanyName: String!
var selectDescription: String!
var selectLocation: String!
var selectlocation_suffix: String!
var selectCompanyURL: String!

var selectAvatar: URL!
var selectImage: URL!

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

        // 検索バーのサーチアイコンの色を変更
        let searchTextField = SearchBar.subviews[0].subviews[1] as! UITextField
        let grassImageView = searchTextField.leftView as! UIImageView
        let magnifyingGlassImage = grassImageView.image!.withRenderingMode(.alwaysTemplate)
        grassImageView.image = magnifyingGlassImage
        grassImageView.tintColor = UIColor.cyan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
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
                    "avatar": dataObject["company"]["avatar"]["s_50"].string,
                    "description":  dataObject["description"].string,
                    "Location": dataObject["location"].string,
                    "Location_suffix": dataObject["location_suffix"].string,
                    "CompanyURL": dataObject["company"]["url"].string
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
        let label3 = cell.viewWithTag(3)as! UIImageView
        let label4 = cell.viewWithTag(4)as! UILabel
        let label5 = cell.viewWithTag(5)as! UIImageView
        
        
        if APIDataList != [] {
            
            var article = APIDataList[indexPath.row]
            Article = APIDataList[indexPath.row]
            
            label1.text = article["title"]!
            label2.text = article["looking_for"]!
//            label3.image = UIImage(named: url)
            label4.text = article["companyName"]!
            // ロゴを表示
            // cell.imageView?.af_setImage(withURL: URL(string: article["avatar"] as! String)!)
            if URL(string: article["avatar"] as? String ?? "https://d2v9k5u4v94ulw.cloudfront.net/small_light(dw=50,dh=50,da=l,ds=s,cw=50,ch=50,cc=FFFFFF)/assets/images") != nil {
                let AvatarURL: URL? = URL(string: article["avatar"] as? String ?? "https://d2v9k5u4v94ulw.cloudfront.net/small_light(dw=50,dh=50,da=l,ds=s,cw=50,ch=50,cc=FFFFFF)/assets/images")
                label3.loadImageAsynchronously(url: AvatarURL)
            }

            // 会社名を表示
            let CompanyImageURL: URL? = URL(string: article["image"] as? String ?? "https://d2v9k5u4v94ulw.cloudfront.net/small_light(dw=320,dh=131,da=s,ds=s,cw=320,ch=131,cc=FFFFFF)/assets/images/f")
            label5.loadImageAsynchronously(url: CompanyImageURL)
            
            
            //
            label1.layer.borderColor = UIColor.blue.cgColor
            label1.layer.borderWidth = 0.5
            label1.layer.cornerRadius = 8.0
            label1.layer.masksToBounds = true
            
        }
        
        return cell
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newArticle = APIDataList[indexPath.row]
        selectTitle = newArticle["title"] as! String
        selectLooking_for = newArticle["looking_for"] as! String
        selectCompanyName = newArticle["companyName"] as! String
        selectDescription = newArticle["description"] as! String
        selectLocation = newArticle["Location"] as! String
        selectlocation_suffix = newArticle ["Location_suffix"] as! String
        selectCompanyURL = newArticle["CompanyURL"] as! String
        
        let AvatarURL: URL? = URL(string: newArticle["avatar"] as? String ?? "https://d2v9k5u4v94ulw.cloudfront.net/small_light(dw=50,dh=50,da=l,ds=s,cw=50,ch=50,cc=FFFFFF)/assets/images")
        let ImageURL: URL? = URL(string: newArticle["image"] as? String ?? "https://d2v9k5u4v94ulw.cloudfront.net/small_light(dw=320,dh=131,da=s,ds=s,cw=320,ch=131,cc=FFFFFF)/assets/images/")
        selectAvatar = AvatarURL
        selectImage = ImageURL

        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let NVC: DetailViewController = (segue.destination as? DetailViewController)!
        NVC.Title = selectTitle
        NVC.Looking_for = selectLooking_for
        NVC.CompanyName = selectCompanyName
        NVC.Description = selectDescription
        NVC.Location = selectLocation
        NVC.Location_suffix = selectlocation_suffix
        NVC.CompanyURL = selectCompanyURL
        NVC.Image = selectImage
        NVC.Avatar = selectAvatar
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索文字列
        print("SearchBar.text")
        print(SearchBar.text)
        if SearchBar.text != "" {
        getSearch()
        searchBar.endEditing(true)
        }
    }
    
    func getSearch(){
        Article.removeAll()
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
                        "avatar": dataObject["company"]["avatar"]["s_50"].string,
                        "description":  dataObject["description"].string,
                        "Location": dataObject["location"].string,
                        "Location_suffix": dataObject["location_suffix"].string,
                        "CompanyURL": dataObject["company"]["url"].string
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
