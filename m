Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68D5153B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 20:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380007AbiD2Scw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379996AbiD2Scu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 14:32:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF907C74BA
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Apr 2022 11:29:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so16970700ejd.9
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Apr 2022 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1Zn4UF57t4pnfMwkACd31jjeal5RhpHnkwFarZTu/dQ=;
        b=Yju2gP3H7feQ0jeMIY/hZkOEOoSoa00CEibfna6oVQzF9/eQ5+ytMAsdLe5WX7mHeQ
         J61qzVV7hJgD2E7DTMm799fD1ExZWC92O5Z5MQJ3Izz75VW5dcvN/q6CSgHUbws9RglY
         83cEuaWdBuKpqQTXIrafNSDyCsuv2Ew28D74WXz/Ik2eST10Un3FzGmvqMC8O+fYL4PC
         8JQYD4vG/i4KtH8ZMZH0GPFGUg6Nz8RKmYkXLtDfxBXypISaZi6+WTwWX/9LGj3oj9Ql
         L8++NV0TVRjT6Iqj0aHMEIgQOGyyJP0xnB5R1z3nGhE9kAKq1TuJQ1gQ5SW7rPZfWhCn
         o50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Zn4UF57t4pnfMwkACd31jjeal5RhpHnkwFarZTu/dQ=;
        b=oCU/kdquy7R0wrC0PzElFLgPBvUHCojXDaGwmgKrDXetQ1+ne3u4wii66EMb85Ge5K
         p6epjqlWDeeY4u+5M3To39RLlP4Xk+R66z3TcWjyEFX17pg9HlSNNxN8KFo37td6uDJF
         5VRX3F+SX/3BodfbVe6UbPo1M99fXLIW6o+fUH0TUpIKfu3I4Rblj1CeXIOH8RQky/GW
         sSB22U3TliKHwgMgcHtQ4T9G+Vi0O+qfVamsw6omaXZetSIqfLx22iceLVA0nC6Z1Z92
         WJd3UTyiRWuZUnL4Xlj737oBq2/MkVUhCMZIZpObLVqgmcLx/niHgjxNNYX1c+TLApwR
         FIyQ==
X-Gm-Message-State: AOAM530k3FL6QhEFjAXMACPtoxkmpl4JPpIfE2NRATiIyXdtIDaywJwy
        6bnzCaEEh06Ay/F4XWZZw7q71A==
X-Google-Smtp-Source: ABdhPJxnnexTfm1ciFrnHmiTZVvUaiD85uL4/xEhS6m4C1gFLe/tyvaZCnOhPWZFKjyEpqAej5KZuQ==
X-Received: by 2002:a17:907:2cc6:b0:6f0:2de3:9446 with SMTP id hg6-20020a1709072cc600b006f02de39446mr581569ejc.690.1651256968301;
        Fri, 29 Apr 2022 11:29:28 -0700 (PDT)
Received: from [192.168.0.175] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709070b0e00b006f3ef214db9sm858906ejl.31.2022.04.29.11.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:29:27 -0700 (PDT)
Message-ID: <cbf9aad1-cbdb-8886-f979-a793b070e2a1@linaro.org>
Date:   Fri, 29 Apr 2022 20:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
 <20220419113435.246203-13-krzysztof.kozlowski@linaro.org>
 <CGME20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9@eucas1p1.samsung.com>
 <870885de-33f3-e0ba-4d56-71c3c993ac87@samsung.com>
 <75b94ccd-b739-2164-bc4a-20025356cc34@linaro.org>
 <6e21f7d3-49d0-eda7-7a89-0f8ac69596a4@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6e21f7d3-49d0-eda7-7a89-0f8ac69596a4@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 29/04/2022 16:51, Marek Szyprowski wrote:
> On 29.04.2022 16:16, Krzysztof Kozlowski wrote:
>> On 29/04/2022 14:29, Marek Szyprowski wrote:
>>> On 19.04.2022 13:34, Krzysztof Kozlowski wrote:
>>>> The driver_override field from platform driver should not be initialized
>>>> from static memory (string literal) because the core later kfree() it,
>>>> for example when driver_override is set via sysfs.
>>>>
>>>> Use dedicated helper to set driver_override properly.
>>>>
>>>> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
>>>> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> This patch landed recently in linux-next as commit 42cd402b8fd4 ("rpmsg:
>>> Fix kfree() of static memory on setting driver_override"). In my tests I
>>> found that it triggers the following issue during boot of the
>>> DragonBoard410c SBC (arch/arm64/boot/dts/qcom/apq8016-sbc.dtb):
>>>
>>> ------------[ cut here ]------------
>>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>> WARNING: CPU: 1 PID: 8 at kernel/locking/mutex.c:582
>>> __mutex_lock+0x1ec/0x430
>>> Modules linked in:
>>> CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc4-next-20220429 #11815
>>> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>>> Workqueue: events_unbound deferred_probe_work_func
>>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : __mutex_lock+0x1ec/0x430
>>> lr : __mutex_lock+0x1ec/0x430
>>> ..
>>> Call trace:
>>>    __mutex_lock+0x1ec/0x430
>>>    mutex_lock_nested+0x38/0x64
>>>    driver_set_override+0x124/0x150
>>>    qcom_smd_register_edge+0x2a8/0x4ec
>>>    qcom_smd_probe+0x54/0x80
>>>    platform_probe+0x68/0xe0
>>>    really_probe.part.0+0x9c/0x29c
>>>    __driver_probe_device+0x98/0x144
>>>    driver_probe_device+0xac/0x14c
>>>    __device_attach_driver+0xb8/0x120
>>>    bus_for_each_drv+0x78/0xd0
>>>    __device_attach+0xd8/0x180
>>>    device_initial_probe+0x14/0x20
>>>    bus_probe_device+0x9c/0xa4
>>>    deferred_probe_work_func+0x88/0xc4
>>>    process_one_work+0x288/0x6bc
>>>    worker_thread+0x248/0x450
>>>    kthread+0x118/0x11c
>>>    ret_from_fork+0x10/0x20
>>> irq event stamp: 3599
>>> hardirqs last  enabled at (3599): [<ffff80000919053c>]
>>> _raw_spin_unlock_irqrestore+0x98/0x9c
>>> hardirqs last disabled at (3598): [<ffff800009190ba4>]
>>> _raw_spin_lock_irqsave+0xc0/0xcc
>>> softirqs last  enabled at (3554): [<ffff800008010470>] _stext+0x470/0x5e8
>>> softirqs last disabled at (3549): [<ffff8000080a4514>]
>>> __irq_exit_rcu+0x180/0x1ac
>>> ---[ end trace 0000000000000000 ]---
>>>
>>> I don't see any direct relation between the $subject and the above log,
>>> but reverting the $subject on top of linux next-20220429 hides/fixes it.
>>> Maybe there is a kind of memory trashing somewhere there and your change
>>> only revealed it?
>> Thanks for the report. I think the error path of my patch is wrong - I
>> should not kfree(rpdev->driver_override) from the rpmsg code. That's the
>> only thing I see now...
>>
>> Could you test following patch and tell if it helps?
>> https://pastebin.ubuntu.com/p/rp3q9Z5fXj/
> 
> This doesn't help, the issue is still reported.

I think I screwed this part of code. The new helper uses device_lock()
(the mutexes you see in backtrace) but in rpmsg it is called before
device_register() which initializes the device.

I don't have a device using qcom-smd rpmsg, so it's a bit tricky to
reproduce.

Best regards,
Krzysztof
