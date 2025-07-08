Return-Path: <linux-hyperv+bounces-6147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656AFAFC7B2
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D78A1898855
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA926202C5C;
	Tue,  8 Jul 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d75d7SC3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468A1401B;
	Tue,  8 Jul 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968976; cv=none; b=gm6YT6vNt8ACf7CNHTcHXmyK6tZ5agC1L/66k4rDefx2vOoC1JASGWUDEJXaVRfMUnoFcq3L53Pm1yV1eqjqPMrY7CQEfZFg/gIXJNwRO1y+wnChrlGEHaZtq+byZ0XIpB5WnuTN+zq9YMuC+rehSFj5ERLxE7yp5BpuwXWfyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968976; c=relaxed/simple;
	bh=0+enkpLJ9nhpvv7Z85p+lNljzlc7wb8dzMrbV9QU5pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejMfYsH8fndfSKNHY/ASghwnZLwdGavh7MBCvgQPwAwNdnT8+pJdp/YV0jYmhDn/lhuI1raityoGbW71pkIUuq23nsEqrcuEZcbMFhNuEEOVfjMGR4AAcFcZkhlSIxV39L4xJemNb921Wrz9yF4wDYZ+F5daHIXYTdmXyvkzr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d75d7SC3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id AB0C52112219; Tue,  8 Jul 2025 03:02:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB0C52112219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751968968;
	bh=H5AsBAlN0UMRVkdoTxCMTMJtKiZ2xFr2/fWRK++rzlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d75d7SC3tk6oM5LNxxHwHJ8O4qn2VtlDdACWcDvIjfd0HcWSwbXxC/DYjSXpxXQpE
	 344OFTbgNnxFg7fi4xMMY0YA9yjxTWysg6Q2WEIfUs5Xh0AfYBcQE6uEUHySuFYfS5
	 /Mtl9B9N2bXi85B/ARw4dYg5mF+zK2tfG/e1R5vk=
Date: Tue, 8 Jul 2025 03:02:48 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>
Subject: Re: [PATCH] PCI/MSI: Initialize the prepare descriptor by default
Message-ID: <20250708100248.GA27472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250708051848.3214-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708051848.3214-1-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jul 08, 2025 at 10:48:48AM +0530, Naman Jain wrote:
> Plug the default MSI-X prepare descriptor for non-implemented ops by
> default to workaround the inability of Hyper-V vPCI module to setup
> the MSI-X descriptors properly; especially for dynamically allocated
> MSI-X.
> 
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/pci/msi/irqdomain.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 765312c92d9b..655e99b9c8cc 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -84,6 +84,8 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
>  	} else {
>  		if (ops->set_desc == NULL)
>  			ops->set_desc = pci_msi_domain_set_desc;
> +		if (ops->prepare_desc == NULL)
> +			ops->prepare_desc = pci_msix_prepare_desc;
>  	}
>  }
>  
> 
> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
> -- 
> 2.34.1
>

Hey Naman,

can you please try your tests with this patch:
https://lore.kernel.org/all/1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com/
I think this should help your use case

Regards,
Shradha. 

