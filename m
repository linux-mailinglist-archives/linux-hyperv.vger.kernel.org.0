Return-Path: <linux-hyperv+bounces-4142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D2A48AC7
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 22:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAABA3AE1CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FFA271821;
	Thu, 27 Feb 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CPtbNjbY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EE27181C;
	Thu, 27 Feb 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692851; cv=none; b=BS9vkcrl/KDJ2H+4/ltmM3GNi9oMskpLPSi9WJYs2a9Ir0nxF7+RnUkzkZGm/RhN8k/Z3A7hynHUmqYEBoj24B3YoGUAinFIft+MTzgdW99T8xI91dyzi29YuKCfApaCwUWrkiBhObNmUKa22KsegC37O07GtgB7eVLmRB5f6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692851; c=relaxed/simple;
	bh=WySDr8RJ9iCLor9PMBDB1y+NCIU0CrhEp2pDvg0Fxyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRVp7/WJiz4t2Rrpr0n2hUW9qhL5aPDKln9NgZVhj89H2ifTc38sGWC+RNvzXAB21ZHMt71NL9NeXvUNRHkLPyynfPEz/NlMfjIsr9vJFQ8RIErv4Tfs1BZPlY0lPVjNt5YiazAfJrgDCWHhSqh2crX+leb9NyQyEukUx/kiaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CPtbNjbY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E74CC210EAC2;
	Thu, 27 Feb 2025 13:47:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E74CC210EAC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740692850;
	bh=s3v611mj9neOZEEDQBmvrzVPT6h/ZL3vkxwXr7kCv58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPtbNjbYUG3bYxCW8gfwP1wQq74PCAZUa65DuX8Trtd2vyGokSj0v1R1J50MrDtEO
	 B7XHRom2pFp7sEheXbWuuDj/gESJpE7mQcPhod6solvor+LjwBLuDZsD6e17p9CJMq
	 SN63NDFXZMjXgR84Hg1pTYpHw6RTWjsmg0NZgXuc=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 1/2] x86/hyperv: Add VTL mode emergency restart callback
Date: Thu, 27 Feb 2025 13:47:27 -0800
Message-ID: <20250227214728.15672-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227214728.15672-1-romank@linux.microsoft.com>
References: <20250227214728.15672-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, X86(-64) systems use the emergecy restart routine
in the course of which the code unconditionally writes to
the physical address of 0x472 to indicate the boot mode
to the firmware (BIOS or UEFI).

When the kernel itself runs as a firmware in the VTL mode,
that write corrupts the memory of the guest upon emergency
restarting. Preserving the state intact in that situation
is important for debugging, at least.

Define the specialized machine callback to avoid that write
and use the triple fault to perform emergency restart.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4e1b1e3b5658..4421b75ad9a9 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
+#include <asm/reboot.h>
 #include <../kernel/smpboot.h>
 
 extern struct boot_params boot_params;
@@ -22,6 +23,27 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
 	return true;
 }
 
+/*
+ * The `native_machine_emergency_restart` function from `reboot.c` writes
+ * to the physical address 0x472 to indicate the type of reboot for the
+ * firmware. We cannot have that in VSM as the memory composition might
+ * be more generic, and such write effectively corrupts the memory thus
+ * making diagnostics harder at the very least.
+ */
+static void  __noreturn hv_vtl_emergency_restart(void)
+{
+	/*
+	 * Cause a triple fault and the immediate reset. Here the code does not run
+	 * on the top of any firmware, whereby cannot reach out to its services.
+	 * The inifinite loop is for the improbable case that the triple fault does
+	 * not work and have to preserve the state intact for debugging.
+	 */
+	for (;;) {
+		idt_invalidate();
+		__asm__ __volatile__("int3");
+	}
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -235,6 +257,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 
 int __init hv_vtl_early_init(void)
 {
+	machine_ops.emergency_restart = hv_vtl_emergency_restart;
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
 	 * and here is the earliest it can be used.
-- 
2.43.0


