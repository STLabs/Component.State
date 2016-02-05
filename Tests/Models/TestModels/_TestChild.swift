/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestChild : Model {
    public var age: Int?
    public var name: String?
    public var myChildren: [Grandchild]?
    public var gender: Gender?

}

extension TestChild : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestChild.performMigrationIfNeeded(decoder)

        let age: Int? = decoder.decode("age")
        let name: String? = decoder.decode("name")
        let myChildren: [Grandchild]? = decoder.decodeModelArray("myChildren")
        let gender: Gender? = decoder.decodeModel("gender")

        self.age = age
        self.name = name
        self.myChildren = myChildren
        self.gender = gender
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestChild : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")
        encoder.encode(myChildren, "myChildren")
        encoder.encode(gender, "gender")

        TestChild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestChild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4b2e27e5 53e329ff 69cfb4ba 1573537c 35d26944 7199acfc 729b6b5c c6e0ac88>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

