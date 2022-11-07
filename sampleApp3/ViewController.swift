//
//  ViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/01.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var APIRequest = API()
    var pokemoninfroarray = [PokemonInfo]()
    
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
        
        APIRequest.CreatePokemonLibrary { InfoArray in
            DispatchQueue.main.async {
                //ここまで入った!!
                self.pokemoninfroarray = InfoArray
                self.collectionView.reloadData()
            }
        }
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
        
        //作成したURLを元にimageを表示
            return cell
    }
}



