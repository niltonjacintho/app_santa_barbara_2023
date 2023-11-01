import 'package:app_sbrm/modules/avisos/avisos.view.dart';
import 'package:app_sbrm/modules/home/homemenu.model.dart';
import 'package:flutter/material.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key, required this.catalogItem});

  final MenuItemModel catalogItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => {
        print(catalogItem.name),
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AvisosView()),
        ),
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
