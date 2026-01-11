import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/news_card.dart';
import 'package:tifltails_official/components/spacing.dart';

class NewsBar extends StatelessWidget {
  const NewsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: blockMargin,
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowSpacing: 25,
        columnSpacing: 32,
        children: const [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: NewsCard(
              title: "Tifltails Donation: Supporting Shelters Nationwide",
              imagePath: "assets/images/donation_announcement.png",
              linkUrl: "https://tifltails.com/",
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: NewsCard(
              title: "Tifltails Adoption Drive: Find Your New Best Friend",
              imagePath: "assets/images/pet_adoption_news.png",
              linkUrl: "https://tifltails.com/",
            ),
          ),
        ],
      ),
    );
  }
}
