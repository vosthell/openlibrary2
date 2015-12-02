//
//  ViewController.swift
//  openLibrary
//
//  Created by Christian Kaiser on 20/11/15.
//  Copyright © 2015 Christian Kaiser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtResultado: UITextView!
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var txtTitulo: UITextField!
    
    func sincrono(){
        
        let isbn:String = txtISBN.text!
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        //let texto = NSString(data:datos!, encoding:NSUTF8StringEncoding)
        //print(texto!)
        //txtResultado.text=String(texto!)
        //print(datos)
        var autores : String = ""
        var autor : String = ""
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dico1 = json as! NSDictionary
            let dico2 = dico1["ISBN:"+isbn] as! NSDictionary
            txtTitulo.text = dico2["title"] as! NSString as String
            let dico3 = dico2["authors"] as? NSArray
            let contador:Int = dico3!.count
            for var index = 0; index < contador; index++ {
                let dico4 = dico3![index] as? NSDictionary
                
                autor = dico4!["name"] as? NSString as! String
                
                autores = autores + autor
                
            }
            
            
            
            
            //let dico3 = dico2["results"] as! NSDictionary
            //let dico4 = dico3["channel"] as! NSDictionary
            //let dico5 = dico4["location"] as! NSDictionary
            
            //self.lblCiudad.text = dico5["city"] as! NSString as String
        }
        catch _
        {}
        txtResultado.text =  autores
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //sincrono()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func ejecutar(sender: AnyObject) {
        sincrono()
        
    }
    @IBAction func limpiar(sender: AnyObject) {
        txtISBN.text=""
        
    }
}

