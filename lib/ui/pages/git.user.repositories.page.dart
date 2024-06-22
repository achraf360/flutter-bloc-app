import 'package:flutter/material.dart';

import '../../model/users.model.dart';

class GitRepositories extends StatelessWidget {
  final User user;
  const GitRepositories({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ${user.login} Repositories"),
      ),
      body: Container(),
    );
  }
}
