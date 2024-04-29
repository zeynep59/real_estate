import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}
class _SearchFieldState extends State<SearchField>{

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFF8FAFC),
          hintText: "Search...",
          prefixIcon: Icon(CupertinoIcons.search),
          suffixIcon: Icon(Icons.filter_alt_outlined),

        ),
    );
  }

}