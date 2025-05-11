import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/menu_detail_notifier.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';

typedef MenuDetailPageParams = ({
  String menuName,
});

class MenuDetailPage extends ConsumerStatefulWidget {
  final MenuDetailPageParams params;
  const MenuDetailPage({super.key, required this.params});

  @override
  ConsumerState<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends ConsumerState<MenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(menuDetailNotifierProvider(widget.params));

    return detailAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar:
            AppBar(leading: const BackButton(), title: const Text('Details')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (detail) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Details'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    detail.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Image carousel
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: detail.imageLinks.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            detail.imageLinks[i],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(detail.description),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Ingredients
                  const Text(
                    'Ingredients Included',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(detail.ingredients),
                  const SizedBox(height: 16),

                  // Watch Out
                  const Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 8),
                      Text(
                        'Watch Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(detail.whatToBeCareful),
                  const SizedBox(height: 24),

                  // Count selector (static)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      const Text('1', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Add to Cart button
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,      // ← set your mainColor here
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child:
                    const Text('Add to Cart', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        );
      },
    );
  }
}
