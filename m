Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F743DFFB
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhJ1Laz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 07:30:55 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:44752 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhJ1Lay (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 07:30:54 -0400
Received: by mail-wm1-f52.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1935956wme.3;
        Thu, 28 Oct 2021 04:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jf8mcGTeOEB3L9RsyjJTqUZF0a+B9UjVqYwAhZ+VJF8=;
        b=gFuvfkVEvd4DlKhXonVRWUBNMtOtMVhwanDYk9u1hvic/zfbDDNYxAVzp36bHIgQW0
         HkRI51+0naMdpWtb68Brlgb7bMB47ssmeyW3nCOPdkC+Strpn4vVOk3nAGIM5P1chfIJ
         1HclSHYUM+cdeNM9vMqtZ4j7oRn9BO7Qo+GMvMJjCJQjeDoYI+598BjEbFun3oPIsCwu
         VaRB9WyazGm81ogiCCYM+4YU51qu+Z1BZLCNtpB8yVOTsEeb5jNLYX1g9IT1hAMi/i3+
         0FyMC/2bU7wLCx2Em2nLcopQ0D2pl7M4666MsJU11muLt5Wrh2MUZZPbvDioSDDGwMhL
         ZVbA==
X-Gm-Message-State: AOAM532+eWLT69P5x6WBuvdO2SbHqnebQg9w/NbqR2n8tIUSFd1REOgm
        Y0FXcKQxX9i9EjvjvFZdvr8=
X-Google-Smtp-Source: ABdhPJyYI537yWYs0DmTtyIUQKi+OcSTP4a/f0o+zbyOBSqVkIHiElUzgkhBKG2v771PhgJ+ALmruw==
X-Received: by 2002:a1c:7411:: with SMTP id p17mr3785973wmc.114.1635420506916;
        Thu, 28 Oct 2021 04:28:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z1sm2948240wre.21.2021.10.28.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:28:26 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:28:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] x86/hyperv: Remove duplicated include in hv_init
Message-ID: <20211028112824.ry2falfyau5wvhd6@liuwe-devbox-debian-v2>
References: <20211026113249.30481-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026113249.30481-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 26, 2021 at 07:32:49AM -0400, Wan Jiabing wrote:
> Fix following checkinclude.pl warning:
> ./arch/x86/hyperv/hv_init.c: linux/io.h is included more than once.
> 
> The include is in line 13. Remove the duplicated here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied to hyperv-next. Thanks.

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
> 2.20.1
> 
