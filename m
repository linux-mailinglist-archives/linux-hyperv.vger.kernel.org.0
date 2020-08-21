Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF324CA91
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHUCTj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:19:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHUCQy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:54 -0400
Message-Id: <20200821002946.407651941@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x5nZXo6cKpQJi+LJrLWJ/GvNtpRx+XtBaOkH00CFFRQ=;
        b=m+me1vmSQTR1TmOCXfW5HE52gKUQy31X3q+NfoqsEUvoAD1nNrYfO2/d8+9qt9HpnLnc3L
        9xlyZOu8x7aI7uyVJ45XK9Hue0PkEEp+s7lJJYzhMD9KgMmxE7IyJhl+qSTLZmVKkYCDPb
        RhFksJJPpPyrfUmUphbCxjmTzowA+en0NCKES+VvvnPe6nUPq93qQ3YCSf6fddT/ePnc2F
        bfzzUyyaxXlS04q1SifU8oUpFP9pP6+taFWL/M9jY4/PuAnPwCtklyY9sY1DtofZxJype8
        fGaKGMNErKS2dVD2ukR9ccQR6tSqzmlWF+q4VPljglEyYlxhTriHDgadgfP9Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x5nZXo6cKpQJi+LJrLWJ/GvNtpRx+XtBaOkH00CFFRQ=;
        b=WP1lR6Ov5eRh39c1bvFbHSX/vrQgh9I3UIKrJ9Fs7pMY2siTXoDYmm3f3wdQVW7v3+oYTa
        Jz4R7LHGQT+o3TBw==
Date:   Fri, 21 Aug 2020 02:24:35 +0200
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
Subject: [patch RFC 11/38] x86/irq: Consolidate DMAR irq allocation
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Consolidate-DMAR-irq-allocation.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

None of the DMAR specific fields are required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hw_irq.h |    6 ------
 arch/x86/kernel/apic/msi.c    |   10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -83,12 +83,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_DMAR_TABLE
-		struct {
-			int		dmar_id;
-			void		*dmar_data;
-		};
-#endif
 #ifdef	CONFIG_X86_UV
 		struct {
 			int		uv_limit;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
 static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->dmar_id;
+	return arg->hwirq;
 }
 
 static int dmar_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_domain_set_info(domain, virq, arg->dmar_id, info->chip, NULL,
-			    handle_edge_irq, arg->dmar_data, "edge");
+	irq_domain_set_info(domain, virq, arg->devid, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -384,8 +384,8 @@ int dmar_alloc_hwirq(int id, int node, v
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
-	info.dmar_id = id;
-	info.dmar_data = arg;
+	info.devid = id;
+	info.data = arg;
 
 	return irq_domain_alloc_irqs(domain, 1, node, &info);
 }

