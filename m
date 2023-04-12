Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE316E29C9
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Apr 2023 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjDNSF1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Apr 2023 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSF0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Apr 2023 14:05:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42B735B0;
        Fri, 14 Apr 2023 11:05:25 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id A7DD22179262;
        Fri, 14 Apr 2023 11:05:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7DD22179262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681495525;
        bh=7TWgMCwTIchIJki1b6WkkqtvzdzihOoHkeu7FSM1cGI=;
        h=Subject:From:Cc:Date:From;
        b=kUZBbC0uf3JACWAKeVn2KDZBX2MgO5n+huVUR6gkRASjspJ7VNiMfNiXiHHYYs1Zy
         EGSXjjOSSJZ0b4sO/4obctT6uobJVkW/KqXeIj6LaTtZT5wDsQh6cQUnTnDLVDcmc/
         pDL7zSwAuj2iilCHVOMaFVk/2vxjX7aC7+nqYyuI=
Subject: [PATCH] x86/hyperv: Fix IRQ effective cpu discovery for the
 interrupts unmasking
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Date:   Wed, 12 Apr 2023 13:29:20 -0700
Message-ID: <168133133232.4448.8053082360972165835.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As of today, the existent code uses conjunction of IRQ affinity mask and cpu
online mask to find the cpu id to map an interrupt to.
I looks like the intention was to make sure that and IRQ won't be mapped to an
offline CPU.

Although it works correctly today, there are two problems with it:
1. IRQ affinity mask already consists only of online cpus, thus matching it
to the mask on online cpus is redundant.
2. cpumask_first_and() can return nr_cpu_ids in case of IRQ affinity
containing offline cpus in future, and in this case current implementation
will likely lead to kernel crash in hv_map_interrupt due to an attempt to use
invalid cpu id for getting vp set.

This patch fixes this logic by taking the first bit from the affinity
mask as the cpu to map the IRQ to.
It also adds a paranoia WARN_ON_ONCE for the case when the affinity mask
contains offline cpus.

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>
CC: linux-hyperv@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: iommu@lists.linux.dev
---
 arch/x86/hyperv/irqdomain.c  |    7 ++++---
 drivers/iommu/hyperv-iommu.c |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 42c70d28ef27..759774b5ab2f 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -192,7 +192,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct pci_dev *dev;
 	struct hv_interrupt_entry out_entry, *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	const cpumask_t *affinity;
 	int cpu;
 	u64 status;
 
@@ -204,8 +203,10 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	affinity = irq_data_get_effective_affinity_mask(data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
+
+	/* Paranoia check: the cpu must be online */
+	WARN_ON_ONCE(!cpumask_test_cpu(cpu, cpu_online_mask));
 
 	if (data->chip_data) {
 		/*
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8302db7f783e..632e9c123bbf 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -197,15 +197,16 @@ hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 	u32 vector;
 	struct irq_cfg *cfg;
 	int ioapic_id;
-	const struct cpumask *affinity;
 	int cpu;
 	struct hv_interrupt_entry entry;
 	struct hyperv_root_ir_data *data = irq_data->chip_data;
 	struct IO_APIC_route_entry e;
 
 	cfg = irqd_cfg(irq_data);
-	affinity = irq_data_get_effective_affinity_mask(irq_data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irq_data));
+
+	/* Paranoia check: the cpu must be online */
+	WARN_ON_ONCE(!cpumask_test_cpu(cpu, cpu_online_mask));
 
 	vector = cfg->vector;
 	ioapic_id = data->ioapic_id;


