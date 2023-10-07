import 'dart:async';
import 'package:flutter/material.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;
  List<String> letters = [
    'W',
    'H',
    'I',
    'L',
    'E'
  ]; // Update letters for "WHILE"
  List<Widget> animatedLetters = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Create scale and fade animations
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Create a bounce animation
    _bounceAnimation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Start the animation when the widget is initialized
    _controller.forward();

    // Start the timer to navigate to the next screen
    Timer(const Duration(seconds: 3), navigationPage);

    // Start animating letters
    animateLetters();
  }

  void navigationPage() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, RoutesName.wrapper);
  }

  void animateLetters() {
    if (_currentIndex < letters.length) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          setState(() {
            animatedLetters.add(
              Text(
                letters[_currentIndex],
                style: const TextStyle(
                  fontSize: 48.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
            _currentIndex++;
          });

          animateLetters();
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Stack(
        children: [
          // Animated Background Particles
          const AnimatedBackgroundParticles(),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, -_bounceAnimation.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: animatedLetters,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackgroundParticles extends StatefulWidget {
  const AnimatedBackgroundParticles({super.key});
  @override
  AnimatedBackgroundParticlesState createState() =>
      AnimatedBackgroundParticlesState();
}

class AnimatedBackgroundParticlesState
    extends State<AnimatedBackgroundParticles> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.deepPurple,
          ],
        ),
      ),
    );
  }
}
