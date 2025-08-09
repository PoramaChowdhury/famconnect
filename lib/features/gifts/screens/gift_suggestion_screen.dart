/*
import 'dart:math';
import 'package:flutter/material.dart';

class GiftSuggestionScreen extends StatefulWidget {
  const GiftSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<GiftSuggestionScreen> createState() => _GiftSuggestionScreenState();
}

class _GiftSuggestionScreenState extends State<GiftSuggestionScreen> {
  final List<String> occasions = ['Birthday', 'Anniversary', 'Graduation', 'Christmas', 'Wedding'];
  final List<String> interests = ['Books', 'Tech', 'Fashion', 'Fitness', 'Cooking', 'Travel', 'Gaming'];
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> ageGroups = ['Child', 'Teen', 'Adult', 'Senior'];

  String selectedOccasion = 'Birthday';
  String selectedGender = 'Male';
  String selectedAgeGroup = 'Adult';
  double selectedBudget = 50;
  List<String> selectedInterests = [];
  String? suggestedGift;

  final Map<String, List<String>> giftDatabase = {
    'Birthday': ['Watch', 'Perfume', 'Book', 'Smartphone', 'Shoes'],
    'Anniversary': ['Photo Frame', 'Couple Mug', 'Romantic Dinner', 'Custom Jewelry'],
    'Graduation': ['Backpack', 'Laptop', 'Inspirational Book', 'Smartwatch'],
    'Christmas': ['Chocolate Box', 'Sweater', 'Gift Card', 'Board Game'],
    'Wedding': ['Toaster', 'Cookware Set', 'Couple Portrait', 'Voucher'],
    'Books': ['Latest Bestseller', 'Bookstore Gift Card', 'Kindle'],
    'Tech': ['Bluetooth Speaker', 'Smartphone', 'VR Headset', 'Smartwatch'],
    'Fashion': ['Sunglasses', 'Leather Wallet', 'Designer Bag'],
    'Fitness': ['Yoga Mat', 'Fitness Tracker', 'Dumbbell Set'],
    'Cooking': ['Knife Set', 'Recipe Book', 'Air Fryer'],
    'Travel': ['Neck Pillow', 'Travel Bag', 'Camera'],
    'Gaming': ['Gaming Mouse', 'Steam Gift Card', 'Headset']
  };

  void generateSuggestion() {
    List<String> pool = [];

    if (giftDatabase[selectedOccasion] != null) {
      pool.addAll(giftDatabase[selectedOccasion]!);
    }

    for (var interest in selectedInterests) {
      pool.addAll(giftDatabase[interest] ?? []);
    }

    // Add bonus diversity
    pool = pool.toSet().toList();

    setState(() {
      suggestedGift = pool.isNotEmpty
          ? pool[Random().nextInt(pool.length)]
          : "No suggestion available. Please select options.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Gift Suggestion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Occasion'),
            dropdownSelector(occasions, selectedOccasion, (val) {
              setState(() => selectedOccasion = val);
            }),

            sectionTitle('Gender'),
            dropdownSelector(genders, selectedGender, (val) {
              setState(() => selectedGender = val);
            }),

            sectionTitle('Age Group'),
            dropdownSelector(ageGroups, selectedAgeGroup, (val) {
              setState(() => selectedAgeGroup = val);
            }),

            sectionTitle('Budget (\$${selectedBudget.round()})'),
            Slider(
              value: selectedBudget,
              min: 10,
              max: 1000,
              divisions: 99,
              label: '\$${selectedBudget.round()}',
              onChanged: (value) {
                setState(() {
                  selectedBudget = value;
                });
              },
            ),

            sectionTitle('Interests'),
            Wrap(
              spacing: 10,
              runSpacing: -5,
              children: interests.map((interest) {
                return FilterChip(
                  label: Text(interest),
                  selected: selectedInterests.contains(interest),
                  onSelected: (bool selected) {
                    setState(() {
                      selected
                          ? selectedInterests.add(interest)
                          : selectedInterests.remove(interest);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: generateSuggestion,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                child: const Text('Suggest Gift', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
            if (suggestedGift != null)
              Center(
                child: Text(
                  '🎁 Suggested Gift: $suggestedGift',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helpers
  Widget sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  );

  Widget dropdownSelector(List<String> items, String selectedValue, ValueChanged<String> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      isExpanded: true,
      items: items
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: (value) => onChanged(value!),
    );
  }
}
*/

