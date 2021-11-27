Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EE45F856
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbhK0BYO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbhK0BWM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:22:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050EC06175B;
        Fri, 26 Nov 2021 17:18:58 -0800 (PST)
Message-ID: <20211126223824.855947162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lhIUE61Y2ARmaAA3RG1h6L7zHDs4cKgQsOndAjR5STU=;
        b=yoS0BgXw6njThHf+Kcu+0fhiWKN/AUUQyrhRnyP005hqMqVamE0iJS9Nymvj7WrdKiNPm9
        0mkqTv8z1FNG/R4t2Fb6c/SNDfW7kY+rGDzKX04havRRDKZzlJgNXPOOfjLye4/WFJKJfP
        xcx9BSS5LKHxoE2JVqPQ+trXGuk8vUYn7URN+PrSM7NPKPbRnZx0hNWCcZeSi04qCE5Oel
        Y9mNYAqJgytmNlLxc+cRQ+JOuNk/T63yzW8ubMu6NjUJqGwyZOKHP2t1qinSdVRhJwmcXC
        H2q4r2C5Ug8hjBbQvmRgnBEn2dAl8pePx8S03VEkIoCUjdrHK0EN0Pjw6qJTBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lhIUE61Y2ARmaAA3RG1h6L7zHDs4cKgQsOndAjR5STU=;
        b=Jl/BK00H8LeQTqtN+ZwcnoSd8mGeJ2yjBlN3eDYCTgWb72N+GwWWz/rF3WttD4qNLnGKTb
        /KKLjL7as1fFZ/DQ==
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
Date:   Sat, 27 Nov 2021 02:18:54 +0100 (CET)
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
 

