Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75744A96F5
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiBDJjv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 04:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235827AbiBDJju (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 04:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643967589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRQ0V6A4LJGZYYi+Sr1vXwJbaJF8WqK92x/QgWB2ajI=;
        b=e2i9XbBNxNTuKS5Nm0hKCpElk8xVXTT8Il9rVKWNWz5e0ks61O32azwIGypyZC0C3rnODJ
        3cBeo3rYQxHyzIqJvmq2wylGpgN8VznCp3s4KavBTIDQFOaVrBdP+/zDiTENOBs0QkvZZC
        mxwpSfDOs2G9oqY3mms6zVWB26uLh8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-ZXL7dbxyNGGWIytDj3TNJA-1; Fri, 04 Feb 2022 04:39:48 -0500
X-MC-Unique: ZXL7dbxyNGGWIytDj3TNJA-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so7334681wms.2
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Feb 2022 01:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qRQ0V6A4LJGZYYi+Sr1vXwJbaJF8WqK92x/QgWB2ajI=;
        b=yk14J+fcA0tGxc5/8oN+9evQ1yRrl+YVsFIzvqHoiwOXsIT9h6AWvo2jeh34DXAQGJ
         iys70G3XhEErh7KE8fW7Y8qAiZvv2LvxC6tXkkY4e/T5NlLNfUtAmCZ62BBkaOa76IBf
         rKN4N6EGj0DjWM4GYSDW4p4pYtVJ14LVR88QLm4bqu31WivamPoLUrKKWbbjeUc6dFsm
         vcrP65sZZ5lQDPmOQbibAhIyDfqDjgMGiDm+KfQ8yCPP4Nob3CSeNu4lSLtc94Nrtmfa
         Pft6UUHV0naOWG9X5cteYlLJVYrUWc09kduvU19c8JWQtOxyBfxmq0Iw4H39lKX9F+vR
         4ltw==
X-Gm-Message-State: AOAM5303bB4KbRc8D0rP6gGbUnhm5FypEc97D8SHKo3vlpgQVbFEwj03
        xW235oWSzoMP3l30waUI67rfdCgbLk+NgNOILBl8R04895KTiwrQC64v4M37R54VbHEgqVxEG+N
        ak677staWF/webagfdgAg89//
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr1685410wrc.662.1643967587630;
        Fri, 04 Feb 2022 01:39:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSmnfdb7J2xKfU0o/lDh0gX0R8rPi0QhfEP+YUKcytUS8Rpo53Z87wdhLqyQGvUbGMYyoTuA==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr1685396wrc.662.1643967587461;
        Fri, 04 Feb 2022 01:39:47 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l10sm1583654wry.79.2022.02.04.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:39:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
In-Reply-To: <20220204022627.4183515-1-vt@altlinux.org>
References: <20220204022627.4183515-1-vt@altlinux.org>
Date:   Fri, 04 Feb 2022 10:39:46 +0100
Message-ID: <871r0jas2l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> writes:

> Clang 12.0.1 cannot understand that value 64 is excluded from the shift
> at compile time (for use in global context) resulting in build error[1]:
>
>   drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> 			      ^~~~~~~~~~~~~~~~
>   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
>   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> 						       ^ ~~~
>
> Avoid using DMA_BIT_MASK macro for that corner case.

Was this reported to Clang already? It looks like a clear bug on their side.

>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmxa@altlinux.org/
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changes since v1:
> - Patch description updated, s/GCC 11/Clang 12/.
>
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..2376ee484362 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2079,7 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
>  	return child_device_obj;
>  }
>  
> -static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> +static u64 vmbus_dma_mask = ~0ULL;
>  /*
>   * vmbus_device_register - Register the child device
>   */

-- 
Vitaly

