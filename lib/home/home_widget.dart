import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/filter_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

/// This is the user’s personalized discovery hub, designed to highlight
/// trending places nearby based on real-world activity and RSVPs.
///
/// Key Features:
/// - A scrollable list of the top venues within a user-defined radius, sorted
/// by RSVP count (most to least)
/// - Each venue card shows:
///   - Venue name and photo
///   - Distance from user
///   - Number of people who RSVP’d
///   - Vibe type (e.g. Chill, Party, Artsy)
///   - Quick link to event or venue detail page
///
/// Additional Elements:
/// - A floating "Change Radius" button or slider that allows the user to
/// adjust how far the app should search (e.g., 1–50 miles/km)
/// - Filter options for:
///   - Vibe Type (Chill, Party, Deep Talk, etc.)
///   - Venue Type (Bar, Lounge, Gallery, etc.)
///   - Event Status (Now, Today, This Weekend)
///
/// Map Integration:
/// - Optional button to switch between List View and Map View
/// - Tapping a venue on the map opens the Venue Detail page
///
/// Suggested Extras:
/// - “Friends are here” label if someone from the user's group or friends is
/// currently at that venue
/// - "Boosted" tag if the venue is promoted
///
/// Use Case:
/// The goal is to help users decide *where to go next* based on real, local
/// activity — not just paid ads — making the experience feel spontaneous and
/// authentic.
class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Home'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_PAGE_Home_ON_INIT_STATE');
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      logFirebaseEvent('Home_update_app_state');
      FFAppState().showFullList = false;
      FFAppState().friend = (currentUserDocument?.friendsList.toList() ?? [])
          .toList()
          .cast<DocumentReference>();
      FFAppState().update(() {});
      logFirebaseEvent('Home_custom_action');
      await actions.startAndTrackVenuePresence(
        currentUserReference!,
      );
      logFirebaseEvent('Home_custom_action');
      await actions.startAndTrackVenuePresence(
        currentUserReference!,
      );
      if (((FFAppState().locations.isNotEmpty) == false) ||
          (valueOrDefault(currentUserDocument?.radiusSaved, 0.0) !=
              FFAppState().filterRadius)) {
        logFirebaseEvent('Home_update_app_state');
        FFAppState().filterRadius =
            valueOrDefault(currentUserDocument?.radiusSaved, 0.0);
        safeSetState(() {});
        logFirebaseEvent('Home_update_app_state');
        FFAppState().interestedInGoing =
            (currentUserDocument?.interestedInGoing.toList() ?? [])
                .toList()
                .cast<DocumentReference>();
        safeSetState(() {});
        logFirebaseEvent('Home_update_app_state');
        FFAppState().showFullList = false;
        safeSetState(() {});
        logFirebaseEvent('Home_firestore_query');
        _model.venueQuery = await queryVenuesRecordOnce();
        logFirebaseEvent('Home_update_app_state');
        FFAppState().locations = functions
            .sortVenuesByDistanceToUser(
                _model.venueQuery!.toList(),
                currentUserLocationValue!,
                valueOrDefault(currentUserDocument?.radiusSaved, 0.0))
            .map((e) => e.reference)
            .toList()
            .toList()
            .cast<DocumentReference>();
        safeSetState(() {});
        if (valueOrDefault(currentUserDocument?.radiusSaved, 0.0) < 5.0) {
          logFirebaseEvent('Home_backend_call');

          await currentUserReference!.update(createUsersRecordData(
            radiusSaved: 5.0,
          ));
        }
      } else {
        logFirebaseEvent('Home_update_app_state');
        FFAppState().showFullList = false;
        safeSetState(() {});
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return Title(
        title: 'Home',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).alternate,
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.sizeOf(context).height * 0.13),
              child: AppBar(
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                automaticallyImplyLeading: false,
                actions: [],
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 28.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/where_2_logo_transparentCentered.png',
                                fit: BoxFit.contain,
                                alignment: Alignment(-1.0, 0.0),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              'Venues Nearby',
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
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
                elevation: 0.0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 28.0,
                                          ),
                                          RichText(
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: valueOrDefault<String>(
                                                    formatNumber(
                                                      valueOrDefault(
                                                          currentUserDocument
                                                              ?.radiusSaved,
                                                          0.0),
                                                      formatType:
                                                          FormatType.custom,
                                                      format: '##',
                                                      locale: '',
                                                    ),
                                                    '5',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: ' miles',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                )
                                              ],
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),
                                    ),
                                  ],
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  buttonSize: 40.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  icon: Icon(
                                    Icons.refresh_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'HOME_PAGE_refresh_sharp_ICN_ON_TAP');
                                    logFirebaseEvent(
                                        'IconButton_update_app_state');
                                    FFAppState().showFullList = false;
                                    FFAppState().update(() {});
                                  },
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  buttonSize: 40.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  icon: Icon(
                                    Icons.search,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      icon: Icon(
                                        Icons.tune,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'HOME_PAGE_tune_ICN_ON_TAP');
                                        logFirebaseEvent(
                                            'IconButton_bottom_sheet');
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: FilterWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                    ),
                                    if (currentUserUid ==
                                        'SRWmrlj7rSVQ11mWtxY0dCrSzlJ2')
                                      FlutterFlowIconButton(
                                        borderRadius: 20.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        icon: Icon(
                                          Icons.map,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'HOME_PAGE_map_ICN_ON_TAP');
                                          logFirebaseEvent(
                                              'IconButton_backend_call');
                                          _model.apiResult24d =
                                              await FetchVenuesCall.call(
                                            location: '29.4241,-98.4936',
                                            radius: 50000,
                                          );

                                          if (FetchVenuesCall.results(
                                                    (_model.apiResult24d
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) !=
                                                  null &&
                                              (FetchVenuesCall.results(
                                                (_model.apiResult24d
                                                        ?.jsonBody ??
                                                    ''),
                                              ))!
                                                  .isNotEmpty) {
                                            for (int loop1Index = 0;
                                                loop1Index <=
                                                    valueOrDefault<int>(
                                                      FetchVenuesCall.results(
                                                        (_model.apiResult24d
                                                                ?.jsonBody ??
                                                            ''),
                                                      )?.length,
                                                      0,
                                                    );
                                                loop1Index++) {
                                              final currentLoop1Item =
                                                  FetchVenuesCall.results(
                                                (_model.apiResult24d
                                                        ?.jsonBody ??
                                                    ''),
                                              )!
                                                      .map((e) => e)
                                                      .toList()[loop1Index];
                                              logFirebaseEvent(
                                                  'IconButton_backend_call');
                                              _model.apiResultxki =
                                                  await FetchPlaceDetailsCall
                                                      .call(
                                                placeId: getJsonField(
                                                  currentLoop1Item,
                                                  r'''$.place_id''',
                                                ).toString(),
                                              );

                                              logFirebaseEvent(
                                                  'IconButton_firestore_query');
                                              _model.docExist =
                                                  await queryVenuesRecordOnce(
                                                queryBuilder: (venuesRecord) =>
                                                    venuesRecord.where(
                                                  'place_id',
                                                  isEqualTo: getJsonField(
                                                    currentLoop1Item,
                                                    r'''$.place_id''',
                                                  ).toString(),
                                                ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              if (_model.docExist != null) {
                                                logFirebaseEvent(
                                                    'IconButton_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Location Exist',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'IconButton_custom_action');
                                                _model.locationLatLng =
                                                    await actions
                                                        .convertToGeoPoint(
                                                  getJsonField(
                                                    currentLoop1Item,
                                                    r'''$.geometry.location.lat''',
                                                  ).toString(),
                                                  getJsonField(
                                                    currentLoop1Item,
                                                    r'''$.geometry.location.lng''',
                                                  ).toString(),
                                                );
                                                logFirebaseEvent(
                                                    'IconButton_backend_call');

                                                var venuesRecordReference =
                                                    VenuesRecord.collection
                                                        .doc(getJsonField(
                                                  currentLoop1Item,
                                                  r'''$.place_id''',
                                                ).toString());
                                                await venuesRecordReference
                                                    .set({
                                                  ...createVenuesRecordData(
                                                    name: getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    address:
                                                        FetchPlaceDetailsCall
                                                            .address(
                                                      (_model.apiResultxki
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    location:
                                                        _model.locationLatLng,
                                                    photoUrl:
                                                        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.photos[0].photo_reference''',
                                                    ).toString()}&key=AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU',
                                                    isClaimed: false,
                                                    placeId: getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.place_id''',
                                                    ).toString(),
                                                    phone: FetchPlaceDetailsCall
                                                        .phone(
                                                      (_model.apiResultxki
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    website:
                                                        FetchPlaceDetailsCall
                                                            .website(
                                                      (_model.apiResultxki
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
                                                        (_model.apiResultxki
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                      'types': (getJsonField(
                                                        currentLoop1Item,
                                                        r'''$.types[0]''',
                                                        true,
                                                      ) as List)
                                                          .map<String>((s) =>
                                                              s.toString())
                                                          .toList(),
                                                    },
                                                  ),
                                                });
                                                _model.documentID = VenuesRecord
                                                    .getDocumentFromData({
                                                  ...createVenuesRecordData(
                                                    name: getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    address:
                                                        FetchPlaceDetailsCall
                                                            .address(
                                                      (_model.apiResultxki
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    location:
                                                        _model.locationLatLng,
                                                    photoUrl:
                                                        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.photos[0].photo_reference''',
                                                    ).toString()}&key=AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU',
                                                    isClaimed: false,
                                                    placeId: getJsonField(
                                                      currentLoop1Item,
                                                      r'''$.place_id''',
                                                    ).toString(),
                                                    phone: FetchPlaceDetailsCall
                                                        .phone(
                                                      (_model.apiResultxki
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    website:
                                                        FetchPlaceDetailsCall
                                                            .website(
                                                      (_model.apiResultxki
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    promoted: false,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'createdAt':
                                                          DateTime.now(),
                                                      'weekday_text':
                                                          FetchPlaceDetailsCall
                                                              .weekdaytext(
                                                        (_model.apiResultxki
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                      'types': (getJsonField(
                                                        currentLoop1Item,
                                                        r'''$.types[0]''',
                                                        true,
                                                      ) as List)
                                                          .map<String>((s) =>
                                                              s.toString())
                                                          .toList(),
                                                    },
                                                  ),
                                                }, venuesRecordReference);
                                                logFirebaseEvent(
                                                    'IconButton_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${loop1Index.toString()} has been added',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                  ),
                                                );
                                              }
                                            }
                                            logFirebaseEvent(
                                                'IconButton_update_app_state');
                                            FFAppState().showFullList = true;
                                            FFAppState().update(() {});
                                          } else {
                                            logFirebaseEvent(
                                                'IconButton_show_snack_bar');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to run API',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                      ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (!FFAppState().showFullList)
                                Builder(
                                  builder: (context) {
                                    final venuesList =
                                        FFAppState().locations.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: venuesList.length,
                                      itemBuilder: (context, venuesListIndex) {
                                        final venuesListItem =
                                            venuesList[venuesListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 16.0),
                                          child: StreamBuilder<VenuesRecord>(
                                            stream: VenuesRecord.getDocument(
                                                venuesListItem),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              final containerVenuesRecord =
                                                  snapshot.data!;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'HOME_PAGE_Container_klpb8078_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Container_navigate_to');

                                                  context.pushNamed(
                                                    VenueWidget.routeName,
                                                    queryParameters: {
                                                      'venueRef':
                                                          serializeParam(
                                                        containerVenuesRecord,
                                                        ParamType.Document,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      'venueRef':
                                                          containerVenuesRecord,
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 260.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset: Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            child: Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerVenuesRecord
                                                                          .photoUrl,
                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/where-to-b7e849/assets/hn810omect9i/transparent_where_to_variant_4.png',
                                                                    ),
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                      child:
                                                                          BackdropFilter(
                                                                        filter:
                                                                            ImageFilter.blur(
                                                                          sigmaX:
                                                                              5.0,
                                                                          sigmaY:
                                                                              2.0,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            if (containerVenuesRecord.isClaimed ==
                                                                                true)
                                                                              Container(
                                                                                height: 32.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).accent4,
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                ),
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                      child: Text(
                                                                                        'Owner Verified',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.verified,
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (containerVenuesRecord
                                                                        .promoted ==
                                                                    true)
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -0.92,
                                                                            -0.78),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            4.0,
                                                                            8.0,
                                                                            4.0),
                                                                        child:
                                                                            Text(
                                                                          'BOOSTED',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.97,
                                                                          0.84),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        30.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              child: StreamBuilder<VenuesRecord>(
                                                                                stream: VenuesRecord.getDocument(containerVenuesRecord.reference),
                                                                                builder: (context, snapshot) {
                                                                                  // Customize what your widget looks like when it's loading.
                                                                                  if (!snapshot.hasData) {
                                                                                    return Center(
                                                                                      child: SizedBox(
                                                                                        width: 50.0,
                                                                                        height: 50.0,
                                                                                        child: CircularProgressIndicator(
                                                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                                                            FlutterFlowTheme.of(context).primary,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }

                                                                                  final listViewVenuesRecord = snapshot.data!;

                                                                                  return Builder(
                                                                                    builder: (context) {
                                                                                      final types = containerVenuesRecord.types.map((e) => e).toList();

                                                                                      return ListView.separated(
                                                                                        padding: EdgeInsets.zero,
                                                                                        primary: false,
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        itemCount: types.length,
                                                                                        separatorBuilder: (_, __) => SizedBox(width: 10.0),
                                                                                        itemBuilder: (context, typesIndex) {
                                                                                          final typesItem = types[typesIndex];
                                                                                          return Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: Color(0xF41A9586),
                                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                                            ),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                child: Text(
                                                                                                  valueOrDefault<String>(
                                                                                                    typesItem,
                                                                                                    'NA',
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.inter(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    containerVenuesRecord
                                                                        .name,
                                                                    'NA',
                                                                  ).maybeHandleOverflow(
                                                                    maxChars:
                                                                        45,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .interTight(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            8.0),
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          functions.distanceBetweenPoints(
                                                                              containerVenuesRecord.location,
                                                                              currentUserLocationValue),
                                                                          '0',
                                                                        ),
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            '/Miles away',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        StreamBuilder<
                                                            List<
                                                                InterestedDailyRecord>>(
                                                          stream:
                                                              queryInterestedDailyRecord(
                                                            parent:
                                                                venuesListItem,
                                                            queryBuilder:
                                                                (interestedDailyRecord) =>
                                                                    interestedDailyRecord
                                                                        .orderBy(
                                                                            'dateTime'),
                                                            singleRecord: true,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<InterestedDailyRecord>
                                                                columnInterestedDailyRecordList =
                                                                snapshot.data!;
                                                            final columnInterestedDailyRecord =
                                                                columnInterestedDailyRecordList
                                                                        .isNotEmpty
                                                                    ? columnInterestedDailyRecordList
                                                                        .first
                                                                    : null;

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xE6FFFFFF),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              8.0,
                                                                              4.0,
                                                                              8.0,
                                                                              4.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                Icons.people,
                                                                                color: Color(0xFD4B39EF),
                                                                                size: 16.0,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                                child: AnimatedDefaultTextStyle(
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF4B39EF),
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                  duration: Duration(milliseconds: 600),
                                                                                  curve: Curves.easeIn,
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      columnInterestedDailyRecord?.totalInterestToday.toString(),
                                                                                      '0',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            Text(
                                                                          'people interested',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xE6FFFFFF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            4.0,
                                                                            8.0,
                                                                            4.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.fire,
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              size: 16.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                                              child: AnimatedDefaultTextStyle(
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFF4B39EF),
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                    ),
                                                                                duration: Duration(milliseconds: 600),
                                                                                curve: Curves.easeIn,
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    columnInterestedDailyRecord?.totalGroupInterestToday.toString(),
                                                                                    '0',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 4.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          6.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'friends are interested',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 100.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
