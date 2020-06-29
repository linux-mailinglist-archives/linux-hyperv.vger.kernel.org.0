Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF83020E086
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2020 23:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgF2UrD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 16:47:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35671 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbgF2Uq5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 16:46:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id g18so17996675wrm.2;
        Mon, 29 Jun 2020 13:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7B3b2pBNzZdwKMzrzlsX2I3eoakSivJkPodIWcuujkg=;
        b=fW+SnvRyi7VKbM8KtWX/EO15B0SBjRffG/Odue+cS1UymPPA8k6eW3mSzqFiITb2u0
         Gocix24S1s+ZcZDMNepQRf7+gxj1u358NYhWXrFihe3I7mWc2/n7R9B1VA8L2rX6zjxa
         Xp3FYzuQloJ2ovpAFmOOoe6FtSPKljIRdAaxBQk9emnaacet3SiAwd3PFkKE/Fx3K4W2
         VQ1nXmFgGk2MnQC7Zhj0ZWbiX6dNboENmZ/MxE/7ESOzV9m/F2dIZUPWbwTqmlTmQftp
         TV+LXmLZNzCky+c51f6yFf/iGsusFC9859cRMM02AJ11R+xqrYsB5J+WFoe6+wfsWX08
         7D1A==
X-Gm-Message-State: AOAM530wbfzhxTw/C91C0IkQfXp8I8xI8UqKJ4yYyshiulB80EFcTR2N
        lp81RfZlTNuh3BX0wZ33UgM=
X-Google-Smtp-Source: ABdhPJyTQzsvY9UTZXZpGaoSPj9qQo2aDDpJP8RGi6+4kz9ZQ+mhGEvD1IWlImXuk16Q5SQVGOWyTQ==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr19802378wro.41.1593463615117;
        Mon, 29 Jun 2020 13:46:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z2sm1152694wmc.2.2020.06.29.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:46:54 -0700 (PDT)
Date:   Mon, 29 Jun 2020 20:46:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     t-mabelt@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com, Andres Beltran <lkmlabelt@gmail.com>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2>
References: <20200629200227.1518784-1-lkmlabelt@gmail.com>
 <20200629200227.1518784-2-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629200227.1518784-2-lkmlabelt@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 29, 2020 at 04:02:25PM -0400, Andres Beltran wrote:
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
> Changes in v2:
> 	- Get rid of "rqstor" variable in __vmbus_open().
> 
>  drivers/hv/channel.c   | 146 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  21 ++++++
>  2 files changed, 167 insertions(+)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 3ebda7707e46..c89d57d0c2d2 100644
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
> @@ -132,6 +196,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	if (newchannel->state != CHANNEL_OPEN_STATE)
>  		return -EINVAL;
>  
> +	/* Create and init requestor */
> +	if (newchannel->rqstor_size) {
> +		if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_size))
> +			return -ENOMEM;
> +	}
> +

Sorry for not noticing this in the last round: this infrastructure is
initialized conditionally but used unconditionally.

I can think of two options here:

  1. Mandate rqstor_size to be non-zero. Always initialize this
     infra.
  2. Modify vmbus_next_request_id and vmbus_request_addr to deal with
     uninitialized state.

For #2, you can simply check rqstor->size _before_ taking the lock
(because it may be uninitialized, and the assumption is ->size will not
change during the channel's lifetime, hence no lock is needed) and
simply return the same value to the caller.

Wei.
