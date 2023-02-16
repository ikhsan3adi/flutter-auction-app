import 'package:flutter/material.dart';

class BidderList extends StatelessWidget {
  const BidderList({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: const CircleAvatar(),
          title: Text("Kerja Bagus", style: textTheme.headlineSmall),
          subtitle: Text("16 Nov 2023", style: textTheme.bodyLarge),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Rp950000",
              style: textTheme.headlineSmall?.copyWith(color: Colors.blue.shade900),
            ),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
