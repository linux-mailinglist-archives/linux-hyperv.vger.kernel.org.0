Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23024CA58
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHUCR7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:17:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgHUCRX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:23 -0400
Message-Id: <20200821002948.755000191@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KXAiwxi/7+KHEXLRwqgJcO0FvN7PQ13nbqh2Dv3IlbA=;
        b=DomSu6NWbyTcu6RFy3xXtuWSfP0W3Tv8gt55Hn/sh+GWhjHXXgTmQt6Mvsr7xBWeu6zOwk
        zImTgH6S7Ligv+UUvg/1wAjgJHEzTIyz/hcIavRvUKXc1CL3Bc2VUqfJJojl3Lk5aihA1H
        5iKiKpWwMb4qHVLmWdVXexDkpRJ+N1kyIN49S09jiq6+AvlcfdcdTO5h/oY8PNexOn1EEU
        vdT69zYrCMEy9dTaTQz4bno2KGJeMftQKVlfVxxXXa1BpXWtAP1EKCWzBdlheHCwkuY1Y2
        CzQ4TjuMP48Qf1l9RFxY3ZBjycOVA3LggRVZSEzHnEg2rIeFeIZOD4qs7uUN/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KXAiwxi/7+KHEXLRwqgJcO0FvN7PQ13nbqh2Dv3IlbA=;
        b=oneia6T1+o5RIJelvR6r8Joibq3DXGPArZ9NPLD/c2Lp/2Flw4pntgzcXCjRW/z8tnc6QC
        +CDbuxUsotAHrdBw==
Date:   Fri, 21 Aug 2020 02:24:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch RFC 35/38] platform-msi: Provide default irq_chip::ack
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="platform-msi--Provide-default-irq_chip--ack.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For the upcoming device MSI support it's required to have a default
irq_chip::ack implementation (irq_chip_ack_parent) so the drivers do not
need to care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform-msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,6 +95,8 @@ static void platform_msi_update_chip_ops
 		chip->irq_mask = irq_chip_mask_parent;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
 	if (!chip->irq_set_affinity)

