Return-Path: <linux-hyperv+bounces-1579-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36185BF30
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A158C2849AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB906A8D6;
	Tue, 20 Feb 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jJjV3yWg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7F6F515;
	Tue, 20 Feb 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440945; cv=none; b=Z6QhcU2uU03/FSVCaYA6ZNqdc9gPoRq3lkYc7kUgQBVGMKQOcval92HfZPfvzfRSPZdhjpnNSADAXSg/RuIyTY9KB0b1soCfU82p8dIc5+eAEHtjDUj2uJF0u6AV24LN5QDwgHPrkdIFJA2c+z9cp3VgEDcDcbcOJkZOPFV2rU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440945; c=relaxed/simple;
	bh=VqCUtywSkBBtP6iRSlhULsk2/W/RFQ/yK2Ie89zEVpY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S+G9+ukLG/DyKMs5XYlEG3G9aGB/NoI2GuWSZ+gsHtdzPSVa0C2Cgcpw2dIRihUAUUHnSQy+q81FiK1J6DJf291ig3JMV5FRwGLE6fBM5JRN4r0yxGZQ2UTDjFuT/Y/QESwhZJEOflgQ47EO6yaR5NgVC5N5XDkwKs9skMKZT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jJjV3yWg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 764942083611;
	Tue, 20 Feb 2024 06:55:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 764942083611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708440942;
	bh=bXtaNZ49gS3FezeGDUKfadE4ql5Ll/u4+kFpP9zktEU=;
	h=From:To:Cc:Subject:Date:From;
	b=jJjV3yWgCZ854PWJlC7NqYXGJ6Zt3XwhYgh87ksJ15AWyWbvJXkE1eDTQ7X3fRL5L
	 tU9a+kDqYeeDOJQ0sDGi1WsrRfmjPgYw2hJMHRpxxLJso1AZkzG+zcxFKg7gaxXoea
	 Tp2XOpStnwszugeEZt+YB/g1UufdzSj89rkWsVkY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	mhklinu@outlook.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	tglx@linutronix.de,
	daniel.lezcano@linaro.org,
	arnd@arndb.de
Subject: [PATCH v2] hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs to HV_MSR_*
Date: Tue, 20 Feb 2024 06:55:33 -0800
Message-Id: <1708440933-27125-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The HV_REGISTER_ are used as arguments to hv_set/get_register(), which
delegate to arch-specific mechanisms for getting/setting synthetic
Hyper-V MSRs.

On arm64, HV_REGISTER_ defines are synthetic VP registers accessed via
the get/set vp registers hypercalls. The naming matches the TLFS
document, although these register names are not specific to arm64.

However, on x86 the prefix HV_REGISTER_ indicates Hyper-V MSRs accessed
via rdmsrl()/wrmsrl(). This is not consistent with the TLFS doc, where
HV_REGISTER_ is *only* used for used for VP register names used by
the get/set register hypercalls.

To fix this inconsistency and prevent future confusion, change the
arch-generic aliases used by callers of hv_set/get_register() to have
the prefix HV_MSR_ instead of HV_REGISTER_.

Use the prefix HV_X64_MSR_ for the x86-only Hyper-V MSRs. On x86, the
generic HV_MSR_'s point to the corresponding HV_X64_MSR_.

Move the arm64 HV_REGISTER_* defines to the asm-generic hyperv-tlfs.h,
since these are not specific to arm64. On arm64, the generic HV_MSR_'s
point to the corresponding HV_REGISTER_.

While at it, rename hv_get/set_registers() and related functions to
hv_get/set_msr(), hv_get/set_nested_msr(), etc. These are only used for
Hyper-V MSRs and this naming makes that clear.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Use HV_X64_MSR_ instead of HV_MSR_ in arch/x86/kernel/cpu/mshyperv.c
---
 arch/arm64/include/asm/hyperv-tlfs.h |  45 ++++-----
 arch/arm64/include/asm/mshyperv.h    |   4 +-
 arch/x86/hyperv/hv_init.c            |   8 +-
 arch/x86/include/asm/hyperv-tlfs.h   | 145 ++++++++++++++-------------
 arch/x86/include/asm/mshyperv.h      |  30 +++---
 arch/x86/kernel/cpu/mshyperv.c       |  56 +++++------
 drivers/clocksource/hyperv_timer.c   |  26 ++---
 drivers/hv/hv.c                      |  36 +++----
 drivers/hv/hv_common.c               |  22 ++--
 include/asm-generic/hyperv-tlfs.h    |  32 +++++-
 include/asm-generic/mshyperv.h       |   2 +-
 11 files changed, 216 insertions(+), 190 deletions(-)

diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
index bc6c7ac934a1..54846d1d29c3 100644
--- a/arch/arm64/include/asm/hyperv-tlfs.h
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -21,14 +21,6 @@
  * byte ordering of Linux running on ARM64, so no special handling is required.
  */
 
-/*
- * These Hyper-V registers provide information equivalent to the CPUID
- * instruction on x86/x64.
- */
-#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
-#define HV_REGISTER_FEATURES			0x00000200 /*CPUID 0x40000003 */
-#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID 0x40000004 */
-
 /*
  * Group C Features. See the asm-generic version of hyperv-tlfs.h
  * for a description of Feature Groups.
@@ -41,28 +33,29 @@
 #define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
 
 /*
- * Synthetic register definitions equivalent to MSRs on x86/x64
+ * To support arch-generic code calling hv_set/get_register:
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
+ * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
  */
-#define HV_REGISTER_CRASH_P0		0x00000210
-#define HV_REGISTER_CRASH_P1		0x00000211
-#define HV_REGISTER_CRASH_P2		0x00000212
-#define HV_REGISTER_CRASH_P3		0x00000213
-#define HV_REGISTER_CRASH_P4		0x00000214
-#define HV_REGISTER_CRASH_CTL		0x00000215
+#define HV_MSR_CRASH_P0		(HV_REGISTER_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_REGISTER_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_REGISTER_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_REGISTER_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_REGISTER_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_REGISTER_CRASH_CTL)
 
-#define HV_REGISTER_GUEST_OSID		0x00090002
-#define HV_REGISTER_VP_INDEX		0x00090003
-#define HV_REGISTER_TIME_REF_COUNT	0x00090004
-#define HV_REGISTER_REFERENCE_TSC	0x00090017
+#define HV_MSR_VP_INDEX		(HV_REGISTER_VP_INDEX)
+#define HV_MSR_TIME_REF_COUNT	(HV_REGISTER_TIME_REF_COUNT)
+#define HV_MSR_REFERENCE_TSC	(HV_REGISTER_REFERENCE_TSC)
 
-#define HV_REGISTER_SINT0		0x000A0000
-#define HV_REGISTER_SCONTROL		0x000A0010
-#define HV_REGISTER_SIEFP		0x000A0012
-#define HV_REGISTER_SIMP		0x000A0013
-#define HV_REGISTER_EOM			0x000A0014
+#define HV_MSR_SINT0		(HV_REGISTER_SINT0)
+#define HV_MSR_SCONTROL		(HV_REGISTER_SCONTROL)
+#define HV_MSR_SIEFP		(HV_REGISTER_SIEFP)
+#define HV_MSR_SIMP		(HV_REGISTER_SIMP)
+#define HV_MSR_EOM		(HV_REGISTER_EOM)
 
-#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
-#define HV_REGISTER_STIMER0_COUNT	0x000B0001
+#define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
+#define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
 
 union hv_msi_entry {
 	u64 as_uint64[2];
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 20070a847304..a975e1a689dd 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -31,12 +31,12 @@ void hv_set_vpreg(u32 reg, u64 value);
 u64 hv_get_vpreg(u32 reg);
 void hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_output *result);
 
-static inline void hv_set_register(unsigned int reg, u64 value)
+static inline void hv_set_msr(unsigned int reg, u64 value)
 {
 	hv_set_vpreg(reg, value);
 }
 
-static inline u64 hv_get_register(unsigned int reg)
+static inline u64 hv_get_msr(unsigned int reg)
 {
 	return hv_get_vpreg(reg);
 }
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 783ed339f341..0c74012b2594 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -642,14 +642,14 @@ void hyperv_cleanup(void)
 	hv_hypercall_pg = NULL;
 
 	/* Reset the hypercall page */
-	hypercall_msr.as_uint64 = hv_get_register(HV_X64_MSR_HYPERCALL);
+	hypercall_msr.as_uint64 = hv_get_msr(HV_X64_MSR_HYPERCALL);
 	hypercall_msr.enable = 0;
