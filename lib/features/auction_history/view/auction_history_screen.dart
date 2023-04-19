import 'package:flutter/material.dart';

class AuctionHistoryScreen extends StatelessWidget {
  const AuctionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: const [Text("data")],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
