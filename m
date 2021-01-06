Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13F2EC4F7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAFUei (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:38 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37424 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbhAFUei (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:38 -0500
Received: by mail-wm1-f54.google.com with SMTP id q75so3726607wme.2;
        Wed, 06 Jan 2021 12:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0hrJnkhTHI8MFmITTywSTXP99AQKzpVEujA7fFIdZs=;
        b=UsaRr6NsevlKvsPxn5G2Hxd05+2UM25KMYDE9iygmclYMYtqcP4Un+T4xtjP7CSlHS
         rzJ0T6WTdMK/MMWv1kiZw9Yi6cz85r9aQYAYDRyoqV7qwqQl6eFxH0xYDI9zKYXdrN6v
         Nq0QS9YjruCIJ8h8TM5C9GWYyVvCM6dBXzDXLLhNXwPizxPQHRDmjn0GTlGkj85W3Z72
         HZVsh9OzaRlOhalNWUBWrIxp8XD8MKfyTJSFIaZJAKwhGA+aqba+2ah/7nNpGkFw+rJB
         aBD5L8D/JeIk4SjmDFD6HJKRcIEISer2O+X0Qn0Hgz+wMXerOrU2Nwxc4uN3xxplTNs/
         ecrA==
X-Gm-Message-State: AOAM531/GH8OOzjpobrB0IVNfJhSYcbaJKFGS71Ay1pQ44rqSESXU6nU
        7GggC8FOcP5MpQC1XlBhquwQpHhRf0Q=
X-Google-Smtp-Source: ABdhPJwYr1YnHm+3rYQk3GIK8uU0NvkcTw+XgzktXprvWYFh8zP1kRWd97ttGDXw5cF0VCboKzzVSg==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr5314943wml.64.1609965235793;
        Wed, 06 Jan 2021 12:33:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:55 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 02/17] x86/hyperv: detect if Linux is the root partition
Date:   Wed,  6 Jan 2021 20:33:35 +0000
Message-Id: <20210106203350.14568-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For now we can use the privilege flag to check. Stash the value to be
used later.

Put in a bunch of defines for future use when we want to have more
fine-grained detection.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v3: move hv_root_partition to mshyperv.c
---
 arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
 arch/x86/include/asm/mshyperv.h    |  2 ++
 arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6bf42aed387e..204010350604 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -21,6 +21,7 @@
 #define HYPERV_CPUID_FEATURES			0x40000003
 #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
+#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
 #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
@@ -110,6 +111,15 @@
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
index ffc289992d1b..ac2b0d110f03 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 
+extern bool hv_root_partition;
+
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f628e3dc150f..c376d191a260 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,10 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 
+/* Is Linux running as the root partition? */
+bool hv_root_partition;
+EXPORT_SYMBOL_GPL(hv_root_partition);
+
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
@@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
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

