import 'package:flutter/material.dart';

/// Table with sticky headers. Whenever you scroll content horizontally
/// or vertically - top and left headers always stay.


class StickyHeadersTable extends StatefulWidget {
  final Color borderColor;
  final Color evenRowColor;
  final int rowsLength;
  final int columnsLength;
  final Widget legendCell;
  final Widget Function(int colulmnIndex) columnsTitleBuilder;
  final Widget Function(int rowIndex) rowsTitleBuilder;
  final Widget Function(int columnIndex, int rowIndex) contentCellBuilder;
  final CellDimensions cellDimensions;
  final BoxFit cellFit;


  StickyHeadersTable({
    Key key,

    /// Number of Columns (for content only)
    @required this.columnsLength,

    /// Number of Rows (for content only)
    @required this.rowsLength,

    /// Title for Top Left cell (always visible)
    this.legendCell = const Text(' '),

    /// Builder for column titles. Takes index of content column as parameter
    /// and returns String for column title
    @required this.columnsTitleBuilder,

    /// Builder for row titles. Takes index of content row as parameter
    /// and returns String for row title
    @required this.rowsTitleBuilder,

    /// Builder for content cell. Takes index for content column first,
    /// index for content row second and returns String for cell
    @required this.contentCellBuilder,

    /// Table cell dimensions
    this.cellDimensions = CellDimensions.base,

    /// Type of fit for content
    this.cellFit = BoxFit.scaleDown,
    this.borderColor = Colors.black12,@required this.evenRowColor,
  }) : super(key: key) {
    assert(columnsLength != null);
    assert(rowsLength != null);
    assert(columnsTitleBuilder != null);
    assert(rowsTitleBuilder != null);
    assert(contentCellBuilder != null);
  }

  @override
  _StickyHeadersTableState createState() => _StickyHeadersTableState();
}

class _StickyHeadersTableState extends State<StickyHeadersTable> {
  final ScrollController _verticalTitleController = ScrollController();
  final ScrollController _verticalBodyController = ScrollController();

  final ScrollController _horizontalBodyController = ScrollController();
  final ScrollController _horizontalTitleController = ScrollController();

  _SyncScrollController _verticalSyncController;
  _SyncScrollController _horizontalSyncController;



  @override
  void initState() {
    super.initState();
    _verticalSyncController = _SyncScrollController(
        [_verticalTitleController, _verticalBodyController]);
    _horizontalSyncController = _SyncScrollController(
        [_horizontalTitleController, _horizontalBodyController]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // STICKY LEGEND
            Container(
              color: widget.evenRowColor,
              width: widget.cellDimensions.stickyLegendWidth,
              height: widget.cellDimensions.stickyLegendHeight,
              child: FittedBox(
                fit: widget.cellFit,
                child: widget.legendCell,
              ),
            ),
            // STICKY ROW
            Expanded(
              child: NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: widget.evenRowColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        widget.columnsLength,
                        (i) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: widget.borderColor,
                                // width: 2,
                              ),
                            ),
                          ),
                          width: widget.cellDimensions.contentCellWidth,
                          height: widget.cellDimensions.stickyLegendHeight,
                          child: FittedBox(
                            fit: widget.cellFit,
                            child: widget.columnsTitleBuilder(i),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller: _horizontalTitleController,
                ),
                onNotification: (ScrollNotification notification) {
                  _horizontalSyncController.processNotification(
                      notification, _horizontalTitleController);
                  return true;
                },
              ),
            )
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // STICKY COLUMN
              NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: widget.borderColor,
                          // width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        widget.rowsLength,
                        (i) => Container(
                          decoration: BoxDecoration(
                            color: i.isEven ? Colors.white : widget.evenRowColor,
                            // border: Border.all(
                            //   color: widget.borderColor,
                            // ),
                          ),
                          width: widget.cellDimensions.stickyLegendWidth,
                          height: widget.cellDimensions.contentCellHeight,
                          child: FittedBox(
                            fit: widget.cellFit,
                            child: widget.rowsTitleBuilder(i),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller: _verticalTitleController,
                ),
                onNotification: (ScrollNotification notification) {
                  _verticalSyncController.processNotification(
                      notification, _verticalTitleController);
                  return true;
                },
              ),
              // CONTENT
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _horizontalSyncController.processNotification(
                        notification, _horizontalBodyController);
                    return true;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalBodyController,
                    child: NotificationListener<ScrollNotification>(
                      child: SingleChildScrollView(
                          controller: _verticalBodyController,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: widget.borderColor,
                                  // width: 2,
                                ),
                              ),
                            ),
                            child: Column(
                              children: List.generate(
                                widget.rowsLength,
                                (int i) => Container(
                                  color: i.isEven ? Colors.white : widget.evenRowColor,
                                  child: Row(
                                    children: List.generate(
                                      widget.columnsLength,
                                      (int j) => Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                color: widget.borderColor),
                                          ),
                                        ),
                                        width: widget
                                            .cellDimensions.contentCellWidth,
                                        height: widget
                                            .cellDimensions.contentCellHeight,
                                        child: FittedBox(
                                          fit: widget.cellFit,
                                          child:
                                              widget.contentCellBuilder(j, i),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      onNotification: (ScrollNotification notification) {
                        _verticalSyncController.processNotification(
                            notification, _verticalBodyController);
                        return true;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Dimensions for table
class CellDimensions {
  const CellDimensions({
    /// Content cell width. It also applied to sticky row width.
    @required this.contentCellWidth,

    /// Content cell height. It also applied to sticky column height.
    @required this.contentCellHeight,

    /// Sticky legend width. It also applied to sticky column width.
    @required this.stickyLegendWidth,

    /// Sticky legend height/ It also applied to sticky row height.
    @required this.stickyLegendHeight,
  });

  final double contentCellWidth;
  final double contentCellHeight;
  final double stickyLegendWidth;
  final double stickyLegendHeight;

  static const CellDimensions base = CellDimensions(
    contentCellWidth: 70.0,
    contentCellHeight: 50.0,
    stickyLegendWidth: 120.0,
    stickyLegendHeight: 50.0,
  );
}

/// SyncScrollController keeps scroll controllers in sync.
class _SyncScrollController {
  _SyncScrollController(List<ScrollController> controllers) {
    controllers
        .forEach((controller) => _registeredScrollControllers.add(controller));
  }

  final List<ScrollController> _registeredScrollControllers = [];

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        for (ScrollController controller in _registeredScrollControllers) {
          if (identical(_scrollingController, controller)) continue;
          controller.jumpTo(_scrollingController.offset);
        }
      }
    }
  }
}
