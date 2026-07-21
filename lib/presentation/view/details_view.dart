import 'package:flutter/material.dart';
import '../../domain/model/stock_search_item.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key, required this.stock});

  final StockSearchItem stock;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.stock.companyName)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Symbol: ${widget.stock.stockSymbol}", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text("Name: ${widget.stock.companyName}"),
              const SizedBox(height: 8),
              Text("Region: ${widget.stock.region}"),
            ],
          ),
        )
    );
  }
}
