import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Charades Naija App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          // Launch Screen
          splash: 'images/kix.png',
          duration: 5000,
          // centered: true,
          splashIconSize: 300,
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  // String current = 'random';
  //
  // void getNext() {
  //   // current = moviesList[1];
  //   print('in get next, current is ==> $current');
  //   notifyListeners();
  // }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Row(
        // This is the nav menu setup
        children: [
          SafeArea(
              child: NavigationRail(
            extended: true, // Show labels next to Icons when possible
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.category), label: Text('Categories')),
              NavigationRailDestination(
                  icon: Icon(Icons.favorite), label: Text('Favourites')),
              NavigationRailDestination(
                  icon: Icon(Icons.settings), label: Text('Settings')),
              NavigationRailDestination(
                  icon: Icon(Icons.score), label: Text('Score')),
            ],
            selectedIndex: 0, // This identifies which Icon shows by default
            onDestinationSelected: (value) {
              print('selected: $value');
            },
          )),
          Expanded(
              // This lets pages defined in here to use all available space possible
              child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: CategoryPage(),
          ))
        ],
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // var pair = appState.current;

    return GridView(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500.0,
        mainAxisSpacing: 20.0, // Horizontal spacing
        // crossAxisSpacing: 10.0, // Vertical spacing
        childAspectRatio: 4.0,
      ),
      // crossAxisCount: 2, can only be used if using "GridView.count"
      children: [
        // Image(image: image)
        // CategoryCard(text: 'Movies'), // Add images to cathgory cards
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> GeneratorPage(text: 'Movies')),
            );
          },
          child: CategoryCard(text: 'Movies'),
        ),
        CategoryCard(text: 'Shows'),
        CategoryCard(text: 'Presidents'),
        CategoryCard(text: 'Famous Landscapes'),
        CategoryCard(text: 'Languages'),
        CategoryCard(text: 'Books'),
        CategoryCard(text: 'Songs'),
        CategoryCard(text: 'Actors'),
        CategoryCard(text: 'Celebrities'),
        CategoryCard(text: 'Football')
      ],
    );
  }
}

class GeneratorPage extends StatefulWidget {
  GeneratorPage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  List<String> moviesList = ['Ayamatanga', 'Lagos Boys', 'Domitila', 'Woman King', 'King of the Boys', 'Magun'];
  List<String> showsList = ['SuperStory', 'OJO', 'Papa Ajasco', 'Real HouseWives Of Lagos', 'Shanty Town'];
  List<String> presidentList = ['Segun Obasanjo', 'Bola Tinubu', 'GoodLuck Jonathan', 'Muhammadu Buhari', 'Umaru Musa YarAdua'];

  late String current = moviesList[0]; // Added this assignment so setState can take effect
  int i = 1; // Counter for looping through list

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    // var generatorPageState = context.watch<GeneratorPage>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    // current = moviesList[0];

    List<String> selectedList = [];

    // switch (text) {
    //   case 'Movies':
    //     selectedList = moviesList;
    //     break;
    //   case 'Shows':
    //     selectedList = showList;
    //     break;
    //   default:
    //     throw UnimplementedError('no category list selected');
    // }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryCard(text: current),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() { // does not work if 'current' is defined in build method
                    if (i < moviesList.length){
                      print('in if');
                      current = moviesList[i];
                      i++;
                    } else {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CategoryPage()),
                      // );
                    }
                    print('Pressed! current is now ==> $current');
                  });
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      // fontStyle: FontStyle.italic,
      fontSize: 30,
      fontFamily: 'Georgia',
      fontWeight: FontWeight.w600
    );

    return Card(
        color: theme.colorScheme.primary,
        margin: const EdgeInsets.only(top: 20, bottom: 7, left: 40.0, right: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: style,
              textAlign: TextAlign.center,
          ),
        ));
  }
}
