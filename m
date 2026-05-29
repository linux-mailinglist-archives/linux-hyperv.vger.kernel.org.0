Return-Path: <linux-hyperv+bounces-11335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBlHMNWoGWodyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11335-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:55:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEA660408D
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6A2F30B5BA6
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6B3F39ED;
	Fri, 29 May 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZflyEy1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DC3F8890
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065909; cv=none; b=Vp8npdlHm+8jfPdleomHSv65nAk40FZdLu9ujnMmorJzl/y0lU6UI02klLh8GSpK0hg94yR1RAItktQUctje5snnPcKuivsw1ayTPIV/llgw3jUXqTiwmMbT60mv5mQ1/acNFlSv1xHAvLMn4U+GisNFdqJatu5e0Kb12y8eltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065909; c=relaxed/simple;
	bh=WHi2AWvhDQvTEIPut9U48s/z4C+6DTwQMXjBVRNgv1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6clWo/BTGUbl5CkUonFkuSuxVXN6Ne8jYTWHJIFTpYj5MLoIBgDnAPMrGulES0C7cqxEqUf5xhyMAETQkqQmNNtBfB1yaEs3QkVDUFh2sWcgiiTIEeSdFrRAKTByCUaOm6bI3XJ/XKEreZ0C/AY1Cvqi3OC1fQQr+cppgmEy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZflyEy1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso112501065ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065907; x=1780670707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ7qyLV4Qg2/G7AZdfT7QLEMZtHiHfovzBdDbSmwy9M=;
        b=TZflyEy1vXcPT+mMlxETjxGB442PHHrQ3KtbjHbPVPy67lAEDR3oUASgqwmYjMqlQd
         e0oE7WW+J3P2Ij9tYaA/XRQg2ZXOimU1UtF0Mn9RUIbjwO/oVv8EacuAa4yOVcX+Fk/t
         AfIrkWcTVG59xXMhS+s32WW9ccnOsWBeKNgJvl/jQEiSRI3PA/W55xqCexy3t1YLy9ED
         Qk2mYc+dW9WPNxp8h65XQCoNWDPeiNO0cETnSiBcqiXy2gt3ua360gKb2lF88XjB81uG
         J+/eVcv2OiKN3kji2t+B6lCi82EjhvZOL6nUl1Iwto2afOKWCON90BZwBr/80UP5lffv
         j+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065907; x=1780670707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ7qyLV4Qg2/G7AZdfT7QLEMZtHiHfovzBdDbSmwy9M=;
        b=k6MYeC9qUKuUMA8KgboszlXLxPNDMuHjJLicNy+A6absErX5E2cCciagoVzV0u6yQU
         MC3nhJCzKPYimZXbGZ5IAvYk+5FGLj6gu6WylHxhU2GJSN1QnSD65tbzw3zM9Ta6YmRP
         lh1FVMKivivpxB8pbS480yVQ+S1saGvX3JNC0SKqAtTb+0teoR9u9zKlkwBHeoxlkHNJ
         zTjXW5Ry5wYJnuNmkYy21WYrt5If+XEUdWSBeruTsbvxlW06IErPSVFB7bEDj8mLxxHT
         j/oCHx5YUhgmD3BHAM8EcMM3ClYIcnKhD95Do0ZI5fl+QMlDzYKESuT7RPMyUHKKBRiE
         /29A==
X-Forwarded-Encrypted: i=1; AFNElJ8TxO59ufhgZeRhf8/3wMqR+8suseNDIHm7Jn2obOuR4Kei1SdMDuGliHG4aEEAEO5c+nH+jk/gBEj8iuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPosVjnVCh+phr2VDpWQQMzo6yCC0lxNXvWU7jhrg16QbeOe5
	ZUALf0FvGFRFQsDu0iywycMlobOhaG6jqGXPjJvlOAIzUPbvX6qRWCx+GRkbrjI0cBIbcvmbXJP
	gPWHb8w==
X-Received: from plblk13.prod.google.com ([2002:a17:903:8cd:b0:2bf:1cdf:9e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f785:b0:2bf:b17:ae3c
 with SMTP id d9443c01a7336-2bf3684e2c2mr1144355ad.25.1780065906739; Fri, 29
 May 2026 07:45:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:00 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-14-seanjc@google.com>
Subject: [PATCH v4 13/47] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11335-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9DEA660408D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fold the guts of native_calibrate_cpu() into its sole remaining caller,
recalibrate_cpu_khz() to eliminate the extra SMP=n #ifdef, and so that it's
more obvious that directly invoking the early vs. late calibration routines
in determine_cpu_tsc_frequencies() is intentional.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 534462c81c78..3e911f0f7364 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -945,21 +945,6 @@ static unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-#ifndef CONFIG_SMP
-/**
- * native_calibrate_cpu - calibrate the cpu
- */
-static unsigned long native_calibrate_cpu(void)
-{
-	unsigned long tsc_freq = native_calibrate_cpu_early();
-
-	if (!tsc_freq)
-		tsc_freq = native_calibrate_cpu_late();
-
-	return tsc_freq;
-}
-#endif
-
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
@@ -968,7 +953,10 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
-	cpu_khz = native_calibrate_cpu();
+	cpu_khz = native_calibrate_cpu_early();
+	if (!cpu_khz)
+		cpu_khz = native_calibrate_cpu_late();
+
 	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
 		tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
-- 
2.54.0.823.g6e5bcc1fc9-goog


