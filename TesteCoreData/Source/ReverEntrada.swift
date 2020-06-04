//
//  ReverEntrada.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 03/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class reverEntradas: UIViewController {
    @IBOutlet weak var textViewEntrada: UITextView!
    @IBOutlet weak var viewEntrada: UIView!
    @IBOutlet weak var labelData: UILabel!
    var nota: NSManagedObject!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        textViewEntrada.text = nota.value(forKey: "corpoTexto") as? String
        labelData.text = nota.value(forKey: "labelData") as? String
        estetica(view: viewEntrada, textView: textViewEntrada)
    }
    
    func estetica(view: UIView, textView: UITextView){
        view.layer.cornerRadius = 50
        textView.layer.cornerRadius = 50
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
