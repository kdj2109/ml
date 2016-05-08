; ModuleID = 'arrays.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

%"class.std::__1::basic_ostream" = type { i32 (...)**, %"class.std::__1::basic_ios.base" }
%"class.std::__1::basic_ios.base" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32 }>
%"class.std::__1::ios_base" = type { i32 (...)**, i32, i64, i64, i32, i32, i8*, i8*, void (i32, %"class.std::__1::ios_base"*, i32)**, i32*, i64, i64, i64*, i64, i64, i8**, i64, i64 }
%"class.std::__1::locale::id" = type <{ %"struct.std::__1::once_flag", i32, [4 x i8] }>
%"struct.std::__1::once_flag" = type { i64 }
%"class.std::__1::ctype" = type <{ %"class.std::__1::locale::facet", i32*, i8, [7 x i8] }>
%"class.std::__1::locale::facet" = type { %"class.std::__1::__shared_count" }
%"class.std::__1::__shared_count" = type { i32 (...)**, i64 }
%"class.std::__1::locale" = type { %"class.std::__1::locale::__imp"* }
%"class.std::__1::locale::__imp" = type opaque
%"class.std::__1::basic_ios" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32, [4 x i8] }>
%"class.std::__1::ostreambuf_iterator" = type { %"class.std::__1::basic_streambuf"* }
%"class.std::__1::basic_streambuf" = type { i32 (...)**, %"class.std::__1::locale", i8*, i8*, i8*, i8*, i8*, i8* }
%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry" = type { i8, %"class.std::__1::basic_ostream"* }
%"struct.std::__1::iterator" = type { i8 }
%"struct.std::__1::nullptr_t" = type { i8* }
%"class.std::__1::allocator" = type { i8 }
%"class.std::__1::__libcpp_compressed_pair_imp" = type { %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep" }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep" = type { %union.anon }
%union.anon = type { %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long" }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long" = type { i64, i64, i8* }
%"class.std::__1::__compressed_pair" = type { %"class.std::__1::__libcpp_compressed_pair_imp" }
%"class.std::__1::basic_string" = type { %"class.std::__1::__compressed_pair" }
%"class.std::__1::__basic_string_common" = type { i8 }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short" = type { %union.anon.0, [23 x i8] }
%union.anon.0 = type { i8 }

@_ZZ4mainE7balance = private unnamed_addr constant [5 x i32] [i32 1000, i32 2, i32 3, i32 17, i32 50], align 16
@_ZNSt3__14coutE = external global %"class.std::__1::basic_ostream", align 8
@_ZNSt3__15ctypeIcE2idE = external global %"class.std::__1::locale::id", align 8

; Function Attrs: nounwind ssp uwtable
define i32 @_Z9addTuplesPi(i32* %a) #0 {
  %1 = alloca i32*, align 8
  store i32* %a, i32** %1, align 8
  %2 = load i32*, i32** %1, align 8
  %3 = getelementptr inbounds i32, i32* %2, i64 0
  %4 = load i32, i32* %3, align 4
  ret i32 %4
}

; Function Attrs: ssp uwtable
define i32 @main() #1 {
  %1 = alloca i32, align 4
  %balance = alloca [5 x i32], align 16
  %x = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = bitcast [5 x i32]* %balance to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* bitcast ([5 x i32]* @_ZZ4mainE7balance to i8*), i64 20, i32 16, i1 false)
  %3 = getelementptr inbounds [5 x i32], [5 x i32]* %balance, i32 0, i32 0
  %4 = call i32 @_Z9addTuplesPi(i32* %3)
  store i32 %4, i32* %x, align 4
  %5 = load i32, i32* %x, align 4
  %6 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi(%"class.std::__1::basic_ostream"* @_ZNSt3__14coutE, i32 %5)
  %7 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_c(%"class.std::__1::basic_ostream"* dereferenceable(160) %6, i8 signext 10)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: ssp uwtable
define linkonce_odr dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_c(%"class.std::__1::basic_ostream"* dereferenceable(160) %__os, i8 signext %__c) #1 {
  %1 = alloca %"class.std::__1::basic_ostream"*, align 8
  %2 = alloca i8, align 1
  store %"class.std::__1::basic_ostream"* %__os, %"class.std::__1::basic_ostream"** %1, align 8
  store i8 %__c, i8* %2, align 1
  %3 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %1, align 8
  %4 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* dereferenceable(160) %3, i8* %2, i64 1)
  ret %"class.std::__1::basic_ostream"* %4
}

declare dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi(%"class.std::__1::basic_ostream"*, i32) #3

