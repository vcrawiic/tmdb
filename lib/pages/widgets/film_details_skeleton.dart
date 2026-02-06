import 'package:flutter/material.dart';

class FilmDetailsSkeleton extends StatefulWidget {
  const FilmDetailsSkeleton({super.key});

  @override
  State<FilmDetailsSkeleton> createState() => _FilmDetailsSkeletonState();
}

class _FilmDetailsSkeletonState extends State<FilmDetailsSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _SkeletonBox(animationValue: _animation.value),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: 250,
                      height: 28,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _SkeletonBox(
                          animationValue: _animation.value,
                          width: 80,
                          height: 20,
                        ),
                        const SizedBox(width: 16),
                        _SkeletonBox(
                          animationValue: _animation.value,
                          width: 100,
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: 50,
                      height: 32,
                      borderRadius: 16,
                    ),
                    const SizedBox(height: 16),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: 100,
                      height: 22,
                    ),
                    const SizedBox(height: 8),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 6),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 6),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 6),
                    _SkeletonBox(
                      animationValue: _animation.value,
                      width: 200,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double animationValue;
  final double? width;
  final double? height;
  final double borderRadius;

  const _SkeletonBox({
    required this.animationValue,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade800,
            Colors.grey.shade600,
            Colors.grey.shade800,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment(animationValue - 1, 0),
          end: Alignment(animationValue, 0),
        ),
      ),
    );
  }
}