// import 'package:flutter/material.dart';
//
// class GiftSuggestionScreen extends StatefulWidget {
//   @override
//   _GiftSuggestionScreenState createState() => _GiftSuggestionScreenState();
// }
//
// class _GiftSuggestionScreenState extends State<GiftSuggestionScreen> {
//   String? selectedOccasion;
//   String? selectedInterest;
//   String? selectedGender;
//   String? selectedAgeGroup;
//
//   final List<String> occasions = ['Birthday', 'Anniversary', 'Graduation', 'Holiday'];
//   final List<String> interests = ['Tech', 'Fashion', 'Books', 'Fitness'];
//   final List<String> genders = ['Male', 'Female'];
//   final List<String> ageGroups = ['0-12', '13-19', '20-35', '36-60', '60+'];
//
//   List<String> suggestedItems = [];
//
//   void searchGifts() {
//     // Just a placeholder logic
//     setState(() {
//       suggestedItems = [
//         'Gift 1 for $selectedOccasion',
//         'Gift 2 for $selectedInterest',
//         'Gift 3 for $selectedGender',
//         'Gift 4 for age $selectedAgeGroup',
//       ];
//     });
//   }
//
//   Widget buildDropdown(String label, String? value, List<String> items, void Function(String?) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label),
//         DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           hint: Text("Select $label"),
//           items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Gift Suggestions')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             buildDropdown("Occasion", selectedOccasion, occasions, (val) => setState(() => selectedOccasion = val)),
//             buildDropdown("Interest", selectedInterest, interests, (val) => setState(() => selectedInterest = val)),
//             buildDropdown("Gender", selectedGender, genders, (val) => setState(() => selectedGender = val)),
//             buildDropdown("Age Group", selectedAgeGroup, ageGroups, (val) => setState(() => selectedAgeGroup = val)),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: searchGifts,
//               child: Text('Search'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: suggestedItems.isEmpty
//                     ? Center(child: Text('No suggestions yet.'))
//                     : ListView.builder(
//                   itemCount: suggestedItems.length,
//                   itemBuilder: (context, index) => ListTile(
//                     title: Text(suggestedItems[index]),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:famconnect/features/common/ui/widgets/custom_app_bar.dart';
import 'package:famconnect/features/gifts/controller/gift_suggestion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiftSuggestionScreen extends StatelessWidget {
  GiftSuggestionScreen({super.key});
  final controller = Get.put(GiftSuggestionController());

  final RxnString selectedOccasion = RxnString();
  final RxnString selectedInterest = RxnString();
  final RxnString selectedGender = RxnString();
  final RxnString selectedAgeGroup = RxnString();

  final List<String> occasions = ['Birthday', 'Anniversary', 'Graduation', 'Holiday'];
  final List<String> interests = ['Tech', 'Fashion', 'Books', 'Fitness'];
  final List<String> genders = ['Male', 'Female'];
  final List<String> ageGroups = ['0-12', '13-19', '20-35', '36-60', '60+'];

  void triggerSearch() {
    if (selectedOccasion.value != null &&
        selectedInterest.value != null &&
        selectedGender.value != null &&
        selectedAgeGroup.value != null) {
      controller.fetchGiftSuggestions(
        occasion: selectedOccasion.value!,
        interest: selectedInterest.value!,
        gender: selectedGender.value!,
        ageGroup: selectedAgeGroup.value!,
      );
    } else {
      Get.snackbar("Missing", "Please select all fields");
    }
  }

  Widget buildDropdown(String label, List<String> items, RxnString selected) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: selected.value,
          hint: Text("Select $label"),
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: (value) => selected.value = value,
        ),
        SizedBox(height: 10),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ('Gift Suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildDropdown("Occasion", occasions, selectedOccasion),
            buildDropdown("Interest", interests, selectedInterest),
            buildDropdown("Gender", genders, selectedGender),
            buildDropdown("Age Group", ageGroups, selectedAgeGroup),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: triggerSearch,
              child: Obx(() => controller.isLoading.value
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                  : const Text('Get Suggestions')),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final suggestions = controller.suggestions;
                if (suggestions.isEmpty) {
                  return Center(child: Text('No suggestions yet.'));
                }
                return ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Text(suggestions[index]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
