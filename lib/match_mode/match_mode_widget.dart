import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'match_mode_model.dart';
export 'match_mode_model.dart';

/// A real-time compass-style interface activated when two users agree to
/// break the ice.
///
/// Includes:
/// - Compass pointer showing the direction of the match
/// - Distance countdown between users
/// - Safety confirmation buttons (e.g. “Still Good?” every 30 sec)
/// - Option to cancel or switch to chat once close
class MatchModeWidget extends StatefulWidget {
  const MatchModeWidget({super.key});

  static String routeName = 'MatchMode';
  static String routePath = '/matchMode';

  @override
  State<MatchModeWidget> createState() => _MatchModeWidgetState();
}

class _MatchModeWidgetState extends State<MatchModeWidget> {
  late MatchModeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MatchModeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'MatchMode'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MATCH_MODE_PAGE_MatchMode_ON_INIT_STATE');
      logFirebaseEvent('MatchMode_firestore_query');
      _model.yourmatches = await queryMatchesRecordOnce(
        queryBuilder: (matchesRecord) => matchesRecord.where(Filter.or(
          Filter(
            'userAId',
            isEqualTo: currentUserReference,
          ),
          Filter(
            'userBId',
            isEqualTo: currentUserReference,
          ),
        )),
      );
      logFirebaseEvent('MatchMode_update_page_state');
      _model.currentMatch = _model.yourmatches
          ?.where((e) => (e.userAStatus == true) && (e.userBStatus == true))
          .toList()
          .sortedList(keyOf: (e) => e.timestamp!, desc: false)
          .firstOrNull;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'MatchMode',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 2.0,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/where_2_logo_transparentCentered.png',
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'No Matches Found',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    if (_model.currentMatch != null)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'MATCH_MODE_MATCH_FOUND_CLICK_HERE_BTN_ON');
                                          if (_model.currentMatch != null) {
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context.goNamed(
                                              MatchModeCompassWidget.routeName,
                                              queryParameters: {
                                                'matchSession': serializeParam(
                                                  _model.currentMatch,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'matchSession':
                                                    _model.currentMatch,
                                              },
                                            );
                                          } else {
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Match Error!'),
                                                  content: Text(
                                                      'An error has occured while trying to match please try again!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Continue'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context.goNamed(
                                                MatchModeWidget.routeName);
                                          }
                                        },
                                        text: 'Match Found! Click Here!',
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 25.0))
                                  .addToStart(SizedBox(height: 100.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
