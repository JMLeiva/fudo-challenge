import 'package:flutter/material.dart';
import 'package:fudo_challenge/di/injection.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_ui_state.dart';
import '../../domain/model/stock.dart';
import '../../domain/model/stock_search_item.dart';
import '../../l10n/app_localizations.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key, required this.stock});

  final StockSearchItem stock;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final DetailsViewModel _viewModel = getIt<DetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.loadStockDetails(widget.stock.stockSymbol);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stock.companyName)),
      body: StreamBuilder<DetailsViewUIState>(
        stream: _viewModel.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;

          return switch (state) {
            null || Loading() => _loadingContent(),
            Success() => _successContent(state.stock),
            Error() => _errorContent(state.message),
          };
        },
      ),
    );
  }

  Widget _loadingContent() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _successContent(Stock stock) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerSection(stock),
          const Divider(height: 32),
          _quoteSection(stock),
          const Divider(height: 32),
          _overviewSection(stock),
        ],
      ),
    );
  }

  Widget _headerSection(Stock stock) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stock.symbol,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          stock.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        Text(
          "${stock.overview.exchange} · ${stock.overview.currency} · ${stock.overview.country}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _quoteSection(Stock stock) {
    final quote = stock.quote;
    final color = quote.change >= 0 ? Colors.green : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${quote.price.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${quote.change >= 0 ? '+' : ''}${quote.change.toStringAsFixed(2)}",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "(${quote.changePercent.toStringAsFixed(2)}%)",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dataItem(AppLocalizations.of(context)!.detailsOpen, "\$${quote.open.toStringAsFixed(2)}"),
            _dataItem(AppLocalizations.of(context)!.detailsHigh, "\$${quote.high.toStringAsFixed(2)}"),
            _dataItem(AppLocalizations.of(context)!.detailsLow, "\$${quote.low.toStringAsFixed(2)}"),
          ],
        ),
      ],
    );
  }

  Widget _overviewSection(Stock stock) {
    final overview = stock.overview;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.detailsAbout, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(overview.description),
        const SizedBox(height: 16),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _dataItem(l10n.detailsSector, overview.sector),
            _dataItem(l10n.detailsIndustry, overview.industry),
            _dataItem(l10n.detailsMarketCap, _formatLargeNumber(overview.marketCapitalization)),
            _dataItem(l10n.detailsPeRatio, overview.peRatio.toString()),
            _dataItem(l10n.detailsDividendYield, "${(overview.dividendYield * 100).toStringAsFixed(2)}%"),
            _dataItem(l10n.detailsEps, overview.eps.toString()),
          ],
        ),
      ],
    );
  }

  Widget _dataItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  String _formatLargeNumber(int number) {
    if (number >= 1e12) return "\$${(number / 1e12).toStringAsFixed(2)}T";
    if (number >= 1e9) return "\$${(number / 1e9).toStringAsFixed(2)}B";
    if (number >= 1e6) return "\$${(number / 1e6).toStringAsFixed(2)}M";
    return "\$$number";
  }

  Widget _errorContent(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _viewModel.loadStockDetails(widget.stock.stockSymbol),
            child: Text(AppLocalizations.of(context)!.retry),
          )
        ],
      ),
    );
  }
}
