//
//  ModelArtWork.swift
//  ArtGalleryExplorerApplication
//
//  Created by ViNEESH HS on 09/07/25.
//

struct ArtworkResponse: Decodable {
    let data: [Artwork]
}

struct Artwork: Decodable {
    let id: Int
    let title: String
    let artist_display: String?
    let image_id: String?
    let provenance_text: String?
}
struct ArtworkDetailResponse: Decodable {
    let data: Artwork
}
