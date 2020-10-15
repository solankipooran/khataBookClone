//
//  ProfileViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 21/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import CoreData
struct profileoptions {
    var icon : String
    var optionsname :  String
    var profileimage :  String?
    var extralabel : String?
    var arrowimage : String?
}

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    var optionsarray : [profileoptions] = []
    var typeVC = 0
    var imagert : UIImage? = nil
    @IBOutlet weak var profileOptionstableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func selectImagebtn(_ sender: Any) {
        imagePickerAlertController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let business = UserDefaults.standard.string(forKey: "businessName")
        let username = UserDefaults.standard.string(forKey: "username")
        let registerNumber = UserDefaults.standard.string(forKey: "phonenumber")
        title = "Profile"
        let icon = ["Camera","ProfileSelcted","Business" ,"Phone" ,"Language" ,"Applock"]
        let optionsname = ["Business Photo" , "Your Name" , "Business Name" , "Registered Number" , "App Language" ,"App Lock"]
        let profileimage : [String?] = ["Profile", nil,nil,nil,nil,nil]
        let extralabel = [nil ,"\(username!)","\(business!)","\(registerNumber!)","App Language",nil]
        let arrorimage = ["Arrow","Arrow","Arrow",nil,"Arrow","Arrow",]
        optionsarray.removeAll()
        for i in 0..<6{
            optionsarray.append(profileoptions(icon: icon[i], optionsname: optionsname[i], profileimage: profileimage[i], extralabel: extralabel[i],arrowimage: arrorimage[i] ))
        }
        profileOptionstableView.reloadData()
    }
    
    func imagePickerAlertController(){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker(sourceType: .camera)
            }else{
                AlertController.showalert(title: nil, message: " Camera Not Available", action: "OK", vc: self)
            }
        })
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.imagePicker(sourceType: .photoLibrary)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cameraAction)
        controller.addAction(galleryAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePicker(sourceType : UIImagePickerController.SourceType){
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagert = info[.originalImage] as? UIImage
    }
    
}

extension ProfileViewController : UITableViewDataSource , UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else{
            return UITableViewCell()
        }
        cell.icon.image = UIImage(named: optionsarray[indexPath.row].icon)
        cell.optionname.text = optionsarray[indexPath.row].optionsname
        if let imageName = optionsarray[indexPath.row].profileimage {
            cell.profileimage.image = UIImage(named: "Profile" )
        } else {
            cell.profileimage.image = nil
        }
        if let arraowImage = optionsarray[indexPath.row].arrowimage{
            cell.arrowImage.image = UIImage(named: arraowImage)
        }else{
            cell.arrowImage.image = nil
        }
        cell.extralabel.text = optionsarray[indexPath.row].extralabel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.row == 0{
            cell?.isUserInteractionEnabled = false
        }else if indexPath.row == 1{
            editorvc(type: 1)
        }else if indexPath.row == 2{
            editorvc(type: 2)
        }else if indexPath.row == 3{
            cell?.isUserInteractionEnabled = false
        }else if indexPath.row == 4{
            
        }else if indexPath.row == 5{
            
        }else{
            print("Error")
        }
    }
    func editorvc(type : Int){
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard  let editorVc = story.instantiateViewController(identifier: "EditBusinessAndYourNameViewController") as? EditBusinessAndYourNameViewController else{
            return
        }
        editorVc.vcType = type
        self.navigationController?.pushViewController(editorVc, animated: true)
    }
    
    
}
