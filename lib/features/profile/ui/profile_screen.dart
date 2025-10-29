import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/function/navigate_without_back.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce_supabase/features/auth/models/user_model.dart';
import 'package:e_commerce_supabase/features/auth/ui/login_screen.dart';
import 'package:e_commerce_supabase/features/profile/ui/edit_name_screen.dart';
import 'package:e_commerce_supabase/features/profile/ui/my_orders.dart';
import 'package:e_commerce_supabase/features/profile/ui/widgets/custom_row_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..getUserData(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            navigateWithoutBack(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          UserModel? user = context.read<AuthCubit>().userModel;
          return state is LogoutLoading || state is GetUserDataLoading
              ? const CustomCircularIndicator()
              : Center(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .75,
                    child: Card(
                      color: AppColors.kWhiteColor,
                      margin: const EdgeInsets.all(24),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 55,
                              backgroundColor: AppColors.kPrimaryColor,
                              foregroundColor: AppColors.kWhiteColor,
                              child: Icon(Icons.person, size: 45),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user?.name ?? "User Name",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(user?.email ?? "User Email"),
                            const SizedBox(height: 10),
                            CustomRowBtn(
                              onTap: () =>
                                  navigateTo(context, const EditNameView()),
                              icon: Icons.person,
                              text: "Edit Name",
                            ),
                            const SizedBox(height: 10),
                            CustomRowBtn(
                              onTap: () =>
                                  navigateTo(context, const MyOrdersViwe()),
                              icon: Icons.shopping_basket,
                              text: "My Orders",
                            ),
                            const SizedBox(height: 10),
                            CustomRowBtn(
                              onTap: () async {
                                await context.read<AuthCubit>().logout();
                              },
                              icon: Icons.logout,
                              text: "Logout",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is LogoutSuccess) {
//           navigateWithoutBack(context, const LoginScreen());
//         }
//       },
//       builder: (context, state) {
//         // اجلب الـ userModel من الـ Cubit مباشرة
//         UserModel? userData = context.read<AuthCubit>().userModel;

//         return state is LoginLoading || state is GetUserDataLoading
//             ? const CustomCircularIndicator()
//             : userData == null
//             ? const Center(child: Text('No user data available'))
//             : Center(
//                 child: SizedBox(
//                   height: MediaQuery.sizeOf(context).height * .70,
//                   child: Card(
//                     color: AppColors.kWhiteColor,
//                     margin: const EdgeInsets.all(24),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           const CircleAvatar(
//                             radius: 55,
//                             backgroundColor: AppColors.kPrimaryColor,
//                             foregroundColor: AppColors.kWhiteColor,
//                             child: Icon(Icons.person, size: 45),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             userData.name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(userData.email),
//                           const SizedBox(height: 10),
//                           CustomRowBtn(
//                             onTap: () =>
//                                 navigateTo(context, const EditNameView()),
//                             icon: Icons.person,
//                             text: "Edit Name",
//                           ),
//                           const SizedBox(height: 10),
//                           CustomRowBtn(
//                             onTap: () =>
//                                 navigateTo(context, const MyOrdersViwe()),
//                             icon: Icons.shopping_basket,
//                             text: "My Orders",
//                           ),
//                           const SizedBox(height: 10),
//                           CustomRowBtn(
//                             onTap: () async {
//                               await context.read<AuthCubit>().logout();
//                             },
//                             icon: Icons.logout,
//                             text: "Logout",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }
