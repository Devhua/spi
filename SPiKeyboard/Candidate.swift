
enum CandidateType {
    case Empty, Special, English, Chinese, OnlyText, Custom
}

class Candidate {
    let type: CandidateType
    let text: String
    let shuangpinString: String?
    let englishString: String?
    let specialString: String?
    let customString: String?
    
    var queryCode: String {
        get {
            switch type {
            case .Empty:
                return ""
            case .Special:
                return specialString!
            case .English:
                return englishString!
            case .Chinese:
                return shuangpinString!
            case .Custom:
                return customString!
            default:
                assertionFailure("Wrong candidate type!")
            }
        }
    }
    
    var lengthAttribute: Int {
        get {
            switch type {
            case .Empty:
                return 0
            case .Special:
                return text.getReadingLength()
            case .English:
                return (text.getReadingLength() + 1) / 2
            case .Chinese:
                return text.getReadingLength()
            case .Custom:
                return text.getReadingLength()
            default:
                assertionFailure("Wrong candidate type!")
            }
        }
    }
    
    var shuangpinAttributeString: String {
        get {
            switch type {
            case .Empty:
                return ""
            case .Special:
                return specialString!
            case .English:
                return englishString!
            case .Chinese:
                return shuangpinString!
            case .Custom:
                return customString!
            default:
                assertionFailure("Wrong candidate type!")
            }
        }
    }
    
    var shengmuAttributeString: String {
        get {
            switch type {
            case .Empty:
                return ""
            case .Special:
                return String(specialString![specialString!.startIndex])
            case .English:
                return String(englishString![englishString!.startIndex]).lowercaseString
            case .Chinese:
                return getShengmuString(from: shuangpinString!)
            case .Custom:
                return String(customString![customString!.startIndex]).lowercaseString    // For special symbol, lowercaseString does not return different value.
            default:
                assertionFailure("Wrong candidate type!")
            }
        }
    }
    
    var typeAttributeString: String {
        get {
            switch type {
            case .Special:
                return String(3)
            case .English:
                return String(2)
            case .Chinese:
                return String(1)
            case .Custom:
                return String(4)
            default:
                assertionFailure("Wrong candidate type!")
            }
        }
    }
    
    init(text: String) {
        self.type = .OnlyText
        self.text = text
    }
    
    init(text: String, withShuangpinString shuangpin: String) {
        self.type = .Chinese
        self.text = text
        self.shuangpinString = shuangpin
    }
    
    init(text: String, withEnglishString english: String) {
        self.type = .English
        self.text = text
        self.englishString = english
    }
    
    init(text: String, withSpecialString special: String) {
        self.type = .Special
        self.text = text
        self.specialString = special
    }
    
    init(text: String, withCustomString custom: String) {
        self.type = .Custom
        self.text = text
        self.customString = custom
    }
    
    init(text: String, type: CandidateType, queryString: String) {
        switch type {
        case .Empty:
            assertionFailure("Candidate init fail!")
        case .Special:
            self.type = .Special
            self.text = text
            self.specialString = queryString
        case .English:
            self.type = .English
            self.text = text
            self.englishString = queryString
        case .Chinese:
            self.type = .Chinese
            self.text = text
            self.shuangpinString = queryString
        case .Custom:
            self.type = .Custom
            self.text = text
            self.customString = queryString
        default:
            assertionFailure("Wrong candidate type!")
        }
    }
    
    convenience init(text: String, queryString: String, isCustomCandidate: Bool) {
        var type = text.getCandidateType()
        self.init(text: text, type: isCustomCandidate ? .Custom : type, queryString: queryString)
    }
    
}