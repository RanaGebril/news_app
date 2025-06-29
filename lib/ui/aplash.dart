import 'package:flutter/material.dart';
import 'package:news_app/ui/home_screen.dart';
import '../App_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String route_name = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController textController;
  late Animation<double> logoAnimation;
  late Animation<Offset> textOffsetAnimation;
  late Animation<double> textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation
    logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    logoAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    // Text animation (slide + fade)
    textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    textOffsetAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: textController, curve: Curves.easeOut),
        );
    textFadeAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeIn),
    );

    // Start animations in sequence
    logoController.forward().then((_) {
      textController.forward();
    });

    // Navigate to Home after delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, HomeScreen.route_name);
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.cover,
        ),
        color: AppColors.white_color,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: logoAnimation,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 130,
                  height: 130,
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: textFadeAnimation,
                child: SlideTransition(
                  position: textOffsetAnimation,
                  child: Text(
                    "Stay Informed\nStay Ahead",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.blue_color,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
