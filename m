Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285A32244EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jul 2020 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGQUL1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 16:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgGQUL1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 16:11:27 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB95C20704;
        Fri, 17 Jul 2020 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595016686;
        bh=tfETmY2kzcabHaWuDq17jMljgiTJ65kMRX+WppyLeX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n8AOiC/htwoUxgp0wROuMdNc2kuVDX11SvXqRzYpqVHPk/MUu+wjOYz90wYGjTK7c
         y0vhk5S5sJkHWea+JYaKnyCbiu/EOKpGSZYwYPyj6gVE9AziBLt2WLciH8R0kZznkC
         gBZ3ob6reEaJZY+/wQkOlukoCqtCvoF72P8q8WEE=
Date:   Fri, 17 Jul 2020 15:11:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH v2] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Message-ID: <20200717201124.GA767548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717025528.3093-1-weh@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 17, 2020 at 10:55:28AM +0800, Wei Hu wrote:
> Kdump could fail sometime on HyperV guest over Accerlated Network
> interface. This is because the retry in hv_pci_enter_d0() relies on
> an asynchronous host event to arrive guest before calling
> hv_send_resources_allocated(). This fixes the problem by moving retry
> to hv_pci_probe(), removing this dependence and making the calling
> sequence synchronous.

Lorenzo, if you apply this, can you fix this typo?

  s/Accerlated/Accelerated/

and maybe even

  s/HyperV/Hyper-V/
  s/This fixes the problem/Fix the problem/
  s/this dependence/this dependency/

Not sure if "relies on ... event to arrive guest" means "relies on ...
event arriving in the guest"?  Or maybe "relies on ... event arriving
before the guest calls ..."?

This would probably all make perfect sense to me if I understood more
about Hyper-V :)

> v2: Adding Fixes tag according to Michael Kelley's review comment.

There's no need to include this "v2" comment in the commit log.  I
think if you put it after a line containing only "---" (or maybe
"--"?), it will be in the email but not in the commit log.

> Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 66 ++++++++++++++---------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bf40ff09c99d..738ee30f3334 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2759,10 +2759,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	bool retry = true;
>  	int ret;
>  
> -enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2789,38 +2787,6 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>  
> -	/*
> -	 * In certain case (Kdump) the pci device of interest was
> -	 * not cleanly shut down and resource is still held on host
> -	 * side, the host could return invalid device status.
> -	 * We need to explicitly request host to release the resource
> -	 * and try to enter D0 again.
> -	 */
> -	if (comp_pkt.completion_status < 0 && retry) {
> -		retry = false;
> -
> -		dev_err(&hdev->device, "Retrying D0 Entry\n");
> -
> -		/*
> -		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> -		 * to free up resources of its child devices.
> -		 * In the kdump kernel we need to set the
> -		 * wslot_res_allocated to 255 so it scans all child
> -		 * devices to release resources allocated in the
> -		 * normal kernel before panic happened.
> -		 */
> -		hbus->wslot_res_allocated = 255;
> -
> -		ret = hv_pci_bus_exit(hdev, true);
> -
> -		if (ret == 0) {
> -			kfree(pkt);
> -			goto enter_d0_retry;
> -		}
> -		dev_err(&hdev->device,
> -			"Retrying D0 failed with ret %d\n", ret);
> -	}
> -
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3058,6 +3024,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	u16 dom_req, dom;
>  	char *name;
> +	bool enter_d0_retry = true;
>  	int ret;
>  
>  	/*
> @@ -3178,11 +3145,42 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (ret)
>  		goto free_fwnode;
>  
> +retry:
>  	ret = hv_pci_query_relations(hdev);
>  	if (ret)
>  		goto free_irq_domain;
>  
>  	ret = hv_pci_enter_d0(hdev);
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 * The retry should start from hv_pci_query_relations() call.
> +	 */
> +	if (ret == -EPROTO && enter_d0_retry) {
> +		enter_d0_retry = false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resources_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated = 255;
> +		ret = hv_pci_bus_exit(hdev, true);
> +
> +		if (ret == 0)
> +			goto retry;
> +
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
>  	if (ret)
>  		goto free_irq_domain;
>  
> -- 
> 2.20.1
> 
