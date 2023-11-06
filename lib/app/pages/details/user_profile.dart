import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 200),
                  ),
                  const SizedBox(height: 40),
                  const Text('nome sobrenome', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Birth: 10/10/1010'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [const Text('Private: '), Checkbox(value: false, onChanged: (val) {})],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("followers: 0"),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("following: 0"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
          Column(
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: const Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Post',
                    textAlign: TextAlign.center,
                  ),
                )),
              ),
              Container(
                constraints: BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: const Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Post',
                    textAlign: TextAlign.center,
                  ),
                )),
              ),
              Container(
                constraints: BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: const Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Post',
                    textAlign: TextAlign.center,
                  ),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
