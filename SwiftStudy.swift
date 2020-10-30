//
//  SwiftStudy.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/29.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit

class SwiftStudy: NSObject {
    
    // 测试闭包
    /**
     闭包的基本形式
     
     { (参数列表) -> 返回值类型 in
        语句...
     }
     */
    func someFunc(arg: String) -> (Int,Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch (arg) {
        case "+":
            result = {(a:Int, b:Int) -> Int in
                return a + b
            }

        default:
            result = {(a:Int, b:Int) -> Int in
                return a * b
            }
        }
        return result
    }
    
    /*
     Swift 提供了参数名称缩写的功能，可以用 $0 , $1 来调用闭包中的参数， 等价于上面的写法
     */
    
    func someFunc1(arg: String) -> (Int,Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch (arg) {
        case "+":
            result = {$0 + $1}
            return result

        default:
            result = {$0 * $1}
            return result
        }
        return result
    }

}



/***
 Swift 提供了一种比强制解包，更安全的解包方式：可选绑定。可选绑定有两种方式：
 1. if-let
 2. guard-let-else，与return和break配合提前终止代码，有效避免了深层的嵌套
 
 Swift的集合有： Array，Set， Dictionary三种
 
 var a = Arrray<String>() 等价与 var a = [String]()
 
 var dict = Dictionary<String, Ing>()
 等价于 var dict = [String:Int]()
 
 */
struct SwiftTestModel: Codable {
    
    // 可选类型变量， 默认不赋值时就是nil
    var optionalVar: String? = nil
    // 非可选类型变量
    var nonOptionalVar: String = "Jung"
    
    // 每次使用到可选类型变量，都需要加判断 或者强制解析，比较麻烦；这时可以利用隐式可选类型。 隐式可选类型实际就是一个普通的可选类型， 但是开发者明确知道此 【可选类型变量】 在第一次赋值后一定总有值，从而用 【隐式可选类型】 省却了强制解析的过程
    
    // 声明一个隐式可选类型, 使用时可以直接取值，但是如果的确没有值，就会引发运行时奔溃。
    var hiddenOptionalVar: String! = nil
    
    // 闭包返回可选类型闭包， 表明次闭包可能为nil
    
    /**
     
     对于可能抛出错误的方法， 调用时应当使用try语法来捕捉错误， 当然有时候并不对 捕捉到错误进行处理，此时代码可能是这个样子
     
     let picture = try！loadImage(atPath: "...")
     
     这样其实是禁止了错误的抛出，一旦有错误是就会 ⚠️奔溃。所以建议的语法如下
     
     let picture = try? loadImage(atPath: "...")
     
     
     */
}

/*
 Swift 类，结构体，枚举
 
 - 类是三者中唯一拥有继承属性的， 内省和转型也是类的特性。三种类型最主要的区别就是 值类型和引用类型。
 - 类属于引用类型，传递的是对象的指针，这些对象存储在堆中，类的指针保存在栈上。
 - 定长的结构体和枚举直接保存在栈上，变长的结构体和枚举需要堆内存的配合，栈的空间有限，运行速度更快。
 - 值引用 && 类型引用
 
 - 枚举的定义方法和类相似，枚举可以有方法和属性，但是它的属性只能是 ❤️ 计算属性
 
 - 类在初始化的时候它的属性必须都被初始化。
 - 只有用var定义的属性才能用lazy关键字
 
 
 */

/* 要访问枚举中的case， 需要使用 ‘点语法’，例如： MediaDataType.VideoType
 
 什么时候用枚举 ？
 
 - 当某样东西在某种情况下是一个值，在另一个情况下是另一个值，但是不可能同时拥有着两个值的时候，使用枚举比较合适。

 */

enum MediaDataType {
    case VideoType
    case AudioType
    case ImageType
    case TextType
}

enum DataType {
    case IntType
    case DoubleType
}
/*
 可以将数据与枚举中的case关联起来， 通过这种关联，case中的情况就一目了然了， 这种关联在工程中非常有用
 */

enum DataType2 {
    case IntType(Int)
    case DoubleType(Double)
}

/*
 枚举的case被理解为 枚举的属性，遵照属性的命名方式，枚举内部使用case 必须加 “.” 前缀
 */

enum Turn {
    case left
    case right
    
    var reminder: String {
        // 枚举内部访问 case
        switch self {
        case .left:
            return "turn left"
        case .right:
            return "turn right"
        }
    }
}


