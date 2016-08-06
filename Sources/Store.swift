
//
// Store.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//

import Foundation
import UIKit

///  An abstract key-value property store for
///     reading a writing values.
public struct Store {
    /// The contents of the store.
    public var data : [String : AnyObject]

    /// Create an instance with initial data.
    public init(data: [String : AnyObject] = [:]) {
        self.data = data
    }

    /// Returns the value associated with the specified key.
    public func value<V>(forKey key: String) -> V? {
        return data[key] as? V
    }

    /// Returns the object associated with the specified key.
    public func object(forKey key: String) -> AnyObject? {
        return data[key]
    }

    /// Returns the array associated with the specified key.
    public func array(forKey key: String) -> [AnyObject]? {
        return data[key] as? [AnyObject]
    }

    /// Returns the dictionary associated with the specified key.
    public func dictionary(forKey key: String) -> [String : AnyObject]? {
        return data[key] as? [String : AnyObject]
    }

    /// Sets the value of the specified key to the specified value.
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        data[key] = value as? AnyObject
    }

    /// Returns the url associated with the specified key.
    public func value(forKey key: String) -> URL? {
        guard let urlString : String  = value(forKey: key)
            else { return nil }
        return URL(string: urlString)
    }

    /// Sets the value of the specified key to the specified url value.
    public mutating func set(_ value: URL?, forKey key: String) {
        guard let urlString : String  = value?.absoluteString
            else { return }
        data[key] = urlString
    }

    /// Returns the color associated with the specified key.
    public func value(forKey key: String) -> UIColor? {
        
        guard
            let cStore = store(forKey: key),
            let red: Float = cStore.value(forKey: "red"),
            let green: Float = cStore.value(forKey: "green"),
            let blue: Float = cStore.value(forKey: "blue"),
            let alpha: Float = cStore.value(forKey: "alpha")
        else { return nil }
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }

    /// Sets the value of the specified key to the specified color value.
    public mutating func set(_ value: UIColor?, forKey key: String) {
        guard let value = value
            else { return }
        var red, green, blue, alpha  : CGFloat
        red = 0; green = 0; blue = 0; alpha = 0
        value.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var cStore = Store()
        cStore.set(red, forKey: "red")
        cStore.set(green, forKey: "green")
        cStore.set(blue, forKey: "blue")
        cStore.set(alpha, forKey: "alpha")
        set(cStore, forKey: key)
    }
    
    /// Removes and returns the value at the specified key
    /// or .none if not found.
    public mutating func remove(key: String) -> AnyObject? {
        return data.removeValue(forKey: key)
    }

    /// Returns the sub store associated with the specified key.
    public func store(forKey key: String) -> Store? {
        guard let data = data[key] as? [String : AnyObject]
            else { return nil }
        return Store(data: data)
    }

    /// Sets the value of the specified key to the specified sub store.
    public mutating func set(_ store: Store, forKey key: String) {
        data[key] = store.data
    }

    /// Create a store with file content in the specified format.
    public init?(file: URL, format: Format) {
        guard let data = format.read(file) as? [String : AnyObject]
            else { return nil }
        self.data = data
    }

    /// Writes the store content to a file in the specified format.
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        return format.write(data, to: file)
    }

    /// Returns the stores content as a string in the
    /// specified format.
    public func makeString(format: Format) -> String? {
        return format.makeString(from: data)
    }

    /// Create a store with a string in the specified format.
    public init?(content: String, format: Format) {
        guard let data = format.read(content) as? [String : AnyObject]
            else { return nil }
        self.data = data
    }

    /// Create a store with data in the specified format.
    public init?(content: Data, format: Format) {
        guard let data = format.read(content) as? [String : AnyObject]
            else { return nil }
        self.data = data
    }

    public func makeData(format: Format) -> Data? {
        return format.makeData(from: data, prettyPrint: true)
    }
}

// MARK: - Utility

public func sequence<T>(_ array: [T?]) -> [T]? {
    return  array.reduce(.some([])) { accum, elem in
        guard let accum = accum, let elem = elem
            else { return nil}
        return accum + [elem]
    }
}

public func sequence<T>(_ dictionary: [String: T?]) -> [String: T]? {
    return dictionary.reduce(.some([:])) { accum, elem in
        guard let accum = accum, let value = elem.1
            else { return nil }
        var result = accum
        result[elem.0] = value
        return result
    }
}

extension Dictionary {
    public func map<A>(_ transform: (Value) -> A) -> [Key: A] {
        return self.reduce([:]) { accum, elem in
            var result = accum
            result[elem.0] = transform(elem.1)
            return result
        }
    }
}
