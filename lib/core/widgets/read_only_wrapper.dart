import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/system_status_provider.dart';
import '../../l10n/app_localizations.dart';

/// Widget che disabilita automaticamente i controlli quando il sistema è in modalità read-only
class ReadOnlyWrapper extends ConsumerWidget {
  final Widget child;
  final Widget? disabledChild;
  final String? tooltipMessage;

  const ReadOnlyWrapper({
    super.key,
    required this.child,
    this.disabledChild,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReadOnly = ref.watch(isReadOnlyProvider);

    if (!isReadOnly) {
      return child;
    }

    // Se abbiamo un child personalizzato per lo stato disabilitato, usalo
    if (disabledChild != null) {
      return disabledChild!;
    }

    // Altrimenti, disabilitiamo il child originale
    return _DisabledWidget(
      tooltipMessage:
          tooltipMessage ?? AppLocalizations.of(context)!.readOnlyTooltip,
      child: child,
    );
  }
}

/// Widget helper per disabilitare controlli UI
class _DisabledWidget extends StatelessWidget {
  final Widget child;
  final String tooltipMessage;

  const _DisabledWidget({
    required this.child,
    required this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: Opacity(
        opacity: 0.5,
        child: AbsorbPointer(
          child: child,
        ),
      ),
    );
  }
}

/// Extension per facilitare l'uso del ReadOnlyWrapper
extension ReadOnlyExtension on Widget {
  Widget whenReadOnly({
    Widget? disabledChild,
    String? tooltipMessage,
  }) {
    return ReadOnlyWrapper(
      disabledChild: disabledChild,
      tooltipMessage: tooltipMessage,
      child: this,
    );
  }
}
