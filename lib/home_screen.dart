import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/sources_response.dart';
import 'package:news_app/tab_item.dart';

class HomeScreen extends StatefulWidget {
  static const String route_name = "home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int selectedTabIndex=1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/pattern.png")),
        color: Colors.white,
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("News"),
          centerTitle: true,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
         drawer: Drawer(),

        body: Column(
          children: [
            FutureBuilder(
                future: ApiManager.getSources(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(

                      ),
                    );
                  }
                  if(snapshot.hasError){
                    return Center(
                      child: Text("error"),
                    );
                  }

                  List<Sources>? sources=snapshot.data?.sources??[];

                   return DefaultTabController(
                     initialIndex: 1,
                       length: sources.length,
                       child: TabBar(
                         isScrollable: true,
                           onTap: (index) {
                           selectedTabIndex=index;
                           setState(() {

                           });

                           },
                           dividerColor: Colors.transparent,
                           indicatorColor: Colors.transparent,
                           tabs: sources.map((source) => TabItem(
                               source: source,
                               // elmentAt take index ,return object
                               // source from the list = source from the map ? true--> selected
                               // بقارن obj ال جاى من list ب obj ال انا فيه فى map دلوقتى
                               isSelected: sources.elementAt(selectedTabIndex)==source)).toList()
                                          ));
                },
            )
          ],
        ),
      ),
    );
  }
}
