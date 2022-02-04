Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB614A98E4
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 13:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiBDMGz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 07:06:55 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35756 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBDMGz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 07:06:55 -0500
Received: by mail-wm1-f49.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so485264wml.0
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Feb 2022 04:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsWOaxf0RPOYWZ/b4CD3X+wjUU/4PcqFGx3b+ZbJdNs=;
        b=K+GigRgMY+YksBVGxIt41IFqxGxMXwK/J8gUm4qWal5BYDU9hU+i3uG9ssHlQOtKQV
         HPMsSLpeH1rV6U/cIibsPVl1tkhPBIELZf60UqUVwU4rOhkwYCoNTFMQ7pNmCdg0Dtar
         AkLXPoeqXkqk2lGcunSzSb4asQGb31kNGIU/SIPPuVucJrTCW3z/cdvC3Rv/txsC3VEO
         3x1dRvTve5/gfHurWL58K2szEs5R/E3N9w2FD5j3D4foZh0UQJTfpfbFIkSzh/OEuoDl
         2mic1xJ61z4JCjfV13inbDygbdruK9PU8N/3yUJXcNnLWgimI+8Frh42QSX4jQcF5hXz
         9nEA==
X-Gm-Message-State: AOAM532CSzWtRYkcMlQii9MFq8IhmOKY0EPExG06xNdPkWVW7IWp9RdL
        0D/TD4FnsYBqu4trSvvKGKo=
X-Google-Smtp-Source: ABdhPJxuzKAKth+XPPYoBwhe8Tu63tBPQ2hHsi1F5Q01bpBVHLegfsXVC5J5xU2mpRzlUgkrMxoLXw==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr2007521wmi.91.1643976414406;
        Fri, 04 Feb 2022 04:06:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m5sm1627760wrs.22.2022.02.04.04.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:06:54 -0800 (PST)
Date:   Fri, 4 Feb 2022 12:06:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Message-ID: <20220204120652.h6powkl2cwsjhe2d@liuwe-devbox-debian-v2>
References: <20220204022627.4183515-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204022627.4183515-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 05:26:27AM +0300, Vitaly Chikunov wrote:
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
> 
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmxa@altlinux.org/

BTW there is no need to put in a Link tag here. The tool I use (b4)
handles this automatically.

Wei.
