//
//  PokemonView.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/02.
//

import Foundation
import UIKit

class API {
    var pokemonInfoArray:[PokemonInfo] = []
    //一時的に入れる配列
    var idList:[Int] = []
    var nameList:[String] = []
    var frontImage:[URL] = []
    var shinyImage:[URL] = []
    
    //151回繰り返す
    func CreatePokemonLibrary(completion: @escaping (_ InfoArray: [PokemonInfo]) -> Void) {
            for i in 1...151 {
                let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)")!

                //リクエストを作成
                let req = URLRequest(url: url)
                
                //データ移送をするためのセッションを作成
                let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
                
                //リクエストをタスクとし登録
                let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
                    //セッションを終了
                    session.finishTasksAndInvalidate()
                    
                    //エラーハンドリング
                    do {
                        //インスタンス
                        let decoder = JSONDecoder()
                        
                        //受け取ったJSONデータを解析
                        let json = try decoder.decode(PokemonInfo.self, from: data!)
                        
                        var pokemonInfo1 = PokemonInfo(name: json.name, id: json.id, sprites: json.sprites)
                        
                        //個別に配列に格納
                        //id,name
                        self.pokemonInfoArray.append(pokemonInfo1)
                        
                        if self.pokemonInfoArray.count > 3 {
                            self.pokemonInfoArray.sort(by: {
                                $0.id! < $1.id!
                            })
                            completion(self.pokemonInfoArray)
                        }
                                            
                        //StringからURLにキャスト、URL型で格納
    //                    self.frontImage.append(URL(string: json.sprites.frontImage)!)
    //                    self.shinyImage.append(URL(string: json.sprites.shinyImage)!)

                    } catch {
                        print("エラー")
                    }
                })
                task.resume()

            }
        

    }
    
    
}
struct PokemonInfo: Codable {
    let name: String?
    let id: Int?
    let sprites:Images
    
}

struct Images: Codable {
    let frontImage: String
    let shinyImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case shinyImage = "front_shiny"
    }
}
