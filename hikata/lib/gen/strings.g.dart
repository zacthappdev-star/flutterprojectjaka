/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 557 (278 per locale)
///
/// Built on 2026-06-18 at 07:24 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.id;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.id) // set locale
/// - Locale locale = AppLocale.id.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.id) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	id(languageCode: 'id', build: Translations.build),
	en(languageCode: 'en', build: _StringsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsCommonId common = _StringsCommonId._(_root);
	late final _StringsAuthId auth = _StringsAuthId._(_root);
	late final _StringsHomeId home = _StringsHomeId._(_root);
	late final _StringsScriptGuideId scriptGuide = _StringsScriptGuideId._(_root);
	late final _StringsHiraganaId hiragana = _StringsHiraganaId._(_root);
	late final _StringsKatakanaId katakana = _StringsKatakanaId._(_root);
	late final _StringsFlashcardId flashcard = _StringsFlashcardId._(_root);
	late final _StringsQuizId quiz = _StringsQuizId._(_root);
	late final _StringsProgressId progress = _StringsProgressId._(_root);
	late final _StringsProfileId profile = _StringsProfileId._(_root);
	late final _StringsSettingsId settings = _StringsSettingsId._(_root);
	late final _StringsNotificationId notification = _StringsNotificationId._(_root);
	late final _StringsErrorsId errors = _StringsErrorsId._(_root);
	late final _StringsLanguageId language = _StringsLanguageId._(_root);
	late final _StringsAboutId about = _StringsAboutId._(_root);
	late final _StringsGoalsId goals = _StringsGoalsId._(_root);
	late final _StringsFeedbackId feedback = _StringsFeedbackId._(_root);
}

// Path: common
class _StringsCommonId {
	_StringsCommonId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome => 'Selamat Datang di HI KATA! 🥳';
	String unlockedLevelsRatio({required Object unlocked, required Object total}) => 'Level ${unlocked} dari ${total} Terbuka';
	String get appName => 'HI KATA';
	String get continueText => 'LANJUTKAN';
	String get cancel => 'Batal';
	String get back => 'Kembali';
	String get loading => 'Memuat...';
	String get save => 'Simpan';
	String get or => 'atau';
	String get check => 'Periksa';
	String get next => 'Lanjut';
	String get finish => 'Selesai';
	String get startLevelQuiz => 'Mulai Quiz Level!';
	String get grid => 'Tabel';
	String get flashcard => 'Kartu';
	String get quiz => 'Kuis';
	String get tip => 'Pengingat:';
	String get reading => 'Cara baca';
	String get memoryTip => 'Tips Hafalan';
	String get japaneseScriptGuide => ' Huruf Jepang';
	String get scriptGuideDesc => 'Hiragana, Katakana, Dakuten, Youon & lainnya';
	String get navHome => 'Beranda';
	String get navLearn => 'Belajar';
	String get navQuiz => 'Kuis';
	String get navProgress => 'Progres';
	String get navProfile => 'Profil';
	String get introTablesTitle => 'Tabel Pengenalan Huruf';
	String get introTablesDesc => 'Ketuk huruf untuk mendengarkan pelafalan suaranya 🔊';
	String get startStudyModules => 'MULAI MODUL BELAJAR';
}

// Path: auth
class _StringsAuthId {
	_StringsAuthId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Masuk';
	String get register => 'Daftar';
	String get emailHint => 'Alamat Email';
	String get passwordHint => 'Kata Sandi';
	String get confirmPasswordHint => 'Konfirmasi Kata Sandi';
	String get usernameHint => 'Nama Pengguna';
	String get forgotPassword => 'Lupa password?';
	String get dontHaveAccount => 'Belum punya akun? ';
	String get alreadyHaveAccount => 'Sudah punya akun? ';
	String get resetPasswordTitle => 'Atur Ulang Sandi';
	String get resetPasswordIntro => 'Masukkan email Anda untuk menerima instruksi pengaturan ulang kata sandi.';
	String get sendEmail => 'KIRIM EMAIL';
	late final _StringsAuthValidationId validation = _StringsAuthValidationId._(_root);
	late final _StringsAuthMessagesId messages = _StringsAuthMessagesId._(_root);
}

// Path: home
class _StringsHomeId {
	_StringsHomeId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Home';
	String get subtitle => 'Mari belajar Hiragana & Katakana';
	String get learnCardTitle => 'Belajar Huruf';
	String get learnCardSubtitle => 'Hiragana & Katakana';
	String get flashcardTitle => 'Flashcard';
	String get flashcardSubtitle => 'Latihan Hafalan';
	String get quizTitle => 'Kuis';
	String get quizSubtitle => 'Uji Kemampuan';
	String get stats => 'Statistik';
	String get dailyGoal => 'Target Harian';
	String get morning => 'Ohayou / Selamat Pagi';
	String get afternoon => 'Konnichiwa / Selamat Siang';
	String get night => 'Konbanwa / Selamat Malam';
	String get dailyMission => 'Misi Hari Ini';
	String get finishOneLesson => 'Selesaikan 1 Pelajaran';
	String days({required Object count}) => '${count} Hari';
	String xp({required Object count}) => '${count} XP';
	String get rankBeginner => 'Pemula';
	String get rankIntermediate => 'Menengah';
	String get rankAdvanced => 'Mahir';
	String get kanji => 'Kanji';
	String get conversation => 'Percakapan';
	String get startPractice => 'Mulai Latihan';
	String progressSummary({required Object completed, required Object percent, required Object total}) => '${completed} karakter · ${percent}% selesai (${completed}/${total})';
}

// Path: scriptGuide
class _StringsScriptGuideId {
	_StringsScriptGuideId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String completed({required Object completed, required Object total}) => '${completed} dari ${total} selesai';
	String get keepItUp => 'Pertahankan Semangat!';
	String get xpPerLevel => '+5 XP tiap level selesai.';
	String get awesome => 'Luar biasa!';
	String get keepLearning => 'Lanjutkan belajarmu hari ini.';
}

// Path: hiragana
class _StringsHiraganaId {
	_StringsHiraganaId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pengenalan Hiragana';
	String get subtitle => 'Belajar huruf dasar Hiragana';
	String get level => 'Level {num}';
	String get locked => 'Level Terkunci';
	String get lockedDesc => 'Selesaikan kuis level sebelumnya dengan akurasi minimal 80% untuk membuka level ini.';
}

// Path: katakana
class _StringsKatakanaId {
	_StringsKatakanaId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pengenalan Katakana';
	String get subtitle => 'Belajar huruf dasar Katakana';
	String get level => 'Level {num}';
	String get locked => 'Level Terkunci';
	String get lockedDesc => 'Selesaikan kuis level sebelumnya dengan akurasi minimal 80% untuk membuka level ini.';
}

// Path: flashcard
class _StringsFlashcardId {
	_StringsFlashcardId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Flashcard Interaktif';
	String get flip => 'Ketuk untuk Membalik';
	String get gotIt => 'Sudah Hafal';
	String get review => 'Perlu Ulang';
	String get congrats => 'Selamat!';
	String get finished => 'Semua kartu telah dipelajari';
}

// Path: quiz
class _StringsQuizId {
	_StringsQuizId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Kuis Pilihan Ganda';
	String question({required Object current, required Object total}) => '${current} dari ${total} soal';
	String get score => 'Skor Anda';
	String get correct => 'Benar';
	String get incorrect => 'Salah';
	String get retry => 'Coba Lagi';
	String get finishQuiz => 'Selesaikan Kuis';
	String get listenPrompt => 'Dengarkan pelafalan huruf berikut:';
	String get listenAudio => 'Dengarkan Audio';
	String feedbackCorrect({required Object answer}) => 'Benar! Jawaban: ${answer}';
	String feedbackWrong({required Object answer}) => 'Salah! Jawaban yang benar: ${answer}';
	String get seeResult => 'LIHAT HASIL';
	String get nextQuestion => 'SOAL BERIKUTNYA';
	String get quitQuiz => 'Keluar Kuis?';
	String get quitWarning => 'Progresmu akan hilang jika keluar sekarang.';
	String get continueQuiz => 'Lanjut';
	String get quit => 'Keluar';
	String get levelUnlockedTitle => '🎉 Selamat!';
	String get levelUnlockedDesc => 'Level berikutnya berhasil dibuka.';
	String get levelUnlockedSub => 'Teruskan belajar untuk membuka level lainnya dan meningkatkan kemampuan membaca huruf Jepang.';
	String get continueLearning => 'Lanjut Belajar';
	String get feedbackOutstanding => '🌟 Luar Biasa!';
	String get feedbackGreat => '🎉 Hebat!';
	String get feedbackGood => '👍 Lumayan!';
	String get feedbackPoor => '📖 Ayo Belajar Lagi!';
	String get descOutstanding => 'Kamu menguasai materi ini dengan sempurna! Pertahankan prestasimu.';
	String get descGreat => 'Pemahamanmu sudah sangat baik. Sedikit latihan lagi untuk nilai sempurna!';
	String get descGood => 'Kamu sudah mulai paham. Mari belajar lagi agar lebih lancar.';
	String get descPoor => 'Jangan menyerah! Coba ulangi pengenalan huruf dan kuis untuk hasil lebih baik.';
	String get accuracy => 'Akurasi';
	String get totalQuestions => 'Total Soal';
	String get startListeningQuiz => 'MULAI KUIS PENDENGARAN';
	String get backToHome => 'KEMBALI KE BERANDA';
	String get evaluationQuiz => 'Quiz Evaluasi';
	String get quizHiragana => 'Quiz Hiragana';
	String get quizKatakana => 'Quiz Katakana';
	String get quizMixed => 'Quiz Campuran';
	String get descQuizHiragana => 'Quiz campuran dari 46 karakter dasar Hiragana';
	String get descQuizKatakana => 'Quiz campuran dari 46 karakter dasar Katakana';
	String get descQuizMixed => 'Tantangan quiz kombinasi Hiragana & Katakana';
	String get listeningQuizzes => 'Quiz Pendengaran';
	String get listeningQuizHiragana => 'Quiz Pendengaran Hiragana';
	String get listeningQuizKatakana => 'Quiz Pendengaran Katakana';
	String get listeningQuizMixed => 'Quiz Pendengaran Campuran';
	String get descListeningHiragana => 'Quiz pendengaran dari 46 karakter dasar Hiragana';
	String get descListeningKatakana => 'Quiz pendengaran dari 46 karakter dasar Katakana';
	String get descListeningMixed => 'Tantangan pendengaran kombinasi Hiragana & Katakana';
	String get unlockPreviousQuiz => 'Selesaikan kuis sebelumnya';
	String countQuestions({required Object count}) => '${count} soal';
	String estTime({required Object time}) => '±${time} menit';
	String get difficultyMedium => 'Sedang';
	String get difficultyHard => 'Sulit';
	String get lockedStatus => 'Terkunci';
	String get audioType => 'Audio';
}

