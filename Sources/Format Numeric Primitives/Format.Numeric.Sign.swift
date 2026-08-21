extension Format.Numeric {

    public enum Sign: Sendable, Equatable {

        case automatic

        case never

        case always(includingZero: Bool = false)
    }
}
