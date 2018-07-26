//
//  ContatoViewController.swift
//  Lista de Contatos
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class ContatoViewController: UIViewController {

    var nameStr: String?
    var foneStr: String?
    var imgTemp: UIImage?
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fone: UILabel!
    
    //--------------------------------------------------------------------------------------------------
    lazy var previewActions: [UIPreviewActionItem] = {
        func previewActionForTitle(_ title: String, style: UIPreviewActionStyle = .default) -> UIPreviewAction {
            return UIPreviewAction(title: title, style: style) { previewAction, viewController in
                print("Action: \(title)")
            }
        }
        
        // Action com o estilo padrão.
        let actionLigar = previewActionForTitle("Ligar para contato")
        
        // Action com o estilo "destructive".
        let action2 = previewActionForTitle("Ação Destrutiva", style: .destructive)
        
        // Actions agrupadas.
        let subAction1 = previewActionForTitle("Sub Action 1")
        let subAction2 = previewActionForTitle("Sub Action 2")
        let groupedActions = UIPreviewActionGroup(title: "Sub Actions…", style: .default, actions: [subAction1, subAction2])
        
        return [actionLigar, action2, groupedActions]
    }()
    
    // Adiciona as actions a lista de previewAcitions para as mesmas serem exibidas no swipe.
    // Sobrescreve uma propriedade padrão da classe UIViewController.
    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions
    }
    //--------------------------------------------------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let nameStr = nameStr {
            self.name.text = nameStr
        }
        
        if let foneStr = foneStr {
            self.fone.text = foneStr
        }
        
        if let imgTemp = imgTemp {
            self.img.image = imgTemp
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
