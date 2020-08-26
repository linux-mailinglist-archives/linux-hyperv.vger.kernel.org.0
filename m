Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61321252E31
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgHZMKY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:10:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgHZMBe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:34 -0400
Message-Id: <20200826112333.622352798@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m8VqN5j7CyoINljd+ev/uJTpzn1HV5cfd+C+/482K8I=;
        b=Ci+yEYTVdn5HrvM1gWFjUHFH5E0a8fnUM0twCozKUIyvPackZGIEC1eEn1P9voCSchqxoe
        cbRDIA+GcmiYA8P8bLyu+IO/TvXATMZzaCAgLTHgi2S+2eBV284MU0YnHjci+ffs85TW3S
        Dm4ID1SxrKaVtlLBYh82EhYa7Fbii8vRrPYTkX4wb7noEwSgk/QG6D7vjkyDYVT6qEQmV2
        DbJOLG51R61SMLP/9lKHqU2ufbvoHcJbPnNAs4uXW3X/OSr6YPLjGB0Ldcl1eXRpL2sZVL
        349nZT9B18UKuwImao/7wESbOOL9PmLyk0S0sT2ykfqjXEaYS3Bsx/YgL5KggA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m8VqN5j7CyoINljd+ev/uJTpzn1HV5cfd+C+/482K8I=;
        b=oFL/js22qqSW7G3PPr5wjroZDaDLsQwO4oZM8Pjs2hlm7OciNNEbJWYeWlRq9TWSaCeZeL
        VwR0c3IpoWnkNkBQ==
Date:   Wed, 26 Aug 2020 13:16:58 +0200
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
Subject: [patch V2 30/46] x86/xen: Wrap XEN MSI management into irqdomain
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To allow utilizing the irq domain pointer in struct device it is necessary
to make XEN/MSI irq domain compatible.

While the right solution would be to truly convert XEN to irq domains, this
is an exercise which is not possible for mere mortals with limited XENology.

Provide a plain irqdomain wrapper around XEN. While this is blatant
violation of the irqdomain design, it's the only solution for a XEN igorant
person to make progress on the issue which triggered this change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Juergen Gross <jgross@suse.com>

---
Note: This is completely untested, but it compiles so it must be perfect.
---
 arch/x86/pci/xen.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -407,6 +407,63 @@ static void xen_teardown_msi_irq(unsigne
 	WARN_ON_ONCE(1);
 }
 
+static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
+				     struct device *dev,  int nvec)
+{
+	int type;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return -EINVAL;
+
+	if (first_msi_entry(dev)->msi_attrib.is_msix)
+		type = PCI_CAP_ID_MSIX;
+	else
+		type = PCI_CAP_ID_MSI;
+
+	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+}
+
+static void xen_msi_domain_free_irqs(struct irq_domain *domain,
+				     struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+static struct msi_domain_ops xen_pci_msi_domain_ops = {
+	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
+	.domain_free_irqs	= xen_msi_domain_free_irqs,
+};
+
+static struct msi_domain_info xen_pci_msi_domain_info = {
+	.ops			= &xen_pci_msi_domain_ops,
+};
+
+/*
+ * This irq domain is a blatant violation of the irq domain design, but
+ * distangling XEN into real irq domains is not a job for mere mortals with
+ * limited XENology. But it's the least dangerous way for a mere mortal to
+ * get rid of the arch_*_msi_irqs() hackery in order to store the irq
+ * domain pointer in struct device. This irq domain wrappery allows to do
+ * that without breaking XEN terminally.
+ */
+static __init struct irq_domain *xen_create_pci_msi_domain(void)
+{
+	struct irq_domain *d = NULL;
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
+	if (fn)
+		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
+
+	/* FIXME: No idea how to survive if this fails */
+	BUG_ON(!d);
+
+	return d;
+}
+
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_pv_domain()) {
@@ -427,6 +484,12 @@ static __init void xen_setup_pci_msi(voi
 	}
 
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+
+	/*
+	 * Override the PCI/MSI irq domain init function. No point
+	 * in allocating the native domain and never use it.
+	 */
+	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
 }
 
 #else /* CONFIG_PCI_MSI */

