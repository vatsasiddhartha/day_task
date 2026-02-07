import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final bool isCompleted;
  final VoidCallback onEdit;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.onEdit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            activeColor: AppColors.primary,
            onChanged: (_) => onToggle(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted ? AppColors.textSecondary : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$date • $time",
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
