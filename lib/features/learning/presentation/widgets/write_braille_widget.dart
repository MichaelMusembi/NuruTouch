import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/design_tokens.dart';

class WriteBrailleWidget extends ConsumerStatefulWidget {
  final Function(List<int> activeDots) onSubmission;

  const WriteBrailleWidget({
    super.key,
    required this.onSubmission,
  });

  @override
  ConsumerState<WriteBrailleWidget> createState() => _WriteBrailleWidgetState();
}

class _WriteBrailleWidgetState extends ConsumerState<WriteBrailleWidget> {
  final Set<int> _activeDots = {};

  void _toggleDot(int dotNumber) {
    setState(() {
      if (_activeDots.contains(dotNumber)) {
        _activeDots.remove(dotNumber);
      } else {
        _activeDots.add(dotNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                   _buildDotToggle(1, 0, 0, constraints),
                   _buildDotToggle(2, 0, 1, constraints),
                   _buildDotToggle(3, 0, 2, constraints),
                   _buildDotToggle(4, 1, 0, constraints),
                   _buildDotToggle(5, 1, 1, constraints),
                   _buildDotToggle(6, 1, 2, constraints),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceMedium),
          child: SizedBox(
            width: double.infinity,
            height: DesignTokens.touchTargetStandard,
            child: ElevatedButton(
              onPressed: () => widget.onSubmission(_activeDots.toList()..sort()),
              child: const Text('Submit', style: DesignTokens.textHeading),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDotToggle(int dotNumber, int col, int row, BoxConstraints constraints) {
    final double colWidth = constraints.maxWidth / 2;
    final double rowHeight = constraints.maxHeight / 3;
    final bool isActive = _activeDots.contains(dotNumber);

    return Positioned(
      left: col * colWidth,
      top: row * rowHeight,
      width: colWidth,
      height: rowHeight,
      child: GestureDetector(
        onTap: () => _toggleDot(dotNumber),
        child: Center(
          child: Container(
            width: DesignTokens.touchTargetStandard,
            height: DesignTokens.touchTargetStandard,
            decoration: BoxDecoration(
              color: isActive ? DesignTokens.colorDotActive : DesignTokens.colorDotInactive,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
