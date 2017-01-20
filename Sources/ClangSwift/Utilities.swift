import cclang

internal extension Bool {
    func asClang() -> Int32 {
        return self ? 1 : 0
    }
}

internal func convertCursor(_ clang: CXCursor) -> Cursor {
    switch (clang as Cursor).kind {
    default:
        return clang
    }
}

extension CXString {
    func asSwift() -> String {
        guard self.data != nil else { return "" }
        defer { clang_disposeString(self) }
        return String(cString: clang_getCString(self))
    }
}

extension Collection where Iterator.Element == String, IndexDistance == Int {
    func withCArrayOfCStrings<Result>(_ f: (UnsafeMutablePointer<UnsafePointer<Int8>?>) throws -> Result) rethrows -> Result {
        let ptr = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: self.count)
        defer  { freelist(ptr, count: self.count) }
        for (idx, str) in enumerated() {
            str.withCString { cStr in
                ptr[idx] = strdup(cStr)
            }
        }
        return try f(unsafeBitCast(ptr, to: UnsafeMutablePointer<UnsafePointer<Int8>?>.self))
    }
}

func freelist<T>(_ ptr: UnsafeMutablePointer<UnsafeMutablePointer<T>?>, count: Int) {
    for i in 0..<count {
        free(ptr[i])
    }
    free(ptr)
}