Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1D2C2CDB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbgKXQ0i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 11:26:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52369 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbgKXQ0h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 11:26:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id 10so2928282wml.2;
        Tue, 24 Nov 2020 08:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eRGc6PGD/C/bb7eassDLJxbAFdnZyH0+sgdit1sSu7c=;
        b=fntC3gNHkrSx9Y9gWslR8g8j/+P/RyW544+EHH+AFIgJbPkwIeMLcbanwDnPG/FIBv
         8btW0EqDXP08rn0zHqteRmmPEqbflqPyhK2wTT5le4wuO4JQwZYAHBcpTJ3lELKo9Luc
         vsFfyjS14YjCgRC0pqnx6x+v3rFPtAxabSz+Ft3XAf3on0cpT1WY91XbOQyHoaJMPm6k
         fcRhFuzqRj0llVUp3cpcrE/sFXANaEnc1KgqTAXvDu+zGoTAl38wP+UOChoUt6k59V4X
         6xZ1ADhM31AXeQwENh7aAD8eHv1vPY9kZKzN6SDtlB1jlaG8/JNFWPjldThxNPhn+6Tv
         MD5A==
X-Gm-Message-State: AOAM532WOXDOOe/iWofXa8zFib0Zsc1hcXJUwKI5URVrIG+X3z6HCnb9
        9vmt++QU15iTuKS1yvI/l7Y=
X-Google-Smtp-Source: ABdhPJyPq6zbi2JDf+rpdvKIMGqBbK/qcsC2qXC7Cai/rdkHpilssxxH+M25e1q04wDCQ8GLmelyyQ==
X-Received: by 2002:a1c:328a:: with SMTP id y132mr5299762wmy.134.1606235195537;
        Tue, 24 Nov 2020 08:26:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c187sm7425248wmd.23.2020.11.24.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:26:35 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:26:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH 4/6] Drivers: hv: vmbus: Avoid use-after-free in
 vmbus_onoffer_rescind()
Message-ID: <20201124162633.n7zlpte6f7zfhn6z@liuwe-devbox-debian-v2>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-5-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118143649.108465-5-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 18, 2020 at 03:36:47PM +0100, Andrea Parri (Microsoft) wrote:
> When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
> invoke put_device(), that will eventually release the device and free
> the channel object (cf. vmbus_device_release()).  However, a pointer
> to the object is dereferenced again later to load the primary_channel.
> The use-after-free can be avoided by noticing that this load/check is
> redundant if device_obk is non-NULL: primary_channel must be NULL if

device_obk -> device_obj

> device_obj is non-NULL, cf. vmbus_add_channel_work().
> 

Missing a Fixes tag?

> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 5bc5eef5da159..4072fd1f22146 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1116,8 +1116,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
>  			vmbus_device_unregister(channel->device_obj);
>  			put_device(dev);
>  		}
> -	}
> -	if (channel->primary_channel != NULL) {
> +	} else if (channel->primary_channel != NULL) {
>  		/*
>  		 * Sub-channel is being rescinded. Following is the channel
>  		 * close sequence when initiated from the driveri (refer to
> -- 
> 2.25.1
> 
