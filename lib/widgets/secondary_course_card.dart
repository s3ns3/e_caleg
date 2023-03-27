import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/kunjungan.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Kunjungan course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  course.kelurahan,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Text(
                  "Watch video - 15 mins",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}
