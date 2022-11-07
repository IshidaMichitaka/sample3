//
//  PokemonViewController.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/03.
//

import UIKit
import Foundation

//class PokemonViewController: UIViewController {
//
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var idLabel: UILabel!
//    @IBOutlet weak var pokrmonImage: UIImageView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //url作成
//        let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/25")!
//        print(url)
//
//        //リクエストを作成
//        let req = URLRequest(url: url)
//
//        //データ移送をするためのセッションを作成
//        let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
//
//        //リクエストをタスクとし登録
//        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
//            //セッションを終了
//            session.finishTasksAndInvalidate()
//
//            //エラーハンドリング
//            do {
//                //インスタンス
//                let decoder = JSONDecoder()
//
//                //受け取ったJSONデータを解析
//                //name
//                let json = try decoder.decode(PokemonInfo.self, from: data!)
//
//
//                print(json)
//            } catch {
//                print("エラー")
//            }
//        })
//            task.resume()
//
//
//
//    }
    
    //名前、id、画像のURLをコンソールを取得する
    //リクエストしてみて、結果をコンソールに出力する
    
    //解析する構造体
//    struct PokemonInfo: Codable {
//        let name: String?
//        let id: Int?
//        let sprites:Images
//
//    }
//    
//    struct Images: Codable {
//        let frontImage: String
//        let shinyImage: String
//
//        enum CodingKeys: String, CodingKey {
//            case frontImage = "front_default"
//            case shinyImage = "front_shiny"
//        }
//    }
//}
