import 'package:braille_recognition/widgets/card.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:braille_recognition/widgets/settings_item.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContentProfile extends StatefulWidget {
  const ContentProfile({super.key});

  @override
  State<ContentProfile> createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                MyButton(
                  onTap: () {},
                  child: SvgPicture.asset("images/notification.svg"),
                  width: 24,
                  height: 24,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFFBAE8F9),
                        ),
                        child: Image.asset("images/user.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Anonymous User",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "Standart user",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    OnTapScaleAndFade(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Soon!'),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF95DBF6),
                              Color(0xFF11B1EE),
                            ],
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                MyCard(
                  title: "Account",
                  soonBadge: true,
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: "icons/icon_profile.svg",
                        title: "Personal Data",
                        onTap: () {},
                      ),
                      SettingsItem(
                        icon: "icons/icon_history.svg",
                        title: "History",
                        onTap: () {},
                      ),
                      SettingsItem(
                        icon: "icons/icon_stat.svg",
                        title: "Premium account",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MyCard(
                  title: "Notifications",
                  soonBadge: true,
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: "icons/icon_notifications.svg",
                        title: "Pop-up Notifications",
                        isSwitch: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MyCard(
                  title: "Other",
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: "icons/icon_message.svg",
                        title: "Contact Us",
                        onTap: () {
                          launchUrlString(
                              "https://abduvoitov.uz/braille_contact.html");
                        },
                      ),
                      SettingsItem(
                        icon: "icons/icon_privacy.svg",
                        title: "Privacy Policy",
                        onTap: () {
                          launchUrlString(
                              "https://abduvoitov.uz/braille_pp.html");
                        },
                      ),
                      SettingsItem(
                        icon: "icons/icon_settings.svg",
                        title: "Settings",
                        onTap: () {
                          launchUrlString(
                              "mailto:m.abduvoitov@icloud.com?subject=Braille Recognition");
                        },
                      ),
                      SettingsItem(
                        icon: "icons/icon_community.svg",
                        title: "Share",
                        onTap: () {
                          Share.share(
                              'check out my website https://example.com');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Focus Group\n© Copyrights 2023",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