; Function Attrs: ssp uwtable
define linkonce_odr dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* dereferenceable(160) %__os, i8* %__str, i64 %__len) #1 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %1 = alloca %"class.std::__1::ctype"*, align 8
  %2 = alloca i8, align 1
  %3 = alloca %"class.std::__1::locale"*, align 8
  %4 = alloca %"class.std::__1::basic_ios"*, align 8
  %5 = alloca i8, align 1
  %6 = alloca %"class.std::__1::locale", align 8
  %7 = alloca i8*
  %8 = alloca i32
  %9 = alloca %"class.std::__1::basic_ios"*, align 8
  %10 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %11 = alloca %"class.std::__1::ios_base"*, align 8
  %12 = alloca %"class.std::__1::ios_base"*, align 8
  %13 = alloca i32, align 4
  %14 = alloca %"class.std::__1::basic_ios"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca %"class.std::__1::ios_base"*, align 8
  %17 = alloca %"class.std::__1::basic_ios"*, align 8
  %18 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %19 = alloca %"class.std::__1::basic_ostream"*, align 8
  %20 = alloca i8*
  %21 = alloca i32
  %22 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %23 = alloca %"class.std::__1::basic_ostream"*, align 8
  %24 = alloca %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, align 8
  %25 = alloca %"class.std::__1::basic_ostream"*, align 8
  %26 = alloca i8*, align 8
  %27 = alloca i64, align 8
  %__s = alloca %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry", align 8
  %28 = alloca i8*
  %29 = alloca i32
  %30 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %31 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  store %"class.std::__1::basic_ostream"* %__os, %"class.std::__1::basic_ostream"** %25, align 8
  store i8* %__str, i8** %26, align 8
  store i64 %__len, i64* %27, align 8
  %32 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  invoke void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s, %"class.std::__1::basic_ostream"* dereferenceable(160) %32)
          to label %33 unwind label %171

; <label>:33                                      ; preds = %0
  store %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s, %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"** %24, align 8
  %34 = load %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"** %24, align 8
  %35 = getelementptr inbounds %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry", %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %34, i32 0, i32 0
  %36 = load i8, i8* %35, align 8
  %37 = trunc i8 %36 to i1
  br label %38

; <label>:38                                      ; preds = %33
  br i1 %37, label %39, label %180

; <label>:39                                      ; preds = %38
  %40 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  store %"class.std::__1::ostreambuf_iterator"* %30, %"class.std::__1::ostreambuf_iterator"** %22, align 8
  store %"class.std::__1::basic_ostream"* %40, %"class.std::__1::basic_ostream"** %23, align 8
  %41 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %22, align 8
  %42 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %23, align 8
  store %"class.std::__1::ostreambuf_iterator"* %41, %"class.std::__1::ostreambuf_iterator"** %18, align 8
  store %"class.std::__1::basic_ostream"* %42, %"class.std::__1::basic_ostream"** %19, align 8
  %43 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %18, align 8
  %44 = bitcast %"class.std::__1::ostreambuf_iterator"* %43 to %"struct.std::__1::iterator"*
  %45 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %43, i32 0, i32 0
  %46 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %19, align 8
  %47 = bitcast %"class.std::__1::basic_ostream"* %46 to i8**
  %48 = load i8*, i8** %47, align 8
  %49 = getelementptr i8, i8* %48, i64 -24
  %50 = bitcast i8* %49 to i64*
  %51 = load i64, i64* %50, align 8
  %52 = bitcast %"class.std::__1::basic_ostream"* %46 to i8*
  %53 = getelementptr inbounds i8, i8* %52, i64 %51
  %54 = bitcast i8* %53 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %54, %"class.std::__1::basic_ios"** %17, align 8
  %55 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %17, align 8
  %56 = bitcast %"class.std::__1::basic_ios"* %55 to %"class.std::__1::ios_base"*
  store %"class.std::__1::ios_base"* %56, %"class.std::__1::ios_base"** %16, align 8
  %57 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %16, align 8
  %58 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %57, i32 0, i32 6
  %59 = load i8*, i8** %58, align 8
  %60 = bitcast i8* %59 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %60, %"class.std::__1::basic_streambuf"** %45, align 8
  %61 = load i8*, i8** %26, align 8
  %62 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  %63 = bitcast %"class.std::__1::basic_ostream"* %62 to i8**
  %64 = load i8*, i8** %63, align 8
  %65 = getelementptr i8, i8* %64, i64 -24
  %66 = bitcast i8* %65 to i64*
  %67 = load i64, i64* %66, align 8
  %68 = bitcast %"class.std::__1::basic_ostream"* %62 to i8*
  %69 = getelementptr inbounds i8, i8* %68, i64 %67
  %70 = bitcast i8* %69 to %"class.std::__1::ios_base"*
  store %"class.std::__1::ios_base"* %70, %"class.std::__1::ios_base"** %11, align 8
  %71 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %11, align 8
  %72 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %71, i32 0, i32 1
  %73 = load i32, i32* %72, align 8
  br label %74

; <label>:74                                      ; preds = %39
  %75 = and i32 %73, 176
  %76 = icmp eq i32 %75, 32
  br i1 %76, label %77, label %81

; <label>:77                                      ; preds = %74
  %78 = load i8*, i8** %26, align 8
  %79 = load i64, i64* %27, align 8
  %80 = getelementptr inbounds i8, i8* %78, i64 %79
  br label %83

; <label>:81                                      ; preds = %74
  %82 = load i8*, i8** %26, align 8
  br label %83

