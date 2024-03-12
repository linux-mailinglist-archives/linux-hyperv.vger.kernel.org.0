Return-Path: <linux-hyperv+bounces-1739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C7F879FA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 00:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA0DB2161C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 23:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B746551;
	Tue, 12 Mar 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kxGgPj9G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FED26286;
	Tue, 12 Mar 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285695; cv=none; b=HXIoeksZBEOjM3QcBW5FP3PsYNYuZcVZAQzdhjheTqZ70LI+fHnCEzhnyVbPgR3yXY18aQy+OY8/R9zi0N8cog90R7ayNZAd/vIb1p8jvdtZ/qKE1Sag1r8U/HMzPJ2l0hjzs6aplhJNX59nr9cey/vLclTB5o2zy+Gl7PjUpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285695; c=relaxed/simple;
	bh=l+PQQeX29hSIYRsGK1E3f+tT9i3VuGNzzWMESaSJlkk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sUUJxXk4idQMjWRqxSNrEiaRdg0USMqkWdMarvLDTkuV7JEHEQTCmJjZn+1Jlk8G21B1/lJywNlWe0sq1pbv7iV1JCGMueQ5GcjNTNDmAWuulHf+zlinf/5CjjXKJyD60EzIz+T4vyCaKPMEnJwdFRbTKPMO6xbUbdwlPFxJ9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kxGgPj9G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E49120B74C0;
	Tue, 12 Mar 2024 16:21:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E49120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710285693;
	bh=tYBQWRvnBjxq98SdJfkL9cZnOn2TzWgczlpG8jTrEPc=;
	h=From:To:Cc:Subject:Date:From;
	b=kxGgPj9GySi9b7OwPqzycLrmw1f8UYvo7R4+lMUvfrGpK7szA/FysjSeV0ID33dgZ
	 WZjOyjsLmn2M3PKvr9dZo0YYxVoGtHCvK2IOTkccOHF7GhRPyXH3E3gRVf6xhT/Kie
	 x+vbPy4aC3L7oIi4yhJoBK/chyziKwlkzge7Xu2s=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	mhklinux@outlook.com,
	mhkelley58@gmail.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	tglx@linutronix.de,
	daniel.lezcano@linaro.org,
	arnd@arndb.de
Subject: [PATCH] hyperv-tlfs: Rename some HV_REGISTER_* defines for consistency
Date: Tue, 12 Mar 2024 16:21:27 -0700
Message-Id: <1710285687-9160-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Rename HV_REGISTER_GUEST_OSID to HV_REGISTER_GUEST_OS_ID. This matches
the existing HV_X64_MSR_GUEST_OS_ID.

Rename HV_REGISTER_CRASH_* to HV_REGISTER_GUEST_CRASH_*. Including
GUEST_ is consistent with other #defines such as
HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE. The new names also match the TLFS
document more accurately, i.e. HvRegisterGuestCrash*.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c          | 14 +++++++-------
 arch/arm64/hyperv/mshyperv.c         |  2 +-
 arch/arm64/include/asm/hyperv-tlfs.h | 12 ++++++------
 arch/x86/kernel/cpu/mshyperv.c       |  2 +-
 include/asm-generic/hyperv-tlfs.h    | 16 ++++++++--------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index b54c34793701..f1ebc025e1df 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -160,22 +160,22 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 		return;
 	panic_reported = true;
 
-	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OS_ID);
 
 	/*
 	 * Hyper-V provides the ability to store only 5 values.
 	 * Pick the passed in error value, the guest_id, the PC,
 	 * and the SP.
 	 */
-	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
-	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
-	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
-	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->sp);
-	hv_set_vpreg(HV_REGISTER_CRASH_P4, 0);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->sp);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, 0);
 
 	/*
 	 * Let Hyper-V know there is crash data available
 	 */
-	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
 }
 EXPORT_SYMBOL_GPL(hyperv_report_panic);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 99362716ac87..03ac88bb9d10 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -46,7 +46,7 @@ static int __init hyperv_init(void)
 
 	/* Setup the guest ID */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
-	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
+	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
 
 	/* Get the features and hints from Hyper-V */
 	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
index 54846d1d29c3..bc30aadedfe9 100644
--- a/arch/arm64/include/asm/hyperv-tlfs.h
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -37,12 +37,12 @@
  * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
  * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
  */
-#define HV_MSR_CRASH_P0		(HV_REGISTER_CRASH_P0)
-#define HV_MSR_CRASH_P1		(HV_REGISTER_CRASH_P1)
-#define HV_MSR_CRASH_P2		(HV_REGISTER_CRASH_P2)
-#define HV_MSR_CRASH_P3		(HV_REGISTER_CRASH_P3)
-#define HV_MSR_CRASH_P4		(HV_REGISTER_CRASH_P4)
-#define HV_MSR_CRASH_CTL	(HV_REGISTER_CRASH_CTL)
+#define HV_MSR_CRASH_P0		(HV_REGISTER_GUEST_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_REGISTER_GUEST_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_REGISTER_GUEST_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_REGISTER_GUEST_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_REGISTER_GUEST_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_REGISTER_GUEST_CRASH_CTL)
 
 #define HV_MSR_VP_INDEX		(HV_REGISTER_VP_INDEX)
 #define HV_MSR_TIME_REF_COUNT	(HV_REGISTER_TIME_REF_COUNT)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 56e731d8f513..909a6236a4c0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -450,7 +450,7 @@ static void __init ms_hyperv_init_platform(void)
 				/* To be supported: more work is required.  */
 				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
 
-				/* HV_REGISTER_CRASH_CTL is unsupported. */
+				/* HV_MSR_CRASH_CTL is unsupported. */
 				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
 				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 32514a870b98..87e3d49a4e29 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -636,14 +636,14 @@ struct hv_retarget_device_interrupt {
 /*
  * Synthetic register definitions equivalent to MSRs on x86/x64
  */
-#define HV_REGISTER_CRASH_P0		0x00000210
-#define HV_REGISTER_CRASH_P1		0x00000211
-#define HV_REGISTER_CRASH_P2		0x00000212
-#define HV_REGISTER_CRASH_P3		0x00000213
-#define HV_REGISTER_CRASH_P4		0x00000214
-#define HV_REGISTER_CRASH_CTL		0x00000215
-
-#define HV_REGISTER_GUEST_OSID		0x00090002
+#define HV_REGISTER_GUEST_CRASH_P0	0x00000210
+#define HV_REGISTER_GUEST_CRASH_P1	0x00000211
+#define HV_REGISTER_GUEST_CRASH_P2	0x00000212
+#define HV_REGISTER_GUEST_CRASH_P3	0x00000213
+#define HV_REGISTER_GUEST_CRASH_P4	0x00000214
+#define HV_REGISTER_GUEST_CRASH_CTL	0x00000215
+
+#define HV_REGISTER_GUEST_OS_ID		0x00090002
 #define HV_REGISTER_VP_INDEX		0x00090003
 #define HV_REGISTER_TIME_REF_COUNT	0x00090004
 #define HV_REGISTER_REFERENCE_TSC	0x00090017
-- 
2.25.1


