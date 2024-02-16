
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'drink-details.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  var api = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail");
  var res, drinks;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData() async {
    res = await http.get(api);
    drinks = jsonDecode(res.body)["drinks"];
    if (kDebugMode) {
      print(drinks.toString());
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Welcome"),
        elevation: 0.0,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: res != null
            ? ListView.builder(
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            var drink = drinks[index];
            return ListTile(
              leading: Hero(
                tag: drink["idDrink"],
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    drink["strDrinkThumb"] ??
                        "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                  ),
                ),
              ),
              title: Text(
                "${drink["strDrink"]}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "${drink["idDrink"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrinkDetails(drink: drink),
                  ),
                );
              },
            );
          },
        )
            : const CircularProgressIndicator(backgroundColor: Colors.white),
      ),
    );  }
}