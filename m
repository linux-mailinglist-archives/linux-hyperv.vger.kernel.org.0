Return-Path: <linux-hyperv+bounces-9316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLZ1LHJEsWlCtAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9316-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:31:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085D26237A
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B42A13080347
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB23CEB80;
	Wed, 11 Mar 2026 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4/zNlN3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0C3CE4A8
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224845; cv=none; b=I997qhBwp6+xNmj34HJ1ZawFok5weYSqgVU1dFcMDQx/+7l5uDVIOMwVO1n/00Lcv4lYECet3k3N5ztbEufQeVNOvbOrZzHmmqbQwzbx6WVyeatURsUi6xfelDtzZQ6SxLkHI2VkwRIwP/vbO8OXr+I2bR4a/N93S9WW1R5k4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224845; c=relaxed/simple;
	bh=QOqdIysNMfx7osxoI2iP931xqvQTDt+cmUbB7PTG7ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHK2OCt/Q45PD2lNGP4kSESdetHf6H24UoUJQbO6CV7kA8g1tggYjGMcJOPzHVz7PMdwEnv7stqwJR7xep7NSjxezpQuongICtpaC4R29pQdASOaL6inXBx1Vc2EeZ2rfci+MbiAqfix+FHrOGOMBnFnzMKoxwYoz2ZA3MBz280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4/zNlN3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso126258685e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 03:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773224841; x=1773829641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KvIJT6o/htTBgHQbPACbqowNMagVBntVqvO+Ajv0GV0=;
        b=a4/zNlN3RWBsV4w+3hITupFAmFwSGQfb3QtAbNMh/XVWh5VbALXFoXwmNS5sAhVJpQ
         hKD9mGTq6bAqpQZfwrempqQLxdu7WDUqDUU9DbmK1E/7HrNLVLOjxshRw6qE+vzKsxv/
         6remVJiQcOjXl1Iozkrs75T/mxFG1l6xAVGOFKMLI/mXVbNtnN9/rC1MVeopSFPxN8we
         Pm4EMw3135b1l/ov7AQ9C8l8gbtRwYwujiflFt6iFEpWclvKiutE19vAYJWEV5Np4Nep
         NfLaHJFSxLyyKFS5hU5sFq8++V6+YT6Fp93NmUuEqrETMp26oi/e9c9FGG0UFrVCC1Bv
         DD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224841; x=1773829641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvIJT6o/htTBgHQbPACbqowNMagVBntVqvO+Ajv0GV0=;
        b=F2hs98BgihntKFULplMvO/vYhBGTtyxNegGoJ7bh6zkfD154AFS6Syd45GZx5YlIq2
         UT4wwI8e+YrgnEVgz5VNh6ED0gT9+rLZn/3Cj/FI8+/Zw0k+5PgWjzPdR8F4Chg2WbOI
         3QXGCbizGB1Z+sGjkNuRtIozn5dmX9kTqBnm3CYwuYU9xaYHVgK2j1SfXQfhSGiGM+KL
         s7fA9DN1RbMHSGobu8o1Gy+cUWd32KTpw9u1QpQV5zGYCZ6WiAazmp5lWFbnU1gJa2Tk
         r4r2ChoRRWTt2pJZFsrscq5BOPwICIQ1gPIoEuAbuVXvygo91VbBTWUnFsrKyHlcXccp
         6LXg==
X-Gm-Message-State: AOJu0Yw4wNIJImQFmBq40UXNSxWAD4TVYpvpmYp7fE+4zLORlisHxt32
	51cUQzSDI4sGbwBSdqj5vSmd+HfeEpLU+fd4+TNHOxAaZFj4FIlWBl81ECPIlZ4ex3M=
