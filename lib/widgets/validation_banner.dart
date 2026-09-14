// import 'package:flutter/material.dart';


// class ValidationBanner extends StatelessWidget {
//   final String message;

//   const ValidationBanner({super.key, required this.message});

//   @override
//   Widget build(BuildContext context) {
//     final scheme = Theme.of(context).colorScheme;
//     return Container(
//       width: double.infinity,
//       padding:  EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: scheme.errorContainer,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.error_outline, color: scheme.onErrorContainer, size: 20),
//            SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               message,
//               style: TextStyle(color: scheme.onErrorContainer),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ValidationBanner extends StatelessWidget {
  final String message;

  const ValidationBanner({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFF4CCCC),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDDDD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFC94C4C),
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFF9F3F3F),
                  fontSize: 12,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
