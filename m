Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3D2C2DF9
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbgKXRI0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 12:08:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38116 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbgKXRIC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 12:08:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id 1so3625445wme.3;
        Tue, 24 Nov 2020 09:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3RfEJx7EqAAW54lT43C3SETi7IT2PM+rjr+/VWw9IA=;
        b=qUBdNXMNpfmw9Om3kA4sCHtxNritkey2T7aawsS9ig7lnAFwzJbD8aGGw5ayuHXCsk
         EpMkhCKsBJCbTUYLF3th+nNR+1WhsyY6Pxm5oIZ+JC8OVTvXEskmDPXTIs2+9DWFXq80
         waaHdvNVRlKbrupxcpGcuWNgXA+frBjZVAzjwXsCzOjzM5RWW/zHvzllHqX+5nrRQfD1
         RpAnBKA8VHNTjUOVH96vQgPvMtZIx9jhuRURcQf6IWIsYUjzjeZD5Wm4BenYSmkF7bBV
         D8KpctTA3NMkr0a2ocLIUK28K3fpRHRwU9fCtACz2h6YBeQTd4PzAjgSdQyH80cil4xU
         5N/w==
X-Gm-Message-State: AOAM531W7fAjZmUmHengQEVprRReNDJA41y0kk//RhQmcE3mphsDdD+M
        gZyKTMVP2OeKbi6N7GCdhMsuTP5SMuc=
X-Google-Smtp-Source: ABdhPJxBgHxUuLpLshTkEt7wIrZgGMvLoCUA+SkLubM7aTHNtLgk9r0gt8cSRVe0CKTAj/uoFJHc4w==
X-Received: by 2002:a05:600c:2119:: with SMTP id u25mr5530653wml.53.1606237679731;
        Tue, 24 Nov 2020 09:07:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:59 -0800 (PST)
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
Subject: [PATCH v3 10/17] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Tue, 24 Nov 2020 17:07:37 +0000
Message-Id: <20201124170744.112180-11-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
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
index f0b8c702c858..956007d2bf0d 100644
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

