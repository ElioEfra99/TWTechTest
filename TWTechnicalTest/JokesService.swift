//
//  JokesService.swift
//  TWTechnicalTest
//
//  Created by Eliu Efraín Díaz Bravo on 03/02/22.
//

import Foundation

protocol JokesServiceDelegate {
    func didFindJoke(joke: Joke)
    func didFail(with error: Error)
}

struct JokesService {
    
    var delegate: JokesServiceDelegate?
    let apiUrl = "https://api.chucknorris.io/jokes/random"
    
    func fetchJokes(jokeCompletion: @escaping (Joke) -> (), groupCompletion: @escaping () -> ()) {
        guard let url = URL(string: apiUrl) else { return }
        let group = DispatchGroup()
        
        // This could result in 14 or less results if we receive the same item
        for _ in 0 ..< 15 {
            group.enter()
            performRequest(with: url, in: group, jokeCompletion)
        }
        
        group.notify(queue: .main, execute: groupCompletion)
    }
    
    func performRequest(with url: URL, in group: DispatchGroup, _ jokeCompletion: @escaping (Joke) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                group.leave()
            }
            
            if let error = error {
                print("Fetching joke failed with error: \(error)")
                return
            }
            
            if let safeData = data {
                if let joke = parseJSON(with: safeData) {
                    jokeCompletion(joke)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(with data: Data) -> Joke? {
        let decoder = JSONDecoder()
        
        do {
            let joke = try decoder.decode(Joke.self, from: data)
            return joke
        } catch {
            print("Error decoding data \(error)")
            return nil
        }
    }
}