// Path: progress
class _StringsProgressId {
	_StringsProgressId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Statistik Progres belajar';
	String get streak => '{days} Hari Beruntun';
	String get completed => 'Selesai';
	String get charactersLearned => 'Karakter Terpelajar';
	String get learningProgress => 'Progres Belajar';
	String get studyReminders => 'Pengingat Belajar';
	String get totalUnlockedLevels => 'Total Level Terbuka';
	String get totalQuizzesCompleted => 'Total Quiz Selesai';
	String reminderActive({required Object time}) => 'Pengingat belajar aktif harian pada ${time} 🔔';
	String get reminderDisabled => 'Pengingat belajar dinonaktifkan 🔕';
	String reminderUpdated({required Object time}) => 'Jam pengingat diubah ke ${time} ⏰';
	String reminderLeft({required Object hours, required Object minutes}) => '⏰ ${hours} jam ${minutes} menit lagi';
	String get studyStreak => 'Streak Belajar';
	String daysInARow({required Object days}) => '${days} Hari Berturut-turut!';
	String get enableAlarm => 'Aktifkan Pengingat';
	String get studyTime => 'Waktu Belajar';
	String get nextReminder => 'Pengingat Berikutnya';
	String get keepItUpMsg => 'Pertahankan terus semangat belajarmu!';
	String charactersCount({required Object completed, required Object total}) => '${completed}/${total} karakter';
}

// Path: profile
class _StringsProfileId {
	_StringsProfileId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Profil Saya';
	String get studyStatistics => 'Statistik Belajar';
	String get appearance => 'Pengaturan Tampilan';
	String get more => 'Lainnya';
	String get feedback => 'Beri Masukan';
	String get aboutApp => 'Tentang Aplikasi';
	String get deleteAccount => 'Hapus Akun';
	String get deleteAccountTitle => 'Hapus Akun Permanen?';
	String get deleteAccountConfirmText => 'Tindakan ini tidak dapat dibatalkan. Seluruh data progres belajar, riwayat kuis, streak, dan karakter terpelajar akan dihapus secara permanen dari sistem.';
	String get cancel => 'Batal';
	String get logout => 'Keluar';
	String get logoutTitle => 'Keluar dari Akun?';
	String get logoutConfirmText => 'Kamu harus masuk lagi untuk menyimpan progres belajar.';
	String get badgesEarned => 'Badge Diraih';
	String get deleteDataWarning => 'Semua data akan hilang permanen';
	String get hiraganaQuiz => 'Kuis Hiragana';
	String get katakanaQuiz => 'Kuis Katakana';
	String get defaultUserName => 'Pelajar HI KATA';
	late final _StringsProfileStatisticsId statistics = _StringsProfileStatisticsId._(_root);
	String get chooseAvatar => 'Pilih Avatar Baru';
	String get achievements => 'Pencapaian Kuis';
	String get mixedQuiz => 'Kuis Campuran';
	String joinedSince({required Object date}) => 'Bergabung sejak ${date}';
}

// Path: settings
class _StringsSettingsId {
	_StringsSettingsId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get mixedQuiz => 'Kuis Campuran';
	String get appearance => 'Tampilan Aplikasi';
	String get lightMode => 'Mode Terang';
	String get darkMode => 'Mode Gelap';
	String get title => 'Pengaturan';
	String get theme => 'Tema Aplikasi';
	String get darkTheme => 'Mode Gelap';
	String get lightTheme => 'Mode Terang';
	String get systemTheme => 'Sistem';
	String get language => 'Bahasa';
	String get dailyNotification => 'Notifikasi Harian';
	String get notificationTime => 'Waktu Notifikasi';
}

// Path: notification
class _StringsNotificationId {
	_StringsNotificationId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Waktunya Belajar!';
	String get body => 'Ayo luangkan 5 menit hari ini untuk melatih Hiragana dan Katakana kamu.';
}

// Path: errors
class _StringsErrorsId {
	_StringsErrorsId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get general => 'Terjadi kesalahan. Silakan coba lagi.';
	String get network => 'Koneksi internet bermasalah.';
}

// Path: language
class _StringsLanguageId {
	_StringsLanguageId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pilih Bahasa';
	String get subtitle => 'Choose Language';
	String get changeAnytime => 'Kamu bisa mengubah bahasa kapan saja';
	String get changeAnytimeEn => 'You can change language anytime';
	String get indonesian => 'Bahasa Indonesia';
	String get english => 'English';
	String get indonesianDesc => 'Panduan dalam Bahasa Indonesia';
	String get englishDesc => 'Guide in English Language';
}

// Path: about
class _StringsAboutId {
	_StringsAboutId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tentang Aplikasi';
	String get description => 'HI KATA membantu anda mempelajari Hiragana dan Katakana melalui pembelajaran interaktif, audio pelafalan, dan kuis yang menyenangkan.';
	String get version => 'App Version';
	String get developer => 'Pembuat Aplikasi';
}

// Path: goals
class _StringsGoalsId {
	_StringsGoalsId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tujuan Belajarmu';
	String get subtitle => 'Mari tentukan target harian belajarmu!';
	String get greatChoice => 'Pilihan mantap! Kamu belajar untuk: ';
	String get dailyTargetQuestion => 'Berapa target belajar harianmu?';
	String get startLearning => 'MULAI BELAJAR';
	String targetSet({required Object name, required Object time}) => 'Target harian diatur ke: ${name} (${time})🔥';
	String get goalRelaxed => 'Santai';
	String get goalRegular => 'Biasa';
	String get goalSerious => 'Serius';
	String get goalIntense => 'Intens';
	String get time5m => '5 menit / hari';
	String get time10m => '10 menit / hari';
	String get time15m => '15 menit / hari';
	String get time20m => '20 menit / hari';
	String get descRelaxed => 'Bagus untuk perkenalan awal';
	String get descRegular => 'Rekomendasi untuk pemula';
	String get descSerious => 'Progress belajar cepat';
	String get descIntense => 'Tantangan belajar maksimal';
	String get reasonSchool => 'Pendidikan & Sekolah 🏫';
	String get reasonAnime => 'Anime & Pop Culture 🍿';
	String get reasonWork => 'Karir & Pekerjaan 💼';
	String get reasonTravel => 'Wisata & Travelling ✈️';
	String get reasonSchoolTitle => 'Pendidikan / Sekolah';
	String get reasonSchoolDesc => 'Untuk tugas sekolah atau pelajaran formal';
	String get reasonAnimeTitle => 'Anime & Pop Culture';
	String get reasonAnimeDesc => 'Biar bisa nonton anime tanpa subtitle';
	String get reasonWorkTitle => 'Karir & Pekerjaan';
	String get reasonWorkDesc => 'Persiapan kerja atau beasiswa ke Jepang';
	String get reasonTravelTitle => 'Wisata / Travelling';
	String get reasonTravelDesc => 'Kemudahan berkomunikasi saat berlibur';
	String get questionTitle => 'Kenapa kamu tertarik belajar Bahasa Jepang?';
	String get questionSubtitle => 'Pilih salah satu alasan utamamu belajar bahasa Jepang';
	String get continueBtn => 'LANJUTKAN';
}

// Path: feedback
class _StringsFeedbackId {
	_StringsFeedbackId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pengalaman Belajar';
	String get intro => 'Ulasan anda sangat membantu dalam mengembangkan fitur baru dan meningkatkan kualitas materi belajar di HI KATA.';
	String get rateUs => 'Bagaimana penilaianmu?';
	String get firstImpression => 'Pilih kesan pertamamu';
	String get commentHint => 'Tuliskan pengalamanmu di sini...';
	String get commentEmpty => 'Komentar tidak boleh kosong';
	String get submit => 'KIRIM ULASAN';
	String get writeSuggestions => 'Tulis saran & masukan';
	String get lastReview => 'Ulasan Terakhirmu';
	String get thanks => 'Terima Kasih! ❤️';
	String get thanksBody => 'Ulasanmu sangat berharga bagi pengembangan aplikasi HI KATA!';
	late final _StringsFeedbackTagsId tags = _StringsFeedbackTagsId._(_root);
}

// Path: auth.validation
class _StringsAuthValidationId {
	_StringsAuthValidationId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emailEmpty => 'Email tidak boleh kosong';
	String get emailInvalid => 'Format email tidak valid';
	String get passwordEmpty => 'Password tidak boleh kosong';
	String get passwordTooShort => 'Password minimal 6 karakter';
	String get passwordMismatch => 'Konfirmasi kata sandi tidak cocok';
	String get usernameEmpty => 'Nama pengguna tidak boleh kosong';
}

// Path: auth.messages
class _StringsAuthMessagesId {
	_StringsAuthMessagesId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loginFailed => 'Email atau kata sandi salah!';
	String get resetEmailSent => 'Tautan reset kata sandi telah dikirim ke email Anda.';
	String get emailAlreadyExists => 'Email sudah terdaftar! Gunakan email lain.';
	String get registerSuccess => 'Akun berhasil dibuat! Selamat bergabung 🥳';
}

// Path: profile.statistics
class _StringsProfileStatisticsId {
	_StringsProfileStatisticsId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get currentStreak => 'Streak Saat Ini';
	String get bestStreak => 'Streak Terbaik';
	String get totalQuiz => 'Total Quiz';
	String get highScore => 'Skor Tertinggi';
	String get hiragana => 'Hiragana';
	String get katakana => 'Katakana';
	String get days => 'Hari';
	String get completed => 'Selesai';
	String get progress => 'Progres';
	String get noQuizHistory => 'Belum ada Riwayat Kuis';
	String get startFirstQuiz => 'Yuk mulai belajar dan kerjakan kuis pertamamu!';
}

