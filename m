Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9075E11FC0F
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLPATy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:19:54 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41102 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPATy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so714638qvr.8;
        Sun, 15 Dec 2019 16:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqQp4+UbbRX/7xlzqwr46OCkSlvgFANLzi802cRaz4A=;
        b=GyH7/Io5fH/c/CUmowH+I8vPoZ8s483kMhc3an3/j9mKJEAGIdoesqC3IMwmIaJf03
         ofn1CUUMWPYu6mLP1xPuGDobPBCRrctiJt71rFvn7BUCtLlI4zPp0N4uYuDweGoKXOCP
         onnsUA8IcLU1SG6wQREkSB57Jh1vP8OF5a9qw0sBK2sVIapT0w/2JQUScUrHqEMKVXCo
         ooyArdT1qkWIdNyhNVcqZbqJALcl1PuEzHCZd4RDv1JRQBkR9eTxP0/m9dGoWfhFWn64
         6Li8U0KzRuQBfnhK4YnbQvWKuqIf+s+y01QrEgZcw3jGf/crhDv1JKa9Y3gPAa70XxBP
         xA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqQp4+UbbRX/7xlzqwr46OCkSlvgFANLzi802cRaz4A=;
        b=LpPyGrdlsnDefrW26luId5Dz3iUq4ejMXH/3TdXcG4JZlstI4GND6BC/bwN/alTWlO
         93Tsz4W4b16y78NPEMaqgEYhxFjkOLAMwHYzXd0CJnE89O9zq0enT1F5O///zOpZgRLv
         CgA0zXyM+l2P2L65SBXn2mHHOU1eNO+Mh72G+pInN5H05E2pa6wUJWgnHYWO5s0s5Nql
         c3S2L4DqHe5EtGp/AE88nbGx4vf1YXA25LHqtzSTBXDTgcH5o6JyuRwCG79HCpg4pBcw
         JzcsR2B986lwhImtHHOyjUzYDlvmNGsNmHf1RiktCUyzXRalPJSJCx76jgzs7+NZ3blW
         3+XQ==
X-Gm-Message-State: APjAAAWlmE2MKZKu0mWfgkNyTrD/dmKI/GGiuw89foO+Vwh1FzBYdztB
        YFjwG8Vopv33X6s5Vl7unng=
X-Google-Smtp-Source: APXvYqxDQ+j2rURsMx2x0xRfHlMUbbM83uuSbHR32vFcElSOqCViHNeFWFNuwVwKh7NFCGLlq6vXXw==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr95564qvb.43.1576455593249;
        Sun, 15 Dec 2019 16:19:53 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l20sm3935350qtj.60.2019.12.15.16.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D85822430;
        Sun, 15 Dec 2019 19:19:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:52 -0500
X-ME-Sender: <xms:ps32XSiA8-W5GqC5Qy3FoXGOj8quSVO-Rhv_jOUF0x5RjYwOGeKgAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:ps32XcozRl7uyns0jxZ5RbnzMCjSlYce4Gl3XelJ3tNtaWiQmANVRA>
    <xmx:ps32XaGAddK6-w31E5CHPXQYuPakcYS_mrOQpy-wvdRbvq_o50YOlA>
    <xmx:ps32XelygpSR2dCJDv_W5E8D_JRuo6QyN2c9cChwjcAoI_tE4J64HA>
    <xmx:qM32XfzFWVElOSSskywo0p0kinDjc-v64e7XlUzN1MaesgGu0REO3cIZZr8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1E9530600FE;
        Sun, 15 Dec 2019 19:19:49 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: [RFC 3/6] arm/arm64: clocksource: Introduce vclock_mode
Date:   Mon, 16 Dec 2019 08:19:19 +0800
Message-Id: <20191216001922.23008-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Similar to x86, use a vclock_mode in arch_clocksource_data to differ
clocksoures use different read function in vDSO.

No functional changes, only preparation for support vDSO in ARM64 on
Hyper-V.

Note: the changes for arm are only because arm and arm64 share the same
code in the arch timer driver and require arch_clocksource_data having
the same field.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm/include/asm/clocksource.h                | 6 +++++-
 arch/arm/kernel/vdso.c                            | 1 -
 arch/arm64/include/asm/clocksource.h              | 6 +++++-
 arch/arm64/include/asm/mshyperv.h                 | 2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 5 +++--
 arch/arm64/include/asm/vdso/gettimeofday.h        | 5 +++--
 arch/arm64/include/asm/vdso/vsyscall.h            | 4 +---
 drivers/clocksource/arm_arch_timer.c              | 8 ++++----
 8 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/clocksource.h b/arch/arm/include/asm/clocksource.h
