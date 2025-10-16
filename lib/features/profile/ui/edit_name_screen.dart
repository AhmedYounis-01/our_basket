import 'package:e_commerce_supabase/core/function/custom_appbar.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_button.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Edit Name"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomTextFormField(labelText: "Enter Name"),
            const SizedBox(height: 15),
            CustomEBtn(text: "Update", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
