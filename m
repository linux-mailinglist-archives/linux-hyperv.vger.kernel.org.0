Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B522FD0E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbhATM7B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 07:59:01 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:33075 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389205AbhATMKp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 07:10:45 -0500
Received: by mail-wm1-f43.google.com with SMTP id s24so3179060wmj.0;
        Wed, 20 Jan 2021 04:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rN/0fuFHwVfj55c/MsJ39TIimzupnKoIy4FjFz+d0q8=;
        b=Of/09TrXX32d1adULmFOcooVT1eOAVcZ5uYiQ7m+O6CuNVHmNq9/QZ1a0SIYXDcDaH
         5VvmFpSLsIoJWtJ1MWuEz5fnl/Za2dtaf3H07X3zS+r9psqXxzxlbHM6T5OUo+JjsIZA
         2ZaOm/+phqLPkJD/45EWDeELn5kkg34wjwVHBr5hGtCglUe2F/04TjZqdXc8+8OPd39X
         b2nweUfg75px9MdzZCTFlRToxcruftbi03P1XUWpMlc801he4yVOrj+aP0c8XquqqivB
         il0JBQHpT0aoSkyPHvmj6emuWtonshaUBeZWgvWJFAEf9mAjX8FkQYyG2A1vQ3UeuGo9
         PDhg==
X-Gm-Message-State: AOAM531PcX7SzrKjQwqwYlby1pwOdqMfRU9i1+QZOF0iuWvx4Yki8RDj
        N+AMCc0cESaqyfdADaRF8USNKHTo+Mo=
X-Google-Smtp-Source: ABdhPJzD1f1f/OMBkLinjNM7+1vtozW8qRMu7hbq5PfdF4Ra+xpwv9NfO5c2ORnCl32iv5cAuQYe1Q==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr3999033wmc.40.1611144073152;
        Wed, 20 Jan 2021 04:01:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:12 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 10/16] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Wed, 20 Jan 2021 12:00:52 +0000
Message-Id: <20210120120058.29138-11-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Microsoft Hypervisor requires the root partition to make a few
hypercalls to setup application processors before they can be used.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
CPU hotplug and unplug is not yet supported in this setup, so those
paths remain untouched.

v3: Always call native SMP preparation function.
---
 arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c376d191a260..13d3b6dd21a3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -31,6 +31,7 @@
 #include <asm/reboot.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/numa.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -212,6 +213,32 @@ static void __init hv_smp_prepare_boot_cpu(void)
 	hv_init_spinlocks();
 #endif
 }
+
+static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
+{
+#ifdef CONFIG_X86_64
+	int i;
+	int ret;
+#endif
+
+	native_smp_prepare_cpus(max_cpus);
+
+#ifdef CONFIG_X86_64
+	for_each_present_cpu(i) {
+		if (i == 0)
+			continue;
+		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
+		BUG_ON(ret);
+	}
+
+	for_each_present_cpu(i) {
+		if (i == 0)
+			continue;
+		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
+		BUG_ON(ret);
+	}
+#endif
+}
 #endif
 
 static void __init ms_hyperv_init_platform(void)
@@ -368,6 +395,8 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
+	if (hv_root_partition)
+		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
-- 
2.20.1

