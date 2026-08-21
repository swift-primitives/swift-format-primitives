import Testing

@testable import Format_Primitives

@Suite
struct `Format.Case.Insensitive - Equality` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `Same strings are equal`() {
        let a = "hello".caseInsensitive
        let b = "hello".caseInsensitive
        #expect(a == b)
    }

    @Test
    func `Different case strings are equal`() {
        let a = "hello".caseInsensitive
        let b = "HELLO".caseInsensitive
        #expect(a == b)
    }

    @Test
    func `Mixed case strings are equal`() {
        let a = "HeLLo".caseInsensitive
        let b = "hEllO".caseInsensitive
        #expect(a == b)
    }
}

@Suite
struct `Format.Case.Insensitive - Hashing` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `Same case strings have same hash`() {
        let a = "hello".caseInsensitive
        let b = "hello".caseInsensitive
        #expect(a.hashValue == b.hashValue)
    }

    @Test
    func `Different case strings have same hash`() {
        let a = "hello".caseInsensitive
        let b = "HELLO".caseInsensitive
        #expect(a.hashValue == b.hashValue)
    }
}
