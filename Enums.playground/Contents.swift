import Foundation

/*
 * Unnkown case in an enum. Using the power of CaseIterable Protocol of enum, We can model other raw values of enum to an unknown case.
 */

protocol UnknownCaseRepresentable:RawRepresentable, CaseIterable where RawValue:Equatable {
    static var unknownCase: Self { get }
}

extension UnknownCaseRepresentable {
    init(rawValue: Self.RawValue) { /* No failable initialiser that means it will always model to a valid enum case value.*/
        self = Self.allCases.first { $0.rawValue == rawValue } ?? Self.unknownCase
    }
}

enum Color: String, Decodable, UnknownCaseRepresentable {
    static var unknownCase: Color = .other
    
    case blue,
    green,
    red,
    white,
    other
}

let jsonArray: String = "[\"blue3\", \"green\", \"red\", \"white\", \"other5\"]"

let jsonDecoder = JSONDecoder.init()
do {
    let arrColors:[Color] = try jsonDecoder.decode([Color].self, from: jsonArray.data(using: String.Encoding.utf8)!)
    print("Final parsed colors are \(arrColors)")
} catch(let error) {
    print("Error in parsing the json - \(error)")
}






