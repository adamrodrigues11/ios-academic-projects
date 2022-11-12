//
//  Book.swift
//  BookTracker
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import Foundation

enum Rating : String {
    case one = "One star"
    case two = "Two stars"
    case three = "Three stars"
    case four = "Four stars"
    case five = "Five stars"
}

class Book {
    
    var title: String
    var isbn10: Int
    var author: String
    var rating: Rating
    var notes: String?
    var imageURL: String
    var details: [String]
    
    
    init(title: String, isbn10: Int, author: String, rating: Rating, notes: String?, imageURL: String) {
        self.title = title
        self.isbn10 = isbn10
        self.author = author
        self.rating = rating
        self.notes = notes
        self.imageURL = imageURL
        self.details = [
            title,
            author,
            String(isbn10),
            rating.rawValue,
        ]
        if let notesField = notes {
            self.details.append(notesField)
        }
        else {
            self.details.append("No notes")
        }

    }
    
}
