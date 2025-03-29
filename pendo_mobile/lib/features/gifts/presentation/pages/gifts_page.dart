import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/gift.dart';
import '../bloc/gifts_bloc.dart';
import '../widgets/gift_card.dart';

class GiftsPage extends StatelessWidget {
  const GiftsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Подарки'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Магазин'),
              Tab(text: 'Полученные'),
              Tab(text: 'Отправленные'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _GiftsList(),
            _ReceivedGiftsList(),
            _SentGiftsList(),
          ],
        ),
      ),
    );
  }
}

class _GiftsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftsBloc, GiftsState>(
      builder: (context, state) {
        if (state is GiftsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GiftsLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.gifts.length,
            itemBuilder: (context, index) {
              final gift = state.gifts[index];
              return GiftCard(
                gift: gift,
                onTap: () => _showSendGiftDialog(context, gift),
              );
            },
          );
        }
        if (state is GiftsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  void _showSendGiftDialog(BuildContext context, Gift gift) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Отправить ${gift.name}'),
        content: const Text('Выберите получателя подарка'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement gift sending
              Navigator.pop(context);
            },
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
  }
}

class _ReceivedGiftsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftsBloc, GiftsState>(
      builder: (context, state) {
        if (state is ReceivedGiftsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ReceivedGiftsLoaded) {
          return ListView.builder(
            itemCount: state.gifts.length,
            itemBuilder: (context, index) {
              final gift = state.gifts[index];
              return ListTile(
                leading: Image.network(gift.imageUrl),
                title: Text(gift.name),
                subtitle: Text('От: ${gift.senderName}'),
              );
            },
          );
        }
        if (state is GiftsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}

class _SentGiftsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftsBloc, GiftsState>(
      builder: (context, state) {
        if (state is SentGiftsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SentGiftsLoaded) {
          return ListView.builder(
            itemCount: state.gifts.length,
            itemBuilder: (context, index) {
              final gift = state.gifts[index];
              return ListTile(
                leading: Image.network(gift.imageUrl),
                title: Text(gift.name),
                subtitle: Text('Кому: ${gift.receiverName}'),
              );
            },
          );
        }
        if (state is GiftsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
