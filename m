Return-Path: <linux-hyperv+bounces-4335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB6A599C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EAB3AC66C
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154822F381;
	Mon, 10 Mar 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K618IVTM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0522DF8F;
	Mon, 10 Mar 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619887; cv=none; b=Si9n0iQY8q5inRQhSmBvSDSXb47Fr9ehbcI79zj3EmbyViiYVdMeNRB0W11dNw7TPPkkiQbC0/uluoRd2XJU2FCUPxVeGf6SzFdcnd6iALcB0I5zWS4+Ix8y1bM2H1RMyjkomeUq0tb3D9jwj0ROMPUV31Ri9J1w9FAp+zC9bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619887; c=relaxed/simple;
	bh=cCr6swPrHejV21H7pFXmqC8XKvmp4WhdXKPELwIzMOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUfzE1ueZ9xcWERay9TdbYh+ml5cyCV085OVf6TLk2smuhf+Ccqp6fHiQWE7EQX3yo2aLZwVlPPaRkzNQNJngMCVg23B2Zh0zvSaeifb6PeWihaVEBx0i2CFLronVEd5/98eYrWEV2r0Ap/4ZsdIeic4TNNgmlHhjMmyupr2WY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K618IVTM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619886; x=1773155886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cCr6swPrHejV21H7pFXmqC8XKvmp4WhdXKPELwIzMOM=;
  b=K618IVTMZyGOO4KLiKRzfSZCJrrG980YnJgI/wlOY+0i44cfTE0Px3m+
   2trab2k8742IAeqtETEBO9MEx5bu72h4X+51H7eNShEedxk94EZ8c689F
   w5503A+t21kgJVrxiTvgdTVCFe153e1056NOsUTMv70jSrk+Y+KXmLP/7
   f/gkLL/lsvvJ17B6xWK4SXvSNKXPjO5TR8OVw5Gx+Gup1bhj8vycLzE5l
   rkVJOqePHPwEw4Vl3zXPR5UwzFXvVxWwedBiRfJJSCxzueXYzB+hVXZy0
   LE3SJsT9AaVJlWGo5IFKLX+cJ4wxT/H3COf8t47qNchCtu8Yqz8vI6GcC
   w==;
X-CSE-ConnectionGUID: UJCdwBgfSee/DLy5EnCIYA==
X-CSE-MsgGUID: nPHq1KpaSBqKKjYhmf2wMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42656858"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42656858"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:18:05 -0700
X-CSE-ConnectionGUID: SMzo5GZDR3iRv+uNIbIeuA==
X-CSE-MsgGUID: BmWdffciSh2Xpkpqi0attg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120539239"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:18:04 -0700
Message-ID: <1fe5dc6e-3fa9-41a0-a38e-367fa2cc9475@intel.com>
Date: Mon, 10 Mar 2025 08:18:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/10] NTB/msi: Switch MSI descriptor locking to lock
 guard()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.394142327@linutronix.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250309084110.394142327@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/9/25 1:41 AM, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: ntb@lists.linux.dev

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/msi.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> --- a/drivers/ntb/msi.c
> +++ b/drivers/ntb/msi.c
> @@ -106,10 +106,10 @@ int ntb_msi_setup_mws(struct ntb_dev *nt
>  	if (!ntb->msi)
>  		return -EINVAL;
>  
> -	msi_lock_descs(&ntb->pdev->dev);
> -	desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
> -	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
> -	msi_unlock_descs(&ntb->pdev->dev);
> +	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
> +		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
> +		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
> +	}
>  
>  	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
>  		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
> @@ -289,7 +289,7 @@ int ntbm_msi_request_threaded_irq(struct
>  	if (!ntb->msi)
>  		return -EINVAL;
>  
> -	msi_lock_descs(dev);
> +	guard(msi_descs_lock)(dev);
>  	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
>  		if (irq_has_action(entry->irq))
>  			continue;
> @@ -307,17 +307,11 @@ int ntbm_msi_request_threaded_irq(struct
>  		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
>  		if (ret) {
>  			devm_free_irq(&ntb->dev, entry->irq, dev_id);
> -			goto unlock;
> +			return ret;
>  		}
> -
> -		ret = entry->irq;
> -		goto unlock;
> +		return entry->irq;
>  	}
> -	ret = -ENODEV;
> -
> -unlock:
> -	msi_unlock_descs(dev);
> -	return ret;
> +	return -ENODEV;
>  }
>  EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
>  
> 


