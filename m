Return-Path: <linux-hyperv+bounces-3717-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F34A158CC
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0585D3A957E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE01ABECA;
	Fri, 17 Jan 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L6OeJMm1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7A1A840F;
	Fri, 17 Jan 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148031; cv=none; b=UwwoUsPbFtp429dQxFVE7lNblcJ50xsQKjq/vOBeLICOOv1yQJIP1gIfnXLy5mWuTT4aWPJMqZpGiJu2VXTD8ArOMJgYl2RkJs/617XOoaAPMhr8pgkbyJCT45FpjnK8GEVpnLY8cTHU7W3Ia6xYNC/avMCpf4MCi4W7Qsppgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148031; c=relaxed/simple;
	bh=4DRmFZL33flA99Dxn4A9g9hQRa8egvlNtxMFDJPT8c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gM8LaYBArQMy2GYMobq7QLcY5rFGr7rI0AMTPB95WN5hZfXaxTcpl6haD5AnyeapcYOjRmkJj6mIzQbt7Ps+wtM4Yw0ws0XP/EQd3nWDknKp9xdtvhXBCqK/R8TGj1HUZMKYIpoFcWeYEGPWgIUQNawgGhjPfPmH3GVXw64JP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L6OeJMm1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D06492064B01;
	Fri, 17 Jan 2025 13:07:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D06492064B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737148024;
	bh=M08nDMJ94JRpn5ioYQ7gppAO+ty5LQQcej4/DPtujuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6OeJMm1Zm9WVCRfU+VykE/bJs5yIkFxUE00D6yCe1CM7x6SoUA0uwiYZrRgxZ9I6
	 OAX4CotWBBOt9TzcNmz2dbcDpBg8qQgy/1LWjDczS8izT94Qg57bWg+oDmPXVNgLen
	 P3FwNRVyA6KNZiDwd/xvprpkXHereNNhJlfwDTao=
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
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH hyperv-next 1/2] x86/hyperv: VTL mode emergency restart callback
Date: Fri, 17 Jan 2025 13:07:01 -0800
Message-Id: <20250117210702.1529580-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117210702.1529580-1-romank@linux.microsoft.com>
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4e1b1e3b5658..8931fc186a5f 100644
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
@@ -246,5 +268,7 @@ int __init hv_vtl_early_init(void)
 	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
+	machine_ops.emergency_restart = hv_vtl_emergency_restart;
+
 	return 0;
 }
-- 
2.34.1


