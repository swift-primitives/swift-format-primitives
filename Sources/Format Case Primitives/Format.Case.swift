public import Formatter_Primitives

extension Format {

    public struct Case: Sendable, Formatter.`Protocol` {
        @usableFromInline
        let transform: @Sendable (String) -> String

        @inlinable
        public init(_ transform: @escaping @Sendable (String) -> String) {
            self.transform = transform
        }
    }
}

extension Format.Case {

    public typealias Input = String

    public typealias Output = String

    public typealias Failure = Never

    @inlinable
    public func format(_ value: String) -> String {
        transform(value)
    }

    public static let upper: Self = Self { $0.uppercased() }

    public static let lower: Self = Self { $0.lowercased() }

    public static let title: Self = Self { string in
        string.split(separator: " ")
            .map { word in
                guard let first = word.first else { return "" }
                return first.uppercased() + word.dropFirst().lowercased()
            }
            .joined(separator: " ")
    }

    public static let sentence: Self = Self { string in
        guard let first = string.first else { return string }
        return first.uppercased() + string.dropFirst().lowercased()
    }
}
