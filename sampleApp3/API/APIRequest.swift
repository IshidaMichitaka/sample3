//
//  PokemonView.swift
//  sampleApp3
//
//  Created by 石田　倫隆 on 2022/11/02.
//

import UIKit

final class API {
    
    var pokemonInfoArray:[PokemonInfo] = []

    
    func CreatePokemonLibrary(completion: @escaping (_ InfoArray: [PokemonInfo]) -> Void) {
        for i in 1...151 {
            let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)")!
            let req = URLRequest(url: url)
            
            //データ移送をするためのセッションを作成
            let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
                session.finishTasksAndInvalidate()
                
                //エラーハンドリング
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(PokemonInfo.self, from: data!)
                    let pokemonInfo1 = PokemonInfo(name: json.name, id: json.id, sprites: json.sprites)
                    self.pokemonInfoArray.append(pokemonInfo1)
                    if self.pokemonInfoArray.count >= 151 {
                        self.pokemonInfoArray.sort(by: {
                            $0.id! < $1.id!
                        })
                        completion(self.pokemonInfoArray)
                    }
                } catch {
                    print("エラー")
                }
            })
            task.resume()
        }
    }
}
