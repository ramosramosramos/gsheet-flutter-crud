import 'package:flutter/material.dart';
import 'package:flutter_gsheets/pages/home.dart';
import 'package:flutter_gsheets/services/user_service.dart';

class EditUserForm extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String password;
  const EditUserForm({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<EditUserForm> createState() => EditUserFormState();
}

class EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      UserService().update(
        id: widget.id,
        name: _name.text,
        email: _email.text,
        password: _password.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name.text = widget.name;
    _email.text = widget.email;
    _password.text = widget.password;
  }

  String? validator({required value, required String message}) {
    if (value == "" || value == null) {
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
              Text("Edit"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      validator:
                          (value) => validator(
                            value: value,
                            message: "Name is required",
                          ),
                    ),
                    TextFormField(
                      controller: _email,
                      validator:
                          (value) => validator(
                            value: value,
                            message: "Email is required",
                          ),
                    ),
                    TextFormField(
                      controller: _password,
                      validator:
                          (value) => validator(
                            value: value,
                            message: "Password is required",
                          ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: handleSubmit,
                      child: Text("Save"),
                    ),
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
