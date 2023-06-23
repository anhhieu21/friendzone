// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:friendzone/state/profile/user/user_cubit.dart';
// import 'package:friendzone/state/profile/user/user_state.dart';

// class UserScreen extends StatefulWidget {
// 	const UserScreen({Key? key}) : super(key: key);
	
// 	@override
// 	_UserScreenState createState() => _UserScreenState();
// }
	
// class _UserScreenState extends State<UserScreen> {
// 	final screenCubit = UserCubit();
	
// 	@override
// 	void initState() {
// 		screenCubit.loadInitialData();
// 		super.initState();
// 	}
	
// 	@override
// 	Widget build(BuildContext context) {
// 		return Scaffold(
// 			body: BlocConsumer<UserCubit, UserState>(
// 				bloc: screenCubit,
// 				listener: (BuildContext context, UserState state) {
// 					if (state.error != null) {
// 						// TODO your code here
// 					}
// 				},
// 				builder: (BuildContext context, UserState state) {

	
// 					return buildBody(state);
// 				},
// 			),
// 		);
// 	}
	
// 	Widget buildBody(UserState state) {
// 		return ListView(
// 			children: [
// 				// TODO your code here
// 			],
// 		);
// 	}
// }
