Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD46DC317
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Apr 2023 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjDJE3B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Apr 2023 00:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJE3A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Apr 2023 00:29:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34E8F3C28;
        Sun,  9 Apr 2023 21:28:59 -0700 (PDT)
Received: from [10.156.156.87] (unknown [167.220.238.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8E266213C158;
        Sun,  9 Apr 2023 21:28:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E266213C158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681100938;
        bh=9Moh8CG8b4PgnpEyV4D2wg4ZRKVsMVbyR2eo8f0Fhhk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eXSFBfAd+xLmbZ9Hl1xU3Ls9cyUnxYiovoxiv6a/yz7eXVm8pNgyOENRUCLKYfW17
         QxUoasX99h1U5uGfnlCqlGANpUD7wk2KKsk/HBXEmFFP/5X6Rzf+jHbuvT3xY3LMGE
         fk1v1pL8Tf5xszYEbrcIShqlHyj/072QIkceLdIs=
Message-ID: <bc4e501b-53a4-0d20-3b7b-5bd4a64376cc@linux.microsoft.com>
Date:   Mon, 10 Apr 2023 09:58:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
References: <20230408213441.15472-1-decui@microsoft.com>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <20230408213441.15472-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>

On 4/9/2023 3:04 AM, Dexuan Cui wrote:
> The post_msg_page was introduced in 2014 in
> commit b29ef3546aec ("Drivers: hv: vmbus: Cleanup hv_post_message()")
>
> Commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments") introduced
> the hyperv_pcpu_input_arg in 2018, which can be used in hv_post_message().
>
> Remove post_msg_page to simplify the code a little bit.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>   drivers/hv/hv.c           | 20 +++++---------------
>   drivers/hv/hyperv_vmbus.h |  4 ----
>   2 files changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 8b0dd8e5244d7..30bf122a502ae 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -84,14 +84,15 @@ int hv_post_message(union hv_connection_id connection_id,
>   		  void *payload, size_t payload_size)
>   {
>   	struct hv_input_post_message *aligned_msg;
> -	struct hv_per_cpu_context *hv_cpu;
> +	unsigned long flags;
>   	u64 status;
>   
>   	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
>   		return -EMSGSIZE;
>   
> -	hv_cpu = get_cpu_ptr(hv_context.cpu_context);
> -	aligned_msg = hv_cpu->post_msg_page;
> +	local_irq_save(flags);
> +
> +	aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
>   	aligned_msg->connectionid = connection_id;
>   	aligned_msg->reserved = 0;
>   	aligned_msg->message_type = message_type;
> @@ -106,11 +107,7 @@ int hv_post_message(union hv_connection_id connection_id,
>   		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
>   				aligned_msg, NULL);
>   
> -	/* Preemption must remain disabled until after the hypercall
> -	 * so some other thread can't get scheduled onto this cpu and
> -	 * corrupt the per-cpu post_msg_page
> -	 */
> -	put_cpu_ptr(hv_cpu);
> +	local_irq_restore(flags);
>   
>   	return hv_result(status);
>   }
> @@ -162,12 +159,6 @@ int hv_synic_alloc(void)
>   				goto err;
>   			}
>   		}
> -
> -		hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
> -		if (hv_cpu->post_msg_page == NULL) {
> -			pr_err("Unable to allocate post msg page\n");
> -			goto err;
> -		}
>   	}
>   
>   	return 0;
> @@ -190,7 +181,6 @@ void hv_synic_free(void)
>   
>   		free_page((unsigned long)hv_cpu->synic_event_page);
>   		free_page((unsigned long)hv_cpu->synic_message_page);
> -		free_page((unsigned long)hv_cpu->post_msg_page);
>   	}
>   
>   	kfree(hv_context.hv_numa_map);
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index dc673edf053c3..d8322049ecd08 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -122,10 +122,6 @@ enum {
>   struct hv_per_cpu_context {
>   	void *synic_message_page;
>   	void *synic_event_page;
> -	/*
> -	 * buffer to post messages to the host.
> -	 */
> -	void *post_msg_page;
>   
>   	/*
>   	 * Starting with win8, we can take channel interrupts on any CPU;
