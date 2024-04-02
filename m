Return-Path: <linux-hyperv+bounces-1903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0589573D
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27A61F26364
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E813AD06;
	Tue,  2 Apr 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c4LCPe/z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89F134751;
	Tue,  2 Apr 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068836; cv=none; b=qtJhY0RPc34FLNFMo7MsPWMWyjFalRwDwJY/+iDegNZztFHfjoCs1fIGkgjCSbEZtdaIuyk2/2QHOKB5syMS0FFXmouNXeS6N2Q3QTEUDsOwbFuTo1l9Mrihby8iIjoxvCVSxJzlaE1vRr95EZU5HFKUfnUf1bkkIbkRdtlC6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068836; c=relaxed/simple;
	bh=LGvutjpkGdUNLb7FeEjh/H5aVzdh5g2v+616cP5TxXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xqs1/kALw3J2JKaFs5ZL15+GNscTuPlgk2/eJ4UU5Oi2divsjlTUjTJNtR7ntNWRSHhNS1cGb21t3f2KhIE15Ul9uCNglfDQ9tu3/wP9QB6KS+zAWvirCpBiTYu4K1TVXVrXo8Y+rGaBV0Xc0jYKiB8Cbw5ThRvYY07XXcnzA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c4LCPe/z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 328A520E8BDE;
	Tue,  2 Apr 2024 07:40:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 328A520E8BDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712068834;
	bh=NV8rpG6eOQycLeq9uJr+csZD/Q4w+0yFEhPCcY4JMrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4LCPe/zMP74nz6m2C904jWcf7ExFFLWGbPWaQKkpKKBFvqb1Eq93PpIWG/ssJ+EH
	 Pa2CpkiQERpWvbAZbPR8FikEQ2XwPpRtuAevksfKmR2xluVy4y3979zSTlDCIzMSLh
	 OeXLjmHlxu8cMPA9ky04gz2dWmI1VS4vWb0qrlUc=
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
	peterz@infradead.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH v2 2/4] x86/of: Set the parse_smp_cfg for all the DeviceTree platforms by default
Date: Tue,  2 Apr 2024 07:40:28 -0700
Message-Id: <1712068830-4513-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

x86_dtb_parse_smp_config must be set by DeviceTree platform for
parsing SMP configuration. Set the parse_smp_cfg pointer to
x86_dtb_parse_smp_config by default so that all the dtb platforms
need not to assign it explicitly. Today there are only two platforms
using DeviceTree in x86, ce4100 and hv_vtl. Remove the explicit
assignment of x86_dtb_parse_smp_config function from these.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c          | 1 -
 arch/x86/include/asm/prom.h       | 7 ++-----
 arch/x86/kernel/devicetree.c      | 6 ++++--
 arch/x86/platform/ce4100/ce4100.c | 1 -
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 3efd0e03b916..04775346369c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -34,7 +34,6 @@ void __init hv_vtl_init_platform(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 043758a2e627..02644e010514 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -24,18 +24,15 @@ extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
 void x86_dtb_parse_smp_config(void);
+void x86_flattree_get_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
 static inline void x86_dtb_parse_smp_config(void) { }
+static inline void x86_flattree_get_config(void) { }
 #define of_ioapic 0
 #endif
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
-void x86_flattree_get_config(void);
-#else
-static inline void x86_flattree_get_config(void) { }
-#endif
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 003e0298f46a..0d3a50e8395d 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -277,9 +277,9 @@ static void __init dtb_apic_setup(void)
 	dtb_ioapic_setup();
 }
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
 void __init x86_flattree_get_config(void)
 {
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	u32 size, map_len;
 	void *dt;
 
@@ -301,8 +301,10 @@ void __init x86_flattree_get_config(void)
 
 	if (initial_dtb)
 		early_memunmap(dt, map_len);
-}
 #endif
+	if (of_have_populated_dt())
+		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
+}
 
 void __init x86_dtb_parse_smp_config(void)
 {
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index f32451bdcfdd..f8126821a94d 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms		= x86_init_noop;
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
 	x86_init.pci.init			= ce4100_pci_init;
 	x86_init.pci.init_irq			= sdv_pci_init;
 
-- 
2.34.1


