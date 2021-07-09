Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9303C23A7
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGIMtK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 08:49:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhGIMtK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 08:49:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C9FED1;
        Fri,  9 Jul 2021 05:46:26 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C00C3F66F;
        Fri,  9 Jul 2021 05:46:24 -0700 (PDT)
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in
 PV-IOMMU
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        pasha.tatashin@soleen.com, kumarpraveen@linux.microsoft.com,
        Will Deacon <will@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        Vineeth Pillai <viremana@linux.microsoft.com>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
Date:   Fri, 9 Jul 2021 13:46:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-7-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-07-09 12:43, Wei Liu wrote:
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

Huh? If the host is using a device, why the heck is it exposing any 
knowledge of that device to the guest at all, let alone allowing the 
guest to do anything that could affect its operation!?

Robin.

> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 043dcff06511..353da5036387 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>   
>   #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
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
>   /* DMA remapping support */
>   struct hv_iommu_domain {
>   	struct iommu_domain domain;
> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>   	if (!dev_is_pci(dev))
>   		return ERR_PTR(-ENODEV);
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
> +	}
> +
>   	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
>   	if (!vdev)
>   		return ERR_PTR(-ENOMEM);
> 
