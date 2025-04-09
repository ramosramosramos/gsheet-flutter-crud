import 'package:flutter/material.dart';
import 'package:flutter_gsheets/pages/create.dart';
import 'package:flutter_gsheets/pages/edit.dart';
import 'package:flutter_gsheets/services/user_service.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _MainAppState();
}

class _MainAppState extends State<Home> {
  late Stream<dynamic> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUserStream(); // create this function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateUserForm()));
        }, icon: Icon(Icons.add))],
      ),
      body: StreamBuilder(
        stream: futureUsers,
        builder: (context, snapShots) {
          if (!snapShots.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapShots.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              if (user.isEmpty) return SizedBox();
              if (user[0] != "" || users[1] != "") {
                return ListTile(
                  title: Text(user[0] != "" ? user[0] : 'No name'),
                  leading: Text('${index + 2}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(user.length > 1 ? user[1] : 'No  email'),

                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              UserService().destroy(id: index + 2);
                              setState(() {
                                futureUsers = UserService().getUserStream();
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              EditUserForm(id: index+2, name: user[0], email: user[1], password: user[2])));
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
