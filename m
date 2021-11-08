Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9217F447EB0
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhKHLTZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 06:19:25 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36554 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhKHLTZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 06:19:25 -0500
Received: by mail-wm1-f43.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso3435904wml.1;
        Mon, 08 Nov 2021 03:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxrytVLw9uh69qoX0r197tR6AIMkYSznUUwb0bfwvaU=;
        b=4pKZ95r1uRAekE7iYVgXPKDfFXUdqqmZy9M3JfGVsfo+dP3AkcSTcm0s58f9dgy85f
         DvXRDloUmVIK7wowVyyeMPBrj126yynCoPTQsQcwGWq2vFYJc79UHqSs296KH9Y2mJLW
         ybVUr0PX1ax7YRHNQvmUWmaf6UQ7R6/6V/i/j+k4hIkf+9GpYff+Hkpeo67otelTMiGs
         MEKAu86qiIjI+A38xwGX46/y3RCrq+sIyvXorlnWaidc2XFEBIUnNBYX0tPQ87FZjHzw
         cPkM65B57EjxmkszuG7v52s6OgQ6Cpa4BYMvg1nplpOUK0bUTXiI2D7wba+0piLUWaQn
         T0+g==
X-Gm-Message-State: AOAM532FeWzq+vU0enUQvZHQ83DxlOgwbQ+Jw/8zGVimkwRtrDc+5EWK
        9jiuaNUo+kDu0ismdP3cjZut6pLFOfs=
X-Google-Smtp-Source: ABdhPJwHF2VokMpNVGDxPma9gUxZIz3oSvmZ/UaIc9sIbhspWpSfPxInRDPTf+J+VdLDpOCrYdR5hQ==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr29176965wmg.118.1636370200099;
        Mon, 08 Nov 2021 03:16:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h16sm18356263wrm.27.2021.11.08.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:16:39 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:16:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v0 08/42] Drivers: hv: vmbus: Check notifier registration
 return value
Message-ID: <20211108111637.c3vsesezc7hwjbty@liuwe-devbox-debian-v2>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-9-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101157.15189-9-bp@alien8.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 08, 2021 at 11:11:23AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-hyperv@vger.kernel.org

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 392c1ac4f819..370afd108d2d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1574,8 +1574,8 @@ static int vmbus_bus_init(void)
>  	 * the VMbus channel connection to prevent any VMbus
>  	 * activity after the VM panics.
>  	 */
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -			       &hyperv_panic_block);
> +	if (atomic_notifier_chain_register(&panic_notifier_list, &hyperv_panic_block))
> +		pr_warn("VMBus panic notifier already registered\n");
>  
>  	vmbus_request_offers();
>  
> -- 
> 2.29.2
> 
