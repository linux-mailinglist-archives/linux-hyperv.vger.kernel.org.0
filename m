Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC31945F8B6
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbhK0BZI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:25:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbhK0BXH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:23:07 -0500
Message-ID: <20211126223825.264524206@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N3CFGfVjsY7LgA1Yw7Ey6P6ZQR/J2nTOxZlFyVj+tfU=;
        b=UfXqK4gHJS3wPrPWiNFsuJp5HCTjIMxFsP8ieaP1ilUkrrU01dxUB5PdkZecIz/2WXNEDq
        zvQjSUFgNnyACCzEWpqx1wmulOVMiL53hM7R/wSlGdbFvvWu840Kf2DJaw206hvZUW/rQp
        dOlRJjtmhZTf9O3fV+JGlP/YxAK15GPOFZABTPuiIs1aoD0EvDnWkH4402nsZ8ReI8AieR
        SrVz0lfx1O/CNC7HT879BBtrVQq4CHQ0CndpLLdNF7SJonwfQgc1mB4YRrtlRWvv4yi+F/
        P9XuE8iCb//pScvRTDx5E4hACjEKW7m4egqtMvg4mKkUgc8gQngM5uxro0gbbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N3CFGfVjsY7LgA1Yw7Ey6P6ZQR/J2nTOxZlFyVj+tfU=;
        b=bQ7sWeM7+DD80GlhKbKWVV73INxg6+XoecjdOCWqiIj/3h6tbwB6loe8CEFHmwu4WmDfwV
        nt+kpAzvuwOrXJAQ==
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
Subject: [patch 20/22] PCI/MSI: Make pci_msi_domain_check_cap() static
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:52 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No users outside of that file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    5 +++--
 include/linux/msi.h         |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -79,8 +79,9 @@ static inline bool pci_msi_desc_is_multi
  *  1 if Multi MSI is requested, but the domain does not support it
  *  -ENOTSUPP otherwise
  */
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev)
+static int pci_msi_domain_check_cap(struct irq_domain *domain,
+				    struct msi_domain_info *info,
+				    struct device *dev)
 {
 	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -438,8 +438,6 @@ void *platform_msi_get_host_data(struct
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);

