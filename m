Return-Path: <linux-hyperv+bounces-4483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C718AA5FA68
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 16:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1652E17AFED
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A601267F71;
	Thu, 13 Mar 2025 15:50:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEB523A;
	Thu, 13 Mar 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881023; cv=none; b=EId1+mUz7rivyWrCXMJmQcVfd+0dGdLLMssQ+eqx2EznzC9TSXRx50iLuFcL/cQDKzeM8CrAeOyoguVqoBpcZeirakLa2FcKcHZHMEjq5yh+KuABoUePMemF5AdDTSbxp5LaVbVa3R3LA+2jbREnv8MEtT1ZbEqlQpXzHs57KDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881023; c=relaxed/simple;
	bh=0e4Lg37IEBkCL1+ibNYCc8zaO1GLTw8DLiQ36F9M068=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYGDh8QREGkparpFyn1tuDsHGCnszz+ID1Q5zpIxegzxASUkyy6ypHopQMQCZLTWgLKvS5VFR8mv9EEU+5cQt9kscfSdsNimkGqSALNsz6bDXNTpINxLqzQUttgxq0rhsyLpJrFYdP8yM+8IjHsomHhToUVvRKlTG1J4zSLA/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDBhC5Z6vz6H8mQ;
	Thu, 13 Mar 2025 23:47:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC32B1400CA;
	Thu, 13 Mar 2025 23:50:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 16:50:16 +0100
Date: Thu, 13 Mar 2025 15:50:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Peter Zijlstra"
	<peterz@infradead.org>, Nishanth Menon <nm@ti.com>, Dhruva Gole
	<d-gole@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang
	<dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe
	<allenbh@gmail.com>, <ntb@lists.linux.dev>, Michael Kelley
	<mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 05/10] PCI/MSI: Switch to MSI descriptor locking to
 guard()
Message-ID: <20250313155015.000037f5@huawei.com>
In-Reply-To: <20250313130321.695027112@linutronix.de>
References: <20250313130212.450198939@linutronix.de>
	<20250313130321.695027112@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 14:03:44 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
> V2: Remove the gotos - Jonathan
Hi Thomas,


There is a bit of the original code that is carried forwards here
that superficially seemed overly complex.  However as far as I can tell
this is functionally the same as you intended.  So with that in mind
if my question isn't complete garbage, maybe a readability issue for
another day.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c



> +static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> +				 int nvec, struct irq_affinity *affd)
> +{
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> +
> +	guard(msi_descs_lock)(&dev->dev);
> +	int ret = __msix_setup_interrupts(dev, entries, nvec, masks);
> +	if (ret)
> +		pci_free_msi_irqs(dev);

It's not immediately obvious what this is undoing (i.e. where the alloc
is).  I think it is at least mostly the pci_msi_setup_msi_irqs in
__msix_setup_interrupts

Why not handle the error in __msix_setup_interrupts and make that function
side effect free.  Does require gotos but in a function that isn't
doing any cleanup magic so should be fine.

Mind you I'm not following the logic in msix_setup_interrupts()
before this series either. i.e. why doesn't msix_setup_msi_descs()
clean up after itself on failure (i.e. undo loop iterations that
weren't failures) as that at least superficially looks like it
would give more readable code.

So this is the same as current and as such the patch is fine I think.

>  	return ret;
>  }
>  



