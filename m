Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A936424CA18
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHUCRJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:17:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgHUCRE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:04 -0400
Message-Id: <20200821002947.263753263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xhbFdhsCsQ5VSYCUiVy99pvX2yN4idfA0I7XlvTQakE=;
        b=ZHPMzYaPzfOECo836sQFsUmCX7TFv2uj13sv98D4bI8o6iI6WKZs1U7pYv9brD8a4az4fs
        NyW2wBNkPya+ae9bCFjp09So5OeSSAX52C6juW+HKgm4ymvYeCx/IfVgaDhjbZBDHJN2Y7
        N3Ga0P6rEMZqQTiiVOkR3j0KsFCD4vhJzcH9tjRPhCUvVfZb3FJIfpw8yH5bG9MqEf/Vfx
        HtYfBOCZj0F8653MC9JjGiUq1BCATOsRuRbgl0R92oj6nP6xijsr8QEAN3xNC7i6G9hIwj
        93+5AhgyK99DgKHmu6NAF2r5clFidEeEDceyitr+J6fyYTJp9z6GKMouFgvM/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xhbFdhsCsQ5VSYCUiVy99pvX2yN4idfA0I7XlvTQakE=;
        b=JYv5Wl4UiPVl3hvzKT1TU9FbgMyvxpUxxeVQ/q1ta3fiBXM7WdZyhJVHsfCIDihr82ihZJ
        mZtv6aJHBV8/OEAQ==
Date:   Fri, 21 Aug 2020 02:24:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
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
Subject: [patch RFC 20/38] PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="PCI--vmd--Mark-VMD-irqdomain-with-DOMAIN_BUS_VMD_PCI.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Devices on the VMD bus use their own MSI irq domain, but it is not
distinguishable from regular PCI/MSI irq domains. This is required
to exclude VMD devices from getting the irq domain pointer set by
interrupt remapping.

Override the default bus token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/vmd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
 		return -ENODEV;
 	}
 
+	/*
+	 * Override the irq domain bus token so the domain can be distinguished
+	 * from a regular PCI/MSI domain.
+	 */
+	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);

