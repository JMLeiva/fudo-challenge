import 'package:flutter/material.dart';
import 'package:fudo_challenge/di/injection.dart';
import 'package:fudo_challenge/presentation/view_model/main_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_ui_state.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainViewModel _viewModel = getIt<MainViewModel>();

  @override
  void dispose() {
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
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search stocks...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _viewModel.onSearchChanged,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<SearchViewUIState>(
                stream: _viewModel.stateStream,
                initialData: SearchViewUIState.empty(),
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Success) {
                    if (state.items.isEmpty) {
                      return const Center(child: Text('No results found'));
                    }
                    return ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ListTile(
                          title: Text(item.stockSymbol),
                          subtitle: Text(item.companyName),
                          trailing: Text(item.region),
                        );
                      },
                    );
                  } else if (state is Error) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Try searching something'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
