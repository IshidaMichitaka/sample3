//
//  SampleViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/08.
//

import UIKit

class PokemonDetailView: UIViewController {

    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var name:String = ""
    var selectedImgURL: URL!
    var id:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = "No.\(id)"
        nameLabel.text = name
        imageView.sd_setImage(with: selectedImgURL)        
    }
}

//navigationで帰る時
//navigationViewController.popViewController(animated: true)
