
import 'package:flutter/material.dart';


class SignOutTile extends StatelessWidget {
  final Function() onTap;

  const SignOutTile({
    super.key,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) => Ink(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.exit_to_app, 
              color: Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(width: 16),
            Text(
              'Выйти', 
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ),
    );
}