; <label>:83                                      ; preds = %81, %77
  %84 = phi i8* [ %80, %77 ], [ %82, %81 ]
  %85 = load i8*, i8** %26, align 8
  %86 = load i64, i64* %27, align 8
  %87 = getelementptr inbounds i8, i8* %85, i64 %86
  %88 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  %89 = bitcast %"class.std::__1::basic_ostream"* %88 to i8**
  %90 = load i8*, i8** %89, align 8
  %91 = getelementptr i8, i8* %90, i64 -24
  %92 = bitcast i8* %91 to i64*
  %93 = load i64, i64* %92, align 8
  %94 = bitcast %"class.std::__1::basic_ostream"* %88 to i8*
  %95 = getelementptr inbounds i8, i8* %94, i64 %93
  %96 = bitcast i8* %95 to %"class.std::__1::ios_base"*
  %97 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  %98 = bitcast %"class.std::__1::basic_ostream"* %97 to i8**
  %99 = load i8*, i8** %98, align 8
  %100 = getelementptr i8, i8* %99, i64 -24
  %101 = bitcast i8* %100 to i64*
  %102 = load i64, i64* %101, align 8
  %103 = bitcast %"class.std::__1::basic_ostream"* %97 to i8*
  %104 = getelementptr inbounds i8, i8* %103, i64 %102
  %105 = bitcast i8* %104 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %105, %"class.std::__1::basic_ios"** %9, align 8
  %106 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %9, align 8
  %107 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #6
  %108 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %106, i32 0, i32 2
  %109 = load i32, i32* %108, align 8
  %110 = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %107, i32 %109) #6
  br i1 %110, label %111, label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit

; <label>:111                                     ; preds = %83
  store %"class.std::__1::basic_ios"* %106, %"class.std::__1::basic_ios"** %4, align 8
  store i8 32, i8* %5, align 1
  %112 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %4, align 8
  %113 = bitcast %"class.std::__1::basic_ios"* %112 to %"class.std::__1::ios_base"*
  invoke void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret %6, %"class.std::__1::ios_base"* %113)
          to label %.noexc unwind label %175

.noexc:                                           ; preds = %111
  store %"class.std::__1::locale"* %6, %"class.std::__1::locale"** %3, align 8
  %114 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %3, align 8
  %115 = invoke %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* %114, %"class.std::__1::locale::id"* dereferenceable(16) @_ZNSt3__15ctypeIcE2idE)
          to label %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i unwind label %125

_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i: ; preds = %.noexc
  %116 = bitcast %"class.std::__1::locale::facet"* %115 to %"class.std::__1::ctype"*
  %117 = load i8, i8* %5, align 1
  store %"class.std::__1::ctype"* %116, %"class.std::__1::ctype"** %1, align 8
  store i8 %117, i8* %2, align 1
  %118 = load %"class.std::__1::ctype"*, %"class.std::__1::ctype"** %1, align 8
  %119 = bitcast %"class.std::__1::ctype"* %118 to i8 (%"class.std::__1::ctype"*, i8)***
  %120 = load i8 (%"class.std::__1::ctype"*, i8)**, i8 (%"class.std::__1::ctype"*, i8)*** %119, align 8
  %121 = getelementptr inbounds i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %120, i64 7
  %122 = load i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %121, align 8
  %123 = load i8, i8* %2, align 1
  %124 = invoke signext i8 %122(%"class.std::__1::ctype"* %118, i8 signext %123)
          to label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i unwind label %125

; <label>:125                                     ; preds = %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i, %.noexc
  %126 = landingpad { i8*, i32 }
          cleanup
          catch i8* null
  %127 = extractvalue { i8*, i32 } %126, 0
  store i8* %127, i8** %7, align 8
  %128 = extractvalue { i8*, i32 } %126, 1
  store i32 %128, i32* %8, align 4
  invoke void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %6)
          to label %129 unwind label %134

; <label>:129                                     ; preds = %125
  %130 = load i8*, i8** %7, align 8
  %131 = load i32, i32* %8, align 4
  %132 = insertvalue { i8*, i32 } undef, i8* %130, 0
  %133 = insertvalue { i8*, i32 } %132, i32 %131, 1
  br label %.body

; <label>:134                                     ; preds = %125
  %135 = landingpad { i8*, i32 }
          catch i8* null
          catch i8* null
  %136 = extractvalue { i8*, i32 } %135, 0
  call void @__clang_call_terminate(i8* %136) #7
  unreachable

_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i: ; preds = %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i
  invoke void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %6)
          to label %.noexc1 unwind label %175

.noexc1:                                          ; preds = %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i
  %137 = sext i8 %124 to i32
  %138 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %106, i32 0, i32 2
  store i32 %137, i32* %138, align 8
  br label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit

_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit: ; preds = %83, %.noexc1
  %139 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %106, i32 0, i32 2
  %140 = load i32, i32* %139, align 8
  %141 = trunc i32 %140 to i8
  br label %142

; <label>:142                                     ; preds = %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit
  %143 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %30, i32 0, i32 0
  %144 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %143, align 8
  %145 = invoke %"class.std::__1::basic_streambuf"* @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(%"class.std::__1::basic_streambuf"* %144, i8* %61, i8* %84, i8* %87, %"class.std::__1::ios_base"* dereferenceable(136) %96, i8 signext %141)
          to label %146 unwind label %175

; <label>:146                                     ; preds = %142
  %147 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %31, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* %145, %"class.std::__1::basic_streambuf"** %147, align 8
  store %"class.std::__1::ostreambuf_iterator"* %31, %"class.std::__1::ostreambuf_iterator"** %10, align 8
  %148 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %10, align 8
  %149 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %148, i32 0, i32 0
  %150 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %149, align 8
  %151 = icmp eq %"class.std::__1::basic_streambuf"* %150, null
  br i1 %151, label %152, label %179

