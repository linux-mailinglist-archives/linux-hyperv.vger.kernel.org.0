Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027912A844D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgKEQ7O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:59:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34568 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbgKEQ6a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so2604318wro.1;
        Thu, 05 Nov 2020 08:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7gGWE1KUMsd9+39KuELqcUtVQ22QVdu595tFsS9SHU=;
        b=cAVSQA+dN1YEiEenMp26R4+7bVkLyMuWEgpS/sXNq7oTDiM9YEg4D2K9HJY9lxVwyZ
         mlpBH5puKP2tsZmtarOPgBPl/ZT+OUFQuZ6+4xIciCme5U8gvJ4bvowNChsByqbpcTrf
         f/1XInPNAEPZyNbRNzpYYUxy54KN3AYy9PdvyMazC9cKUz5vC98VYemJoyY1Y1ejUhnF
         27Txp1gJ6ZRwnGT0ADYoV7Llbd97/WUzLOX2UFuVbu31ooV1zc1tqh1jjgeZ/Xfrb4d2
         hhW9BIIH0oqWzMv/ctu3OJa1ZPZuzt7YIGZqSY2kVuJYSLGk+60TgkgxzDoRPNdenkFj
         fQ/g==
X-Gm-Message-State: AOAM532n7hGLwXVAGtv7G0FGSYuhdHQspH4x+QI9oxnde5K2toylWZBE
        hhZW21DNObq4GvrexdQEvgqZhebO6V8=
X-Google-Smtp-Source: ABdhPJwpDhvQrHK3WwjrjTFn71gUwZVgYIQo08rac/znVi21vuGDo5TBoSBrp2OT0Qz88kzACQ9qQg==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr3903627wrc.335.1604595508956;
        Thu, 05 Nov 2020 08:58:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:28 -0800 (PST)
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
Subject: [PATCH v2 10/17] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Thu,  5 Nov 2020 16:58:07 +0000
Message-Id: <20201105165814.29233-11-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
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
---
 arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f7633e1e4c82..4795e54550e6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -31,6 +31,7 @@
 #include <asm/reboot.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/numa.h>
 
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
@@ -208,6 +209,30 @@ static void __init hv_smp_prepare_boot_cpu(void)
 	hv_init_spinlocks();
 #endif
 }
+
+static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
+{
+#if defined(CONFIG_X86_64)
+	int i;
+	int ret;
+
+	native_smp_prepare_cpus(max_cpus);
+
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
@@ -364,6 +389,8 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
+	if (hv_root_partition)
+		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
-- 
2.20.1

