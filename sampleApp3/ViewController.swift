//
//  ViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/01.
//

import UIKit
import SDWebImage

final class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            collectionView.delegate = self
            collectionView.dataSource = self
            layout.itemSize = CGSize(width: self.collectionView.frame.width/2, height: self.collectionView.frame.width/2)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            collectionView.collectionViewLayout = layout
        }
    }
    
    private let APIRequest = API()
    private var pokemonInfoArray = [PokemonInfo]()
    private var pokemon: PokemonInfo?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpNavigation()
       fetchPokemonList() { result in
            DispatchQueue.main.async {
                self.pokemonInfoArray = result
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemon = pokemon,
              let id = pokemon.id else {return}
        if (segue.identifier == "toNext") {
            let subVC: PokemonDetailView = (segue.destination as? PokemonDetailView)!
            subVC.id = id
            subVC.name = pokemon.name
            subVC.selectedImgURL = URL(string: pokemon.sprites.frontImage)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pokemon = getItem(index: indexPath)
        performSegue(withIdentifier: "toNext", sender: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    //ここまでにサイズの決定をしておく
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let ballView = cell.contentView.viewWithTag(4) as! UIImageView
        ballView.image = UIImage(named: "MonsterBall")
        ballView.sizeToFit()
        let idLabel = cell.contentView.viewWithTag(1) as! UILabel
        let nameLabel = cell.contentView.viewWithTag(2) as! UILabel
        idLabel.text = "No.\(String(describing: pokemonInfoArray[indexPath.row].id))"
        nameLabel.text = String(describing: pokemonInfoArray[indexPath.row].name)
        let imageView = cell.contentView.viewWithTag(3) as! UIImageView
        let imageURL = URL(string: pokemonInfoArray[indexPath.row].sprites.frontImage)
        imageView.sd_setImage(with: imageURL)
        self.view.bringSubviewToFront(imageView)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonInfoArray.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.collectionView.frame.size.width / 2
                let height = width
                return CGSize(width: width, height: height)
    }
}

// MARK: - Private

private extension ViewController {
    
    func getItem(index: IndexPath) -> PokemonInfo? {
        pokemonInfoArray[index.row]
    }
    
    func fetchPokemonList(completion: @escaping (_ InfoArray: [PokemonInfo]) -> Void) {
        APIRequest.CreatePokemonLibrary { InfoArray in
            completion(InfoArray)
        }
    }
    
    func setUpNavigation() {
        navigationController?.navigationBar.backgroundColor = .systemPink
        view.backgroundColor = UIColor.systemPink
        title = "一覧"
    }
    
}

