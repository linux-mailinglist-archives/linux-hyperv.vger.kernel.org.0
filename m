Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9413845F9A0
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbhK0B1v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbhK0BZu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:25:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7CC0613FB;
        Fri, 26 Nov 2021 17:19:43 -0800 (PST)
Message-ID: <20211126223824.855947162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lhIUE61Y2ARmaAA3RG1h6L7zHDs4cKgQsOndAjR5STU=;
        b=3I27l9siS6/oWE1JVUleWaLVyIqltkA2MLPegdLeuNH4xABPDw/VJVaN4/5xZwR/ZGDZ/X
        z+Yu7BvVlI1Y8bjNWoik91+y02TV4O1ndMArqPpxXOjDKZc7tlfYU+IDvy9/QevhvUBSSe
        nyPwZJhyvMtFooayQnVqCf1qlIROsanIGmDDCCtFBXia2UMjMfl/6bOUpWxdL7U7K8o12E
        JDsMmY+UavmvHDtkNDK/mVPz680wKGlII+yHcirzIllt9Z7FWCJTiaD8RGfRwVR8wCXrIw
        Fm3H9jm1jwNh8R+ZVC5kx7Gidr5VdZYHXIY0uS6MsgUEApx3IIaeb7WLJgRlLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lhIUE61Y2ARmaAA3RG1h6L7zHDs4cKgQsOndAjR5STU=;
        b=cSljuXSfhLC27NoLNfSXkLMLt2p1DhSlr0Y1CawLWxZ6xSqD3SbIMB5YfCzJcABWyjJgHj
        cjBENAHWPOx02EDA==
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
Subject: [patch 13/22] PCI/MSI: Cleanup include zoo
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:41 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Get rid of the pile of unneeded includes which accumulated over time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 

