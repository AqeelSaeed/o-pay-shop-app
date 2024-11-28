import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class NetworkImageComponent extends StatelessWidget {
  final String url;
  final double borderRadius;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? borderWidth;
  final BoxFit fit;

  const NetworkImageComponent({
    super.key,
    required this.url,
    this.borderRadius = 999,
    this.size = 50,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            width: borderWidth ?? 0.1,
            color: (borderColor ?? primaryColor).withOpacity(0.10)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height ?? size,
      width: width ?? size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          url,
          fit: fit,
          color: color,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: primaryColor,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.error,
                color: primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