-	hv_set_register(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hv_set_msr(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	/* Reset the TSC page */
-	tsc_msr.as_uint64 = hv_get_register(HV_X64_MSR_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_msr(HV_X64_MSR_REFERENCE_TSC);
 	tsc_msr.enable = 0;
-	hv_set_register(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_msr(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 2ff26f53cd62..3787d26810c1 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -182,7 +182,7 @@ enum hv_isolation_type {
 #define HV_X64_MSR_HYPERCALL			0x40000001
 
 /* MSR used to provide vcpu index */
-#define HV_REGISTER_VP_INDEX			0x40000002
+#define HV_X64_MSR_VP_INDEX			0x40000002
 
 /* MSR used to reset the guest OS. */
 #define HV_X64_MSR_RESET			0x40000003
@@ -191,10 +191,10 @@ enum hv_isolation_type {
 #define HV_X64_MSR_VP_RUNTIME			0x40000010
 
 /* MSR used to read the per-partition time reference counter */
-#define HV_REGISTER_TIME_REF_COUNT		0x40000020
+#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
 
 /* A partition's reference time stamp counter (TSC) page */
-#define HV_REGISTER_REFERENCE_TSC		0x40000021
+#define HV_X64_MSR_REFERENCE_TSC		0x40000021
 
 /* MSR used to retrieve the TSC frequency */
 #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
@@ -209,61 +209,61 @@ enum hv_isolation_type {
 #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
 
 /* Define synthetic interrupt controller model specific registers. */
-#define HV_REGISTER_SCONTROL			0x40000080
-#define HV_REGISTER_SVERSION			0x40000081
-#define HV_REGISTER_SIEFP			0x40000082
-#define HV_REGISTER_SIMP			0x40000083
-#define HV_REGISTER_EOM				0x40000084
-#define HV_REGISTER_SINT0			0x40000090
-#define HV_REGISTER_SINT1			0x40000091
-#define HV_REGISTER_SINT2			0x40000092
-#define HV_REGISTER_SINT3			0x40000093
-#define HV_REGISTER_SINT4			0x40000094
-#define HV_REGISTER_SINT5			0x40000095
-#define HV_REGISTER_SINT6			0x40000096
-#define HV_REGISTER_SINT7			0x40000097
-#define HV_REGISTER_SINT8			0x40000098
-#define HV_REGISTER_SINT9			0x40000099
-#define HV_REGISTER_SINT10			0x4000009A
-#define HV_REGISTER_SINT11			0x4000009B
-#define HV_REGISTER_SINT12			0x4000009C
-#define HV_REGISTER_SINT13			0x4000009D
-#define HV_REGISTER_SINT14			0x4000009E
-#define HV_REGISTER_SINT15			0x4000009F
+#define HV_X64_MSR_SCONTROL			0x40000080
+#define HV_X64_MSR_SVERSION			0x40000081
+#define HV_X64_MSR_SIEFP			0x40000082
+#define HV_X64_MSR_SIMP				0x40000083
+#define HV_X64_MSR_EOM				0x40000084
+#define HV_X64_MSR_SINT0			0x40000090
+#define HV_X64_MSR_SINT1			0x40000091
+#define HV_X64_MSR_SINT2			0x40000092
+#define HV_X64_MSR_SINT3			0x40000093
+#define HV_X64_MSR_SINT4			0x40000094
+#define HV_X64_MSR_SINT5			0x40000095
+#define HV_X64_MSR_SINT6			0x40000096
+#define HV_X64_MSR_SINT7			0x40000097
+#define HV_X64_MSR_SINT8			0x40000098
+#define HV_X64_MSR_SINT9			0x40000099
+#define HV_X64_MSR_SINT10			0x4000009A
+#define HV_X64_MSR_SINT11			0x4000009B
+#define HV_X64_MSR_SINT12			0x4000009C
+#define HV_X64_MSR_SINT13			0x4000009D
+#define HV_X64_MSR_SINT14			0x4000009E
+#define HV_X64_MSR_SINT15			0x4000009F
 
 /*
  * Define synthetic interrupt controller model specific registers for
  * nested hypervisor.
  */
-#define HV_REGISTER_NESTED_SCONTROL            0x40001080
-#define HV_REGISTER_NESTED_SVERSION            0x40001081
-#define HV_REGISTER_NESTED_SIEFP               0x40001082
-#define HV_REGISTER_NESTED_SIMP                0x40001083
-#define HV_REGISTER_NESTED_EOM                 0x40001084
-#define HV_REGISTER_NESTED_SINT0               0x40001090
+#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
+#define HV_X64_MSR_NESTED_SVERSION		0x40001081
+#define HV_X64_MSR_NESTED_SIEFP			0x40001082
+#define HV_X64_MSR_NESTED_SIMP			0x40001083
+#define HV_X64_MSR_NESTED_EOM			0x40001084
+#define HV_X64_MSR_NESTED_SINT0			0x40001090
 
 /*
  * Synthetic Timer MSRs. Four timers per vcpu.
  */
-#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
-#define HV_REGISTER_STIMER0_COUNT		0x400000B1
-#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
-#define HV_REGISTER_STIMER1_COUNT		0x400000B3
-#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
-#define HV_REGISTER_STIMER2_COUNT		0x400000B5
-#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
-#define HV_REGISTER_STIMER3_COUNT		0x400000B7
+#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
+#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
+#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
+#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
+#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
+#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
+#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
+#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
 
 /* Hyper-V guest idle MSR */
 #define HV_X64_MSR_GUEST_IDLE			0x400000F0
 
 /* Hyper-V guest crash notification MSR's */
-#define HV_REGISTER_CRASH_P0			0x40000100
-#define HV_REGISTER_CRASH_P1			0x40000101
-#define HV_REGISTER_CRASH_P2			0x40000102
-#define HV_REGISTER_CRASH_P3			0x40000103
-#define HV_REGISTER_CRASH_P4			0x40000104
-#define HV_REGISTER_CRASH_CTL			0x40000105
+#define HV_X64_MSR_CRASH_P0			0x40000100
+#define HV_X64_MSR_CRASH_P1			0x40000101
+#define HV_X64_MSR_CRASH_P2			0x40000102
+#define HV_X64_MSR_CRASH_P3			0x40000103
+#define HV_X64_MSR_CRASH_P4			0x40000104
+#define HV_X64_MSR_CRASH_CTL			0x40000105
 
 /* TSC emulation after migration */
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
@@ -276,31 +276,38 @@ enum hv_isolation_type {
 /* HV_X64_MSR_TSC_INVARIANT_CONTROL bits */
 #define HV_EXPOSE_INVARIANT_TSC		BIT_ULL(0)
 
-/* Register name aliases for temporary compatibility */
-#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
-#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
-#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
-#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
-#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
-#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
-#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
-#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
-#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
-#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
-#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
-#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
-#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
-#define HV_X64_MSR_EOM			HV_REGISTER_EOM
-#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
-#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
-#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
-#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
-#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
-#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
-#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
-#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
-#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
-#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
+/*
+ * To support arch-generic code calling hv_set/get_register:
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
+ * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
+ */
+#define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_X64_MSR_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_X64_MSR_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_X64_MSR_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_X64_MSR_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_X64_MSR_CRASH_CTL)
+
+#define HV_MSR_VP_INDEX		(HV_X64_MSR_VP_INDEX)
+#define HV_MSR_TIME_REF_COUNT	(HV_X64_MSR_TIME_REF_COUNT)
+#define HV_MSR_REFERENCE_TSC	(HV_X64_MSR_REFERENCE_TSC)
+
+#define HV_MSR_SINT0		(HV_X64_MSR_SINT0)
+#define HV_MSR_SVERSION		(HV_X64_MSR_SVERSION)
+#define HV_MSR_SCONTROL		(HV_X64_MSR_SCONTROL)
+#define HV_MSR_SIEFP		(HV_X64_MSR_SIEFP)
+#define HV_MSR_SIMP		(HV_X64_MSR_SIMP)
+#define HV_MSR_EOM		(HV_X64_MSR_EOM)
+
+#define HV_MSR_NESTED_SCONTROL	(HV_X64_MSR_NESTED_SCONTROL)
+#define HV_MSR_NESTED_SVERSION	(HV_X64_MSR_NESTED_SVERSION)
+#define HV_MSR_NESTED_SIEFP	(HV_X64_MSR_NESTED_SIEFP)
+#define HV_MSR_NESTED_SIMP	(HV_X64_MSR_NESTED_SIMP)
+#define HV_MSR_NESTED_EOM	(HV_X64_MSR_NESTED_EOM)
+#define HV_MSR_NESTED_SINT0	(HV_X64_MSR_NESTED_SINT0)
+
+#define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
+#define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
 
 /*
  * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 033b53f993c6..b06d6fd75367 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -293,24 +293,24 @@ static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
 static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
 #endif
 
-static inline bool hv_is_synic_reg(unsigned int reg)
+static inline bool hv_is_synic_msr(unsigned int reg)
 {
-	return (reg >= HV_REGISTER_SCONTROL) &&
-	       (reg <= HV_REGISTER_SINT15);
+	return (reg >= HV_X64_MSR_SCONTROL) &&
+	       (reg <= HV_X64_MSR_SINT15);
 }
 
-static inline bool hv_is_sint_reg(unsigned int reg)
+static inline bool hv_is_sint_msr(unsigned int reg)
 {
-	return (reg >= HV_REGISTER_SINT0) &&
-	       (reg <= HV_REGISTER_SINT15);
+	return (reg >= HV_X64_MSR_SINT0) &&
+	       (reg <= HV_X64_MSR_SINT15);
 }
 
-u64 hv_get_register(unsigned int reg);
-void hv_set_register(unsigned int reg, u64 value);
-u64 hv_get_non_nested_register(unsigned int reg);
-void hv_set_non_nested_register(unsigned int reg, u64 value);
+u64 hv_get_msr(unsigned int reg);
+void hv_set_msr(unsigned int reg, u64 value);
+u64 hv_get_non_nested_msr(unsigned int reg);
+void hv_set_non_nested_msr(unsigned int reg, u64 value);
 
-static __always_inline u64 hv_raw_get_register(unsigned int reg)
+static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
 	return __rdmsr(reg);
 }
@@ -331,10 +331,10 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 {
 	return -1;
 }
-static inline void hv_set_register(unsigned int reg, u64 value) { }
-static inline u64 hv_get_register(unsigned int reg) { return 0; }
-static inline void hv_set_non_nested_register(unsigned int reg, u64 value) { }
-static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
+static inline void hv_set_msr(unsigned int reg, u64 value) { }
+static inline u64 hv_get_msr(unsigned int reg) { return 0; }
+static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
+static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
 #endif /* CONFIG_HYPERV */
 
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e6bba12c759c..08a7ca2cdcbb 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -45,70 +45,70 @@ bool hyperv_paravisor_present __ro_after_init;
 EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
 
 #if IS_ENABLED(CONFIG_HYPERV)
-static inline unsigned int hv_get_nested_reg(unsigned int reg)
+static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
-	if (hv_is_sint_reg(reg))
-		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
+	if (hv_is_sint_msr(reg))
+		return reg - HV_X64_MSR_SINT0 + HV_X64_MSR_NESTED_SINT0;
 
 	switch (reg) {
-	case HV_REGISTER_SIMP:
-		return HV_REGISTER_NESTED_SIMP;
-	case HV_REGISTER_SIEFP:
-		return HV_REGISTER_NESTED_SIEFP;
-	case HV_REGISTER_SVERSION:
-		return HV_REGISTER_NESTED_SVERSION;
-	case HV_REGISTER_SCONTROL:
-		return HV_REGISTER_NESTED_SCONTROL;
-	case HV_REGISTER_EOM:
-		return HV_REGISTER_NESTED_EOM;
+	case HV_X64_MSR_SIMP:
+		return HV_X64_MSR_NESTED_SIMP;
+	case HV_X64_MSR_SIEFP:
+		return HV_X64_MSR_NESTED_SIEFP;
+	case HV_X64_MSR_SVERSION:
+		return HV_X64_MSR_NESTED_SVERSION;
+	case HV_X64_MSR_SCONTROL:
+		return HV_X64_MSR_NESTED_SCONTROL;
+	case HV_X64_MSR_EOM:
+		return HV_X64_MSR_NESTED_EOM;
 	default:
 		return reg;
 	}
 }
 
-u64 hv_get_non_nested_register(unsigned int reg)
+u64 hv_get_non_nested_msr(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present)
+	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present)
 		hv_ivm_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
 	return value;
 }
-EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
+EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 
-void hv_set_non_nested_register(unsigned int reg, u64 value)
+void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present) {
+	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
 		hv_ivm_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
-		if (hv_is_sint_reg(reg))
+		if (hv_is_sint_msr(reg))
 			wrmsrl(reg, value | 1 << 20);
 	} else {
 		wrmsrl(reg, value);
 	}
 }
-EXPORT_SYMBOL_GPL(hv_set_non_nested_register);
+EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
-u64 hv_get_register(unsigned int reg)
+u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
-		reg = hv_get_nested_reg(reg);
+		reg = hv_get_nested_msr(reg);
 
-	return hv_get_non_nested_register(reg);
+	return hv_get_non_nested_msr(reg);
 }
-EXPORT_SYMBOL_GPL(hv_get_register);
+EXPORT_SYMBOL_GPL(hv_get_msr);
 
-void hv_set_register(unsigned int reg, u64 value)
+void hv_set_msr(unsigned int reg, u64 value)
 {
 	if (hv_nested)
-		reg = hv_get_nested_reg(reg);
+		reg = hv_get_nested_msr(reg);
 
-	hv_set_non_nested_register(reg, value);
+	hv_set_non_nested_msr(reg, value);
 }
-EXPORT_SYMBOL_GPL(hv_set_register);
+EXPORT_SYMBOL_GPL(hv_set_msr);
 
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 8ff7cd4e20bb..b2a080647e41 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
 
 	current_tick = hv_read_reference_counter();
 	current_tick += delta;
-	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
+	hv_set_msr(HV_MSR_STIMER0_COUNT, current_tick);
 	return 0;
 }
 
 static int hv_ce_shutdown(struct clock_event_device *evt)
 {
-	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
-	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
+	hv_set_msr(HV_MSR_STIMER0_COUNT, 0);
+	hv_set_msr(HV_MSR_STIMER0_CONFIG, 0);
 	if (direct_mode_enabled && stimer0_irq >= 0)
 		disable_percpu_irq(stimer0_irq);
 
@@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		timer_cfg.direct_mode = 0;
 		timer_cfg.sintx = stimer0_message_sint;
 	}
-	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
+	hv_set_msr(HV_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
 	return 0;
 }
 
@@ -372,11 +372,11 @@ static __always_inline u64 read_hv_clock_msr(void)
 	 * is set to 0 when the partition is created and is incremented in 100
 	 * nanosecond units.
 	 *
-	 * Use hv_raw_get_register() because this function is used from
-	 * noinstr. Notable; while HV_REGISTER_TIME_REF_COUNT is a synthetic
+	 * Use hv_raw_get_msr() because this function is used from
+	 * noinstr. Notable; while HV_MSR_TIME_REF_COUNT is a synthetic
 	 * register it doesn't need the GHCB path.
 	 */
-	return hv_raw_get_register(HV_REGISTER_TIME_REF_COUNT);
+	return hv_raw_get_msr(HV_MSR_TIME_REF_COUNT);
 }
 
 /*
@@ -439,9 +439,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Disable the TSC page */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
 	tsc_msr.enable = 0;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 
@@ -450,10 +450,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Re-enable the TSC page */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
 	tsc_msr.enable = 1;
 	tsc_msr.pfn = tsc_pfn;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
@@ -555,14 +555,14 @@ static void __init hv_init_tsc_clocksource(void)
 	 * thus TSC clocksource will work even without the real TSC page
 	 * mapped.
 	 */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
 	if (hv_root_partition)
 		tsc_pfn = tsc_msr.pfn;
 	else
 		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
 	tsc_msr.enable = 1;
 	tsc_msr.pfn = tsc_pfn;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 51e5018ac9b2..a8ad728354cb 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -270,7 +270,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	simp.simp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
@@ -286,10 +286,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
@@ -305,13 +305,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
+	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
@@ -326,14 +325,13 @@ void hv_synic_enable_regs(unsigned int cpu)
 #else
 	shared_sint.auto_eoi = 0;
 #endif
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
-				shared_sint.as_uint64);
+	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 1;
 
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -357,17 +355,15 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
+	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
-				shared_sint.as_uint64);
+	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
@@ -382,9 +378,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 		simp.base_simp_gpa = 0;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
@@ -394,12 +390,12 @@ void hv_synic_disable_regs(unsigned int cpu)
 		siefp.base_siefp_gpa = 0;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 0;
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ccad7bca3fd3..65c0740484cb 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -228,19 +228,19 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * contain the size of the panic data in that page. Rest of the
 	 * registers are no-op when the NOTIFY_MSG flag is set.
 	 */
