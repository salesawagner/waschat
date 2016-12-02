// Completions
typealias Completion				= () -> Void
typealias CompletionSuccess			= (_ success: Bool) -> Void
typealias CompletionSuccessList		= (_ success: Bool, _ places: [Any]?) -> Void
typealias CompletionSuccessObject	= (_ success: Bool, _ place: Any?) -> Void
