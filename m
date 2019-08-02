Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5697ED78
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbfHBHdC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 03:33:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37724 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHBHdC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 03:33:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so65327775wme.2
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Aug 2019 00:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=az1IxEpXm+/nTRc6bpZgirA2qd9wXqQdWBN/PugKfmg=;
        b=T63wDF+ocgIZjT7S+Mi+LiWNRdZeDMXWeUdforiB+QzgyMjaXeklZ1GEGrUrZ329UE
         PVyxXaUxoAvfu58Le6b46zUas2qZ7ac5lD1G4mWox5e24HmLO6w5WSRY5dq0qyQ//vHh
         AKxEgaZDvyYNYVKp5e9aq1EfospCe42J5Ts/zCvRelLuOLdgsZrE0j0Z3J8hd6ZiS9fL
         QSUju1RLiqXSm3LWOsgw8KcFmaYxbJwO6zjbAMI/sroEjELJci3gd/ESgr54I9eb72/b
         S/YDJKlB9VoEWRcIRIn2irVacDMnERfMf1rWqZDLtJjNkZUcBCWDUTXFVNubzDOCHbWR
         QANQ==
X-Gm-Message-State: APjAAAUjPiF9suKfimyx2b4/O+DDwthNHeSw27MM5MWNm+gR8OSyj2YT
        YZSdJ/B7o1X6KoYtP+ULHr1I7w==
X-Google-Smtp-Source: APXvYqzp+8DIf7b6mdG7siZa+rCZOnsy1DLUOoS9P01kip4gjk4saikQTzaNcndQu5yjBuZ1POd6zw==
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr2772941wmg.85.1564731180735;
        Fri, 02 Aug 2019 00:33:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id s15sm57975838wrw.21.2019.08.02.00.32.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:33:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Branden Bonaby <brandonbonaby94@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: hv: vmbus: Introduce latency testing
In-Reply-To: <18193677a879c402d00955c445ae7ce461b4198f.1564527684.git.brandonbonaby94@gmail.com>
References: <cover.1564527684.git.brandonbonaby94@gmail.com> <18193677a879c402d00955c445ae7ce461b4198f.1564527684.git.brandonbonaby94@gmail.com>
Date:   Fri, 02 Aug 2019 09:32:59 +0200
Message-ID: <87d0hoggyc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Branden Bonaby <brandonbonaby94@gmail.com> writes:

> Introduce user specified latency in the packet reception path.
>
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
>  drivers/hv/connection.c  |  5 +++++
>  drivers/hv/ring_buffer.c | 10 ++++++++++
>  include/linux/hyperv.h   | 14 ++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 09829e15d4a0..2a2c22f5570e 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -354,9 +354,14 @@ void vmbus_on_event(unsigned long data)
>  {
>  	struct vmbus_channel *channel = (void *) data;
>  	unsigned long time_limit = jiffies + 2;
> +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> +						channel :
> +						channel->primary_channel;
>  
>  	trace_vmbus_on_event(channel);
>  
> +	if (unlikely(test_channel->fuzz_testing_buffer_delay > 0))
> +		udelay(test_channel->fuzz_testing_buffer_delay);
>  	do {
>  		void (*callback_fn)(void *);
>  
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 9a03b163cbbd..d7627c9023d6 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -395,7 +395,12 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
>  {
>  	struct hv_ring_buffer_info *rbi = &channel->inbound;
>  	struct vmpacket_descriptor *desc;
> +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> +						channel :
> +						channel->primary_channel;
>  
> +	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
> +		udelay(test_channel->fuzz_testing_message_delay);
>  	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
>  		return NULL;
>  
> @@ -420,7 +425,12 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
>  	struct hv_ring_buffer_info *rbi = &channel->inbound;
>  	u32 packetlen = desc->len8 << 3;
>  	u32 dsize = rbi->ring_datasize;
> +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> +						channel :
> +						channel->primary_channel;

This pattern is repeated 3 times so a define is justified. I would also
reversed the logic:

   test_channel = channel->primary_channel ? channel->primary_channel : channel;

>  
> +	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
> +		udelay(test_channel->fuzz_testing_message_delay);

unlikely() is good but if it was under #ifdef it would've been even better.

>  	/* bump offset to next potential packet */
>  	rbi->priv_read_index += packetlen + VMBUS_PKT_TRAILER;
>  	if (rbi->priv_read_index >= dsize)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 6256cc34c4a6..8d068956dd67 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -23,6 +23,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/reciprocal_div.h>
> +#include <linux/delay.h>
>  
>  #define MAX_PAGE_BUFFER_COUNT				32
>  #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
> @@ -926,6 +927,19 @@ struct vmbus_channel {
>  	 * full outbound ring buffer.
>  	 */
>  	u64 out_full_first;
> +
> +	/* enabling/disabling fuzz testing on the channel (default is false)*/
> +	bool fuzz_testing_state;
> +
> +	/* Buffer delay will delay the guest from emptying the ring buffer
> +	 * for a specific amount of time. The delay is in microseconds and will
> +	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
> +	 * The  Message delay will delay guest reading on a per message basis
> +	 * in microseconds between 1 to 1000 with the default being 0
> +	 * (no delay).
> +	 */
> +	u32 fuzz_testing_buffer_delay;
> +	u32 fuzz_testing_message_delay;
>  };
>  
>  static inline bool is_hvsock_channel(const struct vmbus_channel *c)

-- 
Vitaly
