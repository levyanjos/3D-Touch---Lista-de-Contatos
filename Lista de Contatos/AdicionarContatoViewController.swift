//
//  AdicionarContatoViewController.swift
//  Lista de Contatos
//
//  Created by Ada 2018 on 25/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class AdicionarContatoViewController: UIViewController {

    var delegate: AdicionarContatoDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numeroField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func salvarContato(_ sender: UIBarButtonItem) {
        let newContato = Contato(nome: nameField.text!, fone: numeroField.text!, img: UIImage.init(named: "1")!)
        
        self.delegate?.adicionar(contato: newContato)
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}
