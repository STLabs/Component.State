#State

A Swift model framework that supports `structs`, `enums` and `protocols` in the model layer. Models optionally can be defined just like with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). The framework provides serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Features: 

- Design Models just like Core Data, in the Xcode model designer
- Model code generated automatically
- Struct, Enum (including associated types), and Protocol model types supported.
- Use immutable, optional, and non-optional properties
- Read and write models to and from JSON, Plists, and Binary 
- Model versioning and migration management (optional)

For more information on the benfiets of State read [About State](Docs/About.md)

#### Example:
Whether you use the data modeler and code generation, or you code your models by hand, it is very easy to define models with State.
This is a complete model as it would be generated, or defined by hand. The example shows you can have constants, optionals, and composition of other models.

```swift
public struct MyModel : Model {
    public let myDate: NSDate
    public let myArrayOfStrings: [String]
    public var myBinary: NSData?
    public var myOtherModel: MyOtherModel
    public var myModelCollection: [MyOtherModel]
}

extension MyModel : Decodable {
    public init?(var decoder: Decoder) {
        // use guard for non-optionals
        guard
            let myDate: NSDate = decoder.decode("myDate"),
            let myArrayOfStrings = decoder.decode("myArrayOfStrings"),
            let myOtherModel: MyOtherModel = decoder.decodeModel("myOtherModel"),
            let myModelCollection: [MyOtherModel] = decoder.decodeModelArray("myModelCollection"),
        else { return  nil }
        let myBinary: NSData = decoder.decode("myBinary")

        self.myDate = myDate
        self.myArrayOfStrings = myArrayOfStrings
        self.myBinary = myBinary
        self.myOtherModel = myOtherModel
        self.myModelCollection = myModelCollection
    }
}

extension MyModel : Encodable {
    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        endcoder.encode(myArrayOfStrings, "myArraryOfStrings")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myOtherModel, "myOtherModel")
        encoder.encode(myModelCollection, "myModelCollection")
    }
}

```

## Protocol Oriented
State has a protocol oriented design with extension points to extend all of your models.
Model items can compose with protocol types with full serialization support.

![<Protocol Oriented>](Docs/Resources/diag2.png)

Not only can you extend each individual model type with an extension, you can also add API to all of your model elements by extending the Model protocol with your own protocol extension. In-fact, this is exactly how State provides a save function to every model.


## Serialization
Convenient serialization API is provided with the  `save` function by passing in the format, and the path. Load models using an initializer that takes the format and the path.

#### Saving and loading models to a file
```swift

// JSON
model.save(.JSON, path: "model.json")
let model = ModelType(.JSON, path: "model.json")

// Plist
model.save(.Plist, path: "model.plist")
let model = ModelType(.Plist, path: "model.plist")
```

## General Design Philosophy 
State is designed to be simple, lightweight, and fast. It's for the application that has only one, or a hundred model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.
It was designed with the following in mind:

* extremely light weight code base
* low dependency surface area
* No subclassing of a base class
* support for struct, enum, and protocol model items
* models can have optional, non-optional, constant and transient properties.
* models can be composed together
* optional migration/version management if you need it

Most frameworks require all optionals, or all vars. I see that as a compromise.


The encoding and decoding process is decoupled from the data conversion format. All models are encoded and decoded to an intermediate Key-Value dictionary. The Key-Value data is then either decoded into a model, or converted to a target format (bin, plist, json).
![<Protocol Oriented>](Docs/Resources/diag1.png)

![<Protocol Oriented>](Docs/Resources/diag4.png)


##Code Generation
Seperate from the framework itself, State also comes with custom Mogenerator templates, and instructions on how to use them. I believe strongly in the power of automatic code generation or "Meta-Programming". Writing model code that reads and writes your models to JSON or Plists, is a tedius uncessary task. Being able to make changes quickly to your model layer and have your models generated automaticly, with consistent clean code, when you build your project is a powerful way to save you hours of writing tedius code. This is espeacialy useful now, beacuse as the Swift language changes, you can easily update all of your model code by just updating to the latest version of State.

Note:You do not have to use the code genertion features of State, but if you want to iterate fast on your model layer design, being able to make changes quicly I highly reccomend taking the time to set up your project to generate your models.


# [ Read the Documentation to Get Started](Docs/)

##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
