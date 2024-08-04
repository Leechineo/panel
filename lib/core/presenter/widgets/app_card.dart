import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_expandable.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final List<Widget>? actions;
  final Widget? title;
  final String? titleText;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final double? titleWidth;
  final double? titleHeight;
  final EdgeInsetsGeometry? contentPadding;
  final bool loading;
  final bool borderless;
  final bool childExpanded;
  final bool titleExpanded;
  final bool hoverTransparent;
  final bool flexible;
  final Color? color;
  final bool scrollable;
  final BorderRadius? borderRadius;

  const AppCard({
    this.child,
    this.actions,
    this.title,
    this.onTap,
    this.width,
    this.height,
    this.titleWidth,
    this.titleHeight,
    this.contentPadding,
    this.loading = false,
    this.borderless = false,
    this.childExpanded = true,
    this.titleExpanded = true,
    this.titleText,
    this.hoverTransparent = false,
    this.flexible = false,
    this.scrollable = true,
    this.color,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFirstDividerShowing =
        ((title != null || titleText != null) && titleExpanded) &&
            ((child != null && childExpanded) || actions != null);
    // ignore: no_leading_underscores_for_local_identifiers
    final Widget _child = Container(
      width: width,
      height: height,
      padding: contentPadding,
      child: child,
    );
    return SizedBox(
      width: width,
      child: Card(
        color: color,
        shadowColor: Colors.transparent,
        shape: borderless
            ? null
            : RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(28),
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.outline.withOpacity(.2),
                ),
              ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(28),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: hoverTransparent || (childExpanded && !titleExpanded)
                ? Colors.transparent
                : null,
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (loading)
                  const FractionallySizedBox(
                    widthFactor: 0.97,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                if (titleText != null)
                  AppExpandable(
                    isExpanded: titleExpanded,
                    body: Container(
                      width: titleWidth,
                      height: titleHeight,
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          titleText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (title != null && titleText == null)
                  AppExpandable(
                    isExpanded: titleExpanded,
                    body: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      child: SizedBox(
                        // width: double.maxFinite,
                        child: title!,
                      ),
                    ),
                  ),
                AppExpandable(
                  isExpanded: isFirstDividerShowing,
                  body: const AppDivider(),
                ),
                if (flexible && child != null)
                  Flexible(
                    child: AppExpandable(
                      isExpanded: childExpanded,
                      body: scrollable
                          ? SingleChildScrollView(
                              child: _child,
                            )
                          : _child,
                    ),
                  ),
                if (child != null && !flexible)
                  AppExpandable(
                    isExpanded: childExpanded,
                    body: scrollable
                        ? SingleChildScrollView(
                            child: _child,
                          )
                        : _child,
                  ),
                if ((child != null && childExpanded) && actions != null)
                  const AppDivider(),
                if (actions != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      child: AppFlex(
                        // alignment: WrapAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        maxItemsPerRow: 1,
                        maxItemsPerRowMd: actions?.length ?? 2,
                        expanded: false,
                        wrap: true,
                        children: actions!
                            .map(
                              (action) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: action,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
