Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081824CA64
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHUCSL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgHUCRU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D5C061387;
        Thu, 20 Aug 2020 19:17:19 -0700 (PDT)
Message-Id: <20200821002948.472642859@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YM0Jb+0jacRYeAAEIXyvt7LyQs4eenP0P8zOev+VYEA=;
        b=XYwY5aZBZHc/cE8NoEwTRaXWx4kQ9d5LAVJKdZmLxtBDVRWBQIJ1CD55OOiD8/PaSIC/Qz
        86xyuToyG6fI0SYmZSPxwoPMnRKptHaFKEijx8ccnzdBv83L4NnYP/UaMCRLf1xPIu9QD6
        LnA+w+4x3Jkpbea1y5BQ1kxBaz1UJLA/aMDIsKy/If47+NLxbOJk4c2rnPclYU5gciOWt2
        q7yABVl1IeaRUY1SCLr5pnWVG3Lc67GbPkqqE2Np8EEdfhi2F/dQu1naD6Hi5jWT+CBefq
        9I1Ctkigd4ye/r+nFa9qaNWht25+BgwifwFgNJLDdwMDEhIbqsoywHttGKLZ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YM0Jb+0jacRYeAAEIXyvt7LyQs4eenP0P8zOev+VYEA=;
        b=SJFB1hWrc9NTcS6nWGalTM0SJUTy+5x03Z372SqiJn9+JXrx5GkSr1rUnc2/RHr+HRLf5m
        OPRQxTlNSr1y7xCA==
Date:   Fri, 21 Aug 2020 02:24:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
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
Subject: [patch RFC 32/38] x86/irq: Make most MSI ops XEN private
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Make-most-MSI-ops-XEN-private.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Nothing except XEN uses the setup/teardown ops. Hide them there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/x86_init.h |    2 --
 arch/x86/pci/xen.c              |   23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -276,8 +276,6 @@ struct x86_platform_ops {
 struct pci_dev;
 
 struct x86_msi_ops {
-	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -156,6 +156,13 @@ static int acpi_register_gsi_xen(struct
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
+struct xen_msi_ops {
+	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_msi_irqs)(struct pci_dev *dev);
+};
+
+static struct xen_msi_ops xen_msi_ops __ro_after_init;
+
 static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
@@ -414,7 +421,7 @@ static int xen_msi_domain_alloc_irqs(str
 	else
 		type = PCI_CAP_ID_MSI;
 
-	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
 static void xen_msi_domain_free_irqs(struct irq_domain *domain,
@@ -423,7 +430,7 @@ static void xen_msi_domain_free_irqs(str
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+	xen_msi_ops.teardown_msi_irqs(to_pci_dev(dev));
 }
 
 static struct msi_domain_ops xen_pci_msi_domain_ops = {
@@ -461,17 +468,17 @@ static __init struct irq_domain *xen_cre
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_initial_domain()) {
-		x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+		xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
 		x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 		pci_msi_ignore_mask = 1;
 	} else if (xen_pv_domain()) {
-		x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-		x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 		pci_msi_ignore_mask = 1;
 	} else if (xen_hvm_domain()) {
-		x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+		xen_msi_ops.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
 	} else {
 		WARN_ON_ONCE(1);
 		return;

