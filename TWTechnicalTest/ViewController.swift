//
//  ViewController.swift
//  TWTechnicalTest
//
//  Created by Eliu Efraín Díaz Bravo on 03/02/22.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Properties
    var jokes = [String : Joke]()
    var jokesService = JokesService()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadJokes()
    }
    
    //MARK: - API
    @objc func loadJokes() {
        jokesService.fetchJokes(jokeCompletion: { self.jokes[$0.id] = $0 }) {
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - Helper Functions
    func setupTableView() {
        tableView.register(JokeCell.self, forCellReuseIdentifier: JokeCell.reuseIdentifier)
        tableView.rowHeight = 200
    }


}

//MARK: - DataSource Methods
extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeCell.reuseIdentifier, for: indexPath) as! JokeCell
        let jokesArray = Array(jokes.values) as [Joke]
        let currentJoke = jokesArray[indexPath.row]
        
        cell.jokeLabel.text = currentJoke.value
        cell.jokeImage.load(url: currentJoke.url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
}
