Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95B485A1C
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiAEUjt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 15:39:49 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54152 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiAEUjs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 15:39:48 -0500
Received: by mail-wm1-f41.google.com with SMTP id l4so448827wmq.3;
        Wed, 05 Jan 2022 12:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzWH85whQT3ssvhGdVpZa/al7Evd5XgLfYaXBu8Oz3Q=;
        b=LbTXv0rbKFH9CAIAOCw/yPovyh899Sz0HxENIg8P6q3w4mO17+pHyhc+18MH9e4qZQ
         Nj4P4fEqo8HIUwF524B2pBit41RAFVBwRM+QkJa9yJSiIToORfbGv81RBKoI7XY8d+yv
         U3/ZeaT5cArSBJVwJssrh/ycyB5Ks2VdgktwbmMJEXmQ9xLWDWtXRo/h6vAIHehggk54
         bceOr0ybkqLjmCOt+/7vPwQEty1pcElRDG43hH5SvM8It/6XB0OW8EHLNcX5oWCvlQKr
         O3CI7EBAUWmca6eM44p735/tF0RX2MwbBS302ZLvFF9olL/GxcVenbZZ2r1yWSaEiOnM
         U1lw==
X-Gm-Message-State: AOAM532FyWkdv9bGHSs+bhnDO06Cs4i1l7J3D/ZGi25FAzE9P+oVZBhq
        EV8Xpc4od2I7H5U434ZCYTOEqBC08Ag=
X-Google-Smtp-Source: ABdhPJzeg9XfNfmEmKoiUYIxQZkc9FAE2L9R/R5bTrCkgqFpvlNg3fKVxQ4TQQ90IjJW7Ne5ycEA6A==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr4354421wmq.148.1641415187586;
        Wed, 05 Jan 2022 12:39:47 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n4sm36060wrc.1.2022.01.05.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:39:47 -0800 (PST)
Date:   Wed, 5 Jan 2022 20:39:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Juan Vazquez <juvazq@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Initialize request offers message
 for Isolation VM
Message-ID: <20220105203945.wyh33cws43enviwx@liuwe-devbox-debian-v2>
References: <20220105192746.23046-1-juvazq@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105192746.23046-1-juvazq@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 05, 2022 at 11:27:46AM -0800, Juan Vazquez wrote:
> Initialize memory of request offers message to be sent to the host so
> padding or uninitialized fields do not leak guest memory contents.
> 
> Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>

Applied to hyperv-next. Thanks.

> ---
>  drivers/hv/channel_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 2829575fd9b7..60375879612f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1554,7 +1554,7 @@ int vmbus_request_offers(void)
>  	struct vmbus_channel_msginfo *msginfo;
>  	int ret;
>  
> -	msginfo = kmalloc(sizeof(*msginfo) +
> +	msginfo = kzalloc(sizeof(*msginfo) +
>  			  sizeof(struct vmbus_channel_message_header),
>  			  GFP_KERNEL);
>  	if (!msginfo)
> -- 
> 2.32.0
> 