// Path: feedback.tags
class _StringsFeedbackTagsId {
	_StringsFeedbackTagsId._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get fun => 'Menyenangkan';
	String get easy => 'Mudah Dipahami';
	String get helpful => 'Sangat Membantu';
	String get improve => 'Perlu Peningkatan';
}

// Path: <root>
class _StringsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonEn common = _StringsCommonEn._(_root);
	@override late final _StringsAuthEn auth = _StringsAuthEn._(_root);
	@override late final _StringsHomeEn home = _StringsHomeEn._(_root);
	@override late final _StringsScriptGuideEn scriptGuide = _StringsScriptGuideEn._(_root);
	@override late final _StringsHiraganaEn hiragana = _StringsHiraganaEn._(_root);
	@override late final _StringsKatakanaEn katakana = _StringsKatakanaEn._(_root);
	@override late final _StringsFlashcardEn flashcard = _StringsFlashcardEn._(_root);
	@override late final _StringsQuizEn quiz = _StringsQuizEn._(_root);
	@override late final _StringsProgressEn progress = _StringsProgressEn._(_root);
	@override late final _StringsProfileEn profile = _StringsProfileEn._(_root);
	@override late final _StringsSettingsEn settings = _StringsSettingsEn._(_root);
	@override late final _StringsNotificationEn notification = _StringsNotificationEn._(_root);
	@override late final _StringsErrorsEn errors = _StringsErrorsEn._(_root);
	@override late final _StringsLanguageEn language = _StringsLanguageEn._(_root);
	@override late final _StringsAboutEn about = _StringsAboutEn._(_root);
	@override late final _StringsGoalsEn goals = _StringsGoalsEn._(_root);
	@override late final _StringsFeedbackEn feedback = _StringsFeedbackEn._(_root);
}

// Path: common
class _StringsCommonEn extends _StringsCommonId {
	_StringsCommonEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Welcome to HI KATA! 🥳';
	@override String unlockedLevelsRatio({required Object unlocked, required Object total}) => 'Level ${unlocked} of ${total} Unlocked';
	@override String get appName => 'HI KATA';
	@override String get continueText => 'CONTINUE';
	@override String get cancel => 'Cancel';
	@override String get back => 'Back';
	@override String get loading => 'Loading...';
	@override String get save => 'Save';
	@override String get or => 'or';
	@override String get check => 'Check';
	@override String get next => 'Next';
	@override String get finish => 'Finish';
	@override String get startLevelQuiz => 'Start Level Quiz!';
	@override String get grid => 'Grid';
	@override String get flashcard => 'Flashcard';
	@override String get quiz => 'Quiz';
	@override String get tip => 'Tip:';
	@override String get reading => 'Reading';
	@override String get memoryTip => 'Memory Tip';
	@override String get japaneseScriptGuide => 'Japanese Script Guide';
	@override String get scriptGuideDesc => 'Hiragana, Katakana, Dakuten, Yōon & more';
	@override String get appDescription => 'Japanese learning application';
	@override String get navHome => 'Home';
	@override String get navLearn => 'Learn';
	@override String get navQuiz => 'Quiz';
	@override String get navProgress => 'Progress';
	@override String get navProfile => 'Profile';
	@override String get introTablesTitle => 'Alphabet Intro Tables';
	@override String get introTablesDesc => 'Tap characters to hear their voice pronunciation 🔊';
	@override String get startStudyModules => 'START STUDY MODULES';
}

// Path: auth
class _StringsAuthEn extends _StringsAuthId {
	_StringsAuthEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get login => 'Login';
	@override String get register => 'Register';
	@override String get emailHint => 'Email Address';
	@override String get passwordHint => 'Password';
	@override String get confirmPasswordHint => 'Confirm Password';
	@override String get usernameHint => 'Username';
	@override String get forgotPassword => 'Forgot password?';
	@override String get dontHaveAccount => 'Don\'t have an account? ';
	@override String get alreadyHaveAccount => 'Already have an account? ';
	@override String get resetPasswordTitle => 'Reset Password';
	@override String get resetPasswordIntro => 'Enter your email to receive password reset instructions.';
	@override String get sendEmail => 'SEND EMAIL';
	@override late final _StringsAuthValidationEn validation = _StringsAuthValidationEn._(_root);
	@override late final _StringsAuthMessagesEn messages = _StringsAuthMessagesEn._(_root);
}

// Path: home
class _StringsHomeEn extends _StringsHomeId {
	_StringsHomeEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Home';
	@override String get subtitle => 'Let\'s learn Hiragana & Katakana';
	@override String get learnCardTitle => 'Learn Characters';
	@override String get learnCardSubtitle => 'Hiragana & Katakana';
	@override String get flashcardTitle => 'Flashcard';
	@override String get flashcardSubtitle => 'Memorization Practice';
	@override String get quizTitle => 'Quiz';
	@override String get quizSubtitle => 'Test Your Skills';
	@override String get stats => 'Statistics';
	@override String get dailyGoal => 'Daily Goal';
	@override String get morning => 'Ohayou / Good Morning';
	@override String get afternoon => 'Konnichiwa / Good Afternoon';
	@override String get night => 'Konbanwa / Good Evening';
	@override String get dailyMission => 'Today\'s Mission';
	@override String get finishOneLesson => 'Finish 1 Lesson';
	@override String days({required Object count}) => '${count} Days';
	@override String xp({required Object count}) => '${count} XP';
	@override String get rankBeginner => 'Beginner';
	@override String get rankIntermediate => 'Intermediate';
	@override String get rankAdvanced => 'Advanced';
	@override String get kanji => 'Kanji';
	@override String get conversation => 'Conversation';
	@override String get startPractice => 'Start Practice';
	@override String progressSummary({required Object completed, required Object percent, required Object total}) => '${completed} characters · ${percent}% completed (${completed}/${total})';
}

// Path: scriptGuide
class _StringsScriptGuideEn extends _StringsScriptGuideId {
	_StringsScriptGuideEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String completed({required Object completed, required Object total}) => '${completed} of ${total} completed';
	@override String get keepItUp => 'Keep it up!';
	@override String get xpPerLevel => '+5 XP each level completed.';
	@override String get awesome => 'Awesome!';
	@override String get keepLearning => 'Keep learning today.';
}

// Path: hiragana
class _StringsHiraganaEn extends _StringsHiraganaId {
	_StringsHiraganaEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hiragana Introduction';
	@override String get subtitle => 'Learn basic Hiragana characters';
	@override String get level => 'Level {num}';
	@override String get locked => 'Level Locked';
	@override String get lockedDesc => 'Complete the previous level quiz with at least 80% accuracy to unlock this level.';
}

// Path: katakana
class _StringsKatakanaEn extends _StringsKatakanaId {
	_StringsKatakanaEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Katakana Introduction';
	@override String get subtitle => 'Learn basic Katakana characters';
	@override String get level => 'Level {num}';
	@override String get locked => 'Level Locked';
	@override String get lockedDesc => 'Complete the previous level quiz with at least 80% accuracy to unlock this level.';
}

// Path: flashcard
class _StringsFlashcardEn extends _StringsFlashcardId {
	_StringsFlashcardEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Interactive Flashcard';
	@override String get flip => 'Tap to Flip';
	@override String get gotIt => 'Got It';
	@override String get review => 'Need Review';
	@override String get congrats => 'Congratulations!';
	@override String get finished => 'All cards have been studied';
}

// Path: quiz
class _StringsQuizEn extends _StringsQuizId {
	_StringsQuizEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Multiple Choice Quiz';
	@override String question({required Object current, required Object total}) => '${current} of ${total} questions';
	@override String get score => 'Your Score';
	@override String get correct => 'Correct';
	@override String get incorrect => 'Incorrect';
	@override String get retry => 'Retry';
	@override String get finishQuiz => 'Finish Quiz';
	@override String get listenPrompt => 'Listen to the following pronunciation:';
	@override String get listenAudio => 'Listen to Audio';
	@override String feedbackCorrect({required Object answer}) => 'Correct! Answer: ${answer}';
	@override String feedbackWrong({required Object answer}) => 'Wrong! Correct answer: ${answer}';
	@override String get seeResult => 'SEE RESULT';
	@override String get nextQuestion => 'NEXT QUESTION';
	@override String get quitQuiz => 'Quit Quiz?';
	@override String get quitWarning => 'Your progress will be lost if you quit now.';
	@override String get continueQuiz => 'Continue';
	@override String get quit => 'Quit';
	@override String get levelUnlockedTitle => '🎉 Congratulations!';
	@override String get levelUnlockedDesc => 'The next level has been successfully unlocked.';
	@override String get levelUnlockedSub => 'Keep learning to unlock more levels and improve your Japanese reading skills.';
	@override String get continueLearning => 'Continue Learning';
	@override String get feedbackOutstanding => '🌟 Outstanding!';
	@override String get feedbackGreat => '🎉 Great!';
	@override String get feedbackGood => '👍 Not Bad!';
	@override String get feedbackPoor => '📖 Let\'s Study Again!';
	@override String get descOutstanding => 'You mastered this material perfectly! Keep up the great work.';
	@override String get descGreat => 'Your understanding is very good. Just a little more practice for a perfect score!';
	@override String get descGood => 'You are starting to understand. Let\'s study more to improve fluency.';
	@override String get descPoor => 'Don\'t give up! Try reviewing the characters and quiz again for a better score.';
	@override String get accuracy => 'Accuracy';
	@override String get totalQuestions => 'Total';
	@override String get startListeningQuiz => 'START LISTENING QUIZ';
	@override String get backToHome => 'BACK TO HOME';
	@override String get evaluationQuiz => 'Evaluation Quiz';
	@override String get quizHiragana => 'Hiragana Quiz';
	@override String get quizKatakana => 'Katakana Quiz';
	@override String get quizMixed => 'Mixed Quiz';
	@override String get descQuizHiragana => 'Mixed quiz covering basic 46 Hiragana characters';
	@override String get descQuizKatakana => 'Mixed quiz covering basic 46 Katakana characters';
	@override String get descQuizMixed => 'Combination challenge of Hiragana & Katakana';
	@override String get listeningQuizzes => 'Listening Quizzes';
	@override String get listeningQuizHiragana => 'Hiragana Listening Quiz';
	@override String get listeningQuizKatakana => 'Katakana Listening Quiz';
	@override String get listeningQuizMixed => 'Mixed Listening Quiz';
	@override String get descListeningHiragana => 'Listening quiz covering basic 46 Hiragana characters';
	@override String get descListeningKatakana => 'Listening quiz covering basic 46 Katakana characters';
	@override String get descListeningMixed => 'Listening challenge of Hiragana & Katakana';
	@override String get unlockPreviousQuiz => 'Finish the previous quiz first';
	@override String countQuestions({required Object count}) => '${count} questions';
	@override String estTime({required Object time}) => '±${time} minutes';
	@override String get difficultyMedium => 'Medium';
	@override String get difficultyHard => 'Hard';
	@override String get lockedStatus => 'Locked';
	@override String get audioType => 'Audio';
}

