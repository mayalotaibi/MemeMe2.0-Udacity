//
//  MemeDetailViewController.swift
//  MemeMe 1
//
//  Created by مي الدغيلبي on 18/02/1441 AH.
//  Copyright © 1441 مي الدغيلبي. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
   var meme :Meme!
    
    var image :UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            imageView.image = image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
    