X-Gm-Gg: ATEYQzxNmW5/oInaN39F6hnbDD0gacPMbWDaJQEnWwVCxmXFFpTMMuFNiMLxesTCnls
	+635hTwn+e/6jdF0EoiFnMF+QVvVglGG5QrNMv5/IsjgjqJJTeFS/T01DKpX7IUCrlIdraN5tVb
	tRfp8mNrhcAcLKVQ1Y6tNh4L/CgMtSkJdaDum13H0V9WT2oNHoIgA1MKCOcytWCDza15Kl1XL8y
	pk+XZjGTuJezuD+39tt6SA3yO6xOGZTPWBNk3YIrx21lkGapcRc/NXK9ElPw6Cagvx7ny5qIWlb
	CeyYX45/Kqe7p5Va9oL5Qmuu2kFitUdIgsmRcFBnFrPBaM8DZD56A2bSUODkOoipHqC6hSj408f
	f+j3S5RF+4gTs6BKwPiozkKrgaxb2XhY3RUMRfCNbdNn6XbD+BbYIj+9ePIwou/GeLaVbNB7FRs
	scUXhK8ONFMcGBtUP5cIR25eWgnkKcGWjHwGF+L6kPcckn6DGPkSrbOL5fTXC6Nfa4H7SB5jSYO
	9rILomLg2YNKP4rei4gGHM6Dy3MIut7wKnSCJHAyWh25fUJ/wzuF4A=
X-Received: by 2002:a05:600c:3493:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-4854b126f35mr31133855e9.27.1773224840758;
        Wed, 11 Mar 2026 03:27:20 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm44534915e9.6.2026.03.11.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:19 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -hyperv 1/3] x86/hyperv: Save segment registers directly to memory in hv_hvcrash_ctxt_save()
Date: Wed, 11 Mar 2026 11:25:58 +0100
Message-ID: <20260311102658.215693-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6085D26237A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,alien8.de,linux.intel.com,zytor.com];
	TAGGED_FROM(0.00)[bounces-9316-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

hv_hvcrash_ctxt_save() in arch/x86/hyperv/hv_crash.c currently saves
segment registers via a general-purpose register (%eax). Update the
code to save segment registers (cs, ss, ds, es, fs, gs) directly to
the crash context memory using movw. This avoids unnecessary use of
a general-purpose register, making the code simpler and more efficient.

The size of the corresponding object file improves as follows:

   text    data     bss     dec     hex filename
   4167     176     200    4543    11bf hv_crash-old.o
   4151     176     200    4527    11af hv_crash-new.o

No functional change occurs to the saved context contents; this is
purely a code-quality improvement.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/hyperv/hv_crash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index fdb277bf73d8..2c7ea7e70854 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -207,12 +207,12 @@ static void hv_hvcrash_ctxt_save(void)
 	asm volatile("movq %%cr2, %0" : "=a"(ctxt->cr2));
 	asm volatile("movq %%cr8, %0" : "=a"(ctxt->cr8));
 
-	asm volatile("movl %%cs, %%eax" : "=a"(ctxt->cs));
-	asm volatile("movl %%ss, %%eax" : "=a"(ctxt->ss));
-	asm volatile("movl %%ds, %%eax" : "=a"(ctxt->ds));
-	asm volatile("movl %%es, %%eax" : "=a"(ctxt->es));
-	asm volatile("movl %%fs, %%eax" : "=a"(ctxt->fs));
-	asm volatile("movl %%gs, %%eax" : "=a"(ctxt->gs));
+	asm volatile("movw %%cs, %0" : "=m"(ctxt->cs));
+	asm volatile("movw %%ss, %0" : "=m"(ctxt->ss));
+	asm volatile("movw %%ds, %0" : "=m"(ctxt->ds));
+	asm volatile("movw %%es, %0" : "=m"(ctxt->es));
+	asm volatile("movw %%fs, %0" : "=m"(ctxt->fs));
+	asm volatile("movw %%gs, %0" : "=m"(ctxt->gs));
 
 	native_store_gdt(&ctxt->gdtr);
 	store_idt(&ctxt->idtr);
-- 
2.53.0


