Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D630DDCB
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhBCPOs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:14:48 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45735 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhBCPFe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:34 -0500
Received: by mail-wr1-f45.google.com with SMTP id m13so24736230wro.12;
        Wed, 03 Feb 2021 07:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDT1aR/ZIaB/uEZttZ80oWLaviiBKbPfEaTtbPxJzow=;
        b=tpaOJecSGK+z6EhLq7qVNhRAo4q+cy9UdnLYVFKTJH/kRH20PyYFbejUhdsG2XOo+1
         K8XkmPYcXKEgR70A/xAUbHv3W9U8ejGjzO5w1IMhHLH0FPF2cRDJtZWIaL7YLP5+N5XP
         gjODc/blpVtQElM8ta+9fDXe8F7WAoJUS2sTp9XVx/bd8UhE+uYp4UsnUA0pQw5FfVNL
         ei1qtpAeeMIARwz0lOxH40/BlZB4Y0h7qZIq0NYfNAL47pkm9vfqpj430Z48nnN0dFpc
         wa8594OjzdVmnTrG8wKi1gvNa185iw55Njik4NcN15Y3ov8VWi4ZsYJukCDeJgwjAA8Q
         uI1Q==
X-Gm-Message-State: AOAM532VnESZthAgRiC5NBhidFxyUMOkLgmOfbZb0BJYjXfl4vhO1rCr
        Wdapar2CFI4U2A+YFqtUK21JSpgFjqY=
X-Google-Smtp-Source: ABdhPJxPfhfPsFIP/AKMHHMpI/IZ9fXZm5cnGE+W23JNVBzmH/LkhtgQWsg7LhAT8j1kZ+daysHSXA==
X-Received: by 2002:a5d:5253:: with SMTP id k19mr4035750wrc.224.1612364689654;
        Wed, 03 Feb 2021 07:04:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:49 -0800 (PST)
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
Subject: [PATCH v6 10/16] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Wed,  3 Feb 2021 15:04:29 +0000
Message-Id: <20210203150435.27941-11-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

