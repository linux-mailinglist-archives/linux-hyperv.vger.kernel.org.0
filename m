Return-Path: <linux-hyperv+bounces-1500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57354845FDA
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 19:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D331F294AF
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002012FB25;
	Thu,  1 Feb 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q/31eGNM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0512FB2A;
	Thu,  1 Feb 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811939; cv=none; b=ZPRUdU66nbtjJyF+Jn35QDx3Ypn8z3tYd5l5B+Io8HpoTGaeevy2BHvUyVV3bCdDz5y3CtNy2dtMyt6dObUixrGnM4LeafNb83oqJacyQeNvbgtsRrzaXpl3cW4mV4qX4+Z1H5drvXc0HA3TW3/lOSLEeQ2NoXgXzSMCtlUu1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811939; c=relaxed/simple;
	bh=LQBEIMnLecAl+vJ+XotE8XRfN49u42wwrviAFW3qf+I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IAoX0sxNYEE0o0CS1YmiVEcTOClwXzzpwY6V3fsEF8pPXPUvS5rwH4RmPuRG3v65C4bvYrIlnErrdRTtOWw/6mLFXrrZXyDfw0xjYv9jq0CRhDerpl/Bep1FoZac1FTeeXfjwigQMry/5yIH4nADi63FXlWns19jPduWU1+Y0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q/31eGNM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8D6220B2000;
	Thu,  1 Feb 2024 10:25:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8D6220B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706811938;
	bh=EHQDwjjVzZ88bNsS20/UDC5Vi19PhVaSrJVWsd14ed0=;
	h=From:To:Cc:Subject:Date:From;
	b=Q/31eGNMWcBfOQ+KNtygSmngPJY2nL7GC2U1wgdEVpRBsGTsLOLEMndTnqv5WHaTT
	 pSP/ltvKviNqhbMWLQExnA183YHM0RcThya3eQqnUTjwjgsnX6jd5FcsvCXjZTIR75
	 hkzQVXf2ufxwWrYCsgsToeO7pP66Je/TVA+ELMAQ=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	dwmw@amazon.co.uk,
	peterz@infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH] x86/hyperv: Use per cpu initial stack for vtl context
Date: Thu,  1 Feb 2024 10:25:31 -0800
Message-Id: <1706811931-3579-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently, the secondary vCPUs in Hyper-V VTL context lack support for
parallel startup. Therefore, relying on the single initial_stack fetched
from the current task structure suffices for all vCPUs.

However, common initial_stack risks stack corruption when parallel startup
is enabled. In order to facilitate parallel startup, use the initial_stack
from the per CPU idle thread instead of the current task.

Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 96e6c51515f5..a54b46b673de 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
+#include <../kernel/smpboot.h>
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -71,7 +72,8 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
 	struct ldttss_desc *ldt;
 	struct desc_struct *gdt;
 
-	u64 rsp = current->thread.sp;
+	struct task_struct *idle = idle_thread_get(target_vp_index);
+	u64 rsp = (unsigned long)idle->thread.sp;
 	u64 rip = (u64)&hv_vtl_ap_entry;
 
 	native_store_gdt(&gdt_ptr);
-- 
2.34.1


