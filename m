Return-Path: <linux-hyperv+bounces-4339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D58A59BAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F0A1887F02
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054A230BE7;
	Mon, 10 Mar 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg06BHTG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196722D7AD;
	Mon, 10 Mar 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625550; cv=none; b=L2iup7cyF93by3VtgNliI369FdNDBUFSy06f9Tagl1t3rXsaD6/BA03nqwadxOIqEw7ml82kASg3gjHqaqn4pXQ5wmuAMm897J0afXntZPUL8GZwcXPODqKkJiv0/vO3KA788zBPcoewLTvU0/oesF4DrRGAuRli729GrtsqemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625550; c=relaxed/simple;
	bh=Ini8lQDyPC8JPG4dO+yrpQyA25GtxLXS4fazV766qdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/Kg1TsmLOOuIeqip3zuAMQ8SNfDBAfpXa/o9Qs8yaOqpujyH3ldO9B+zytM83irGMgYPrYoD0+gT4ijwdNjpFmG7fsi/nh9RlhwqfHuDfgz1mFfTAn8vWEVQEAlTgCGOEu9tGuTODW7tcv+82B8Ii1ZqLJUt1HvWO2F1hLG+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg06BHTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D61C4CEF0;
	Mon, 10 Mar 2025 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625549;
	bh=Ini8lQDyPC8JPG4dO+yrpQyA25GtxLXS4fazV766qdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mg06BHTG+uVv8Oefui2vMxpiSJ3F1CUPo8LCNY1l1/5zhHx+3I1lBgNNNJSTYIF9s
	 0xs25Dyblmlv1ZYN0PFtKgshGCKNbpdGEhXFmY4yHHMm65CBMjfMD3yvHch+rFgJqb
	 VQmghi0rFRZtY6mLe+vexgSz6KjBt6XvNOob0dXlq2q/+yJ0PSsAvO3NFq0WJy1EnD
	 J6Wq9FSAPVcizZMZfE4zCxz9+YOM+712AoZPqY4o+k0CdJDb3mqx+QAZdTI6iNeb8d
	 qHxnnfH+IgiCP89peOUwSlDEU6opuKRURVw6XCyqBjT4BAh7o6c4gSzp/yAjfHfDLX
	 kY2tj8JFSXiRA==
Date: Mon, 10 Mar 2025 16:52:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [patch 06/10] PCI: hv: Switch MSI descriptor locking to guard()
Message-ID: <Z88YzDAf-qvi7cyH@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.521468021@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309084110.521468021@linutronix.de>

On Sun, Mar 09, 2025 at 09:41:51AM +0100, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-pci@vger.kernel.org

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/pci/controller/pci-hyperv.c |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3976,24 +3976,18 @@ static int hv_pci_restore_msi_msg(struct
>  {
>  	struct irq_data *irq_data;
>  	struct msi_desc *entry;
> -	int ret = 0;
>  
>  	if (!pdev->msi_enabled && !pdev->msix_enabled)
>  		return 0;
>  
> -	msi_lock_descs(&pdev->dev);
> +	guard(msi_descs_lock)(&pdev->dev);
>  	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_data = irq_get_irq_data(entry->irq);
> -		if (WARN_ON_ONCE(!irq_data)) {
> -			ret = -EINVAL;
> -			break;
> -		}
> -
> +		if (WARN_ON_ONCE(!irq_data))
> +			return -EINVAL;
>  		hv_compose_msi_msg(irq_data, &entry->msg);
>  	}
> -	msi_unlock_descs(&pdev->dev);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> 

