Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0E45F8A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbhK0BY4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:24:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbhK0BWx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:22:53 -0500
Message-ID: <20211126223824.737214551@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aZOv1txgfOaOUbPFrZO+dbMPb9SLUMuv6lc2RMuyFjg=;
        b=gLteyA8nzze5GVNCuntT+mDm6BaDWteqvktrkoi4ASYzPXrlz4HKz0bxicobR9/2app1it
        5Jy9qIWqgXn1Yj3OnnnOAvfU3H1kJ2vIi2IgMpIOPf3Tbg+hwPdIQAMRBQMKMqsPyJSKCA
        wKej5OsKAZizHqGwChrYLE1YONAQ8ZADKZ/fhlTu0TWHLuld7oQdv/UKLaQWm/gl5ZetSr
        yRIutEfTCLBZ7jzkBcIGoANQ1a7tyhNoqABO43Tmkk667izRZp/2B6vZyjNMgGaUpCFWwm
        uK+aQVNlYDtOZW5StTeczSND/gp8vKFzi0ncw1BQWiiVIPNjOWmse1DqR/W8Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aZOv1txgfOaOUbPFrZO+dbMPb9SLUMuv6lc2RMuyFjg=;
        b=8887gmXcOxR2mcE3VZwOWRnobHxN5JTQvSyxaMwj/RCiewHrEtBePVsZfuQUe9gZwQtKvb
        qBx5Exc3k7997lBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Wei Liu <wei.liu@kernel.org>,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        ath11k@lists.infradead.org, Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch 11/22] x86/hyperv: Refactor hv_msi_domain_free_irqs()
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:37 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No point in looking up things over and over. Just look up the associated
irq data and work from there.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: x86@kernel.org
Cc: linux-hyperv@vger.kernel.org
---
 arch/x86/hyperv/irqdomain.c |   55 +++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -253,64 +253,43 @@ static int hv_unmap_msi_interrupt(struct
 	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry);
 }
 
-static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
+static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 {
-	u64 status;
 	struct hv_interrupt_entry old_entry;
-	struct irq_desc *desc;
-	struct irq_data *data;
 	struct msi_msg msg;
+	u64 status;
 
-	desc = irq_to_desc(irq);
-	if (!desc) {
-		pr_debug("%s: no irq desc\n", __func__);
-		return;
-	}
-
-	data = &desc->irq_data;
-	if (!data) {
-		pr_debug("%s: no irq data\n", __func__);
-		return;
-	}
-
-	if (!data->chip_data) {
+	if (!irqd->chip_data) {
 		pr_debug("%s: no chip data\n!", __func__);
 		return;
 	}
 
-	old_entry = *(struct hv_interrupt_entry *)data->chip_data;
+	old_entry = *(struct hv_interrupt_entry *)irqd->chip_data;
 	entry_to_msi_msg(&old_entry, &msg);
 
-	kfree(data->chip_data);
-	data->chip_data = NULL;
+	kfree(irqd->chip_data);
+	irqd->chip_data = NULL;
 
 	status = hv_unmap_msi_interrupt(dev, &old_entry);
 
-	if (status != HV_STATUS_SUCCESS) {
+	if (status != HV_STATUS_SUCCESS)
 		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
-		return;
-	}
 }
 
-static void hv_msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void hv_msi_free_irq(struct irq_domain *domain,
+			    struct msi_domain_info *info, unsigned int virq)
 {
-	int i;
-	struct msi_desc *entry;
-	struct pci_dev *pdev;
+	struct irq_data *irqd = irq_get_irq_data(virq);
+	struct msi_desc *desc;
 
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+	if (!irqd)
 		return;
 
-	pdev = to_pci_dev(dev);
+	desc = irq_data_get_msi_desc(irqd);
+	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
+		return;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq) {
-			for (i = 0; i < entry->nvec_used; i++) {
-				hv_teardown_msi_irq_common(pdev, entry, entry->irq + i);
-				irq_domain_free_irqs(entry->irq + i, 1);
-			}
-		}
-	}
+	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
 }
 
 /*
@@ -329,7 +308,7 @@ static struct irq_chip hv_pci_msi_contro
 };
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.domain_free_irqs	= hv_msi_domain_free_irqs,
+	.msi_free		= hv_msi_free_irq,
 	.msi_prepare		= pci_msi_prepare,
 };
 

