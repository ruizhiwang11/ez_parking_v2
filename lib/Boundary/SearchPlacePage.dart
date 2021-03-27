import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:ezparking/Services/PlaceAutoComplete.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(12.0),
              //child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}

class FloatAppBar extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 5,
          left: 5,
          top: 60,
          child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 2),
                ],
              ),
              padding: const EdgeInsets.all(5),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: new ThemeData(
                        primaryColor: Colors.grey,
                        primaryColorDark: Colors.grey),
                    child: new TextField(
                      style: TextStyle(fontSize: 15),
                      controller: _controller,
                      readOnly: true,
                      onTap: () async {
                        // generate a new token here
                        final sessionToken = Uuid().v4();
                        final Suggestion result = await showSearch(
                          context: context,
                          delegate: AddressSearch(sessionToken),
                        );
                        // This will change the text displayed in the TextField
                        if (result != null) {
                          final placeDetails =
                              await PlaceApiProvider(sessionToken)
                                  .getPlaceDetailFromId(result.placeId);
                          _controller.text = result.description;
                          print(_controller.text);
                          getCoordinates(_controller.text);
                        }
                      },
                      decoration: new InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20,
                        ),
                        hintText: "Enter Address ...",
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  ),

                  //_buildTextClearIcon()
                ],
              )),
        )
      ],
    );
  }
}