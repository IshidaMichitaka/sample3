//
//  CustomView.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/07.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
//    //コードで呼び出す
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibInit()
    }

    // 上記どちらのinitからも使用される共通関数で、xibファイルを呼び出す。
    //この部分でviewcontrollerから値を受け取り、id,name,imageにそれぞれ格納する
    private func nibInit() {
        let nib = UINib(nibName: "CustomView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.addSubview(view)
    }
}
