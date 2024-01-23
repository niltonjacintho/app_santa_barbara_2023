import 'package:go_router/go_router.dart';
import 'package:santa_barbara/app/modules/game/game.repository.dart';
import 'package:santa_barbara/modules/home/homemenu.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key, required this.catalogItem});

  final MenuItemModel catalogItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late GameRepository gameRepository;
    gameRepository = Provider.of<GameRepository>(context);

    return GestureDetector(
      onTap: () => {
        // ignore: avoid_print
        switch (catalogItem.id) {
          0 => GoRouter.of(context).go('/avisos'),
          1 => GoRouter.of(context).go('/mensagemparoco'),
          2 => GoRouter.of(context).go('/paroquias'),
          3 => GoRouter.of(context).go('/agenda'),
          4 => {
              gameRepository.getTopicos(),
              GoRouter.of(context).go('/games'),
            },
          int() => null,
        },
      },
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 16,
              child: Image.asset(
                catalogItem.photoUrl,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              catalogItem.name,
              style: theme.textTheme.titleLarge,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