; <label>:152                                     ; preds = %146
  %153 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  %154 = bitcast %"class.std::__1::basic_ostream"* %153 to i8**
  %155 = load i8*, i8** %154, align 8
  %156 = getelementptr i8, i8* %155, i64 -24
  %157 = bitcast i8* %156 to i64*
  %158 = load i64, i64* %157, align 8
  %159 = bitcast %"class.std::__1::basic_ostream"* %153 to i8*
  %160 = getelementptr inbounds i8, i8* %159, i64 %158
  %161 = bitcast i8* %160 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %161, %"class.std::__1::basic_ios"** %14, align 8
  store i32 5, i32* %15, align 4
  %162 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %14, align 8
  %163 = bitcast %"class.std::__1::basic_ios"* %162 to %"class.std::__1::ios_base"*
  %164 = load i32, i32* %15, align 4
  store %"class.std::__1::ios_base"* %163, %"class.std::__1::ios_base"** %12, align 8
  store i32 %164, i32* %13, align 4
  %165 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %12, align 8
  %166 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %165, i32 0, i32 4
  %167 = load i32, i32* %166, align 8
  %168 = load i32, i32* %13, align 4
  %169 = or i32 %167, %168
  invoke void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* %165, i32 %169)
          to label %_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit unwind label %175

_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit: ; preds = %152
  br label %170

; <label>:170                                     ; preds = %_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit
  br label %179

; <label>:171                                     ; preds = %180, %0
  %172 = landingpad { i8*, i32 }
          catch i8* null
  %173 = extractvalue { i8*, i32 } %172, 0
  store i8* %173, i8** %28, align 8
  %174 = extractvalue { i8*, i32 } %172, 1
  store i32 %174, i32* %29, align 4
  br label %183

; <label>:175                                     ; preds = %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i, %111, %152, %142
  %176 = landingpad { i8*, i32 }
          catch i8* null
  br label %.body

.body:                                            ; preds = %129, %175
  %eh.lpad-body = phi { i8*, i32 } [ %176, %175 ], [ %133, %129 ]
  %177 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  store i8* %177, i8** %28, align 8
  %178 = extractvalue { i8*, i32 } %eh.lpad-body, 1
  store i32 %178, i32* %29, align 4
  invoke void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s)
          to label %182 unwind label %208

; <label>:179                                     ; preds = %170, %146
  br label %180

; <label>:180                                     ; preds = %179, %38
  invoke void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s)
          to label %181 unwind label %171

; <label>:181                                     ; preds = %180
  br label %196

; <label>:182                                     ; preds = %.body
  br label %183

; <label>:183                                     ; preds = %182, %171
  %184 = load i8*, i8** %28, align 8
  %185 = call i8* @__cxa_begin_catch(i8* %184) #6
  %186 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  %187 = bitcast %"class.std::__1::basic_ostream"* %186 to i8**
  %188 = load i8*, i8** %187, align 8
  %189 = getelementptr i8, i8* %188, i64 -24
  %190 = bitcast i8* %189 to i64*
  %191 = load i64, i64* %190, align 8
  %192 = bitcast %"class.std::__1::basic_ostream"* %186 to i8*
  %193 = getelementptr inbounds i8, i8* %192, i64 %191
  %194 = bitcast i8* %193 to %"class.std::__1::ios_base"*
  invoke void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"* %194)
          to label %195 unwind label %198

; <label>:195                                     ; preds = %183
  call void @__cxa_end_catch()
  br label %196

; <label>:196                                     ; preds = %195, %181
  %197 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %25, align 8
  ret %"class.std::__1::basic_ostream"* %197

; <label>:198                                     ; preds = %183
  %199 = landingpad { i8*, i32 }
          cleanup
  %200 = extractvalue { i8*, i32 } %199, 0
  store i8* %200, i8** %28, align 8
  %201 = extractvalue { i8*, i32 } %199, 1
  store i32 %201, i32* %29, align 4
  invoke void @__cxa_end_catch()
          to label %202 unwind label %208

; <label>:202                                     ; preds = %198
  br label %203

; <label>:203                                     ; preds = %202
  %204 = load i8*, i8** %28, align 8
  %205 = load i32, i32* %29, align 4
  %206 = insertvalue { i8*, i32 } undef, i8* %204, 0
  %207 = insertvalue { i8*, i32 } %206, i32 %205, 1
  resume { i8*, i32 } %207

; <label>:208                                     ; preds = %198, %.body
  %209 = landingpad { i8*, i32 }
          catch i8* null
  %210 = extractvalue { i8*, i32 } %209, 0
  call void @__clang_call_terminate(i8* %210) #7
  unreachable
}

declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, %"class.std::__1::basic_ostream"* dereferenceable(160)) #3

declare i32 @__gxx_personality_v0(...)

