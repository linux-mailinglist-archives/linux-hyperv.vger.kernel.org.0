Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050D045F811
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbhK0BXz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:23:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34706 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbhK0BVx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:21:53 -0500
Message-ID: <20211126223824.204004845@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yyhtvslqP4HLRieVFfAZFU9HV4/e0iOdDJgsQQb4EZc=;
        b=MSnZxqs36ngrl9esIIYADuLZ5UnosIcrhDvAVsnJuf2st6ZzR4E0B8BK0WhsczGF2aQGRB
        5xqOQF7gKjLg5HtkIGZlL6qPaoikrc//4NAmvgkfntQGveJ1vh93/nybm8ts4T5eKLbe2a
        FLC989xEGaNa67pn5Vg0kHFoSDs27rxgxD2Rnj0isODzxt0/Sbu19k1Ip1s3c4baRK4jif
        2Yl57PGritygSsdkg6F0Zs/thARyj0yJ2lkp6xOmLTci5ES3K6dmvTb8S/jWtOyJovQflo
        8tWJ8Gc9G8/Jsut61YVS4TsADPfWGLjLS9cFYLeUo18ZyEvWefuwbblT+T30NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yyhtvslqP4HLRieVFfAZFU9HV4/e0iOdDJgsQQb4EZc=;
        b=pxjlR8C9JsyjjdEic60Abn3AE0T4g0tEBV+QqXtyNfpm9QMaaFULGX1MUnX49YqwF0yZy0
        u2vfAxS294gl3eBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch 02/22] PCI/MSI: Fix pci_irq_vector()/pci_irq_get_attinity()
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:18:37 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

pci_irq_vector() and pci_irq_get_affinity() use the list position to find the
MSI-X descriptor at a given index. That's correct for the normal case where
the entry number is the same as the list position.

But it's wrong for cases where MSI-X was allocated with an entries array
describing sparse entry numbers into the hardware message descriptor
table. That's inconsistent at best.

Make it always check the entry number because that's what the zero base
index really means. This change won't break existing users which use a
sparse entries array for allocation because these users retrieve the Linux
interrupt number from the entries array after allocation and none of them
uses pci_irq_vector() or pci_irq_get_affinity().

Fixes: aff171641d18 ("PCI: Provide sensible IRQ vector alloc/free routines")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1187,19 +1187,24 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
 
 /**
  * pci_irq_vector - return Linux IRQ number of a device vector
- * @dev: PCI device to operate on
- * @nr: device-relative interrupt vector index (0-based).
+ * @dev:	PCI device to operate on
+ * @nr:		Interrupt vector index (0-based)
+ *
+ * @nr has the following meanings depending on the interrupt mode:
+ *   MSI-X:	The index in the MSI-X vector table
+ *   MSI:	The index of the enabled MSI vectors
+ *   INTx:	Must be 0
+ *
+ * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
 	if (dev->msix_enabled) {
 		struct msi_desc *entry;
-		int i = 0;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (i == nr)
+			if (entry->msi_attrib.entry_nr == nr)
 				return entry->irq;
-			i++;
 		}
 		WARN_ON_ONCE(1);
 		return -EINVAL;
@@ -1223,17 +1228,22 @@ EXPORT_SYMBOL(pci_irq_vector);
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
+ *
+ * @nr has the following meanings depending on the interrupt mode:
+ *   MSI-X:	The index in the MSI-X vector table
+ *   MSI:	The index of the enabled MSI vectors
+ *   INTx:	Must be 0
+ *
+ * Return: A cpumask pointer or NULL if @nr is out of range
  */
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 {
 	if (dev->msix_enabled) {
 		struct msi_desc *entry;
-		int i = 0;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (i == nr)
+			if (entry->msi_attrib.entry_nr == nr)
 				return &entry->affinity->mask;
-			i++;
 		}
 		WARN_ON_ONCE(1);
 		return NULL;

