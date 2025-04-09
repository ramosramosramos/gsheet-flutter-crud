import 'package:flutter/material.dart';
import 'package:flutter_gsheets/pages/home.dart';
import 'package:flutter_gsheets/services/user_service.dart';


class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      UserService().store(name: _name.text, email: _email.text, password: _password.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
  }
  String? validator({required value ,required String message}){
       if(value =="" || value==null){
        return message;
     }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text("Create"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      validator: (value) =>validator(value: value, message: "Name is required")
                  ), TextFormField(
                    controller: _email,
                    validator: (value) =>validator(value: value, message: "Email is required")

                  ), TextFormField(
                    controller: _password,
                    validator: (value) =>validator(value: value, message: "Password is required")

                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: handleSubmit, child: Text("Add")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
