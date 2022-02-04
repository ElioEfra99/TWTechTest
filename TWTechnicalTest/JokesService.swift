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
    
    
    
    func fetchJoke() {
        guard let url = URL(string: apiUrl) else { return }
        performRequest(with: url)
    }
    
    func performRequest(with url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                delegate?.didFail(with: error)
            }
            
            if let safeData = data {
                if let joke = parseJSON(with: safeData) {
                    delegate?.didFindJoke(joke: joke)
                }
            }
        }.resume()
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
