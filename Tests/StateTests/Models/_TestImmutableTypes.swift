
//
// AUTO GENERATED FILE
// _TestImmutableTypes.swift
//

import Foundation
import State

public struct TestImmutableTypes : Model  {
    public let myDate: Date
    public let myInt: Int
    public let myBinary: Data
    public let myDouble: Double
    public let myString: String
    public let myBoolean: Bool
    public let myDecimal: NSDecimalNumber
    public let myFloat: Float

}

extension TestImmutableTypes  {

    public init?(with source: Store) {
        let store = TestImmutableTypes.migrate(source: source)

         guard
            let myDate: Date = store.value(forKey: "myDate"),
            let myInt: Int = store.value(forKey: "myInt"),
            let myBinary: Data = store.value(forKey: "myBinary"),
            let myDouble: Double = store.value(forKey: "myDouble"),
            let myString: String = store.value(forKey: "myString"),
            let myBoolean: Bool = store.value(forKey: "myBoolean"),
            let myDecimal: NSDecimalNumber = store.value(forKey: "myDecimal"),
            let myFloat: Float = store.value(forKey: "myFloat")
         else { return  nil }

        self.myDate = myDate
        self.myInt = myInt
        self.myBinary = myBinary
        self.myDouble = myDouble
        self.myString = myString
        self.myBoolean = myBoolean
        self.myDecimal = myDecimal
        self.myFloat = myFloat
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestImmutableTypes? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myDate, forKey: "myDate")
        store.set(myInt, forKey: "myInt")
        store.set(myBinary, forKey: "myBinary")
        store.set(myDouble, forKey: "myDouble")
        store.set(myString, forKey: "myString")
        store.set(myBoolean, forKey: "myBoolean")
        store.set(myDecimal, forKey: "myDecimal")
        store.set(myFloat, forKey: "myFloat")

        TestImmutableTypes.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

