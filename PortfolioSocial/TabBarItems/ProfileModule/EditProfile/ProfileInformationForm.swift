import Foundation
import UIKit

enum FormItems: String, CaseIterable {
    case name = "Name"
    case username = "Username"
    case occupation = "Occupation"
    case bio = "Bio"
    case nothing = ""
}

class ProfileInformationForm: UIView, UITextViewDelegate {

    var listOfTextLabels = [UILabel]()
    var listOfTextViews = [UILabel]()
    var arrayOfTexts: [(String, String)]?
    let textView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, userInformation: UserInformation) {
        self.init(frame: frame)
        arrayOfTexts = [("Name", userInformation.name),
                        ("Username", userInformation.username),
                        ("Occupation", userInformation.occupation),
                        ("Bio", userInformation.bio)]

        var yValue: CGFloat = 0.0
        for (name, information) in arrayOfTexts! {
            listOfTextLabels.append(createTitles(text: name, information: information, yOffset: yValue))
            yValue += 50.0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTitles(info: UserInformation) {
        for (textView, item) in zip(listOfTextViews, FormItems.allCases) {
            textView.text = item.rawValue
        }
    }

    func createTitles(text: String, information: String?, yOffset: CGFloat) -> UILabel {
        let grayLabel = UILabel()
        grayLabel.backgroundColor = .clear

        if let info = information {
            if info == "" {
                grayLabel.text = text
                grayLabel.textColor = UIColor(rgb: 0xC4C3C7)
            } else {
                grayLabel.text = info
                grayLabel.textColor = .black
            }
        } else {
            fatalError()
        }

        grayLabel.font = UIFont.systemFont(ofSize: 15)
        grayLabel.textAlignment = .left

        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.frame = CGRect(x: 20, y: yOffset, width: self.frame.width, height: 0)

        grayLabel.numberOfLines = 0
        grayLabel.lineBreakMode = .byWordWrapping
        grayLabel.frame.size.width = self.frame.width / 4 * 3 - 10
        grayLabel.sizeToFit()
        grayLabel.frame.origin = CGPoint(x: self.frame.width / 4 + 10, y: yOffset + 16)
        let xOrigin = self.frame.width / 4
        let yOrigin = yOffset + grayLabel.frame.height + 32
        let width =  self.frame.width / 4 * 3
        addSubview(SeperatorLineView(frame: CGRect(x: xOrigin, y: yOrigin, width: width, height: 1)))

        label.frame.size.height = grayLabel.frame.height + 32

        addSubview(label)
        addSubview(grayLabel)
        listOfTextViews.append(grayLabel)
        return label
    }
}
