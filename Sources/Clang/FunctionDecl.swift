#if !NO_SWIFTPM
import cclang
#endif

/// Describes the calling convention of a function type
public enum CallingConvention {
    case `default`
    case c
    case x86StdCall
    case x86FastCall
    case x86ThisCall
    case x86Pascal
    case aapcs
    case aapcs_vfp
    case intelOclBicc
    case x86_64Win64
    case x86_64SysV
    case x86VectorCall
    case swift
    case preserveMost
    case preserveAll
    case unexposed

    init?(clang: CXCallingConv) {
        switch clang {
        case CXCallingConv_Default: self = .default
        case CXCallingConv_C: self = .c
        case CXCallingConv_X86StdCall: self = .x86StdCall
        case CXCallingConv_X86FastCall: self = .x86FastCall
        case CXCallingConv_X86ThisCall: self = .x86ThisCall
        case CXCallingConv_X86Pascal: self = .x86Pascal
        case CXCallingConv_AAPCS: self = .aapcs
        case CXCallingConv_AAPCS_VFP: self = .aapcs_vfp
        case CXCallingConv_IntelOclBicc: self = .intelOclBicc
        case CXCallingConv_X86_64Win64: self = .x86_64Win64
        case CXCallingConv_X86_64SysV: self = .x86_64SysV
        case CXCallingConv_X86VectorCall: self = .x86VectorCall
        case CXCallingConv_Swift: self = .swift
        case CXCallingConv_PreserveMost: self = .preserveMost
        case CXCallingConv_PreserveAll: self = .preserveAll
        case CXCallingConv_Invalid: return nil
        case CXCallingConv_Unexposed: self = .unexposed
        default: fatalError("invalid CXCallingConv \(clang)")
        }
    }
}

/// Property attributes for an Objective-C @property declaration.
public struct ObjCPropertyAttributes: OptionSet {
    public typealias RawValue = CXObjCPropertyAttrKind.RawValue
    public let rawValue: RawValue
    /// Creates a new ObjCPropertyAttributes from a raw integer value.
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    public static let noattr = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_noattr.rawValue)
    public static let readonly = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_readonly.rawValue)
    public static let getter = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_getter.rawValue)
    public static let assign = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_assign.rawValue)
    public static let readwrite = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_readwrite.rawValue)
    public static let retain = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_retain.rawValue)
    public static let copy = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_copy.rawValue)
    public static let nonatomic = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_nonatomic.rawValue)
    public static let setter = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_setter.rawValue)
    public static let atomic = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_atomic.rawValue)
    public static let weak = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_weak.rawValue)
    public static let strong = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_strong.rawValue)
    public static let unsafe_unretained = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_unsafe_unretained.rawValue)
    public static let `class` = ObjCPropertyAttributes(rawValue:
        CXObjCPropertyAttr_class.rawValue)
}
