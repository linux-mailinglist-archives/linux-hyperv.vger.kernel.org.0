Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4681D4970F4
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 11:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiAWKjO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 05:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiAWKjO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 05:39:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E31C06173B;
        Sun, 23 Jan 2022 02:39:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B247FB80AD2;
        Sun, 23 Jan 2022 10:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7709C340E2;
        Sun, 23 Jan 2022 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642934351;
        bh=giP7T5U/6HYH5M/XC35TE5YxsEHR+HxDlnOPEOIqim0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urUGGLmO5uELWysOnb3o6Y75gKJ7ULy6pYepr3om0HCvm9e+Z27gk1vtOXbElRb7U
         9QCTTVKBnANxbuc1K5aW9KaLZ/nPqPudD3juLhn5Ro3JAiUzpXrP6sOinW+OYAVoxH
         wfNW3/QfpvL/Qq3Iguchh6mwjS30AhnzNHyDizHKgjWYl24ZPQPg9Mv65F1u9ZHslJ
         ys0ZTRra2eOD99rKgmWcmAXAxi7KEWsCAc2hE+dAajq1qQMoXdJKDqDruqiLrexI4D
         s8Cj86V91rdF+qG+KBNrJLjvTsnQN87pOhHUZRMyAKEz/Xg8CKRiVRqVwT5QwOvjFy
         DbrzYW4/Jn9Nw==
Date:   Sun, 23 Jan 2022 12:39:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com,
        Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Message-ID: <Ye0wSwQhsnk2nB8z@unreal>
References: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 19, 2022 at 11:59:06AM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
> driver should only set an online NUMA node on the device. This can happen
> during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.
> 
> This patch also fixes the case where kernel is booting with "numa=off".
> 
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> 

No blank line here, please

> Signed-off-by: Long Li <longli@microsoft.com>

Everything below needs to be under "---" marker.

Thanks

> 
> Change log:
> v2: use numa_map_to_online_node() to assign a node to device (suggested by
> Michael Kelly <mikelley@microsoft.com>)
> 
> v3: add "Fixes" and check for num_possible_nodes()
> ---
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6c9efeefae1b..b5276e81bb44 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2129,8 +2129,17 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
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
