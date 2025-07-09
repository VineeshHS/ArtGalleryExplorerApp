//
//  ArtworkListViewController.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//

import UIKit

class ArtworkListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let viewModel = ArtworkListViewModel()
    private var collectionView: UICollectionView!
    private let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Art Gallery"

        setupCollectionView()
        setupBindings()
        fetchData()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 230)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArtworkCollectionViewCell.self, forCellWithReuseIdentifier: "ArtworkCell")
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.onDataFetched = { [weak self] in
            self?.spinner.stopAnimating()
            self?.collectionView.reloadData()
        }

        viewModel.onError = { [weak self] message in
            self?.spinner.stopAnimating()
            self?.showErrorAlert(message: message)
        }
    }

    private func fetchData() {
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.startAnimating()
        viewModel.fetchArtworks()
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.fetchData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.artworks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let artwork = viewModel.artworks[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtworkCell", for: indexPath) as! ArtworkCollectionViewCell
        cell.configure(with: artwork)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artwork = viewModel.artworks[indexPath.row]
        let detailVC = ArtworkDetailViewController(artworkID: artwork.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
