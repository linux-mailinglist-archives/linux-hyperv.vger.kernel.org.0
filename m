Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854162EC513
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbhAFUer (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:47 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51212 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbhAFUeq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:46 -0500
Received: by mail-wm1-f54.google.com with SMTP id v14so3451202wml.1;
        Wed, 06 Jan 2021 12:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rN/0fuFHwVfj55c/MsJ39TIimzupnKoIy4FjFz+d0q8=;
        b=ss0j/JncKwSkW85blDKA0KdsCTyMZNhTG6n/ij3HIuvtLlx6n0+CqLxfuVMzr/zG/e
         nPdWKmL1xOMzGAec6ea5WGvvb+JtKMQv7XDPUnSyzGXOVt5UN9cjtM8J2KyW7MAMFFAY
         6n4eLD83vV6XE+4CSHKplk0Z5RaOvp3aJV/IzUqWprvMVzzENvDDk54kGrO/h1TS5sSU
         mNJYOofLgReZyrd/bZRdCFSZeuU762ydbXIuNnDWThw2Urp7WmEqcRNza24KY7l0SrdP
         yrNsTi+H/wAU0VP8n9x9zCCjGeVHiJHp0yTVzHLQIBNU2CyC91sHP0heZrw7Lu+PLcd5
         zPRA==
X-Gm-Message-State: AOAM532tNbtF5twXP09Z+XJlNqTeakkWpCJESAvQRzxxBFbPS2RSIz9Y
        A00JP7rvnvXu4djRd4FyRtqvkXl/XUM=
X-Google-Smtp-Source: ABdhPJzPmKt4VR5c1TEB4qE/szweYQL5hAHLcLxHSdGRUWdz8dDQMpdvsTx9swqCzq6LyLm61UuATw==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr5384686wmb.12.1609965244266;
        Wed, 06 Jan 2021 12:34:04 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:03 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 10/17] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Wed,  6 Jan 2021 20:33:43 +0000
Message-Id: <20210106203350.14568-11-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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