/*
 ### 属性
 
 属性将值 跟特定的类，结构体或枚举关联， OC中使用property关键字显式地声明属性。
 - Swift中的属性分为两类： 一种是存储属性，另一种是计算属性
 
 #### 存储属性
 - 把常量或变量的值作为实例的一部分
 
 #### 计算属性
 - 它计算一个值，类似于方法的功能， 提供了一个处理数据的入口与出口。
 - 计算属性可以用于 类，结构体 和枚举里，存储属性只能用于类和结构体里。
 
 - 计算属性，不直接存储值，而是提供一个getter来获取值， 然后用过一个可选的setter来间接设置其他属性或变量的值。
 

 */

/*
    比如： 有两个存储值属性分别 存储一个人的姓和名，现在需要获得他的完整名字，可以使用一个计算属性的 get方法
 
 - 可以看到，在定义计算属性的时候，属性并没有初始化，而是后面跟了一个大括号，在大括号中定义了get方法
 
 - 此外也可以在计算属性中定义 set方法， set方法并不是必须的
*/
class testValueClass {
    var givenName = "爱新觉罗"
    var firstName = "小明"
    
    var fullName: String {
        get {
            return givenName+firstName
        }
    }
    
}


class Pet {
    // 存储属性
    var notPet: String = ""
    
    // 计算属性
    var changePet: String {
        
        get {
            return notPet
        }
        
        set (newPet) {
            notPet = newPet
        }
    }
}


/*
 ### 属性观察器
 
 属性观察器是个非常酷的特性，可以用来检测属性值的变化，属性观察器极大地提高了Swift中属性的灵活性。
 - willSet 和 didSet 中的代码会在属性值被设置或获取的时候调用。
 - 只需要在属性中显式地使用 willSet和didSet即可，它们会在属性值发生变化时自动执行。
 - willSet 中有一个特殊的变量叫 newValue,代表属性将要被赋予的新值。 同样地，在didSet中有一个oldValue，代表属性被设置之前的旧值。
 - ⚠️ 属性观察器更适合值类型，属性观察器 实际监听的是 “栈” 上所发生的改变。
 */

class TestValueObserver {
    
    var exampleOfProperty: Int = 10 {
        
        willSet {
            // 在属性值更改之前做某些操作
        }
        
        didSet {
            // 在属性值更改之后做某些操作
        }
    }
    
}


/**
 ### 类型属性
 
 上面介绍的属性，都是类型属性，还有一种属性是类型属性。
 为了区分这两个概念，举一个例子：
 
 假设轿车这种交通工具是类， 那么某个品牌的轿车就是轿车类的实例，该品牌轿车的价格是实例的一个属性，因为不同品牌轿车的价格 是与具体品牌挂钩的。
 但是有些属性是所有轿车的共性， 比如无论什么牌子的轿车，都有4个轮子，而并不与轿车品牌挂钩。这种属性就是 类型属性。
 
 - 类型属性，用于定义特定类型所有实例共享的数据。
 - 使用关键字 static来定义 【 类型属性 】 类型属性可以包括存储属性和计算属性， 另外类中有一个专用的关键字 class， 用来定义可被子类 重写的计算属性
 
 */

struct NewStruct {
    
    static var storedTypeProperty = 0
    static var computedTypeProperty: Int {
        // get set 方法
        get {
            return storedTypeProperty
        }
    }
    
   
}


/* Swift 和OC一样，也存在构造和析构过程。在Swift中使用 “init” 表示构造器。
 
 - 在定义一个新类时，并不经常使用构造器，这是因为类和结构体 中的大部分属性都会通过赋值被初始化，或者有些属性是可选型的，即使他们的值是nil也没关系，可以在之后再给他们赋值。
 
 - 不用着急去定一个构造器，在某些情况下系统会自动生成一个构造器。
- ⚠️ 在某个类中，当类中所有属性都有初始值，并且类中没有定义构造器时，就会自动生成一个没有参数的构造器 init（）
 - ⚠️ 在结构体中，当所有属性都有默认值，并且结构体中没有定义构造器时，就会得到一个默认的，将所有属性作为参数的构造器，注意二者区别
 
 - 构造器不需要使用func关键字
 
 */


struct Example {
    var str = "Hello"
    
    // init(str: String) 系统会自动生成这样一个构造器，并且它是隐藏的
}

/**
 ### 类型检查和类型转换
 
 在Swift中，使用 is 关键字实现类型检查，使用 as 关键字实现类型转换，除此之外，还可以通过构造器和方法来实现类型转换。
 
 - “is” 可以用来检查一个实例 是否属于特定子类型， 若实例属于那个子类型，则类型检查操作符返回true，否则返回false
 
 */

class Transport {
    
    var scope:String
    init(scope:String) {
        self.scope = scope
    }
}

