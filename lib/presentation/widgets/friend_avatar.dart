import 'package:flutter/material.dart';
import '../../core/utils/avatar_colors.dart';
import '../../domain/models/saved_person.dart';

/// A beautiful avatar widget for displaying friend initials with colors.
class FriendAvatar extends StatelessWidget {
  final SavedPerson person;
  final double size;
  final bool showBorder;
  final VoidCallback? onTap;

  const FriendAvatar({
    super.key,
    required this.person,
    this.size = 48,
    this.showBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = person.avatarColor != null 
        ? Color(person.avatarColor!) 
        : AvatarColors.toColor(AvatarColors.getColorForName(person.name));
    final textColor = AvatarColors.getContrastingTextColor(
      person.avatarColor ?? AvatarColors.getColorForName(person.name)
    );
    final initials = AvatarColors.getInitials(person.name);

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: textColor,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }
}

/// A small badge showing friend count or status.
class FriendCountBadge extends StatelessWidget {
  final int count;
  final Color? color;

  const FriendCountBadge({
    super.key,
    required this.count,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A row of stacked friend avatars (for showing participants).
class FriendAvatarStack extends StatelessWidget {
  final List<SavedPerson> people;
  final double size;
  final int maxVisible;
  final double overlap;

  const FriendAvatarStack({
    super.key,
    required this.people,
    this.size = 32,
    this.maxVisible = 4,
    this.overlap = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    final visiblePeople = people.take(maxVisible).toList();
    final remaining = people.length - maxVisible;
    final overlapOffset = size * overlap;

    return SizedBox(
      width: size + (visiblePeople.length - 1) * (size - overlapOffset) + (remaining > 0 ? size : 0),
      height: size,
      child: Stack(
        children: [
          ...visiblePeople.asMap().entries.map((entry) {
            final index = entry.key;
            final person = entry.value;
            return Positioned(
              left: index * (size - overlapOffset),
              child: FriendAvatar(
                person: person,
                size: size,
                showBorder: true,
              ),
            );
          }),
          if (remaining > 0)
            Positioned(
              left: visiblePeople.length * (size - overlapOffset),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
