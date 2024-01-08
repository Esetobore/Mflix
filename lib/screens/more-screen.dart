import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final String discord = Uri.parse("https://discord.com/invite/HUpWspd4").toString();
  final String whatsApp = Uri.parse("https://wa.me/qr/C4E5OAE3B535L1").toString();
  final String twitter = Uri.parse("https://twitter.com/Esetobore?t=NUyaVjKY3NoX_hOZWYA9Cw&s=09").toString();
  final String github = Uri.parse("https://github.com/Esetobore").toString();


  // Function to open a URL
  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                      "assets/mflix_logo.png",
                      height: 250, width: 250
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                     IconButton(
                      onPressed: () {
                        Get.changeTheme(
                          Get.isDarkMode ? lightMode : darkMode
                        );
                      },
                       icon: Icon(
                         Get.isDarkMode ? Icons.dark_mode_rounded :
                         Icons.light_mode_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 27,),
                     ),
                    const SizedBox(width: 30,),
                    Text(
                      Get.isDarkMode ? "Dark Mode" : "Light Mode", style: TextStyle(
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                     IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,),),
                    const SizedBox(width: 30,),
                    Text(
                      "About", style: TextStyle(
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 200,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () => _launchUrl(Uri.parse(discord)),
                      iconSize: 30,
                      icon: Icon(Icons.discord_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,)
                  ),
                  IconButton(
                      onPressed: () => _launchUrl(Uri.parse(whatsApp)),
                      iconSize: 30,
                      icon:  Icon(FontAwesomeIcons.whatsapp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,)
                  ),
                  IconButton(
                      onPressed: () => _launchUrl(Uri.parse(twitter)),
                      iconSize: 30,
                      icon: Icon(FontAwesomeIcons.twitter,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,)
                  ),
                  IconButton(
                      onPressed: () => _launchUrl(Uri.parse(github)),
                      iconSize: 30,
                      icon: Icon(FontAwesomeIcons.github,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,)
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
