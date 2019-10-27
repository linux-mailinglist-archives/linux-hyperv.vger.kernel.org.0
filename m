Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAAE63A8
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Oct 2019 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJ0PTp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Oct 2019 11:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfJ0PTp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Oct 2019 11:19:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 903B45945B
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Oct 2019 15:19:44 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f15so4811365wrs.13
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Oct 2019 08:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvVHDWrg8kpWgm0TThMdqhOJom1+KkBM1yfK666tdK4=;
        b=WpJ6mNw/NA09aKxTt4JP753SBhrgjnLa1hMe4Z7GBP+wefuTuRawkW1CQTZGFQFYif
         xyWiNmM7GlAH8oCbYkwWE48mgthb86WgRlxKUlT/jgdA8qTuZRNgwAxOYYKl8ikVlCtM
         SuzLi3Wad/TZ8BTVrlxzQ/pZbdxKRS3oNdTIwI0GiSSor3lDEXmEhRCr/yDnWW0QVuaQ
         9zLNMFunzqXNTjDjLhGdnmKW2i5dg2f0Fmgx0CMr9hbms6OwDGmz2xXHNC0PpbIXOpPd
         hK1Q0P0lG+1HP3HdTKKPXjD6+S8Kx6BuHm1QetyMDely8L66kc878TIFEKvSON1umkvz
         UC+A==
X-Gm-Message-State: APjAAAUykP8zkzcTauaNZCvcLZ6iELYoMTxDy1jELRQqvvi39+50j1vm
        J7AYI+TczRD+IgqhBvv2HBXPreeqiYOC/p0PINO9vLuA1Wk3rdCrCnkDoD4yZUXN2sYD8qjKOwH
        dEfi2JR2LkwEKZejrHkkriU/L
X-Received: by 2002:adf:94e2:: with SMTP id 89mr10328945wrr.259.1572189583018;
        Sun, 27 Oct 2019 08:19:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvdVn0aiYq7FrT5RVLqx0MXimGTzauHTpKqpbORHqbfFJoV/X9338sWHQK9x3m/KY2jVMJ9Q==
X-Received: by 2002:adf:94e2:: with SMTP id 89mr10328926wrr.259.1572189582760;
        Sun, 27 Oct 2019 08:19:42 -0700 (PDT)
Received: from vitty.brq.redhat.com ([193.43.158.229])
        by smtp.gmail.com with ESMTPSA id l15sm3649473wmh.18.2019.10.27.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:19:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
Date:   Sun, 27 Oct 2019 16:19:38 +0100
Message-Id: <20191027151938.7296-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When sending an IPI to a single CPU there is no need to deal with cpumasks.
With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
cycles) improvement with smp_call_function_single() loop benchmark. The
optimization, however, is tiny and straitforward. Also, send_ipi_one() is
important for PV spinlock kick.

I was also wondering if it would make sense to switch to using regular
APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
vector)).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v2:
 - Check VP number instead of CPU number against >= 64 [Michael]
 - Check for VP_INVAL
---
 arch/x86/hyperv/hv_apic.c           | 16 +++++++++++++---
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e01078e93dd3..40e0e322161d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -194,10 +194,20 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 
 static bool __send_ipi_one(int cpu, int vector)
 {
-	struct cpumask mask = CPU_MASK_NONE;
+	int vp = hv_cpu_number_to_vp_number(cpu);
 
-	cpumask_set_cpu(cpu, &mask);
-	return __send_ipi_mask(&mask, vector);
+	trace_hyperv_send_ipi_one(cpu, vector);
+
+	if (!hv_hypercall_pg || (vp == VP_INVAL))
+		return false;
+
+	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+		return false;
+
+	if (vp >= 64)
+		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
+
+	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
 }
 
 static void hv_send_ipi(int cpu, int vector)
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index ace464f09681..4d705cb4d63b 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -71,6 +71,21 @@ TRACE_EVENT(hyperv_send_ipi_mask,
 		      __entry->ncpus, __entry->vector)
 	);
 
+TRACE_EVENT(hyperv_send_ipi_one,
+	    TP_PROTO(int cpu,
+		     int vector),
+	    TP_ARGS(cpu, vector),
+	    TP_STRUCT__entry(
+		    __field(int, cpu)
+		    __field(int, vector)
+		    ),
+	    TP_fast_assign(__entry->cpu = cpu;
+			   __entry->vector = vector;
+		    ),
+	    TP_printk("cpu %d vector %x",
+		      __entry->cpu, __entry->vector)
+	);
+
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.20.1

