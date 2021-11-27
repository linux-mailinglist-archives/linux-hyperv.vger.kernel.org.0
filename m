Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4A45F932
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbhK0B0R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbhK0BYJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:24:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC42C0613F7;
        Fri, 26 Nov 2021 17:19:30 -0800 (PST)
Message-ID: <20211126223824.382273262@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w7GncdwHZHkuO6107A0BMJdTfScXy8O2W/1Ze2L1KBI=;
        b=3QE1kwAZSn0AOk+bavNZ+1QGzKQwtdZggp/2QupSoLnSv4hgBf0i5NYSQk1Xh3Te7r2lj2
        RIKrJ8nRt+yOUSqgv/raaaEzi4g7iUcBuN551YDz6Xaov3UfHqH8KbAZc91CzVW9+qGr+5
        0K2kZCbaxqFIj4mFhtFNSEu+KAhUE1WDPPYhMsX8N8ff3xkHmUekaAo3u4T7A66BSLqhYp
        4XGys/cw7iBRHVdNQTa9QVZRKfJojBV6cCn4mN7axCrfi968z4S8U7K2yEJOsKQLwWgo1n
        EZ7cAGoXHBM1b+VijVozl6thH/vIF8O3zDUH6vXm2+A/d3lLLGdu2F4xFTZCEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w7GncdwHZHkuO6107A0BMJdTfScXy8O2W/1Ze2L1KBI=;
        b=/+krVhSSUWDZcKzVa8Z7DFG7rRo3Xw/7JdSU0e8eVBPs+Rs+2BYhA4S+6BpELmkd/ZqXPd
        OxLK/KydpitaftBQ==
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
Subject: [patch 05/22] genirq/msi: Fixup includes
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:28 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove the kobject.h include from msi.h as it's not required and add a
sysfs.h include to the core code instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    1 -
 kernel/irq/msi.c    |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,7 +2,6 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
-#include <linux/kobject.h>
 #include <linux/list.h>
 #include <asm/msi.h>
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/pci.h>
 
 #include "internals.h"

