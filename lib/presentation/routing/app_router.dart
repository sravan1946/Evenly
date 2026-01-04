import 'package:go_router/go_router.dart';
import '../screens/main_navigation.dart';
import '../screens/new_split_flow.dart';
import '../screens/split_detail_screen.dart';
import '../screens/manage_people_screen.dart';
import '../screens/receipt_scan_screen.dart';
import '../screens/new_bill_screen.dart';

/// App router configuration.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigation(),
    ),
    GoRoute(
      path: '/new-split',
      builder: (context, state) => const NewSplitFlow(),
    ),
    GoRoute(
      path: '/split/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return SplitDetailScreen(splitId: id);
      },
    ),
    GoRoute(
      path: '/manage-people',
      builder: (context, state) => const ManagePeopleScreen(),
    ),
    GoRoute(
      path: '/scan-receipt',
      builder: (context, state) => const ReceiptScanScreen(),
    ),
    GoRoute(
      path: '/new-bill',
      builder: (context, state) => const NewBillScreen(),
    ),
  ],
);
