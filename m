Return-Path: <linux-hyperv+bounces-7754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19319C7A210
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D87B4F4462
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481834CFB2;
	Fri, 21 Nov 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DONyoT9F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F483246781
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734536; cv=none; b=lWVFJNP2wXv7brYNqswDmIZQ/lIAQv3oz7lHrAivXrSmql10GcOd7J3mhr1/aHxdr/AUjROnmv+IfcpGPnzPZdJfX0OT14l3zHTesDfYf6otoxiDNPXNIth3k/LjdHgQY+WmPsSe7y6EDiKgOt6ON+d/HkI9ggf7Qs/mQ2oQZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734536; c=relaxed/simple;
	bh=g1UJH5JtvNvgdX2USl/WINIQov48rYguxDCviaub/NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW1yEEqNnhi6pvo/li9oHQsj9qcQJYDZM9t6C5P/K1B0LglG8Bw5uIt1Q4Wg+gMXUyIhtQQdkFXoV5zLoSG03iBfVK6dCxW8OOqvjNwVSjZycBT9FxVaAQWKNu2tv2N4S2HFkEYUblhCg4kvWQL0ULRX+c1JwYlyRPtWnbvslOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DONyoT9F; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so3599032a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734532; x=1764339332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0IUKyu7y63T4v570gIGGcoEle4ROUpd9KbIE9nAa3M=;
        b=DONyoT9FPEm+WIkZ/n52DY9GpJodFtN9qvmqXlxqjC/rkUFqmwKeMrZGYcizCZFWt9
         O1oALQ6ITVRozSlbS/i7hCVoI7zBGwg+4Bb7btTBonr9Gz3XwH4DrXpDwdT7utiW+SKC
         rOLh8DkUDUuBGO0krN3HcXVeHlM/6j60jSoGaS0RFhTr1vkJNyy7EgyvPEw2f9V2wOrG
         VpuRyEhPqZFC5z8xic5XQcc0/gRCDLWzCOZ82pNvNWrZll740IXaRhdHPhNKhw6QioQ2
         SOBTP7scFFuBdynWjZ7hhWv2/DstGEe6ps+s593doaK/8vMJ1LUBSDxu27OVyKR+eNII
         vLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734532; x=1764339332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0IUKyu7y63T4v570gIGGcoEle4ROUpd9KbIE9nAa3M=;
        b=m1CMV4n3e32We0y+6tCWO4QWZIlXu+eWYp2SPbmUWV0fNjHFTK6S2k+bn5hRJ4YiYa
         iErP0ivXpIKjulSd41WFiQKMvPawOLedzbqUZ5f88jECU5y3s5HkFDKslQW75nGelfKo
         /ejpG3o3lCyA+9KavFTMGICMCC0Ha+DJdLG4ft/gYgtwsTNmfwq+xjDFkfehwXcroHO8
         kPTlXn01jvybn3h+1L0HyhpS9JnddCN/eOwC+2BvEN6O67JgMdg/wObGB5a17wGVUQNP
         EQS3JrNrQ7LokE3Op3ozmK8wdaN35lKjGVBeLQoTunR1/V+NAaKYF8f3sKjOY0/aOSTI
         6WrA==
X-Gm-Message-State: AOJu0YxNaFBuPUGxYRswEv1o8ryr1r/3r7FQD/KClqkbqA0P+g3w0DNy
	8AsHxPpYtYrNuDI9rFHWDwj8rI7TJcT52Xc4JMnmgZG64pKm8RmZUeosjFI0mXHVJqs=
X-Gm-Gg: ASbGncubFZgqADFFSHwY0sNOC7olz3+uFggIaxUmy3Q5A2kgKOXNxwytRI3oBruLYCH
	n4z5IQjlguTcn0NYAqZXVK1E+GGNXvo4bIZQYa37Yl3PcvqFw5sGlGh6549McwD1RtNASAAiEVF
	sSfH440i0zWL58a+TCZbyJYbJVGc09CBWlPPqHXGf6pXG+y2b2kKNe6EwXEpZr1xyRCFCyix0Nl
	rmG6to9QGeyeZZc7HYJAh4H8AkNpPYrUs58RBPrQeZhLFB0cN6eAWbChyWgNzHlIyfVO1KEo87e
	908mZ2gaInUElxk4iEqCOhYVXr5rG4dqrVKSZHhqum2Hdy8fnkvZBvHAqv8SAQFcOMcRZfCpBxL
	PT80uiZuJUitafWQ+I+1wDwrIyw6AvrfYefDx94buxt+pDmW1naZNiWl2kG8/EccCaivuNoMAYU
	WIWkDSZwQypnA=
X-Google-Smtp-Source: AGHT+IFkdOzm+/94HwAgho2IF44MZyTaGiv2TSmNnbxHPFb5pZkOlldjx+YgMe1jibmL74fBG/D7bQ==
X-Received: by 2002:a05:6402:3513:b0:640:9cdc:aba7 with SMTP id 4fb4d7f45d1cf-6455468d55emr2417694a12.26.1763734531902;
        Fri, 21 Nov 2025 06:15:31 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm4609936a12.34.2025.11.21.06.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:15:31 -0800 (PST)
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
Subject: [PATCH v2 2/3] x86/hyperv: Use savesegment() instead of inline asm() to save segment registers
Date: Fri, 21 Nov 2025 15:14:10 +0100
Message-ID: <20251121141437.205481-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121141437.205481-1-ubizjak@gmail.com>
References: <20251121141437.205481-1-ubizjak@gmail.com>
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
2.51.1


