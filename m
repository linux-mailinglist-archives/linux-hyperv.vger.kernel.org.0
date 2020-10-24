Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B818D297F19
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Oct 2020 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764923AbgJXVhe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Oct 2020 17:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764733AbgJXVfw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Oct 2020 17:35:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED66C0613D9;
        Sat, 24 Oct 2020 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vMkvKYa1bgtG4WRZglskJrL6oEo1WAo+yFDgFj7e70E=; b=wr8pnY2UR65DZIMCNhrp599YhR
        upsvRRUSKGK5lfCFL/gDx7MRwPphkS25LPOWDjpmXnP1AeDGQ6ZuAc/FMcUeZQ4VbFC5D1/OE8J/M
        7BjXpUdsexI3HFCcgLX0c4EUc9QV3LXFxmGlmrN7fLwh3aoj0CdwD+FbxZvc/L2pMdQQH1VbjtaN4
        juMyW44PrJ9SmeTngtFSdJUJCmeYNSE7tRL9iO7fXySYc+3QRbW+EI9PbvtmBku9UbJCE5Ikvo5bV
        8v45RM3O9orvjHNAzvggMFK9SHq5AQi2xrthe4TGiZp6tsrjBFOl5uSUaytbfFdm2TGlYyyc2o8Jy
        9QEFOc0g==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWRCS-0008BR-Nc; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kWRCM-001rNs-MU; Sat, 24 Oct 2020 22:35:38 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, maz@misterjones.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 05/35] x86/apic: Cleanup delivery mode defines
Date:   Sat, 24 Oct 2020 22:35:05 +0100
Message-Id: <20201024213535.443185-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The enum ioapic_irq_destination_types and the enumerated constants starting
with 'dest_' are gross misnomers because they describe the delivery mode.

