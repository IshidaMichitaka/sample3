//
//  CustomView.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/07.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //コードで呼び出す
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadPokemondetail()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadPokemondetail()
    }
    
    // 上記どちらのinitからも使用される共通関数で、xibファイルを呼び出す。
    func loadPokemondetail() {
        //         第1引数のnameには、xibファイル名
        //         ownerはself固定
        //         optionsはここではnil
        if let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
