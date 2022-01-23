// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/all.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:liquid_bash/models/user_helper.dart';
// import 'package:liquid_bash/widget/text_widget.dart';
// import 'package:liquid_bash/widget/user_widget.dart';
// import 'package:provider/provider.dart';

// class UserRequest {
//   final bool isFemale;
//   final int minAge;

//   const UserRequest({
//     required this.isFemale,
//     required this.minAge,
//   });

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserRequest &&
//           runtimeType == other.runtimeType &&
//           isFemale == other.isFemale &&
//           minAge == other.minAge;

//   @override
//   int get hashCode => isFemale.hashCode ^ minAge.hashCode;
// }

// Future<User> fetchUser(UserRequest request) async {
//   await Future.delayed(Duration(milliseconds: 400));
//   final gender = request.isFemale ? 'female' : 'male';

//   return users.firstWhere(
//       (user) => user.gender == gender && user.age >= request.minAge);
// }

// final userProvider = FutureProvider.family<User, UserRequest>(
//     (ref, userRequest) async => fetchUser(userRequest));

// class SearchUsers extends StatefulWidget {
//   @override
//   _FamilyObjectModifierPageState createState() =>
//       _FamilyObjectModifierPageState();
// }

// class _FamilyObjectModifierPageState extends State<SearchUsers> {
//   static final ages = [18, 25, 30, 40];
//   bool isFemale = true;
//   int minAge = ages.first;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0x6D6D6D),
//       appBar: AppBar(
//         title: Text('Search Users'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 300,
//               child: Consumer(builder: (context, watch, child) {
//                 final userRequest =
//                     UserRequest(isFemale: isFemale, minAge: minAge);
//                 final future = watch(userProvider(userRequest));

//                 return future.when(
//                   data: (user) => UserWidget(user: user),
//                   loading: () => Center(child: CircularProgressIndicator()),
//                   error: (e, stack) => Center(child: TextWidget('Not found')),
//                 );
//               }),
//             ),
//             const SizedBox(height: 32),
//             buildSearch(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildSearch() => Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Search',
//               style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             const SizedBox(height: 16),
//             buildGenderSwitch(),
//             const SizedBox(height: 16),
//             buildAgeDropdown(),
//           ],
//         ),
//       );

//   Widget buildGenderSwitch() => Row(
//         children: [
//           Text(
//             'Female',
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//           Spacer(),
//           CupertinoSwitch(
//             value: isFemale,
//             onChanged: (value) => setState(() => isFemale = value),
//           ),
//         ],
//       );

//   Widget buildAgeDropdown() => Row(
//         children: [
//           Text(
//             'Age',
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//           Spacer(),
//           DropdownButton<int>(
//             value: minAge,
//             iconSize: 32,
//             style: TextStyle(fontSize: 24, color: Colors.white),
//             onChanged: (value) => setState(() => minAge = value!),
//             items: ages
//                 .map<DropdownMenuItem<int>>(
//                     (int value) => DropdownMenuItem<int>(
//                           value: value,
//                           child: Text('$value years old',
//                               style: TextStyle(color: Colors.white)),
//                         ))
//                 .toList(),
//           ),
//         ],
//       );
// }
