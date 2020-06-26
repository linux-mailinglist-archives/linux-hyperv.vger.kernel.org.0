Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338DD20B258
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2020 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFZNTy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jun 2020 09:19:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43759 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNTy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 09:19:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id j4so7029357wrp.10;
        Fri, 26 Jun 2020 06:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m969CeyZWFMnAeRNTD0HdPXdGGiv/1qoAkylW/aijZg=;
        b=qUsp1/fddneN60zZXptil7sqk13Zxwu33i9Ag+I+sNDq8CPoswzccz8oM57H4SUqn8
         uNyDGIPDrl5uzb8CpqsDtA5RSBQG1zbqcVons7xYGkcKZJNe44v55AfpB1f1HP3a93IH
         uiLvWVCq6dA3J9hXFUIqs4eggDeoG9h6+RqUOdlKIqUNVVIkiiyGkT+k3ipqM2Fl1dC2
         SU423v/yasnlelaAKSYr7DUzFp9TdYzL34H3//2k7I5C2MX+OOfdP3ngNGGjymp0DM6+
         R2Zfyt7UFt/V9MPziy9RnJhuG1C4vPAKCC2AlmJ+H6RHCJc4tLjzsPHKBWCYbkiz/5qv
         YA7g==
X-Gm-Message-State: AOAM5309MFhciE7MVL8sQXEihyZsfra6BSbZBUg6fNvRgL8cI9ZCeDuo
        duugC61hbBhm/h/ZzRId4p0=
X-Google-Smtp-Source: ABdhPJzxNqcr8qiKvnQD2oAQNAdEEW/ojvoE++GrY4Uh/DoEiOW5AZWWvbsv8hyccXJj75QeuG65Mg==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr753744wrv.57.1593177591625;
        Fri, 26 Jun 2020 06:19:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x18sm16794296wmi.35.2020.06.26.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:19:51 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:19:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andres Beltran <lkmlabelt@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200626131949.gg3ndl4s6alvembp@liuwe-devbox-debian-v2>
References: <20200625153723.8428-1-lkmlabelt@gmail.com>
 <20200625153723.8428-2-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625153723.8428-2-lkmlabelt@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 25, 2020 at 11:37:21AM -0400, Andres Beltran wrote:
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
> 
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
>  drivers/hv/channel.c   | 149 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  21 ++++++
>  2 files changed, 170 insertions(+)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 3ebda7707e46..2ea1bfecbfda 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -112,6 +112,70 @@ int vmbus_alloc_ring(struct vmbus_channel *newchannel,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
>  
> +/**
> + * request_arr_init - Allocates memory for the requestor array. Each slot
> + * keeps track of the next available slot in the array. Initially, each
> + * slot points to the next one (as in a Linked List). The last slot
> + * does not point to anything, so its value is U64_MAX by default.
> + * @size The size of the array
> + */
> +static u64 *request_arr_init(u32 size)
> +{
> +	int i;
> +	u64 *req_arr;
> +
> +	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
> +	if (!req_arr)
> +		return NULL;
> +
> +	for (i = 0; i < size - 1; i++)
> +		req_arr[i] = i + 1;
> +
> +	/* Last slot (no more available slots) */
> +	req_arr[i] = U64_MAX;
> +
> +	return req_arr;
> +}
> +
> +/*
> + * vmbus_alloc_requestor - Initializes @rqstor's fields.
> + * Slot at index 0 is the first free slot.
> + * @size: Size of the requestor array
> + */
> +static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
> +{
> +	u64 *rqst_arr;
> +	unsigned long *bitmap;
> +
> +	rqst_arr = request_arr_init(size);
> +	if (!rqst_arr)
> +		return -ENOMEM;
> +
> +	bitmap = bitmap_zalloc(size, GFP_KERNEL);
> +	if (!bitmap) {
> +		kfree(rqst_arr);
> +		return -ENOMEM;
> +	}
> +
> +	rqstor->req_arr = rqst_arr;
> +	rqstor->req_bitmap = bitmap;
> +	rqstor->size = size;
> +	rqstor->next_request_id = 0;
> +	spin_lock_init(&rqstor->req_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * vmbus_free_requestor - Frees memory allocated for @rqstor
> + * @rqstor: Pointer to the requestor struct
> + */
> +static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
> +{
> +	kfree(rqstor->req_arr);
> +	bitmap_free(rqstor->req_bitmap);
> +}
> +
>  static int __vmbus_open(struct vmbus_channel *newchannel,
>  		       void *userdata, u32 userdatalen,
>  		       void (*onchannelcallback)(void *context), void *context)
> @@ -122,6 +186,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	u32 send_pages, recv_pages;
>  	unsigned long flags;
>  	int err;
> +	int rqstor;
>  
>  	if (userdatalen > MAX_USER_DEFINED_BYTES)
>  		return -EINVAL;
> @@ -132,6 +197,14 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	if (newchannel->state != CHANNEL_OPEN_STATE)
>  		return -EINVAL;
>  
> +	/* Create and init requestor */
> +	if (newchannel->rqstor_size) {
> +		rqstor = vmbus_alloc_requestor(&newchannel->requestor,
> +					       newchannel->rqstor_size);

You can simply use err here to store the return value or even get rid of
rqstor by doing

   if (vmbus_alloc_requestor(...))

> +		if (rqstor)
> +			return -ENOMEM;
> +	}
> +
>  	newchannel->state = CHANNEL_OPENING_STATE;
>  	newchannel->onchannel_callback = onchannelcallback;
>  	newchannel->channel_callback_context = context;
> @@ -228,6 +301,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  error_clean_ring:
>  	hv_ringbuffer_cleanup(&newchannel->outbound);
>  	hv_ringbuffer_cleanup(&newchannel->inbound);
> +	vmbus_free_requestor(&newchannel->requestor);
>  	newchannel->state = CHANNEL_OPEN_STATE;
>  	return err;
>  }
> @@ -703,6 +777,9 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
>  		channel->ringbuffer_gpadlhandle = 0;
>  	}
>  
> +	if (!ret)
> +		vmbus_free_requestor(&channel->requestor);
> +
>  	return ret;
>  }
>  
> @@ -937,3 +1014,75 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
>  				  buffer_actual_len, requestid, true);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
> +
> +/*
> + * vmbus_next_request_id - Returns a new request id. It is also
> + * the index at which the guest memory address is stored.
> + * Uses a spin lock to avoid race conditions.
> + * @rqstor: Pointer to the requestor struct
> + * @rqst_add: Guest memory address to be stored in the array
> + */
> +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
> +{
> +	unsigned long flags;
> +	u64 current_id;
> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);

Do you really need the irqsave variant here? I.e. is there really a
chance this code is reachable from an interrupt handler?

Wei.
