//
//  JokeTableViewCell.swift
//  TWTechnicalTest
//
//  Created by Eliu Efraín Díaz Bravo on 03/02/22.
//

import UIKit

class JokeCell: UITableViewCell {
    
    static let reuseIdentifier = "Joke"
    
    var jokeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var jokeLabel: UILabel = {
        let label = UILabel()
        label.text = "Habia una vez un perro llamado pegamento, se cayó y se pegó :("
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        jokeImage.frame = CGRect(x: 5, y: (contentView.frame.size.height) / 4, width: 100, height: 100)
        jokeLabel.frame = CGRect(x: 120, y: 5, width: contentView.frame.size.width - 120, height: contentView.frame.size.height - 10)
    }
    
    //MARK: - Helper Functions
    
    func setupCell() {
        selectionStyle = .none
        contentView.addSubview(jokeLabel)
        contentView.addSubview(jokeImage)
    }
    
    override func prepareForReuse() {
        jokeLabel.text = nil
        jokeImage.image = nil
    }

}
