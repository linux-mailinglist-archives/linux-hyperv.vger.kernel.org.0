Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6B16A5AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2020 13:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBXMFB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Feb 2020 07:05:01 -0500
Received: from foss.arm.com ([217.140.110.172]:36086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgBXMFB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Feb 2020 07:05:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E8F930E;
        Mon, 24 Feb 2020 04:05:00 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D313F534;
        Mon, 24 Feb 2020 04:04:59 -0800 (PST)
Date:   Mon, 24 Feb 2020 12:04:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH v2 1/2] PCI: hv: Remove unnecessary type casting from
 kzalloc
Message-ID: <20200224120456.GC11120@e121166-lin.cambridge.arm.com>
References: <1582351197-12303-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582351197-12303-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 21, 2020 at 09:59:56PM -0800, Dexuan Cui wrote:
> In C, there is no need to cast a void * to any other pointer type.
> 
> Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")

This patch fixes nothing, anyway, that's a leftover that I removed.

Applied the series to pci/hv for v5.7.

Thanks,
Lorenzo

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> Change in v2: this was part of v1.
> 
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9977abff92fc..0fe0283368d2 100644
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
> -- 
> 2.19.1
> 
