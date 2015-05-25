import XCTest
import State

class TemplateTests: Test {
    
    func testEncodingAndDecodingAutoGeneratedModel() {
        var company = Company(name: "State llc", phoneNumber: "888-888-8888", yearFounded: 2015, employees: [Employee]())
        let employee = Employee(name:"Joe", title: "CEO")
        company.employees?.append(employee)
        let data = Encoder.encodeModel(company)
        Plist.write(data, path: tempPathFor("company.plist"))
        let testCompany: Company? = Decoder.decodeModel(Plist.read(tempPathFor("company.plist")))
        
        XCTAssert(testCompany != nil)
        XCTAssert(testCompany?.name == "State llc")
        XCTAssert(testCompany?.phoneNumber == "888-888-8888")
        XCTAssert(testCompany?.yearFounded == 2015)
        XCTAssert(testCompany?.employees?.count == 1)
        XCTAssert(testCompany?.employees?[0].name == "Joe")
    }
    
    func testTypes() {
        var test_out = TestTypes()
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_types.plist"))
        var sut: TestTypes? = Decoder.decodeModel(Data.read(tempPathFor("test_types.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testImmutableTypes() {
        var test_out = TestImmutableTypes()
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_immutable_types.plist"))
        var sut: TestImmutableTypes? = Decoder.decodeModel(Data.read(tempPathFor("test_immutable_types.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }

    func testOptionalTypes() {
        var test_out = TestOptionalTypes()
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_optional_types.plist"))
        var sut: TestOptionalTypes? = Decoder.decodeModel(Data.read(tempPathFor("test_optional_types.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testImmutableOptionalTypes() {
        var test_out = TestImmutableOptionalTypes()
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_immutable_optional_types.plist"))
        var sut: TestImmutableOptionalTypes? = Decoder.decodeModel(Data.read(tempPathFor("test_immutable_optional_types.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }

    func testCollections() {
        var test_out = TestCollections()
        test_out.arrayOfStrings = ["string1", "string2", "string3"]
        test_out.dicOfInts["int1"] = 1
        test_out.dicOfInts["int2"] = 2
        test_out.dicOfInts["int3"] = 3
        test_out.setOfStrings = ["do", "ray", "me"]
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_collections.plist"))
        var sut: TestCollections? = Decoder.decodeModel(Data.read(tempPathFor("test_collections.plist")))
        
        XCTAssert(sut != nil)
        XCTAssert(sut?.arrayOfStrings.count == 3)
        XCTAssert(sut?.dicOfInts.count == 3)
        XCTAssert(sut?.setOfStrings.count == 3)
    }
    
    func testRawEnum() {
        var test_out = TestRawEnum.Ready
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_enum.plist"))
        var sut: TestRawEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_enum.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.Ready)
    }
    
    func testTransformable() {
        var test_out = TestTransformable( myTransformable: NSURL(string: "http://facebook.com")!, myTransformableImmutable: NSURL(string: "http://yahoo.com")!, myTransformableImmutableOptional: nil, myTransformableOptional:NSURL(string: "http://twitter.com")!)
        Data.write(Encoder.encodeModel(test_out), path: tempPathFor("test_transformable.plist"))
        var sut: TestTransformable? = Decoder.decodeModel(Data.read(tempPathFor("test_transformable.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myTransformable == test_out.myTransformable)
        XCTAssert(sut?.myTransformableImmutable == test_out.myTransformableImmutable)
        XCTAssert(sut?.myTransformableImmutableOptional == test_out.myTransformableImmutableOptional)
        XCTAssert(sut?.myTransformableOptional == test_out.myTransformableOptional)
    }
    
    func testOverrideType() {
        var test_out: TestOverrideType? = TestOverrideType(myArrayOfString: ["string1", "string2"], myURL: NSURL(string: "http://simpletouchsoftware.com"))
        XCTAssert(test_out != nil)
    }

}