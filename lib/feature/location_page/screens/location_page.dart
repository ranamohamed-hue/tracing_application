import 'package:flutter/material.dart';
import 'package:tracing_app/feature/location_page/widgets/action_button.dart';
import 'package:http/http.dart' as http;

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _mapLoading = true;
  String? _mapError;

  void _onLocationPressed() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('جاري تحديد الموقع...')));
  }

  void _onMessagePressed() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('فتح شاشة الرسائل...')));
  }

  void _onNotificationPressed() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('فتح إعدادات التنبيهات...')));
  }

  @override
  void initState() {
    super.initState();
    _checkMapConnectivity();
  }

  Future<void> _checkMapConnectivity() async {
    try {
      // التحقق من الوصول إلى خادم الخرائط
      final response = await http
          .head(Uri.parse('https://tile.openstreetmap.org/'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        setState(() {
          _mapError = 'لا يمكن الاتصال بخادم الخرائط';
          _mapLoading = false;
        });
      } else {
        setState(() {
          _mapLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _mapError = 'خطأ في الشبكة: ${e.toString()}';
        _mapLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // الخريطة مع معالجة الأخطاء
          _mapLoading
              ? const Center(child: CircularProgressIndicator())
              : _mapError != null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ في الخريطة: $_mapError'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _checkMapConnectivity,
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              )
              : DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 0.7,
                builder: (
                  BuildContext context,
                  ScrollController scrollController,
                ) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 231, 192),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: theme.dividerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "أحمد",
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  "آمن في المنزل",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ActionButton(
                                      icon: Icons.location_searching,
                                      label: "تحديد الموقع",
                                      onPressed: _onLocationPressed,
                                    ),
                                    ActionButton(
                                      icon: Icons.chat_bubble_outline,
                                      label: "رسالة",
                                      onPressed: _onMessagePressed,
                                    ),
                                    ActionButton(
                                      icon: Icons.notifications_outlined,
                                      label: "التنبيهات",
                                      onPressed: _onNotificationPressed,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "سجل اليوم",
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
