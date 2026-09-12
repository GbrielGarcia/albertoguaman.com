import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Stack interactivo: clic en herramienta → proyectos relacionados.
class InteractiveSkills extends StatefulWidget {
  const InteractiveSkills({super.key});

  @override
  State<InteractiveSkills> createState() => _InteractiveSkillsState();
}

class _InteractiveSkillsState extends State<InteractiveSkills> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final hints = _selected == null
        ? const <String>[]
        : projectHintsForSkill(_selected!);
    final projects = _selected == null
        ? const <ProjectModel>[]
        : projectsForSkill(_selected!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Clic en una herramienta para ver dónde la usé.',
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.9,
            color: UtilsColor.colorMuted,
          ),
        ),
        SizedBox(height: SizeUtils.m),
        for (final group in infoSkillGroups) ...[
          Text(
            group.title.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.85,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorYellowInk,
            ),
          ),
          SizedBox(height: SizeUtils.s / 2),
          Text(
            group.subtitle,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.88,
              color: UtilsColor.colorMuted,
            ),
          ),
          SizedBox(height: SizeUtils.s),
          Wrap(
            spacing: SizeUtils.s,
            runSpacing: SizeUtils.s,
            children: [
              for (final item in group.items)
                _SkillChip(
                  item: item,
                  selected: _selected == item.name,
                  bodySize: bodySize,
                  onTap: () => setState(() {
                    _selected = _selected == item.name ? null : item.name;
                  }),
                ),
            ],
          ),
          SizedBox(height: SizeUtils.l),
        ],
        if (_selected != null) ...[
          Divider(color: UtilsColor.hairline, height: 1),
          SizedBox(height: SizeUtils.m),
          Text(
            'Proyectos con $_selected',
            style: StyleText.textPortfolio(
              fontSize: bodySize * 1.05,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorSecondaryWhite,
            ),
          ),
          SizedBox(height: SizeUtils.s),
          if (hints.isEmpty)
            Text(
              'Sin proyectos públicos enlazados aún para esta herramienta.',
              style: StyleText.textPortfolio(
                fontSize: bodySize * 0.95,
                color: UtilsColor.colorMuted,
              ),
            )
          else ...[
            for (final h in hints)
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '· $h',
                  style: StyleText.textPortfolio(
                    fontSize: bodySize * 0.95,
                    color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.9),
                  ),
                ),
              ),
            if (projects.isNotEmpty) ...[
              SizedBox(height: SizeUtils.s),
              for (final p in projects)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    p.title,
                    style: StyleText.textPortfolio(
                      fontSize: bodySize,
                      fontWeight: FontWeight.w700,
                      color: UtilsColor.colorBlue,
                    ),
                  ),
                  subtitle: Text(
                    p.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleText.textPortfolio(
                      fontSize: bodySize * 0.88,
                      color: UtilsColor.colorMuted,
                    ),
                  ),
                  onTap: () => laucherURL(p.buttonVoidCall),
                ),
            ],
          ],
        ],
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.item,
    required this.selected,
    required this.bodySize,
    required this.onTap,
  });

  final SkillItem item;
  final bool selected;
  final double bodySize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? UtilsColor.colorBlue.withValues(alpha: 0.18)
          : UtilsColor.colorSurface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.m,
            vertical: SizeUtils.s,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? UtilsColor.colorBlue : UtilsColor.hairline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                item.icon,
                size: bodySize,
                color: selected
                    ? UtilsColor.colorBlue
                    : UtilsColor.colorYellowInk,
              ),
              SizedBox(width: SizeUtils.s / 2),
              Text(
                item.name,
                style: StyleText.textPortfolio(
                  fontSize: bodySize * 0.9,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: UtilsColor.colorSecondaryWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
