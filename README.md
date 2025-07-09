#  Art Gallery Explorer

## Overview
An iOS app that fetches and displays artworks from the Art Institute of Chicago API. Built using UIKit and MVVM.

 **Model**: 
  - `Artwork`: Structs that represent the artwork JSON.
  
- **ViewModel**: 
  - `ArtworkListViewModel`: Handles artwork list fetching.
  - `ArtworkDetailViewModel`: Fetches details for selected artwork by ID.

- **View (UIKit)**:
  - `ArtworkListViewController`: Uses `UICollectionView` to show artwork grid.
  - `ArtworkDetailViewController`: Displays title, image, artist name, and description.
  - `ArtworkCollectionViewCell`: Custom cell with title, artist name, and ID.


## Design Highlights
- MVVM pattern for clean separation
- Programmatic UIKit components with Auto Layout (no Storyboard).
- Loading Indicators**  
  Added a `UIActivityIndicatorView` while fetching data.
- Error Handling**  
  If the network request fails, the app shows an alert with options to retry or cancel.
- URLSession for networking API calls (no third-party libraries).
- Dynamic Cell Colors**: Artwork cells have random pastel background colors for visual variety.