// Path: progress
class _StringsProgressEn extends _StringsProgressId {
	_StringsProgressEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Learning Progress Statistics';
	@override String get streak => '{days} Day Streak';
	@override String get completed => 'Completed';
	@override String get charactersLearned => 'Characters Learned';
	@override String get learningProgress => 'Learning Progress';
	@override String get studyReminders => 'Study Reminders';
	@override String get totalUnlockedLevels => 'Total Unlocked Levels';
	@override String get totalQuizzesCompleted => 'Total Quizzes Completed';
	@override String reminderActive({required Object time}) => 'Daily study reminder scheduled at ${time} 🔔';
	@override String get reminderDisabled => 'Study reminder disabled 🔕';
	@override String reminderUpdated({required Object time}) => 'Reminder time updated to ${time} ⏰';
	@override String reminderLeft({required Object hours, required Object minutes}) => '⏰ ${hours} hours ${minutes} minutes left';
	@override String get studyStreak => 'Study Streak';
	@override String daysInARow({required Object days}) => '${days} Days in a Row!';
	@override String get enableAlarm => 'Enable Alarm';
	@override String get studyTime => 'Study Time';
	@override String get nextReminder => 'Next Reminder';
	@override String get keepItUpMsg => 'Keep up your learning spirit!';
	@override String charactersCount({required Object completed, required Object total}) => '${completed}/${total} characters';
}

// Path: profile
class _StringsProfileEn extends _StringsProfileId {
	_StringsProfileEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My Profile';
	@override String get studyStatistics => 'Study Statistics';
	@override String get appearance => 'Appearance';
	@override String get more => 'More';
	@override String get feedback => 'Feedback';
	@override String get aboutApp => 'About App';
	@override String get deleteAccount => 'Delete Account';
	@override String get deleteAccountTitle => 'Delete Account Permanently?';
	@override String get deleteAccountConfirmText => 'This action cannot be undone. All your study progress, quiz history, streak, and learned characters will be permanently deleted from the system.';
	@override String get cancel => 'Cancel';
	@override String get logout => 'Log Out';
	@override String get logoutTitle => 'Logout?';
	@override String get logoutConfirmText => 'You need to login again to save your learning progress.';
	@override String get badgesEarned => 'Badges Earned';
	@override String get deleteDataWarning => 'All data will be lost permanently';
	@override String get hiraganaQuiz => 'Hiragana Quiz';
	@override String get katakanaQuiz => 'Katakana Quiz';
	@override String get defaultUserName => 'HI KATA Learner';
	@override late final _StringsProfileStatisticsEn statistics = _StringsProfileStatisticsEn._(_root);
	@override String get chooseAvatar => 'Choose New Avatar';
	@override String get achievements => 'Quiz Achievements';
	@override String get mixedQuiz => 'Mixed Quiz';
	@override String joinedSince({required Object date}) => 'Joined since ${date}';
}

// Path: settings
class _StringsSettingsEn extends _StringsSettingsId {
	_StringsSettingsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get mixedQuiz => 'Mixed Quiz';
	@override String get appearance => 'App Appearance';
	@override String get lightMode => 'Light Mode';
	@override String get darkMode => 'Dark Mode';
	@override String get title => 'Settings';
	@override String get theme => 'App Theme';
	@override String get darkTheme => 'Dark Mode';
	@override String get lightTheme => 'Light Mode';
	@override String get systemTheme => 'System';
	@override String get language => 'Language';
	@override String get dailyNotification => 'Daily Notification';
	@override String get notificationTime => 'Notification Time';
}

// Path: notification
class _StringsNotificationEn extends _StringsNotificationId {
	_StringsNotificationEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Time to Study!';
	@override String get body => 'Let\'s spend 5 minutes today to practice your Hiragana and Katakana.';
}

// Path: errors
class _StringsErrorsEn extends _StringsErrorsId {
	_StringsErrorsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get general => 'An error occurred. Please try again.';
	@override String get network => 'Network connection error.';
}

// Path: language
class _StringsLanguageEn extends _StringsLanguageId {
	_StringsLanguageEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Select Language';
	@override String get subtitle => 'Choose Language';
	@override String get changeAnytime => 'You can change language anytime';
	@override String get changeAnytimeEn => 'You can change language anytime';
	@override String get indonesian => 'Bahasa Indonesia';
	@override String get english => 'English';
	@override String get indonesianDesc => 'Guide in Indonesian Language';
	@override String get englishDesc => 'Guide in English Language';
}

// Path: about
class _StringsAboutEn extends _StringsAboutId {
	_StringsAboutEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'About App';
	@override String get description => 'HI KATA helps you learn Hiragana and Katakana through interactive lessons, pronunciation audio, and engaging quizzes.';
	@override String get version => 'App Version';
	@override String get developer => 'App Developer';
}

// Path: goals
class _StringsGoalsEn extends _StringsGoalsId {
	_StringsGoalsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your Learning Goal';
	@override String get subtitle => 'Let\'s set your daily learning target!';
	@override String get greatChoice => 'Great choice! You are learning for: ';
	@override String get dailyTargetQuestion => 'How much is your daily target?';
	@override String get startLearning => 'START LEARNING';
	@override String targetSet({required Object name, required Object time}) => 'Daily target set to: ${name} (${time})🔥';
	@override String get goalRelaxed => 'Relaxed';
	@override String get goalRegular => 'Regular';
	@override String get goalSerious => 'Serious';
	@override String get goalIntense => 'Intense';
	@override String get time5m => '5 mins / day';
	@override String get time10m => '10 mins / day';
	@override String get time15m => '15 mins / day';
	@override String get time20m => '20 mins / day';
	@override String get descRelaxed => 'Good for initial intro';
	@override String get descRegular => 'Recommended for beginners';
	@override String get descSerious => 'Fast learning progress';
	@override String get descIntense => 'Maximum learning challenge';
	@override String get reasonSchool => 'Education & School 🏫';
	@override String get reasonAnime => 'Anime & Pop Culture 🍿';
	@override String get reasonWork => 'Career & Work 💼';
	@override String get reasonTravel => 'Tourism & Travelling ✈️';
	@override String get reasonSchoolTitle => 'Education / School';
	@override String get reasonSchoolDesc => 'For school assignments or formal courses';
	@override String get reasonAnimeTitle => 'Anime & Pop Culture';
	@override String get reasonAnimeDesc => 'So you can watch anime without subtitles';
	@override String get reasonWorkTitle => 'Career & Work';
	@override String get reasonWorkDesc => 'Preparing for a job or scholarship in Japan';
	@override String get reasonTravelTitle => 'Tourism / Travelling';
	@override String get reasonTravelDesc => 'Ease of communication during vacations';
	@override String get questionTitle => 'Why are you interested in learning Japanese?';
	@override String get questionSubtitle => 'Choose one of your main reasons for learning Japanese.';
	@override String get continueBtn => 'CONTINUE';
}

// Path: feedback
class _StringsFeedbackEn extends _StringsFeedbackId {
	_StringsFeedbackEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Learning Experience';
	@override String get intro => 'Your review highly helps our team in developing new features and improving study material quality in HI KATA.';
	@override String get rateUs => 'How would you rate us?';
	@override String get firstImpression => 'Choose your first impression';
	@override String get commentHint => 'Write your experience here...';
	@override String get commentEmpty => 'Comment cannot be empty';
	@override String get submit => 'SUBMIT REVIEW';
	@override String get writeSuggestions => 'Write comments & suggestions';
	@override String get lastReview => 'Your Last Review';
	@override String get thanks => 'Thank You! ❤️';
	@override String get thanksBody => 'Your review is highly valuable for the development of HI KATA!';
	@override late final _StringsFeedbackTagsEn tags = _StringsFeedbackTagsEn._(_root);
}

// Path: auth.validation
class _StringsAuthValidationEn extends _StringsAuthValidationId {
	_StringsAuthValidationEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get emailEmpty => 'Email cannot be empty';
	@override String get emailInvalid => 'Invalid email format';
	@override String get passwordEmpty => 'Password cannot be empty';
	@override String get passwordTooShort => 'Password must be at least 6 characters';
	@override String get passwordMismatch => 'Passwords do not match';
	@override String get usernameEmpty => 'Username cannot be empty';
}

// Path: auth.messages
class _StringsAuthMessagesEn extends _StringsAuthMessagesId {
	_StringsAuthMessagesEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get loginFailed => 'Incorrect email or password!';
	@override String get resetEmailSent => 'Password reset link has been sent to your email.';
	@override String get emailAlreadyExists => 'Email is already registered! Please use another email.';
	@override String get registerSuccess => 'Account successfully created! Welcome 🥳';
}

// Path: profile.statistics
class _StringsProfileStatisticsEn extends _StringsProfileStatisticsId {
	_StringsProfileStatisticsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get currentStreak => 'Current Streak';
	@override String get bestStreak => 'Best Streak';
	@override String get totalQuiz => 'Total Quiz';
	@override String get highScore => 'High Score';
	@override String get hiragana => 'Hiragana';
	@override String get katakana => 'Katakana';
	@override String get days => 'Days';
	@override String get completed => 'Completed';
	@override String get progress => 'Progress';
	@override String get noQuizHistory => 'No Quiz History';
	@override String get startFirstQuiz => 'Let\'s start learning and take your first quiz!';
}

