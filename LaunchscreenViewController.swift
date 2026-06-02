//
//  LaunchscreenViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 13/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import MBProgressHUD
import AuthenticationServices


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class LaunchscreenViewController: UIViewController,GIDSignInDelegate {
    
    @IBOutlet weak var stackviewfacebbok: UIStackView!
    @IBOutlet weak var stackviewgoogle: UIStackView!
    @IBOutlet weak var btntermscondition: UIButton!
    @IBOutlet weak var btncontinueemail: UIButton!
    @IBOutlet weak var btncontinuefb: UIButton!
    @IBOutlet weak var btnprivacystatement: UIButton!
    @IBOutlet weak var btncontinuegoogle: UIButton!
    @IBOutlet weak var btncreateaccount: UIButton!
    var hud:MBProgressHUD!
    var username=String()
    var useremail=String()
    var usermobile=String()
    var uniqueid=String()
    var loginflagfood=Int()
    var searchroomflag=Int()
    var productlistingflag=Int()
    var device_id=String()
    var device_token=String()
    
    @IBOutlet weak var btnapplesignin: ASAuthorizationAppleIDButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     setupLoginWithAppleButton()
        
      setupAppleIDCredentialObserver()
        
        // performExistingAccountSetupFlows()
        
        
        
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont(name: "ProximaNova-Bold", size: 14)!,
            NSAttributedString.Key.foregroundColor : UIColor(red: 112 / 255, green: 247 / 255, blue: 188 / 255, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue]
        let attributeString = NSMutableAttributedString(string: "Terms & Conditions",
                                                        attributes: yourAttributes)
        btntermscondition.setAttributedTitle(attributeString, for: .normal)
        
        let attributeString1 = NSMutableAttributedString(string: "Privacy Statement",
                                                         attributes: yourAttributes)
        
        btnprivacystatement.setAttributedTitle(attributeString1, for: .normal)
        
        btncontinuegoogle.layer.cornerRadius=5
        // btncontinueemail.layer.borderColor=UIColor.
        btncontinuefb.layer.cornerRadius=15
        self.navigationController?.isNavigationBarHidden = true
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        btncontinuegoogle.layer.borderWidth=1
        btncontinuegoogle.layer.borderColor=UIColor.black.cgColor
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(googleAction))
        self.stackviewgoogle.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(fbAction))
        self.stackviewfacebbok.addGestureRecognizer(gesture2)
        
        
        if let  deviceid=UserDefaults.standard.value(forKey: "device_id"){
            device_id=UserDefaults.standard.value(forKey: "device_id") as! String
        }
        if let devicetoken=UserDefaults.standard.value(forKey: "fcm_token"){
            device_token=UserDefaults.standard.value(forKey: "fcm_token") as! String
        }
        if let user_id=UserDefaults.standard.value(forKey: "userid"){
            
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
            
            self.navigationController?.pushViewController(home, animated: true)
        }
        
        if let currentToken = FileManager.default.ubiquityIdentityToken {
            print("currenttoken",currentToken)
           
        }
        else {
           
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    private func setupLoginWithAppleButton() {
       
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        authorizationButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-30, height: 40)
//         authorizationButton.center = self.view.center
    
        
      authorizationButton.addTarget(self, action: #selector(handleLogInWithAppleIDButtonPress), for: .touchUpInside)
       btnapplesignin.addSubview(authorizationButton)
    }
    
    
    
    @objc private func handleLogInWithAppleIDButtonPress() {
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
        
//        let authorizationPasswordProvider = ASAuthorizationPasswordProvider()
//        let authorizationPasswordRequest = authorizationPasswordProvider.createRequest()
        
      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.performRequests()
    }
    
    func setupAppleIDCredentialObserver() {
      let authorizationAppleIDProvider = ASAuthorizationAppleIDProvider()

      authorizationAppleIDProvider.getCredentialState(forUserID: "currentUserIdentifier") { (credentialState: ASAuthorizationAppleIDProvider.CredentialState, error: Error?) in
        if let error = error {
          print("error")
          // Something went wrong check error state
          return
        }
        switch (credentialState) {
        case .authorized:
            print("authorized")
//           let homepage = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
//            self.navigationController?.pushViewController(homepage, animated: true)
          break
        case .revoked:
              print("revoked")
              UserDefaults.standard.removeObject(forKey: "userid")
               UserDefaults.standard.removeObject(forKey: "uniqueidforguest")
//              let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                             self.navigationController?.pushViewController(launch, animated: true)
          break
        case .notFound:
          //User is not found, meaning that the user never signed in through Apple ID
             print("notFound")
             UserDefaults.standard.removeObject(forKey: "userid")
                UserDefaults.standard.removeObject(forKey: "uniqueidforguest")
//             let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//             self.navigationController?.pushViewController(launch, animated: true)
          break
        default: break
        }
      }
    }
    
    
    
    @IBAction func btncontinueemailaction(_ sender: Any) {
        let login = self.storyboard?.instantiateViewController (withIdentifier: "LoginViewController") as! LoginViewController
        login.searchroom_flag=searchroomflag
        
        self.navigationController?.pushViewController(login, animated: true)
    }
    @objc func googleAction(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func btncreateaccountaction(_ sender: Any) {
        
        let registration = self.storyboard?.instantiateViewController (withIdentifier: "RegistrationViewController") as! RegistrationViewController
          registration.searchroom_flag=searchroomflag
        self.navigationController?.pushViewController(registration, animated: true)
        
    }
    
    @IBAction func btncontinuewithgoogle(_ sender: Any) {
        
        
        GIDSignIn.sharedInstance()?.signIn()
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        // let phnenumber=user.profile.
        print("fullName",fullName)
        print("idToken",idToken)
        print("userId",userId)
        if fullName != nil||fullName != ""{
            
            username=fullName!
            useremail=email!
            uniqueid=idToken!
            
            UserDefaults.standard.set(userId, forKey: "useridfororderhistory")
            UserDefaults.standard.set(userId, forKey: "uniqueidforguest")
            
        }
        service_insert_guest()
        
        
    }
    
    
    @IBAction func btncontinuefb(_ sender: Any) {
        fbAction()
        
    }
    @objc func  fbAction(){
        let fbLoginManager : LoginManager = LoginManager()
       
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    
                    //                       if((AccessToken.current) != nil){
                    //                                            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, mobile"]).start(completionHandler: { (connection, result, error) -> Void in
                    //                                                if (error == nil){
                    //                                                    //everything works print the user data
                    //                                                    print(result as Any)
                    //                                                    let dict = result as! NSDictionary
                    //
                    //                                                    self.get_fblogin_details(dict: dict)
                    //
                    //
                    //
                    //                                                }
                    //
                    //                                            })
                    //
                    //
                    //                                }
                   // self.showhud()
//                    let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
//                    home.accesstokenfb=AccessToken.current!
//                     home.fbflag=1
//                    DispatchQueue.main.async {
//                         self.hud.hide(animated: true)
//                    }
//
//                    self.navigationController?.pushViewController(home, animated: true)
                    
                    
                    self.getFBUserData()
                    self.showhud()
                    
                }
                
            }
        }
        
        
    }
    
    
