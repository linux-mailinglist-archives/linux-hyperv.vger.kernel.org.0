Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA662FD0ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbhATM7m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 07:59:42 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51225 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733300AbhATMMz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 07:12:55 -0500
Received: by mail-wm1-f48.google.com with SMTP id m2so2666032wmm.1;
        Wed, 20 Jan 2021 04:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0hrJnkhTHI8MFmITTywSTXP99AQKzpVEujA7fFIdZs=;
        b=qogB0TxakGDoVgznQvzFzVDYgn82tNNHh8p76R3wkPyyuMfgxJCIQgXIKoWXT+ShPP
         iDeVZyP+RJcOF0NQ3achf42bqFnLMsdT6XHcViNwoYQgsv0akwdPLUnQfrWNm0z246Em
         iRIGq8RY8DaVCwqk2hAznsw6d/+LqGpXAF2MSH0goWSkuQAwhaDKXEWIbfT4/mdbup5E
         KvpoJJ899k2cVrRv2yGyqNfVPDue1rf6zUCRXzE9PYMlChFn5ygRcA4A08DntCesvAtz
         5uZ3ol3ohHlThnmhTLa9ZfPou2HKAheo8P+eFvz7R1AeydwRJOTJ9jYjFpCdzqjZQZmk
         zAxg==
X-Gm-Message-State: AOAM530WsSN1SRNYw23ztgOPNFAyWnPb/kMbmk7byjgixZNBkcnhlHOo
        QkJkbl++NEbyanXcMcWzQCbBtiBjw64=
X-Google-Smtp-Source: ABdhPJylYWvb2U55NEWuPZWBC5TtItUq4b/PYfTV63zKexgitY9OxOQM4E/8hQK0juYs0b61Mpv5Ew==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr3925770wmk.70.1611144063903;
        Wed, 20 Jan 2021 04:01:03 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:03 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root partition
Date:   Wed, 20 Jan 2021 12:00:44 +0000
Message-Id: <20210120120058.29138-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
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

