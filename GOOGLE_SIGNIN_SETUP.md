# دليل تفعيل Google Sign-In / Google Sign-In Setup Guide

## المشكلة / Problem

إذا ظهر لك خطأ `"Unsupported provider: provider is not enabled"` عند محاولة تسجيل الدخول عبر Google، فهذا يعني أن Google OAuth غير مفعّل في Supabase Dashboard.

## الحل / Solution

اتبع الخطوات التالية لتفعيل Google Sign-In:

---

## الخطوة 1: إعداد Google Cloud Console

### 1.1 إنشاء مشروع في Google Cloud

1. اذهب إلى [Google Cloud Console](https://console.cloud.google.com/)
2. اضغط على **"Select a project"** في الأعلى
3. اضغط **"New Project"**
4. أدخل اسم المشروع (مثلاً: `flutter-todo-app`)
5. اضغط **"Create"**

### 1.2 تفعيل Google+ API

1. في Google Cloud Console، اذهب إلى **APIs & Services** → **Library**
2. ابحث عن **"Google+ API"** أو **"Google Identity Services"**
3. اضغط على النتيجة
4. اضغط **"Enable"**

### 1.3 إنشاء OAuth 2.0 Credentials

1. اذهب إلى **APIs & Services** → **Credentials**
2. اضغط **"Create Credentials"** → **"OAuth 2.0 Client ID"**
3. إذا طُلب منك، اضغط **"Configure Consent Screen"**:
   - اختر **External** (للتطوير)
   - املأ المعلومات الأساسية:
     - App name: `Flutter Todo App`
     - User support email: بريدك الإلكتروني
     - Developer contact: بريدك الإلكتروني
   - اضغط **"Save and Continue"**
   - اضغط **"Save and Continue"** مرة أخرى (Scopes)
   - اضغط **"Save and Continue"** (Test users - يمكن تخطيه)
   - اضغط **"Back to Dashboard"**

4. الآن أنشئ OAuth Client ID:
   - Application type: اختر **Web application**
   - Name: `Supabase Auth`
   - Authorized redirect URIs: أضف:
     ```
     https://wwdbzpwoyoxhavatiaii.supabase.co/auth/v1/callback
     ```
     ⚠️ **مهم**: استبدل `wwdbzpwoyoxhavatiaii` بـ Project ID الخاص بك من Supabase
   - اضغط **"Create"**

5. **انسخ**:
   - **Client ID** (يبدأ بـ `xxxxx.apps.googleusercontent.com`)
   - **Client Secret** (سلسلة طويلة)

---

## الخطوة 2: تفعيل Google Provider في Supabase

### 2.1 تفعيل Provider

1. اذهب إلى [Supabase Dashboard](https://app.supabase.com)
2. اختر مشروعك
3. اذهب إلى **Authentication** → **Providers** (من القائمة الجانبية)
4. ابحث عن **Google** في القائمة
5. **فعّل** Toggle بجانب Google

### 2.2 إضافة Credentials

في نفس الصفحة (Authentication → Providers → Google):

1. الصق **Client ID** في حقل **Client ID (for OAuth)**
2. الصق **Client Secret** في حقل **Client Secret (for OAuth)**
3. اضغط **"Save"** أو سيتم الحفظ تلقائياً

### 2.3 التحقق من Redirect URL

تأكد من أن Redirect URL في Supabase يطابق ما أضفته في Google Cloud Console:
- في Supabase: **Authentication** → **URL Configuration**
- يجب أن يكون Redirect URL: `https://your-project-id.supabase.co/auth/v1/callback`

---

## الخطوة 3: اختبار Google Sign-In

1. شغّل التطبيق
2. اضغط على زر **"Sign in with Google"**
3. يجب أن يفتح المتصفح
4. اختر حساب Google
5. بعد الموافقة، يجب أن تعود إلى التطبيق وتسجّل الدخول تلقائياً

---

## ملاحظات مهمة / Important Notes

### للمحاكي/Simulator:

- Google Sign-In قد لا يعمل بشكل صحيح على المحاكي
- اختبر على جهاز حقيقي للحصول على أفضل نتائج

### للويب:

إذا كنت تختبر على الويب، يجب إضافة Redirect URL إضافي في Supabase:
- في **Authentication** → **URL Configuration**
- أضف Redirect URL: `http://localhost:3000/auth/callback` (أو رقم المنفذ الخاص بك)

### للتطبيق المحمول:

- يجب إعداد Deep Links بشكل صحيح
- Redirect URL الحالي: `io.supabase.fluttertodo://login-callback/`

---

## حل المشاكل الشائعة / Troubleshooting

### المشكلة: "Redirect URI mismatch"

**الحل**: 
- تأكد من أن Redirect URI في Google Cloud Console يطابق تماماً ما في Supabase
- يجب أن يكون: `https://your-project-id.supabase.co/auth/v1/callback`

### المشكلة: "Invalid client"

**الحل**:
- تحقق من أن Client ID و Client Secret صحيحة
- تأكد من نسخها بدون مسافات إضافية

### المشكلة: "Access blocked"

**الحل**:
- في Google Cloud Console → OAuth consent screen
- تأكد من أن Consent Screen مفعّل
- أضف حسابك في "Test users" إذا كان المشروع في وضع Testing

---

## الخطوات السريعة / Quick Steps

1. ✅ Google Cloud Console → إنشاء OAuth Client ID
2. ✅ نسخ Client ID و Client Secret
3. ✅ Supabase Dashboard → Authentication → Providers → Google
4. ✅ تفعيل Google Provider
5. ✅ إضافة Client ID و Client Secret
6. ✅ حفظ
7. ✅ اختبار في التطبيق

---

**بعد تفعيل Google Sign-In، يجب أن يعمل بشكل صحيح!** ✅

