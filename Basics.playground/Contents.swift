//: Playground - noun: a place where people can play

import UIKit

//
// Variables and constants
//
var str = "Hello, playground!"
let constString = "Hello, constant"
// Always use let until you need a var

//
// Optional Values
//
var optionalString : String?

optionalString = "Hello"

if let stringThatHasAValue = optionalString {
    println("It has a value.")
}
else {
    println("It doesn't have a value.")
}

// Can also coalesce null values with ??, just like C#
// Unwrap an optional with ?, e.g. optionalString?.someMethod()
// DANGEROUSLY unwrap with !, e.g. optionalString!.someMethod(), WILL CRASH if nil

//
// Arrays
//
var arrayOfInts = [1, 2, 3, 4, 5]

//
// Dictionaries
//
var niftyDictionary = [
    "Greeting": "Hello",
    "Farewell": "Goodbye"
]

var numberDictionary = [
    1: "one",
    2: "two"
]

// Note: maps as NSObject: String
var mixedKeys = [
    1: "one",
    "two": 2
]

//
// For loops
//
for number in arrayOfInts {
    println("Number: \(number)")
}

for (key, value) in niftyDictionary {
    println("Key: \(key) = \(value)")
}

//
// Tuples
//
var grocery = ("Beans", 1.99)
grocery.0
grocery.1

//
// Typealias
//
typealias GroceryType = (String, Float)
var fancyGroceryType : GroceryType = ("Beans", 1.99)
fancyGroceryType.0
fancyGroceryType.1

typealias GroceryTypeWithNames = (name: String, price: Float)
var fancierGroceryType : GroceryTypeWithNames = ("Beans", 1.99)
fancierGroceryType.name
fancierGroceryType.price

//
// Sets
//
var mySet : Set = [1, 2, 3, 4, 5] // Note: must use Set type or it will default to Array
mySet.insert(5) // Sets enforce unique values

//
// Switch
//
var number = 42

switch number {
    
case 0:
    println("It's zero!")
    fallthrough // Falls through into case 1
case 1:
    println("It's one")
default: // Switch must either be exhaustive or include a default
    println("It's something else")

}

switch number {
    
case 0...10: // inclusive
    println("It's between 0 and 10")
case 11..<20: // not inclusive
    println("It's between 11 and 19")
default:
    println("It's 20 or more")

}

switch grocery {
    
case ("Beans", _): // Underscore means you don't care what the price is.
    println("It's beans!")
    
case ("Tomatoes", let price): // Capture specific tuple member
    println("Tomatoes cost \(price)")

case (_, 0.0...100.0): // Case matching a pattern
    println("Price is between 0 and 100")
    
default:
    println("It's something else.")
}

//
// Ifs
//
if "one".uppercaseString == "ONE" {
    println("Hi.")
}

if ("two".uppercaseString == "TWO") {
    println("'if' can also use parens, but doesn't have to.")
}

//
// Functions
//
func doSomething() {
    println("Hello!")
}
doSomething()

func returnAValue() -> Int {
    return 42
}
returnAValue()

func withParams(name: String) {
    println("Hello, \(name)")
}
withParams("Isaac")

func optionalParams(name: String?) {
    println("Hello, \(name!)")
}
optionalParams("Isaac")
//optionalParams(nil)

func namedParameters(name: String, withNumber number: Int) {
    println("\(name): \(number)")
}
namedParameters("Isaac", withNumber: 42)

var funcVar = returnAValue
funcVar()

// Functions can return functions
func createAdder(numberToAdd : Int) -> Int -> Int {
    func theAdder(aNumber : Int) -> Int {
        return aNumber + numberToAdd
    }
    
    return theAdder
}

var addTwo = createAdder(2)
addTwo(40)

//
// Closures
//
var addThree = { (number) in
    number + 3
}
addThree(39)

arrayOfInts.sorted( { (first, second) in
    return first < second
})

// Can also omit parameter names
// Can put it after
arrayOfInts.sorted(){$0 < $1}

//
// Extensions (mixins)
//
// CGPoint is a C struct
var myPoint = CGPoint()
myPoint.x = 2
myPoint.y = 3

// Extend to include length()
extension CGPoint {
    func length() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
}

myPoint.length()

// You can even extend basic types like Int
extension Int {
    func double() -> Int {
        return self * 2
    }
}

2.double()

// Operator Overloading (must be at the top level, not part of an extension)
func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

let anotherPoint = CGPoint(x: 3, y: 4)
myPoint + anotherPoint

//
// Classes
// Must provide either an initializer OR properties must be optional OR provide default value
// Access modifiers: (can apply at class level and/or property & function level)
//   public   - everything can access
//   internal - everything within the same module can access
//   private  - only this class can access
//
class WebBrowser {
    // Properties
    var currentWebsite : String = "about:blank"
    
    var windowTitle : String {
        willSet {
            println("Window title is about to change from \(windowTitle) to \(newValue)")
        }
        
        didSet {
            println("Window title did change from \(oldValue) to \(windowTitle)")
        }
    }
    
    var lastResponseCode : Int?
    
    // Computed property
    var numberOfAdsOnCurrentPage : Int {
        // Walk the DOM and cout ad elements
        return 241503
    }
    
    // get/set
    var numberOfOpenTabs : Int {
        get {
            // Count tabs
            return 3
        }
        set {
            // close or open tabs then continue
        }
    }
    
    // Can declare properties as weak references (note: must be optional)
    weak var button : UIButton?
    
    init(browserName: String) {
        windowTitle = "Welcome to \(browserName)"
    }
    