; Function Attrs: ssp uwtable
define linkonce_odr hidden %"class.std::__1::basic_streambuf"* @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(%"class.std::__1::basic_streambuf"* %__s.coerce, i8* %__ob, i8* %__op, i8* %__oe, %"class.std::__1::ios_base"* dereferenceable(136) %__iob, i8 signext %__fl) #1 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %1 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %2 = alloca %"class.std::__1::allocator"*, align 8
  %3 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %4 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %5 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %6 = alloca %"class.std::__1::basic_string"*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8, align 1
  %9 = alloca %"class.std::__1::basic_string"*, align 8
  %10 = alloca i64, align 8
  %11 = alloca i8, align 1
  %12 = alloca i8*, align 8
  %13 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %14 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %15 = alloca %"class.std::__1::basic_string"*, align 8
  %16 = alloca i8*, align 8
  %17 = alloca i8*, align 8
  %18 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %19 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %20 = alloca %"class.std::__1::basic_string"*, align 8
  %21 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %22 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %23 = alloca %"class.std::__1::basic_string"*, align 8
  %24 = alloca %"class.std::__1::basic_string"*, align 8
  %25 = alloca %"class.std::__1::basic_string"*, align 8
  %26 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %27 = alloca i64, align 8
  %28 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %29 = alloca i64, align 8
  %30 = alloca %"struct.std::__1::nullptr_t", align 8
  %31 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %32 = alloca i8*, align 8
  %33 = alloca i64, align 8
  %34 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %35 = alloca i8*, align 8
  %36 = alloca i64, align 8
  %37 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %38 = alloca i64, align 8
  %39 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %40 = alloca i64, align 8
  %41 = alloca %"struct.std::__1::nullptr_t", align 8
  %42 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %43 = alloca %"class.std::__1::ios_base"*, align 8
  %44 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %45 = alloca i8*, align 8
  %46 = alloca i64, align 8
  %47 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %48 = alloca i64, align 8
  %49 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %50 = alloca i64, align 8
  %51 = alloca %"struct.std::__1::nullptr_t", align 8
  %52 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %53 = alloca %"class.std::__1::ios_base"*, align 8
  %54 = alloca i64, align 8
  %__r.i = alloca i64, align 8
  %55 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %56 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %57 = alloca i64, align 8
  %58 = alloca %"struct.std::__1::nullptr_t"*, align 8
  %59 = alloca i64, align 8
  %60 = alloca %"struct.std::__1::nullptr_t", align 8
  %61 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %__s = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %62 = alloca i8*, align 8
  %63 = alloca i8*, align 8
  %64 = alloca i8*, align 8
  %65 = alloca %"class.std::__1::ios_base"*, align 8
  %66 = alloca i8, align 1
  %67 = alloca %"struct.std::__1::nullptr_t", align 8
  %__sz = alloca i64, align 8
  %__ns = alloca i64, align 8
  %__np = alloca i64, align 8
  %68 = alloca %"struct.std::__1::nullptr_t", align 8
  %__sp = alloca %"class.std::__1::basic_string", align 8
  %69 = alloca i8*
  %70 = alloca i32
  %71 = alloca %"struct.std::__1::nullptr_t", align 8
  %72 = alloca i32
  %73 = alloca %"struct.std::__1::nullptr_t", align 8
  %74 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* %__s.coerce, %"class.std::__1::basic_streambuf"** %74, align 8
  store i8* %__ob, i8** %62, align 8
  store i8* %__op, i8** %63, align 8
  store i8* %__oe, i8** %64, align 8
  store %"class.std::__1::ios_base"* %__iob, %"class.std::__1::ios_base"** %65, align 8
  store i8 %__fl, i8* %66, align 1
  %75 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %76 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %75, align 8
  store %"struct.std::__1::nullptr_t"* %60, %"struct.std::__1::nullptr_t"** %58, align 8
  store i64 -1, i64* %59, align 8
  %77 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %58, align 8
  %78 = load i64, i64* %59, align 8
  store %"struct.std::__1::nullptr_t"* %77, %"struct.std::__1::nullptr_t"** %56, align 8
  store i64 %78, i64* %57, align 8
  %79 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %56, align 8
  %80 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %79, i32 0, i32 0
  store i8* null, i8** %80, align 8
  %81 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %60, i32 0, i32 0
  %82 = load i8*, i8** %81, align 8
  %83 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %67, i32 0, i32 0
  store i8* %82, i8** %83, align 8
  store %"struct.std::__1::nullptr_t"* %67, %"struct.std::__1::nullptr_t"** %55, align 8
  %84 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %55, align 8
  %85 = icmp eq %"class.std::__1::basic_streambuf"* %76, null
  br i1 %85, label %86, label %89

; <label>:86                                      ; preds = %0
  %87 = bitcast %"class.std::__1::ostreambuf_iterator"* %61 to i8*
  %88 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %87, i8* %88, i64 8, i32 8, i1 false)
  br label %289

; <label>:89                                      ; preds = %0
  %90 = load i8*, i8** %64, align 8
  %91 = load i8*, i8** %62, align 8
  %92 = ptrtoint i8* %90 to i64
  %93 = ptrtoint i8* %91 to i64
  %94 = sub i64 %92, %93
  store i64 %94, i64* %__sz, align 8
  %95 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %65, align 8
  store %"class.std::__1::ios_base"* %95, %"class.std::__1::ios_base"** %43, align 8
  %96 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %43, align 8
  %97 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %96, i32 0, i32 3
  %98 = load i64, i64* %97, align 8
  store i64 %98, i64* %__ns, align 8
  %99 = load i64, i64* %__ns, align 8
  %100 = load i64, i64* %__sz, align 8
  %101 = icmp sgt i64 %99, %100
  br i1 %101, label %102, label %106

; <label>:102                                     ; preds = %89
  %103 = load i64, i64* %__sz, align 8
  %104 = load i64, i64* %__ns, align 8
  %105 = sub nsw i64 %104, %103
  store i64 %105, i64* %__ns, align 8
  br label %107

; <label>:106                                     ; preds = %89
  store i64 0, i64* %__ns, align 8
  br label %107

; <label>:107                                     ; preds = %106, %102
  %108 = load i8*, i8** %63, align 8
  %109 = load i8*, i8** %62, align 8
  %110 = ptrtoint i8* %108 to i64
  %111 = ptrtoint i8* %109 to i64
  %112 = sub i64 %110, %111
  store i64 %112, i64* %__np, align 8
  %113 = load i64, i64* %__np, align 8
  %114 = icmp sgt i64 %113, 0
  br i1 %114, label %115, label %143