index 0b350a7e26f3..017c5ab6e587 100644
--- a/arch/arm/include/asm/clocksource.h
+++ b/arch/arm/include/asm/clocksource.h
@@ -1,8 +1,12 @@
 #ifndef _ASM_CLOCKSOURCE_H
 #define _ASM_CLOCKSOURCE_H
 
+#define VCLOCK_NONE	0	/* No vDSO clock available.		*/
+#define VCLOCK_CNTVCT	1	/* vDSO should use cntvcnt		*/
+#define VCLOCK_MAX	1
+
 struct arch_clocksource_data {
-	bool vdso_direct;	/* Usable for direct VDSO access? */
+	int vclock_mode;
 };
 
 #endif
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index c89ac1b9d28b..09e46ec420fe 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -263,4 +263,3 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 	if (!IS_ERR(vma))
 		mm->context.vdso = addr;
 }
-
diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
index 0ece64a26c8c..fbe80057468c 100644
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -2,8 +2,12 @@
 #ifndef _ASM_CLOCKSOURCE_H
 #define _ASM_CLOCKSOURCE_H
 
+#define VCLOCK_NONE	0	/* No vDSO clock available.		*/
+#define VCLOCK_CNTVCT	1	/* vDSO should use cntvcnt		*/
+#define VCLOCK_MAX	1
+
 struct arch_clocksource_data {
-	bool vdso_direct;	/* Usable for direct VDSO access? */
+	int vclock_mode;
 };
 
 #endif
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 9cc4aeddf2d0..0afb00e3501d 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -90,7 +90,7 @@ extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
 #define hv_set_reference_tsc(val) \
 		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
 #define hv_set_clocksource_vdso(val) \
-		((val).archdata.vdso_direct = false)
+		((val).archdata.vclock_mode = VCLOCK_NONE)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 #define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index c50ee1b7d5cd..630d04c3c92e 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
+#include <asm/clocksource.h>
 #include <uapi/linux/time.h>
 
 #include <asm/vdso/compat_barrier.h>
@@ -117,10 +118,10 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	u64 res;
 
 	/*
-	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * clock_mode == VCLOCK_NONE implies that vDSO are disabled so
 	 * fallback on syscall.
 	 */
-	if (clock_mode)
+	if (clock_mode == VCLOCK_NONE)
 		return __VDSO_USE_SYSCALL;
 
 	/*
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index b08f476b72b4..e6e3fe0488c7 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
+#include <asm/clocksource.h>
 #include <uapi/linux/time.h>
 
 #define __VDSO_USE_SYSCALL		ULLONG_MAX
@@ -71,10 +72,10 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	u64 res;
 
 	/*
-	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * clock_mode == VCLOCK_NONE implies that vDSO are disabled so
 	 * fallback on syscall.
 	 */
-	if (clock_mode)
+	if (clock_mode == VCLOCK_NONE)
 		return __VDSO_USE_SYSCALL;
 
 	/*
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 0c20a7c1bee5..07f78b0da498 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -24,9 +24,7 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
 static __always_inline
 int __arm64_get_clock_mode(struct timekeeper *tk)
 {
-	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
-
-	return use_syscall;
+	return tk->tkr_mono.clock->archdata.vclock_mode;
 }
 #define __arch_get_clock_mode __arm64_get_clock_mode
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a5464c625b4..9b8d4d00b53b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,7 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
-static bool vdso_default = true;
+static int vdso_default = VCLOCK_CNTVCT;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
@@ -560,8 +560,8 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 	 * change both the default value and the vdso itself.
 	 */
 	if (wa->read_cntvct_el0) {
-		clocksource_counter.archdata.vdso_direct = false;
-		vdso_default = false;
+		clocksource_counter.archdata.vclock_mode = VCLOCK_NONE;
+		vdso_default = VCLOCK_NONE;
 	}
 }
 
@@ -979,7 +979,7 @@ static void __init arch_counter_register(unsigned type)
 		}
 
 		arch_timer_read_counter = rd;
-		clocksource_counter.archdata.vdso_direct = vdso_default;
+		clocksource_counter.archdata.vclock_mode = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
-- 
2.24.0

