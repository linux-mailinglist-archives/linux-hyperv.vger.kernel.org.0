Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA294A83F8
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiBCMmx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:42:53 -0500
Received: from foss.arm.com ([217.140.110.172]:44652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbiBCMmx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:42:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8875711D4;
        Thu,  3 Feb 2022 04:42:52 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DAF63F774;
        Thu,  3 Feb 2022 04:42:51 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:42:46 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     longli@linuxonhyperv.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com,
        Long Li <longli@microsoft.com>
Subject: Re: [Patch v4] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Message-ID: <20220203124246.GA25305@lpieralisi>
References: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 26, 2022 at 05:43:34PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
> driver should only set an online NUMA node on the device. This can happen
> during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.
> 
> This patch also fixes the case where kernel is booting with "numa=off".
> 
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> Change log:
> v2: use numa_map_to_online_node() to assign a node to device (suggested by
> Michael Kelly <mikelley@microsoft.com>)
> v3: add "Fixes" and check for num_possible_nodes()
> v4: fix commit message format
> 
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Feel free to pick it up:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 20ea2ee330b8..ae0bc2fee4ca 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2155,8 +2155,17 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
>  		if (!hv_dev)
>  			continue;
>  
> -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> +		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> +			/*
> +			 * The kernel may boot with some NUMA nodes offline
> +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> +			 * "numa=off". In those cases, adjust the host provided
> +			 * NUMA node to a valid NUMA node used by the kernel.
> +			 */
> +			set_dev_node(&dev->dev,
> +				     numa_map_to_online_node(
> +					     hv_dev->desc.virtual_numa_node));
>  
>  		put_pcichild(hv_dev);
>  	}
> -- 
> 2.25.1
> 
