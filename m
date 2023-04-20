Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5816E9E34
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Apr 2023 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDTV7W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Apr 2023 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDTV7V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Apr 2023 17:59:21 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24D1FE9;
        Thu, 20 Apr 2023 14:59:20 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1a6862e47b1so17775835ad.0;
        Thu, 20 Apr 2023 14:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682027960; x=1684619960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3t/4IKujL+j6Bbyb2zCnzo5/T/IxEaCiO/CbGvMAvI=;
        b=jRIOKU5clFCN+xBvRGC/Xbfwc0xBK/B4AcK0OZEzCh3q5xNw2CgnaJqQ5Dw4P+xEEC
         VIncwiXg9mgjHKpCl/r/uNfyViA5UdZbHMB4KzMgNX1Pzww4IL0nlHMFOTowQRowqWbO
         HbC89UfIaN2wBVD+sNXSC1TwclwIWP5hcjn7TfzbCEz3yJ7StF1P1YhoNBXTGuXpPZHQ
         Mt8QNT5iqxljSUbFJagoopnJaS15rCyEHYzswP9dbiPwBCt8EAWhjJNAd0GXGb/5HzA3
         HiDcAm8CYloTRO34pqKtSZljU3RAeTyZlZNz7X3hz5qq0L5MIUxEBR8HM/Hm5Lr3Vs+E
         opTg==
X-Gm-Message-State: AAQBX9eAFM6ealFRGo9fSDn+WNx5R7UrP/xswmvD7+/grRJg3gwPMjhZ
        4gP5vd7xF3v/j3X6IWQPLMTENOzByhQ=
X-Google-Smtp-Source: AKy350Y8e609v04FznrKe1zOu3l4meBGPy5nQT9t4Wn72HHp8y2nGkquf2NZWDEN2DJUTpGOOsFV6w==
X-Received: by 2002:a17:902:ab92:b0:1a6:8ed5:428a with SMTP id f18-20020a170902ab9200b001a68ed5428amr3092913plr.22.1682027960379;
        Thu, 20 Apr 2023 14:59:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902c44300b0019abd4ddbf2sm1558006plm.179.2023.04.20.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:59:19 -0700 (PDT)
Date:   Thu, 20 Apr 2023 21:59:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Suhui <suhui@nfschina.com>
Cc:     "K . Y . Srinivasa" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Remove unnecessary (void*)
 conversions
Message-ID: <ZEG1tjvoqTxLxYvl@liuwe-devbox-debian-v2>
References: <20230419080331.505798-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419080331.505798-1-suhui@nfschina.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 19, 2023 at 04:03:31PM +0800, Suhui wrote:
> No need cast (void*) to (struct hv_ring_buffer *).
> 
> Signed-off-by: Suhui <suhui@nfschina.com>

Unfortunately due to recent changes this patch no longer applies to
hyperv-next.

> ---
>  drivers/hv/ring_buffer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index c6692fd5ab15..5471321169e9 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -209,9 +209,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  		for (i = 0; i < 2 * (page_cnt - 1); i++)
>  			pfns_wraparound[i + 1] = pfn + i % (page_cnt - 1) + 1;
>  
> -		ring_info->ring_buffer = (struct hv_ring_buffer *)
> -			vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
> -				 PAGE_KERNEL);
> +		ring_info->ring_buffer = vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
> +						  PAGE_KERNEL);
>  		kfree(pfns_wraparound);
>  
>  		if (!ring_info->ring_buffer)
> @@ -231,9 +230,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  			pages_wraparound[i + 1] =
>  				&pages[i % (page_cnt - 1) + 1];
>  
> -		ring_info->ring_buffer = (struct hv_ring_buffer *)
> -			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -				PAGE_KERNEL);
> +		ring_info->ring_buffer = vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> +					      PAGE_KERNEL);
>  
>  		kfree(pages_wraparound);
>  		if (!ring_info->ring_buffer)
> -- 
> 2.34.1
> 
