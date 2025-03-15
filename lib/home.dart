import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/token_provider.dart';
import 'providers/shared_prefs_provider.dart';
import 'profile.dart';

class HomePage extends ConsumerStatefulWidget{
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}
class _HomePageState extends ConsumerState<HomePage> {
  
  Future<void> _logout() async {
    SharedPreferencesWithCache prefs = ref.watch(sharedPreferences);
    await prefs.setString("access_token", "");
    await prefs.setString("refresh_token", "");
    ref.read(TokenNotifierProvider("access_token").notifier).update("");
    ref.read(TokenNotifierProvider("refresh_token").notifier).update("");
    print("Cleared");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _logout,
            child: Text(
              "Logout",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              )
            )
          ),
        ],
      ),
    );
  }
}
/*
class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
      case 1:
        page = ProfilePage(profileID:0);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                NavigationBar(
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Icons.home), 
                      label: "Home"),
                    NavigationDestination(
                      icon: Icon(Icons.home), 
                      label: "Home"),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                Expanded(
                  child: SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) {
                        // Placeholder for when I figure out what to do with the search bar
                        return List<ListTile>.generate(5, (int index) {
                          final String item = 'item $index';
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                  controller.closeView(item);
                              });
                            },
                          );
                        });
                      },
                    )
                ),
              ],
            )
          ),
          Expanded(
            child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
        ],
      )
    );
  }
} */
