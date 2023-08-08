Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF5773C3E
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHHQCq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Aug 2023 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHHQBA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Aug 2023 12:01:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D73A80
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Aug 2023 08:40:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso9444763e87.1
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Aug 2023 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509214; x=1692114014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4dnD0+K+dm5daW3WB08MbZFAi/HCGlO7XvEtgJV7ak=;
        b=KyfwSH+VKDAG3BMj6tq3pn2XdASxvwtswVxQebxj2NG3jztY2osuemFtCPhC/7YOAh
         2CPB+EHQfWttbL2v0sPk5LzX+Yvga7MVu3NmIxHEJiSKbRjiIWyQp6SPBxVfRmkhfT3i
         nAYUeSkSWz+HP0UoFgynr3tJV0zy/ZaPDSqgUj8m/vMBqD7pHyvGXSYkLxgvQtZ/UFUU
         4x6kFKd9e4y42hJB2gJHeqFHQLL93IVemXUKAzKB1sr5hUKIrNE0NZt5zx0Wtp2k131e
         6IuN6O+DIjFMO6VBoLRnA83KxznhBnq9OHvz+l6yUgtf0q4U+Hr/9GAyiALnrk33gcSv
         Aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509214; x=1692114014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4dnD0+K+dm5daW3WB08MbZFAi/HCGlO7XvEtgJV7ak=;
        b=i8iG5Mfn9tDJXkfZ8ix1gCseqE5Kr7eXZRHMneCR6U0SLuk1/2YPVFY7OsKfEKJ+qA
         8cv7ZMq5Ob2wjk+f19Uao/q91hbjjRBUPQ5l4F67vU91q5Pm4g+SyQx6Vxvp4XH/k+xI
         uBQ4c+AcE5veusjDdp0IUo2SHEFs4N9HUbpAgDPgVB4mi5ULYtyRKgSdnMrzfFdOkxwx
         rlK0XiJ33Yr4GKDarKUXvpr67aBUlchLEJ1asGhwfqFsU9cRb2KtfpSyQyAZjekIFihl
         a3f+xJKe8vMSVNSwNcjzETubMm+9EFCH4qxJTzPTSs3Py2OGxj/Yci9viaat92ulBKLg
         /t/g==
X-Gm-Message-State: AOJu0YwpV7uOMNSNuwFEgqbL4FsgJxyYG0fSBPAbTAXh0Rzwlxkz1Mv8
        UHC6b84H2hG591U7wmb2w+nl/bXsI4SsJs9wWRM=
X-Google-Smtp-Source: AGHT+IFbsOyyzxbYaBvG1QmkrxxSBHNWlGts8aZAcOYBA1mSGd9SM+bUxD72/iUt8zqziutWdovXJQ==
X-Received: by 2002:a2e:9793:0:b0:2b9:453f:a383 with SMTP id y19-20020a2e9793000000b002b9453fa383mr8829643lji.53.1691508827814;
        Tue, 08 Aug 2023 08:33:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b003fe17901fcdsm18548603wmh.32.2023.08.08.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:33:47 -0700 (PDT)
Date:   Tue, 8 Aug 2023 18:33:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [bug report] net: mana: Add page pool for RX buffers
Message-ID: <7659902d-2419-4d7e-8038-6737267c1e16@kadam.mountain>
References: <72639c0d-9cf5-468e-ad6a-e36c25d63b02@moroto.mountain>
 <PH7PR21MB3116FB9E14746215B1C9D4D4CA0DA@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3116FB9E14746215B1C9D4D4CA0DA@PH7PR21MB3116.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 08, 2023 at 03:12:07PM +0000, Haiyang Zhang wrote:
> 
> Do I have to initialize it, or just add a code comment explaining like above?
> 

It depends on if mana_rx_skb() is going to be inlined or not.  This is
both from a theoretical and pratical perspective.

Theoretical:  Passing uninitialized memory is undefined in C and it's a
bug, but if the function is inline then it's not really "passing" is it?

Pratical:  If it's not inlined then KMemsan will likely warn about it at
runtime but if it is inlined then.

The other thing to consider is that these days the compiler is going to
automatically initialize it to zero anyway, so manually setting it to
zero will not affect runtime.

regards,
dan carpenter

