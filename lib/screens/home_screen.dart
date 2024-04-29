import 'package:flutter/material.dart';
import 'package:real_estate/widgets/search_field.dart';
import 'package:real_estate/widgets/select_category.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}): super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: Row(children: [
          Icon(
            Icons.location_on,
            color: Colors.blue.shade600,
          ),
          Text(
            "Tokyo, Japan",
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],),
        actions: [IconButton(onPressed: (){}, icon: Icon(
            Icons.notifications,
            color: Colors.grey.shade600,
        ),
        )
        ],
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchField(),
              //SelectCategory(),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}