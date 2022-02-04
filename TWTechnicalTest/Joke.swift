//
//  Joke.swift
//  TWTechnicalTest
//
//  Created by Eliu Efraín Díaz Bravo on 03/02/22.
//

import Foundation

struct Joke: Decodable {
    let id: String
    let icon_url: String
    let value: String
    var url: URL {
        return URL(string: icon_url)!
    }
}
