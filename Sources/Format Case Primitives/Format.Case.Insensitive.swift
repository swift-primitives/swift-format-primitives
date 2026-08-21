extension Format.Case {

    public struct Insensitive: Hashable, Comparable, Sendable {

        public let value: String

        @inlinable
        public init(_ value: some StringProtocol) {
            self.value = String(value)
        }
    }
}

extension Format.Case.Insensitive {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        value.lowercased().hash(into: &hasher)
    }

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value.lowercased() == rhs.value.lowercased()
    }

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value.lowercased() < rhs.value.lowercased()
    }
}
