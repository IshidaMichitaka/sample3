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
            layout.itemSize = CGSize(width: self.collectionView.frame.width/2, height: self.collectionView.frame.width/2)
            
            
            //行間
            layout.minimumLineSpacing = 0
            //列間
            layout.minimumInteritemSpacing = 0
            
            //セクションごとのInsetを指定/16
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
        let width: CGFloat = self.collectionView.frame.size.width / 2
                let height = width
                return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemoninfroarray.count
    }
    
    
    // 水平方向におけるセル間のマージン
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            // セルの左右に
            return 0
        }
        
    // 垂直方向におけるセル間のマージン
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // セルの中央に
            return 10
        }
    
    //ここまでにサイズの決定をしておく
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        //monsterview
        let ballView = cell.contentView.viewWithTag(4) as! UIImageView
        ballView.image = UIImage(named: "MonsterBall")
        ballView.sizeToFit()
        
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
        
        //最前面に配置する
        self.view.bringSubviewToFront(imageView)
        
        //作成したURLを元にimageを表示
        return cell
    }
    
    //各セルがタップされたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //遷移先に渡す変数にそれぞれ格納
        name = pokemoninfroarray[indexPath.row].name!
        id = pokemoninfroarray[indexPath.row].id!
        image = URL(string: pokemoninfroarray[indexPath.row].sprites.frontImage)
        
        //segueでの画面遷移
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toNext") {
            let subVC: PokemonDetailView = (segue.destination as? PokemonDetailView)!
            subVC.id = id!
            subVC.name = name!
            subVC.selectedImgURL = image!
        }
    }
    
}

