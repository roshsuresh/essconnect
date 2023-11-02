import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text, required this.fSize})
      : super(key: key);

  final String text;
  final double fSize;

  @override
  _TextWrapperState createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  late int numLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.text,
            style: TextStyle(fontSize: widget.fSize),
            maxLines: isExpanded ? 100 : 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        widget.text.length < 80
            ? const SizedBox()
            : InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isExpanded == false ? 'Read more' : 'Read less',
                    style: const TextStyle(
                      color: UIGuide.light_Purple,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
      ],
    );
  }
  // bool isExpanded = false;
  // @override
  // Widget build(BuildContext context) {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     AnimatedSize(
  //         duration: const Duration(milliseconds: 300),
  //         child: ConstrainedBox(
  //             constraints: isExpanded
  //                 ? const BoxConstraints()
  //                 : const BoxConstraints(maxHeight: 40),
  //             child: Text(
  //               widget.text,
  //               style: const TextStyle(fontSize: 16),
  //               softWrap: true,
  //               overflow: TextOverflow.fade,
  //             ))),
  //     isExpanded
  //         ? OutlinedButton.icon(
  //             icon: const Icon(
  //               Icons.arrow_upward,
  //               size: 11,
  //               color: UIGuide.light_Purple,
  //             ),
  //             label: const Text(
  //               'Read less',
  //               style: TextStyle(
  //                 fontSize: 11,
  //                 color: UIGuide.light_Purple,
  //               ),
  //             ),
  //             onPressed: () => setState(() => isExpanded = false))
  //         : TextButton.icon(
  //             icon: const Icon(
  //               Icons.arrow_downward,
  //               size: 11,
  //               color: UIGuide.light_Purple,
  //             ),
  //             label: const Text(
  //               'Read more',
  //               style: TextStyle(fontSize: 11, color: UIGuide.light_Purple),
  //             ),
  //             onPressed: () => setState(() => isExpanded = true))
  //   ]);
  // }
}
