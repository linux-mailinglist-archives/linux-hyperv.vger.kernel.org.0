Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7026940F
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgINRum (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:50:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52039 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINL2P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id w2so10266656wmi.1;
        Mon, 14 Sep 2020 04:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gy81tDRIYMaqrShjpbYnWa6qUW0GqByGNBBg1HW1d6U=;
        b=qzj8UwOvCfS/78OEdWd1qQlAnl6fdDO6nlmeCtr1DSfjzGt6wjpGNJQrRzU4G5uwh8
         ywgWEDDPa0PsoUdlc9TItQ1wt1S9OeWt1bxxHhPcqW32NooFF7ZcHz4kv/vtmau5+ebJ
         1jH/PpMjdrJjBx+M1D25/sKK1SE8JErdgSEo7bpxg0IujSPLmYufg5HyfXYxVuywGgMS
         oqwoSf0KYXuVsJ5uJtcYGlyXtwhjARbApulQv0e3tah/VOIoeOc+/mcg+hQtQ8fN5CRY
         wZc04aYI3PAbXwlcA74u5W387prjeOlEUXtHKfZnccjbrpa+ONAtnsiJFIDaAvK/Z5Vy
         RZ3w==
X-Gm-Message-State: AOAM533tK0ylHHWW/epM5/bTtKQVZJKB+7ASEJADU3kegwkrL8HI9sCe
        d/VMk6D+VGPZ0+tXB2/KW5yzHOXKJHo=
X-Google-Smtp-Source: ABdhPJyMtWrEN5k8zHBXFTX32eH9dNiXqQAvAl2FzmM4V3sQ7G58YZ7YpPMYIGWBu3lm4DH/4p9SDA==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr14903752wma.11.1600082892846;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC v1 02/18] x86/hyperv: detect if Linux is the root partition
Date:   Mon, 14 Sep 2020 11:27:46 +0000
Message-Id: <20200914112802.80611-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For now we can use the privilege flag to check. Stash the value to be
used later.

Put in a bunch of defines for future use when we want to have more
fine-grained detection.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c          |  4 ++++
 arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
 arch/x86/include/asm/mshyperv.h    |  2 ++
 arch/x86/kernel/cpu/mshyperv.c     | 16 ++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6035df1b49e1..cac8e4c56261 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -26,6 +26,10 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
+/* Is Linux running as the root partition? */
+bool hv_root_partition;
+EXPORT_SYMBOL_GPL(hv_root_partition);
+
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 7a4d2062385c..20d628c1ed50 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -21,6 +21,7 @@
 #define HYPERV_CPUID_FEATURES			0x40000003
 #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
+#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
 #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
@@ -136,6 +137,15 @@
 /* Recommend using enlightened VMCS */
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
 
+/*
+ * CPU management features identification.
+ * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
+ */
+#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
+#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
+#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
+#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
+
 /*
  * Virtual processor will never share a physical core with another virtual
  * processor, except for virtual processors that are reported as sibling SMT
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 60b944dd2df1..2a2cc81beac6 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -224,6 +224,8 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 
+extern bool hv_root_partition;
+
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index af94f05a5c66..1bf57d310f78 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -232,6 +232,22 @@ static void __init ms_hyperv_init_platform(void)
 	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
 		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
 
+	/*
+	 * Check CPU management privilege.
+	 *
+	 * To mirror what Windows does we should extract CPU management
+	 * features and use the ReservedIdentityBit to detect if Linux is the
+	 * root partition. But that requires negotiating CPU management
+	 * interface (a process to be finalized).
+	 *
+	 * For now, use the privilege flag as the indicator for running as
+	 * root.
+	 */
+	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
+		hv_root_partition = true;
+		pr_info("Hyper-V: running as root partition\n");
+	}
+
 	/*
 	 * Extract host information.
 	 */
-- 
2.20.1

