import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/widgets/profil/sheet_pemilih_avatar.dart';

class HeroProfil extends StatelessWidget {
  final List<String> avatars;

  const HeroProfil({
    super.key,
    required this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topPadding + 20,
        bottom: 20,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.t.profile.title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    builder: (_) => SheetPemilihAvatar(
                      avatarSaatIni: profileProvider.avatar,
                      daftarAvatar: avatars,
                      onPilih: (av) {
                        profileProvider.updateAvatar(av);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(profileProvider.avatar, style: const TextStyle(fontSize: 40)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2E9E5B),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xFF2E9E5B),
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileProvider.userName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (profileProvider.userEmail.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        profileProvider.userEmail,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      "Bergabung sejak ${profileProvider.joinDate}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