; <label>:115                                     ; preds = %107
  %116 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %117 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %116, align 8
  %118 = load i8*, i8** %62, align 8
  %119 = load i64, i64* %__np, align 8
  store %"class.std::__1::basic_streambuf"* %117, %"class.std::__1::basic_streambuf"** %31, align 8
  store i8* %118, i8** %32, align 8
  store i64 %119, i64* %33, align 8
  %120 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %31, align 8
  %121 = bitcast %"class.std::__1::basic_streambuf"* %120 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %122 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %121, align 8
  %123 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %122, i64 12
  %124 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %123, align 8
  %125 = load i8*, i8** %32, align 8
  %126 = load i64, i64* %33, align 8
  %127 = call i64 %124(%"class.std::__1::basic_streambuf"* %120, i8* %125, i64 %126)
  %128 = load i64, i64* %__np, align 8
  %129 = icmp ne i64 %127, %128
  br i1 %129, label %130, label %142

; <label>:130                                     ; preds = %115
  store %"struct.std::__1::nullptr_t"* %30, %"struct.std::__1::nullptr_t"** %28, align 8
  store i64 -1, i64* %29, align 8
  %131 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %28, align 8
  %132 = load i64, i64* %29, align 8
  store %"struct.std::__1::nullptr_t"* %131, %"struct.std::__1::nullptr_t"** %26, align 8
  store i64 %132, i64* %27, align 8
  %133 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %26, align 8
  %134 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %133, i32 0, i32 0
  store i8* null, i8** %134, align 8
  %135 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %30, i32 0, i32 0
  %136 = load i8*, i8** %135, align 8
  %137 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %68, i32 0, i32 0
  store i8* %136, i8** %137, align 8
  store %"struct.std::__1::nullptr_t"* %68, %"struct.std::__1::nullptr_t"** %1, align 8
  %138 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %1, align 8
  %139 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %139, align 8
  %140 = bitcast %"class.std::__1::ostreambuf_iterator"* %61 to i8*
  %141 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %140, i8* %141, i64 8, i32 8, i1 false)
  br label %289

; <label>:142                                     ; preds = %115
  br label %143

; <label>:143                                     ; preds = %142, %107
  %144 = load i64, i64* %__ns, align 8
  %145 = icmp sgt i64 %144, 0
  br i1 %145, label %146, label %243

; <label>:146                                     ; preds = %143
  %147 = load i64, i64* %__ns, align 8
  %148 = load i8, i8* %66, align 1
  store %"class.std::__1::basic_string"* %__sp, %"class.std::__1::basic_string"** %9, align 8
  store i64 %147, i64* %10, align 8
  store i8 %148, i8* %11, align 1
  %149 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %9, align 8
  %150 = load i64, i64* %10, align 8
  %151 = load i8, i8* %11, align 1
  store %"class.std::__1::basic_string"* %149, %"class.std::__1::basic_string"** %6, align 8
  store i64 %150, i64* %7, align 8
  store i8 %151, i8* %8, align 1
  %152 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %6, align 8
  %153 = bitcast %"class.std::__1::basic_string"* %152 to %"class.std::__1::__basic_string_common"*
  %154 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %152, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %154, %"class.std::__1::__compressed_pair"** %5, align 8
  %155 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %5, align 8
  store %"class.std::__1::__compressed_pair"* %155, %"class.std::__1::__compressed_pair"** %4, align 8
  %156 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %4, align 8
  %157 = bitcast %"class.std::__1::__compressed_pair"* %156 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %157, %"class.std::__1::__libcpp_compressed_pair_imp"** %3, align 8
  %158 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %3, align 8
  %159 = bitcast %"class.std::__1::__libcpp_compressed_pair_imp"* %158 to %"class.std::__1::allocator"*
  store %"class.std::__1::allocator"* %159, %"class.std::__1::allocator"** %2, align 8
  %160 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %2, align 8
  %161 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %158, i32 0, i32 0
  %162 = bitcast %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %161 to i8*
  call void @llvm.memset.p0i8.i64(i8* %162, i8 0, i64 24, i32 8, i1 false) #6
  %163 = load i64, i64* %7, align 8
  %164 = load i8, i8* %8, align 1
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(%"class.std::__1::basic_string"* %152, i64 %163, i8 signext %164)
  %165 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %166 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %165, align 8
  store %"class.std::__1::basic_string"* %__sp, %"class.std::__1::basic_string"** %25, align 8
  %167 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %25, align 8
  store %"class.std::__1::basic_string"* %167, %"class.std::__1::basic_string"** %24, align 8
  %168 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %24, align 8
  store %"class.std::__1::basic_string"* %168, %"class.std::__1::basic_string"** %23, align 8
  %169 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %23, align 8
  %170 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %169, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %170, %"class.std::__1::__compressed_pair"** %22, align 8
  %171 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %22, align 8
  %172 = bitcast %"class.std::__1::__compressed_pair"* %171 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %172, %"class.std::__1::__libcpp_compressed_pair_imp"** %21, align 8
  %173 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %21, align 8
  %174 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %173, i32 0, i32 0
  %175 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %174, i32 0, i32 0
  %176 = bitcast %union.anon* %175 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %177 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %176, i32 0, i32 0
  %178 = bitcast %union.anon.0* %177 to i8*
  %179 = load i8, i8* %178, align 8
  %180 = zext i8 %179 to i32
  %181 = and i32 %180, 1
  %182 = icmp ne i32 %181, 0
  br i1 %182, label %183, label %194

