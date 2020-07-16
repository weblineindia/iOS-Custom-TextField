//
//  WLITextField.swift
//  WLISwiftLibrary
//
//  Created by WeblineIndia on 17/04/17.
//  Copyright © 2017 WeblineIndia. All rights reserved.
//

/**
Author Name  :  WeblineIndia  |  https://www.weblineindia.com/

For more such software development components and code libraries, visit us at
https://www.weblineindia.com/software-development-resources.html

Our Github URL : https://github.com/weblineindia
**/

import UIKit

//-----------------------------------------------------------------------

// MARK: - Enum

//-----------------------------------------------------------------------

enum kType: Int {
    case DefaultTextfield = 1
    case EmailTextField = 2
    case PasswordTextField = 3
    case PhoneNumberTextField = 4
}

//-----------------------------------------------------------------------

enum kTypeBorder: Int {
    case NoBorder = 0
    case BottomBorder = 1
    case TopBorder = 2
    case LeftBorder = 3
    case RightBorder = 4
}

//-----------------------------------------------------------------------

// MARK: - Protocol: WLITextFieldDelegate Methods

//-----------------------------------------------------------------------

@objc protocol WLITextFieldDelegate: NSObjectProtocol {
    @objc optional func WLITextFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    @objc optional func WLITextFieldDidBeginEditing(_ textField: UITextField)
    @objc optional func WLITextFieldShouldEndEditing(_ textField: UITextField) -> Bool
    @objc optional func WLITextFieldDidEndEditing(_ textField: UITextField)
    @objc optional func WLITextFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason)
    @objc optional func WLITextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, maxCharacters result: Bool) -> Bool
    @objc optional func WLITextFieldShouldClear(_ textField: UITextField) -> Bool
    @objc optional func WLITextFieldShouldReturn(_ textField: UITextField) -> Bool
    @objc optional func WLITextFielsShowAlertMessage (_ errorMessage: String)
}

//-----------------------------------------------------------------------

// MARK: - Class: WLITextField

//-----------------------------------------------------------------------

class WLITextField: UITextField {

    //-----------------------------------------------------------------------
    
    // MARK: - Properties: WLITextField
    
    //-----------------------------------------------------------------------
    
    let kTagHideText = 1155
    var typeBorder = kTypeBorder.NoBorder.rawValue
    var wliDelegate : WLITextFieldDelegate?
    var enterOnlyValidEmail : Bool = true
    var returnKeyPressToHideKeybord:Bool = true
    var allowCharacterOnly: String?
    
    //-----------------------------------------------------------------------
    
    // MARK: - Initialization Methods
    
    //-----------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    //-----------------------------------------------------------------------
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Custom Methods
    
    //-----------------------------------------------------------------------
    
