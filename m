Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561C124CA6D
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHUCSZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:18:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgHUCRR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:17 -0400
Message-Id: <20200821002948.189324911@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eWBLX5XgA0aFXkIZkqQam70cKG8KNwwE8vYzAqD+WN4=;
        b=eUyv3sONGiRpnc/zgIJAYkirhWZcZynKVLYkoQPXXP4A6ZnjjoBWLHzsTmHEEM4HCvy9jr
        edi49BZCXKIqUXgHlYUZdl1AE9a4yg+xc1pZDfKbqK5UM72SrtIMeXAM8xa7KoQUn0KfzR
        QTL59m0n4Owxi2cxF5vwj9hJQAq3MpMy7CxEwR9guh/hdlPrL3LL9DIcFn3F0sTM7vMZMS
        06Zuob5KBzqYerYQ33uVsMGFbUQ6ZumEtRGXxklWClYS/T8IGHYIJGeoFrzTBLVqHTzo8Z
        hLIwRJlEaxDg5e5oEKHQ6Q5LEmVf3JA63yBZfaOTXWLXqjyeizqcTRcqJwUwOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eWBLX5XgA0aFXkIZkqQam70cKG8KNwwE8vYzAqD+WN4=;
        b=M2AaOXstsi+4kBCSX8XCuM6S/HPc49K6W3zpC28X3vBu1VOwwAtybmVqDaJleAJgrIJwF+
        eQ3UqKA/FTWlS8Bg==
Date:   Fri, 21 Aug 2020 02:24:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: [patch RFC 29/38] x86/pci: Set default irq domain in pcibios_add_device()
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-pci--Set-default-irq-domain-in-pcibios_add_device.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now that interrupt remapping sets the irqdomain pointer when a PCI device
is added it's possible to store the default irq domain in the device struct
in pcibios_add_device().

If the bus to which a device is connected has an irq domain associated then
this domain is used otherwise the default domain (PCI/MSI native or XEN
PCI/MSI) is used. Using the bus domain ensures that special MSI bus domains
like VMD work.

This makes XEN and the non-remapped native case work solely based on the
irq domain pointer in struct device for PCI/MSI and allows to remove the
arch fallback and make most of the x86_msi ops private to XEN in the next
steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/irqdomain.h |    2 ++
 arch/x86/kernel/apic/msi.c       |    2 +-
 arch/x86/pci/common.c            |   18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -53,9 +53,11 @@ extern int mp_irqdomain_ioapic_idx(struc
 #ifdef CONFIG_PCI_MSI
 void x86_create_pci_msi_domain(void);
 struct irq_domain *native_create_pci_msi_domain(void);
+extern struct irq_domain *x86_pci_msi_default_domain;
 #else
 static inline void x86_create_pci_msi_domain(void) { }
 #define native_create_pci_msi_domain	NULL
+#define x86_pci_msi_default_domain	NULL
 #endif
 
 #endif
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
+struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
+#include <asm/irqdomain.h>
 
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
@@ -633,8 +634,9 @@ static void set_dev_domain_options(struc
 
 int pcibios_add_device(struct pci_dev *dev)
 {
-	struct setup_data *data;
 	struct pci_setup_rom *rom;
+	struct irq_domain *msidom;
+	struct setup_data *data;
 	u64 pa_data;
 
 	pa_data = boot_params.hdr.setup_data;
@@ -661,6 +663,20 @@ int pcibios_add_device(struct pci_dev *d
 		memunmap(data);
 	}
 	set_dev_domain_options(dev);
+
+	/*
+	 * Setup the initial MSI domain of the device. If the underlying
+	 * bus has a PCI/MSI irqdomain associated use the bus domain,
+	 * otherwise set the default domain. This ensures that special irq
+	 * domains e.g. VMD are preserved. The default ensures initial
+	 * operation if irq remapping is not active. If irq remapping is
+	 * active it will overwrite the domain pointer when the device is
+	 * associated to a remapping domain.
+	 */
+	msidom = dev_get_msi_domain(&dev->bus->dev);
+	if (!msidom)
+		msidom = x86_pci_msi_default_domain;
+	dev_set_msi_domain(&dev->dev, msidom);
 	return 0;
 }
 

