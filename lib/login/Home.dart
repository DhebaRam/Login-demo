import 'package:flutter/material.dart';
import 'package:project/login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userEmail = "";
  String? userName = "";

  getPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("userName");
      userEmail = prefs.getString("userEmail");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    // Size sized=MediaQuery.of(context).size * 2;
    return Scaffold(
      appBar: AppBar(
         title: Text('Welcome  $userName'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async{
              SharedPreferences pref=await SharedPreferences.getInstance();
              //pref.remove("user");
              pref.remove('email');
              pref.remove('password');
              // pref.clear();
              // pref.remove("userEmail");
              // pref.remove("userName");
              // pref.remove("userPassword");
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));
            },
          )
        ],
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Card(
              // color: Colors.transparent,
              margin: EdgeInsets.only(left: 30,right: 30),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15)
              // ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: Image.asset('assets/images/2.jpg',
                      width: size.width,
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5,right: 5),
                    width: size.width,
                    decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.white,
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    // color: Colors.black12,
                                    margin: EdgeInsets.only(left: 5),
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Card Title",style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,),),
                                    decoration: BoxDecoration(
                                      // color: Colors.white60
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        // color: Colors.white60
                                    ),
                                    child: IconButton(
                                        icon: const Icon(Icons.favorite,size: 30),
                                        onPressed:(){}
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        // color: Colors.white60
                                    ),
                                    child: IconButton(
                                        icon: const Icon(Icons.share,size: 30,),
                                        onPressed:(){}
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: size.width,
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(width: 2))
                          ),
                          padding: EdgeInsets.only(top: 10,left: 5),
                          margin: EdgeInsets.only(left: 5,right: 5,bottom: 10),
                          child: Text("Some quick example tet to build on the card",style: TextStyle(fontSize: 17),),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(left: 10,right: 5,bottom: 15),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextButton(onPressed: (){}
                                  , child: Text("Button",style: TextStyle(color: Colors.white,fontSize: 17),)),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(left: 5,bottom: 15),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextButton(onPressed: (){}
                                  , child: Text("Button",style: TextStyle(color: Colors.white,fontSize: 17),)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                ],
              ),
              // color: Colors.white12,
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      )
    );
  }
}







// child: Column(mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
//   height: 25,
//   child: const Text(
//     "Welcome",
//     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   ),
// ),
// Container(height: 15,
//      child: Text(userName!)
// ),
// Container(height: 15,
//      child: Text(userEmail!)
// ),
