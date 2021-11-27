Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54945F9A8
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbhK0B1w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbhK0BZv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:25:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE6C0613FC;
        Fri, 26 Nov 2021 17:19:44 -0800 (PST)
Message-ID: <20211126223824.914161382@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HvFnLhSNQWkY7FyV6dqkmiDpk27hPnt+iT7sMKioVYY=;
        b=nLVAIHxU7zzvZDcgNYXA194SYdMrO6dCVMw9y6HDD/le7JD9C2QCF1wk/oqJx43iUEDnY1
        pgFSlnrN/ssoMHCXM1uIFRYGaPp1xqbZEnupYzQc1IY8qVYeNbHLiAjPWJl+M4yhP2RdYQ
        cCvlNNeLa1fK+j1OQO1an1R2IQT5f2TQuSGwBcLKRc/fbex/njb0MW28/CMYhqJTqy9tUY
        CVHodIwjaxn70G+E6gtde2Lz44MuDnM9t8twCu61Q+gLHHsjI5TqsEgLxYzGmGm3HlcIN3
        BEj3sWmPgxXgXz1yJGmpdxUJULqvf5Szc7KHc+NFChP1uqJQYAlM8cHG8IC6NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HvFnLhSNQWkY7FyV6dqkmiDpk27hPnt+iT7sMKioVYY=;
        b=1oZXQ7KMDPa4UCKNRSuXOGmdL7VQAHRxAH7SeUCdr1ZzVhtYvvJdA6oJ2iJPmpT4hzHWhx
        P5LB3i92rxk9FGCg==
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
Subject: [patch 14/22] PCI/MSI: Make msix_update_entries() smarter
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:42 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No need to walk the descriptors and check for each one whether the entries
pointer function argument is NULL. Do it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -642,8 +642,8 @@ static void msix_update_entries(struct p
 {
 	struct msi_desc *entry;
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (entries) {
+	if (entries) {
+		for_each_pci_msi_entry(entry, dev) {
 			entries->vector = entry->irq;
 			entries++;
 		}

