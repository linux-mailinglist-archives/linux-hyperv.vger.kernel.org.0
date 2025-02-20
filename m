Return-Path: <linux-hyperv+bounces-3996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86622A3E5C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B040B3BC741
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DD21480E;
	Thu, 20 Feb 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oS1yVVN0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153651F03D2;
	Thu, 20 Feb 2025 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082986; cv=none; b=e8m5vi9j0MelZD924STZMQ7ALbXTMJCqk2u4ipFKBmkRWN6gKXZd8bGqUGgN8/9hnWQZTNfVgCbA6k3n9qcoyW2E6A0Dx/CBiid/Zoaq2uI3THEA8ZnlI8kmWawqrTMdOK4ZHC3y0wT1QWme7WWJGj0IYK+Hhs8J854lbc4f2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082986; c=relaxed/simple;
	bh=WySDr8RJ9iCLor9PMBDB1y+NCIU0CrhEp2pDvg0Fxyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r15wOe3gXUJBGy+pOTNB7LKt2mFqUWGqfwogTpRdk9YnTk7ROiC5a7TRkry9uh8xehNFr1p2tqcE6ZVsKGen8LdEV69QWvrws8NkvSp7abQgKpm1CJAA1b+sMDBSU9LL9mCaGggN4KS14XtC/4iSMczMn0QURPvfL/nE2CrHIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oS1yVVN0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7EB61203EC37;
	Thu, 20 Feb 2025 12:23:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EB61203EC37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740082984;
	bh=s3v611mj9neOZEEDQBmvrzVPT6h/ZL3vkxwXr7kCv58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS1yVVN0v1oyA1YYHy29V524JK/aEhr73LKdMdMRFo3zXoCx3MpGmkQFqQgd5zXvE
	 3l4ec6J8OyP/bMhJC7q/qsbEENpZ/xijTcjlF5KaBuUbgOLw5NN5S6FpWxIlWqfm/u
	 qXLF1JrNPx6PFgX5y7rnKzg5arUV3fjZZ+mx0YCw=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 1/2] x86/hyperv: VTL mode emergency restart callback
Date: Thu, 20 Feb 2025 12:23:01 -0800
Message-ID: <20250220202302.2819863-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220202302.2819863-1-romank@linux.microsoft.com>
References: <20250220202302.2819863-1-romank@linux.microsoft.com>
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


