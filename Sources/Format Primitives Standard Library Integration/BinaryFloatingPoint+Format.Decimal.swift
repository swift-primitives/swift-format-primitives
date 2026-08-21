public import Format_Decimal_Primitives

extension Swift.BinaryFloatingPoint {

    @inlinable
    public func formatted(_ format: Format.Decimal) -> String {
        format.format(self)
    }
}
