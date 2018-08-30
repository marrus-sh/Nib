/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// For use when attempting to constrain a facet with another, non-applicable facet.
	case facetConstraintMismatch

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

	/// Undefined escape sequences are not allowed in XSD Regular Expressions.
	case invalidEscapeInRegularExpression

	/// The provided `literal` does not exist in the lexical space for the type.
	case notInLexicalSpace

}