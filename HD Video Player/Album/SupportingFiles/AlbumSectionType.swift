/// Copyright (c) 2020 Razeware LLC




enum AlbumCollectionSectionType: Int, CustomStringConvertible {
    case smartAlbums, userCollections
    var description: String {
        switch self {
        case .smartAlbums: return "Smart Albums"
        case .userCollections: return "User Collections"
        }
    }
}
