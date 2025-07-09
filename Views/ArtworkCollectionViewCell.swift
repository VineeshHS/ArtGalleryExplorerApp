//
//  ArtworkCollectionViewCell.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//
import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let idLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
     
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center

        artistLabel.font = .systemFont(ofSize: 12)
        artistLabel.textColor = .darkGray
        artistLabel.numberOfLines = 2
        artistLabel.textAlignment = .center

        idLabel.font = .systemFont(ofSize: 10)
        idLabel.textColor = .darkGray
        idLabel.textAlignment = .center

     
        let stack = UIStackView(arrangedSubviews: [titleLabel, artistLabel, idLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 15
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with artwork: Artwork) {
        titleLabel.text = artwork.title
        artistLabel.text = artwork.artist_display ?? "Unknown Artist"
        idLabel.text = "ID: \(artwork.id)"
        contentView.backgroundColor = Self.randomPastelColor()
    }

    static func randomPastelColor() -> UIColor {
        let red = CGFloat.random(in: 0.6...0.95)
        let green = CGFloat.random(in: 0.6...0.95)
        let blue = CGFloat.random(in: 0.6...0.95)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

