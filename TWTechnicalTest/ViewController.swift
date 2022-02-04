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
        setupNavigationItems()
        jokesService.delegate = self
    }
    
    //MARK: - API
    @objc func loadJokes() {
        jokesService.fetchJoke()
    }
    
    
    //MARK: - Helper Functions
    func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Load", style: .plain, target: self, action: #selector(loadJokes))
    }
    
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

//MARK: - JokeService Delegate Methods
extension ViewController: JokesServiceDelegate {
    func didFindJoke(joke: Joke) {
        DispatchQueue.main.async {
            self.jokes[joke.id] = joke
            self.tableView.reloadData()
            if self.jokes.count < 15 {
                self.jokesService.fetchJoke()
            }
        }
    }
    
    func didFail(with error: Error) {
        print("Failed to fetch joke: \(error)")
    }
}
