Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185C568331
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiGFJPC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiGFJOu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 05:14:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 614BDC00;
        Wed,  6 Jul 2022 02:14:50 -0700 (PDT)
Received: from [10.94.128.140] (unknown [167.220.238.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2CB620DDCBC;
        Wed,  6 Jul 2022 02:14:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2CB620DDCBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657098889;
        bh=/kmtOQO+PI9dGRrLXt9M5TSGdKEbx0frgn67z9zfgr8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=HGJ1opaUv5uH9uY7dmi/NsgFOyMaBoc1GcIsQnBDKITSXUK4BtGO0d0JF+rgA94S7
         JzbOIJOi6WMMWUCAWLDIDQofInTzD3cAuE3Jy15i9InbBtYX8o17fN0VbUtRSzBBgg
         jPnQeelE76qSR3NCcTMke3uQLtpHtyyFPU8XwRx0=
Message-ID: <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
Date:   Wed, 6 Jul 2022 14:44:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: storvsc: Prevent running tasklet for long
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05-07-2022 21:02, Saurabh Sengar wrote:
> There can be scenarios where packets in ring buffer are continuously
> getting queued from upper layer and dequeued from storvsc interrupt
> handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
> executing as a tasklet) for a long duration. Theoretically its possible
> that this loop executes forever. Add a condition to limit execution of
> this tasklet for finite amount of time to avoid such hazardous scenarios.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fe000da..0c428cb 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -60,6 +60,9 @@
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
>  
> +/* channel callback timeout in ms */
> +#define CALLBACK_TIMEOUT		5

If I may, it would be good if we have the CALLBACK_TIMEOUT configurable based upon user's requirement with default value to '5'.
I assume, this value '5' fits best to the use-case which we are trying to resolve here. Thanks.

> +
>  /*  Packet structure describing virtual storage requests. */
>  enum vstor_packet_operation {
>  	VSTOR_OPERATION_COMPLETE_IO		= 1,
> @@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *context)
>  	struct hv_device *device;
>  	struct storvsc_device *stor_device;
>  	struct Scsi_Host *shost;
> +	unsigned long expire = jiffies + msecs_to_jiffies(CALLBACK_TIMEOUT);
>  
>  	if (channel->primary_channel != NULL)
>  		device = channel->primary_channel->device_obj;
> @@ -1224,6 +1228,9 @@ static void storvsc_on_channel_callback(void *context)
>  		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
>  			sizeof(enum vstor_packet_operation);
>  
> +		if (time_after(jiffies, expire))
> +			break;
> +
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
>  				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",

Regards,

~Praveen.
