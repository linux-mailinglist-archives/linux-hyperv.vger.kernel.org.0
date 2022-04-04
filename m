Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B884F121B
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354272AbiDDJgy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354285AbiDDJgy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 05:36:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA1275FB
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Apr 2022 02:34:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so7348119wms.2
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Apr 2022 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xry0fvSIyDxjB2H9TftOM1VVr7Z84GMJx65XGE7l1g8=;
        b=QyIkbrvP3PXHYn8SZb3YFGNOU4YEWKwijKbTOMes2v3n/iFjy3E0l83+3PU1OyKdiC
         28W9oIBBI4K+hraVFUC4rWiUr33rPk2ySKcvsAeR22WUXi4iM2aHnZd8Fn1GeAeirYrD
         vpYCRqjh9PypWsECcQ9s8YJ0IOwuqrtnIou1JtT8aMLsJeQiP8+/F14BOx45Pzoc5hOs
         zFVa0z20WuRvfR9IM3W6B7NXFHL5NIRr3q2/9wWYRFFUZeBeGzMux4sUyMGNAuZjF3t0
         mwwwBGsWFJCRgizWUZXY7qrl7cdc2T3DX58d8hKruK4mcWNDpPeP1QmPVvKj4hi4kGzf
         uymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xry0fvSIyDxjB2H9TftOM1VVr7Z84GMJx65XGE7l1g8=;
        b=W9UPI6hrcK1EiI7ghaFItN3l6aG4pkG7jRGGPYXkr7bLQyHwgRdgBXjP5VB7jDxpvR
         CmtW+pqUYtxNl/nv1zX3dAo/wTLceI/y5RwP4clNW+3SBdOulPhl6TckDYY2iqUprhfU
         LxWeC5NRshHoGi3dt8rNFSQkNKj7oCAohHo4q4rWo33dODXCgTVTThKiVjchvGfjBMiy
         roGKfkc1UOG0sWc/AGAekFlZX0ZPRzf/5cBCsolRAjkRRIlN4POQUvbmr2HSWwvmBa2D
         2myhdi67UHQkVyMhQviJCRNaHVXsAJtNWXNYhbj7b9imdg7txxmgz4i4yjuRhCGDyWji
         ggSA==
X-Gm-Message-State: AOAM532wjz9ieo/QiwhqKGOHCgMgl05Yh89r1SpaOJulbXIuxgRLS1me
        HtNy0I1iXi9ouxBCfdYgyLG+2w==
X-Google-Smtp-Source: ABdhPJw+vbnPc6vft6RqA6zSnbRtvDlS1NwlZFp269pvENQ083BNJ7dEdI8BO5JpR9Ta6ymEkaX/jQ==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id a7-20020a05600c348700b0038c9a424d49mr18900226wmq.29.1649064894420;
        Mon, 04 Apr 2022 02:34:54 -0700 (PDT)
Received: from [192.168.0.173] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm9143811wri.48.2022.04.04.02.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 02:34:54 -0700 (PDT)
Message-ID: <2976f4f9-4fda-c04f-45cf-351518f88ec0@linaro.org>
Date:   Mon, 4 Apr 2022 11:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 01/12] driver: platform: Add helper for safer setting
 of driver_override
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-2-krzysztof.kozlowski@linaro.org>
 <CAHp75Vczm9f9Bx_w4nW31cnBgwEzPiN-Eqn-7DKZuB+Hew0F=Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHp75Vczm9f9Bx_w4nW31cnBgwEzPiN-Eqn-7DKZuB+Hew0F=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 04/04/2022 11:16, Andy Shevchenko wrote:
> On Sun, Apr 3, 2022 at 9:38 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Several core drivers and buses expect that driver_override is a
>> dynamically allocated memory thus later they can kfree() it.
>>
>> However such assumption is not documented, there were in the past and
>> there are already users setting it to a string literal. This leads to
>> kfree() of static memory during device release (e.g. in error paths or
>> during unbind):
>>
>>     kernel BUG at ../mm/slub.c:3960!
>>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>>     ...
>>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
>>
>> Provide a helper which clearly documents the usage of driver_override.
>> This will allow later to reuse the helper and reduce the amount of
>> duplicated code.
>>
>> Convert the platform driver to use a new helper and make the
>> driver_override field const char (it is not modified by the core).
> 
> ...
> 
>> +int driver_set_override(struct device *dev, const char **override,
>> +                       const char *s, size_t len)
>> +{
>> +       const char *new, *old;
>> +       char *cp;
> 
>> +       if (!override || !s)
>> +               return -EINVAL;
> 
> Still not sure if we should distinguish (s == NULL && len == 0) from
> (s != NULL && len == 0).
> Supplying the latter seems confusing (yes, I see that in the old code). Perhaps
> !s test, in case you want to leave it, should be also commented.

The old semantics were focused on sysfs usage, so clearing is by passing
an empty string. In the case of sysfs empty string is actually "\n". I
intend to keep the semantics also for the in-kernel usage and in such
case empty string can be also "".

If I understand your comment correctly, you propose to change it to NULL
for in-kernel usage, but that would change the semantics.

> Another approach is to split above to two checks and move !s after !len.

I don't follow why... The !override and !s are invalid uses. !len is a
valid user for internal callers, just like "\n" is for sysfs.

> 
>> +       /*
>> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
>> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
>> +        * Thus we can store one character less to avoid truncation during sysfs
>> +        * show.
>> +        */
>> +       if (len >= (PAGE_SIZE - 1))
>> +               return -EINVAL;
> 
> Perhaps explain the case in the comment here?

You mean the case we discuss here (to clear override with "")? Sure.

> 
>> +       if (!len) {
>> +               device_lock(dev);
>> +               old = *override;
>> +               *override = NULL;
> 
>> +               device_unlock(dev);
>> +               goto out_free;
> 
> You may deduplicate this one, by
> 
>                goto out_unlock_free;
> 
> But I understand your intention to keep lock-unlock in one place, so
> perhaps dropping that label would be even better in this case and
> keeping it

Yes, exactly.

> 
>        kfree(old);
>        return 0;
> 
> here instead of goto.

Slightly more code, but indeed maybe easier to follow. I'll do like this.


Best regards,
Krzysztof
