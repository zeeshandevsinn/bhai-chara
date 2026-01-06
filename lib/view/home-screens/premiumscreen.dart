import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/premiumprovider/premiumprovider.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  // bool _isFreeExpanded = false;
  // bool _isPremiumExpanded = false;

  final List<Map<String, dynamic>> freeFeatures = [
    {"icon": Icons.check_circle, "text": "Access to basic features"},
    {"icon": Icons.check_circle, "text": "Limited Search options at no cost"},
    {"icon": Icons.support_agent, "text": "Standard support"},
  ];

  final List<Map<String, dynamic>> premiumFeatures = [
    {
      "icon": Icons.campaign,
      "text": "Advertisement Integration (Meta & In-App Ads)"
    },
    {"icon": Icons.public, "text": "SEO Optimization & Landing Page"},
    {"icon": Icons.verified, "text": "Verified Profiles & Premium Badges"},
    {"icon": Icons.storefront, "text": "Premium Storefronts with Branding"},
    {
      "icon": Icons.chat,
      "text": "Advanced Chat (Files, Voice Notes, AI Support)"
    },
    {
      "icon": Icons.receipt_long,
      "text": "Donation Transparency & Impact Reports"
    },
    {
      "icon": Icons.notifications_active,
      "text": "Push Notifications & Targeted Campaigns"
    },
    {"icon": Icons.headset_mic, "text": "Priority Support"},
  ];

  @override
  Widget build(BuildContext context) {
    print('isRebuilding');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Premium Plans"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<Premiumprovider>(
          builder: (context, provider, _) {
            print('notRebuilding');
            return Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Choose Your Plan",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildDropdownSection(
                  title: "Free Limited Plan",
                  expanded: provider.isFreeExpanded,
                  onTap: () {
                    provider.setisFreeExpanded(!provider.isFreeExpanded);
                    provider.setisPremiumExpanded(false);
                    // setState(() {
                    //   _isFreeExpanded = !_isFreeExpanded;
                    //   _isPremiumExpanded = false;
                    // });
                  },
                  features: freeFeatures,
                  gradient: [Colors.blue.shade400, Colors.blue.shade700],
                  price: "0\$ / mo",
                ),
                const SizedBox(height: 20),
                _buildDropdownSection(
                  title: "Premium Plan",
                  expanded: provider.isPremiumExpanded,
                  onTap: () {
                    provider.setisPremiumExpanded(!provider.isPremiumExpanded);
                    provider.setisFreeExpanded(false);

                    // setState(() {
                    //   _isPremiumExpanded = !_isPremiumExpanded;
                    //   _isFreeExpanded = false;
                    // });
                  },
                  features: premiumFeatures,
                  gradient: [
                    Colors.deepPurple.shade400,
                    Colors.purple.shade700
                  ],
                  price: "19.99\$ / mo",
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required List<Map<String, dynamic>> features,
    required List<Color> gradient,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                price,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
              trailing: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onTap: onTap,
            ),
            if (expanded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: features
                      .map((feature) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                Icon(feature["icon"], color: Colors.deepPurple),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    feature["text"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
