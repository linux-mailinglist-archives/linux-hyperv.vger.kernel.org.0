Return-Path: <linux-hyperv+bounces-4489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0245A5FEA0
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6E3BB318
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029301E573B;
	Thu, 13 Mar 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFZ1UBSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaZ5+jSl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356615DBC1;
	Thu, 13 Mar 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888516; cv=none; b=AOVUsziZpvXmp0D9MrXWXPX2cM40Dln6vf/ycTmC4xXMLkPVfrYbPqohkgrfA8a56ojSERvTwML9u9L4lxsoJQs1dm+MrcglcwUGdQPWvGgIpTAY27aPIw4d2C/N5I4tlDGEL6uzniQ5zEcy7YF0/K7UgmJD4KuSQtQeAQzmEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888516; c=relaxed/simple;
	bh=Tt71LYU6EhXq+PF34rquse8y+1HkrL6YTObHYDTEgC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7BiZ3nLGQkcK1PPOPZgGbhh70fZUK5S0NwiZ/xzK9Q58bByvXyFegdhCJL6yNOV0rMwBONYzsPo/X8oppKcIxA4DbB6vfP1eqtj6zKjyeJodeF+KrSwghw7G4zLXBjfKDvAQiIH4gNHKV24bMzKynPUvxNSJ31uGr0i6HrIKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFZ1UBSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DaZ5+jSl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741888513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PI1SXUEUlOflpG5mqedjH0tAMTUnOBBlzLm30n5Uuc=;
	b=uFZ1UBSPIOZgTqTqDPp+hhu/m7GcOkIt1v3H07rmD4Ul7VL35J6jWDvJIA+deMFrBrOnbr
	8ynwe7rivWoT25DDOIcKFqTlsUHbHlBmYIb1TLN91juJY9FmyXTCXZr5OEP4FJWRQJRcrF
	OoZQaJr9kQvLeLhWezSO18uv67r3WIgHGxe4u4mh4hNj0o3F3bh+1vYNFz22NcT7tkTOIl
	og+qd1C2OI0B6igXtHcKG2JJlrAQdE2Arpkbd1UkgQDpUVePa9LPRdlZs+NCkvxTQmUet3
	UhOf8ztb+kp+188qw6+Z+WIKy9JFx+dvkdWZgF0blzeIBmRdkZxk5ukei3qmuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741888513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PI1SXUEUlOflpG5mqedjH0tAMTUnOBBlzLm30n5Uuc=;
	b=DaZ5+jSlfrg02yOuP/NlnEIu8fr+/VfyCADOXZFaNyu2YS2F1MFQ+giIy2PvmK5hrryHIc
	SNt0bHYWB8QiwtCw==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Nishanth Menon <nm@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang
 <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe
 <allenbh@gmail.com>, ntb@lists.linux.dev, Michael Kelley
 <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 05/10] PCI/MSI: Switch to MSI descriptor locking to
 guard()
In-Reply-To: <20250313155015.000037f5@huawei.com>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.695027112@linutronix.de>
 <20250313155015.000037f5@huawei.com>
Date: Thu, 13 Mar 2025 18:55:12 +0100
Message-ID: <87ldt86cjj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 13 2025 at 15:50, Jonathan Cameron wrote:
>> +	guard(msi_descs_lock)(&dev->dev);
>> +	int ret = __msix_setup_interrupts(dev, entries, nvec, masks);
>> +	if (ret)
>> +		pci_free_msi_irqs(dev);
>
> It's not immediately obvious what this is undoing (i.e. where the alloc
> is).  I think it is at least mostly the pci_msi_setup_msi_irqs in
> __msix_setup_interrupts

It's a universal cleanup for all possible error cases.

> Why not handle the error in __msix_setup_interrupts and make that function
> side effect free.  Does require gotos but in a function that isn't
> doing any cleanup magic so should be fine.

I had the gotos first and then hated them. But you are right, it's better
to have them than having the magic clean up at the call site.

I'll fold the delta patch below.

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -671,19 +671,23 @@ static int __msix_setup_interrupts(struc
 	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 
 	if (ret)
-		return ret;
+		goto fail;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
 	if (ret)
-		return ret;
+		goto fail;
 
 	msix_update_entries(dev, entries);
 	return 0;
+
+fail:
+	pci_free_msi_irqs(dev);
+	return ret;
 }
 
 static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
@@ -693,10 +697,7 @@ static int msix_setup_interrupts(struct
 		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 
 	guard(msi_descs_lock)(&dev->dev);
-	int ret = __msix_setup_interrupts(dev, entries, nvec, masks);
-	if (ret)
-		pci_free_msi_irqs(dev);
-	return ret;
+	return __msix_setup_interrupts(dev, entries, nvec, masks);
 }
 
 /**

