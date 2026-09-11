import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _topic = 'general';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(AppLocalizations al) async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final message = _messageCtrl.text.trim();
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(al.contactFormRequired)),
      );
      return;
    }

    final topicLabel = switch (_topic) {
      'job' => al.contactTopicJob,
      'project' => al.contactTopicProject,
      _ => al.contactTopicGeneral,
    };

    final subject = Uri.encodeComponent('Contacto web · $topicLabel');
    final body = Uri.encodeComponent(
      'Nombre: $name\nEmail: $email\nTema: $topicLabel\n\n$message',
    );
    final uri = Uri.parse(
      'mailto:contacto@albertoguaman.com?subject=$subject&body=$body',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final wa = Uri.parse(
        'https://wa.me/593992889078?text=${Uri.encodeComponent('$topicLabel — $name: $message')}',
      );
      await launchUrl(wa, mode: LaunchMode.externalApplication);
    }
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: StyleText.textPortfolio(color: UtilsColor.colorMuted),
      filled: true,
      fillColor: UtilsColor.colorElevated.withValues(alpha: 0.75),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: UtilsColor.hairline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: UtilsColor.colorBlue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return Container(
      padding: EdgeInsets.all(SizeUtils.l),
      decoration: BoxDecoration(
        color: UtilsColor.colorSurface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UtilsColor.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            al.contactFormTitle,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: SizeUtils.s / 2),
          Text(
            al.contactEmail,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.9,
              color: UtilsColor.colorBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SizeUtils.m),
          TextField(
            controller: _nameCtrl,
            style: StyleText.textPortfolio(fontSize: bodySize),
            decoration: _decoration(al.contactFormName),
          ),
          SizedBox(height: SizeUtils.m),
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            style: StyleText.textPortfolio(fontSize: bodySize),
            decoration: _decoration(al.contactFormEmail),
          ),
          SizedBox(height: SizeUtils.m),
          DropdownButtonFormField<String>(
            initialValue: _topic,
            dropdownColor: UtilsColor.colorElevated,
            style: StyleText.textPortfolio(fontSize: bodySize),
            decoration: _decoration(al.contactFormTopic),
            items: [
              DropdownMenuItem(
                value: 'general',
                child: Text(al.contactTopicGeneral),
              ),
              DropdownMenuItem(
                value: 'job',
                child: Text(al.contactTopicJob),
              ),
              DropdownMenuItem(
                value: 'project',
                child: Text(al.contactTopicProject),
              ),
            ],
            onChanged: (v) => setState(() => _topic = v ?? 'general'),
          ),
          SizedBox(height: SizeUtils.m),
          TextField(
            controller: _messageCtrl,
            maxLines: 5,
            style: StyleText.textPortfolio(fontSize: bodySize),
            decoration: _decoration(al.contactFormMessage),
          ),
          SizedBox(height: SizeUtils.l),
          containerBottom(
            () => _submit(al),
            al.contactFormSubmit,
            al.contactFormSubmit,
            width: double.infinity,
            variant: PortfolioButtonVariant.solid,
            padding: 0,
          ),
        ],
      ),
    );
  }
}
