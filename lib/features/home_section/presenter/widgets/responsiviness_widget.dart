import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_expandable.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

class ResponsivinessWidget extends StatefulWidget {
  final Widget xsChild;
  final Widget smChild;
  final Widget mdChild;
  final Widget lgChild;
  final Widget xlChild;
  final Widget xxlChild;
  final void Function() onUpdated;
  final double? width;
  final double? height;
  final Responsiviness responsiviness;
  const ResponsivinessWidget({
    required this.xsChild,
    required this.smChild,
    required this.mdChild,
    required this.lgChild,
    required this.xlChild,
    required this.xxlChild,
    required this.responsiviness,
    required this.onUpdated,
    this.width,
    this.height,
    super.key,
  });

  @override
  State<ResponsivinessWidget> createState() => _ResponsivinessWidgetState();
}

class _ResponsivinessWidgetState extends State<ResponsivinessWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool fullScreen = false;
  ElementScreenSizes selected = ElementScreenSizes.xs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      final currentScreenSize = DisplayHelper.getElementScreenSize(context);
      if (widget.responsiviness.linked) {
        setState(() {
          selected = ElementScreenSizes.xs;
        });
      } else {
        goToPage(currentScreenSize);
      }
    });
  }

  void goToPage(ElementScreenSizes screenSize) {
    final List<ElementScreenSizes> sizes = [
      ElementScreenSizes.xs,
      ElementScreenSizes.sm,
      ElementScreenSizes.md,
      ElementScreenSizes.lg,
      ElementScreenSizes.xl,
      ElementScreenSizes.xxl,
    ];
    setState(() {
      selected = screenSize;
      final int index = sizes.indexOf(selected);
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = MediaQuery.of(context).size.width;
        final fullHeight = MediaQuery.of(context).size.height - 138;

        return AppCard(
          borderless: fullScreen,
          borderRadius: fullScreen ? const BorderRadius.all(Radius.zero) : null,
          height: fullScreen ? fullHeight : widget.height ?? 200,
          width: fullScreen ? fullWidth : widget.width ?? 200,
          title: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                AppExpandable(
                  isExpanded: !widget.responsiviness.linked,
                  body: SegmentedButton(
                    segments: const [
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.xs,
                        label: Text('XS'),
                        icon: Icon(
                          Icons.phone_iphone,
                        ),
                      ),
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.sm,
                        label: Text('SM'),
                        icon: Icon(
                          Icons.smartphone,
                        ),
                      ),
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.md,
                        label: Text('MD'),
                        icon: Icon(
                          Icons.tablet_android,
                        ),
                      ),
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.lg,
                        label: Text('LG'),
                        icon: Icon(
                          Icons.laptop_mac,
                        ),
                      ),
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.xl,
                        label: Text('XL'),
                        icon: Icon(
                          Icons.desktop_windows_outlined,
                        ),
                      ),
                      ButtonSegment<ElementScreenSizes>(
                        value: ElementScreenSizes.xxl,
                        label: Text('XXL'),
                        icon: Icon(
                          Icons.tv,
                        ),
                      ),
                    ],
                    selected: {selected},
                    onSelectionChanged: (value) {
                      goToPage(value.first);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      fullScreen = !fullScreen;
                    });
                  },
                  style: const ButtonStyle(
                    iconSize: WidgetStatePropertyAll(15),
                  ),
                  icon: Icon(
                    fullScreen ? Icons.close_fullscreen : Icons.open_in_full,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Tooltip(
              message:
                  '${widget.responsiviness.linked ? 'Desvincular' : 'Vincular'} configurações de tela',
              child: IconButton(
                style: widget.responsiviness.linked
                    ? ButtonStyle(
                        iconColor: WidgetStatePropertyAll(
                          Theme.of(context).buttonTheme.colorScheme?.primary,
                        ),
                      )
                    : null,
                onPressed: () {
                  setState(() {
                    widget.responsiviness.linked =
                        !widget.responsiviness.linked;
                  });
                  if (widget.responsiviness.linked) {
                    goToPage(ElementScreenSizes.xs);
                  } else {
                    final screenSize =
                        DisplayHelper.getElementScreenSize(context);
                    goToPage(screenSize);
                  }
                  widget.onUpdated.call();
                },
                icon: Icon(
                  widget.responsiviness.linked ? Icons.link_off : Icons.link,
                ),
              ),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Fechar',
              ),
            ),
          ],
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: widget.xsChild,
              ),
              SingleChildScrollView(
                child: widget.smChild,
              ),
              SingleChildScrollView(
                child: widget.mdChild,
              ),
              SingleChildScrollView(
                child: widget.lgChild,
              ),
              SingleChildScrollView(
                child: widget.xlChild,
              ),
              SingleChildScrollView(
                child: widget.xxlChild,
              ),
            ],
          ),
        );
      },
    );
  }
}