    func initialSetup() {
        self.delegate = self
        self.layoutIfNeeded()
        addTarget(self, action: #selector(textEditingDidBegin(textField:)), for: .editingDidBegin)
        addTarget(self, action: #selector(textEditingDidBegin(textField:)), for: .editingChanged)
    }
    
    //-----------------------------------------------------------------------
    
    func checkForMaxCharacters(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount) {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= maxCharacter
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Action Methods
    
    //-----------------------------------------------------------------------
    
    @objc func textEditingDidBegin(textField: UITextField) {
        if type == kType.PhoneNumberTextField.rawValue {
            updateTextWithPosition()
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - ThemeColor, BorderWidth, BorderColor, CornerRadius Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var theme: Bool = false {
        didSet {
            setLeftView()
            setBorder()
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var themeColor: UIColor = .black {
        didSet {
            setLeftView()
            setBorder()
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setBorder()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            setBorder()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setBorder()
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Left View Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var leftSide: Bool = false {
        didSet {
            setLeftView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var leftSideRect: CGRect = .init(x: 10, y: 10, width: 30, height: 30) {
        didSet {
            setLeftView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var leftImage : UIImage? = nil {
        didSet {
            setLeftView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var ltTintColor: UIColor = .black {
        didSet {
            setLeftView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return leftSideRect
    }
    
    //-----------------------------------------------------------------------
    
    func setLeftView() {
        
        // Set Left View
        if leftSide && leftImage != nil {
            leftViewMode = .always
            let imageView = UIImageView(frame: leftSideRect)
            imageView.contentMode = .scaleAspectFit
            imageView.image = leftImage
            imageView.tintColor = self.theme ? self.themeColor : self.ltTintColor
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Right View Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rightSide: Bool = false {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rightSideRect: CGRect = .init(x: 10, y: 10, width: 30, height: 30) {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rightImage : UIImage? = nil {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rtTintColor: UIColor = .black {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: (self.frame.size.width - rightSideRect.size.width - rightSideRect.origin.x), y: rightSideRect.origin.y, width: rightSideRect.size.width, height: rightSideRect.size.height)
    }
    
    //-----------------------------------------------------------------------
    
    func setRightView() {
        
        // Set Right View
        if rightSide && rightImage != nil {
            rightViewMode = .always
            if type == kType.PasswordTextField.rawValue {
                let button = UIButton(frame: rightSideRect)
                if showPasswordImage != nil {
                    button.setImage(showPasswordImage, for: .selected)
                }
                button.setImage(rightImage, for: .normal)
                button.imageView?.tintColor = button.tag == kTagHideText ?  self.theme ? self.themeColor : hidePasswordImageTintColor :   self.theme ? self.themeColor : showPasswordImageTintColor
                button.addTarget(self, action: #selector(showHideText(sender:)), for: .touchUpInside)
                button.tag = kTagHideText
                self.rightView = button
            } else {
                let imageView = UIImageView(frame: rightSideRect)
                imageView.contentMode = .scaleAspectFit
                imageView.image = rightImage
                imageView.tintColor =  self.theme ? self.themeColor : rtTintColor
                rightView = imageView
            }
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Password Field Images
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var showPasswordImage : UIImage? = nil {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var showPasswordImageTintColor : UIColor? = nil {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var hidePasswordImage : UIImage? = nil {
        didSet {
            rightImage = hidePasswordImage
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var hidePasswordImageTintColor : UIColor? = nil {
        didSet {
            setRightView()
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Padding Methods (Left Padding, Right Padding)
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rightPadding : CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var xPos = leftPadding
        if leftView != nil {
            xPos = (leftView?.frame.origin.x)! + (leftView?.frame.size.height)! + leftPadding
        }
        var width = bounds.size.width - rightPadding - xPos
        if rightView != nil {
            width = (rightView?.frame.origin.x)! - rightPadding - xPos
        }
        return CGRect(x: xPos, y: bounds.origin.y, width: width, height: bounds.size.height)
    }
    
    //-----------------------------------------------------------------------
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var xPos = leftPadding
        if leftView != nil {
            xPos = (leftView?.frame.origin.x)! + (leftView?.frame.size.height)! + leftPadding
        }
        var width = bounds.size.width - rightPadding - xPos
        if rightView != nil {
            width = (rightView?.frame.origin.x)! - rightPadding - xPos
        }
        return CGRect(x: xPos, y: bounds.origin.y, width: width, height: bounds.size.height)
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - TextField's Type Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var type : Int = kType.DefaultTextfield.rawValue {
        didSet {
            setType(type: type)
        }
    }
    
    //-----------------------------------------------------------------------
    
    func setType(type: Int) {
        
        switch type {
            
        case kType.DefaultTextfield.rawValue:
            print("Default TextField")
            self.keyboardType = .default
            
        case kType.EmailTextField.rawValue:
            print("Email TextField")
            self.keyboardType = .emailAddress
            
        case kType.PasswordTextField.rawValue:
            print("Password TextField")
            self.keyboardType = .default
            self.isSecureTextEntry = true
            
        case kType.PhoneNumberTextField.rawValue:
            print("Password TextField")
            self.keyboardType = .phonePad
            
        default:
            self.keyboardType = .default
            break
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Password Show Hide Methods
    
    //-----------------------------------------------------------------------
    
    @objc func showHideText(sender: UIButton) {
        print("showHideText")
        if rightView != nil {
            if self.rightView?.tag == kTagHideText {
                self.isSecureTextEntry = false
                self.rightView?.tag = 0
                (self.rightView as! UIButton).isSelected = true
            } else {
                self.isSecureTextEntry = true
                self.rightView?.tag = kTagHideText
                (self.rightView as! UIButton).isSelected = false
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Phone Number Format (Masking) Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable open var Template: String = ""
    
    //-----------------------------------------------------------------------
    
    // Replacement symbol, it use for formattingTemplate as is as pattern for replacing. Default is "#"
    @IBInspectable open var formattingReplacementChar = "#"
    
    //-----------------------------------------------------------------------
    
    // Allowable symbols for entering. Uses only if formattingTemplate is not empty. Default is "", that is all symbols.
    @IBInspectable open var Characters: String = ""
        {
        didSet {
            if Characters.isEmpty {
                formattingEnteredCharSet = CharacterSet().inverted
            } else {
                formattingEnteredCharSet = CharacterSet(charactersIn: Characters)
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    // You can use formattingEnteredCharacters or this from code.
    open var formattingEnteredCharSet: CharacterSet = CharacterSet()
    
    //-----------------------------------------------------------------------
    
    /// Move the cursore to the position
    internal func goTo(textPosition: UITextPosition) {
        selectedTextRange = textRange(from: textPosition, to: textPosition)
    }
    
    //-----------------------------------------------------------------------
    
    /// Return clear text without formatting. This algorithm clear all symbols if formattingEnteredCharSet doesn't contain its. The Position needed for shifting cursor
    public func getSimpleUnformattedText(with text: String, position: inout Int) -> String {
        guard Template.isEmpty == false, formattingEnteredCharSet.isEmpty == false
            else {
                return text
        }
        var result = ""
        var index = 0
        for char in text {
            let unicodeScalars = String(char).unicodeScalars
            if formattingEnteredCharSet.contains(UnicodeScalar.init((unicodeScalars.first?.value)!)!) {
                result.append(char)
                index = index + 1
            } else {
                if position > index {
                    position = position - 1
                }
            }
        }
        return result
    }
    
    //-----------------------------------------------------------------------
    
    /// Transform text to match with formattingTemplate. The Position needed for shifting cursor
    public func getFormattedText(with text: String, position: inout Int) -> String {
        guard Template.isEmpty == false else {
            return text
        }
        
        let result = text
        
        if result.count > 0 && Template.count > 0 {
            
            let patternes = Template.components(separatedBy: String(formattingReplacementChar))
            
            var formattedResult = ""
            var index = 0
            let startPosition = position
            for character in result {
                if patternes.count > index {
                    let patternString = patternes[index]
                    formattedResult = formattedResult + patternString
                    if startPosition > index {
                        position = position + patternString.count
                    }
                }
                
                formattedResult = formattedResult + String(character)
                index = index + 1
            }
            
            if Template.count < formattedResult.count {
                formattedResult = formattedResult.substring(to: Template.endIndex)
            }
            
            return formattedResult
        }
        
        return text
    }
    
    //-----------------------------------------------------------------------
    
    /// Return clear text without formatting. This algorithm work only by formattingTemplate. If text doesn't match pattern, then it doesn't guarantee expected result.
    public func getUnformattedText(with text: String) -> String {
        guard Template.isEmpty == false else {
            return text
        }
        
        let result = text
        
        if result.count > 0 && Template.count > 0 {
            
            let patternes = Template.components(separatedBy: String(formattingReplacementChar))
            
            var unformattedResult = ""
            var index = result.startIndex
            for pattern in patternes {
                if pattern.count > 0 {
                    let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                    if let range = result.range(of: pattern, options: .forcedOrdering, range: range, locale: nil)
                    {
                        if index != range.lowerBound {
                            if let endIndex = result.index(range.lowerBound, offsetBy: 0, limitedBy: result.endIndex) {
                                let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: endIndex))
                                unformattedResult = unformattedResult + result.substring(with: range)
                            } else {
                                break
                            }
                        }
                        index = range.upperBound
                    } else
                    {
                        let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                        unformattedResult = unformattedResult + result.substring(with: range)
                        break
                    }
                }
            }
            
            return unformattedResult
        }
        return text
    }
    
    //-----------------------------------------------------------------------
    
    /// update text for showing
    fileprivate func updateTextOnly(offset: inout Int)
    {
        let unformattedText = getSimpleUnformattedText(with: text ?? "", position: &offset)
        let formattedText = getFormattedText(with: unformattedText, position: &offset)
        
        attributedText = getAttributedText(with: formattedText, enteredTextAttributes: nil)
    }
    
    //-----------------------------------------------------------------------
    
    /// update text for showing
    public func updateTextWithPosition() {
        guard let selectedTextRange = selectedTextRange else {
            if let text = text, text.isEmpty == false {
                var offset = 0
                updateTextOnly(offset: &offset)
            }
            return
        }
        let selectedPositon = selectedTextRange.start
        var offset = self.offset(from: self.beginningOfDocument, to: selectedPositon)
        
        updateTextOnly(offset: &offset)
        
        if let position = position(from: self.beginningOfDocument, offset: offset) {
            goTo(textPosition: position)
        } else {
            goTo(textPosition: selectedPositon)
        }
    }
    
    //-----------------------------------------------------------------------
    
    /// Return attributed text for showing prepared text
    open func getAttributedText(with text: String, enteredTextAttributes: [NSAttributedString.Key: Any]? = nil) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)
        let startEnteredPosition = 0
        let stopEnteredPosition = text.count
        
        if let enteredTextAttributes = enteredTextAttributes {
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(startEnteredPosition, stopEnteredPosition - startEnteredPosition))
            
        }
        
        return attributedString
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Maximum Characters
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var maxCharacter : Int = Int.max {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Disable Copy, Paste, Cut
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var allowCopyCut : Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var allowPaste : Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var selectable : Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //-----------------------------------------------------------------------
    
    // MARK: - Set Border Methods
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var bottomBorder : Bool = true {
        didSet {
            if bottomBorder {
                typeBorder = kTypeBorder.BottomBorder.rawValue
                setBorder()
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var topBorder : Bool = true {
        didSet {
            if topBorder {
                typeBorder = kTypeBorder.TopBorder.rawValue
                setBorder()
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var leftBorder : Bool = true {
        didSet {
            if leftBorder {
                typeBorder = kTypeBorder.LeftBorder.rawValue
                setBorder()
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    @IBInspectable var rightBorder : Bool = true {
        didSet {
            if rightBorder {
                typeBorder = kTypeBorder.RightBorder.rawValue
                setBorder()
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    func setBorder() {
        self.layoutIfNeeded()
        
        if bottomBorder && topBorder && leftBorder && rightBorder && (self.typeBorder == kTypeBorder.NoBorder.rawValue) {
            self.clipsToBounds = true
            self.layer.borderWidth = self.borderWidth
            self.layer.cornerRadius = self.cornerRadius
            self.layer.borderColor = self.theme ? self.themeColor.cgColor : self.borderColor.cgColor
        } else {
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 0
            self.layer.borderColor = UIColor.clear.cgColor
            
            borderStyle = .none
            let border = CALayer()
            let borderWidth = self.borderWidth
            border.borderColor = self.theme ? self.themeColor.cgColor : self.borderColor.cgColor
            border.borderWidth = borderWidth
            
            switch typeBorder {
            case kTypeBorder.BottomBorder.rawValue:
                border.frame = CGRect(origin: CGPoint(x: 0,y :frame.size.height - borderWidth), size: CGSize(width: frame.size.width, height: borderWidth))
            case kTypeBorder.TopBorder.rawValue:
                border.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: frame.size.width, height: borderWidth))
            case kTypeBorder.LeftBorder.rawValue:
                border.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: borderWidth, height: frame.size.width))
            case kTypeBorder.RightBorder.rawValue:
                border.frame = CGRect(origin: CGPoint(x: frame.size.width, y :0), size: CGSize(width: borderWidth, height: frame.size.width))
            default:
                break
            }
            
            layer.addSublayer(border)
            layer.masksToBounds = true
        }
    }    
}


//-----------------------------------------------------------------------

// MARK: - UITextFieldDelegate Methods

//-----------------------------------------------------------------------

extension WLITextField : UITextFieldDelegate {
  
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldShouldBeginEditing(_:))))! {
                return (wliDelegate?.WLITextFieldShouldBeginEditing!(textField))!
            }
        }
        return true
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldDidBeginEditing(_:))))! {
                (wliDelegate?.WLITextFieldDidBeginEditing!(textField))!
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldShouldEndEditing(_:))))! {
                return (wliDelegate?.WLITextFieldShouldEndEditing!(textField))!
            }
        }
        return true
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldDidEndEditing(_:))))! {
                (wliDelegate?.WLITextFieldDidEndEditing!(textField))!
            }
        }
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldDidEndEditing(_:reason:))))! {
                (wliDelegate?.WLITextFieldDidEndEditing!(textField, reason: reason))!
            }
            if self.keyboardType == .emailAddress {
                if (enterOnlyValidEmail == true) {
                    if(textField.text!.count > 0 ){
                        if (isValid(textField.text!) == false){
                            wliDelegate?.WLITextFielsShowAlertMessage?("Enter valid email id")
                        }
                    }
                }
            }
        }
    }
    
    
   
    //-----------------------------------------------------------------------
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextField(_:shouldChangeCharactersIn:replacementString:maxCharacters:))))! {
                let result = checkForMaxCharacters(textField, shouldChangeCharactersIn: range, replacementString: string)
                if result == false {
                    return false
                }
                if (allowCharacterOnly != nil) {
                    let aSet = NSCharacterSet(charactersIn:allowCharacterOnly!).inverted
                    let compSepByCharInSet = string.components(separatedBy: aSet)
                    let numberFiltered = compSepByCharInSet.joined(separator: "")
                    return string == numberFiltered
                }
                return (wliDelegate?.WLITextField!(textField, shouldChangeCharactersIn: range, replacementString: string, maxCharacters: result))!
            }else {
                let result = checkForMaxCharacters(textField, shouldChangeCharactersIn: range, replacementString: string)
                if result == false {
                    return false
                }
                if (allowCharacterOnly != nil) {
                    let aSet = NSCharacterSet(charactersIn:allowCharacterOnly!).inverted
                    let compSepByCharInSet = string.components(separatedBy: aSet)
                    let numberFiltered = compSepByCharInSet.joined(separator: "")
                    return string == numberFiltered
                }
            }
        }
        return true
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldShouldClear(_:))))! {
                return (wliDelegate?.WLITextFieldShouldClear!(textField))!
            }
        }
        return true
    }
    
    //-----------------------------------------------------------------------
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if wliDelegate != nil{
            if (wliDelegate?.responds(to: #selector(WLITextFieldDelegate.WLITextFieldShouldReturn(_:))))! {
                return (wliDelegate?.WLITextFieldShouldReturn!(textField))!
            }
        }
        if returnKeyPressToHideKeybord == true
        {
            self.endEditing(true)
        }
        return true
    }
    
    
    //-----------------------------------------------------------------------
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        // Disable Copy & Cut
        if action == #selector(copy(_:)) || action == #selector(cut(_:)) {
            return !allowCopyCut
        }
        
        // Disable Paste
        if action == #selector(paste(_:)) {
            return !allowPaste
        }
        
        // Disable Selectable
        if action == #selector(select(_:)) || action == #selector(selectAll(_:)) {
            return selectable
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    //-----------------------------------------------------------------------
    
    //validate enter email id
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
