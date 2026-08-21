import Standard_Library_Extensions

extension Format {

    public struct Decimal: Sendable {
        @usableFromInline
        let isPercent: Bool

        public let shouldRound: Bool

        public let precisionDigits: Int?

        @usableFromInline
        init(isPercent: Bool, shouldRound: Bool, precisionDigits: Int?) {
            self.isPercent = isPercent
            self.shouldRound = shouldRound
            self.precisionDigits = precisionDigits
        }

        public init(shouldRound: Bool = false, precisionDigits: Int? = nil) {
            self.isPercent = false
            self.shouldRound = shouldRound
            self.precisionDigits = precisionDigits
        }
    }
}

extension Format.Decimal {

    public static func format<T: Swift.BinaryFloatingPoint>(
        _ value: T,
        isPercent: Bool,
        shouldRound: Bool,
        precisionDigits: Int?
    ) -> String {
        var workingValue = value

        if isPercent {
            workingValue *= T(100)
        }

        if shouldRound {
            workingValue = workingValue.rounded()
        }

        let result: String
        if let precision = precisionDigits {
            result = formatWithPrecision(workingValue, precision: precision)
        } else {

            var autoResult = "\(workingValue)"
            if autoResult.hasSuffix(".0") {
                autoResult.removeLast(2)
            }
            result = autoResult
        }

        return isPercent ? result + "%" : result
    }

    @usableFromInline
    static func formatWithPrecision<T: Swift.BinaryFloatingPoint>(
        _ value: T,
        precision: Int
    ) -> String {
        guard precision > 0 else {
            return "\(Int(value.rounded()))"
        }

        let isNegative = value < 0
        let absValue = abs(value)

        var multiplier: T = 1
        for _ in 0..<precision {
            multiplier *= 10
        }

        let rounded = (absValue * multiplier).rounded() / multiplier
        let intPart = Int(rounded)
        let fracPart = rounded - T(intPart)

        let sign = isNegative ? "-" : ""

        if fracPart == 0 {
            return sign + "\(intPart)." + String(repeating: "0", count: precision)
        }

        var fracValue = fracPart
        var fracString = ""
        for _ in 0..<precision {
            fracValue *= 10
            let digit = Int(fracValue) % 10
            fracString += "\(digit)"
        }

        return sign + "\(intPart).\(fracString)"
    }

    @inlinable
    public func format<T: Swift.BinaryFloatingPoint>(_ value: T) -> String {
        Self.format(
            value,
            isPercent: isPercent,
            shouldRound: shouldRound,
            precisionDigits: precisionDigits
        )
    }
}

extension Format.Decimal {

    @inlinable
    public static var number: Self {
        .init(isPercent: false, shouldRound: false, precisionDigits: nil)
    }

    @inlinable
    public static var percent: Self {
        .init(isPercent: true, shouldRound: false, precisionDigits: nil)
    }
}

extension Format.Decimal {

    @inlinable
    public func rounded() -> Self {
        .init(isPercent: isPercent, shouldRound: true, precisionDigits: precisionDigits)
    }

    @inlinable
    public func precision(_ digits: Int) -> Self {
        .init(isPercent: isPercent, shouldRound: shouldRound, precisionDigits: digits)
    }
}
