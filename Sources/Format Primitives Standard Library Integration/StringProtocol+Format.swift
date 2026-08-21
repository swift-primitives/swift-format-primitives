public import Formatter_Primitives

extension StringProtocol {

    @inlinable
    public func formatted(_ format: Format.Case) -> String {
        format.format(String(self))
    }

    @inlinable
    public func formatted<F>(_ format: F) -> F.Output
    where F: Formatter.`Protocol`, F.Input == String, F.Failure == Never {
        format.format(String(self))
    }
}

extension String {

    @inlinable
    public var caseInsensitive: Format.Case.Insensitive {
        Format.Case.Insensitive(self)
    }
}