-	hv_set_register(HV_REGISTER_CRASH_P0, 0);
-	hv_set_register(HV_REGISTER_CRASH_P1, 0);
-	hv_set_register(HV_REGISTER_CRASH_P2, 0);
-	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
-	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
+	hv_set_msr(HV_MSR_CRASH_P0, 0);
+	hv_set_msr(HV_MSR_CRASH_P1, 0);
+	hv_set_msr(HV_MSR_CRASH_P2, 0);
+	hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
 
 	/*
 	 * Let Hyper-V know there is crash data available along with
 	 * the panic message.
 	 */
-	hv_set_register(HV_REGISTER_CRASH_CTL,
-			(HV_CRASH_CTL_CRASH_NOTIFY |
-			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+	hv_set_msr(HV_MSR_CRASH_CTL,
+		   (HV_CRASH_CTL_CRASH_NOTIFY |
+		    HV_CRASH_CTL_CRASH_NOTIFY_MSG));
 }
 
 static struct kmsg_dumper hv_kmsg_dumper = {
@@ -311,7 +311,7 @@ int __init hv_common_init(void)
 		 * Register for panic kmsg callback only if the right
 		 * capability is supported by the hypervisor.
 		 */
-		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
+		hyperv_crash_ctl = hv_get_msr(HV_MSR_CRASH_CTL);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
 			hv_kmsg_dump_register();
 
@@ -410,7 +410,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		*inputarg = mem;
 	}
 
-	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
+	msr_vp_index = hv_get_msr(HV_MSR_VP_INDEX);
 
 	hv_vp_index[cpu] = msr_vp_index;
 
@@ -507,7 +507,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
  */
 static u64 __hv_read_ref_counter(void)
 {
-	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+	return hv_get_msr(HV_MSR_TIME_REF_COUNT);
 }
 
 u64 (*hv_read_reference_counter)(void) = __hv_read_ref_counter;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index fdac4a1714ec..3d1b31f90ed6 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -625,6 +625,37 @@ struct hv_retarget_device_interrupt {
 	struct hv_device_interrupt_target int_target;
 } __packed __aligned(8);
 
+/*
+ * These Hyper-V registers provide information equivalent to the CPUID
+ * instruction on x86/x64.
+ */
+#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
+#define HV_REGISTER_FEATURES			0x00000200 /*CPUID 0x40000003 */
+#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID 0x40000004 */
+
+/*
+ * Synthetic register definitions equivalent to MSRs on x86/x64
+ */
+#define HV_REGISTER_CRASH_P0		0x00000210
+#define HV_REGISTER_CRASH_P1		0x00000211
+#define HV_REGISTER_CRASH_P2		0x00000212
+#define HV_REGISTER_CRASH_P3		0x00000213
+#define HV_REGISTER_CRASH_P4		0x00000214
+#define HV_REGISTER_CRASH_CTL		0x00000215
+
+#define HV_REGISTER_GUEST_OSID		0x00090002
+#define HV_REGISTER_VP_INDEX		0x00090003
+#define HV_REGISTER_TIME_REF_COUNT	0x00090004
+#define HV_REGISTER_REFERENCE_TSC	0x00090017
+
+#define HV_REGISTER_SINT0		0x000A0000
+#define HV_REGISTER_SCONTROL		0x000A0010
+#define HV_REGISTER_SIEFP		0x000A0012
+#define HV_REGISTER_SIMP		0x000A0013
+#define HV_REGISTER_EOM			0x000A0014
+
+#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
+#define HV_REGISTER_STIMER0_COUNT	0x000B0001
 
 /* HvGetVpRegisters hypercall input with variable size reg name list*/
 struct hv_get_vp_registers_input {
@@ -640,7 +671,6 @@ struct hv_get_vp_registers_input {
 	} element[];
 } __packed;
 
-
 /* HvGetVpRegisters returns an array of these output elements */
 struct hv_get_vp_registers_output {
 	union {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index cecd2b7bd033..2dc65c1d3117 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -157,7 +157,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_set_register(HV_REGISTER_EOM, 0);
+		hv_set_msr(HV_MSR_EOM, 0);
 	}
 }
 
-- 
2.25.1


