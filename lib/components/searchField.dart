import 'package:flutter/material.dart';

class SearchFieldWithSelection extends StatefulWidget {
  const SearchFieldWithSelection({Key? key}) : super(key: key);

  @override
  _SearchFieldWithSelectionState createState() =>
      _SearchFieldWithSelectionState();
}

class _SearchFieldWithSelectionState extends State<SearchFieldWithSelection> {
  String? _selectedCategory;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust the width as needed
      height: 40, // Adjust the height as needed
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController, // Use the controller
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5, // Add some space between search field and selection box
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            onSelected: (String value) {
              setState(() {
                _selectedCategory = value;
                _searchController.text =
                    value; // Update the text field with the selected category
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'İstanbul',
                child: Text('İstanbul'),
              ),
              PopupMenuItem(
                value: 'İzmir',
                child: Text('İzmir'),
              ),
              PopupMenuItem(
                value: 'Gönen',
                child: Text('Gönen'),
              ),
              // Add more categories as needed
            ],
          ),
        ],
      ),
    );
  }
}
