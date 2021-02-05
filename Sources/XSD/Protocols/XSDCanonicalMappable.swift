public protocol XSDCanonicalMappable:
	Codable,
	LosslessStringConvertible,
	TextOutputStreamable,
	XSDLexicallyRepresentable
{

	var ·canonicalMapping·: Self.LexicalRepresentation
	{ get }

	init(
		mapping literal: Self.LexicalRepresentation
	)

}

public extension XSDCanonicalMappable {

	@inlinable
	var description: String {
		return String(
			describing: ·canonicalMapping·
		)
	}

	@inlinable
	init (
		from decoder: Decoder
	) throws {
		try self = Self.LexicalRepresentation(
			from: decoder
		).·lexicalMapping·
	}

	@inlinable
	func encode (
		to encoder: Encoder
	) throws {
		try ·canonicalMapping·.encode(
			to: encoder
		)
	}

	@inlinable
	func write <Target> (
		to target: inout Target
	)
	where Target: TextOutputStream {
		·canonicalMapping·.write(
			to: &target
		)
	}

}
