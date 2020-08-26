Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A208252E6F
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgHZMNs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgHZMBV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F71C061574;
        Wed, 26 Aug 2020 05:01:20 -0700 (PDT)
Message-Id: <20200826112331.157603198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6S+VPwjCO4/0/sg5O/D8yGF7mUxRzB6iCmAEo7WLFeY=;
        b=yBa1jZyq19hlxKFJk3xxqm7DyS+GDm5bb0xsGOflfAgTKxIfxMWsOquHJO8oAmDg57DS2O
        lOd5gVhWE33CpyLZ98lEY6XLD8VUMPfnergrf924inK2Y0VoOUDpqLwrNon8BZkDdz3+RZ
        yX47Hb4PiDkN+/QsBNEh9UPVPiX3u0mN3awXLTF4/59iOyWlV4bQiBwP1s4Iy1rkRwPWcl
        0sRWk8UdH9fpJKD4wOajIaX4OIEMEwGSfYibyYvgtipQmWu1nChRU0L9O3ofQCESFnO2r0
        /O1UWsUyXWAh1MgcFvs4LyhV7tN+dM6a3oK2zVsEshW1p5maB74zT8l4pFyB8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6S+VPwjCO4/0/sg5O/D8yGF7mUxRzB6iCmAEo7WLFeY=;
        b=X+rqdbCzEwcm50ULD6Yd1kuRe0Xhd7Md4D5DV2hlhjFcxaDeRH1iXqy0ovLxzi9/fl9LUK
        RmgSqOyBQ/HmJiAQ==
Date:   Wed, 26 Aug 2020 13:16:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch V2 05/46] x86/msi: Move compose message callback where it belongs
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Composing the MSI message at the MSI chip level is wrong because the
underlying parent domain is the one which knows how the message should be
composed for the direct vector delivery or the interrupt remapping table
entry.

The interrupt remapping aware PCI/MSI chip does that already. Make the
direct delivery chip do the same and move the composition of the direct
delivery MSI message to the vector domain irq chip.

This prepares for the upcoming device MSI support to avoid having
architecture specific knowledge in the device MSI domain irq chips.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/apic.h   |    8 ++++++++
 arch/x86/kernel/apic/msi.c    |   12 +++---------
 arch/x86/kernel/apic/vector.c |    1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -519,6 +519,14 @@ static inline bool apic_id_is_primary_th
 static inline void apic_smt_update(void) { }
 #endif
 
+struct msi_msg;
+
+#ifdef CONFIG_PCI_MSI
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
+#else
+# define x86_vector_msi_compose_msg NULL
+#endif
+
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,7 @@ static void __irq_msi_compose_msg(struct
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	__irq_msi_compose_msg(irqd_cfg(data), msg);
 }
@@ -177,7 +177,6 @@ static struct irq_chip pci_msi_controlle
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -321,7 +320,6 @@ static struct irq_chip dmar_msi_controll
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -419,7 +417,6 @@ static struct irq_chip hpet_msi_controll
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg = irq_msi_compose_msg,
 	.irq_write_msi_msg = hpet_msi_write_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
@@ -479,13 +476,10 @@ struct irq_domain *hpet_create_irq_domai
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL) {
+	if (parent == NULL)
 		parent = x86_vector_domain;
-	} else {
+	else
 		hpet_msi_controller.name = "IR-HPET-MSI";
-		/* Temporary fix: Will go away */
-		hpet_msi_controller.irq_compose_msi_msg = NULL;
-	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -823,6 +823,7 @@ static struct irq_chip lapic_controller
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
 	.irq_set_affinity	= apic_set_affinity,
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
 	.irq_retrigger		= apic_retrigger_irq,
 };
 

