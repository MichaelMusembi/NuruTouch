import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/design_tokens.dart';

class BrailleGridWidget extends ConsumerStatefulWidget {
  final Function(int dotNumber) onDotTouched;
  final List<int> highlightedDots;

  const BrailleGridWidget({
    super.key,
    required this.onDotTouched,
    this.highlightedDots = const [],
  });

  @override
  ConsumerState<BrailleGridWidget> createState() => _BrailleGridWidgetState();
}

class _BrailleGridWidgetState extends ConsumerState<BrailleGridWidget> {
  int? _lastTouchedDot;

  void _handleTouch(Offset localPosition, Size size) {
    final double colWidth = size.width / 2;
    final double rowHeight = size.height / 3;

    int col = (localPosition.dx / colWidth).floor();
    int row = (localPosition.dy / rowHeight).floor();

    // Bound checks
    col = col.clamp(0, 1);
    row = row.clamp(0, 2);

    // Map grid position to dot number (1-6)
    // 1 4
    // 2 5
    // 3 6
    int dotNumber = (col == 0) ? (row + 1) : (row + 4);

    if (_lastTouchedDot != dotNumber) {
      _lastTouchedDot = dotNumber;
      widget.onDotTouched(dotNumber);
    }
  }

  void _handleTouchEnd() {
    _lastTouchedDot = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) => _handleTouch(details.localPosition, context.size!),
      onPanUpdate: (details) => _handleTouch(details.localPosition, context.size!),
      onPanEnd: (_) => _handleTouchEnd(),
      onPanCancel: _handleTouchEnd,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
               _buildDotVisual(1, 0, 0, constraints),
               _buildDotVisual(2, 0, 1, constraints),
               _buildDotVisual(3, 0, 2, constraints),
               _buildDotVisual(4, 1, 0, constraints),
               _buildDotVisual(5, 1, 1, constraints),
               _buildDotVisual(6, 1, 2, constraints),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDotVisual(int dotNumber, int col, int row, BoxConstraints constraints) {
    final double colWidth = constraints.maxWidth / 2;
    final double rowHeight = constraints.maxHeight / 3;
    final bool isHighlighted = widget.highlightedDots.contains(dotNumber);

    return Positioned(
      left: col * colWidth,
      top: row * rowHeight,
      width: colWidth,
      height: rowHeight,
      child: Center(
        child: Container(
          width: DesignTokens.touchTargetStandard,
          height: DesignTokens.touchTargetStandard,
          decoration: BoxDecoration(
            color: isHighlighted ? DesignTokens.colorDotActive : DesignTokens.colorDotInactive,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
