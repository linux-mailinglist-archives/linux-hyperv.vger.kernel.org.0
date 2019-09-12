Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFFB0C47
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfILKIp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 06:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfILKIp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 06:08:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 960AA30044CE;
        Thu, 12 Sep 2019 10:08:44 +0000 (UTC)
Received: from [10.36.117.168] (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E038960852;
        Thu, 12 Sep 2019 10:08:42 +0000 (UTC)
Subject: Re: [PATCH] hv_balloon: Add the support of hibernation
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
Date:   Thu, 12 Sep 2019 12:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568245010-66879-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 10:08:44 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12.09.19 01:36, Dexuan Cui wrote:
> When hibernation is enabled, we must ignore the balloon up/down and
> hot-add requests from the host, if any.
> 
> Fow now, if people want to test hibernation, please blacklist hv_balloon
> or do not enable Dynamic Memory and Memory Resizing. See the comment in
> balloon_probe() for more info.
> 

Why do you even care about supporting hibernation? Can't you just pause
the VM in the hypervisor and continue to live a happy life? :)

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> 
> I request this patch should go through Sasha's tree rather than the
> other tree(s).
> 
>  drivers/hv/hv_balloon.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 34bd735..7df0f67 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -24,6 +24,8 @@
>  
>  #include <linux/hyperv.h>
>  
> +#include <asm/mshyperv.h>
> +
>  #define CREATE_TRACE_POINTS
>  #include "hv_trace_balloon.h"
>  
> @@ -457,6 +459,7 @@ struct hot_add_wrk {
>  	struct work_struct wrk;
>  };
>  
> +static bool allow_hibernation;
>  static bool hot_add = true;
>  static bool do_hot_add;
>  /*
> @@ -1053,8 +1056,12 @@ static void hot_add_req(struct work_struct *dummy)
>  	else
>  		resp.result = 0;
>  
> -	if (!do_hot_add || (resp.page_count == 0))
> -		pr_err("Memory hot add failed\n");
> +	if (!do_hot_add || resp.page_count == 0) {
> +		if (!allow_hibernation)
> +			pr_err("Memory hot add failed\n");
> +		else
> +			pr_info("Ignore hot-add request!\n");
> +	}
>  
>  	dm->state = DM_INITIALIZED;
>  	resp.hdr.trans_id = atomic_inc_return(&trans_id);
> @@ -1509,6 +1516,11 @@ static void balloon_onchannelcallback(void *context)
>  			break;
>  
>  		case DM_BALLOON_REQUEST:
> +			if (allow_hibernation) {
> +				pr_info("Ignore balloon-up request!\n");
> +				break;
> +			}
> +
>  			if (dm->state == DM_BALLOON_UP)
>  				pr_warn("Currently ballooning\n");
>  			bal_msg = (struct dm_balloon *)recv_buffer;
> @@ -1518,6 +1530,11 @@ static void balloon_onchannelcallback(void *context)
>  			break;
>  
>  		case DM_UNBALLOON_REQUEST:
> +			if (allow_hibernation) {
> +				pr_info("Ignore balloon-down request!\n");
> +				break;
> +			}
> +
>  			dm->state = DM_BALLOON_DOWN;
>  			balloon_down(dm,
>  				 (struct dm_unballoon_request *)recv_buffer);
> @@ -1623,6 +1640,11 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	cap_msg.hdr.size = sizeof(struct dm_capabilities);
>  	cap_msg.hdr.trans_id = atomic_inc_return(&trans_id);
>  
> +	/*
> +	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
> +	 * currently still requires the bits to be set, so we have to add code
> +	 * to fail the host's hot-add and balloon up/down requests, if any.
> +	 */
>  	cap_msg.caps.cap_bits.balloon = 1;
>  	cap_msg.caps.cap_bits.hot_add = 1;
>  
> @@ -1672,6 +1694,24 @@ static int balloon_probe(struct hv_device *dev,
>  {
>  	int ret;
>  
> +#if 0

I am not sure if that's a good idea. Can't you base this series on
hv_is_hibernation_supported() ?

> +	/*
> +	 * The patch to implement hv_is_hibernation_supported() is going
> +	 * through the tip tree. For now, let's hardcode allow_hibernation
> +	 * to false to keep the current behavior of hv_balloon. If people
> +	 * want to test hibernation, please blacklist hv_balloon fow now
> +	 * or do not enable Dynamid Memory and Memory Resizing.
> +	 *
> +	 * We'll remove the conditional compilation as soon as
> +	 * hv_is_hibernation_supported() is available in the mainline tree.
> +	 */
> +	allow_hibernation = hv_is_hibernation_supported();
> +#else
> +	allow_hibernation = false;
> +#endif
> +	if (allow_hibernation)
> +		hot_add = false;
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	do_hot_add = hot_add;
>  #else
> @@ -1711,6 +1751,8 @@ static int balloon_probe(struct hv_device *dev,
>  	return 0;
>  
>  probe_error:
> +	dm_device.state = DM_INIT_ERROR;
> +	dm_device.thread  = NULL;
>  	vmbus_close(dev->channel);
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
> @@ -1752,6 +1794,59 @@ static int balloon_remove(struct hv_device *dev)
>  	return 0;
>  }
>  
> +static int balloon_suspend(struct hv_device *hv_dev)
> +{
> +	struct hv_dynmem_device *dm = hv_get_drvdata(hv_dev);
> +
> +	tasklet_disable(&hv_dev->channel->callback_event);
> +
> +	cancel_work_sync(&dm->balloon_wrk.wrk);
> +	cancel_work_sync(&dm->ha_wrk.wrk);
> +
> +	if (dm->thread) {
> +		kthread_stop(dm->thread);
> +		dm->thread = NULL;
> +		vmbus_close(hv_dev->channel);
> +	}
> +
> +	tasklet_enable(&hv_dev->channel->callback_event);
> +
> +	return 0;
> +
> +}
> +
> +static int balloon_resume(struct hv_device *dev)
> +{
> +	int ret;
> +
> +	dm_device.state = DM_INITIALIZING;
> +
> +	ret = balloon_connect_vsp(dev);
> +
> +	if (ret != 0)
> +		goto out;
> +
> +	dm_device.thread =
> +		 kthread_run(dm_thread_func, &dm_device, "hv_balloon");
> +	if (IS_ERR(dm_device.thread)) {
> +		ret = PTR_ERR(dm_device.thread);
> +		dm_device.thread = NULL;
> +		goto close_channel;
> +	}
> +
> +	dm_device.state = DM_INITIALIZED;
> +	return 0;
> +close_channel:
> +	vmbus_close(dev->channel);
> +out:
> +	dm_device.state = DM_INIT_ERROR;
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	unregister_memory_notifier(&hv_memory_nb);
> +	restore_online_page_callback(&hv_online_page);
> +#endif
> +	return ret;
> +}
> +
>  static const struct hv_vmbus_device_id id_table[] = {
>  	/* Dynamic Memory Class ID */
>  	/* 525074DC-8985-46e2-8057-A307DC18A502 */
> @@ -1766,6 +1861,8 @@ static int balloon_remove(struct hv_device *dev)
>  	.id_table = id_table,
>  	.probe =  balloon_probe,
>  	.remove =  balloon_remove,
> +	.suspend = balloon_suspend,
> +	.resume = balloon_resume,
>  	.driver = {
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> 


-- 

Thanks,

David / dhildenb
