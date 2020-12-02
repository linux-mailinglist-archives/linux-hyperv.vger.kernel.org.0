Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6982CBCE6
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgLBMXp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 07:23:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33755 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLBMXo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 07:23:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id u12so3723039wrt.0;
        Wed, 02 Dec 2020 04:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9yZnJwUyGYJWXufZN6mWISbIVmm/nLFQLYOSV6Egd8=;
        b=JW7PUlZXGi8+MUpZeRe6f4wkIqyvrAbgO5iNVIP5Ozg3qZb0vK/XrZupLF7hm1moPD
         Cg7QoLlRNkXOh6CWrOOnoUy88mjnEvift6LhN6svRkDVKse+A+JLY9IbN+UhuaXemPNk
         JGDfNB19T3uebZ1w32Cn7buhU6E9qR+RxV+/5yoTKxuDMdhoJra9hJLZXPMNvXmxekrU
         DDcxohc0swI8qkeUI5qsMUv86YreEE8+aHR0XzW5Op3AqINElJR2fGUc51a9GesQc4Fg
         C001R+NNjBQN2b8LdwTbKEBHYpbG8whY7GdoKEsazh/+GAhZJ7K1dakRncezF/DS3Jz2
         RoiA==
X-Gm-Message-State: AOAM531fILkcvtZKufd3/tzugW3KULCaCpUiCenrGnWwRkDiOupmC9uT
        1ZVuaGufhLLJclTcp2GAbD8=
X-Google-Smtp-Source: ABdhPJzaap45vwcn7+2rJjslwsNC5S8s9IkkvW3wnhHWpU6oLLly8GMf8Sh94X8BcJKXhfKYx6dXmw==
X-Received: by 2002:adf:e787:: with SMTP id n7mr3176959wrm.153.1606911776720;
        Wed, 02 Dec 2020 04:22:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g78sm1814572wme.33.2020.12.02.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:22:56 -0800 (PST)
Date:   Wed, 2 Dec 2020 12:22:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH v2 2/7] Drivers: hv: vmbus: Avoid double fetch of msgtype
 in vmbus_on_msg_dpc()
Message-ID: <20201202122254.zjhu3cfcq3zwvmvu@liuwe-devbox-debian-v2>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202092214.13520-3-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 10:22:09AM +0100, Andrea Parri (Microsoft) wrote:
> vmbus_on_msg_dpc() double fetches from msgtype.  The double fetch can
> lead to an out-of-bound access when accessing the channel_message_table
> array.  In turn, the use of the out-of-bound entry could lead to code
> execution primitive (entry->message_handler()).  Avoid the double fetch
> by saving the value of msgtype into a local variable.
> 
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0a2711aa63a15..82b23baa446d7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1057,6 +1057,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	struct hv_message *msg = (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
>  	struct vmbus_channel_message_header *hdr;
> +	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
>  	struct onmessage_work_context *ctx;
>  	u32 message_type = msg->header.message_type;
> @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		/* no msg */
>  		return;
>  
> +	/*
> +	 * The hv_message object is in memory shared with the host.  The host
> +	 * could erroneously or maliciously modify such object.  Make sure to
> +	 * validate its fields and avoid double fetches whenever feasible.
> +	 */
> +
>  	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
> +	msgtype = hdr->msgtype;

Should READ_ONCE be used here?

Wei.