class Car: Transport {
    var type:String = "Bus"
    init(scope: String, type:String) {
        super.init(scope: scope)
        self.type = type
    }
}

class AirPlane: Transport {
    var company:String = "东方航空"
    init(scope: String, company:String) {
        super.init(scope: scope)
        self.company = company
    }
}

class TestMain {
    
    var testProperty:String = "测试属性"
    
    func test() {
        
        let car = Car(scope: "公路", type: "轿车")
        let plane = AirPlane(scope: "航空", company: "ChinaAir")
    
       let transportArray = [car, plane]
        
        var carNum = 0
        var airNum = 0
        // 类型检查
        for transport in transportArray {
            if transport is Car {
                carNum += 1
            } else if transport is AirPlane {
                airNum += 1
            }
        }
        
        print(carNum)
        print(airNum)
        
        // 类型转换
        // 数组中取出的元素可能是Car类，也可能是AirPlane类，所以使用安全转型 as?
        for transport in transportArray {
            if let car = transport as? Car {
                print(car.type)
            } else if let airplane = transport as? AirPlane {
                print(airplane.company)
            }
        }
    }
}


/**
 ### 扩展
 扩展就是给一个 现存的类，结构体，枚举或者协议 添加新的属性或者方法的 语法；
 
 - 无法修改目标的源代码，不能添加一个已经存在的方法或者属性
 - 添加的属性不能是存储属性，只能是计算属性
 
 */

extension TestMain {
    
    // 扩展计算属性
    var extProperty:String {
        get {
            return testProperty
        }
    }
}


/**
 ### 协议
 
 - 协议也有继承关系，想遵守某个协议，就必须吧它继承的协议全部实现
 - 协议中加入的属性可以不用实现， 不限制于计算属性还是 存储属性， 但是必须要指出属性的读写权限 ⚠️，比如 {set, get}表示可读写， {get}表示可读。
 
 */

protocol someProtocol {
    // 协议中的属性
    var num:Int  {get}
}


class show:someProtocol {
    var so = 1
    var num: Int {
        get {
            return so
        }
        set {
            so = newValue + 1
        }
    }
}

// 协议扩展补充
/*
 定义了一个协议SharedString， 有两个方法， 在扩展中 赋上了默认实现，使用时可以选择重新定义或者使用默认实现
 */
protocol SharedString {
    func methodForOverride()
    func methodWithOutOverride()
}

extension SharedString {
    
    func methodWithOutOverride() {
        
    }
}

/**
 ### 泛型
 
 范型代码可以确保写出灵活的，可重用的函数。
 
 #### 节点泛型
 在swift中，有参数的函数必须指定参数的类型， 现在有几个同名的函数实现类似的功能，但是参数类型不同，例如：
 
 - 虽然，可以根据参数类型调用不同的参数，但是在定义上这种做法太过冗余
 - 泛型的好处就是，可以通过定义单个函数来实现此功能
 - 节点类型，在定义时不表示任何 具体类型，在函数调用时，会根据传入的实际类型来指定自身的类型。
 */

class GenericTest {
    
    func show(param: Int) {
        print("Hello \(param)")
    }
    
    func show(param: Double) {
        print("Hello \(param)")
    }
    
    func show(param: String) {
        print("Hello \(param)")
    }
    
    // 泛型函数
    func show<T>(param: T) {
        print("Hello \(param)")
    }
    
    
    // 调用时，可以给泛型函数传入不同类型的值
    
    // 如果泛型列表中只有一个T，每个节点类型必须是相同类型的
    
    func show<T>(param1: T, param2: T) {
    
    }
    //。在调用这个函数时，两个参数必须是相同的类型：
    // show(1, 2) Int类型
    // show("Jia", "XiaoMing")
    
    // 如果想定义多个类型的泛型
    
    func show<T,U>(param1:T, param2:U) {
        
    }
}


/**
 ### 泛型协议
 除了节点式声明泛型外，还有其他方式声明一个泛型，比如使用关键字 associatedtype，Swift2.2之前是 typealias 关键字
 
 */

protocol SomeGenericProtocol {
    associatedtype Element
    
    func elementMethod1(element: Element)
    func elementMethod2(element: Element)
}


//struct TestGenericStruct:SomeGenericProtocol {
//
//    // 实现协议的方法
//    func elementMethod1(element: Element) {
//
//    }
//
//    func elementMethod2(element: Element) {
//
//    }
//}

protocol CanCompare {
    func isBigger(other: Self) -> Bool
}

struct BoxInt: CanCompare {
    var intValue:Int
    func isBigger(other: BoxInt) -> Bool {
        return self.intValue > other.intValue
    }
}