//    func openSession(withAllowLoginUI allowLoginUI: Bool, completionHandler handler: FBSessionStateHandler) -> Bool {
//
//        // We pass this permissions array into our request.
//        // I only request email, but there are many more options.
//        //
//        let permissions = ["email", "basic_info"]
//
//        return FBSession.openActiveSession(
//            withReadPermissions: permissions,
//            allowLoginUI: allowLoginUI,
//            completionHandler: { session, state, error in
//
//                if handler != nil {
//                    handler(session, state, error)
//                }
//            })
//    openSession(withAllowLoginUI: true, completionHandler: { session, status, error in
//
//        if error == nil && status == FBSessionStateOpen {
//            let token = session?.accessTokenData.accessToken as? String
//
//            // You're logged in!
//        } else {
//
//            // Something wrong happened
//        }
//    })
//
    
    
    func getFBUserData(){
        print("AccessToken",AccessToken.current)
        if((AccessToken.current) != nil){
            //                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, mobile"]).start(completionHandler: { (connection, result, error) -> Void in
            //                    if (error == nil){
            //                        //everything works print the user data
            //                        print(result as Any)
            //                        let dict = result as! NSDictionary
            //
            //                        self.get_fblogin_details(dict: dict)
            //
            //
            //
            //
            //
            //                    }
            //
            //                })
            
            guard let accessToken = FBSDKLoginKit.AccessToken.current else { return }
            let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                          parameters: ["fields": "email, name"],
                                                          tokenString: accessToken.tokenString,
                                                          version: nil,
                                                          httpMethod: .get)
            graphRequest.start { (connection, result, error) -> Void in
                if error == nil {
                    let dict = result as! NSDictionary
                    
                    self.get_fblogin_details(dict: dict)
                    
                    
                }
                else {
                    print("error \(error)")
                }
            }
            
            
            
            
        }
    }
    
    func get_fblogin_details(dict:NSDictionary){
        DispatchQueue.main.async{
            self.hud.hide(animated: true)
        }
        print("dict",dict)
        print("currentuserid:",UserDefaults.standard.value(forKey: "userid") as Any)
        let fbemail : String = dict.object(forKey: "email") as! String
        print(fbemail)
        let fbname = dict.object(forKey: "name") as! String
        print(fbname)
//                    let phonenumber = dict.object(forKey: "mobile") as! String
                    print(fbname)
        let id=dict.object(forKey: "id") as! String
        
        username=fbname
        useremail=fbemail
         //usermobile=phonenumber
        print("id",id)
        print("usermobile",usermobile)
        uniqueid=id
        UserDefaults.standard.set(username, forKey:"username")
         //UserDefaults.standard.set(usermobile, forKey:"usermobile")
        UserDefaults.standard.set(useremail, forKey:"useremail")
        UserDefaults.standard.set(id, forKey: "uniqueidforguest")
        
        
        service_insert_guest()
        
        
        
    }
    
    
    func service_insert_guest(){
        self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/insert_guest")else{return}
        let poststring="user_name=\(username)&user_email=\(useremail)&mobile=\(usermobile)&unique_id=\(uniqueid)&security_token=niya32jfhdu392nfbfdr&device_id=\(device_id)&device_token=\(device_token)&device_type=2"
        print("poststring",poststring)
        var request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                print("error",error)
                return
            }
            let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("respnsedate,\(responsestring)")
            do{
                let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
                if let parseJson = jsonarray{
                    let status=parseJson["status"]as! Bool
                    let message=parseJson["message"]as! String
                    if status==true{
                        let dataarray=parseJson["data"] as! NSDictionary
                        
                        
                        let user_id=dataarray["user_id"] as! String
                        let user_cat=dataarray["user_cat"] as! String
                        let user_name=dataarray["user_name"] as! String
                        let offer=dataarray["offer"] as! String
                        print("user_id",user_id)
                        let gst=dataarray["gst"] as! String
                        let useremail=dataarray["user_email"] as! String
                        let paymentstatus=dataarray["payment_status"] as! String
                        UserDefaults.standard.set(user_id, forKey:"useridorderhistory")
                        UserDefaults.standard.set("1", forKey:"typeorderhistory")
                        UserDefaults.standard.set(paymentstatus, forKey:"paymentstatus")
                        UserDefaults.standard.set(user_id, forKey:"userid")
                        UserDefaults.standard.set(user_cat, forKey:"usercatid")
                        UserDefaults.standard.set(user_name, forKey:"username")
                        UserDefaults.standard.set(gst, forKey:"usergst")
                        UserDefaults.standard.set(offer, forKey:"useroffer")
                        UserDefaults.standard.set(useremail, forKey:"useremail")
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            if self.searchroomflag==1{
                                let searchroom = self.storyboard?.instantiateViewController (withIdentifier: "SearchroomsViewController") as! SearchroomsViewController
                                self.navigationController?.pushViewController(searchroom, animated: true)
                                
                            }else if self.searchroomflag==2{
                                let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
                                self.navigationController?.pushViewController(productlisting, animated: true)
                            }else if self.searchroomflag==3{
                                
                                let expandcollapse = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as! ExpandcollapseViewController
                                self.navigationController?.pushViewController(expandcollapse, animated: true)
                                
                            }else{
                                
                                let homepage = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                                self.navigationController?.pushViewController(homepage, animated: true)
                            }
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.showToast(message: "Invalid OTP", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                            
                        }
                    }
                }
                
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    @IBAction func btncloseaction(_ sender: Any) {
        if searchroomflag==1{
            let searchroom = self.storyboard?.instantiateViewController (withIdentifier: "SearchroomsViewController") as! SearchroomsViewController
            self.navigationController?.pushViewController(searchroom, animated: true)
            
        }else if searchroomflag==2{
            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
            self.navigationController?.pushViewController(productlisting, animated: true)
        }else if searchroomflag==3{
            
            let expandcollapse = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as! ExpandcollapseViewController
            self.navigationController?.pushViewController(expandcollapse, animated: true)
            
        }else{
            
            let homepage = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
            self.navigationController?.pushViewController(homepage, animated: true)
        }
        
    }
    
    
    @IBAction func btntermsconditions(_ sender: Any) {
        
        let termsandcondition = self.storyboard?.instantiateViewController (withIdentifier: "Terms_conditionViewController") as! Terms_conditionViewController
        termsandcondition.termsflag=1
        self.navigationController?.pushViewController(termsandcondition, animated: true)
        
    }
    
    
    
    
    @IBAction func btnprivacy(_ sender: Any) {
        let termsandcondition = self.storyboard?.instantiateViewController (withIdentifier: "Terms_conditionViewController") as! Terms_conditionViewController
        termsandcondition.termsflag=0
        self.navigationController?.pushViewController(termsandcondition, animated: true)
        
    }
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
    
}

