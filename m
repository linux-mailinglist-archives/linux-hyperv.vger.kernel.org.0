Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6B24CA0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHUCRE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgHUCQ7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B5C061385;
        Thu, 20 Aug 2020 19:16:59 -0700 (PDT)
Message-Id: <20200821002946.887237419@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GYsCif/3llmuLBvpYPtjuTHhsKUK5MCMDeW2t2MJscU=;
        b=q7dSxIfa2NAL9KD2teMyDV01SxnyZKzF6/JmWFSxrt4bg5x1doERDgaXnVj7u4mOEdz45i
        s8eTgKutbpA8zbvLN5XbMOhfEhT83rB5QSmk3Nf0wJfsbCBE7O+H8RbvjPFoHLYvaj3PI5
        0Ir3gWIVXdw7KlQi2QzmUFBvtwM6SWdulp/PPE8Spn9KjhcUnevfsg+y1085hUP5RhdjNK
        F3NUTNp6L/aTcVNHc6YLFBxk5XAo5Pz16xMSpAOmFrmGxGLLpFdTuB0EtA14DMy8whOStx
        rsDXjkHsk66HqrWp+bjMVgu9KVh7sP5kmRE4Up2Fo/rMlXBGcFLN0TtbKmh7Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GYsCif/3llmuLBvpYPtjuTHhsKUK5MCMDeW2t2MJscU=;
        b=QYOx4xUygE/UcllLug+eYgjWxrxLwQK7B3c3lbd2KZJMEHg+1hEG377sd9w4Vwj9eR08qW
        BT1NC9ypZFV92bAg==
Date:   Fri, 21 Aug 2020 02:24:40 +0200
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
Subject: [patch RFC 16/38] x86/irq: Move apic_post_init() invocation to one place
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename="x86-irq--Move-apic_post_init"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No point to call it from both 32bit and 64bit implementations of
default_setup_apic_routing(). Move it to the caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c     |    3 +++
 arch/x86/kernel/apic/probe_32.c |    3 ---
 arch/x86/kernel/apic/probe_64.c |    3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1429,6 +1429,9 @@ void __init apic_intr_mode_init(void)
 		break;
 	}
 
+	if (x86_platform.apic_post_init)
+		x86_platform.apic_post_init();
+
 	apic_bsp_setup(upmode);
 }
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -170,9 +170,6 @@ void __init default_setup_apic_routing(v
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 void __init generic_apic_probe(void)
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -32,9 +32,6 @@ void __init default_setup_apic_routing(v
 			break;
 		}
 	}
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)

