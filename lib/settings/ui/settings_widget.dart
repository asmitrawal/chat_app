import 'package:chat_app/settings/cubit/theme_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  //theme toggle bool
  bool themeBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SETTINGS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 16),
                ),
                Switch.adaptive(
                  value: themeBool,
                  onChanged: (value) {
                    context.read<ThemeCheckCubit>().toggleTheme();
                    setState(() {
                      themeBool = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
