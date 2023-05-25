Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049EB71073E
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 May 2023 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjEYIWp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 May 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjEYIWo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 May 2023 04:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F166122;
        Thu, 25 May 2023 01:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9806F643C2;
        Thu, 25 May 2023 08:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3450C433D2;
        Thu, 25 May 2023 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685002961;
        bh=BMal3lRf0YeLMZBUF7KpBH68HoeAfjihUs5S7Jxz8Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuXj4PrzjeLpH3b2vv2KFqq7j0TaZNRq5rM3EV6Fm3N6fScUNTYLGbPD10AwafuFq
         XFC4dhD8vaz9uuQVod5TTI+1hr3pZJ4sQT6HaVkz1nKpnrJ0Xh4ugk0GoYGw8iwJkp
         5vJWFtSgiadvxTwAp8fW3C9vVSugdmEgB3YzXVtlCSgCBPfMKV6RrRUpES1sWMHJjF
         lVAUdI2H25ylx5Dm1DvQgOsym/JI7FOH0qFo5/868EeB8845XRGPevIRHOP6kIiBMU
         fbxnFcaqAtmAXf14iRHeagGxuAyLibB1+WF24s5FNf0tDScxQi7VhollKncNJ/66Fl
         YgKQquQzFCBwA==
Date:   Thu, 25 May 2023 10:22:30 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bhelgaas@google.com, davem@davemloft.net, edumazet@google.com,
        haiyangz@microsoft.com, jakeo@microsoft.com, kuba@kernel.org,
        kw@linux.com, kys@microsoft.com, leon@kernel.org,
        linux-pci@vger.kernel.org, mikelley@microsoft.com,
        pabeni@redhat.com, robh@kernel.org, saeedm@nvidia.com,
        wei.liu@kernel.org, longli@microsoft.com, boqun.feng@gmail.com,
        ssengar@microsoft.com, helgaas@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        josete@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/6] Revert "PCI: hv: Fix a timing issue which causes
 kdump to fail occasionally"
Message-ID: <ZG8axpfFQArZ0Hj/@lpieralisi>
References: <20230420024037.5921-1-decui@microsoft.com>
 <20230420024037.5921-5-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420024037.5921-5-decui@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 19, 2023 at 07:40:35PM -0700, Dexuan Cui wrote:
> This reverts commit d6af2ed29c7c1c311b96dac989dcb991e90ee195.
> 
> The statement "the hv_pci_bus_exit() call releases structures of all its
> child devices" in commit d6af2ed29c7c is not true: in the path
> hv_pci_probe() -> hv_pci_enter_d0() -> hv_pci_bus_exit(hdev, true): the
> parameter "keep_devs" is true, so hv_pci_bus_exit() does *not* release the
> child "struct hv_pci_dev *hpdev" that is created earlier in
> pci_devices_present_work() -> new_pcichild_device().
> 
> The commit d6af2ed29c7c was originally made in July 2020 for RHEL 7.7,
> where the old version of hv_pci_bus_exit() was used; when the commit was
> rebased and merged into the upstream, people didn't notice that it's
> not really necessary. The commit itself doesn't cause any issue, but it
> makes hv_pci_probe() more complicated. Revert it to facilitate some
> upcoming changes to hv_pci_probe().

If d6af2ed29c7c does not cause any issue this is not a fix and should be
merged only with subsequent changes.

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Wei Hu <weh@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> 
> v2:
>   No change to the patch body.
>   Added Wei Hu's Acked-by.
>   Added Cc:stable
> 
> v3:
>   Added Michael's Reviewed-by.
> 
>  drivers/pci/controller/pci-hyperv.c | 71 ++++++++++++++---------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 46df6d093d683..48feab095a144 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3225,8 +3225,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> +	bool retry = true;
>  	int ret;
>  
> +enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -3253,6 +3255,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>  
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 */
> +	if (comp_pkt.completion_status < 0 && retry) {
> +		retry = false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated = 255;
> +
> +		ret = hv_pci_bus_exit(hdev, true);
> +
> +		if (ret == 0) {
> +			kfree(pkt);
> +			goto enter_d0_retry;
> +		}
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
> +
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3493,7 +3527,6 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	u16 dom_req, dom;
>  	char *name;
> -	bool enter_d0_retry = true;
>  	int ret;
>  
>  	/*
> @@ -3633,47 +3666,11 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (ret)
>  		goto free_fwnode;
>  
> -retry:
>  	ret = hv_pci_query_relations(hdev);
>  	if (ret)
>  		goto free_irq_domain;
>  
>  	ret = hv_pci_enter_d0(hdev);
> -	/*
> -	 * In certain case (Kdump) the pci device of interest was
> -	 * not cleanly shut down and resource is still held on host
> -	 * side, the host could return invalid device status.
> -	 * We need to explicitly request host to release the resource
> -	 * and try to enter D0 again.
> -	 * Since the hv_pci_bus_exit() call releases structures
> -	 * of all its child devices, we need to start the retry from
> -	 * hv_pci_query_relations() call, requesting host to send
> -	 * the synchronous child device relations message before this
> -	 * information is needed in hv_send_resources_allocated()
> -	 * call later.
> -	 */
> -	if (ret == -EPROTO && enter_d0_retry) {
> -		enter_d0_retry = false;
> -
> -		dev_err(&hdev->device, "Retrying D0 Entry\n");
> -
> -		/*
> -		 * Hv_pci_bus_exit() calls hv_send_resources_released()
> -		 * to free up resources of its child devices.
> -		 * In the kdump kernel we need to set the
> -		 * wslot_res_allocated to 255 so it scans all child
> -		 * devices to release resources allocated in the
> -		 * normal kernel before panic happened.
> -		 */
> -		hbus->wslot_res_allocated = 255;
> -		ret = hv_pci_bus_exit(hdev, true);
> -
> -		if (ret == 0)
> -			goto retry;
> -
> -		dev_err(&hdev->device,
> -			"Retrying D0 failed with ret %d\n", ret);
> -	}
>  	if (ret)
>  		goto free_irq_domain;
>  
> -- 
> 2.25.1
> 
