import Foundation

struct Movie {
    let title: String
    let image: URL?
    let preview: URL?

    init(title: String, image: URL? = nil) {
        self.title = title
        self.image = image
        self.preview = nil
    }

    init(from feedEntry: FeedEntry) {
        self.title = feedEntry.name.label

        if let urlString = feedEntry.images.last?.url {
            self.image = URL(string: urlString)
        } else {
            self.image = nil
        }

        var preview: URL?
        for link in feedEntry.links
            where link.attribute.assetType == .preview {
                preview = URL(string: link.attribute.url)
        }
        if let preview = preview {
            self.preview = preview
        } else {
            self.preview = nil
        }
    }
}

struct MoviesResponse: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let entries: [FeedEntry]

    enum CodingKeys: String, CodingKey {
        case entries = "entry"
    }
}

struct FeedEntry: Decodable {
    let name: FeedEntryName
    let images: [FeedImage]
    let links: [FeedLink]

    enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case images = "im:image"
        case links = "link"
    }
}

struct FeedEntryName: Decodable {
    let label: String
}

struct FeedImage: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "label"
    }
}

struct FeedLink: Decodable {
    let attribute: FeedLinkAttribute

    enum CodingKeys: String, CodingKey {
        case attribute = "attributes"
    }
}

struct FeedLinkAttribute: Decodable {
    let assetType: FeedLinkAssetType?
    let url: String

    enum CodingKeys: String, CodingKey {
        case assetType = "im:assetType"
        case url = "href"
    }
}

enum FeedLinkAssetType: String, Decodable {
    case preview
    case unknown

    init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        switch string {
        case "preview":
            self = .preview
        default:
            self = .unknown
        }
    }
}
