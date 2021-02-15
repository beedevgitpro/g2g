import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:g2g/controllers/clientController.dart';
import 'package:g2g/utility/pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'tawk_visitor.dart';

/// [Tawk] Widget.
class Tawk extends StatefulWidget {
  /// Tawk direct chat link.
  final String directChatLink;

  /// Object used to set the visitor name and email.
  final TawkVisitor visitor;

  /// Called right after the widget is rendered.
  final Function() onLoad;

  /// Called when a link pressed.
  final Function(String url) onLinkTap;

  /// Render your own loading widget.
  final Widget placeholder;

  Tawk({
    @required this.directChatLink,
    this.visitor,
    this.onLoad,
    this.onLinkTap,
    this.placeholder,
  });

  @override
  _TawkState createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  WebViewController _controller;
  bool _isLoading = true;

  void _setUser(TawkVisitor visitor) {
    print(visitor);
    final json = jsonEncode(visitor);
    print(json);

    final javascriptString = 'Tawk_API.setAttributes($json);';
    print(javascriptString);
    final javascriptString1 =
        'document.getElementById("Name").value ="${visitor.name ?? 'as'}";';

    print(javascriptString);
    _controller.evaluateJavascript(javascriptString);
  }

  setClientID(TawkVisitor visitor) async {
    await ClientController().getClientBasic();
    print(visitor);
    final json = jsonEncode(visitor);
    print(json);

    print('onlink ' + json);

    final javascriptString =
        'document.getElementById("formSubmit").onclick = (){Tawk_API = Tawk_API || {};Tawk_API.onPrechatSubmit = function(data){return $json};};';

    print(javascriptString);
    await _controller.evaluateJavascript(javascriptString);
  }

  @override
  void dispose() {
    _controller.reload();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.directChatLink,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              _controller = webViewController;
            });
          },
          navigationDelegate: (NavigationRequest request)async {
            if (widget.onLinkTap != null){
              widget.onLinkTap(request.url);
              await setClientID(widget.visitor);

            }

            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            if (widget.visitor != null) {
              _setUser(widget.visitor);
            }
            if (widget.onLoad != null) {
              widget.onLoad();
            }
            setState(() {
              _isLoading = false;
            });
          },
        ),
        _isLoading
            ? widget.placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                )
            : Container(),
      ],
    );
  }
}
