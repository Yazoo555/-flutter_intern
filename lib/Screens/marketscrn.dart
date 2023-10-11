import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({
    super.key,
  });

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MarketPlace"),
      ),
      body: Column(
        children: const [
          Text(
            "This is MarketPlace",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
