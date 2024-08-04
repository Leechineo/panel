import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/presenter/widgets/responsiviness_widget.dart';

class FlexResponsivinessSettings extends StatefulWidget {
  final section_entity.Element element;
  final void Function() onElementUpdated;
  const FlexResponsivinessSettings({
    required this.element,
    required this.onElementUpdated,
    super.key,
  });

  @override
  State<FlexResponsivinessSettings> createState() =>
      _FlexResponsivinessSettingsState();
}

class _FlexResponsivinessSettingsState
    extends State<FlexResponsivinessSettings> {
  @override
  Widget build(BuildContext context) {
    Widget flexRadio({
      required section_entity.ElementAlignment value,
      required section_entity.ElementAlignment groupValue,
      required section_entity.ResponsivinessFlexOptions flexOptions,
      required section_entity.ElementAlignmentType alignmentType,
    }) {
      String title() {
        switch (value) {
          case section_entity.ElementAlignment.start:
            return 'Início';
          case section_entity.ElementAlignment.end:
            return 'Final';
          case section_entity.ElementAlignment.center:
            return 'Centralizado';
          case section_entity.ElementAlignment.spaceBetween:
            return 'Entre os itens';
          case section_entity.ElementAlignment.spaceAround:
            return 'Nas extreminades';
          case section_entity.ElementAlignment.spaceEvenly:
            return 'Uniforme';
        }
      }

      MainAxisAlignment mainAxisAlignment(
        section_entity.ElementAlignment alignment,
      ) {
        switch (alignment) {
          case section_entity.ElementAlignment.start:
            return MainAxisAlignment.start;
          case section_entity.ElementAlignment.end:
            return MainAxisAlignment.end;
          case section_entity.ElementAlignment.center:
            return MainAxisAlignment.center;
          case section_entity.ElementAlignment.spaceBetween:
            return MainAxisAlignment.spaceBetween;
          case section_entity.ElementAlignment.spaceAround:
            return MainAxisAlignment.spaceAround;
          case section_entity.ElementAlignment.spaceEvenly:
            return MainAxisAlignment.spaceEvenly;
        }
      }

      CrossAxisAlignment crossAxisAlignment() {
        switch (value) {
          case section_entity.ElementAlignment.start:
            return CrossAxisAlignment.start;
          case section_entity.ElementAlignment.end:
            return CrossAxisAlignment.end;
          case section_entity.ElementAlignment.center:
            return CrossAxisAlignment.center;
          default:
            return CrossAxisAlignment.start;
        }
      }

      Widget exampleParent({required List<Widget> children}) {
        if (widget.element is section_entity.RowElement) {
          return Row(
            mainAxisAlignment: mainAxisAlignment(
              alignmentType == section_entity.ElementAlignmentType.align
                  ? flexOptions.justify
                  : value,
            ),
            crossAxisAlignment: crossAxisAlignment(),
            children: children,
          );
        }
        return Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: mainAxisAlignment(
                  alignmentType == section_entity.ElementAlignmentType.align
                      ? flexOptions.justify
                      : value,
                ),
                crossAxisAlignment:
                    alignmentType == section_entity.ElementAlignmentType.justify
                        ? CrossAxisAlignment.center
                        : crossAxisAlignment(),
                children: children,
              ),
            ),
          ],
        );
      }

      return RadioListTile<section_entity.ElementAlignment>(
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          if (value != null) {
            if (alignmentType == section_entity.ElementAlignmentType.align) {
              flexOptions.align = value;
            } else {
              flexOptions.justify = value;
            }
            setState(() {});
            widget.onElementUpdated();
          }
        },
        title: Text(title()),
        subtitle: AppCard(
          borderRadius: BorderRadius.circular(4),
          height: widget.element is section_entity.ColumnElement
              ? 100
              : alignmentType == section_entity.ElementAlignmentType.align
                  ? 80
                  : null,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: exampleParent(
              children: const [
                Icon(
                  Icons.grass,
                  size: 15,
                ),
                Icon(
                  Icons.grass,
                  size: 15,
                ),
                Icon(
                  Icons.grass,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget alignmentGroup({
      required section_entity.ElementAlignmentType alignmentType,
      required section_entity.ResponsivinessFlexOptions flexOptions,
    }) {
      return Column(
        children: [
          Text(
            alignmentType == section_entity.ElementAlignmentType.align
                ? 'Alinhamento:'
                : 'Justificar:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          flexRadio(
            value: section_entity.ElementAlignment.start,
            groupValue:
                alignmentType == section_entity.ElementAlignmentType.align
                    ? flexOptions.align
                    : flexOptions.justify,
            flexOptions: flexOptions,
            alignmentType: alignmentType,
          ),
          flexRadio(
            value: section_entity.ElementAlignment.end,
            groupValue:
                alignmentType == section_entity.ElementAlignmentType.align
                    ? flexOptions.align
                    : flexOptions.justify,
            flexOptions: flexOptions,
            alignmentType: alignmentType,
          ),
          flexRadio(
            value: section_entity.ElementAlignment.center,
            groupValue:
                alignmentType == section_entity.ElementAlignmentType.align
                    ? flexOptions.align
                    : flexOptions.justify,
            flexOptions: flexOptions,
            alignmentType: alignmentType,
          ),
          if (alignmentType == section_entity.ElementAlignmentType.justify)
            flexRadio(
              value: section_entity.ElementAlignment.spaceBetween,
              groupValue:
                  alignmentType == section_entity.ElementAlignmentType.align
                      ? flexOptions.align
                      : flexOptions.justify,
              flexOptions: flexOptions,
              alignmentType: alignmentType,
            ),
          if (alignmentType == section_entity.ElementAlignmentType.justify)
            flexRadio(
              value: section_entity.ElementAlignment.spaceAround,
              groupValue:
                  alignmentType == section_entity.ElementAlignmentType.align
                      ? flexOptions.align
                      : flexOptions.justify,
              flexOptions: flexOptions,
              alignmentType: alignmentType,
            ),
          if (alignmentType == section_entity.ElementAlignmentType.justify)
            flexRadio(
              value: section_entity.ElementAlignment.spaceEvenly,
              groupValue:
                  alignmentType == section_entity.ElementAlignmentType.align
                      ? flexOptions.align
                      : flexOptions.justify,
              flexOptions: flexOptions,
              alignmentType: alignmentType,
            ),
        ],
      );
    }

    Widget settingsWidget(
        section_entity.ResponsivinessFlexOptions flexOptions) {
      return Column(
        children: [
          SwitchListTile(
            thumbIcon: WidgetStatePropertyAll(
              Icon(
                flexOptions.display == section_entity.ElementDisplay.hidden
                    ? Icons.check
                    : Icons.close,
              ),
            ),
            value: flexOptions.display == section_entity.ElementDisplay.hidden,
            onChanged: (value) {
              flexOptions.display = value
                  ? section_entity.ElementDisplay.hidden
                  : section_entity.ElementDisplay.show;
              widget.onElementUpdated();
              setState(() {});
            },
            title: Text(
              widget.element is section_entity.RowElement
                  ? 'Ocultar linha'
                  : 'Ocultar coluna',
            ),
          ),
          const AppDivider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: alignmentGroup(
                    alignmentType: section_entity.ElementAlignmentType.justify,
                    flexOptions: flexOptions,
                  ),
                ),
              ),
              AppDivider(
                vertical: true,
                height: widget.element is section_entity.RowElement ? 500 : 980,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: alignmentGroup(
                    alignmentType: section_entity.ElementAlignmentType.align,
                    flexOptions: flexOptions,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    if (widget.element.responsiviness != null &&
        widget.element.responsiviness is section_entity
            .Responsiviness<section_entity.ResponsivinessFlexOptions>) {
      return ResponsivinessWidget(
        width: 900,
        height: 400,
        onUpdated: widget.onElementUpdated,
        responsiviness: widget.element.responsiviness!,
        xsChild: settingsWidget(widget.element.responsiviness!.xs
            as section_entity.ResponsivinessFlexOptions),
        smChild: settingsWidget(widget.element.responsiviness!.sm
            as section_entity.ResponsivinessFlexOptions),
        mdChild: settingsWidget(widget.element.responsiviness!.md
            as section_entity.ResponsivinessFlexOptions),
        lgChild: settingsWidget(widget.element.responsiviness!.lg
            as section_entity.ResponsivinessFlexOptions),
        xlChild: settingsWidget(widget.element.responsiviness!.xl
            as section_entity.ResponsivinessFlexOptions),
        xxlChild: settingsWidget(widget.element.responsiviness!.xxl
            as section_entity.ResponsivinessFlexOptions),
      );
    }
    return Container();
  }
}