Rename then enum and the constants so they actually make sense.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/apic.h           |  3 ++-
 arch/x86/include/asm/apicdef.h        | 16 +++++++---------
 arch/x86/kernel/apic/apic_flat_64.c   |  4 ++--
 arch/x86/kernel/apic/apic_noop.c      |  2 +-
 arch/x86/kernel/apic/apic_numachip.c  |  4 ++--
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/io_apic.c        | 11 ++++++-----
 arch/x86/kernel/apic/probe_32.c       |  2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  6 +++---
 arch/x86/platform/uv/uv_irq.c         |  2 +-
 drivers/iommu/amd/iommu.c             |  4 ++--
 drivers/iommu/intel/irq_remapping.c   |  2 +-
 drivers/pci/controller/pci-hyperv.c   |  6 +++---
 15 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index b0fd204e0023..53bb62e0fdd5 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -309,7 +309,8 @@ struct apic {
 	/* dest_logical is used by the IPI functions */
 	u32	dest_logical;
 	u32	disable_esr;
-	u32	irq_delivery_mode;
+
+	enum apic_delivery_modes delivery_mode;
 	u32	irq_dest_mode;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 05e694ed8386..5716f22f81ac 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -432,15 +432,13 @@ struct local_apic {
  #define BAD_APICID 0xFFFFu
 #endif
 
-enum ioapic_irq_destination_types {
-	dest_Fixed		= 0,
-	dest_LowestPrio		= 1,
-	dest_SMI		= 2,
-	dest__reserved_1	= 3,
-	dest_NMI		= 4,
-	dest_INIT		= 5,
-	dest__reserved_2	= 6,
-	dest_ExtINT		= 7
+enum apic_delivery_modes {
+	APIC_DELIVERY_MODE_FIXED	= 0,
+	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
+	APIC_DELIVERY_MODE_SMI		= 2,
+	APIC_DELIVERY_MODE_NMI		= 4,
+	APIC_DELIVERY_MODE_INIT		= 5,
+	APIC_DELIVERY_MODE_EXTINT	= 7,
 };
 
 #endif /* _ASM_X86_APICDEF_H */
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7862b152a052..fdd38a17f835 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -113,7 +113,7 @@ static struct apic apic_flat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
@@ -206,7 +206,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 780c702969b7..4fc934b11851 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -95,7 +95,7 @@ struct apic apic_noop __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= noop_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* logical delivery broadcast to all CPUs: */
 	.irq_dest_mode			= 1,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 35edd57f064a..db715d082ec9 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -246,7 +246,7 @@ static const struct apic apic_numachip1 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
@@ -295,7 +295,7 @@ static const struct apic apic_numachip2 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 98d015a4405a..7f6461f5d349 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -127,7 +127,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* phys delivery to target CPU: */
 	.irq_dest_mode			= 0,
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b3c7e0d4a09..cff6cbc3d183 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -535,7 +535,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 
 	/* Check delivery_mode to be sure we're not clearing an SMI pin */
 	entry = ioapic_read_entry(apic, pin);
-	if (entry.delivery_mode == dest_SMI)
+	if (entry.delivery_mode == APIC_DELIVERY_MODE_SMI)
 		return;
 
 	/*
@@ -1368,7 +1368,8 @@ void __init enable_IO_APIC(void)
 		/* If the interrupt line is enabled and in ExtInt mode
 		 * I have found the pin where the i8259 is connected.
 		 */
-		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT)) {
+		if ((entry.mask == 0) &&
+		    (entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT)) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
 			goto found_i8259;
@@ -1416,7 +1417,7 @@ void native_restore_boot_irq_mode(void)
 		entry.trigger		= IOAPIC_EDGE;
 		entry.polarity		= IOAPIC_POL_HIGH;
 		entry.dest_mode		= IOAPIC_DEST_MODE_PHYSICAL;
-		entry.delivery_mode	= dest_ExtINT;
+		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
 		entry.dest		= read_apic_id();
 
 		/*
@@ -2047,7 +2048,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry1.dest_mode = IOAPIC_DEST_MODE_PHYSICAL;
 	entry1.mask = IOAPIC_UNMASKED;
 	entry1.dest = hard_smp_processor_id();
-	entry1.delivery_mode = dest_ExtINT;
+	entry1.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
 	entry1.polarity = entry0.polarity;
 	entry1.trigger = IOAPIC_EDGE;
 	entry1.vector = 0;
@@ -2948,7 +2949,7 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
+	entry->delivery_mode = apic->delivery_mode;
 	entry->dest_mode     = apic->irq_dest_mode;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b6f7c049ec..77c6e2e04a1f 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -69,7 +69,7 @@ static struct apic apic_default __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* logical delivery broadcast to all CPUs: */
 	.irq_dest_mode			= 1,
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b0889c48a2ac..82fb43d807f7 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -184,7 +184,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e14eae6d6ea7..437e8439db67 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -157,7 +157,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9ade9e6a95ff..49deefdded68 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -703,9 +703,9 @@ static void uv_send_IPI_one(int cpu, int vector)
 	unsigned long dmode, val;
 
 	if (vector == NMI_VECTOR)
-		dmode = dest_NMI;
+		dmode = APIC_DELIVERY_MODE_NMI;
 	else
-		dmode = dest_Fixed;
+		dmode = APIC_DELIVERY_MODE_FIXED;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 		(apicid << UVH_IPI_INT_APIC_ID_SHFT) |
@@ -807,7 +807,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.apic_id_valid			= uv_apic_id_valid,
 	.apic_id_registered		= uv_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* Physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 18ca2261cc9a..e7020d162949 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
+	entry->delivery_mode	= apic->delivery_mode;
 	entry->dest_mode	= apic->irq_dest_mode;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf59443843..bc81b91f89fe 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3671,7 +3671,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->irq_delivery_mode,
+	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
 				 apic->irq_dest_mode, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
@@ -3944,7 +3944,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 
 	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
-	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
+	entry->lo.fields_remap.int_type    = apic->delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0cfce1d3b7bb..d44e719d1984 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1122,7 +1122,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
+	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 4e992403fffe..92b57ac50a06 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1226,7 +1226,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params->int_target.vector = cfg->vector;
 
 	/*
-	 * Honoring apic->irq_delivery_mode set to dest_Fixed by
+	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
 	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
 	 * spurious interrupt storm. Not doing so does not seem to have a
 	 * negative effect (yet?).
@@ -1310,7 +1310,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1331,7 +1331,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
-- 
2.26.2

