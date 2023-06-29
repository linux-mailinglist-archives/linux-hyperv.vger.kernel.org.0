Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFF742CCA
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjF2TBp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjF2TBQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50A3596;
        Thu, 29 Jun 2023 12:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF5A615FF;
        Thu, 29 Jun 2023 19:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3ADC433C0;
        Thu, 29 Jun 2023 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065273;
        bh=J/FMb7N3Z3QE6+0UJq/+18R/ri6GRgg063fVx6b2yK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZxh4wX8IaQhmuwNa2eOUfJXfcXXQhMFw14RMdueKQ+a8bk3N3hKk/rZ5ITqX2+XS
         16roA7/Jne6SHsmcRABaWjdRvILsRg9aOg7qDI90b0PkEgw0knerFwRBJEqXsAfh2N
         2WLfRM5J5Kq5Hwmysb5ZS5SMGs1r23/u95XH+YvqOAvm05TfH6FE1umXQx+9FIMcot
         jfS5RwACtRMpCKsUqYxWb920bqNJRgU1gHiQ7g/DuISPEbVLuWNpCPbrMS0f8lKenP
         CXU5ViTm3ATw7MJntWtpkEWLlAhmNDAPWkxxJYlSdInO6HzkoexANfS5fQ7usN2y4E
         fpZx1kY9LBl8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 06/17] x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline
Date:   Thu, 29 Jun 2023 15:00:35 -0400
Message-Id: <20230629190049.907558-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 9636be85cc5bdd8b7a7f6a53405cbcc52161c93c ]

These commits

a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg")
2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")

update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
because that memory will be correctly marked as decrypted or encrypted
for all VM types (CoCo or normal). But problems ensue when CPUs in the
VM go online or offline after virtual PCI devices have been configured.

When a CPU is brought online, the hyperv_pcpu_input_arg for that CPU is
initialized by hv_cpu_init() running under state CPUHP_AP_ONLINE_DYN.
But this state occurs after state CPUHP_AP_IRQ_AFFINITY_ONLINE, which
may call the virtual PCI driver and fault trying to use the as yet
uninitialized hyperv_pcpu_input_arg. A similar problem occurs in a CoCo
VM if the MMIO read and write hypercalls are used from state
CPUHP_AP_IRQ_AFFINITY_ONLINE.

When a CPU is taken offline, IRQs may be reassigned in state
CPUHP_TEARDOWN_CPU. Again, the virtual PCI driver may fault trying to
use the hyperv_pcpu_input_arg that has already been freed by a
higher state.

Fix the onlining problem by adding state CPUHP_AP_HYPERV_ONLINE
immediately after CPUHP_AP_ONLINE_IDLE (similar to CPUHP_AP_KVM_ONLINE)
and before CPUHP_AP_IRQ_AFFINITY_ONLINE. Use this new state for
Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
early enough.

Fix the offlining problem by not freeing hyperv_pcpu_input_arg when
a CPU goes offline. Retain the allocated memory, and reuse it if
the CPU comes back online later.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Link: https://lore.kernel.org/r/1684862062-51576-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c  |  2 +-
 drivers/hv/hv_common.c     | 48 +++++++++++++++++++-------------------
 include/linux/cpuhotplug.h |  1 +
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 41ef036ebb7ba..5e26ac43552b0 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -414,7 +414,7 @@ void __init hyperv_init(void)
 			goto free_vp_assist_page;
 	}
 
-	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
+	cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
 				  hv_cpu_init, hv_cpu_die);
 	if (cpuhp < 0)
 		goto free_ghcb_page;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 52a6f89ccdbd4..2d19118adf95b 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -133,13 +133,20 @@ int hv_common_cpu_init(unsigned int cpu)
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
 
 	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
-	if (!(*inputarg))
-		return -ENOMEM;
 
-	if (hv_root_partition) {
-		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+	/*
+	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
+	 * allocated if this CPU was previously online and then taken offline
+	 */
+	if (!*inputarg) {
+		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		if (!(*inputarg))
+			return -ENOMEM;
+
+		if (hv_root_partition) {
+			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+		}
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
@@ -154,24 +161,17 @@ int hv_common_cpu_init(unsigned int cpu)
 
 int hv_common_cpu_die(unsigned int cpu)
 {
-	unsigned long flags;
-	void **inputarg, **outputarg;
-	void *mem;
-
-	local_irq_save(flags);
-
-	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	mem = *inputarg;
-	*inputarg = NULL;
-
-	if (hv_root_partition) {
-		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*outputarg = NULL;
-	}
-
-	local_irq_restore(flags);
-
-	kfree(mem);
+	/*
+	 * The hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory
+	 * is not freed when the CPU goes offline as the hyperv_pcpu_input_arg
+	 * may be used by the Hyper-V vPCI driver in reassigning interrupts
+	 * as part of the offlining process.  The interrupt reassignment
+	 * happens *after* the CPUHP_AP_HYPERV_ONLINE state has run and
+	 * called this function.
+	 *
+	 * If a previously offlined CPU is brought back online again, the
+	 * originally allocated memory is reused in hv_common_cpu_init().
+	 */
 
 	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001dca0e00..3ceb9dfa09933 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -200,6 +200,7 @@ enum cpuhp_state {
 
 	/* Online section invoked on the hotplugged CPU from the hotplug thread */
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_HYPERV_ONLINE,
 	CPUHP_AP_KVM_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
-- 
2.39.2

