//
//  ImageDetailViewController.swift
//  SlideshowApp
//
//  Created by 坪本 梨沙 on 2022/06/14.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImageView.image = image
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
