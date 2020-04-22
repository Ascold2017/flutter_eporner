import 'package:flutter/material.dart';
import 'package:flutter_eporner/main.dart';
import 'package:provider/provider.dart';

class SearchForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchForm();
  }
}

class _SearchForm extends State<SearchForm> {
  TextEditingController _searchController;
  int gayFilter;
  String sorting;
  Map<String, String> sortings = {
    'latest': 'Latest',
    'longest': 'Longest',
    'shortest': 'Shortest',
    'top-rated': 'Top Rated',
    'most-popular': 'Most Popular'
  };
  List gayFilters = ['Getero', 'Getero & Gay', 'Gay'];
  VideosProvider _state;

  _SearchForm() {
    this._searchController = TextEditingController(text: '');
    this.gayFilter = 0;
    this.sorting = 'latest';
  }

  _submitSearch(BuildContext context) {
    _state.requestVideos(gayFilter: gayFilter, sorting: sorting, search: _searchController.text);
    FocusScope.of(context).unfocus();
  }

  _showBottomSheetSelectOrientation(BuildContext ctx) async {
    int value = await showModalBottomSheet(
        context: ctx,
        builder: (ctx) =>
            _bottomSheetSelectOrientation(value: gayFilter, context: ctx));
    setState(() {
      gayFilter = value;
    });
    _state.requestVideos(gayFilter: gayFilter, sorting: sorting, search: _searchController.text);
  }

  _showBottomSheetSelectSorting(BuildContext ctx) async {
    String value = await showModalBottomSheet(
        context: ctx,
        builder: (ctx) => _bottomSheetSelectSorting(
            value: sorting, context: ctx, sortings: sortings));
    setState(() {
      sorting = value;
    });
    _state.requestVideos(gayFilter: gayFilter, sorting: sorting, search: _searchController.text);
  }


  @override
  Widget build(BuildContext context) {
    _state = Provider.of<VideosProvider>(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _submitSearch(context);
                },
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hasFloatingPlaceholder: false,
                      labelText: 'Search...',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: RaisedButton(
                  child: Text(gayFilters[gayFilter],
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red[400],
                  onPressed: () {
                    _showBottomSheetSelectOrientation(context);
                  },
                )),
            VerticalDivider(),
            Expanded(
                flex: 1,
                child: RaisedButton(
                  child: Text(
                    sortings[sorting],
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[400],
                  onPressed: () {
                    _showBottomSheetSelectSorting(context);
                  },
                )),
          ])
        ],
      ),
    );
  }
}

Widget _bottomSheetSelectOrientation({int value, BuildContext context}) {
  return Container(
    child: Column(
      children: <Widget>[
        ListTile(
          title: const Text('Getero only'),
          leading: Radio(
              value: 0,
              groupValue: value,
              onChanged: (int value) => Navigator.pop(context, value)),
        ),
        ListTile(
          title: const Text('Getero & Gay'),
          leading: Radio(
              value: 1,
              groupValue: value,
              onChanged: (int value) => Navigator.pop(context, value)),
        ),
        ListTile(
          title: const Text('Gay only'),
          leading: Radio(
              value: 2,
              groupValue: value,
              onChanged: (int value) => Navigator.pop(context, value)),
        ),
      ],
    ),
  );
}

Widget _bottomSheetSelectSorting(
    {Map<String, String> sortings, String value, BuildContext context}) {
  return Container(
      child: Column(
          children: List.generate(sortings.length, (int index) {
    return ListTile(
      title: Text(sortings.values.toList()[index]),
      leading: Radio(
          value: sortings.keys.toList()[index],
          groupValue: value,
          onChanged: (String value) => Navigator.pop(context, value)),
    );
  })));
}
