Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE2168079
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2020 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBUOkI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Feb 2020 09:40:08 -0500
Received: from foss.arm.com ([217.140.110.172]:40806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgBUOkH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Feb 2020 09:40:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153A01FB;
        Fri, 21 Feb 2020 06:40:07 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9988D3F703;
        Fri, 21 Feb 2020 06:40:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:40:03 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error
 handling path
Message-ID: <20200221144003.GD15440@e121166-lin.cambridge.arm.com>
References: <1578350351-129783-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578350351-129783-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 06, 2020 at 02:39:11PM -0800, Dexuan Cui wrote:
> Now that we use kzalloc() to allocate the hbus buffer, we should use
> kfree() in the error path as well.
> 
> Also remove the type casting, since it's unnecessary in C.

Two unrelated logical changes -> two patches please, I know it is
tempting but it is important to split logical changes into separate
patches.

Thanks,
Lorenzo

> Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Sorry for missing the error handling path.
> 
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9977abff92fc..15011a349520 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2922,7 +2922,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
>  	 * kmemleak to track and scan the hbus buffer.
>  	 */
> -	hbus = (struct hv_pcibus_device *)kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
>  	hbus->state = hv_pcibus_init;
> @@ -3058,7 +3058,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  free_dom:
>  	hv_put_dom_num(hbus->sysdata.domain);
>  free_bus:
> -	free_page((unsigned long)hbus);
> +	kfree(hbus);
>  	return ret;
>  }
>  
> -- 
> 2.19.1
> 
