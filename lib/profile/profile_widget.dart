import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'profile_model.dart';
export 'profile_model.dart';

/// Create a page that Displays a user's own profile.
///
/// Includes:
/// - Profile picture, name, and short bio
/// - Interest tags and vibe preferences
/// - Toggle visibility and “open to match” status
/// - Edit profile button
/// - Group label (e.g. "The Flirt") shown if grouped
class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static String routeName = 'profile';
  static String routePath = '/profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'profile'});
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
        title: 'profile',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Text(
                'My Profile',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).info,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 20.0,
                      buttonSize: 40.0,
                      fillColor: Color(0x4DFFFFFF),
                      icon: Icon(
                        Icons.settings,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent('PROFILE_PAGE_settings_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed(SettingsWidget.routeName);
                      },
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 280.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary,
                          FlutterFlowTheme.of(context).secondary
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(1.0, 1.0),
                        end: AlignmentDirectional(-1.0, -1.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Container(
                                        width: 120.0,
                                        height: 120.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            currentUserPhoto,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/where-to-b7e849/assets/0uybxhpzvlmv/where_to_variant_4.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    child: Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          width: 3.0,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check_rounded,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Text(
                                valueOrDefault<String>(
                                  currentUserDisplayName,
                                  'NA',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              width: 80.0,
                              height: 28.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault<String>(
                                      valueOrDefault(
                                          currentUserDocument?.friendTypeLabel,
                                          ''),
                                      'No Type',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PROFILE_PAGE_Container_6so5hfql_ON_TAP');
                                    logFirebaseEvent('Container_navigate_to');

                                    context.pushNamed(OwnerWidget.routeName);
                                  },
                                  child: Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Owner Page',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PROFILE_PAGE_Container_nyf0umbs_ON_TAP');
                                    logFirebaseEvent('Container_navigate_to');

                                    context
                                        .pushNamed(AddFriendWidget.routeName);
                                  },
                                  child: Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Add Friend',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'PROFILE_PAGE_Container_39qtfebl_ON_TAP');
                                      logFirebaseEvent('Container_share');
                                      await Share.share(
                                        'https://testflight.apple.com/join/uGZbgfAU',
                                        sharePositionOrigin:
                                            getWidgetBoundingBox(context),
                                      );
                                    },
                                    child: Container(
                                      height: 28.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFE39D2C0),
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          'Share App',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PROFILE_PAGE_Container_vllmmpdb_ON_TAP');
                                    logFirebaseEvent('Container_backend_call');
                                    _model.apiResult24db2 =
                                        await FetchVenuesCall.call(
                                      location: '29.4241,-98.4936',
                                      radius: 50000,
                                    );

                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    _model.current = 0;
                                    safeSetState(() {});
                                    if (FetchVenuesCall.results(
                                              (_model.apiResult24db2
                                                      ?.jsonBody ??
                                                  ''),
                                            ) !=
                                            null &&
                                        (FetchVenuesCall.results(
                                          (_model.apiResult24db2?.jsonBody ??
                                              ''),
                                        ))!
                                            .isNotEmpty) {
                                      while (_model.current! <
                                          FetchVenuesCall.results(
                                            (_model.apiResult24db2?.jsonBody ??
                                                ''),
                                          )!
                                              .length) {
                                        logFirebaseEvent(
                                            'Container_update_page_state');
                                        _model.currentItem =
                                            FetchVenuesCall.results(
                                          (_model.apiResult24db2?.jsonBody ??
                                              ''),
                                        )?.elementAtOrNull(_model.current!);
                                        safeSetState(() {});
                                        logFirebaseEvent(
                                            'Container_backend_call');
                                        _model.apiResultxki22 =
                                            await FetchPlaceDetailsCall.call(
                                          placeId: getJsonField(
                                            _model.currentItem,
                                            r'''$.place_id''',
                                          ).toString(),
                                        );

                                        logFirebaseEvent(
                                            'Container_firestore_query');
                                        _model.docExist2 =
                                            await queryVenuesRecordOnce(
                                          queryBuilder: (venuesRecord) =>
                                              venuesRecord.where(
                                            'place_id',
                                            isEqualTo: getJsonField(
                                              _model.currentItem,
                                              r'''$.place_id''',
                                            ).toString(),
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        if ((_model.docExist2 != null) ==
                                            true) {
                                          logFirebaseEvent(
                                              'Container_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Location Exist',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        } else {
                                          logFirebaseEvent(
                                              'Container_custom_action');
                                          _model.locationLatLng =
                                              await actions.convertToGeoPoint(
                                            getJsonField(
                                              _model.currentItem,
                                              r'''$.geometry.location.lat''',
                                            ).toString(),
                                            getJsonField(
                                              _model.currentItem,
                                              r'''$.geometry.location.lng''',
                                            ).toString(),
                                          );
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          var venuesRecordReference =
                                              VenuesRecord.collection
                                                  .doc(getJsonField(
                                            _model.currentItem,
                                            r'''$.place_id''',
                                          ).toString());
                                          await venuesRecordReference.set({
                                            ...createVenuesRecordData(
                                              name: getJsonField(
                                                _model.currentItem,
                                                r'''$.name''',
                                              ).toString(),
                                              address:
                                                  FetchPlaceDetailsCall.address(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              location: _model.locationLatLng,
                                              photoUrl:
                                                  'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${getJsonField(
                                                _model.currentItem,
                                                r'''$.photos[0].photo_reference''',
                                              ).toString()}&key=AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU',
                                              isClaimed: false,
                                              placeId: getJsonField(
                                                _model.currentItem,
                                                r'''$.place_id''',
                                              ).toString(),
                                              phone:
                                                  FetchPlaceDetailsCall.phone(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              website:
                                                  FetchPlaceDetailsCall.website(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              promoted: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'createdAt': FieldValue
                                                    .serverTimestamp(),
                                                'weekday_text':
                                                    FetchPlaceDetailsCall
                                                        .weekdaytext(
                                                  (_model.apiResultxki22
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                'types': (getJsonField(
                                                  _model.currentItem,
                                                  r'''$.types[0]''',
                                                  true,
                                                ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList(),
                                              },
                                            ),
                                          });
                                          _model.documentID =
                                              VenuesRecord.getDocumentFromData({
                                            ...createVenuesRecordData(
                                              name: getJsonField(
                                                _model.currentItem,
                                                r'''$.name''',
                                              ).toString(),
                                              address:
                                                  FetchPlaceDetailsCall.address(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              location: _model.locationLatLng,
                                              photoUrl:
                                                  'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${getJsonField(
                                                _model.currentItem,
                                                r'''$.photos[0].photo_reference''',
                                              ).toString()}&key=AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU',
                                              isClaimed: false,
                                              placeId: getJsonField(
                                                _model.currentItem,
                                                r'''$.place_id''',
                                              ).toString(),
                                              phone:
                                                  FetchPlaceDetailsCall.phone(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              website:
                                                  FetchPlaceDetailsCall.website(
                                                (_model.apiResultxki22
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              promoted: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'createdAt': DateTime.now(),
                                                'weekday_text':
                                                    FetchPlaceDetailsCall
                                                        .weekdaytext(
                                                  (_model.apiResultxki22
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                'types': (getJsonField(
                                                  _model.currentItem,
                                                  r'''$.types[0]''',
                                                  true,
                                                ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList(),
                                              },
                                            ),
                                          }, venuesRecordReference);
                                          logFirebaseEvent(
                                              'Container_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${_model.current?.toString()} has been added',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                            ),
                                          );
                                        }

                                        logFirebaseEvent(
                                            'Container_update_page_state');
                                        _model.current = _model.current! + 1;
                                        safeSetState(() {});
                                      }
                                      logFirebaseEvent(
                                          'Container_update_app_state');
                                      FFAppState().showFullList = true;
                                      FFAppState().update(() {});
                                    } else {
                                      logFirebaseEvent(
                                          'Container_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Failed to run API',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'add locations',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Me',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault<String>(
                                      valueOrDefault(
                                          currentUserDocument?.bio, ''),
                                      'NA',
                                    ),
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
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Interests',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                  AuthUserStreamWidget(
                                    builder: (context) => Builder(
                                      builder: (context) {
                                        final interests = (currentUserDocument
                                                    ?.interests
                                                    .toList() ??
                                                [])
                                            .toList();

                                        return Wrap(
                                          spacing: 0.0,
                                          runSpacing: 0.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children:
                                              List.generate(interests.length,
                                                  (interestsIndex) {
                                            final interestsItem =
                                                interests[interestsIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 6.0, 12.0, 6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      interestsItem,
                                                      'NA',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vibe Preferences',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final vibesPref = (currentUserDocument
                                                  ?.vibePreferances
                                                  .toList() ??
                                              [])
                                          .toList();

                                      return Wrap(
                                        spacing: 0.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: List.generate(
                                            vibesPref.length, (vibesPrefIndex) {
                                          final vibesPrefItem =
                                              vibesPref[vibesPrefIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 6.0, 12.0, 6.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    vibesPrefItem,
                                                    'NA',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Profile Settings',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: SwitchListTile(
                                          value: _model.switchListTileValue ??=
                                              true,
                                          onChanged: (newValue) async {
                                            safeSetState(() =>
                                                _model.switchListTileValue =
                                                    newValue);
                                            if (newValue) {
                                              logFirebaseEvent(
                                                  'PROFILE_SwitchListTile_f8x9dsmz_ON_TOGGL');
                                              logFirebaseEvent(
                                                  'SwitchListTile_backend_call');

                                              await currentUserReference!
                                                  .update(createUsersRecordData(
                                                openToMatch: true,
                                              ));
                                            } else {
                                              logFirebaseEvent(
                                                  'PROFILE_SwitchListTile_f8x9dsmz_ON_TOGGL');
                                              logFirebaseEvent(
                                                  'SwitchListTile_backend_call');

                                              await currentUserReference!
                                                  .update(createUsersRecordData(
                                                openToMatch: false,
                                              ));
                                            }
                                          },
                                          title: Text(
                                            'Open to Match',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          subtitle: Text(
                                            'Available for new connections',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .success,
                                          dense: true,
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          contentPadding: EdgeInsets.all(0.0),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'PROFILE_PAGE_EDIT_PROFILE_BTN_ON_TAP');
                                  logFirebaseEvent('Button_navigate_to');

                                  context.pushNamed(SettingsWidget.routeName);
                                },
                                text: 'Edit Profile',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 24.0))
                              .addToStart(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
