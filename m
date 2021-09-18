Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD84106EA
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Sep 2021 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhIRNxU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 18 Sep 2021 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbhIRNxT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 18 Sep 2021 09:53:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC9C06175F
        for <linux-hyperv@vger.kernel.org>; Sat, 18 Sep 2021 06:51:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e7so12570262pgk.2
        for <linux-hyperv@vger.kernel.org>; Sat, 18 Sep 2021 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=miV8uugxK2l0+TxTl0bYFsYjBqHnegb6tYLIO2c+/pQ=;
        b=VKw24EWmI8tJCg4PHVON7yyfJEQYhqptyNWjyqSgsFi2IVS6iZif5B1uZsuSDvQJQx
         +SLIrVCrSDmIzh61Ekf1bB13WKURTAlrae0zpyW9LPkrZhrxOTmbsf6XQShfyz4Em/fS
         wf5x9/lw0kRW0qR2yJUr6fJ35kuYwP3X2e7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=miV8uugxK2l0+TxTl0bYFsYjBqHnegb6tYLIO2c+/pQ=;
        b=0GNhVjx3Wi41OcELCoFn1sVh4KjhH6egM/MC3MZgbp6hgZsHPFPq/pLPYCNN15WoCP
         T8vIQQXv+tcqtPMBunIkQ8TwAEfR7t+9tGeDcfNmEJ4oOBPwlFqVA/6MHN5BOb5R4q14
         JXZy5Ds4dnj2HJXTdbmfxo7P4TkAIKdj36zHR8Dm9FOUp3oTrk55K+S8QkGzKRUhkRix
         02MDdGYeKlRAsKtOqTB9L8L435GG0BDe5xd6a4X878FUvz4QOHTeRFlMIK7nStuMlBPC
         mvXfZBlo0p55a+ckSaZqSSbsN06FZY1jDEk99EzEXboCSI2EjmvW9gB6exatdymleBZP
         IJGw==
X-Gm-Message-State: AOAM5307q5FwHwDkuA8i9vI0QbLvcJVL6WsGHValvv/kBqTY+OkX0KFd
        HkVQBzRlNNWud/bj86mBEwqSYw==
X-Google-Smtp-Source: ABdhPJyS2QSKmMpzTd7MmHyqFtqie45S/kXPdQTs6m3qND4U8eV1/DVEXDB+DPoyXL97BCM+ZzgQOA==
X-Received: by 2002:a63:2011:: with SMTP id g17mr14710533pgg.379.1631973115834;
        Sat, 18 Sep 2021 06:51:55 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k29sm9351614pfp.200.2021.09.18.06.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 06:51:54 -0700 (PDT)
Date:   Sat, 18 Sep 2021 06:51:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC:     Colin Ian King <colin.king@canonical.com>,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] net: mana: Prefer struct_size over open coded arithmetic
User-Agent: K-9 Mail for Android
In-Reply-To: <20210918132010.GA15999@titan>
References: <20210911102818.3804-1-len.baker@gmx.com> <20210918132010.GA15999@titan>
Message-ID: <D81D1EE2-92A0-42D5-9238-9B05E4BDE230@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On September 18, 2021 6:20:10 AM PDT, Len Baker <len=2Ebaker@gmx=2Ecom> wr=
ote:
>Hi,
>
>On Sat, Sep 11, 2021 at 12:28:18PM +0200, Len Baker wrote:
>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> and Conventions" documentation [1], size calculations (especially
>> multiplication) should not be performed in memory allocator (or similar=
)
>> function arguments due to the risk of them overflowing=2E This could le=
ad
>> to values wrapping around and a smaller allocation being made than the
>> caller was expecting=2E Using those allocations could lead to linear
>> overflows of heap memory and other misbehaviors=2E
>>
>> So, use the struct_size() helper to do the arithmetic instead of the
>> argument "size + count * size" in the kzalloc() function=2E
>>
>> [1] https://www=2Ekernel=2Eorg/doc/html/v5=2E14/process/deprecated=2Eht=
ml#open-coded-arithmetic-in-allocator-arguments
>>
>> Signed-off-by: Len Baker <len=2Ebaker@gmx=2Ecom>
>> ---
>>  drivers/net/ethernet/microsoft/mana/hw_channel=2Ec | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel=2Ec b/drive=
rs/net/ethernet/microsoft/mana/hw_channel=2Ec
>> index 1a923fd99990=2E=2E0efdc6c3c32a 100644
>> --- a/drivers/net/ethernet/microsoft/mana/hw_channel=2Ec
>> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel=2Ec
>> @@ -398,9 +398,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel=
_context *hwc, u16 q_depth,
>>  	int err;
>>  	u16 i;
>>
>> -	dma_buf =3D kzalloc(sizeof(*dma_buf) +
>> -			  q_depth * sizeof(struct hwc_work_request),
>> -			  GFP_KERNEL);
>> +	dma_buf =3D kzalloc(struct_size(dma_buf, reqs, q_depth), GFP_KERNEL);
>>  	if (!dma_buf)
>>  		return -ENOMEM;
>>
>> --
>> 2=2E25=2E1
>>
>
>I have received a email from the linux-media subsystem telling that this
>patch is not applicable=2E The email is the following:
>
>Hello,
>
>The following patch (submitted by you) has been updated in Patchwork:
>
> * linux-media: net: mana: Prefer struct_size over open coded arithmetic
>     - http://patchwork=2Elinuxtv=2Eorg/project/linux-media/patch/2021091=
1102818=2E3804-1-len=2Ebaker@gmx=2Ecom/
>     - for: Linux Media kernel patches
>    was: New
>    now: Not Applicable
>
>This email is a notification only - you do not need to respond=2E
>
>The question is: Why it is not applicable?=2E I have no received any bad =
comment
>and a "Reviewed-by:" tag from Haiyang Zhang=2E So, what is the reason for=
 the
>"Not Applicable" state?=2E

That is the "Media" subsystem patch tracker=2E The patch appears to be for=
 networking, so the Media tracker has marked it as "not applicable [to the =
media subsystem]"=2E

The CC list for this patch seems rather wide (media, dri)=2E I would have =
expected only netdev=2E Were you using scripts/get_maintainer=2Epl for gett=
ing addresses?

-Kees
