Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7446AB87
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Dec 2021 23:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356794AbhLFWbM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Dec 2021 17:31:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356856AbhLFWbI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Dec 2021 17:31:08 -0500
Message-ID: <20211206210224.265589103@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638829657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OKsXQmZewVMh9C4veaPA025YU+pW4cMZqzIAn23b/9c=;
        b=vZzNCRO+uOrMt1rLYUlSjWHvY3GnOwXQ/odIk4OnimL55yM4E7H9Z+gKxR4cdWzJuc9jJT
        M0aZip9AGf/BRov7wd4DUsRP6NuHKtBNXayKEfTNAPYWG4mlPDCTJXpLfq+Eq2Q7uel0c0
        GCYlxK1amEskkZn0CPcuIPlwQANt3pdUSVU0mXb6Dh6glegghN2NwscVEl8RJS6xJpYmzr
        0oSjRQ0h7Lm4xi7TTTOAuPFvY1F1jeW22TqUuxURSvBD6YjS5m5HOdgSgSZmuNW7/hljHH
        0p6i/mhLMFw2u59Zr1gi+Goyq9OYh0ugIdb202nzF0CcX0f/aD/i2jlLaPiQJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638829657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OKsXQmZewVMh9C4veaPA025YU+pW4cMZqzIAn23b/9c=;
        b=M/NxrnxGKVPLqAlsqI5UQ6dl9IZUEhUwGcQJKRyC/Ho89KfJQzOP0MU4EFQc7/B84xAAnW
        7QekxbEDbxz2NvAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch V2 08/23] PCI/sysfs: Use pci_irq_vector()
References: <20211206210147.872865823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:27:36 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

instead of fiddling with msi descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci-sysfs.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -62,11 +62,8 @@ static ssize_t irq_show(struct device *d
 	 * For MSI, show the first MSI IRQ; for all other cases including
 	 * MSI-X, show the legacy INTx IRQ.
 	 */
-	if (pdev->msi_enabled) {
-		struct msi_desc *desc = first_pci_msi_entry(pdev);
-
-		return sysfs_emit(buf, "%u\n", desc->irq);
-	}
+	if (pdev->msi_enabled)
+		return sysfs_emit(buf, "%u\n", pci_irq_vector(pdev, 0));
 #endif
 
 	return sysfs_emit(buf, "%u\n", pdev->irq);

