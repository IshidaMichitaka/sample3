//
//  SampleViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/08.
//

import UIKit

final class PokemonDetailView: UIViewController {
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var name:String = ""
    var selectedImgURL: URL!
    var id:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = "No.\(id)"
        nameLabel.text = name
        imageView.sd_setImage(with: selectedImgURL)
    }
    
//    func configure(pokemon: PokemonInfo) {
//        idLabel.text = "No. \(pokemon.id)"
//        nameLabel.text = pokemon.name
//        let url = URL(string: pokemon.sprites.frontImage)
//        imageView.sd_setImage(with: url)
//    }
}
