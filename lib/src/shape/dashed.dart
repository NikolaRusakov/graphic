import 'dart:ui';

import 'package:graphic/src/coord/coord.dart';
import 'package:graphic/src/coord/rect.dart';
import 'package:graphic/src/dataflow/tuple.dart';
import 'package:graphic/src/graffiti/element/element.dart';
import 'package:graphic/src/graffiti/element/path.dart';
import 'package:graphic/src/graffiti/element/rect.dart';
import 'package:graphic/src/graffiti/element/segment/close.dart';
import 'package:graphic/src/graffiti/element/segment/line.dart';
import 'package:graphic/src/graffiti/element/segment/move.dart';
import 'package:vector_math/vector_math_64.dart';

import 'util/style.dart';
import 'shape.dart';

/// A candle stick shape.
///
/// The points order of measure dimension is appointed as:
///
/// ```
/// [star, end, max, min]
/// ```
///
/// And the end point is regarded as represent point.
///
/// ** We insist that the price of a subject matter of investment is determined
/// by its intrinsic value. Too much attention to the short-term fluctuations in
/// prices is harmful. Thus a candlestick chart may misslead your investment decision.**
class DashedRecShape extends Shape {
  /// Creates a candle stick shape.
  DashedRecShape({
    this.hollow = true,
    this.strokeWidth = 1,
  });

  /// whether the sticks are hollow.
  final bool hollow;

  /// The stroke width of the stick.
  final double strokeWidth;

  @override
  bool equalTo(Object other) =>
      other is DashedRecShape &&
      hollow == other.hollow &&
      strokeWidth == other.strokeWidth;

  @override
  double get defaultSize => 10;

  @override
  List<MarkElement> drawGroupPrimitives(
    List<Attributes> group,
    CoordConv coord,
    Offset origin,
  ) {
    assert(coord is RectCoordConv);
    assert(!coord.transposed);

    final primitives = <MarkElement>[];

    for (var item in group) {
      // assert(item.shape is DashedRecShape);

      final style = getPaintStyle(
          Attributes(
              index: 0,
              position: [Offset(100, 500)],
              shape: item.shape,
              elevation: 10,
              color: Color.fromARGB(124, 106, 0, 255)),
          true,
          // (item.shape as DashedRecShape).hollow,
          // (item.shape as DashedRecShape).strokeWidth
          2,
          null,
          [10]);

      // Candle stick shape dosen't allow NaN value.
      // final points = item.position.map((p) => coord.convert(p)).toList();
      // final x = points.first.dx;
      // final ys = points.map((p) => p.dy).toList()..sort();
      // final bias = (item.size ?? defaultSize) / 2;
      // final top = ys[0];
      // final topEdge = ys[1];
      // final bottomEdge = ys[2];
      // final bottom = ys[3];
      primitives.add(
        RectElement(
          rect: Rect.fromPoints(Offset(100, 400), Offset(120, 100)),
          style: PaintStyle(
            fillColor: Color.fromRGBO(255, 217, 0, 0.583),
            dash: [6],
            strokeColor: Color.fromARGB(234, 0, 255, 26),
            strokeWidth: 2,
          ),
        ),
      );
      // if ((item.shape as DashedRecShape).hollow) {
      /* primitives.add(
        PathElement(
          style: style,
          tag: item.tag,
          segments: [
            MoveSegment(end: Offset(100, 250)),
            LineSegment(end: Offset(100, 100)),

            MoveSegment(end: Offset(100, 100)),
            LineSegment(end: Offset(150, 100)),

            MoveSegment(end: Offset(150, 100)),
            LineSegment(end: Offset(150, 250)),

            MoveSegment(end: Offset(150, 250)),
            LineSegment(end: Offset(100, 250)),

            // ---
            // MoveSegment(end: Offset(x, top)),
            // LineSegment(end: Offset(x, topEdge)),
            // MoveSegment(end: Offset(x - bias, topEdge)),
            // LineSegment(end: Offset(x + bias, topEdge)),
            // LineSegment(end: Offset(x + bias, bottomEdge)),
            // LineSegment(end: Offset(x - bias, bottomEdge)),
            // CloseSegment(),
            // // MoveSegment(end: Offset(x, bottomEdge)),
            // // LineSegment(end: Offset(x, bottom)),
          ],
        ),
      );
       */
      // } else {
      //   // If the stoke style is fill, the lines created by Path.lineTo will not
      //   // be rendered.
      //   final strokeBias = (item.shape as DashedRecShape).strokeWidth / 2;
      //   primitives.add(PathElement(segments: [
      //     MoveSegment(end: Offset(x + strokeBias, top)),
      //     LineSegment(end: Offset(x + strokeBias, topEdge)),
      //     LineSegment(end: Offset(x + bias, topEdge)),
      //     LineSegment(end: Offset(x + bias, bottomEdge)),
      //     LineSegment(end: Offset(x + strokeBias, bottomEdge)),
      //     LineSegment(end: Offset(x + strokeBias, bottom)),
      //     LineSegment(end: Offset(x - strokeBias, bottom)),
      //     LineSegment(end: Offset(x - strokeBias, bottomEdge)),
      //     LineSegment(end: Offset(x - bias, bottomEdge)),
      //     LineSegment(end: Offset(x - bias, topEdge)),
      //     LineSegment(end: Offset(x - strokeBias, topEdge)),
      //     LineSegment(end: Offset(x - strokeBias, top)),
      //     CloseSegment(),
      //   ], style: style, tag: item.tag));
      // }
      // No labels.
    }

    return primitives;
  }

  @override
  List<MarkElement> drawGroupLabels(
          List<Attributes> group, CoordConv coord, Offset origin) =>
      [];

  @override
  Offset representPoint(List<Offset> position) => position[1];
}
