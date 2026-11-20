//
//  ReservationViewController.swift
//  1120
//
//  Created by 伊藤瞭汰 on 2026/11/20.
//

import UIKit

private enum ReservationError: Error {
    case invalidName
    case invalidPeople
}

final class ReservationViewController: UIViewController {
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var peopleField: UITextField!
    @IBOutlet private weak var noteField: UITextField!
    @IBAction func resaveButtonDidTap(_ sender: UIButton) {
        self.view.endEditing(true)
        let trimmedPeople = (peopleField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let people = Int(trimmedPeople) ?? 0
        do {
            let reservation = try Reservation(name: nameField.text ?? "", people: people, note: noteField.text ?? "")
            resultLabel.text = "\(reservation.name)さん \(reservation.people)名で予約しました"
            nameField.text = ""
            peopleField.text = ""
            noteField.text = ""
        } catch ReservationError.invalidName {
            resultLabel.text = "名前は1〜20文字で入力してください"
        } catch ReservationError.invalidPeople {
            resultLabel.text = "人数は1〜4名の数字で入力してください"
        } catch {
            resultLabel.text = "名前と人数を確認してください"
        }
    }
    @IBOutlet private weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "料理教室予約ページ"
        resultLabel.text = "名前と人数を入力してください"
        
        nameField.delegate = self
        peopleField.delegate = self
        noteField.delegate = self
    }
}

extension ReservationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField != noteField else {
            self.view.endEditing(true)
            return true
        }
        
        textField.resignFirstResponder()
        if textField == nameField {
            peopleField.becomeFirstResponder()
        }
        if textField == peopleField {
            noteField.becomeFirstResponder()
        }
        
        return true
    }
}

private struct Reservation {
    let name: String
    let people: Int
    let note: String
    
    init(name: String, people: Int, note: String) throws {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedName.count > 0 && trimmedName.count <= 20 else { throw ReservationError.invalidName }
        guard people > 0 && people <= 4 else { throw ReservationError.invalidPeople }
        
        self.name = trimmedName
        self.people = people
        self.note = trimmedNote
    }
}
