Return-Path: <linux-hyperv+bounces-152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E547AA80A
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 06:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 28AEC1C2091D
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1E659;
	Fri, 22 Sep 2023 04:58:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E6639
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 04:58:46 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6629B192;
	Thu, 21 Sep 2023 21:58:45 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1BED212C5B7;
	Thu, 21 Sep 2023 21:58:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1BED212C5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695358724;
	bh=+yXMZYNsMsvn2jwwDbQl1ZwR5DmyfHWdhUieAsjjntE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZV8FpA5rQIGeeqhPqT4DBWcgP+m3qnVc4ZFfXauyHrMtr98EOzQ1wYPpgAl/NxFTM
	 cM2GWtz3RpyVULVnoqz0MAQ0g/yv/US4sVIPpE0Zc4+te1K+nhtiCi+dzHqQt/xz8d
	 +QyjT7tMhmkicZfXAlaVkFiDXVJBwFShF4dWdjOM=
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
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikelley@microsoft.com
Cc: minipli@grsecurity.net,
	ssengar@microsoft.com
Subject: [PATCH v2] x86/hyperv: Remove hv_vtl_early_init initcall
Date: Thu, 21 Sep 2023 21:58:40 -0700
Message-Id: <1695358720-27681-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
be called in an non Hyper-V/VTL platforms which results the memory
corruption.

Remove the early_initcall for hv_vtl_early_init and call it at the end of
hyperv_init to make sure it is never called in a non Hyper-V platform by
mistake.

Reported-by: Mathias Krause <minipli@grsecurity.net>
Closes: https://lore.kernel.org/lkml/40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net/
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Acked-by: Mathias Krause <minipli@grsecurity.net>
---
This patch is dependent on :
https://lore.kernel.org/lkml/1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com/
[V2]
- Fix HYPERV_VTL_MODE=n compilation flow
- Updated commit s/vhv_vtl_early_init/hv_vtl_early_init


 arch/x86/hyperv/hv_init.c       | 3 +++
 arch/x86/hyperv/hv_vtl.c        | 3 +--
 arch/x86/include/asm/mshyperv.h | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f0128fd4031d..608f4fe41fb7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -610,6 +610,9 @@ void __init hyperv_init(void)
 	/* Find the VTL */
 	ms_hyperv.vtl = get_vtl();
 
+	if (ms_hyperv.vtl > 0) /* non default VTL */
+		hv_vtl_early_init();
+
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 36a562218010..999f5ac82fe9 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -215,7 +215,7 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 	return hv_vtl_bringup_vcpu(vp_id, start_eip);
 }
 
-static int __init hv_vtl_early_init(void)
+int __init hv_vtl_early_init(void)
 {
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
@@ -230,4 +230,3 @@ static int __init hv_vtl_early_init(void)
 
 	return 0;
 }
-early_initcall(hv_vtl_early_init);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 033b53f993c6..896445edc6a8 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
 
 #ifdef CONFIG_HYPERV_VTL_MODE
 void __init hv_vtl_init_platform(void);
+int __init hv_vtl_early_init(void);
 #else
 static inline void __init hv_vtl_init_platform(void) {}
+static inline int __init hv_vtl_early_init(void) { return 0; }
 #endif
 
 #include <asm-generic/mshyperv.h>
-- 
2.34.1