// Path: feedback.tags
class _StringsFeedbackTagsEn extends _StringsFeedbackTagsId {
	_StringsFeedbackTagsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get fun => 'Fun';
	@override String get easy => 'Easy to Understand';
	@override String get helpful => 'Very Helpful';
	@override String get improve => 'Needs Improvement';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.welcome': return 'Selamat Datang di HI KATA! 🥳';
			case 'common.unlockedLevelsRatio': return ({required Object unlocked, required Object total}) => 'Level ${unlocked} dari ${total} Terbuka';
			case 'common.appName': return 'HI KATA';
			case 'common.continueText': return 'LANJUTKAN';
			case 'common.cancel': return 'Batal';
			case 'common.back': return 'Kembali';
			case 'common.loading': return 'Memuat...';
			case 'common.save': return 'Simpan';
			case 'common.or': return 'atau';
			case 'common.check': return 'Periksa';
			case 'common.next': return 'Lanjut';
			case 'common.finish': return 'Selesai';
			case 'common.startLevelQuiz': return 'Mulai Quiz Level!';
			case 'common.grid': return 'Tabel';
			case 'common.flashcard': return 'Kartu';
			case 'common.quiz': return 'Kuis';
			case 'common.tip': return 'Pengingat:';
			case 'common.reading': return 'Cara baca';
			case 'common.memoryTip': return 'Tips Hafalan';
			case 'common.japaneseScriptGuide': return ' Huruf Jepang';
			case 'common.scriptGuideDesc': return 'Hiragana, Katakana, Dakuten, Youon & lainnya';
			case 'common.navHome': return 'Beranda';
			case 'common.navLearn': return 'Belajar';
			case 'common.navQuiz': return 'Kuis';
			case 'common.navProgress': return 'Progres';
			case 'common.navProfile': return 'Profil';
			case 'common.introTablesTitle': return 'Tabel Pengenalan Huruf';
			case 'common.introTablesDesc': return 'Ketuk huruf untuk mendengarkan pelafalan suaranya 🔊';
			case 'common.startStudyModules': return 'MULAI MODUL BELAJAR';
			case 'auth.login': return 'Masuk';
			case 'auth.register': return 'Daftar';
			case 'auth.emailHint': return 'Alamat Email';
			case 'auth.passwordHint': return 'Kata Sandi';
			case 'auth.confirmPasswordHint': return 'Konfirmasi Kata Sandi';
			case 'auth.usernameHint': return 'Nama Pengguna';
			case 'auth.forgotPassword': return 'Lupa password?';
			case 'auth.dontHaveAccount': return 'Belum punya akun? ';
			case 'auth.alreadyHaveAccount': return 'Sudah punya akun? ';
			case 'auth.resetPasswordTitle': return 'Atur Ulang Sandi';
			case 'auth.resetPasswordIntro': return 'Masukkan email Anda untuk menerima instruksi pengaturan ulang kata sandi.';
			case 'auth.sendEmail': return 'KIRIM EMAIL';
			case 'auth.validation.emailEmpty': return 'Email tidak boleh kosong';
			case 'auth.validation.emailInvalid': return 'Format email tidak valid';
			case 'auth.validation.passwordEmpty': return 'Password tidak boleh kosong';
			case 'auth.validation.passwordTooShort': return 'Password minimal 6 karakter';
			case 'auth.validation.passwordMismatch': return 'Konfirmasi kata sandi tidak cocok';
			case 'auth.validation.usernameEmpty': return 'Nama pengguna tidak boleh kosong';
			case 'auth.messages.loginFailed': return 'Email atau kata sandi salah!';
			case 'auth.messages.resetEmailSent': return 'Tautan reset kata sandi telah dikirim ke email Anda.';
			case 'auth.messages.emailAlreadyExists': return 'Email sudah terdaftar! Gunakan email lain.';
			case 'auth.messages.registerSuccess': return 'Akun berhasil dibuat! Selamat bergabung 🥳';
			case 'home.title': return 'Home';
			case 'home.subtitle': return 'Mari belajar Hiragana & Katakana';
			case 'home.learnCardTitle': return 'Belajar Huruf';
			case 'home.learnCardSubtitle': return 'Hiragana & Katakana';
			case 'home.flashcardTitle': return 'Flashcard';
			case 'home.flashcardSubtitle': return 'Latihan Hafalan';
			case 'home.quizTitle': return 'Kuis';
			case 'home.quizSubtitle': return 'Uji Kemampuan';
			case 'home.stats': return 'Statistik';
			case 'home.dailyGoal': return 'Target Harian';
			case 'home.morning': return 'Ohayou / Selamat Pagi';
			case 'home.afternoon': return 'Konnichiwa / Selamat Siang';
			case 'home.night': return 'Konbanwa / Selamat Malam';
			case 'home.dailyMission': return 'Misi Hari Ini';
			case 'home.finishOneLesson': return 'Selesaikan 1 Pelajaran';
			case 'home.days': return ({required Object count}) => '${count} Hari';
			case 'home.xp': return ({required Object count}) => '${count} XP';
			case 'home.rankBeginner': return 'Pemula';
			case 'home.rankIntermediate': return 'Menengah';
			case 'home.rankAdvanced': return 'Mahir';
			case 'home.kanji': return 'Kanji';
			case 'home.conversation': return 'Percakapan';
			case 'home.startPractice': return 'Mulai Latihan';
			case 'home.progressSummary': return ({required Object completed, required Object percent, required Object total}) => '${completed} karakter · ${percent}% selesai (${completed}/${total})';
			case 'scriptGuide.completed': return ({required Object completed, required Object total}) => '${completed} dari ${total} selesai';
			case 'scriptGuide.keepItUp': return 'Pertahankan Semangat!';
			case 'scriptGuide.xpPerLevel': return '+5 XP tiap level selesai.';
			case 'scriptGuide.awesome': return 'Luar biasa!';
			case 'scriptGuide.keepLearning': return 'Lanjutkan belajarmu hari ini.';
			case 'hiragana.title': return 'Pengenalan Hiragana';
			case 'hiragana.subtitle': return 'Belajar huruf dasar Hiragana';
			case 'hiragana.level': return 'Level {num}';
			case 'hiragana.locked': return 'Level Terkunci';
			case 'hiragana.lockedDesc': return 'Selesaikan kuis level sebelumnya dengan akurasi minimal 80% untuk membuka level ini.';
			case 'katakana.title': return 'Pengenalan Katakana';
			case 'katakana.subtitle': return 'Belajar huruf dasar Katakana';
			case 'katakana.level': return 'Level {num}';
			case 'katakana.locked': return 'Level Terkunci';
			case 'katakana.lockedDesc': return 'Selesaikan kuis level sebelumnya dengan akurasi minimal 80% untuk membuka level ini.';
			case 'flashcard.title': return 'Flashcard Interaktif';
			case 'flashcard.flip': return 'Ketuk untuk Membalik';
			case 'flashcard.gotIt': return 'Sudah Hafal';
			case 'flashcard.review': return 'Perlu Ulang';
			case 'flashcard.congrats': return 'Selamat!';
			case 'flashcard.finished': return 'Semua kartu telah dipelajari';
			case 'quiz.title': return 'Kuis Pilihan Ganda';
			case 'quiz.question': return ({required Object current, required Object total}) => '${current} dari ${total} soal';
			case 'quiz.score': return 'Skor Anda';
			case 'quiz.correct': return 'Benar';
			case 'quiz.incorrect': return 'Salah';
			case 'quiz.retry': return 'Coba Lagi';
			case 'quiz.finishQuiz': return 'Selesaikan Kuis';
			case 'quiz.listenPrompt': return 'Dengarkan pelafalan huruf berikut:';
			case 'quiz.listenAudio': return 'Dengarkan Audio';
			case 'quiz.feedbackCorrect': return ({required Object answer}) => 'Benar! Jawaban: ${answer}';
			case 'quiz.feedbackWrong': return ({required Object answer}) => 'Salah! Jawaban yang benar: ${answer}';
			case 'quiz.seeResult': return 'LIHAT HASIL';
			case 'quiz.nextQuestion': return 'SOAL BERIKUTNYA';
			case 'quiz.quitQuiz': return 'Keluar Kuis?';
			case 'quiz.quitWarning': return 'Progresmu akan hilang jika keluar sekarang.';
			case 'quiz.continueQuiz': return 'Lanjut';
			case 'quiz.quit': return 'Keluar';
			case 'quiz.levelUnlockedTitle': return '🎉 Selamat!';
			case 'quiz.levelUnlockedDesc': return 'Level berikutnya berhasil dibuka.';
			case 'quiz.levelUnlockedSub': return 'Teruskan belajar untuk membuka level lainnya dan meningkatkan kemampuan membaca huruf Jepang.';
			case 'quiz.continueLearning': return 'Lanjut Belajar';
			case 'quiz.feedbackOutstanding': return '🌟 Luar Biasa!';
			case 'quiz.feedbackGreat': return '🎉 Hebat!';
			case 'quiz.feedbackGood': return '👍 Lumayan!';
			case 'quiz.feedbackPoor': return '📖 Ayo Belajar Lagi!';
			case 'quiz.descOutstanding': return 'Kamu menguasai materi ini dengan sempurna! Pertahankan prestasimu.';
			case 'quiz.descGreat': return 'Pemahamanmu sudah sangat baik. Sedikit latihan lagi untuk nilai sempurna!';
			case 'quiz.descGood': return 'Kamu sudah mulai paham. Mari belajar lagi agar lebih lancar.';
			case 'quiz.descPoor': return 'Jangan menyerah! Coba ulangi pengenalan huruf dan kuis untuk hasil lebih baik.';
			case 'quiz.accuracy': return 'Akurasi';
			case 'quiz.totalQuestions': return 'Total Soal';
			case 'quiz.startListeningQuiz': return 'MULAI KUIS PENDENGARAN';
			case 'quiz.backToHome': return 'KEMBALI KE BERANDA';
			case 'quiz.evaluationQuiz': return 'Quiz Evaluasi';
			case 'quiz.quizHiragana': return 'Quiz Hiragana';
			case 'quiz.quizKatakana': return 'Quiz Katakana';
			case 'quiz.quizMixed': return 'Quiz Campuran';
			case 'quiz.descQuizHiragana': return 'Quiz campuran dari 46 karakter dasar Hiragana';
			case 'quiz.descQuizKatakana': return 'Quiz campuran dari 46 karakter dasar Katakana';
			case 'quiz.descQuizMixed': return 'Tantangan quiz kombinasi Hiragana & Katakana';
			case 'quiz.listeningQuizzes': return 'Quiz Pendengaran';
			case 'quiz.listeningQuizHiragana': return 'Quiz Pendengaran Hiragana';
			case 'quiz.listeningQuizKatakana': return 'Quiz Pendengaran Katakana';
			case 'quiz.listeningQuizMixed': return 'Quiz Pendengaran Campuran';
			case 'quiz.descListeningHiragana': return 'Quiz pendengaran dari 46 karakter dasar Hiragana';
			case 'quiz.descListeningKatakana': return 'Quiz pendengaran dari 46 karakter dasar Katakana';
			case 'quiz.descListeningMixed': return 'Tantangan pendengaran kombinasi Hiragana & Katakana';
			case 'quiz.unlockPreviousQuiz': return 'Selesaikan kuis sebelumnya';
			case 'quiz.countQuestions': return ({required Object count}) => '${count} soal';
			case 'quiz.estTime': return ({required Object time}) => '±${time} menit';
			case 'quiz.difficultyMedium': return 'Sedang';
			case 'quiz.difficultyHard': return 'Sulit';
			case 'quiz.lockedStatus': return 'Terkunci';
			case 'quiz.audioType': return 'Audio';
			case 'progress.title': return 'Statistik Progres belajar';
			case 'progress.streak': return '{days} Hari Beruntun';
			case 'progress.completed': return 'Selesai';
			case 'progress.charactersLearned': return 'Karakter Terpelajar';
			case 'progress.learningProgress': return 'Progres Belajar';
			case 'progress.studyReminders': return 'Pengingat Belajar';
			case 'progress.totalUnlockedLevels': return 'Total Level Terbuka';
			case 'progress.totalQuizzesCompleted': return 'Total Quiz Selesai';
			case 'progress.reminderActive': return ({required Object time}) => 'Pengingat belajar aktif harian pada ${time} 🔔';
			case 'progress.reminderDisabled': return 'Pengingat belajar dinonaktifkan 🔕';
			case 'progress.reminderUpdated': return ({required Object time}) => 'Jam pengingat diubah ke ${time} ⏰';
			case 'progress.reminderLeft': return ({required Object hours, required Object minutes}) => '⏰ ${hours} jam ${minutes} menit lagi';
			case 'progress.studyStreak': return 'Streak Belajar';
			case 'progress.daysInARow': return ({required Object days}) => '${days} Hari Berturut-turut!';
			case 'progress.enableAlarm': return 'Aktifkan Pengingat';
			case 'progress.studyTime': return 'Waktu Belajar';
			case 'progress.nextReminder': return 'Pengingat Berikutnya';
			case 'progress.keepItUpMsg': return 'Pertahankan terus semangat belajarmu!';
			case 'progress.charactersCount': return ({required Object completed, required Object total}) => '${completed}/${total} karakter';
			case 'profile.title': return 'Profil Saya';
			case 'profile.studyStatistics': return 'Statistik Belajar';
			case 'profile.appearance': return 'Pengaturan Tampilan';
			case 'profile.more': return 'Lainnya';
			case 'profile.feedback': return 'Beri Masukan';
			case 'profile.aboutApp': return 'Tentang Aplikasi';
			case 'profile.deleteAccount': return 'Hapus Akun';
			case 'profile.deleteAccountTitle': return 'Hapus Akun Permanen?';
			case 'profile.deleteAccountConfirmText': return 'Tindakan ini tidak dapat dibatalkan. Seluruh data progres belajar, riwayat kuis, streak, dan karakter terpelajar akan dihapus secara permanen dari sistem.';
			case 'profile.cancel': return 'Batal';
			case 'profile.logout': return 'Keluar';
			case 'profile.logoutTitle': return 'Keluar dari Akun?';
			case 'profile.logoutConfirmText': return 'Kamu harus masuk lagi untuk menyimpan progres belajar.';
			case 'profile.badgesEarned': return 'Badge Diraih';
			case 'profile.deleteDataWarning': return 'Semua data akan hilang permanen';
			case 'profile.hiraganaQuiz': return 'Kuis Hiragana';
			case 'profile.katakanaQuiz': return 'Kuis Katakana';
			case 'profile.defaultUserName': return 'Pelajar HI KATA';
			case 'profile.statistics.currentStreak': return 'Streak Saat Ini';
			case 'profile.statistics.bestStreak': return 'Streak Terbaik';
			case 'profile.statistics.totalQuiz': return 'Total Quiz';
			case 'profile.statistics.highScore': return 'Skor Tertinggi';
			case 'profile.statistics.hiragana': return 'Hiragana';
			case 'profile.statistics.katakana': return 'Katakana';
			case 'profile.statistics.days': return 'Hari';
			case 'profile.statistics.completed': return 'Selesai';
			case 'profile.statistics.progress': return 'Progres';
			case 'profile.statistics.noQuizHistory': return 'Belum ada Riwayat Kuis';
			case 'profile.statistics.startFirstQuiz': return 'Yuk mulai belajar dan kerjakan kuis pertamamu!';
			case 'profile.chooseAvatar': return 'Pilih Avatar Baru';
			case 'profile.achievements': return 'Pencapaian Kuis';
			case 'profile.mixedQuiz': return 'Kuis Campuran';
			case 'profile.joinedSince': return ({required Object date}) => 'Bergabung sejak ${date}';
			case 'settings.mixedQuiz': return 'Kuis Campuran';
			case 'settings.appearance': return 'Tampilan Aplikasi';
			case 'settings.lightMode': return 'Mode Terang';
			case 'settings.darkMode': return 'Mode Gelap';
			case 'settings.title': return 'Pengaturan';
			case 'settings.theme': return 'Tema Aplikasi';
			case 'settings.darkTheme': return 'Mode Gelap';
			case 'settings.lightTheme': return 'Mode Terang';
			case 'settings.systemTheme': return 'Sistem';
			case 'settings.language': return 'Bahasa';
			case 'settings.dailyNotification': return 'Notifikasi Harian';
			case 'settings.notificationTime': return 'Waktu Notifikasi';
			case 'notification.title': return 'Waktunya Belajar!';
			case 'notification.body': return 'Ayo luangkan 5 menit hari ini untuk melatih Hiragana dan Katakana kamu.';
			case 'errors.general': return 'Terjadi kesalahan. Silakan coba lagi.';
			case 'errors.network': return 'Koneksi internet bermasalah.';
			case 'language.title': return 'Pilih Bahasa';
			case 'language.subtitle': return 'Choose Language';
			case 'language.changeAnytime': return 'Kamu bisa mengubah bahasa kapan saja';
			case 'language.changeAnytimeEn': return 'You can change language anytime';
			case 'language.indonesian': return 'Bahasa Indonesia';
			case 'language.english': return 'English';
			case 'language.indonesianDesc': return 'Panduan dalam Bahasa Indonesia';
			case 'language.englishDesc': return 'Guide in English Language';
			case 'about.title': return 'Tentang Aplikasi';
			case 'about.description': return 'HI KATA membantu anda mempelajari Hiragana dan Katakana melalui pembelajaran interaktif, audio pelafalan, dan kuis yang menyenangkan.';
			case 'about.version': return 'App Version';
			case 'about.developer': return 'Pembuat Aplikasi';
			case 'goals.title': return 'Tujuan Belajarmu';
			case 'goals.subtitle': return 'Mari tentukan target harian belajarmu!';
			case 'goals.greatChoice': return 'Pilihan mantap! Kamu belajar untuk: ';
			case 'goals.dailyTargetQuestion': return 'Berapa target belajar harianmu?';
			case 'goals.startLearning': return 'MULAI BELAJAR';
			case 'goals.targetSet': return ({required Object name, required Object time}) => 'Target harian diatur ke: ${name} (${time})🔥';
			case 'goals.goalRelaxed': return 'Santai';
			case 'goals.goalRegular': return 'Biasa';
			case 'goals.goalSerious': return 'Serius';
			case 'goals.goalIntense': return 'Intens';
			case 'goals.time5m': return '5 menit / hari';
			case 'goals.time10m': return '10 menit / hari';
			case 'goals.time15m': return '15 menit / hari';
			case 'goals.time20m': return '20 menit / hari';
			case 'goals.descRelaxed': return 'Bagus untuk perkenalan awal';
			case 'goals.descRegular': return 'Rekomendasi untuk pemula';
			case 'goals.descSerious': return 'Progress belajar cepat';
			case 'goals.descIntense': return 'Tantangan belajar maksimal';
			case 'goals.reasonSchool': return 'Pendidikan & Sekolah 🏫';
			case 'goals.reasonAnime': return 'Anime & Pop Culture 🍿';
			case 'goals.reasonWork': return 'Karir & Pekerjaan 💼';
			case 'goals.reasonTravel': return 'Wisata & Travelling ✈️';
			case 'goals.reasonSchoolTitle': return 'Pendidikan / Sekolah';
			case 'goals.reasonSchoolDesc': return 'Untuk tugas sekolah atau pelajaran formal';
			case 'goals.reasonAnimeTitle': return 'Anime & Pop Culture';
			case 'goals.reasonAnimeDesc': return 'Biar bisa nonton anime tanpa subtitle';
			case 'goals.reasonWorkTitle': return 'Karir & Pekerjaan';
			case 'goals.reasonWorkDesc': return 'Persiapan kerja atau beasiswa ke Jepang';
			case 'goals.reasonTravelTitle': return 'Wisata / Travelling';
			case 'goals.reasonTravelDesc': return 'Kemudahan berkomunikasi saat berlibur';
			case 'goals.questionTitle': return 'Kenapa kamu tertarik belajar Bahasa Jepang?';
			case 'goals.questionSubtitle': return 'Pilih salah satu alasan utamamu belajar bahasa Jepang';
			case 'goals.continueBtn': return 'LANJUTKAN';
			case 'feedback.title': return 'Pengalaman Belajar';
			case 'feedback.intro': return 'Ulasan anda sangat membantu dalam mengembangkan fitur baru dan meningkatkan kualitas materi belajar di HI KATA.';
			case 'feedback.rateUs': return 'Bagaimana penilaianmu?';
			case 'feedback.firstImpression': return 'Pilih kesan pertamamu';
			case 'feedback.commentHint': return 'Tuliskan pengalamanmu di sini...';
			case 'feedback.commentEmpty': return 'Komentar tidak boleh kosong';
			case 'feedback.submit': return 'KIRIM ULASAN';
			case 'feedback.writeSuggestions': return 'Tulis saran & masukan';
			case 'feedback.lastReview': return 'Ulasan Terakhirmu';
			case 'feedback.thanks': return 'Terima Kasih! ❤️';
			case 'feedback.thanksBody': return 'Ulasanmu sangat berharga bagi pengembangan aplikasi HI KATA!';
			case 'feedback.tags.fun': return 'Menyenangkan';
			case 'feedback.tags.easy': return 'Mudah Dipahami';
			case 'feedback.tags.helpful': return 'Sangat Membantu';
			case 'feedback.tags.improve': return 'Perlu Peningkatan';
			default: return null;
		}
	}
}

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.welcome': return 'Welcome to HI KATA! 🥳';
			case 'common.unlockedLevelsRatio': return ({required Object unlocked, required Object total}) => 'Level ${unlocked} of ${total} Unlocked';
			case 'common.appName': return 'HI KATA';
			case 'common.continueText': return 'CONTINUE';
			case 'common.cancel': return 'Cancel';
			case 'common.back': return 'Back';
			case 'common.loading': return 'Loading...';
			case 'common.save': return 'Save';
			case 'common.or': return 'or';
			case 'common.check': return 'Check';
			case 'common.next': return 'Next';
			case 'common.finish': return 'Finish';
			case 'common.startLevelQuiz': return 'Start Level Quiz!';
			case 'common.grid': return 'Grid';
			case 'common.flashcard': return 'Flashcard';
			case 'common.quiz': return 'Quiz';
			case 'common.tip': return 'Tip:';
			case 'common.reading': return 'Reading';
			case 'common.memoryTip': return 'Memory Tip';
			case 'common.japaneseScriptGuide': return 'Japanese Script Guide';
			case 'common.scriptGuideDesc': return 'Hiragana, Katakana, Dakuten, Yōon & more';
			case 'common.appDescription': return 'Japanese learning application';
			case 'common.navHome': return 'Home';
			case 'common.navLearn': return 'Learn';
			case 'common.navQuiz': return 'Quiz';
			case 'common.navProgress': return 'Progress';
			case 'common.navProfile': return 'Profile';
			case 'common.introTablesTitle': return 'Alphabet Intro Tables';
			case 'common.introTablesDesc': return 'Tap characters to hear their voice pronunciation 🔊';
			case 'common.startStudyModules': return 'START STUDY MODULES';
			case 'auth.login': return 'Login';
			case 'auth.register': return 'Register';
			case 'auth.emailHint': return 'Email Address';
			case 'auth.passwordHint': return 'Password';
			case 'auth.confirmPasswordHint': return 'Confirm Password';
			case 'auth.usernameHint': return 'Username';
			case 'auth.forgotPassword': return 'Forgot password?';
			case 'auth.dontHaveAccount': return 'Don\'t have an account? ';
			case 'auth.alreadyHaveAccount': return 'Already have an account? ';
			case 'auth.resetPasswordTitle': return 'Reset Password';
			case 'auth.resetPasswordIntro': return 'Enter your email to receive password reset instructions.';
			case 'auth.sendEmail': return 'SEND EMAIL';
			case 'auth.validation.emailEmpty': return 'Email cannot be empty';
			case 'auth.validation.emailInvalid': return 'Invalid email format';
			case 'auth.validation.passwordEmpty': return 'Password cannot be empty';
			case 'auth.validation.passwordTooShort': return 'Password must be at least 6 characters';
			case 'auth.validation.passwordMismatch': return 'Passwords do not match';
			case 'auth.validation.usernameEmpty': return 'Username cannot be empty';
			case 'auth.messages.loginFailed': return 'Incorrect email or password!';
			case 'auth.messages.resetEmailSent': return 'Password reset link has been sent to your email.';
			case 'auth.messages.emailAlreadyExists': return 'Email is already registered! Please use another email.';
			case 'auth.messages.registerSuccess': return 'Account successfully created! Welcome 🥳';
			case 'home.title': return 'Home';
			case 'home.subtitle': return 'Let\'s learn Hiragana & Katakana';
			case 'home.learnCardTitle': return 'Learn Characters';
			case 'home.learnCardSubtitle': return 'Hiragana & Katakana';
			case 'home.flashcardTitle': return 'Flashcard';
			case 'home.flashcardSubtitle': return 'Memorization Practice';
			case 'home.quizTitle': return 'Quiz';
			case 'home.quizSubtitle': return 'Test Your Skills';
			case 'home.stats': return 'Statistics';
			case 'home.dailyGoal': return 'Daily Goal';
			case 'home.morning': return 'Ohayou / Good Morning';
			case 'home.afternoon': return 'Konnichiwa / Good Afternoon';
			case 'home.night': return 'Konbanwa / Good Evening';
			case 'home.dailyMission': return 'Today\'s Mission';
			case 'home.finishOneLesson': return 'Finish 1 Lesson';
			case 'home.days': return ({required Object count}) => '${count} Days';
			case 'home.xp': return ({required Object count}) => '${count} XP';
			case 'home.rankBeginner': return 'Beginner';
			case 'home.rankIntermediate': return 'Intermediate';
			case 'home.rankAdvanced': return 'Advanced';
			case 'home.kanji': return 'Kanji';
			case 'home.conversation': return 'Conversation';
			case 'home.startPractice': return 'Start Practice';
			case 'home.progressSummary': return ({required Object completed, required Object percent, required Object total}) => '${completed} characters · ${percent}% completed (${completed}/${total})';
			case 'scriptGuide.completed': return ({required Object completed, required Object total}) => '${completed} of ${total} completed';
			case 'scriptGuide.keepItUp': return 'Keep it up!';
			case 'scriptGuide.xpPerLevel': return '+5 XP each level completed.';
			case 'scriptGuide.awesome': return 'Awesome!';
			case 'scriptGuide.keepLearning': return 'Keep learning today.';
			case 'hiragana.title': return 'Hiragana Introduction';
			case 'hiragana.subtitle': return 'Learn basic Hiragana characters';
			case 'hiragana.level': return 'Level {num}';
			case 'hiragana.locked': return 'Level Locked';
			case 'hiragana.lockedDesc': return 'Complete the previous level quiz with at least 80% accuracy to unlock this level.';
			case 'katakana.title': return 'Katakana Introduction';
			case 'katakana.subtitle': return 'Learn basic Katakana characters';
			case 'katakana.level': return 'Level {num}';
			case 'katakana.locked': return 'Level Locked';
			case 'katakana.lockedDesc': return 'Complete the previous level quiz with at least 80% accuracy to unlock this level.';
			case 'flashcard.title': return 'Interactive Flashcard';
			case 'flashcard.flip': return 'Tap to Flip';
			case 'flashcard.gotIt': return 'Got It';
			case 'flashcard.review': return 'Need Review';
			case 'flashcard.congrats': return 'Congratulations!';
			case 'flashcard.finished': return 'All cards have been studied';
			case 'quiz.title': return 'Multiple Choice Quiz';
			case 'quiz.question': return ({required Object current, required Object total}) => '${current} of ${total} questions';
			case 'quiz.score': return 'Your Score';
			case 'quiz.correct': return 'Correct';
			case 'quiz.incorrect': return 'Incorrect';
			case 'quiz.retry': return 'Retry';
			case 'quiz.finishQuiz': return 'Finish Quiz';
			case 'quiz.listenPrompt': return 'Listen to the following pronunciation:';
			case 'quiz.listenAudio': return 'Listen to Audio';
			case 'quiz.feedbackCorrect': return ({required Object answer}) => 'Correct! Answer: ${answer}';
			case 'quiz.feedbackWrong': return ({required Object answer}) => 'Wrong! Correct answer: ${answer}';
			case 'quiz.seeResult': return 'SEE RESULT';
			case 'quiz.nextQuestion': return 'NEXT QUESTION';
			case 'quiz.quitQuiz': return 'Quit Quiz?';
			case 'quiz.quitWarning': return 'Your progress will be lost if you quit now.';
			case 'quiz.continueQuiz': return 'Continue';
			case 'quiz.quit': return 'Quit';
			case 'quiz.levelUnlockedTitle': return '🎉 Congratulations!';
			case 'quiz.levelUnlockedDesc': return 'The next level has been successfully unlocked.';
			case 'quiz.levelUnlockedSub': return 'Keep learning to unlock more levels and improve your Japanese reading skills.';
			case 'quiz.continueLearning': return 'Continue Learning';
			case 'quiz.feedbackOutstanding': return '🌟 Outstanding!';
			case 'quiz.feedbackGreat': return '🎉 Great!';
			case 'quiz.feedbackGood': return '👍 Not Bad!';
			case 'quiz.feedbackPoor': return '📖 Let\'s Study Again!';
			case 'quiz.descOutstanding': return 'You mastered this material perfectly! Keep up the great work.';
			case 'quiz.descGreat': return 'Your understanding is very good. Just a little more practice for a perfect score!';
			case 'quiz.descGood': return 'You are starting to understand. Let\'s study more to improve fluency.';
			case 'quiz.descPoor': return 'Don\'t give up! Try reviewing the characters and quiz again for a better score.';
			case 'quiz.accuracy': return 'Accuracy';
			case 'quiz.totalQuestions': return 'Total';
			case 'quiz.startListeningQuiz': return 'START LISTENING QUIZ';
			case 'quiz.backToHome': return 'BACK TO HOME';
			case 'quiz.evaluationQuiz': return 'Evaluation Quiz';
			case 'quiz.quizHiragana': return 'Hiragana Quiz';
			case 'quiz.quizKatakana': return 'Katakana Quiz';
			case 'quiz.quizMixed': return 'Mixed Quiz';
			case 'quiz.descQuizHiragana': return 'Mixed quiz covering basic 46 Hiragana characters';
			case 'quiz.descQuizKatakana': return 'Mixed quiz covering basic 46 Katakana characters';
			case 'quiz.descQuizMixed': return 'Combination challenge of Hiragana & Katakana';
			case 'quiz.listeningQuizzes': return 'Listening Quizzes';
			case 'quiz.listeningQuizHiragana': return 'Hiragana Listening Quiz';
			case 'quiz.listeningQuizKatakana': return 'Katakana Listening Quiz';
			case 'quiz.listeningQuizMixed': return 'Mixed Listening Quiz';
			case 'quiz.descListeningHiragana': return 'Listening quiz covering basic 46 Hiragana characters';
			case 'quiz.descListeningKatakana': return 'Listening quiz covering basic 46 Katakana characters';
			case 'quiz.descListeningMixed': return 'Listening challenge of Hiragana & Katakana';
			case 'quiz.unlockPreviousQuiz': return 'Finish the previous quiz first';
			case 'quiz.countQuestions': return ({required Object count}) => '${count} questions';
			case 'quiz.estTime': return ({required Object time}) => '±${time} minutes';
			case 'quiz.difficultyMedium': return 'Medium';
			case 'quiz.difficultyHard': return 'Hard';
			case 'quiz.lockedStatus': return 'Locked';
			case 'quiz.audioType': return 'Audio';
			case 'progress.title': return 'Learning Progress Statistics';
			case 'progress.streak': return '{days} Day Streak';
			case 'progress.completed': return 'Completed';
			case 'progress.charactersLearned': return 'Characters Learned';
			case 'progress.learningProgress': return 'Learning Progress';
			case 'progress.studyReminders': return 'Study Reminders';
			case 'progress.totalUnlockedLevels': return 'Total Unlocked Levels';
			case 'progress.totalQuizzesCompleted': return 'Total Quizzes Completed';
			case 'progress.reminderActive': return ({required Object time}) => 'Daily study reminder scheduled at ${time} 🔔';
			case 'progress.reminderDisabled': return 'Study reminder disabled 🔕';
			case 'progress.reminderUpdated': return ({required Object time}) => 'Reminder time updated to ${time} ⏰';
			case 'progress.reminderLeft': return ({required Object hours, required Object minutes}) => '⏰ ${hours} hours ${minutes} minutes left';
			case 'progress.studyStreak': return 'Study Streak';
			case 'progress.daysInARow': return ({required Object days}) => '${days} Days in a Row!';
			case 'progress.enableAlarm': return 'Enable Alarm';
			case 'progress.studyTime': return 'Study Time';
			case 'progress.nextReminder': return 'Next Reminder';
			case 'progress.keepItUpMsg': return 'Keep up your learning spirit!';
			case 'progress.charactersCount': return ({required Object completed, required Object total}) => '${completed}/${total} characters';
			case 'profile.title': return 'My Profile';
			case 'profile.studyStatistics': return 'Study Statistics';
			case 'profile.appearance': return 'Appearance';
			case 'profile.more': return 'More';
			case 'profile.feedback': return 'Feedback';
			case 'profile.aboutApp': return 'About App';
			case 'profile.deleteAccount': return 'Delete Account';
			case 'profile.deleteAccountTitle': return 'Delete Account Permanently?';
			case 'profile.deleteAccountConfirmText': return 'This action cannot be undone. All your study progress, quiz history, streak, and learned characters will be permanently deleted from the system.';
			case 'profile.cancel': return 'Cancel';
			case 'profile.logout': return 'Log Out';
			case 'profile.logoutTitle': return 'Logout?';
			case 'profile.logoutConfirmText': return 'You need to login again to save your learning progress.';
			case 'profile.badgesEarned': return 'Badges Earned';
			case 'profile.deleteDataWarning': return 'All data will be lost permanently';
			case 'profile.hiraganaQuiz': return 'Hiragana Quiz';
			case 'profile.katakanaQuiz': return 'Katakana Quiz';
			case 'profile.defaultUserName': return 'HI KATA Learner';
			case 'profile.statistics.currentStreak': return 'Current Streak';
			case 'profile.statistics.bestStreak': return 'Best Streak';
			case 'profile.statistics.totalQuiz': return 'Total Quiz';
			case 'profile.statistics.highScore': return 'High Score';
			case 'profile.statistics.hiragana': return 'Hiragana';
			case 'profile.statistics.katakana': return 'Katakana';
			case 'profile.statistics.days': return 'Days';
			case 'profile.statistics.completed': return 'Completed';
			case 'profile.statistics.progress': return 'Progress';
			case 'profile.statistics.noQuizHistory': return 'No Quiz History';
			case 'profile.statistics.startFirstQuiz': return 'Let\'s start learning and take your first quiz!';
			case 'profile.chooseAvatar': return 'Choose New Avatar';
			case 'profile.achievements': return 'Quiz Achievements';
			case 'profile.mixedQuiz': return 'Mixed Quiz';
			case 'profile.joinedSince': return ({required Object date}) => 'Joined since ${date}';
			case 'settings.mixedQuiz': return 'Mixed Quiz';
			case 'settings.appearance': return 'App Appearance';
			case 'settings.lightMode': return 'Light Mode';
			case 'settings.darkMode': return 'Dark Mode';
			case 'settings.title': return 'Settings';
			case 'settings.theme': return 'App Theme';
			case 'settings.darkTheme': return 'Dark Mode';
			case 'settings.lightTheme': return 'Light Mode';
			case 'settings.systemTheme': return 'System';
			case 'settings.language': return 'Language';
			case 'settings.dailyNotification': return 'Daily Notification';
			case 'settings.notificationTime': return 'Notification Time';
			case 'notification.title': return 'Time to Study!';
			case 'notification.body': return 'Let\'s spend 5 minutes today to practice your Hiragana and Katakana.';
			case 'errors.general': return 'An error occurred. Please try again.';
			case 'errors.network': return 'Network connection error.';
			case 'language.title': return 'Select Language';
			case 'language.subtitle': return 'Choose Language';
			case 'language.changeAnytime': return 'You can change language anytime';
			case 'language.changeAnytimeEn': return 'You can change language anytime';
			case 'language.indonesian': return 'Bahasa Indonesia';
			case 'language.english': return 'English';
			case 'language.indonesianDesc': return 'Guide in Indonesian Language';
			case 'language.englishDesc': return 'Guide in English Language';
			case 'about.title': return 'About App';
			case 'about.description': return 'HI KATA helps you learn Hiragana and Katakana through interactive lessons, pronunciation audio, and engaging quizzes.';
			case 'about.version': return 'App Version';
			case 'about.developer': return 'App Developer';
			case 'goals.title': return 'Your Learning Goal';
			case 'goals.subtitle': return 'Let\'s set your daily learning target!';
			case 'goals.greatChoice': return 'Great choice! You are learning for: ';
			case 'goals.dailyTargetQuestion': return 'How much is your daily target?';
			case 'goals.startLearning': return 'START LEARNING';
			case 'goals.targetSet': return ({required Object name, required Object time}) => 'Daily target set to: ${name} (${time})🔥';
			case 'goals.goalRelaxed': return 'Relaxed';
			case 'goals.goalRegular': return 'Regular';
			case 'goals.goalSerious': return 'Serious';
			case 'goals.goalIntense': return 'Intense';
			case 'goals.time5m': return '5 mins / day';
			case 'goals.time10m': return '10 mins / day';
			case 'goals.time15m': return '15 mins / day';
			case 'goals.time20m': return '20 mins / day';
			case 'goals.descRelaxed': return 'Good for initial intro';
			case 'goals.descRegular': return 'Recommended for beginners';
			case 'goals.descSerious': return 'Fast learning progress';
			case 'goals.descIntense': return 'Maximum learning challenge';
			case 'goals.reasonSchool': return 'Education & School 🏫';
			case 'goals.reasonAnime': return 'Anime & Pop Culture 🍿';
			case 'goals.reasonWork': return 'Career & Work 💼';
			case 'goals.reasonTravel': return 'Tourism & Travelling ✈️';
			case 'goals.reasonSchoolTitle': return 'Education / School';
			case 'goals.reasonSchoolDesc': return 'For school assignments or formal courses';
			case 'goals.reasonAnimeTitle': return 'Anime & Pop Culture';
			case 'goals.reasonAnimeDesc': return 'So you can watch anime without subtitles';
			case 'goals.reasonWorkTitle': return 'Career & Work';
			case 'goals.reasonWorkDesc': return 'Preparing for a job or scholarship in Japan';
			case 'goals.reasonTravelTitle': return 'Tourism / Travelling';
			case 'goals.reasonTravelDesc': return 'Ease of communication during vacations';
			case 'goals.questionTitle': return 'Why are you interested in learning Japanese?';
			case 'goals.questionSubtitle': return 'Choose one of your main reasons for learning Japanese.';
			case 'goals.continueBtn': return 'CONTINUE';
			case 'feedback.title': return 'Learning Experience';
			case 'feedback.intro': return 'Your review highly helps our team in developing new features and improving study material quality in HI KATA.';
			case 'feedback.rateUs': return 'How would you rate us?';
			case 'feedback.firstImpression': return 'Choose your first impression';
			case 'feedback.commentHint': return 'Write your experience here...';
			case 'feedback.commentEmpty': return 'Comment cannot be empty';
			case 'feedback.submit': return 'SUBMIT REVIEW';
			case 'feedback.writeSuggestions': return 'Write comments & suggestions';
			case 'feedback.lastReview': return 'Your Last Review';
			case 'feedback.thanks': return 'Thank You! ❤️';
			case 'feedback.thanksBody': return 'Your review is highly valuable for the development of HI KATA!';
			case 'feedback.tags.fun': return 'Fun';
			case 'feedback.tags.easy': return 'Easy to Understand';
			case 'feedback.tags.helpful': return 'Very Helpful';
			case 'feedback.tags.improve': return 'Needs Improvement';
			default: return null;
		}
	}
}
