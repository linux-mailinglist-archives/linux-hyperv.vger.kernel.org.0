Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A85878CC
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Aug 2022 10:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiHBIOd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Aug 2022 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHBIOc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Aug 2022 04:14:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB0E540BDE;
        Tue,  2 Aug 2022 01:14:31 -0700 (PDT)
Received: from [192.168.1.87] (unknown [122.171.18.126])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0FF1120FEB3D;
        Tue,  2 Aug 2022 01:14:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF1120FEB3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659428071;
        bh=e9jMP+l1EBs7edkrR5yZ/P6HawFIJg7Wsf/tP8c1hH0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=sXcg7ueT90KrfILlIRM1HvHe29gKYoqSsyMQQeLTWwjG/2yXmE0aR2uVg0MLLbabt
         bFLzzVExKfHih7h+hz22WEJriYgk9tSIr380HorDd/SRNsmSyQsKfrYRToXiqRvEob
         v/XBrdiMYQPyzKMTC6bhLKTBeUWwNFvx6GIrQrRE=
Message-ID: <33983fa2-c9a8-1ac1-2f75-8360a077cfc2@linux.microsoft.com>
Date:   Tue, 2 Aug 2022 13:44:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 25-07-2022 15:07, Saurabh Sengar wrote:
> In the vmbus_on_event loop, 2 jiffies timer will not serve the purpose if
> callback_fn takes longer. For effective use move this check inside of
> callback functions where needed. Out of all the VMbus drivers using
> vmbus_on_event, only storvsc has a high packet volume, thus add this limit
> only in storvsc callback for now.
> There is no apparent benefit of loop itself because this tasklet will be
> scheduled anyway again if there are packets left in ring buffer. This
> patch removes this unnecessary loop as well.
> 

In my understanding the loop was for optimizing the host to guest signaling for batched channels.
And the loop ensures that we process all the posted messages from the host before returning from the respective callbacks.

Am I missing something here.

> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/connection.c    | 33 ++++++++++++++-------------------
>  drivers/scsi/storvsc_drv.c |  9 +++++++++
>  2 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index eca7afd..9dc27e5 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -431,34 +431,29 @@ struct vmbus_channel *relid2channel(u32 relid)
>  void vmbus_on_event(unsigned long data)
>  {
>  	struct vmbus_channel *channel = (void *) data;
> -	unsigned long time_limit = jiffies + 2;
> +	void (*callback_fn)(void *context);
>  
>  	trace_vmbus_on_event(channel);
>  
>  	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> -	do {
> -		void (*callback_fn)(void *);
>  
> -		/* A channel once created is persistent even when
> -		 * there is no driver handling the device. An
> -		 * unloading driver sets the onchannel_callback to NULL.
> -		 */
> -		callback_fn = READ_ONCE(channel->onchannel_callback);
> -		if (unlikely(callback_fn == NULL))
> -			return;
> -
> -		(*callback_fn)(channel->channel_callback_context);
> +	/* A channel once created is persistent even when
> +	 * there is no driver handling the device. An
> +	 * unloading driver sets the onchannel_callback to NULL.
> +	 */
> +	callback_fn = READ_ONCE(channel->onchannel_callback);
> +	if (unlikely(!callback_fn))
> +		return;
>  
> -		if (channel->callback_mode != HV_CALL_BATCHED)
> -			return;
> +	(*callback_fn)(channel->channel_callback_context);
>  
> -		if (likely(hv_end_read(&channel->inbound) == 0))
> -			return;
> +	if (channel->callback_mode != HV_CALL_BATCHED)
> +		return;
>  
> -		hv_begin_read(&channel->inbound);
> -	} while (likely(time_before(jiffies, time_limit)));
> +	if (likely(hv_end_read(&channel->inbound) == 0))
> +		return;
>  
> -	/* The time limit (2 jiffies) has been reached */
> +	hv_begin_read(&channel->inbound);
>  	tasklet_schedule(&channel->callback_event);
>  }
>  
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fe000da..c457e6b 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -60,6 +60,9 @@
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
>  
> +/* channel callback timeout in ms */
> +#define CALLBACK_TIMEOUT               2
> +
>  /*  Packet structure describing virtual storage requests. */
>  enum vstor_packet_operation {
>  	VSTOR_OPERATION_COMPLETE_IO		= 1,
> @@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *context)
>  	struct hv_device *device;
>  	struct storvsc_device *stor_device;
>  	struct Scsi_Host *shost;
> +	unsigned long time_limit = jiffies + msecs_to_jiffies(CALLBACK_TIMEOUT);
>  
>  	if (channel->primary_channel != NULL)
>  		device = channel->primary_channel->device_obj;
> @@ -1224,6 +1228,11 @@ static void storvsc_on_channel_callback(void *context)
>  		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
>  			sizeof(enum vstor_packet_operation);
>  
> +		if (unlikely(time_after(jiffies, time_limit))) {
> +			hv_pkt_iter_close(channel);
> +			return;
> +		}
> +
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
>  				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",

Regards,

~Praveen.