    deinit {
        // Goodbye!
        // Note: Swift does not have a garbage collector.
        // The compiler does reference counting for you.
    }
}

var opera = WebBrowser(browserName: "opera")
opera.currentWebsite
opera.windowTitle
opera.lastResponseCode
opera.numberOfAdsOnCurrentPage

var anotherBrowser = opera
anotherBrowser.windowTitle = "Firefox"
opera.windowTitle // Note that this type of assignment uses the same memory address

class PrivateModeBrowser : WebBrowser {
    var privacyLevel : Float
    
    override init(browserName: String) {
        privacyLevel = 1.0 // Must be initialized before super.init
        super.init(browserName: browserName)
    }
}

//
// Structures
// Do not need to provide initializer, default values, or optionals
// Compiler provides an initializer with all vars included
// Are value types
//
struct Square {
    var size : Float
    var color : UIColor
    
    var area : Float {
        get {
            return size * size
        }
        
        set {
            size = sqrt(newValue)
        }
    }
    
    // Can declare functions within structs, but by default they cannot mutate self
    // unless the `mutating` modifier is included.
    // Use sparingly.
    mutating func changeColor() {
        let colors = [UIColor.redColor(), UIColor.greenColor()]
        
        let randomColor = colors[Int(rand()) % colors.count]

        self.color = randomColor
    }
}

var mySquare = Square(size: 2.0, color: UIColor.yellowColor())

var otherSquare = mySquare
otherSquare.size = 6.0

mySquare.size

mySquare.area = 9
mySquare.size

//
// Generics
//
class Tree<T : Equatable> { // Can 'qualify' types, just like C#
    var data : T
    
    var children : [Tree<T>] = []
    
    init(data: T) {
        self.data = data
    }
    
    func addChild(data : T) -> Tree<T> {
        let newNode = Tree(data: data)
        children.append(newNode)
        return newNode
    }
    
    func containsData(dataToFind : T) -> Bool {
        if (self.data == dataToFind) {
            return true
        }
        
        for childNode in self.children {
            if childNode.containsData(dataToFind) {
                return true
            }
        }
        return false
    }
}

let numberTree = Tree(data: 5)
numberTree.addChild(2)
numberTree.addChild(7).addChild(4)

let stringTree = Tree(data: "hello")

//
// Enumerations
//
/* Traditional enum:
enum CompassDirection {
    North = 0,
    South,
    East,
    West
}
*/

enum CompassDirection /* : Int */{ // Not backed by integer by default
    case North
    case South
    case East
    case West
}
var theWall = CompassDirection.North
theWall = .South

switch theWall {
case .North:
    println("The wall is north.")
default:
    () // default cannot be empty
}

// Enum backed by String
enum HTTPVerb : String {
    case GET = "GET"
    case POST = "POST"
}

var myHTTPRequest = HTTPVerb.GET
myHTTPRequest.rawValue

enum Planet : Int {
    case Mercury = 1
    case Venus /* = 2 */ // assignment after first is optional
    case Earth
    case Mars
    case Jupiter
    case Saturn
    case Uranus
    case Neptune
}
// Can create using raw value instead of enum 'case'
var myPlanet = Planet(rawValue: 3)

// Enums can also have different values
enum Beverage {
    case Tea(milk: Bool, sugars: Int)
    case Coffee(milk: Bool, sugars: Int)
    case Soda(name: String)
}

var myDrink = Beverage.Coffee(milk: true, sugars: 0)

switch myDrink {
    
case .Coffee(true, let sugars):
    println("It's coffee with milk and \(sugars) sugar(s)")
    
case .Coffee(true, 2):
    println("It's coffee, but with milk and 2 sugars")

case .Coffee:
    println("It's coffee, black")
    
default:
    ()
}

//
// Custom Operators
//

// Double type does not provide an operator for exponents, so let's create one.
// 💁 would be a great emoji for this but apparently it doesn't work
infix operator ** { associativity left precedence 160 }
func **(left: Double, right: Double) -> Double {
    return pow(left, right)
}

2.4 ** 3.14

prefix operator +++ {} // defined before infix so no need to set precedence
prefix func +++(inout int: Int) -> Int {
    return int + 2
}
var a = 1
+++a
var b = +++a + 1
a
b


//
// Literal convertibles
//
var anArray    = [1, 2, 3]
var aSet : Set = [1, 2, 3] // This array is converted into a Set automatically

struct Regex {
    
    let pattern : String
    let options : NSRegularExpressionOptions
    
    private var matcher : NSRegularExpression? {
        return NSRegularExpression(pattern: self.pattern, options: self.options, error: nil)
    }
    
    init(pattern: String, options: NSRegularExpressionOptions = NSRegularExpressionOptions.CaseInsensitive) {
        self.pattern = pattern
        self.options = options
    }
    
    func match(string: String, options: NSMatchingOptions = nil) -> Bool {
        return self.matcher?.numberOfMatchesInString(string, options: options, range: NSMakeRange(0, string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))) != 0;
    }
}

let myRegex = Regex(pattern: "foo")
myRegex.match("foo bar")

// Can use Swift literal convertibles to make this declaration nicer.
extension Regex : StringLiteralConvertible {
    
    typealias UnicodeScalarLiteralType = StringLiteralType
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    init(stringLiteral value: StringLiteralType) {
        self.pattern = value
        self.options = .CaseInsensitive
    }
    
    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.pattern = value
        self.options = .CaseInsensitive
    }
    
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {        self.pattern = value
        self.options = .CaseInsensitive
    }
}

// Now we can init a regex like this:
let nicerRegex : Regex = "foo"
nicerRegex.match("foo bar")

