Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249894C9896
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 23:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiCAW61 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 17:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCAW60 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 17:58:26 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7373463C9;
        Tue,  1 Mar 2022 14:57:43 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so2184109wmb.1;
        Tue, 01 Mar 2022 14:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JpAXOTURWqHul9DmLjuZI2b96sOIIpns+4hIROH1Uz4=;
        b=KDFsTIJfRfqMmFBKv9ARC4wtvWSPW1eg5xo9zPgCCmuQFDcR9Xe8w55sVirZYegyZJ
         riKYQA27bYzSUJ7Y2g93ZJbE3LJLfzOQwkxH7KQx93KBTbZl3KVjF9muzGAxIZZgZCv2
         pSGBxwIEUvTEzMB1rOJFPZNByPzneKILBYb0+idg09eUkiwGWC0BzHez1UYImyKKf0bS
         Ygbd3eSzPI8kgE53ns2Cr0EQ3abB5DanMCJ3VUwJp7xy5+wnKxT6S1gJ+sxHoSS7mbG+
         LooTZOxBTNtwUx1W0xIXBDAfrXwwXKJaYflb/cQ6FLogyVu15jZS0jTryyark7VuRnzT
         6j2A==
X-Gm-Message-State: AOAM5313+nO8cFj7DHTW2qps2Gg75hfi/ia5Pr2vD/ohkTKxKVOtiizP
        dn2FCPZHr6djqC90PqLwgnM=
X-Google-Smtp-Source: ABdhPJyt6LuvSvDaLczFggZ6xS0goostNIyZjV4qyzKbtpncLrymUmgXlJnYODk49vzoqLLX37L2ag==
X-Received: by 2002:a05:600c:384b:b0:381:10bc:9e43 with SMTP id s11-20020a05600c384b00b0038110bc9e43mr13840234wmr.181.1646175462041;
        Tue, 01 Mar 2022 14:57:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k15-20020adff28f000000b001f018230b86sm3064767wro.44.2022.03.01.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:57:41 -0800 (PST)
Date:   Tue, 1 Mar 2022 22:57:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 03/30] drivers: hv: dxgkrnl: Add VM bus message
 support, initialize VM bus channels.
Message-ID: <20220301225740.ued3v26oez5lcuqf@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <fde2024f8cd2d2ca2ed9a461298b7914c78226e6.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde2024f8cd2d2ca2ed9a461298b7914c78226e6.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The subject line is too long. Also, no period at the end please.

You can write it as:

drivers: hv: dxgkrnl: Add VMBus message support and initialize channels

On Tue, Mar 01, 2022 at 11:45:50AM -0800, Iouri Tarassov wrote:
[...]
> +
> +struct dxgvmbusmsgres {
> +/* Points to the allocated buffer */
> +	struct dxgvmb_ext_header	*hdr;
> +/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
> +	void				*msg;
> +/* The vm bus channel, used to pass the message to the host */
> +	struct dxgvmbuschannel		*channel;
> +/* Message size in bytes including the header, the payload and the result */
> +	u32				size;
> +/* Result buffer size in bytes */
> +	u32				res_size;
> +/* Points to the result within the allocated buffer */
> +	void				*res;

Please align the comments with their fields.

> +};
> +
[...]
> +static void process_inband_packet(struct dxgvmbuschannel *channel,
> +				  struct vmpacket_descriptor *desc)
> +{
> +	u32 packet_length = hv_pkt_datalen(desc);
> +	struct dxgkvmb_command_host_to_vm *packet;
> +
> +	if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
> +		pr_err("Invalid global packet");
> +	} else {
> +		packet = hv_pkt_data(desc);
> +		pr_debug("global packet %d",
> +				packet->command_type);

Unnecessary line wrap.

> +		switch (packet->command_type) {
> +		case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
> +		case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
> +			break;
> +		case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
> +			break;
> +		default:
> +			pr_err("unexpected host message %d",
> +					packet->command_type);
> +		}
> +	}
> +}
> +
[...]
> +
> +/* Receive callback for messages from the host */
> +void dxgvmbuschannel_receive(void *ctx)
> +{
> +	struct dxgvmbuschannel *channel = ctx;
> +	struct vmpacket_descriptor *desc;
> +	u32 packet_length = 0;
> +
> +	foreach_vmbus_pkt(desc, channel->channel) {
> +		packet_length = hv_pkt_datalen(desc);
> +		pr_debug("next packet (id, size, type): %llu %d %d",
> +			desc->trans_id, packet_length, desc->type);
> +		if (desc->type == VM_PKT_COMP) {
> +			process_completion_packet(channel, desc);
> +		} else {
> +			if (desc->type != VM_PKT_DATA_INBAND)
> +				pr_err("unexpected packet type");

This can potentially flood the guest if the backend is misbehaving.
We've seen flooding before so would definitely not want more of it.
Please consider using the ratelimit version pr_err.

The same comment goes for all other pr calls in repeatedly called paths.
I can see the value of having precise output from the pr_debug a few
lines above though.

> +			else
> +				process_inband_packet(channel, desc);
> +		}
> +	}
> +}
> +
[...]
> +int dxgvmb_send_set_iospace_region(u64 start, u64 len,
> +	struct vmbus_gpadl *shared_mem_gpadl)
> +{
> +	int ret;
> +	struct dxgkvmb_command_setiospaceregion *command;
> +	struct dxgvmbusmsg msg;
> +
> +	ret = init_message(&msg, NULL, sizeof(*command));
> +	if (ret)
> +		return ret;
> +	command = (void *)msg.msg;
> +
> +	ret = dxgglobal_acquire_channel_lock();
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	command_vm_to_host_init1(&command->hdr,
> +				 DXGK_VMBCOMMAND_SETIOSPACEREGION);
> +	command->start = start;
> +	command->length = len;
> +	if (command->shared_page_gpadl)
> +		command->shared_page_gpadl = shared_mem_gpadl->gpadl_handle;

shared_mem_gpadl should be checked to be non-null. There is at least one
call site passes 0 to it.

> +	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel, msg.hdr,
> +					    msg.size);
> +	if (ret < 0)
> +		pr_err("send_set_iospace_region failed %x", ret);
> +
> +	dxgglobal_release_channel_lock();
> +cleanup:
> +	free_message(&msg, NULL);
> +	if (ret)
> +		pr_debug("err: %s %d", __func__, ret);
> +	return ret;
> +}
> +
[...]
> +
> +
> +#define NT_SUCCESS(status)				(status.v >= 0)
> +
> +#ifndef DEBUG
> +
> +#define DXGKRNL_ASSERT(exp)
> +
> +#else
> +
> +#define DXGKRNL_ASSERT(exp)	\
> +do {				\
> +	if (!(exp)) {		\
> +		dump_stack();	\
> +		BUG_ON(true);	\
> +	}			\
> +} while (0)


You can just use BUG_ON(exp), right? BUG_ON calls panic, which already
dumps the stack when CONFIG_DEBUG_VERBOSE is set.

Thanks,
Wei.
