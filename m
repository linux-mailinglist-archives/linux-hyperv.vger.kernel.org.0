Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DB1A8C69
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633063AbgDNUYS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 16:24:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33793 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633040AbgDNUYQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 16:24:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id c195so13324050wme.1;
        Tue, 14 Apr 2020 13:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8foj8DrysV33p4mme5GdEjxA5CWGWkeyAu6FZ3U4eS0=;
        b=IF1f8RElmawcrPYoRSgrPir9kIXdHCdU6Meve1ekN4grhbEqXhRTNo9tpVhJQ5yueb
         XABFBIRRjKMeqMinSFW5YIoDhFnVcCIir7KJIEzCC8mNOh+wIBA4WL+Kac6cJbaNRgiI
         FPGosUoC2s90URZAgopAYV9/HTqoabvN9ioQEQKnwwf28LesrX8r21wc0l0Xi7Ma3itJ
         SCoMUeO8Nu4SLgV/jAPwhDuoYyT7BFDnPoEj5FmbB4AyCzqT2bJb96tJcOUR3zx1Br1A
         BVOrT7y7aF++KRbbTL1rihlwVkU850LUmc2mw3jfpKdBT5k8C3yFfmlvB7qsUWixzIjK
         DofA==
X-Gm-Message-State: AGi0PuZ0Ti9rD5vuV0jnGwlxVEsnYbjzKAkLIaEWss+4etQ00ZGTB+L2
        Ox5Nhak3IzhraM+k0Qb5ErA=
X-Google-Smtp-Source: APiQypKNDiBsb0VoeE7xhlyPlc3j5YSKwr2IMwWp7yUDNrjRzO29ekzSD3mV+sqz2oB1ca/p8BMjlA==
X-Received: by 2002:a1c:9891:: with SMTP id a139mr1688487wme.129.1586895854749;
        Tue, 14 Apr 2020 13:24:14 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id y5sm21213391wru.15.2020.04.14.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:24:14 -0700 (PDT)
Date:   Tue, 14 Apr 2020 21:24:12 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to
 pointer primary_channel
Message-ID: <20200414202412.op5kxcqc7k4bce6z@debian>
References: <20200414152343.243166-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414152343.243166-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 14, 2020 at 04:23:43PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer primary_channel is being assigned with a value that is never,
> The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks.

Now that the only user of primary_channel is within the else branch, we
can go one step further to move the definition of primary_channel there.

I can make the adjustment while committing this patch, as well as
updating the commit message.

Wei.

> ---
>  drivers/hv/channel_mgmt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ffd7fffa5f83..f7bbb8dc4b0f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>  
>  	if (channel->primary_channel == NULL) {
>  		list_del(&channel->listentry);
> -
> -		primary_channel = channel;
>  	} else {
>  		primary_channel = channel->primary_channel;
>  		spin_lock_irqsave(&primary_channel->lock, flags);
> -- 
> 2.25.1
> 
