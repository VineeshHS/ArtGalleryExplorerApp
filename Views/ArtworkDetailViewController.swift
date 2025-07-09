//
//  Untitled.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//

import UIKit

class ArtworkDetailViewController: UIViewController {
    private let artworkID: Int
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let spinner = UIActivityIndicatorView(style: .large)

    init(artworkID: Int) {
        self.artworkID = artworkID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupUI()
        fetchArtworkDetail()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        titleLabel.font = .boldSystemFont(ofSize: 20)
        artistLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0

        [imageView, titleLabel, artistLabel, descriptionLabel].forEach { contentStack.addArrangedSubview($0) }

        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
    }

    private func fetchArtworkDetail() {
        APIService.shared.fetchArtworkDetail(id: artworkID) { [weak self] result in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                switch result {
                case .success(let artwork):
                    self?.titleLabel.text = artwork.title
                    self?.artistLabel.text = artwork.artist_display
                    self?.descriptionLabel.text = artwork.provenance_text ?? "No description available"

                    if let imageID = artwork.image_id {
                        let urlString = "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg"
                        if let url = URL(string: urlString) {
                            URLSession.shared.dataTask(with: url) { data, _, _ in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        self?.imageView.image = UIImage(data: data)
                                    }
                                }
                            }.resume()
                        }
                    }
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

