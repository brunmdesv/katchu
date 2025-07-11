import 'package:flutter/material.dart';

class AppColors {
  // Paleta moderna: Azul profundo, Verde água, Cinza carvão, Branco gelo
  static const Color deepNavy = Color(0xFF0A1628); // Azul marinho profundo
  static const Color slateBlue = Color(0xFF1E3A8A); // Azul ardósia
  static const Color tealGreen = Color(0xFF059669); // Verde água
  static const Color charcoalGray = Color(0xFF1F2937); // Cinza carvão
  static const Color coolGray = Color(0xFF6B7280); // Cinza médio
  static const Color lightGray = Color(0xFFF9FAFB); // Cinza muito claro
  static const Color iceWhite = Color(0xFFFFFFFF); // Branco puro
  
  // Cores primárias
  static const Color primary = slateBlue; // #1E3A8A
  static const Color primaryDark = Color(0xFF1E40AF); // Versão mais vibrante para tema escuro
  static const Color secondary = tealGreen; // #059669
  static const Color tertiary = Color(0xFF0F766E); // Verde água mais escuro
  
  // Backgrounds adaptativos
  static const Color backgroundLight = lightGray; // #F9FAFB
  static const Color backgroundDark = deepNavy; // #0A1628
  
  // Surfaces (cards, containers)
  static const Color surfaceLight = iceWhite; // #FFFFFF
  static const Color surfaceDark = charcoalGray; // #1F2937
  static const Color surfaceVariantLight = Color(0xFFF1F5F9); // Cinza azulado claro
  static const Color surfaceVariantDark = Color(0xFF374151); // Cinza mais claro
  
  // Borders
  static const Color borderLight = Color(0xFFE5E7EB); // Cinza claro
  static const Color borderDark = Color(0xFF4B5563); // Cinza médio
  
  // Textos
  static const Color textPrimaryLight = Color(0xFF111827); // Quase preto
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Quase branco
  static const Color textSecondaryLight = coolGray; // #6B7280
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // Cinza mais claro
  
  // Estados
  static const Color success = tealGreen; // #059669
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFDC2626); // Vermelho
  static const Color info = slateBlue; // #1E3A8A
  
  // Overlay e sombras
  static const Color overlayLight = Color(0x0A111827); // Preto com 4% opacidade
  static const Color overlayDark = Color(0x1AF9FAFB); // Branco com 10% opacidade
  
  // Acentos e destaques
  static const Color accent = tealGreen; // #059669
  static const Color accentLight = Color(0xFF10B981); // Verde água mais claro
  static const Color accentSoft = Color(0xFF6EE7B7); // Verde água suave
  
  // Gradientes
  static const Color gradientStart = slateBlue; // #1E3A8A
  static const Color gradientEnd = tealGreen; // #059669
  
  // Cores neutras derivadas
  static const Color neutralLight = Color(0xFFFCFCFD); // Branco levemente azulado
  static const Color neutralDark = Color(0xFF0F172A); // Azul muito escuro
  
  // Métodos para obter cores baseadas no tema
  static Color getBackground(bool isDark) => 
    isDark ? backgroundDark : backgroundLight;
  
  static Color getSurface(bool isDark) => 
    isDark ? surfaceDark : surfaceLight;
  
  static Color getSurfaceVariant(bool isDark) => 
    isDark ? surfaceVariantDark : surfaceVariantLight;
  
  static Color getBorder(bool isDark) => 
    isDark ? borderDark : borderLight;
  
  static Color getTextPrimary(bool isDark) => 
    isDark ? textPrimaryDark : textPrimaryLight;
  
  static Color getTextSecondary(bool isDark) => 
    isDark ? textSecondaryDark : textSecondaryLight;
  
  static Color getOverlay(bool isDark) => 
    isDark ? overlayDark : overlayLight;
    
  static Color getAccent(bool isDark) => 
    isDark ? accentLight : accent;
    
  static Color getNeutral(bool isDark) => 
    isDark ? neutralDark : neutralLight;
    
  static Color getPrimary(bool isDark) => 
    isDark ? primaryDark : primary;
}

