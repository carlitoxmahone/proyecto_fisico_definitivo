import 'package:flutter/material.dart';

class ExerciseImage extends StatelessWidget {
  const ExerciseImage({
    super.key,
    required this.imageAsset,
    this.height,
  });

  final String imageAsset;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF101F1B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color(0xFF00E0A4).withValues(alpha: 0.24),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _ExerciseImagePlaceholder(imageAsset: imageAsset);
            },
          ),
        ),
      ),
    );
  }
}

class _ExerciseImagePlaceholder extends StatelessWidget {
  const _ExerciseImagePlaceholder({
    required this.imageAsset,
  });

  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFF101F1B),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_not_supported_outlined,
              color: Color(0xFF00E0A4),
              size: 42,
            ),
            const SizedBox(height: 10),
            const Text(
              'Imagen pendiente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              imageAsset,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: Colors.white.withValues(alpha: 0.58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