//associatedtype OwnElement: Comparable


/**
 ### 泛型对象
 
 我们常用的数组就是对象层面的泛型定义， 如果 不使用协议， 一个泛型对象风格的结构体 定义如下：
 
 
 */

struct TestStruct <T: Comparable> {
    
    func method1(element: T) {
        print("method1 element\(element)")
    }
    
    func method2(element: T) {
        print("method2 element\(element)")
    }
}


/*
 调用测试
 
 let test = TestStruct<Int>()
 test.method1(1)
 */


/**
 ### 泛型方法
 
 方法中泛型使用节点表示法，作用域只在本方法内
 */

struct TestGenericMethod {
    func method1<T : Comparable>(element:T) {
        print("method")
    }
}

/**
 我们都知道Swift的创造者同时也是LLVM的开发者， LLVM编译将C 和 OC 的代码放到一个低级容器中，然后变异成机器代码。 在Swift中，LLVM也在做着同样的事情，编译成汇编代码，发生在整个编译阶段
 
 ### 为什么要用可选型、
 
 出于安全方面考虑，Swift是一门类型安全的语言，Swift中的可选型会在编译时就去检查某些 可能发生在运行时的错误。
 
 - (NSString *)exmaple:(NSString *)name {

    if ([name isEqualToString:@"小明"]){
        return @"找到小明";
    } else if ([name isEqualToString:@"大明"]){
        return @"找到大明"
    }
    return nil；
 }
 
 调用
 
 NSString *result = [self example:@"隔壁老王"]; // 会返回结果nil
 
 NSString *list = @"查找结果：";
 NSString *message = [list stringByAppendingString:result]; // 会发生运行时错误 ❌
 
 这段代码虽然可以通过编译，但是会在运行时发生错误。 原因是，方法中传入“隔壁老王” 时返回nil
 
 上面的代码，用Swift写法如下：
 
 */

func exampleSwift(name:String) -> String? {
    if name == "小明" {
        return "找到小明"
    } else if name == "大明" {
        return "找到大明"
    }
  
    
    return nil
}

/**
 ## 调用
 
 var result:String? = exampleSwift(name: "老王")
 let list = "查找结果："
 let message = list + result // ❌ 因为reult是可选型，这样写在编译器就会报错，就避免了运行时错误，可见，可选型的应用可以提高代码的质量
 
 
 ### 解包 可选型
 
 - 可以使用强制解包， 和 可选绑定（❤️推荐使用）
 
 ### 可选链
 
有一个类Student，里面有两个属性，name和age，它们的类型是可选的，
 
 */

class Student {
    var name:String?
    var age:Int?
}

func exampleStudent(code: String) -> Student? {
    if code == "xm" {
        let xiaoming:Student = Student()
        xiaoming.name = "小明"
        xiaoming.age = 12
        return xiaoming
    } else if code == "dm" {
        let daming:Student = Student()
        daming.name = "大明"
        daming.age  = 15
        return daming
    }
    
    return nil
}

/*
 
 if let student = exampleStudent(code: "xm") {
     if let age = student.age {
         let years = 18 - age
         print(years)
     }
 }
 
 上面的代码运行没问题，但是使用了两个可选绑定，可以吧上面的代码改成可选链的操作，做法如下：
 
 if let age = exampleStudent(code: "xm")?.age {
     let years = 18 - age
     print(years)
 }
 
 */


/**
 ### AnyObject / Any
 
 ⚠️ AnyObject的存在是为了兼容现有OC和iOS代码，并不会经常使用它来构建读者自己的数据结构。
 
 - 可以单纯的认为 AnyObject 是OC中 id的桥接
 - 用 swift 做 app 开发时，为了能适配 Cocoa 架构，AnyObject 就诞生了。它可以代表任意 class 类型（用来替代OC中的 id）
 - ⚠️ 在 Swift 中编译器会对 AnyObject 实例的方法调用做检查，还会返回一个 Optional 的结果。
 -  AnyObject 只适用于 class 类型。但是 swift 中的基本类型都是 struct 类型，并不能用 AnyObject 来表示
 - ❤️ 在Swift3.0中， AnyObject已经被 Any取代了
 - Any 类型，它除了 class 以外还可以表示其他类型，可以说是任意类型（包括 struct，enum，func等）
 */


/**
 ## 可选型中的map 和 flatMap
 
 ❤️❤️ 非常实用的两个方法 map 和flatMap， 当你需要确定返回一个可选型，并且希望当可选型不为空时， 对可选型的值做某些处理后再返回， 可以选用map，可选型的map 定义如下：
 
 */
