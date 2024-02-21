
struct BruteForceMethod {
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var stringForBruteForce: String = string

        if stringForBruteForce.count <= 0 {
            stringForBruteForce.append(characterAt(index: 0, array))
        }
        else {
            stringForBruteForce.replace(at: stringForBruteForce.count - 1,
                        with: characterAt(index: (indexOf(character: stringForBruteForce.last!, array) + 1) % array.count, array))

            if indexOf(character: stringForBruteForce.last!, array) == 0 {
                stringForBruteForce = String(generateBruteForce(String(stringForBruteForce.dropLast()), fromArray: array)) + String(stringForBruteForce.last!)
            }
        }

        return stringForBruteForce
    }
}
