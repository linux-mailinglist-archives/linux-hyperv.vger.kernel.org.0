Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF013DF4FB
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 20:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhHCSvE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 14:51:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35834 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhHCSvC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 14:51:02 -0400
Received: from [192.168.1.115] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5C7C208AB1E;
        Tue,  3 Aug 2021 11:50:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5C7C208AB1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628016651;
        bh=yrbpSB1otFwR1Tu1Csab8DOioMdyKobhXI9/Ft52GG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K4DGdAtk7yYMYs9z4xVcn10z4CVCrOraaCr75QTgoV4kqbgxkL71xW/EllD9G5cVD
         lW/HnybP6aDsZtXAxoQqSe21bWz6x7yYVV0km0Odz69sqgz2qhnpXXYHGtSU1K5m5e
         TPlyfD8ROLWzPNL/MBHwwYT+Lw6cv0iM2XWyOsVs=
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in
 PV-IOMMU
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 00:20:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-7-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 09-07-2021 17:13, Wei Liu wrote:
> Some devices may have been claimed by the hypervisor already. One such
> example is a user can assign a NIC for debugging purpose.
> 
> Ideally Linux should be able to tell retrieve that information, but
> there is no way to do that yet. And designing that new mechanism is
> going to take time.
> 
> Provide a command line option for skipping devices. This is a stopgap
> solution, so it is intentionally undocumented. Hopefully we can retire
> it in the future.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 043dcff06511..353da5036387 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>  
>  #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
>  
> +/* The IOMMU will not claim these PCI devices. */
> +static char *pci_devs_to_skip;
> +static int __init mshv_iommu_setup_skip(char *str) {
> +	pci_devs_to_skip = str;
> +
> +	return 0;
> +}
> +/* mshv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("mshv_iommu_skip=", mshv_iommu_setup_skip);
> +
>  /* DMA remapping support */
>  struct hv_iommu_domain {
>  	struct iommu_domain domain;
> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>  	if (!dev_is_pci(dev))
>  		return ERR_PTR(-ENODEV);
>  
> +	/*
> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> +	 * temporary solution until we figure out a way to extract information
> +	 * from the hypervisor what devices it is already using.
> +	 */
> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> +		int pos = 0;
> +		int parsed;
> +		int segment, bus, slot, func;
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		do {
> +			parsed = 0;
> +
> +			sscanf(pci_devs_to_skip + pos,
> +				" (%x:%x:%x.%x) %n",
> +				&segment, &bus, &slot, &func, &parsed);
> +
> +			if (parsed <= 0)
> +				break;
> +
> +			if (pci_domain_nr(pdev->bus) == segment &&
> +				pdev->bus->number == bus &&
> +				PCI_SLOT(pdev->devfn) == slot &&
> +				PCI_FUNC(pdev->devfn) == func)
> +			{
> +				dev_info(dev, "skipped by MSHV IOMMU\n");
> +				return ERR_PTR(-ENODEV);
> +			}
> +
> +			pos += parsed;
> +
> +		} while (pci_devs_to_skip[pos]);

Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip) and also a valid memory ?
I would recommend to have a check of size as well before accessing the array content, just to be safer accessing any memory.

> +	}
> +
>  	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
>  	if (!vdev)
>  		return ERR_PTR(-ENOMEM);
> 

Regards,

~Praveen.
