//
//  ArtworkListViewModel.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//
import Foundation

class ArtworkListViewModel {
    var artworks: [Artwork] = []
    var onDataFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    func fetchArtworks() {
        APIService.shared.fetchArtworks { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artworks):
                    self.artworks = artworks
                    self.onDataFetched?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
}

