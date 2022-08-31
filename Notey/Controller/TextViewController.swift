//
//  TextViewController.swift
//  Notey
//
//  Created by Iury Vasconcelos on 31/08/22.
//

import UIKit
import CoreData

class TextViewController: UIViewController {
        
    @IBOutlet weak var textBox: UITextView!
    
    var textView = [NoteyText]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: NoteyCategory? {
        didSet {
            loadText()
        }
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveText() {

        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func loadText(with request: NSFetchRequest<NoteyText> = NoteyText.fetchRequest(), and predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "noteyTextCat.title MATCHES %@", selectedCategory!.title!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [addtionalPredicate, categoryPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        do {
            textView = try context.fetch(request)
        } catch {
            print("Error fetching context: \(error)")
        }
    }
}
//MARK: - UITextViewDelegate

extension TextViewController: UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBox.delegate = self
        textBox.text = textView[0].text ?? ""

        //MARK: - UITextView Customize
        textBox.autocorrectionType = .no
        textBox.backgroundColor = .secondarySystemBackground
        textBox.textColor = .label
        textBox.font = UIFont.systemFont(ofSize: 20)
        textBox.layer.cornerRadius = 20
        textBox.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //MARK: - UITextView Shadow
        textBox.layer.shadowColor = UIColor.gray.cgColor;
        textBox.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        textBox.layer.shadowOpacity = 0.4
        textBox.layer.shadowRadius = 20
        textBox.layer.masksToBounds = false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let newText = NoteyText(context: context)
        newText.text = textBox.text
        newText.noteyTextCat = selectedCategory
        saveText()
        return true
    }
}
