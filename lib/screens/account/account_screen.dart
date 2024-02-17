import 'package:comixnook_prj/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  void logout() async{
    _ui.loadState(true);
    try{
      await _auth.logout().then((value){
        Navigator.of(context).pushReplacementNamed('/login');
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/images/ComixNookLogo.png",
            height: 120,
            width: 260,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  _auth.loggedInUser!.name.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  _auth.loggedInUser!.email.toString(),
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          makeSettings(
              icon: Icon(Icons.sell),
              title: "My Comics",
              subtitle: "Get listing of my comics",
              onTap: (){
                Navigator.of(context).pushNamed("/my-products");
              }
          ),
          SizedBox(
            height: 10,
          ),
          makeSettings(
              icon: Icon(Icons.logout),
              title: "Logout",
              subtitle: "Logout from this application",
              onTap: (){
                logout();
              }
          ),
          // makeSettings(
          //     icon: Icon(Icons.android),
          //     title: "Version",
          //     subtitle: "0.0.1",
          //     onTap: (){
          //
          //     }
          // )
        ],
      ),
    );
  }

  makeSettings({required Icon icon, required String title, required String subtitle, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
                tileColor: KPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                leading: icon,
                title: Text(
                  title,
                ),
                subtitle: Text(
                  subtitle,
                ))),
      ),
    );
  }
}