class AppTextStyles {
  // Estilos para tema claro
  static const TextStyle titleLight = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryLight,
    height: 1.3,
  );
  
  static const TextStyle subtitleLight = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondaryLight,
    height: 1.4,
  );
  
  static const TextStyle bodyLight = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryLight,
    height: 1.5,
  );
  
  static const TextStyle captionLight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryLight,
    height: 1.4,
  );
  
  static const TextStyle codeLight = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 6,
    color: AppColors.primary,
    fontFamily: 'monospace',
  );
  
  // Estilos para tema escuro
  static const TextStyle titleDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
    height: 1.3,
  );
  
  static const TextStyle subtitleDark = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondaryDark,
    height: 1.4,
  );
  
  static const TextStyle bodyDark = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
    height: 1.5,
  );
  
  static const TextStyle captionDark = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryDark,
    height: 1.4,
  );
  
  static const TextStyle codeDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 6,
    color: AppColors.accentLight,
    fontFamily: 'monospace',
  );
  
  // Estilos especiais
  static const TextStyle accentTitleLight = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
    height: 1.3,
  );
  
  static const TextStyle accentTitleDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.accentLight,
    height: 1.3,
  );
  
  static const TextStyle brandLight = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    height: 1.2,
  );
  
  static const TextStyle brandDark = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryDark,
    height: 1.2,
  );
  
  // Métodos para obter estilos baseados no tema
  static TextStyle getTitle(bool isDark) => 
    isDark ? titleDark : titleLight;
  
  static TextStyle getSubtitle(bool isDark) => 
    isDark ? subtitleDark : subtitleLight;
  
  static TextStyle getBody(bool isDark) => 
    isDark ? bodyDark : bodyLight;
  
  static TextStyle getCaption(bool isDark) => 
    isDark ? captionDark : captionLight;
  
  static TextStyle getCode(bool isDark) => 
    isDark ? codeDark : codeLight;
    
  static TextStyle getAccentTitle(bool isDark) => 
    isDark ? accentTitleDark : accentTitleLight;
    
  static TextStyle getBrand(bool isDark) => 
    isDark ? brandDark : brandLight;
}

class AppSpaces {
  // Espaçamentos mais consistentes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  
  // Raios de borda modernos
  static const double radiusXs = 6.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  
  // Espaçamentos específicos
  static const double cardRadius = radiusLg;
  static const double cardPadding = xl;
  static const double screenPadding = lg;
  static const double sectionSpacing = xxl;
  static const double itemSpacing = md;
  
  // Elevações
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 12.0;
}

// Extensão para facilitar o uso do tema
extension ThemeExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  
  Color get primaryColor => AppColors.getPrimary(isDark);
  Color get backgroundColor => AppColors.getBackground(isDark);
  Color get surfaceColor => AppColors.getSurface(isDark);
  Color get borderColor => AppColors.getBorder(isDark);
  Color get textPrimaryColor => AppColors.getTextPrimary(isDark);
  Color get textSecondaryColor => AppColors.getTextSecondary(isDark);
  Color get accentColor => AppColors.getAccent(isDark);
  Color get neutralColor => AppColors.getNeutral(isDark);
  
  TextStyle get titleStyle => AppTextStyles.getTitle(isDark);
  TextStyle get subtitleStyle => AppTextStyles.getSubtitle(isDark);
  TextStyle get bodyStyle => AppTextStyles.getBody(isDark);
  TextStyle get captionStyle => AppTextStyles.getCaption(isDark);
  TextStyle get codeStyle => AppTextStyles.getCode(isDark);
  TextStyle get accentTitleStyle => AppTextStyles.getAccentTitle(isDark);
  TextStyle get brandStyle => AppTextStyles.getBrand(isDark);
}

// Classe para gradientes comuns
class AppGradients {
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get surfaceGradient => const LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// Exemplo de uso das extensões:
// Text('Título', style: context.titleStyle)
// Text('Marca', style: context.brandStyle)
// Container(color: context.surfaceColor)
// Container(decoration: BoxDecoration(gradient: AppGradients.primaryGradient))

/* 
PALETA DE CORES CRIADA:
- Deep Navy: #0A1628 (azul marinho profundo)
- Slate Blue: #1E3A8A (azul ardósia moderno)
- Teal Green: #059669 (verde água sofisticado)
- Charcoal Gray: #1F2937 (cinza carvão)
- Cool Gray: #6B7280 (cinza médio)
- Light Gray: #F9FAFB (cinza muito claro)

CARACTERÍSTICAS:
- Paleta profissional e moderna
- Excelente contraste em ambos os temas
- Combinação azul + verde água é tendência
- Cores neutras sofisticadas
- Gradientes elegantes disponíveis
*/