Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270EA43E021
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhJ1Lkv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 07:40:51 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:47032 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Lkv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 07:40:51 -0400
Received: by mail-wm1-f46.google.com with SMTP id b194-20020a1c1bcb000000b0032cd7b47853so3638935wmb.5;
        Thu, 28 Oct 2021 04:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPsZe59sUfz40Za7EQsJFQwt8poLF06kBo3e/Xrgz4k=;
        b=YuDeFtQd7mt/GoG5fki8bHi6rY4exosqP7mXzbF+98Go3aD8AWZdG3JESG2IJhUHVT
         XKocJeTauqOOQxeOc0uSYyCGGYATk+MZXW1kgmKR0FIEyXuqYF856opj+Sh/UDrjAp9j
         KKKZm/8h2hnhzHVqsoOV4nrpBAFXFiiEZaeqmvOFFW3k0bZXNvppKzTihsWihgoi//e7
         yzzxajOf1qwZgyp/ALTU2xRQBy5s4VYqfqwCztGQ327NZPYYl4oZjsPoQU5bbsoQJSe3
         ScvHezAX0nsP4KgeYunKLLrsbewe5X28G3VxXkH3/ZZG8WnLQN5o0PwqbpqTZ4Co+jll
         uN2g==
X-Gm-Message-State: AOAM531H1VR24q/sxxZatTzoYHUo73PDpUOP6N1UeAUiPBrgUEJu49st
        hJJxzkeHaPM115PX0/kkPN8=
X-Google-Smtp-Source: ABdhPJxy6WG/ZkknIxqk6RVc94VSwuHY1SdFwH661s/3ZAdTf7q7CTgKmHphH2KbtvvBFUm0ij9OfA==
X-Received: by 2002:a1c:4646:: with SMTP id t67mr3963627wma.64.1635421103620;
        Thu, 28 Oct 2021 04:38:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m34sm1372200wms.25.2021.10.28.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:38:23 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:38:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] x86/hyperv: remove duplicate include in ivm.c
Message-ID: <20211028113821.4uormm52hfr5hlnd@liuwe-devbox-debian-v2>
References: <20211027090544.2383-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027090544.2383-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 27, 2021 at 09:05:44AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> 'linux/types.h' included in 'arch/x86/hyperv/ivm.c'
>  is duplicated.It is also included on the 12 line.
> 'linux/bitfield.h'included in 'arch/x86/hyperv/ivm.c'
> is duplicated.It is also included on the 13 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

This is already dealt with. Thanks.

> ---
>  arch/x86/hyperv/ivm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 4d012fd9d95d..479201ceae8e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -9,8 +9,6 @@
>  #include <linux/types.h>
>  #include <linux/bitfield.h>
>  #include <linux/hyperv.h>
> -#include <linux/types.h>
> -#include <linux/bitfield.h>
>  #include <linux/slab.h>
>  #include <asm/svm.h>
>  #include <asm/sev.h>
> -- 
> 2.25.1
> 
