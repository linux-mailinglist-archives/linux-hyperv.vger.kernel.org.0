Return-Path: <linux-hyperv+bounces-4094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C97A47243
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2022165963
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC691DE2A7;
	Thu, 27 Feb 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcQl/qQx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7F1D9694
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622761; cv=none; b=ax1Umd/6yxclwET+YqhtMPyitj3iORJFbXp1EYIOo/HK1u+QjUB5p9SpSqvCoO3yxpB0Vg20Jp+ohwGUJKIUz+w6rSBURgSYujv2CasOfgHoi3Ih4bPSbgs6CJedtIicRCCwnCjUVc4gbmvkoNIWifgN6D8MOI1TW73b6Uu7zTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622761; c=relaxed/simple;
	bh=M+VN5C0boRzeU19KeJ4QoMy1PkpWXwTcpvT2+bfg0Lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ny/G/zPNZ6sXhizxT8Ul1YOSg/sQtbZlf3H43mlDx1bCU06au/ff2S1o3hqr2ADe/bAMzqfi8aF0x2Fv3iSMgrWistXiSJMlGH0fymy7LCeHR3PYAEyGBRguXrGprv5Yv8szWkjlokIXK+57u5jhmKpIh656gke/lG22sXUpWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcQl/qQx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so1539242a91.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622759; x=1741227559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=M9J4vMOsFh+KFESDavQmkJXQ4sHD+OspEOtA7Gz9lOo=;
        b=PcQl/qQx/3b2oed4omjjhJihgSYATZ8Br5IF4lqggDiSUwykE5khbL2NWnA8RgmNpc
         xAtdkxs4jIgY/q5ISfp5AWXO/9gicxgI/RDLrWr7vQGu1HsVEFQttaWI71IIM+g6NICt
         2ahJrsrNA4qHDYYB07k7utFv1wfcpPQMU2Vck6VZ4uG1LJAF6FLqZLk6XyKh6wbFmXrs
         A957TvtKJMWtRu2vjGUAkNsNsYWQUCGTyWILV+VAjZds94gVK9Marphz0lTP19i0HTJ9
         GBlm9bjD6ymW2TwrfGx6c4YiONQD8knBMAtpTi8YGMMYO/HICap2/IfQbSK6bQdbWGSD
         qoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622759; x=1741227559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9J4vMOsFh+KFESDavQmkJXQ4sHD+OspEOtA7Gz9lOo=;
        b=YfJ9DiYRSDUyQIrLsSSAevybLlP+H3v8i2oOgiEKvzraaPWUkikpDXp2XYFI/sCg55
         86OE+EH5J7OOk02dTvUQ42IpsU4sTIgfuzSwMZrKoZmOszw/sDy8H5KQZY1tg9mj+vni
         UlpSMyssI6xaurWvYVIfDw19dDWuaRivx9wt+H+Csj1a0kCFBHdDtC1rS2HmkBxp7vxK
         xvV328vFAXYnchVnxQG+tw93/l1SXLZowb0yAoNO3xgFhNFp0JnlZcAE4+sLrHUnkZoO
         8Lt5XJFKKXImQgtbbRp310a952Mpqj/IJJ1DSM4ah5Qq7pbNxkaS4uQGvFxUIANBIzCq
         wlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUFCptU0LP4P9ji60sti2z5OueYY6SElrsZM1S8DO0FHMVXPmCMAelUZSgpGD4Nur5S10tmDMtQS0o8QeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ43EESn+bvN5OAmTyXBH3mzJRkAJnefP1I01+xV4K6E3GX4/G
	aRQTwbusgK89OCHEbuQOTBr19y67bvvn7CF9diEmo6Iges+2vO93UYAxcaHNNXTcx0jsUBYwPuJ
	JGQ==
X-Google-Smtp-Source: AGHT+IHGg2YNnpdN9W11waKGKjVdoMsbSztU341tlOE27g2wibRX2aXDt93sxEvHQRpF0p5gOf3qjCfl60c=
X-Received: from pjbsn14.prod.google.com ([2002:a17:90b:2e8e:b0:2fc:15bf:92f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc5:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-2fe7e32b7c8mr10195616a91.17.1740622758747; Wed, 26
 Feb 2025 18:19:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:25 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-10-seanjc@google.com>
Subject: [PATCH v2 09/38] clocksource: hyper-v: Drop wrappers to sched_clock
 save/restore helpers
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that all of the Hyper-V timer sched_clock code is located in a single
file, drop the superfluous wrappers for the save/restore flows.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/clocksource/hyperv_timer.c | 34 +++++-------------------------
 include/clocksource/hyperv_timer.h |  2 --
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 86a55167bf5d..5a52d0acf31f 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -471,17 +471,6 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
-/*
- * Called during resume from hibernation, from overridden
- * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
- * used to calculate time for hv tsc page based sched_clock, to account for
- * time spent before hibernation.
- */
-void hv_adj_sched_clock_offset(u64 offset)
-{
-	hv_sched_clock_offset -= offset;
-}
-
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
@@ -545,12 +534,14 @@ static void (*old_restore_sched_clock_state)(void);
  * based clocksource, proceeds from where it left off during suspend and
  * it shows correct time for the timestamps of kernel messages after resume.
  */
-static void save_hv_clock_tsc_state(void)
+static void hv_save_sched_clock_state(void)
 {
+	old_save_sched_clock_state();
+
 	hv_ref_counter_at_suspend = hv_read_reference_counter();
 }
 
-static void restore_hv_clock_tsc_state(void)
+static void hv_restore_sched_clock_state(void)
 {
 	/*
 	 * Adjust the offsets used by hv tsc clocksource to
@@ -558,23 +549,8 @@ static void restore_hv_clock_tsc_state(void)
 	 * adjusted value = reference counter (time) at suspend
 	 *                - reference counter (time) now.
 	 */
-	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
-}
-/*
- * Functions to override save_sched_clock_state and restore_sched_clock_state
- * functions of x86_platform. The Hyper-V clock counter is reset during
- * suspend-resume and the offset used to measure time needs to be
- * corrected, post resume.
- */
-static void hv_save_sched_clock_state(void)
-{
-	old_save_sched_clock_state();
-	save_hv_clock_tsc_state();
-}
+	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
 
-static void hv_restore_sched_clock_state(void)
-{
-	restore_hv_clock_tsc_state();
 	old_restore_sched_clock_state();
 }
 
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index d48dd4176fd3..a4c81a60f53d 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -38,8 +38,6 @@ extern void hv_remap_tsc_clocksource(void);
 extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
-extern void hv_adj_sched_clock_offset(u64 offset);
-
 static __always_inline bool
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 		     u64 *cur_tsc, u64 *time)
-- 
2.48.1.711.g2feabab25a-goog


