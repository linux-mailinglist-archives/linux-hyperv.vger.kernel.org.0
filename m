Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13C543379F
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Oct 2021 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhJSNtP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Oct 2021 09:49:15 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46754 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhJSNtP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Oct 2021 09:49:15 -0400
Received: by mail-wr1-f43.google.com with SMTP id k7so47669968wrd.13;
        Tue, 19 Oct 2021 06:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=parC8PxzpOXH/U754F84t/+ZClKXFQWU08kBmp0MqI0=;
        b=2Cr1AsSJqH6TM+9+80gjU7Qdf79GMHlbd7xZkMZ2pKZ49Rv6zCDBqzbC238/qppP2A
         eIcFb0Ec5B6TUs3WoBu8FA365l6Y82tpaKQjekMOPddiAVFd+YY9x6J+FCDy0fc809Pz
         Fgzm+5lTSD75G2UZSBsAlbv3Gt5BE8xzwA5eTxH897mvFGVGF4Vn82WZYfILZNngsQG3
         cIoD+oz3hKg8vWZs5fzjImZyIKnUSKVHKeWzP0KxNaqspKQMrJ6hd7PC1SSn7X1nfcMm
         f2T565IbZmoHlX7AbtNW7WZUHmdCq1wZnA9Q0vQaZz8D2ZVBJDDjNnGvM3Kg+46CaQZg
         FT7A==
X-Gm-Message-State: AOAM532RI7nQDI9kBNHsc3TBc4a0N0VtHj9qpbX7pfDj9E1Osy8r6NAF
        7cg+ClQWKkYU1/kwZIfqwFA=
X-Google-Smtp-Source: ABdhPJxd3Z7z4Vf3M93WATsWNR1wZ4XGNiitz2hn96kapMHc+TYmILk5/JmED/rU+kOEQkehq8GjbA==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr43491190wrc.257.1634651221243;
        Tue, 19 Oct 2021 06:47:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u2sm14757178wrr.35.2021.10.19.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:47:00 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:46:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andres Beltran <lkmlabelt@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hypverv/vmbus: include linux/bitops.h
Message-ID: <20211019134659.awxirloepa2d7c32@liuwe-devbox-debian-v2>
References: <20211018131929.2260087-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018131929.2260087-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 18, 2021 at 03:19:08PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On arm64 randconfig builds, hyperv sometimes fails with this
> error:
> 
> In file included from drivers/hv/hv_trace.c:3:
> In file included from drivers/hv/hyperv_vmbus.h:16:
> In file included from arch/arm64/include/asm/sync_bitops.h:5:
> arch/arm64/include/asm/bitops.h:11:2: error: only <linux/bitops.h> can be included directly
> In file included from include/asm-generic/bitops/hweight.h:5:
> include/asm-generic/bitops/arch_hweight.h:9:9: error: implicit declaration of function '__sw_hweight32' [-Werror,-Wimplicit-function-declaration]
> include/asm-generic/bitops/atomic.h:17:7: error: implicit declaration of function 'BIT_WORD' [-Werror,-Wimplicit-function-declaration]
> 
> Include the correct header first.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to hyperv-fixes. Thanks.

> ---
> Not sure what started this, I first saw it on linux-next-20211015
> ---
>  drivers/hv/hyperv_vmbus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 42f3d9d123a1..d030577ad6a2 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -13,6 +13,7 @@
>  #define _HYPERV_VMBUS_H
>  
>  #include <linux/list.h>
> +#include <linux/bitops.h>
>  #include <asm/sync_bitops.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <linux/atomic.h>
> -- 
> 2.29.2
> 
