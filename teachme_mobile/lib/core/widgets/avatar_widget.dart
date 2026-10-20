import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.size = 48,
    this.isVerified = false,
  });

  final String? imageUrl;
  final double size;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: Brand.secondary.withValues(alpha: 0.2),
      backgroundImage:
          imageUrl != null ? CachedNetworkImageProvider(imageUrl!) : null,
      child: imageUrl == null
          ? Icon(Icons.person, size: size * 0.5, color: Brand.secondary)
          : null,
    );

    if (!isVerified) return avatar;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: StatusColors.successLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.check,
                size: size * 0.18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
