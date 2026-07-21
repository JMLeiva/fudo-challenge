import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fudo_challenge/di/injection.dart';
import 'package:fudo_challenge/presentation/view/details_view.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_ui_state.dart';

import '../../domain/model/stock_search_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.title});

  final String title;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _viewModel = getIt<SearchViewModel>();
  late StreamSubscription<StockSearchItem> _navigationSubscription;

  @override
  void initState() {
    super.initState();
    _navigationSubscription = _viewModel.navigationStream.listen((stock) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsView(stock: stock),
        ),
      );
    });
  }

  @override
  void dispose() {
    _navigationSubscription.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _createSearchBar(),
            const SizedBox(height: 16),

            Expanded(
              child: StreamBuilder<SearchViewUIState>(
                stream: _viewModel.stateStream,
                initialData: SearchViewUIState.empty(),
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  return switch (state) {
                    null || Empty() => _emptyContent(),
                    Loading() => _loadingContent(),
                    Success() => _successContent(state),
                    Error() => _errorContent(state),
                  };
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSearchBar() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search stocks...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: _viewModel.onSearchChanged,
    );
  }

  Widget _loadingContent() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _emptyContent() {
    return const Center(child: Text('Try searching something'));
  }

  Widget _successContent(Success state) {
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return _stockItem(item);
      },
    );
  }

  Widget _stockItem(StockSearchItem item) {
    return ListTile(
      title: Text(item.stockSymbol),
      subtitle: Text(item.companyName),
      trailing: Text(item.region),
      onTap: () => _viewModel.onStockItemTap(item),
    );
  }

  Widget _errorContent(Error state) {
    return Center(
      child: Text(
        state.message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