; <label>:183                                     ; preds = %146
  store %"class.std::__1::basic_string"* %168, %"class.std::__1::basic_string"** %15, align 8
  %184 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %15, align 8
  %185 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %184, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %185, %"class.std::__1::__compressed_pair"** %14, align 8
  %186 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %14, align 8
  %187 = bitcast %"class.std::__1::__compressed_pair"* %186 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %187, %"class.std::__1::__libcpp_compressed_pair_imp"** %13, align 8
  %188 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %13, align 8
  %189 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %188, i32 0, i32 0
  %190 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %189, i32 0, i32 0
  %191 = bitcast %union.anon* %190 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"*
  %192 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"* %191, i32 0, i32 2
  %193 = load i8*, i8** %192, align 8
  br label %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit

; <label>:194                                     ; preds = %146
  store %"class.std::__1::basic_string"* %168, %"class.std::__1::basic_string"** %20, align 8
  %195 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %20, align 8
  %196 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %195, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %196, %"class.std::__1::__compressed_pair"** %19, align 8
  %197 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %19, align 8
  %198 = bitcast %"class.std::__1::__compressed_pair"* %197 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %198, %"class.std::__1::__libcpp_compressed_pair_imp"** %18, align 8
  %199 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %18, align 8
  %200 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %199, i32 0, i32 0
  %201 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %200, i32 0, i32 0
  %202 = bitcast %union.anon* %201 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %203 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %202, i32 0, i32 1
  %204 = getelementptr inbounds [23 x i8], [23 x i8]* %203, i64 0, i64 0
  store i8* %204, i8** %17, align 8
  %205 = load i8*, i8** %17, align 8
  store i8* %205, i8** %16, align 8
  %206 = load i8*, i8** %16, align 8
  br label %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit

_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit: ; preds = %183, %194
  %207 = phi i8* [ %193, %183 ], [ %206, %194 ]
  store i8* %207, i8** %12, align 8
  %208 = load i8*, i8** %12, align 8
  %209 = load i64, i64* %__ns, align 8
  store %"class.std::__1::basic_streambuf"* %166, %"class.std::__1::basic_streambuf"** %34, align 8
  store i8* %208, i8** %35, align 8
  store i64 %209, i64* %36, align 8
  %210 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %34, align 8
  %211 = bitcast %"class.std::__1::basic_streambuf"* %210 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %212 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %211, align 8
  %213 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %212, i64 12
  %214 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %213, align 8
  %215 = load i8*, i8** %35, align 8
  %216 = load i64, i64* %36, align 8
  %217 = invoke i64 %214(%"class.std::__1::basic_streambuf"* %210, i8* %215, i64 %216)
          to label %_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit unwind label %235

_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit: ; preds = %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit
  br label %218

; <label>:218                                     ; preds = %_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit
  %219 = load i64, i64* %__ns, align 8
  %220 = icmp ne i64 %217, %219
  br i1 %220, label %221, label %239

; <label>:221                                     ; preds = %218
  store %"struct.std::__1::nullptr_t"* %41, %"struct.std::__1::nullptr_t"** %39, align 8
  store i64 -1, i64* %40, align 8
  %222 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %39, align 8
  %223 = load i64, i64* %40, align 8
  store %"struct.std::__1::nullptr_t"* %222, %"struct.std::__1::nullptr_t"** %37, align 8
  store i64 %223, i64* %38, align 8
  %224 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %37, align 8
  %225 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %224, i32 0, i32 0
  store i8* null, i8** %225, align 8
  %226 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %41, i32 0, i32 0
  %227 = load i8*, i8** %226, align 8
  br label %228

; <label>:228                                     ; preds = %221
  %229 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %71, i32 0, i32 0
  store i8* %227, i8** %229, align 8
  store %"struct.std::__1::nullptr_t"* %71, %"struct.std::__1::nullptr_t"** %42, align 8
  %230 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %42, align 8
  br label %231

; <label>:231                                     ; preds = %228
  %232 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %232, align 8
  %233 = bitcast %"class.std::__1::ostreambuf_iterator"* %61 to i8*
  %234 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %233, i8* %234, i64 8, i32 8, i1 false)
  store i32 1, i32* %72, align 4
  br label %240

; <label>:235                                     ; preds = %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit
  %236 = landingpad { i8*, i32 }
          cleanup
  %237 = extractvalue { i8*, i32 } %236, 0
  store i8* %237, i8** %69, align 8
  %238 = extractvalue { i8*, i32 } %236, 1
  store i32 %238, i32* %70, align 4
  invoke void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* %__sp)
          to label %242 unwind label %297

; <label>:239                                     ; preds = %218
  store i32 0, i32* %72, align 4
  br label %240

; <label>:240                                     ; preds = %239, %231
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* %__sp)
  %cleanup.dest = load i32, i32* %72, align 4
  switch i32 %cleanup.dest, label %300 [
    i32 0, label %241
    i32 1, label %289
  ]

; <label>:241                                     ; preds = %240
  br label %243

; <label>:242                                     ; preds = %235
  br label %292

