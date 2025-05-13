import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/menu_order_notifier.dart';

typedef MenuOrderDetailParams = ({
  String name,
  String count,
  String description
});

typedef MenuOrderPageParams = ({
  List<MenuOrderDetailParams> menuOrderDetailParams
});

class MenuOrderPage extends ConsumerStatefulWidget {
  const MenuOrderPage({super.key, required this.params});
  final MenuOrderPageParams params;

  @override
  MenuOrderPageState createState() => MenuOrderPageState();
}

class MenuOrderPageState extends ConsumerState<MenuOrderPage> {
  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(menuOrderNotifierProvider(widget.params));

    return orderAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(leading: const BackButton(), title: const Text('Order')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (resp) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Order'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.mic,
                        size: 60,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Order Card
                GestureDetector(
                  onTap: () => ref
                      .read(menuOrderNotifierProvider(widget.params).notifier)
                      .playOrderAudio(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resp.orderInUserLanguage,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(resp.orderInForeignLanguage),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Inquiry Card
                GestureDetector(
                  onTap: () => ref
                      .read(menuOrderNotifierProvider(widget.params).notifier)
                      .playInquiryAudio(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resp.inquiryForDislikeFoodsInUserLanguage,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(resp.inquiryForDislikeFoodsInForeignLanguage),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
