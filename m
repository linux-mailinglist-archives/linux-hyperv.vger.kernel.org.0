Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB146AB9B
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Dec 2021 23:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357477AbhLFWbX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Dec 2021 17:31:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357095AbhLFWbP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Dec 2021 17:31:15 -0500
Message-ID: <20211206210224.539281124@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638829665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fpyg7awX8dijQzBRp+WIS78Jmos3C/8mTMn+TSrhxD8=;
        b=pnGIDteYP84F0igC2k+ACUhibYQ3881OhRiiuaVIOBjTshXhjGeVdgZAA/lcK5sjvLEMoj
        ROvDFYYNJX0JhR2QOKUEjXyWb04lLq7PP9xV81Z0D1FytvGg8OABck9JmC/ylB+YU2AvRJ
        PZVaY5Ia3WuXqX49dyC//GQiLcA+5A6GZy5/1+M3d4XVPgxEHo1T/dGhvFuUZ1a4SJvQjn
        ICbirvZcyT0c9k1KJC4jGdKAhnGZprc4Xqsi6XNBDU2/0hwWf55EV2aY3VwLmgUvxv9n/d
        Nfe/m+FudbplubW4O/Khqp8m6T0J7JnGYcrRL/PejELQssL7PtUMHvHQVkjmhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638829665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fpyg7awX8dijQzBRp+WIS78Jmos3C/8mTMn+TSrhxD8=;
        b=RuOHGkoAA1Vj7KuipSnVapOZhwsUvKElxjyliNOso5sc0g+RXjuUG8oJb8SOmIunMIh0Pt
        uWzxF181jxyPh3AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch V2 13/23] PCI/MSI: Cleanup include zoo
References: <20211206210147.872865823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:27:44 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Get rid of the pile of unneeded includes which accumulated over time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
V2: Address build fail on powerpc - Cedric
---
 drivers/pci/msi.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -7,22 +7,14 @@
  * Copyright (C) 2016 Christoph Hellwig.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/err.h>
-#include <linux/mm.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/proc_fs.h>
-#include <linux/msi.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/acpi_iort.h>
-#include <linux/slab.h>
+#include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/of_irq.h>
+#include <linux/pci.h>
 
 #include "pci.h"
 