; <label>:243                                     ; preds = %241, %143
  %244 = load i8*, i8** %64, align 8
  %245 = load i8*, i8** %63, align 8
  %246 = ptrtoint i8* %244 to i64
  %247 = ptrtoint i8* %245 to i64
  %248 = sub i64 %246, %247
  store i64 %248, i64* %__np, align 8
  %249 = load i64, i64* %__np, align 8
  %250 = icmp sgt i64 %249, 0
  br i1 %250, label %251, label %279

; <label>:251                                     ; preds = %243
  %252 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %253 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %252, align 8
  %254 = load i8*, i8** %63, align 8
  %255 = load i64, i64* %__np, align 8
  store %"class.std::__1::basic_streambuf"* %253, %"class.std::__1::basic_streambuf"** %44, align 8
  store i8* %254, i8** %45, align 8
  store i64 %255, i64* %46, align 8
  %256 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %44, align 8
  %257 = bitcast %"class.std::__1::basic_streambuf"* %256 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %258 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %257, align 8
  %259 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %258, i64 12
  %260 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %259, align 8
  %261 = load i8*, i8** %45, align 8
  %262 = load i64, i64* %46, align 8
  %263 = call i64 %260(%"class.std::__1::basic_streambuf"* %256, i8* %261, i64 %262)
  %264 = load i64, i64* %__np, align 8
  %265 = icmp ne i64 %263, %264
  br i1 %265, label %266, label %278

; <label>:266                                     ; preds = %251
  store %"struct.std::__1::nullptr_t"* %51, %"struct.std::__1::nullptr_t"** %49, align 8
  store i64 -1, i64* %50, align 8
  %267 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %49, align 8
  %268 = load i64, i64* %50, align 8
  store %"struct.std::__1::nullptr_t"* %267, %"struct.std::__1::nullptr_t"** %47, align 8
  store i64 %268, i64* %48, align 8
  %269 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %47, align 8
  %270 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %269, i32 0, i32 0
  store i8* null, i8** %270, align 8
  %271 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %51, i32 0, i32 0
  %272 = load i8*, i8** %271, align 8
  %273 = getelementptr inbounds %"struct.std::__1::nullptr_t", %"struct.std::__1::nullptr_t"* %73, i32 0, i32 0
  store i8* %272, i8** %273, align 8
  store %"struct.std::__1::nullptr_t"* %73, %"struct.std::__1::nullptr_t"** %52, align 8
  %274 = load %"struct.std::__1::nullptr_t"*, %"struct.std::__1::nullptr_t"** %52, align 8
  %275 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %275, align 8
  %276 = bitcast %"class.std::__1::ostreambuf_iterator"* %61 to i8*
  %277 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %276, i8* %277, i64 8, i32 8, i1 false)
  br label %289

; <label>:278                                     ; preds = %251
  br label %279

; <label>:279                                     ; preds = %278, %243
  %280 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %65, align 8
  store %"class.std::__1::ios_base"* %280, %"class.std::__1::ios_base"** %53, align 8
  store i64 0, i64* %54, align 8
  %281 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %53, align 8
  %282 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %281, i32 0, i32 3
  %283 = load i64, i64* %282, align 8
  store i64 %283, i64* %__r.i, align 8
  %284 = load i64, i64* %54, align 8
  %285 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %281, i32 0, i32 3
  store i64 %284, i64* %285, align 8
  %286 = load i64, i64* %__r.i, align 8
  %287 = bitcast %"class.std::__1::ostreambuf_iterator"* %61 to i8*
  %288 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %287, i8* %288, i64 8, i32 8, i1 false)
  br label %289

; <label>:289                                     ; preds = %279, %266, %240, %130, %86
  %290 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %61, i32 0, i32 0
  %291 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %290, align 8
  ret %"class.std::__1::basic_streambuf"* %291

; <label>:292                                     ; preds = %242
  %293 = load i8*, i8** %69, align 8
  %294 = load i32, i32* %70, align 4
  %295 = insertvalue { i8*, i32 } undef, i8* %293, 0
  %296 = insertvalue { i8*, i32 } %295, i32 %294, 1
  resume { i8*, i32 } %296

; <label>:297                                     ; preds = %235
  %298 = landingpad { i8*, i32 }
          catch i8* null
  %299 = extractvalue { i8*, i32 } %298, 0
  call void @__clang_call_terminate(i8* %299) #7
  unreachable

; <label>:300                                     ; preds = %240
  unreachable
}

declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*) #3

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #4 {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #6
  call void @_ZSt9terminatev() #7
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"*) #3

declare void @__cxa_end_catch()

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"*) #3

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(%"class.std::__1::basic_string"*, i64, i8 signext) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

declare void @__cxa_call_unexpected(i8*)

; Function Attrs: inlinehint nounwind ssp uwtable
define linkonce_odr zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %__c1, i32 %__c2) #5 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %__c1, i32* %1, align 4
  store i32 %__c2, i32* %2, align 4
  %3 = load i32, i32* %1, align 4
  %4 = load i32, i32* %2, align 4
  %5 = icmp eq i32 %3, %4
  ret i1 %5
}

; Function Attrs: inlinehint nounwind ssp uwtable
define linkonce_odr i32 @_ZNSt3__111char_traitsIcE3eofEv() #5 align 2 {
  ret i32 -1
}

declare void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret, %"class.std::__1::ios_base"*) #3

declare void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"*) #3

declare %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"*, %"class.std::__1::locale::id"* dereferenceable(16)) #3

declare void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"*, i32) #3

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind }
attributes #5 = { inlinehint nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
