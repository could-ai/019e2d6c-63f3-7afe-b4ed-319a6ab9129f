import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const SuperHealthApp());
}

class SuperHealthApp extends StatelessWidget {
  const SuperHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthHub Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C853), // A healthy green
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C853),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainHubScreen(),
      },
    );
  }
}

class MainHubScreen extends StatefulWidget {
  const MainHubScreen({super.key});

  @override
  State<MainHubScreen> createState() => _MainHubScreenState();
}

class _MainHubScreenState extends State<MainHubScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ExploreFeaturesScreen(),
    SocialCommunityScreen(),
    ProfileSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Features',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// MOCK HEALTH SERVICE
// ---------------------------------------------------------
class MockHealthService {
  static final _random = Random();
  
  static int getTodaySteps() {
    return 6542; 
  }

  static int getDailyGoal() {
    return 10000;
  }

  static double getCaloriesBurned() {
    return getTodaySteps() * 0.04;
  }

  static double getDistanceKm() {
    return getTodaySteps() * 0.000762; 
  }
}

// ---------------------------------------------------------
// 1. DASHBOARD SCREEN (Home)
// ---------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int todaySteps = MockHealthService.getTodaySteps();
    final int goal = MockHealthService.getDailyGoal();
    final double progress = todaySteps / goal;
    final double calories = MockHealthService.getCaloriesBurned();
    final double distance = MockHealthService.getDistanceKm();
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Daily Overview',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Core Steps Widget
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 20,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          color: theme.colorScheme.primary,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.directions_walk, size: 40, color: theme.colorScheme.primary),
                          const SizedBox(height: 8),
                          Text(
                            todaySteps.toString(),
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '/ $goal steps',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Metrics Grid
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Calories',
                        value: '${calories.toStringAsFixed(0)} kcal',
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Distance',
                        value: '${distance.toStringAsFixed(2)} km',
                        icon: Icons.location_on,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Connection Status
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.health_and_safety, color: Colors.red),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Connected to Apple Health & Google Fit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 16),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. EXPLORE FEATURES SCREEN (The 500+ Feature Hub)
// ---------------------------------------------------------
class ExploreFeaturesScreen extends StatelessWidget {
  const ExploreFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Mock categories for the 500+ features
    final categories = [
      {'title': 'Workout Programs', 'icon': Icons.fitness_center, 'color': Colors.blue},
      {'title': 'Diet & Nutrition', 'icon': Icons.restaurant, 'color': Colors.orange},
      {'title': 'Sleep Tracking', 'icon': Icons.bedtime, 'color': Colors.indigo},
      {'title': 'Mental Health', 'icon': Icons.psychology, 'color': Colors.purple},
      {'title': 'Hydration Log', 'icon': Icons.water_drop, 'color': Colors.lightBlue},
      {'title': 'AI Coach', 'icon': Icons.smart_toy, 'color': Colors.teal},
      {'title': 'Medical Records', 'icon': Icons.medical_services, 'color': Colors.red},
      {'title': 'Device Sync', 'icon': Icons.watch, 'color': Colors.grey},
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Explore Modules',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Unlock over 500 features to optimize your health journey.',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final cat = categories[index];
                final color = cat['color'] as Color;
                return Card(
                  elevation: 0,
                  color: color.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${cat['title']} module coming soon!')),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'] as IconData, size: 48, color: color),
                          const SizedBox(height: 12),
                          Text(
                            cat['title'] as String,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: categories.length,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. SOCIAL & COMMUNITY SCREEN
// ---------------------------------------------------------
class SocialCommunityScreen extends StatelessWidget {
  const SocialCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 80, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          const SizedBox(height: 24),
          Text(
            'Community Leaderboards',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('Connect with friends and compete.'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Find Friends'),
          )
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. PROFILE & SETTINGS SCREEN
// ---------------------------------------------------------
class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 48),
        const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Jane Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 32),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('App Settings'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.health_and_safety),
          title: const Text('Health Data Sources'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy & Permissions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          onTap: () {},
        ),
      ],
    );
  }
}
