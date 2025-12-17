# تعليمات الإعداد الكاملة / Complete Setup Instructions

## 📋 قائمة التحقق / Checklist

### ✅ ما تم تسليمه / What's Delivered:

- [x] جميع ملفات Flutter جاهزة للتشغيل
- [x] `pubspec.yaml` مع جميع التبعيات
- [x] `supabase_migration.sql` - ملف SQL كامل
- [x] README شامل بالعربية والإنجليزية
- [x] بنية مشروع منظمة (models, providers, screens, services, widgets)
- [x] Profile/Settings Screen مع Dark Mode
- [x] Google Sign-In (اختياري)
- [x] معالجة أخطاء محسنة
- [x] Real-time sync مع Supabase Realtime
- [x] RLS Policies للأمان

---

## 🚀 الأوامر المطلوبة / Required Commands

### 1. إعداد Flutter / Flutter Setup

```bash
# الانتقال إلى مجلد المشروع
cd flutter_todo_supabase

# تثبيت التبعيات
flutter pub get

# التحقق من الإعدادات (اختياري)
flutter doctor

# عرض الأجهزة المتاحة
flutter devices
```

### 2. إنشاء ملف .env

```bash
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

ثم عدّل `.env` وأضف بيانات Supabase:

```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

### 3. تشغيل التطبيق / Run App

```bash
# على Android
flutter run

# على iOS (macOS فقط)
flutter run

# على جهاز محدد
flutter run -d <device-id>
```

### 4. بناء للتوزيع / Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (لـ Google Play)
flutter build appbundle --release

# iOS (macOS فقط)
flutter build ios --release
```

---

## 🔧 إعداد Supabase من الصفر (خطوة بخطوة)

### الخطوة 1: إنشاء حساب ومشروع

1. اذهب إلى [app.supabase.com](https://app.supabase.com)
2. اضغط **"Sign Up"** أو **"Log In"** إذا كان لديك حساب
3. بعد تسجيل الدخول، اضغط على **"New Project"** (أزرار خضراء كبيرة في المنتصف)
4. املأ المعلومات:
   - **Name**: `flutter-todo` (أو أي اسم تفضله)
   - **Database Password**: أنشئ كلمة مرور قوية واحفظها (ستحتاجها لاحقاً)
   - **Region**: اختر المنطقة الأقرب إليك (مثلاً: `West US (California)`)
5. اضغط **"Create new project"**
6. انتظر 1-2 دقيقة حتى يتم إنشاء المشروع (ستظهر شاشة Loading)

### الخطوة 2: الحصول على بيانات الاتصال

1. بعد اكتمال الإنشاء، ستظهر لوحة التحكم (Dashboard)
2. في القائمة الجانبية اليسرى، اضغط على **Settings** (رمز الترس ⚙️ في الأسفل)
3. من القائمة الفرعية، اضغط على **API**
4. ستجد قسمين مهمين:
   - **Project URL**: انسخه (مثل: `https://abcdefghijklmnop.supabase.co`)
   - **anon public** key: انسخه (سلسلة طويلة تبدأ بـ `eyJhbG...`)

### الخطوة 3: إضافة البيانات إلى ملف .env

1. افتح ملف `.env` في مجلد المشروع (أنشئه إذا لم يكن موجوداً)
2. الصق البيانات كما يلي:

```env
SUPABASE_URL=https://abcdefghijklmnop.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYxNjIzOTAyMiwiZXhwIjoxOTMxODE1MDIyfQ.example-key
```

⚠️ **مهم**: استبدل القيم بأرقامك الحقيقية من Supabase Dashboard!

### الخطوة 4: إنشاء جدول المهام

1. في Supabase Dashboard، اضغط على **SQL Editor** من القائمة الجانبية (رمز الطرفية/Terminal 📟)
2. اضغط على **"New query"** (أزرار في الأعلى)
3. افتح ملف `supabase_migration.sql` من مجلد المشروع
4. انسخ **كل** محتوى الملف (يمكنك الضغط Ctrl+A ثم Ctrl+C)
5. الصقه في محرر SQL في Supabase
6. اضغط على زر **"Run"** (أو اضغط Ctrl+Enter)
7. يجب أن ترى رسالة نجاح في الأسفل: ✅ "Success. No rows returned"

**ماذا يفعل هذا الملف؟**
- ينشئ جدول `tasks` مع الأعمدة المطلوبة
- يفعل Row Level Security (RLS)
- ينشئ 4 سياسات أمان:
  - المستخدمون يمكنهم قراءة مهامهم فقط
  - المستخدمون يمكنهم إضافة مهامهم فقط
  - المستخدمون يمكنهم تحديث مهامهم فقط
  - المستخدمون يمكنهم حذف مهامهم فقط

### الخطوة 5: تفعيل Realtime (مهم جداً!)

1. في Supabase Dashboard، اضغط على **Database** (رمز الأسطوانة 💾)
2. من القائمة الفرعية، اضغط على **Replication**
3. في صفحة Replication، ستجد قسم **"Source"**
4. اضغط على **"0 tables"** (أو عدد الجداول إذا كان موجوداً)
5. ستظهر قائمة بجميع الجداول
6. فعّل المفتاح (Toggle) 🔄 بجانب **public.tasks**
7. اضغط **Save** أو سيتم الحفظ تلقائياً

✅ **الآن التطبيق يمكنه الاستماع للتغييرات في الوقت الفعلي!**

### الخطوة 6: التحقق من الإعدادات

