import 'package:flutter/material.dart';

void main() {
  runApp(const MedicalLibraryApp());
}

class MedicalLibraryApp extends StatelessWidget {
  const MedicalLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبة الطب الذكية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Cairo', // يمكنك إضافة خط عربي لاحقاً
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LibraryHomeTab(),
    const UpdatesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبة الطب الذكية', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'المكتبة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'التحديثات الطبية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

// تبويب المكتبة الرئيسية
class LibraryHomeTab extends StatelessWidget {
  const LibraryHomeTab({Key? key}) : super(key: key);

  final List<Map<String, String>> categories = const [
    {'title': 'التشريح (Anatomy)', 'icon': '🦴', 'count': '120 كتاب'},
    {'title': 'الأدوية (Pharmacology)', 'icon': '💊', 'count': '85 مرجعاً'},
    {'title': 'الباطنة (Internal Med)', 'icon': '🩺', 'count': '150 كتاباً'},
    {'title': 'الجراحة (Surgery)', 'icon': '🔪', 'count': '95 مرجعاً'},
    {'title': 'بنك الأسئلة (QBank)', 'icon': '📝', 'count': '1200 سؤلاً'},
    {'title': 'الملخصات والخرائط', 'icon': '🧠', 'count': '210 ملخصاً'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط البحث
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن كتاب، مرض، أو دواء...',
              prefixIcon: const Icon(Icons.search, color: Colors.teal),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'التخصصات الطبية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          // شبكة التخصصات
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(categories[index]['icon']!, style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 8),
                        Text(
                          categories[index]['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[index]['count']!,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// تبويب التحديثات والأبحاث الطبية
class UpdatesTab extends StatelessWidget {
  const UpdatesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        UpdateCard(
          title: 'تحديث إرشادات أمراض القلب الأمريكية 2026',
          date: 'منذ يومين',
          source: 'NEJM',
        ),
        UpdateCard(
          title: 'بروتوكول جديد لعلاج الطوارئ السريرية',
          date: 'منذ 4 أيام',
          source: 'Lancet',
        ),
        UpdateCard(
          title: 'أحدث التوصيات في التعامل مع المضادات الحيوية',
          date: 'منذ أسبوع',
          source: 'WHO Guidelines',
        ),
      ],
    );
  }
}

class UpdateCard extends StatelessWidget {
  final String title;
  final String date;
  final String source;

  const UpdateCard({Key? key, required this.title, required this.date, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(source, style: const TextStyle(color: Colors.white, fontSize: 10)),
                  backgroundColor: Colors.teal,
                ),
                Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// تبويب الملف الشخصي
class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BoxContext context) {
    return const Center(
      child: Text('صفحة حساب الطالب والمفضلة', style: TextStyle(fontSize: 18)),
    );
  }
}