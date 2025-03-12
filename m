Return-Path: <linux-hyperv+bounces-4428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487AA5E354
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F53A38DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013701D63C4;
	Wed, 12 Mar 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkfrrJSp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F8635C;
	Wed, 12 Mar 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802427; cv=none; b=JV3cdTXI80EZZfxudVg9FB2ciKVHp4bjmrl7S9kaqFQySIo5g3OQ15VbUJ3w3nk2XJ3gE+L8eQFMSCZtuACpbiMk1PS7Dq8kwv2kickuffJq3F8E2ZeYQk5xThl/NrCHihIEiBsvhLr6hx4PdqgHpYdUcVLwG+EhZiibD2WzHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802427; c=relaxed/simple;
	bh=oV1jKXyKCcmGjWlSIr3cbhebDw/eEAZ7VyyVaXDSRPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9mIOXL7O08Hx9/x69r4/bQeEAfc0z572k4b9AtGD4YlrKqRn45LMPX/3hYk9PIhj/TF42V7rpGqzrCHzpsMw2SVWPYpVb2J05yRw6WgEvYHxUMRzfVjETtBVg6qpXP7QksLpOACEumETvsWHDult7AFdzUJ0R86fN3cWlSQbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hkfrrJSp; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CHxlo71652549
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 12:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741802387;
	bh=1gu2hLHkw3oXjZ+lNcFWEL88KOjDXH3qbsIRgSuLXZg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hkfrrJSptdQGA2ajD0QInTrYQ0AvrhJbV/4wNXT71IyQVlLn7+gaicisEVPcNXdcj
	 UpLXeNvJ4rG688hK+jp2dIm51qMfXCLsWxzVR1jad0tn7eR0dak1KDrrLukZWm6/3Y
	 Sx0jdQ/CfwH5Fjq9k0hhO2WnFXZ4rjl6ho4NLS7g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CHxlZ9002568
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 12:59:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 12:59:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 12:59:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CHxk4p048636;
	Wed, 12 Mar 2025 12:59:46 -0500
Date: Wed, 12 Mar 2025 12:59:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Jon
 Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe
	<allenbh@gmail.com>,
        <ntb@lists.linux.dev>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>,
        Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [patch 03/10] soc: ti: ti_sci_inta_msi: Switch MSI descriptor
 locking to guard()
Message-ID: <20250312175946.mirwklpli45qsqd5@brittle>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.330984023@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250309084110.330984023@linutronix.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 09:41-20250309, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> ---
>  drivers/soc/ti/ti_sci_inta_msi.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/drivers/soc/ti/ti_sci_inta_msi.c
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -103,19 +103,15 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
>  	if (ret)
>  		return ret;
>  
> -	msi_lock_descs(dev);
> +	guard(msi_descs_lock)(dev);
>  	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
> -	if (nvec <= 0) {
> -		ret = nvec;
> -		goto unlock;
> -	}
> +	if (nvec <= 0)
> +		return nvec;
>  
>  	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
>  	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
>  	if (ret)
>  		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
> -unlock:
> -	msi_unlock_descs(dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
> 

Quick test of the series for basic NFS boot (which uses INTR/INTA MSI
for Ethernet) on TI K3 platforms against linux-next:
https://gist.github.com/nmenon/26ea6eb530de34808ab04b1958a0b28b

Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

