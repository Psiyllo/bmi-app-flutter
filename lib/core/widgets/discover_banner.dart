import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';

class DiscoverBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryLight, // Verifique se a cor existe
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          // Texto no lado esquerdo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover Top Picks',
                  style: AppTextStyles.subtitlePrimary.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary, // Garante contraste
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '+100 lessons',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para ação do botão
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Explore more',
                    style: AppTextStyles.button,
                  ),
                ),
              ],
            ),
          ),
          // Imagem no lado direito
          Image.network(
            'https://via.placeholder.com/100', // Troque pela URL final
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
