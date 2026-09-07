// Week 01 Text Art
// Created by Zhenan Liu
//
// Issues encountered:
// 1. Xcode Playground took a long time to launch during the first run.
// 2. I initially redeclared a variable by writing "var" twice.
//    I learned that "var" is only used when declaring a variable.
// 3. I initially found String(repeating:count:) difficult to understand.
//    I learned that it repeats a symbol a specified number of times.

// This function creates a diamond using a chosen symbol and size.
func makeDiamond(symbol: String, size: Int) {

    // Create the upper half of the diamond.
    for row in 1...size {
        let spaces = String(repeating: " ", count: size - row)
        let symbols = String(repeating: symbol, count: row * 2 - 1)

        print(spaces + symbols)
    }

    // Create the lower half of the diamond.
    for row in stride(from: size - 1, through: 1, by: -1) {
        let spaces = String(repeating: " ", count: size - row)
        let symbols = String(repeating: symbol, count: row * 2 - 1)

        print(spaces + symbols)
    }
}

// Call the function.
makeDiamond(symbol: "*", size: 5)
