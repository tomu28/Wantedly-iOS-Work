//
//  UIImageView.swift
//  Wantedly-iOS-Work
//
//  Created by 小幡 十矛 on 2019/02/26.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageAsynchronously(url: URL?, defaultUIImage: UIImage? = nil) -> Void {
        
        if url == nil {
            self.image = defaultUIImage
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                    } else {
                        self.image = defaultUIImage
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.image = defaultUIImage
                }
            }
        }
    }
}
