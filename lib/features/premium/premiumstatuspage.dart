import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumStatus extends ConsumerWidget {
  const PremiumStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Premium Status",),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.05),
          ListTile(
            style: ListTileStyle.drawer,
            leading: Container(
              width: size.width * 0.15,
              height: size.width * 0.15,
              decoration: BoxDecoration(
                color: appGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Image.asset(
                  'assets/logo/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: (user.isPremiumUser)
                ? const Text('You are a Premium User')
                : const Text('Get Premium Access'),
            subtitle: Text('billing id: '+ user.id, style: const TextStyle(fontSize: 12, color: appGreyColor, overflow: TextOverflow.ellipsis)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}