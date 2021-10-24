import 'package:flutter/material.dart';
import '../models/redditor.dart';
import '../views/flapp_page.dart';


/// Controller for Settings Page, where the user can change settings
class SettingsPageView extends StatefulWidget {
  Redditor user;
  /// A map of settings to display. Key is the key of settings in user's prefs, the value is the label
  final Map<String, String> settings;

  SettingsPageView({Key? key, required this.user, required this.settings}) : super(key: key);

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView>
{
  @override
  Widget build(BuildContext context)
  {
    List<Widget> settingsFields = [];
    Widget saveButton = Column(children: [
      ElevatedButton(onPressed: () { print(widget.user.prefs['video_autoplay']); },
        child: Text("Save changes"),
        style: ElevatedButton.styleFrom(primary: Theme.of(context).backgroundColor),
      ),

    ]);

    for (var key in widget.settings.keys) {
      settingsFields.add(Container(padding: const EdgeInsets.all(20), child: Row(
          children: [
            Expanded(child: Text(widget.settings[key]!)),
            Switch(value: widget.user.prefs[key], onChanged: (bool value) => setState((){ widget.user.prefs[key] = value;})),
          ]
      )));
    }

    return FlappPage(title: "Settings",
        body: Column(children: settingsFields + [saveButton])
    );
  }
}
