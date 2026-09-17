import Foundation

let width = 56
let height = 25

func insideEllipse(
    x: Int, y: Int,
    centerX: Double, centerY: Double,
    radiusX: Double, radiusY: Double
) -> Bool {
    let dx = (Double(x) - centerX) / radiusX
    let dy = (Double(y) - centerY) / radiusY

    return dx * dx + dy * dy <= 1
}

for y in 0..<height {
    var line = ""

    for x in 0..<width {
        var character = " "

        if y >= 3 && y <= 7 {
            let earWidth = (y - 3) / 2

            if abs(x - 8) <= earWidth ||
               abs(x - 20) <= earWidth {
                character = "*"
            }
        }

        if insideEllipse(
            x: x, y: y,
            centerX: 14, centerY: 9,
            radiusX: 8, radiusY: 4
        ) {
            character = "*"
        }

        if insideEllipse(
            x: x, y: y,
            centerX: 14, centerY: 17,
            radiusX: 6, radiusY: 5
        ) {
            character = "*"
        }

        if y >= 15 && y <= 21 {
            let tailX = 21 + (21 - y) * (21 - y) / 12

            if x == tailX || x == tailX + 1 {
                character = "*"
            }
        }

        if y == 8 {
            if (9...11).contains(x) || (17...19).contains(x) {
                character = " "
            }

            if x == 10 || x == 18 {
                character = "o"
            }
        }

        if y == 10 && (12...16).contains(x) {
            character = " "

            if x == 14 {
                character = "w"
            }
        }

        if y == 10 &&
           ((3...6).contains(x) || (22...25).contains(x)) {
            character = "-"
        }

        if y >= 20 && y <= 22 && x == 14 {
            character = " "
        }

        if y >= 11 && y <= 22 && (39...40).contains(x) {
            character = "|"
        }

        let dx = Double(x - 40) / 2.0
        let dy = Double(y - 7)
        let distance = sqrt(dx * dx + dy * dy)

        if distance <= 5 {
            if distance >= 4.3 {
                character = "#"
            } else if (x + y) % 4 < 2 {
                character = "@"
            } else {
                character = "."
            }
        }

        line += character
    }

    print(line)
}
