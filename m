Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93F252E87
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgHZMOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgHZMBB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:01 -0400
Message-Id: <20200826112330.928952181@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GJq1CEkWcaKs7Em2GYlhCtoVPP5Bukhfi2C/MO87oqU=;
        b=dUiCUdbmQOpMkybm8iOwgllxN+rbWKXHIOv8xVx9P0CYcEvTrFfH+U510MWl4oVPJ0gtga
        ahqCxi9ahMWxjIEsaydAa/rKy2pLoS0XfR5K4IDb4uihwE2PQKBjV4F9A8pFZYgGN7PuxQ
        EOB1SaNvp8dPe4VJ46qh1GtqJBzaIwyAez52Agf9f+0VgyaCndFq+l56XNDg+v6HO0uzx9
        KwoWueh6GMvJjAnouk8aSNrY7sJJRDuvX4Ynt2UCn35woH/JnJXgQKrYdLfLlaCEBkFk9c
        Y7WVHB/k+RUE/B1QV9Xa55mz4IiFTHSC1D8o3oA/1GFewMJzkzQ+YqY5c8skRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GJq1CEkWcaKs7Em2GYlhCtoVPP5Bukhfi2C/MO87oqU=;
        b=HQTmvGI7KkXeaCWVTYGHuxhaaAjsX1BJNwh3dDUbNFgWHKVDFEbHlgJXRMU0uVeDi8WgHM
        cnjckdDSNiedpnBg==
Date:   Wed, 26 Aug 2020 13:16:31 +0200
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
Subject: [patch V2 03/46] PCI: vmd: Dont abuse vector irqomain as parent
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VMD has it's own PCI/MSI interrupt domain which is not in any way depending
on the x86 vector domain. PCI devices behind VMD share the VMD MSIX vector
entries via a VMD specific message translation to the actual VMD MSIX
vector. The VMD device interrupt handler for the VMD MSIX vectors invokes
all interrupt handlers of the devices which share a vector.

Making the x86 vector domain the actual parent of the VMD irq domain is
pointless and actually counterproductive. When a device interrupt is
requested then it will activate the interrupt which traverses down the
hierarchy and consumes an interrupt vector in the vector domain which is
never used.

The domain is self contained and has no parent dependencies, so just hand
in NULL for the parent and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org
---
V2: New patch.
---
 drivers/pci/controller/vmd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -573,7 +573,8 @@ static int vmd_enable_domain(struct vmd_
 		return -ENODEV;
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
-						    x86_vector_domain);
+						    NULL);
+
 	if (!vmd->irq_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENODEV;

