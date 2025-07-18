import 'package:flutter/material.dart';

class CharityListPage extends StatefulWidget {
  @override
  _CharityListPageState createState() => _CharityListPageState();
}

class _CharityListPageState extends State<CharityListPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  List<CharityItem> filteredCharities = [];
  String selectedCategory = 'All';
  int? selectedCharityIndex;

  final List<CharityItem> charities = [
    CharityItem(
      name: 'Hope Foundation',
      description: 'Providing education and healthcare to underprivileged children across Malaysia.',
      category: 'Education',
      color: const Color(0xFF6C5CE7),
      icon: Icons.school,
      rating: 4.8,
      donationsCount: 1250,
      impact: '2,500 children helped',
      location: 'Kuala Lumpur',
    ),
    CharityItem(
      name: 'Green Earth Initiative',
      description: 'Environmental conservation and sustainable development projects.',
      category: 'Environment',
      color: const Color(0xFF00B894),
      icon: Icons.eco,
      rating: 4.6,
      donationsCount: 890,
      impact: '15,000 trees planted',
      location: 'Selangor',
    ),
    CharityItem(
      name: 'Helping Hands',
      description: 'Supporting elderly care and community welfare programs.',
      category: 'Healthcare',
      color: const Color(0xFFE17055),
      icon: Icons.favorite,
      rating: 4.9,
      donationsCount: 2100,
      impact: '500 elderly supported',
      location: 'Penang',
    ),
    CharityItem(
      name: 'Food for All',
      description: 'Eliminating hunger through food distribution and nutrition programs.',
      category: 'Food Security',
      color: const Color(0xFFFFD93D),
      icon: Icons.restaurant,
      rating: 4.7,
      donationsCount: 1800,
      impact: '10,000 meals served',
      location: 'Johor',
    ),
    CharityItem(
      name: 'Build Tomorrow',
      description: 'Housing and infrastructure development for low-income families.',
      category: 'Housing',
      color: const Color(0xFF74B9FF),
      icon: Icons.home,
      rating: 4.5,
      donationsCount: 650,
      impact: '200 homes built',
      location: 'Sabah',
    ),
    CharityItem(
      name: 'Animal Rescue Center',
      description: 'Rescuing and rehabilitating stray animals across urban areas.',
      category: 'Animal Welfare',
      color: const Color(0xFFFF7675),
      icon: Icons.pets,
      rating: 4.8,
      donationsCount: 1100,
      impact: '800 animals rescued',
      location: 'Sarawak',
    ),
  ];

  final List<String> categories = [
    'All',
    'Education',
    'Environment',
    'Healthcare',
    'Food Security',
    'Housing',
    'Animal Welfare',
  ];

  @override
  void initState() {
    super.initState();
    filteredCharities = charities;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCharities() {
    setState(() {
      filteredCharities = charities.where((charity) {
        final matchesSearch = charity.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            charity.description.toLowerCase().contains(_searchController.text.toLowerCase());
        final matchesCategory = selectedCategory == 'All' || charity.category == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E13),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchAndFilter(),
                _buildCategoryFilter(),
                _buildCharityStats(),
                Expanded(
                  child: _buildCharityList(),
                ),
                _buildActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Your Charity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Make a difference in your community',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.volunteer_activism,
              color: Color(0xFF4ECDC4),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D23),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _filterCharities(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF4ECDC4),
                  ),
                  hintText: 'Search charities...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1D23),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: IconButton(
              onPressed: () {
                // Filter options
              },
              icon: const Icon(
                Icons.tune,
                color: Color(0xFF4ECDC4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                _filterCharities();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4ECDC4) : const Color(0xFF1A1D23),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade800,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade400,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCharityStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4ECDC4).withOpacity(0.1),
            const Color(0xFF44B5A0).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('${filteredCharities.length}', 'Charities'),
          _buildStatItem('12.5K', 'Donations'),
          _buildStatItem('4.7★', 'Avg Rating'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF4ECDC4),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCharityList() {
    return Container(
      margin: const EdgeInsets.all(24),
      child: filteredCharities.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: filteredCharities.length,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildCharityItem(filteredCharities[index], index),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          Text(
            'No charities found',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharityItem(CharityItem charity, int index) {
    final isSelected = selectedCharityIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCharityIndex = isSelected ? null : index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1A1D23) : const Color(0xFF0F1115),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade800,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF4ECDC4).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: charity.color,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: charity.color.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      charity.icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          charity.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: charity.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            charity.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: charity.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            charity.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${charity.donationsCount} donors',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                charity.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade300,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(Icons.location_on, charity.location),
                  const SizedBox(width: 12),
                  _buildInfoChip(Icons.trending_up, charity.impact),
                ],
              ),
              if (isSelected) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4ECDC4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF4ECDC4),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Selected',
                        style: TextStyle(
                          color: Color(0xFF4ECDC4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // View charity details
                        },
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            color: Color(0xFF4ECDC4),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          if (selectedCharityIndex != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4ECDC4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF4ECDC4), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You selected: ${filteredCharities[selectedCharityIndex!].name}',
                      style: const TextStyle(
                        color: Color(0xFF4ECDC4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: selectedCharityIndex != null
                  ? const LinearGradient(
                      colors: [Color(0xFF4ECDC4), Color(0xFF44B5A0)],
                    )
                  : null,
              color: selectedCharityIndex == null ? Colors.grey.shade700 : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: selectedCharityIndex != null
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4ECDC4).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: TextButton(
              onPressed: selectedCharityIndex != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Proceeding with ${filteredCharities[selectedCharityIndex!].name}',
                          ),
                          backgroundColor: const Color(0xFF4ECDC4),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedCharityIndex != null ? Icons.arrow_forward : Icons.info_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedCharityIndex != null ? 'PROCEED WITH DONATION' : 'SELECT A CHARITY',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CharityItem {
  final String name;
  final String description;
  final String category;
  final Color color;
  final IconData icon;
  final double rating;
  final int donationsCount;
  final String impact;
  final String location;

  CharityItem({
    required this.name,
    required this.description,
    required this.category,
    required this.color,
    required this.icon,
    required this.rating,
    required this.donationsCount,
    required this.impact,
    required this.location,
  });
}