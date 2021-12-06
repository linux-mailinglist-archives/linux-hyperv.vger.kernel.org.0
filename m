Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAD46AB7D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Dec 2021 23:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356836AbhLFWbH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Dec 2021 17:31:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356553AbhLFWbB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Dec 2021 17:31:01 -0500
Message-ID: <20211206210224.041777889@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638829650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tZSxCAPD1C/72AGbeyH6kqtxyoXqz8oMI6L3bIBgwo8=;
        b=VUkO3W8Pm9/sA/VUkP33Z1m5XdVqjjFScjNp9xzbJHH6VrzKV611tW5ns/aEvdBtDB5hhY
        4sUYsRTR30anXGxzbOb0K9PMdNFmLOz3BtlIbLryJFmRON/QnRUAVR/tUTC6oCBXwHrZNU
        z+uQJjknPy98RzoGlyywBCTzDA5LQQ/GGEJBDUQgMdOGLnUvWgS3MwvOzMBbN3MyH24wyE
        wloaWdPwNovCCcXh3rks0tF7L7gx6H5HzNZzGmXGzeG4yaX/ZJz5jQYq+o9N1e9u0u4iqL
        y3XBSQqFZdf+aTZPjClD1dgm+ky3LS8iWYvusLGtZCCQqQWdojsreK8LMBSkSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638829650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tZSxCAPD1C/72AGbeyH6kqtxyoXqz8oMI6L3bIBgwo8=;
        b=kAM4q1j8ks4DVQFHaEciD0kyWWmX1az4hnbSd/G606ypPv2fKA8RKlEiRFpQ/EsaY+4iOs
        9cLVCE7hHJDUqHDA==
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
Subject: [patch V2 04/23] genirq/msi: Remove unused domain callbacks
References: <20211206210147.872865823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:27:29 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No users and there is no need to grow them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211126223824.322987915@linutronix.de
---
 include/linux/msi.h |   11 ++++-------
 kernel/irq/msi.c    |    5 -----
 2 files changed, 4 insertions(+), 12 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -304,7 +304,6 @@ struct msi_domain_info;
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
- * @msi_finish:		Optional callback to finalize the allocation
  * @set_desc:		Set the msi descriptor for an interrupt
  * @handle_error:	Optional error handler if the allocation fails
  * @domain_alloc_irqs:	Optional function to override the default allocation
@@ -312,12 +311,11 @@ struct msi_domain_info;
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
  *
- * @get_hwirq, @msi_init and @msi_free are callbacks used by
- * msi_create_irq_domain() and related interfaces
+ * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
+ * irqdomain.
  *
- * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
- * are callbacks used by msi_domain_alloc_irqs() and related
- * interfaces which are based on msi_desc.
+ * @msi_check, @msi_prepare, @handle_error and @set_desc are callbacks used by
+ * msi_domain_alloc/free_irqs().
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -351,7 +349,6 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
-	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
 	int		(*handle_error)(struct irq_domain *domain,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -562,8 +562,6 @@ int __msi_domain_alloc_irqs(struct irq_d
 			ret = -ENOSPC;
 			if (ops->handle_error)
 				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
 			return ret;
 		}
 
@@ -573,9 +571,6 @@ int __msi_domain_alloc_irqs(struct irq_d
 		}
 	}
 
-	if (ops->msi_finish)
-		ops->msi_finish(&arg, 0);
-
 	can_reserve = msi_check_reservation_mode(domain, info, dev);
 
 	/*

