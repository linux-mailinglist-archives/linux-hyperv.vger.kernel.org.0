Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2886A268AF4
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgINM2A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 08:28:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39206 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgINMZz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:25:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id e22so6843934edq.6;
        Mon, 14 Sep 2020 05:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2b8Hx6LFneW6965HjzLe+3orBdeADynSXFLtZaWjCw=;
        b=Zja261ehjQBrl2aok+5n10901pgFU8K+eHwsp7PtsDS+Un8qweDGS/Ju1I/SENsDwQ
         GgdXZfYaBnJ4XJtR1sdisAUfRu+Q2hwOx6ZTdaA78MWkgf/2iMZ4JSlyqdX8R3Cyk7Bm
         VCkDmh4f1/IVzJfA/5Vp02UBz5uVxGmJuHfynzl1WiHFH9COCxWxoFlQB7Jgfso8aHSj
         58R8gzPQCsPROM1jhz436Gp9lr770BDB86lY93S2YenlanW6+e1PAYX/Bb4uhK/Kn/FL
         wBNY+ZP3udD0JD9HMyywB9AecwW3MuTqqOnY+qVK3MLuS934IMQ37cHxG5RdVPKlog/6
         F9fQ==
X-Gm-Message-State: AOAM533ztR2NWMT0SanMBdsFbh9I2X/MaHdvQvPeBaROiqPcbRS3ekI+
        3nZ4KNEaqdLvdRQmz/IkQVTeJD27z8E=
X-Google-Smtp-Source: ABdhPJwV929Qde1LAClVneTnWUhcH/snWYo+2fQQFsSWrwM68mzGxAkYgCx6ZFZF7fyqpyKDui6nfg==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr16016915wrv.185.1600084777041;
        Mon, 14 Sep 2020 04:59:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:36 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC v1 10/18] x86/hyperv: implement and use hv_smp_prepare_cpus
Date:   Mon, 14 Sep 2020 11:59:19 +0000
Message-Id: <20200914115928.83184-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
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
index 1bf57d310f78..7522cae02759 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -203,6 +203,31 @@ static void __init hv_smp_prepare_boot_cpu(void)
 	hv_init_spinlocks();
 #endif
 }
+
+static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
+{
+#if defined(CONFIG_X86_64)
+	int i;
+	int vp_index = 1;
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
+		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, vp_index++, i);
+		BUG_ON(ret);
+	}
+#endif
+}
 #endif
 
 static void __init ms_hyperv_init_platform(void)
@@ -359,6 +384,8 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
+	if (hv_root_partition)
+		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
-- 
2.20.1

