import 'dart:async';
import 'package:flutter/material.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;
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
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Create scale and fade animations
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Create a bounce animation
    _bounceAnimation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Create a rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    // Start the animation when the widget is initialized
    _controller.forward();

    // Start the timer to navigate to the next screen
    Timer(Duration(seconds: 3), navigationPage);

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
        Duration(milliseconds: 300),
        () {
          setState(() {
            animatedLetters.add(
              ScaleTransition(
                scale: _scaleAnimation, // Apply scale animation to the letter
                child: FadeTransition(
                  opacity: _fadeAnimation, // Apply fade animation to the letter
                  child: RotationTransition(
                    turns:
                        _rotationAnimation, // Apply rotation animation to the letter
                    child: Text(
                      letters[_currentIndex],
                      style: TextStyle(
                        fontSize: 48.0, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
          // Animated Background Gradient
          AnimatedBackgroundGradient(),
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

class AnimatedBackgroundGradient extends StatefulWidget {
  @override
  _AnimatedBackgroundGradientState createState() =>
      _AnimatedBackgroundGradientState();
}

class _AnimatedBackgroundGradientState
    extends State<AnimatedBackgroundGradient> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: BoxDecoration(
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
