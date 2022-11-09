//
//  ViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/01.
//

import UIKit
import Foundation
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var APIRequest = API()
    var pokemoninfroarray = [PokemonInfo]()
    
    //11.8追加
    var image: URL?
    var name:String?
    var id:Int?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            
            //cellの初期値のサイズを記入 autolayoutで上書きされる予定
            layout.estimatedItemSize = CGSize(width: 20, height: 20)
            
            //各セルのサイズ
            //            layout.itemSize = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 4)
//            layout.itemSize = CGSize(width: 150, height: 150)
            
            //行間
            layout.minimumLineSpacing = 0
            //列間
            layout.minimumInteritemSpacing = 0
            
            //セクションごとのInsetを指定/16
            layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
            collectionView.collectionViewLayout = layout
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .systemPink
        self.view.backgroundColor = UIColor.systemPink
        self.title = "一覧"
        
        APIRequest.CreatePokemonLibrary { InfoArray in
            //APIRequestの処理が終了次第、viewControllerのviewに入れる。
            DispatchQueue.main.async {
                self.pokemoninfroarray = InfoArray
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 2
        let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemoninfroarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //セル上のTag(1)とつけたUILabelを生成
        let idLabel = cell.contentView.viewWithTag(1) as! UILabel
        
        //セル上のTag(2)とつけたUILabelを生成
        let nameLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        //名前のラベル
        idLabel.text = "No.\(String(describing: pokemoninfroarray[indexPath.row].id!))"
        
        //セルのラベル
        nameLabel.text = String(describing: pokemoninfroarray[indexPath.row].name!)
        
        //imageを定義
        let imageView = cell.contentView.viewWithTag(3) as! UIImageView
        
        //imageURLを作成する
        let imageURL = URL(string: pokemoninfroarray[indexPath.row].sprites.frontImage)
        imageView.sd_setImage(with: imageURL)
        
        //monsterview
        let ballView = cell.contentView.viewWithTag(4) as! UIImageView
        ballView.sizeToFit()
        
        //最前面に配置する
        self.view.bringSubviewToFront(imageView)
        
        //作成したURLを元にimageを表示
        return cell
    }
    
    //各セルがタップされたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let pokemondetailView: UIView = UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        //                self.view.addSubview(pokemondetailView)
        
        //遷移先に渡す変数にそれぞれ格納
        name = pokemoninfroarray[indexPath.row].name!
        id = pokemoninfroarray[indexPath.row].id!
        image = URL(string: pokemoninfroarray[indexPath.row].sprites.frontImage)
        
        //segueでの画面遷移
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toNext") {
            let subVC: SampleViewController = (segue.destination as? SampleViewController)!
            subVC.id = id!
            subVC.name = name!
            subVC.selectedImgURL = image!
        }
    }
    
}

