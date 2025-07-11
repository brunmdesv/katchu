import 'package:flutter/material.dart';
import '../styles.dart';

class CardPadrao extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? color;
  const CardPadrao({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding ?? const EdgeInsets.all(AppSpaces.cardPadding),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSpaces.cardRadius),
        border: Border.all(color: context.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(AppSpaces.cardRadius),
        onTap: onTap,
        child: card,
      );
    }
    return card;
  }
}
