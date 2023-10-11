import 'package:flutter/material.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/User_Profile/seeuserprof.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/pages/mainscr.dart';

class CustomSearchDelegateWidget extends StatefulWidget {
  const CustomSearchDelegateWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchDelegateWidgetState createState() =>
      _CustomSearchDelegateWidgetState();
}

class _CustomSearchDelegateWidgetState
    extends State<CustomSearchDelegateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400, // Background color
              elevation: 5, // Shadow elevation
            ),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors
                    .orange.shade400, // Customize with your preferred color
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Tap here to search",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(usersData: usersData),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<UserModel> usersData;

  CustomSearchDelegate({required this.usersData});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModel> matchQuery = usersData.where((user) {
      return user.fullname!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => seeuserpro(
                  id: result.id.toString(),
                ),
              ),
            );
          },
          child: Card(
            color: const Color.fromARGB(255, 246, 211, 211),
            child: ListTile(
              title: Text('${result.fullname}'),
              leading: ClipOval(
                child: result.image?.path != ""
                    ? Image(
                        height: 60,
                        width: 60,
                        image: FileImage(result.image!),
                        fit: BoxFit.cover,
                      )
                    : Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('${result.imageUrl}'),
                        fit: BoxFit.cover,
                      ),
              ),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> matchQuery = usersData.where((user) {
      return user.fullname!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => seeuserpro(
                  id: result.id.toString(),
                ),
              ),
            );
          },
          child: Card(
            color: Colors.blueGrey.shade100,
            child: ListTile(
              title: Text('${result.fullname}'),
              leading: ClipOval(
                child: result.image?.path != "" && result.image != null
                    ? Image(
                        height: 60,
                        width: 60,
                        image: FileImage(result.image!),
                        fit: BoxFit.cover,
                      )
                    : Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('${result.imageUrl}'),
                        fit: BoxFit.cover,
                      ),
              ),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }
}
