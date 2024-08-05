Return-Path: <linux-hyperv+bounces-2720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24563948302
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2024 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B288FB21E72
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75C16BE31;
	Mon,  5 Aug 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUwB+bb9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308016C680
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Aug 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888774; cv=none; b=c8g3uo+CsEg/zUMn7/AxnQnMD6cLN18p8XezG7hVsKFpO0RHpG25ucmwMKowO2n3JO9LP9bD0AdRChhNEMR1sXo3uUtTk3OGUutGtb/5Ai+gaNpu/fF89KbwiaxNHZd1bTKohGHGzFWdGCD5S2z6dnJh8l9faNtgWPMIQ3aXEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888774; c=relaxed/simple;
	bh=jij8aP42T72ubwaJKx50J9XfLi8cZ7pA+OPSpaf44y0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iGKkZ26F39Np5ZleKfH+8lhNvxxZbLVbZ43ttSvEd5mWO3XwQ2qNmoaoZJj6VPLG5qgEQaD7/qboOvFPvk5k6P443xhSA4A/p4q5M5Z86WcjBBryJpKO1iCoMS6g2YYha5jbOZs08xT13j7pb5qAcCV2f259kTP1x0U0kB72pGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUwB+bb9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66a2aee82a0so74247b3.0
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Aug 2024 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722888772; x=1723493572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vAM13V73+JGoi3sB94ylLbhhxyQ11c/DL05/0xsi6Kg=;
        b=qUwB+bb98Q1FKW83pvbYeE1E4szPSYsJ4q4jKlP/WkrfiX1Gbi1eByFCPVYXhTPIY2
         SSNxbjHHwGgM+T8ujYZbh2y13WtjEHVZ9gDsq47vYiIc5w7B+l5r2ym2iHSvKH2i/O3R
         psQUCI+SVRE1wcRTumLhybs5mhwhvEJyfp+Wem5KC+5GePy6bkd4pvUFFYXEqktkCWcr
         +lIyzEHMEA/lBAYNMVOP15PpodJfkxKskdONc16suKc3pgpeBcHhNKr0x74d5GWpQOxL
         jFt1eaqI7dAS20LwT+TwUia6qE3qBcZPfTX/sdzvBdVaT0M39gAyHXrGuOx8ve1mlpFl
         Up8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888772; x=1723493572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAM13V73+JGoi3sB94ylLbhhxyQ11c/DL05/0xsi6Kg=;
        b=wworPOaaRijqjgzM2i6FRwywdYdh4K/kIOWMO28iKJSozdi1QC+DUxb4bNF25LqKad
         j926rKc/5KNuYUSSwTfkgB+ENWDulK9G49DtCSI5IO/SXlCQHtl40FwLJzLngxDyAoJM
         PZUQr35dDWmm9k3heDC/l+phAH4nE2e/kUWkyL9NzPmnWKTem/uWSNJnoHl8WJieoGfc
         ZL7VccbfLTsVjLzaGMe2i6C0vqkPVLkJ9SCEKVgIox4F3oItHChuzfcCCd892MdaFVFZ
         JrM+lsN1N2rfeeV9ESQAsViOGAJNOo6p7zlI9J6L9MJZQOVMk6YaSM21Ar0iM9eJaqIm
         yP1w==
X-Forwarded-Encrypted: i=1; AJvYcCU4L/vSVXD6CGdt2R+WBXERKyX46MVAXn1JAlFn9JUwnZq0B5HG1BvkydqTPUvZT7lqFkY2K44ykRc4DI7vTugPVg98XQHo3ZPXCXKz
X-Gm-Message-State: AOJu0YykYd0387MrpPWoZvf+Z3fAyyZdgB6t7qwYyHPOxwiW5LZPZ9RG
	q3kHVIKLXoDgk1LyYMt5KvlSLAVUAr6AKM9MrtwPcGDgWcSP9DIO8NqnxgzLq9YMKDdQY4s5cwQ
	oBAR3m+RNQDrppNW8tg==
X-Google-Smtp-Source: AGHT+IGk/lHUMF+5u6MZhgz9dYRcC6aVot88Xvor1TNAzmg3/V3f7iRracYHyGVxtZnEX5KCpV8/IHrD+bjnZQWT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f06:b0:68d:52a1:be9 with SMTP
 id 00721157ae682-68d52a10ef2mr1180357b3.1.1722888771583; Mon, 05 Aug 2024
 13:12:51 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:12:47 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201247.427982-1-yosryahmed@google.com>
Subject: [PATCH v2] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
From: Yosry Ahmed <yosryahmed@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Use native_read_cr*() helpers to read control registers into vmsa->cr*
instead of open-coded assembly.

No functional change intended, unless there was a purpose to specifying
rax.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Fixed a silly bug that overwrote vmsa->cr3 instead of reading
  vmsa->cr0.

---
 arch/x86/hyperv/ivm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7cb..60fc3ed728304 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 
 	vmsa->efer = native_read_msr(MSR_EFER);
 
-	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
-	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
-	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+	vmsa->cr4 = native_read_cr4();
+	vmsa->cr3 = __native_read_cr3();
+	vmsa->cr0 = native_read_cr0();
 
 	vmsa->xcr0 = 1;
 	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


