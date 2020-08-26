Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3D252E72
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgHZMNx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:13:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57538 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgHZMBU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:20 -0400
Message-Id: <20200826112331.250130127@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1OGPpjWOZmr24XSSpz6Nc6JwYhMQbICDj4hspoAwZbU=;
        b=wxfQv6OayK5u1H6FLXXIAcQEscg4HPJjeG+pstXl+pgdl31DNhEzs50ZOWpxyGkrMjOLQW
        1o9FaSrwh83greTW5vyCTb8zGAVDs36ov93GPrm04pneHRj9I5V1gKWvrEoOOH7jQ4WymB
        2dnYg73pm5Qf+NAJfV1VaexuVCwBhHU44wya2eXAw2Z+FnlfrDPKCol1dSx8jwE8+r40Me
        gFhsh/HnjcO+3pm7neY65BLXMr3nyoULj1GDuHwk6obFDadT45ulfhicTAV256PX5YzSNc
        dGaROF2c7TCDhfRvvityWK3X4gmliC/zDpfaFSui0jbwM5OFgjvjPhruWz0AMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1OGPpjWOZmr24XSSpz6Nc6JwYhMQbICDj4hspoAwZbU=;
        b=8tJ5SZ+n+CTD4sQz2apdajCK0eVmBiC+58dr8L0pUzWdakVsmFSRzEYppLbMSxQkKBKFP2
        zKDpRtN2h+Z7x/Ag==
Date:   Wed, 26 Aug 2020 13:16:34 +0200
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
Subject: [patch V2 06/46] x86/msi: Remove pointless vcpu_affinity callback
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Setting the irq_set_vcpu_affinity() callback to
irq_chip_set_vcpu_affinity_parent() is a pointless exercise because the
function which utilizes it searchs the domain hierarchy to find a parent
domain which has such a callback.

Remove the useless indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch. The same is probably true for lots of other irq chips.
---
 arch/x86/kernel/apic/msi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -278,7 +278,6 @@ static struct irq_chip pci_msi_ir_contro
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 

