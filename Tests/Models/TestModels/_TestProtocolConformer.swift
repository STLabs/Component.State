/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer : TestProtocol {
    public var age: Int?
    public var ss_number: String
    public var isReady: Bool?
    public var employee: Employee

    public var children: [TestChild]

}

extension TestProtocolConformer : Decodable {

   public static func decode(_ decoder: Decoder) -> TestProtocolConformer? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolConformer.performMigrationIfNeeded(decoder)

         guard
            let ss_number: String = decoder.decode("ss_number"),
            let employee: Employee = decoder.decode("employee"),
            let children: [TestChild] = decoder.decode("children")
         else { return  nil }

        let age: Int? = decoder.decode("age")

        let isReady: Bool? = decoder.decode("isReady")

        self.age = age
        self.ss_number = ss_number
        self.isReady = isReady
        self.employee = employee
        self.children = children
        didFinishDecoding(decoder: decoder)
    }
}

extension TestProtocolConformer : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(ss_number, "ss_number")
        encoder.encode(isReady, "isReady")
        encoder.encode(employee, "employee")
        encoder.encode(children, "children")

        encoder.encode("TestProtocolConformer", "TestParentProtocol")

        TestProtocolConformer.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestProtocolConformer {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<d32fcba3 281d4cc9 b37e5db7 913bf809 201719ca af7abe39 905ab5fe 694ab08b>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestProtocolConformer(forKey key: String) -> TestProtocolConformer? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestProtocolConformer.decode(dictionary)
   }

   public func getTestProtocolConformer(forKey key: String) -> [TestProtocolConformer]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestProtocolConformer.decode))
   }

   public func getTestProtocolConformer(forKey key: String) -> [String : TestProtocolConformer]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestProtocolConformer.decode($0) })
   }

   public func getTestProtocolConformer(forKey key: String, defaultValue: TestProtocolConformer) -> TestProtocolConformer {
      return getTestProtocolConformer(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformer(forKey key: String, defaultValue: [TestProtocolConformer]) -> [TestProtocolConformer] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestProtocolConformer(forKey key: String,  defaultValue: [String : TestProtocolConformer]) -> [String : TestProtocolConformer] {
      return getTestProtocolConformer(forKey: key) ?? defaultValue
   }

   public func setTestProtocolConformer(value: TestProtocolConformer, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestProtocolConformer(value: [TestProtocolConformer], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestProtocolConformer(value: [String : TestProtocolConformer], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestProtocolConformer(forKey key: String) -> TestProtocolConformer? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformer(forKey key: String, defaultValue: TestProtocolConformer) -> TestProtocolConformer {
      return getTestProtocolConformer(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformers(forKey key: String) -> [TestProtocolConformer]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformers(forKey key: String, defaultValue: [TestProtocolConformer]) -> [TestProtocolConformer] {
      return getTestProtocolConformers(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformerDictionary(forKey key: String) -> [String : TestProtocolConformer]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformerDictionary(forKey key: String, defaultValue: [String : TestProtocolConformer]) -> [String : TestProtocolConformer] {
      return getTestProtocolConformerDictionary(forKey: key) ?? defaultValue
   }
}

