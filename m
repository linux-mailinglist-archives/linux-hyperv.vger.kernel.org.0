Return-Path: <linux-hyperv+bounces-8140-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14112CF2A00
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC73F302465C
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919B332EA0;
	Mon,  5 Jan 2026 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxecu9OE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB2332913
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603877; cv=none; b=V/uxlQMG+qjBSLGBsBdwQ++TXmaw5KkmbvuEFOyxPm93PC1JuW61PLgTguLPDSvQ5Vm2uBrPvtsAprSpVkWn/HpWPRCt16O0wcUWol8bIyeiAflfZmZ14AjB+ahq/V6Rlh35r++z7b0Ym3qQ/oWbSX2TcEXpPcHqPNHMQ6zS3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603877; c=relaxed/simple;
	bh=loaBc+S9gx5SefF69kEypUtGb1sSYutm3S9LGoMHCB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBRnJY3ph7DnqTvin5+gwmScNzAYUcuXAII4CKicNGUtR/fQ4k3cMH5lEqL8pSjID4HSs89zrpbHsDKJX6a1m7UuiFxoJ4fVOoH7ehvj+pXAxaZ7uibEmoTf6Bk8aa8tykyTOx1FU/C53wRITIYLOr3Tq8Dv89X/S3cFYtaCkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxecu9OE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so17225468a12.3
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jan 2026 01:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603873; x=1768208673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFyeVs291sZ8T07f6Gs8jIFIePxj6hgdTz6x9pMic/E=;
        b=Kxecu9OEcFkvpLF95oRiSByjxLzoAxYkBzLqAUmW1kkkTH30qdJ3yslFzB/F9lnRgn
         3nnWAsbiJFeyxSX8bPJNXuSEqGoQ84SQdzeolFSy5QYlomZMMG4gQVKo0Hd8NSxE0OLe
         ReZqGTpItwulXvCYbH6UYBCkAom5k+73DEOcHJp4hwvzhkcvHJdW4L5PetjiamUap7Jj
         tuMG2RQbf6EDZ5a33GPZHT8HH6If7MQMt7wH28fJ4ONsTFRNw/EFEcnFPiZ6H2FB+jQ8
         Bm91RzvoCdih+EksU6g4dGrwVWe6JXUoGocosiD/HwXNM/MQTD99jakYOe/xDe1Dsz8S
         QNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603873; x=1768208673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFyeVs291sZ8T07f6Gs8jIFIePxj6hgdTz6x9pMic/E=;
        b=nWSUZ1+JVF4NAC45tB2nnWbw4R4biRa1sxhOuRphHxdqBtkNd/tJpkorv00v44tTlO
         l/IHpAYywp2e6JsEzrHoxlZ68Go913RW6okkjfsoJQLCQRBRs4bUx3KKZOZN3XjFzTym
         woXveHxwiuCN0Qzs+RQn0iOhPlicBV39SvbjCQ6JB+13ADRuqCzsHcQm5ee7lZi16gya
         cgs5E4nbD23J5CdSprrukJodC8booRtTmvJbOmF9uNmh9E0OwLYO3DTDtbgaywO0dhEG
         VjtlFNKkEvUHqtYe7xnA8prqRD4lAUA4k4CXB4lCCZTLvZYDPQdR8I2x5yMa5z3r2agS
         SLCQ==
X-Gm-Message-State: AOJu0YxiOZqiYNw2vkk5k89yv2aLe4yGp5R/owIP4HFBTF8YK3Qwtmcd
	mmVKkMROUiy0sopcdizkMZqOBPw0YmaZrXLyc+RWXxFcrxuJgfSMnHrKcj373g==
X-Gm-Gg: AY/fxX7DAxvEyL3P+XChWT8QbRgIvsTQOgyWOskiH5V5XckKFaSlaKCod9BiS30dhed
	if/zqzrARfvWmWzV4Fsmmb5KT6qHg/vyrKhCgaJ15r/p6m0c0+IgDaMdTh0GX3n03v6nikMK3at
	kEOAdjRu3EkJzbGmPEvkxRzQdvJvYeVLKYZG80xGe+DkIY6GfgNLy2dZs7zXOQ6t32wOQN/o0j8
	acuqEIlv1S55+0iRIWOW1aOGflW0UE6dHqUWsFqvSosRid28LFwUWyOsNcbFzZnwy/jqM4p5mzw
	B0ze5xiS7/kPdSc2E7pBeUVgoVwVd2DeWm2AzxL2htq3gqM5mtC7ZKl3hNXXS4Q7Y1+wZrtPCSK
	IgMeZ4R8oXfYo72IOwHGfnFAcm6xmXb8fnnUkLzGyuG1orPz+hMGRsWTKTQ/APW5q1X46FITg+B
	rQ42LDLvNFqO1XjB9jp/mvGABNytjqmHSTQQFhONBExpc=
X-Google-Smtp-Source: AGHT+IG6R/QwWg98fdh9ZUhbh5oNNDrzwqktF8jdC68MqB05XeY2271qVPo4K3wegM1wYYuWMNSnmg==
X-Received: by 2002:a17:906:c109:b0:b80:325d:99e2 with SMTP id a640c23a62f3a-b803705ddb6mr5492183666b.33.1767603872588;
        Mon, 05 Jan 2026 01:04:32 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0de1sm5521794766b.40.2026.01.05.01.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:04:31 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND v2 2/3] x86/hyperv: Use savesegment() instead of inline asm() to save segment registers
Date: Mon,  5 Jan 2026 10:02:33 +0100
Message-ID: <20260105090422.6243-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105090422.6243-1-ubizjak@gmail.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use standard savesegment() utility macro to save segment registers.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/hyperv/ivm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 651771534cae..7365d8f43181 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -25,6 +25,7 @@
 #include <asm/e820/api.h>
 #include <asm/desc.h>
 #include <asm/msr.h>
+#include <asm/segment.h>
 #include <uapi/asm/vmx.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -315,16 +316,16 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	vmsa->gdtr.base = gdtr.address;
 	vmsa->gdtr.limit = gdtr.size;
 
-	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
+	savesegment(es, vmsa->es.selector);
 	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
 
-	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
+	savesegment(cs, vmsa->cs.selector);
 	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
 
-	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
+	savesegment(ss, vmsa->ss.selector);
 	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
 
-	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
+	savesegment(ds, vmsa->ds.selector);
 	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
 
 	vmsa->efer = native_read_msr(MSR_EFER);
-- 
2.52.0


