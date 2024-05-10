Return-Path: <linux-hyperv+bounces-2088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F58C2872
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72C21F2635A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E986AC9;
	Fri, 10 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QYD/qgd2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1540172762;
	Fri, 10 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357188; cv=none; b=F4L81Mw2OIIUdep6NqSrI41QEktd0andGE1E7FBsjz4kIZycxvU2+iFbFYOYAbOg02achxlIqXTGSqgzTda6IjzPk7kIWFVXydl8G7ggGwigNEn2qHDg6AnS8Wnd/LSvkknjYt5xNCiJ8Y04un61hIH+YQUt26s1s9jEOXVpP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357188; c=relaxed/simple;
	bh=+ARAvmTH0xEHhWGY2pzMrCPUMF/Y9G/VRo68y4+oy+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Kmqqx1LowzBUyGKpQHpy9yGzYYByFMj1o8FZacW+tHRKB5CId1VrOX26k8+FHHxo1B3mUQoGmrXNi4KFUXkj1EJzfEKrTEa7+qQ0LgawzURoEdC3T1Ys4WNRESX3BQptxlQU+293+oehAyko+0dmoB4eQkx8YaAKgX2Tw+Ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QYD/qgd2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 859BB209122F;
	Fri, 10 May 2024 09:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 859BB209122F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357180;
	bh=Wa4hWhC80XW07zlGS45CsHMVVvWPCo0ufeD5PixgqZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYD/qgd2pBIMe1y+TbiB5ES/nFiLmdv0pMNkBv6PNqWvWiu462letgKIch1Gxtx+l
	 H3I0Lv08bRqcT+aM2LzVBmecesHx7ze7isIfCBY+9ijatuxCX66z8EYZcfkoE/FNgq
	 1QNbx2BIiW8Cj1Kck9sNZBXVxtDsTsYByq2l34ik=
From: romank@linux.microsoft.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH 3/6] arm64/hyperv: Boot in a Virtual Trust Level
Date: Fri, 10 May 2024 09:05:02 -0700
Message-ID: <20240510160602.1311352-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510160602.1311352-1-romank@linux.microsoft.com>
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

This change builds upon the previous ones to boot
in a Virtual Trust Level and provide configuration
for the drivers.

Also print the VTL the code runs in the new and the
existing code.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/Makefile        |  1 +
 arch/arm64/hyperv/hv_vtl.c        | 19 +++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c      |  6 ++++++
 arch/arm64/include/asm/mshyperv.h |  8 ++++++++
 arch/x86/hyperv/hv_vtl.c          |  2 +-
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 87c31c001da9..9701a837a6e1 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y		:= hv_core.o mshyperv.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
new file mode 100644
index 000000000000..9b44cc49594c
--- /dev/null
+++ b/arch/arm64/hyperv/hv_vtl.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023, Microsoft, Inc.
+ *
+ * Author : Roman Kisel <romank@linux.microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+
+void __init hv_vtl_init_platform(void)
+{
+	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
+}
+
+int __init hv_vtl_early_init(void)
+{
+	return 0;
+}
+early_initcall(hv_vtl_early_init);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 208a3bcb9686..cbde483b167a 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -96,6 +96,12 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	/* Find the VTL */
+	ms_hyperv.vtl = get_vtl();
+	if (ms_hyperv.vtl > 0) /* non default VTL */
+		hv_vtl_early_init();
+
+	hv_vtl_init_platform();
 	ms_hyperv_late_init();
 
 	hyperv_initialized = true;
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a975e1a689dd..4a8ff6be389c 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -49,6 +49,14 @@ static inline u64 hv_get_msr(unsigned int reg)
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
 
+#ifdef CONFIG_HYPERV_VTL_MODE
+void __init hv_vtl_init_platform(void);
+int __init hv_vtl_early_init(void);
+#else
+static inline void __init hv_vtl_init_platform(void) {}
+static inline int __init hv_vtl_early_init(void) { return 0; }
+#endif
+
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 92bd5a55f093..ae3105375a12 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -19,7 +19,7 @@ static struct real_mode_header hv_vtl_real_mode_header;
 
 void __init hv_vtl_init_platform(void)
 {
-	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
+	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
-- 
2.45.0


