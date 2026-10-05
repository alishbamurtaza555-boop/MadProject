import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class LostItemModel {
  final String id;
  final String name;
  final String category;
  final String location;
  final String date;
  final String status; // 'LOST', 'FOUND', 'RETURNED'
  final IconData icon;
  final String? imagePath;

  LostItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.date,
    required this.status,
    required this.icon,
    this.imagePath,
  });
}

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Electronics',
    'Accessories',
    'Books',
  ];

  late List<LostItemModel> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      LostItemModel(
        id: '1',
        name: 'HP Laptop Bag',
        category: 'Accessories',
        location: 'CS Block',
        date: 'Sep 17',
        status: 'LOST',
        icon: Icons.work_outline_rounded,
      ),
      LostItemModel(
        id: '2',
        name: 'Samsung Earpods',
        category: 'Electronics',
        location: 'Cafeteria',
        date: 'Sep 18',
        status: 'FOUND',
        icon: Icons.headphones_outlined,
      ),
      LostItemModel(
        id: '3',
        name: 'DBMS Textbook',
        category: 'Books',
        location: 'Library',
        date: 'Sep 16',
        status: 'LOST',
        icon: Icons.book_outlined,
      ),
      LostItemModel(
        id: '4',
        name: 'ID Card Wallet',
        category: 'Accessories',
        location: 'Admin Block',
        date: 'Sep 15',
        status: 'RETURNED',
        icon: Icons.wallet_outlined,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LostItemModel> get _filteredItems {
    return _items.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch =
          _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get _lostCount => 23 + _items.where((e) => e.status == 'LOST').length - 2;
  int get _foundCount =>
      14 + _items.where((e) => e.status == 'FOUND').length - 1;
  int get _returnedCount =>
      9 + _items.where((e) => e.status == 'RETURNED').length - 1;

  void _showReportItemDialog() {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final dateCtrl = TextEditingController(text: 'Today');
    final descCtrl = TextEditingController();
    String itemType = 'LOST';
    String category = 'Electronics';
    String? pickedImagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> pickImage(ImageSource source) async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(
              source: source,
              imageQuality: 80,
              maxWidth: 1080,
            );
            if (picked != null) {
              setModalState(() => pickedImagePath = picked.path);
            }
          }

          return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.cardBorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Report Campus Item',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Help your peers track lost belongings on campus',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Item Type Selector (Lost / Found)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() => itemType = 'LOST');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: itemType == 'LOST'
                                  ? const Color(0xFF2E222A)
                                  : AppTheme.surfaceWarm,
                              borderRadius: BorderRadius.circular(
                                AppTheme.pillRadius,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Lost Item',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: itemType == 'LOST'
                                      ? Colors.white
                                      : AppTheme.textDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() => itemType = 'FOUND');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: itemType == 'FOUND'
                                  ? AppTheme.primaryDarkNavy
                                  : AppTheme.surfaceWarm,
                              borderRadius: BorderRadius.circular(
                                AppTheme.pillRadius,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Found Item',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: itemType == 'FOUND'
                                      ? Colors.white
                                      : AppTheme.textDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Item Name
                  const Text(
                    'Item Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: nameCtrl,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Enter item name'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Blue Dell Charger, Student ID...',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category Dropdown
                  const Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceWhite,
                      borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: category,
                        isExpanded: true,
                        items: ['Electronics', 'Accessories', 'Books']
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => category = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Location
                  const Text(
                    'Location on Campus',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: locationCtrl,
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Enter location' : null,
                    decoration: const InputDecoration(
                      hintText: 'e.g. CS Block 2nd Floor, Library Lab 1',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Date
                  const Text(
                    'Date Found / Lost',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: dateCtrl,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Sep 18, 2026',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Description
                  const Text(
                    'Description / Identifying Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: descCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Describe stickers, color, or distinguishing features...',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Item Photo Upload
                  const Text(
                    'Item Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  if (pickedImagePath != null) ...
                    [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              File(pickedImagePath!),
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => setModalState(() => pickedImagePath = null),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(ImageSource.camera),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceWarm,
                              borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                              border: Border.all(color: AppTheme.cardBorder),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.camera_alt_outlined, size: 22, color: AppTheme.textDark),
                                SizedBox(height: 4),
                                Text(
                                  'Camera',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(ImageSource.gallery),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceWarm,
                              borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                              border: Border.all(color: AppTheme.cardBorder),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.photo_library_outlined, size: 22, color: AppTheme.textDark),
                                SizedBox(height: 4),
                                Text(
                                  'Gallery',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        IconData icon = Icons.inventory_2_outlined;
                        if (category == 'Electronics') {
                          icon = Icons.devices_other;
                        } else if (category == 'Books') {
                          icon = Icons.menu_book;
                        } else {
                          icon = Icons.work_outline;
                        }

                        setState(() {
                          _items.insert(
                            0,
                            LostItemModel(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              name: nameCtrl.text.trim(),
                              category: category,
                              location: locationCtrl.text.trim(),
                              date: dateCtrl.text.trim(),
                              status: itemType,
                              icon: icon,
                              imagePath: pickedImagePath,
                            ),
                          );
                        });

                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${nameCtrl.text.trim()} posted to Campus Board!',
                            ),
                            backgroundColor: AppTheme.primaryDarkNavy,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color(0xFF2E222A),
                    ),
                    child: const Text('Submit to Board'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 16),

              // Category Filter Pills
              _buildCategoryPills(),
              const SizedBox(height: 18),

              // 3 Counter Summary Cards Row
              _buildCounterRow(),
              const SizedBox(height: 20),

              // 2x2 Grid of Items matching PDF
              _buildItemsGrid(),
              const SizedBox(
                height: 80,
              ), // Room for floating report item button
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: _showReportItemDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2E222A), Color(0xFF5A2542)],
              ),
              borderRadius: BorderRadius.circular(AppTheme.pillRadius),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2E222A).withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Report Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Campus Board',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Lost & Found',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            shape: BoxShape.circle,
            boxShadow: AppTheme.cardShadow,
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: AppTheme.textDark,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.pillRadius),
        boxShadow: AppTheme.cardShadow,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search lost items...',
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.textSecondary,
            size: 22,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = cat;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2E222A) // Active dark pill as in PDF
                      : AppTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2E222A)
                        : AppTheme.cardBorder,
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppTheme.textDark,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCounterRow() {
    return Row(
      children: [
        Expanded(child: _buildCounterCard('$_lostCount', 'Lost')),
        const SizedBox(width: 12),
        Expanded(child: _buildCounterCard('$_foundCount', 'Found')),
        const SizedBox(width: 12),
        Expanded(child: _buildCounterCard('$_returnedCount', 'Returned')),
      ],
    );
  }

  Widget _buildCounterCard(String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid() {
    final items = _filteredItems;

    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: const Text(
          'No matching campus items found',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.88,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        return _buildItemCard(items[i]);
      },
    );
  }

  Widget _buildItemCard(LostItemModel item) {
    Color badgeTextColor;
    Color badgeBgColor;

    if (item.status == 'LOST') {
      badgeTextColor = const Color(0xFFC84B5B);
      badgeBgColor = const Color(0xFFFFECEF);
    } else if (item.status == 'FOUND') {
      badgeTextColor = const Color(0xFF1E7B68);
      badgeBgColor = const Color(0xFFE8F6F3);
    } else {
      badgeTextColor = const Color(0xFF6B7280);
      badgeBgColor = const Color(0xFFEDEAE4);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon in subtle outline container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item.icon,
              color: const Color(0xFF8C4258), // Muted plum tone from PDF
              size: 26,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                '${item.location} · ${item.date}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          // Status Pill Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(AppTheme.pillRadius),
            ),
            child: Text(
              item.status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: badgeTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
