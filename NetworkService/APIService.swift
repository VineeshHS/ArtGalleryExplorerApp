//
//  APIService.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//
import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.artic.edu/api/v1/artworks"

    func fetchArtworks(completion: @escaping (Result<[Artwork], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(ArtworkResponse.self, from: data)
                completion(.success(decoded.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchArtworkDetail(id: Int, completion: @escaping (Result<Artwork, Error>) -> Void) {
        let urlString = "https://api.artic.edu/api/v1/artworks/\(id)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(ArtworkDetailResponse.self, from: data)
                completion(.success(decoded.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}

