Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5645F9BA
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbhK0B2A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbhK0BZ7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:25:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A191C0613FF;
        Fri, 26 Nov 2021 17:19:52 -0800 (PST)
Message-ID: <20211126223825.205369150@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nFqFw10FNB3YOwALwDw82lvlHKuNVaj2KNOVAS+AX+k=;
        b=XxApkOzom8INqALAoCZXnrM4Gnfq0P5GFuHbGcbsFfXChmsBjBRR8Zre+TuXWv4z5oHF/D
        27C5TK24a23MOmJBeYVaW9cCplXJLITNdKg10JEBz8oTehDPyyfs3FciGiHEms5WL8JDag
        52S+Frofyun05kxZ+YWSxvjUyOIel0FxMfLXiEs3TDVLbwr55wPMh/3rPSf2nT/i2JzwLL
        zftakULTHTxPert40kEEFdjOny39idUZcd25undSrm5WMAU87UNDGUGbSd6C5shoMJVpZk
        a/+xgaOEsYDt53mm6tVNNHcfadUk2EMQ02Z8BgKKcXGB4JY6BzIjRA3g4H6V/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nFqFw10FNB3YOwALwDw82lvlHKuNVaj2KNOVAS+AX+k=;
        b=Vi13o2zcshu0Zxixi8TKOXGvkRDXe53XxUuH+PoNwGcyMUye1tI4Lhz4L+Jh6z/xJGTC6x
        SgID9tLyCfbnS1CQ==
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
Subject: [patch 19/22] PCI/MSI: Sanitize MSIX table map handling
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:50 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Unmapping the MSIX base mapping in the loops which allocate/free MSI
desciptors is daft and in the way of allowing runtime expansion of MSI-X
descriptors.

Store the mapping in struct pci_dev and free it after freeing the MSI-X
descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   18 ++++++++----------
 include/linux/pci.h   |    1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -241,14 +241,14 @@ static void free_msi_irqs(struct pci_dev
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		if (entry->pci.msi_attrib.is_msix) {
-			if (list_is_last(&entry->list, msi_list))
-				iounmap(entry->pci.mask_base);
-		}
-
 		list_del(&entry->list);
 		free_msi_entry(entry);
 	}
+
+	if (dev->msix_base) {
+		iounmap(dev->msix_base);
+		dev->msix_base = NULL;
+	}
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -501,10 +501,6 @@ static int msix_setup_entries(struct pci
 	for (i = 0, curmsk = masks; i < nvec; i++) {
 		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
 		if (!entry) {
-			if (!i)
-				iounmap(base);
-			else
-				free_msi_irqs(dev);
 			/* No enough memory. Don't try again */
 			ret = -ENOMEM;
 			goto out;
@@ -602,12 +598,14 @@ static int msix_capability_init(struct p
 		goto out_disable;
 	}
 
+	dev->msix_base = base;
+
 	/* Ensure that all table entries are masked. */
 	msix_mask_all(base, tsize);
 
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
-		goto out_disable;
+		goto out_free;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -473,6 +473,7 @@ struct pci_dev {
 	u8		ptm_granularity;
 #endif
 #ifdef CONFIG_PCI_MSI
+	void __iomem	*msix_base;
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;