1. في Supabase Dashboard -> **Table Editor** -> اختر جدول `tasks`
2. يجب أن ترى الجدول فارغاً (طبيعي - لم نضف مهام بعد)
3. في **Authentication** -> **Users**، يمكنك رؤية المستخدمين المسجلين لاحقاً

---

## 🔐 إعداد Google Sign-In (اختياري)

### في Supabase Dashboard:

1. اذهب إلى **Authentication** -> **Providers**
2. ابحث عن **Google** في القائمة
3. اضغط على **Toggle** لتفعيله
4. ستحتاج إلى **Client ID** و **Client Secret** من Google Cloud

### في Google Cloud Console:

1. اذهب إلى [console.cloud.google.com](https://console.cloud.google.com)
2. أنشئ مشروع جديد أو اختر موجود
3. فعّل **Google+ API** (أو Google Identity Services)
4. اذهب إلى **APIs & Services** -> **Credentials**
5. اضغط **Create Credentials** -> **OAuth 2.0 Client ID**
6. اختر **Web application**
7. أضف **Authorized redirect URIs**:
   ```
   https://<your-project-id>.supabase.co/auth/v1/callback
   ```
   (استبدل `<your-project-id>` بـ Project ID الخاص بك)
8. انسخ **Client ID** و **Client Secret**
9. الصقهما في Supabase Dashboard -> Authentication -> Providers -> Google
10. احفظ التغييرات

### في التطبيق:

الكود موجود بالفعل! فقط:
- تأكد من إعداد OAuth في Supabase كما هو موضح أعلاه
- زر Google Sign-In موجود في شاشة تسجيل الدخول
- عند الضغط، سيتم فتح المتصفح للمصادقة

---

## 🧪 اختبار Backend من المتصفح

### 1. الحصول على JWT Token:

افتح Terminal/Command Prompt واكتب:

```bash
curl -X POST 'https://<your-project-id>.supabase.co/auth/v1/token?grant_type=password' \
  -H "apikey: <your-anon-key>" \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"your-password"}'
```

استبدل:
- `<your-project-id>` بـ Project ID
- `<your-anon-key>` بـ anon key
- `test@example.com` و `your-password` ببيانات مستخدم مسجل

ستحصل على response يحتوي على `access_token` - انسخه.

### 2. الحصول على المهام:

```bash
curl 'https://<your-project-id>.supabase.co/rest/v1/tasks?select=*' \
  -H "apikey: <your-anon-key>" \
  -H "Authorization: Bearer <access-token-from-step-1>"
```

يجب أن ترى المهام (إن وجدت) في شكل JSON.

### 3. عرض المستخدمين:

- اذهب إلى Supabase Dashboard -> **Authentication** -> **Users**
- يمكنك رؤية جميع المستخدمين المسجلين

---

## 📱 بناء وإصدار التطبيق / Building & Releasing

### Android:

#### 1. إنشاء Keystore:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

احفظ كلمة المرور في مكان آمن!

#### 2. تكوين Android:

أنشئ ملف `android/key.properties`:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=upload
storeFile=<path-to-keystore>
```

#### 3. تحديث build.gradle:

في `android/app/build.gradle`، أضف:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

#### 4. بناء App Bundle:

```bash
flutter build appbundle --release
```

#### 5. رفع إلى Google Play:

- اذهب إلى [play.google.com/console](https://play.google.com/console)
- أنشئ تطبيق جديد
- ارفع ملف `.aab` من `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS فقط):

```bash
# بناء للتوزيع
flutter build ios --release

# ثم افتح Xcode
open ios/Runner.xcworkspace

# في Xcode: Product -> Archive -> Distribute App
```

---

## ⚠️ ملاحظات الأمان / Security Notes

1. **Anon Key**: آمن للاستخدام في تطبيقات الهاتف المحمول **طالما** أن RLS مفعّل (وهو كذلك)
2. **RLS Policies**: تضمن أن المستخدمين يمكنهم الوصول إلى مهامهم فقط
3. **لا تحفظ Service Role Key** في التطبيق - هذا المفتاح لديه صلاحيات كاملة!
4. للبيانات الحساسة جداً، استخدم Edge Functions أو Proxy Server

---

## 🐛 حل المشاكل / Troubleshooting

### مشكلة: التطبيق لا يتصل بـ Supabase

**الحل:**
- تحقق من ملف `.env` - يجب أن يحتوي على قيم صحيحة
- تأكد من نسخ القيم من Supabase Dashboard -> Settings -> API
- أعد تشغيل التطبيق بعد تعديل `.env`

### مشكلة: Real-time لا يعمل

**الحل:**
- تأكد من تفعيل Realtime في Supabase Dashboard -> Database -> Replication
- تأكد من تفعيل جدول `public.tasks`
- أعد تشغيل التطبيق

### مشكلة: خطأ في RLS

**الحل:**
- تأكد من تطبيق ملف SQL migration بشكل صحيح
- تحقق من السياسات في Supabase Dashboard -> Authentication -> Policies
- تأكد من وجود 4 سياسات على الأقل لجدول `tasks`

### مشكلة: Google Sign-In لا يعمل

**الحل:**
- تأكد من إعداد OAuth في Supabase Dashboard
- تحقق من Redirect URL في Google Cloud Console
- تأكد من تفعيل Google Provider في Supabase
- تحقق من Client ID و Client Secret

---

## 📚 موارد إضافية / Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Supabase Flutter Package](https://pub.dev/packages/supabase_flutter)

---

**تم إنشاؤه بـ ❤️ - جاهز للتشغيل!**

