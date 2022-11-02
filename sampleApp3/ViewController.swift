//
//  ViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/01.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            
            //各セルのサイズ
            layout.itemSize = CGSize(width: 190, height: 190)
            
            //行間
            layout.minimumLineSpacing = 0
            //列間
            layout.minimumInteritemSpacing = 0
            
            //セクションごとのInsetを指定/16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    collectionView.collectionViewLayout = layout
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 151
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//            cell.backgroundColor = UIColor.lightGray
        //cellを二分割する、丸角になる
//        cell.layer.cornerRadius = cell.frame.size.width * 0.5
//        cell.clipsToBounds = true
        
        //セル上のTag(1)とつけたUILabelを生成
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        //今回は簡易的にセルの番号をラベルのテキストに反映させる
        label.text = "No.\(String(indexPath.row + 1))"
        
            return cell
    }

}

