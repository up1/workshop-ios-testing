//
//  ResponseDataFactory.swift
//  TopMoviesUITests
//
//  Created by Somkiat Puisungnoen on 11/3/2563 BE.
//

import Foundation

class ResponseDataFactory {
    static func responseData(filename: String) -> Data {
        guard let path = Bundle(for: ResponseDataFactory.self).path(forResource: filename, ofType: "json", inDirectory: ""),
            let data = try? NSData.init(contentsOfFile: path, options: []) else {
                fatalError("\(filename).json not found")
        }
        return data as Data
    }
}
