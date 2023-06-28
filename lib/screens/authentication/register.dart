import 'package:flutter/material.dart';
import '../../services/auth.dart';



class Register extends StatefulWidget {
  const Register({required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController username1=new TextEditingController();
  TextEditingController passsord1=new TextEditingController();
  TextEditingController phno=new TextEditingController();
  TextEditingController adhar=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController drl=new TextEditingController();
  TextEditingController vno=new TextEditingController();
  TextEditingController rcbook=new TextEditingController();

  String dropdownvalue = 'traveller',error="";
  var users = ['traveller','owner','dual'];
  String newval="traveller";bool validate=false,visible=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1.0,
        title: Text('Sign up'),
        actions: [
          IconButton(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person))
        ],
      ),
      body: SingleChildScrollView(//physics: NeverScrollableScrollPhysics(),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(children:[
                    Expanded(flex: 1,child: Text("Username",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex:3,
                      child: TextField(
                        controller: username1,
                        decoration: InputDecoration(
                            hintText: 'username'
                        ),
                      ),
                    ),]),
                  SizedBox(height: 20,),
                  Row(children:[
                    Expanded(flex: 1,child: Text("Email id",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex:3,
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: 'Email id'
                        ),validator: (val)=> val!.isEmpty?"email cannot be empty":null,
                      ),
                    ),]),
                  SizedBox(height: 20,),
                  Row(children:[
                    Expanded(flex: 1,child: Text("Password",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex:3,
                      child: TextFormField(
                        controller: passsord1,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            errorText: validate?"password must be atleast eight character long":""
                        ),
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[
                    Expanded(flex: 1,child: Text("Phone number",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex:3,
                      child: TextField(
                        controller: phno,
                        decoration: InputDecoration(
                            hintText: 'Phone number'
                        ),
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[
                    Expanded(flex: 1,child: Text("Aadhaar's last 4 digits",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex:3,
                      child: TextField(
                        controller: adhar,
                        decoration: InputDecoration(
                            hintText: 'Aadhaar'
                        ),
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[
                    Expanded(flex:1,child: Text("isUser",style: TextStyle(fontSize: 18.0),)),
                    Expanded(flex: 2,
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: users.map((String user) {
                          return DropdownMenuItem(
                            value: user,
                            child: Text(user),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            print(newValue);
                            newval=newValue;
                            if(newValue!="traveller") {visible=true;}
                            else{visible=false;}
                          });
                        },
                      ),
                    ),]),
                  Visibility(visible: visible,child: Column(
                    children: [
                      Row(children:[
                        Expanded(flex: 1,child: Text("driving licence",style: TextStyle(fontSize: 18.0),)),
                        Expanded(flex:3,
                          child: TextField(
                            controller: drl,
                            decoration: InputDecoration(
                                hintText: 'driving licence'
                            ),
                          ),
                        ),]),SizedBox(height: 20,),
                      Row(children:[
                        Expanded(flex: 1,child: Text("vehicle number",style: TextStyle(fontSize: 18.0),)),
                        Expanded(flex:3,
                          child: TextField(
                            controller: vno,
                            decoration: InputDecoration(
                                hintText: 'vehicle number'
                            ),
                          ),
                        ),]),SizedBox(height: 20,),
                      Row(children:[
                        Expanded(flex: 1,child: Text("rc book",style: TextStyle(fontSize: 18.0),)),
                        Expanded(flex:3,
                          child: TextField(
                            controller: rcbook,
                            decoration: InputDecoration(

                                hintText: 'rc book'
                            ),
                          ),
                        ),]),SizedBox(height: 20,),
                    ],
                  )),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: ()async{
                    dynamic result;
                    //if(_formKey.currentState!.validate()){}
                    if(passsord1.text.length<8){
                      validate=true;
                    }else{validate=false;
                      if(newval=='owner'){
                        dynamic result =await _auth.registerWithEmailandPasswordowner(
                            email.text,passsord1.text,username1.text,phno.text,adhar.text,drl.text,rcbook.text,vno.text);
                      }else if(newval=='traveller'){
                        dynamic result =await _auth.registerWithEmailandPasswordtraveller(
                          email.text,passsord1.text,username1.text,phno.text,adhar.text);
                      }else{
                        dynamic result =await _auth.registerWithEmailandPassworddual(
                            email.text,passsord1.text,username1.text,phno.text,adhar.text,drl.text,rcbook.text,vno.text);
                      }
                      if(result==null){
                        setState(() {
                          error="register failed";
                        });
                      }else{
                        email.clear();passsord1.clear();username1.clear();phno.clear();
                        adhar.clear();drl.clear();rcbook.clear();vno.clear();
                      }
                    }

                  }, child: Text('register')),
                  SizedBox(height: 12,),
                  Text(error),
                ],
              ),
            )
        ),
      ),
    );
  }
}