Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60F43E003
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJ1LcB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 07:32:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34673 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhJ1LcA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 07:32:00 -0400
Received: by mail-wr1-f49.google.com with SMTP id d10so9630332wrb.1;
        Thu, 28 Oct 2021 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=421f3LwifZUZNPSEyEAdKWVD1ka58kXxmjC4jtayTyo=;
        b=NSGDJFTPLklghMnOlmJnaNsx1pS7aPIzRvpVTfA6EOZ7sawX2Jp/TCVwYG+82l0L5/
         omQy67Spgjto71I2sg/pCXjm+Ut++sin7Bw0weh/zBKiFNZyxdmgVPiV+8X6mpMsbXp4
         AsOmZzGdOuIA3NuCcdWDLgUyelRn7WL8W1JsLxK2lJmB7sOVqF51T5Ur6Z2bm6cBk2qo
         2SeOvfE9W63+7wttiDCdNcD0MMcfp68hrMKlgJ4M3PUA77L7WsZnF4BmUldlcv5Od4Y6
         e6nhivW9+nNhUDrXfw2T6deeSRolN3JwJB6mB3T+UG96xeErYjEMblGTh2DQAJgNxP8P
         0p5w==
X-Gm-Message-State: AOAM532LAb2sVgoTWxuW9QbFLrknuGvgvPTXNH4n+6c2btw5D4rvY7tN
        L3aFeftEhVXUSK3RDPlkUrs=
X-Google-Smtp-Source: ABdhPJyl0gL67L8UZYs45igP2Y6XhiUvKPuocLTaWT/V3kiRoVKZvhWhV3phJ2qExXMh/65iUF/qJQ==
X-Received: by 2002:a5d:6dae:: with SMTP id u14mr4951249wrs.46.1635420572916;
        Thu, 28 Oct 2021 04:29:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 3sm2673764wms.5.2021.10.28.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:29:32 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:29:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] x86/hyperv: remove duplicate include in hv_init.c
Message-ID: <20211028112931.3zq5qialuzro4mc5@liuwe-devbox-debian-v2>
References: <20211027081808.2099-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027081808.2099-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 27, 2021 at 08:18:08AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> 'linux/io.h' included in 'arch/x86/hyperv/hv_init.c'
>  is duplicated.It is also included on the 23 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

This is fixed by an earlier patch which happened to be sent out one day
before yours. I just picked that one up.

Thanks anyway.

Wei.

> ---
>  arch/x86/hyperv/hv_init.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a16a83e46a30..4fb7c7bb164e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -20,7 +20,6 @@
>  #include <linux/kexec.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
> -#include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
> -- 
> 2.25.1
> 
