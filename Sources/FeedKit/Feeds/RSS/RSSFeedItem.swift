//
// RSSFeedItem.swift
//
// Copyright (c) 2016 - 2025 Nuno Dias
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/// A channel may contain any number of <item>s. An item may represent a
/// "story" -- much like a story in a newspaper or magazine; if so its
/// description is a synopsis of the story, and the link points to the full
/// story. An item may also be complete in itself, if so, the description
/// contains the text (entity-encoded HTML is allowed; see examples:
/// http://cyber.law.harvard.edu/rss/encodingDescriptions.html), and
/// the link and title may be omitted. All elements of an item are optional,
/// however at least one of title or description must be present.
public struct RSSFeedItem {
    public var title: String
    public var link: String?
    public var description: String?
    public var pubDate: Date
    public var latitude: Double?
    public var longitude: Double?
}

// MARK: - Sendable

extension RSSFeedItem: Sendable {}

// MARK: - Equatable

extension RSSFeedItem: Equatable {}

// MARK: - Hashable

extension RSSFeedItem: Hashable {}

// MARK: - Codable

extension RSSFeedItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case description
        case pubDate
        case latitude
        case longitude
    }
    
    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<RSSFeedItem.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: CodingKeys.title)
        link = try container.decodeIfPresent(String.self, forKey: CodingKeys.link)
        description = try container.decodeIfPresent(String.self, forKey: CodingKeys.description)
        pubDate = try container.decode(Date.self, forKey: CodingKeys.pubDate)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<RSSFeedItem.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(pubDate, forKey: .pubDate)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)

        
    }
}