@available(iOS 13.0, *)
extension LaunchscreenViewController: ASAuthorizationControllerPresentationContextProviding {

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window!
  }
}

@available(iOS 13.0, *)
extension LaunchscreenViewController: ASAuthorizationControllerDelegate {

//   func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//      if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
//       let userIdentifier = appleIDCredential.user
//       let fullName = appleIDCredential.fullName
//       let email = appleIDCredential.email
//
//       print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
//
//    }
//   }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
   
      print("User ID: \(appleIDCredential.user)")
        uniqueid="\(appleIDCredential.user)"
         UserDefaults.standard.set(uniqueid, forKey: "uniqueidforguest")
        
        
      if let userEmail = appleIDCredential.email {
        print("Email: \(userEmail)")
        useremail=userEmail
         UserDefaults.standard.set(userEmail, forKey:"useremail")
      }

      if let userGivenName = appleIDCredential.fullName?.givenName,
        let userFamilyName = appleIDCredential.fullName?.familyName {
        print("Given Name: \(userGivenName)")
        print("Family Name: \(userFamilyName)")
        username=userGivenName
        UserDefaults.standard.set("\(userGivenName)", forKey:"username")
         self.service_insert_guest()
      }

      if let authorizationCode = appleIDCredential.authorizationCode,
        let identifyToken = appleIDCredential.identityToken,
        let token=String(data: identifyToken,encoding: .utf8){
        print("Authorization Code: \(authorizationCode)")
        print("Identity Token: \(identifyToken)")
        print("token: \(token)")
        //First time user, perform authentication with the backend
        //TODO: Submit authorization code and identity token to your backend for user validation and signIn
        return
      }
//        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
//          // Sign in using an existing iCloud Keychain credential.
//          let username = passwordCredential.user
//          let password = passwordCredential.password
//          uniqueid="\(passwordCredential.user)"
//          UserDefaults.standard.set(uniqueid, forKey: "uniqueidforguest")
//
//          self.service_insert_guest()
//      }
           
        }
    
    }
        
    
      
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization returned an error: \(error.localizedDescription)")
      }
    
    
    
    
    
    
    }
    



