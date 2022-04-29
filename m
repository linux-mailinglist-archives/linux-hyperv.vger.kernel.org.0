Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A5514E49
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377998AbiD2Oyc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377293AbiD2Oyb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 10:54:31 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420D7B562;
        Fri, 29 Apr 2022 07:51:10 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220429145105euoutp02a4ff87d736e062c2b5b8d6949b4a8124~qZYvtOB600645106451euoutp02X;
        Fri, 29 Apr 2022 14:51:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220429145105euoutp02a4ff87d736e062c2b5b8d6949b4a8124~qZYvtOB600645106451euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651243865;
        bh=5YBaHMY3mPIzdSas9KX5dsom+hzeyHCAeOerOpdnlGM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nUygAb0awXyLhsWvbplVvnPEjXFct41EUHXyvcagoZZduuCOiiwbl3paB7Z3NT/3Q
         82B0Qh+kW/mKX0QfGho5StrLqkL+va0m/keORiKtboEXzCjt6tjtcL1fZ18g15k4AD
         B60vtGBDgdRlTfWkIwVZJAghgRNvqBlidfNYJStg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429145104eucas1p1b664d55195f404d0491068056d04f953~qZYvTcF4l1233212332eucas1p1k;
        Fri, 29 Apr 2022 14:51:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F1.AF.10260.85BFB626; Fri, 29
        Apr 2022 15:51:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220429145104eucas1p1b6a251590f370a28b664559a60a3b16b~qZYuz9Sd21955719557eucas1p10;
        Fri, 29 Apr 2022 14:51:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220429145104eusmtrp2af05bf6f42d264c4ddf8aff43c3bcdf0~qZYuwfnSp2710627106eusmtrp2j;
        Fri, 29 Apr 2022 14:51:04 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-43-626bfb583005
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.21.09522.75BFB626; Fri, 29
        Apr 2022 15:51:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220429145102eusmtip2cb3f061d2c2fe5223225a8705c3a0fc9~qZYs5kqVa2214722147eusmtip2R;
        Fri, 29 Apr 2022 14:51:01 +0000 (GMT)
Message-ID: <6e21f7d3-49d0-eda7-7a89-0f8ac69596a4@samsung.com>
Date:   Fri, 29 Apr 2022 16:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v7 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <75b94ccd-b739-2164-bc4a-20025356cc34@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjeuff29sJSuFQZR2aYKcyBiyhDkzMlKosud9ElSwbL5rLNIneU
        tQXWiuAWB9LNuOpYxRngThAE+aggUuVDvinDzhYKiJCKQNzakfA5+RgbNuhaLm78OXme533e
        8z7vyaFwsZX0p+ITjrGqBKlCQnoStXeWerZ+6JTHbLddCEDVlnESWe1OAt3vM2JoXNcBUHGG
        DFlaZwhkXzaSqOVbA0C93KIAaYqqSDRYx6DJfD1AzZM1QuS45joM9kEBOt/aLUSz50YF6OL5
        xyTSPinHUX/DJRJ155tIpOmRIF2hBkenZh8IkZ3LJ1FNUxuGzMMjAOUtXMTRdEc7jtqrh3BU
        UlUpRL9nTgtRabfLl9VRIkAdhiFsXyBzYz6DZG5zI0KmwJDMGPTfk8zwYBPJ/JrjJBjdlTbA
        tOZVCJmbxWnMBVspYL6rXxYy1TP1GNOrlTPzhoD3vA57RsSyivjjrGrbniOest8sOURSkX9q
        5bKVTAfcS1rgQUF6B7zTPyDUAk9KTJcBeGasgeDJAoCNc3qSJ/MADrUWCp63tGmnVgulrkLn
        3xhPZgHMcPS4CEWJ6D3QmO/jbiDoV2HJnIl0YxHtA+/mOgg39qVjYF7LKO7G6+hPYdvDCsyN
        cdoPDjkur+D19E8AXh3fyesWD9jfyrgxSYdB7bR25U4P16gCcy7gPa9ATc3PuDsPpB2eUNtZ
        IORT74cPKrswHq+DE6Zbq/pG+Oz25ZXMkE6EyznhvJwKBycrcB7vhsPWJ6TbgtMhsKphGy9H
        wpKFzNVOL2ib9uETeMGs2mycl0XwzGkx794MOdP1/2a2997DdUDCrXkTbs3u3JpduP/nFgBC
        D/zYZLUyjlWHJ7ApoWqpUp2cEBd6NFFpAK4vb3lq+qselE3MhhoBRgEjgBQuWS9aaJTFiEWx
        0hNfsarEz1TJClZtBC9ThMRPdDT+hlRMx0mPsXKWTWJVz6sY5eGfjmH2vru1nzjnL105YO4N
        LpG/nhaZMRDkrw958+GzoL3hisDG0J25Z8U35YfTwrZsjw5Q+hYuGRKiH0dKTniHGDejEHw0
        YsNHoXMHMpfeoVo2pUSJTmfOL+2a+gFPKbfmF23Kjnxjwt588KT8c0Gmv+3kxoh0s0Yx2Ake
        he1vqj7e+NauH4+kbgis+GK6TpMUfK3ty49rdFRs3eKt7EMBJpPXPcELXads46qgg1QtfPTB
        P85zX/9SrCjt+uYP89nde2dGyrW6q1ujhqO415g/s2R9viqHxdos917esa83pDj5fvD1sfeV
        Y+DdhYy6QzFzyrdzojWcNzVeRjY/fbHcOuCHphYlhFomDduCq9TSfwG+068WYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsVy+t/xe7rhv7OTDCYfMrXYePolm8W5x79Z
        LK5cPMRk8XLCYUaLJU0ZFqf3v2OxePz3EJvFvpZNjBYXZn1jtWhevJ7N4tp2D4vX81YxWux9
        vZXd4slqILHp8TVWi4n7z7JbfOy5x2oxdeIHNouuXyuZLS7vmsNmcXbecTaL5vNKFhMWNjNb
        NH68yW7xeNY8Noutew4wWZy6c5fRYu6XqcwWbw8fZLY4uPEWs8Wy9WvZLR71vWW3WH4WqG7S
        4WWsFoc33WJyUPbY8LmJzWPnrLvsHgs2lXpsWtXJ5nHn2h42jxMzfrN4TFh0gNFj/9w17B6b
        l9R7TL6xnNGjdcdfdo+N73YweVzoyvb4vEkugC9Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Ph6RksBYulKtb+PcfWwDhLrIuRk0NCwETiQNcb
        ti5GLg4hgaWMEo8eX2KBSMhInJzWwAphC0v8udYFVfSeUaK7dR+Qw8HBK2AncWieIEgNi4Cq
        xLJPx9lAbF4BQYmTM5+AzREVSJJ4se05I4gtLBAnceD2GiYQm1lAXOLWk/lMIDNFBKYBLW44
        wwKRuMgpcXlfAsSyvUwSW/9tZwZJsAkYSnS97QLbwAm0eMGpmYwQDWYSXVu7oGx5ieats5kn
        MArNQnLILCQLZyFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA5Lbt2M/NOxjn
        vfqod4iRiYPxEKMEB7OSCO+X3RlJQrwpiZVVqUX58UWlOanFhxhNgaExkVlKNDkfmF7zSuIN
        zQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYpsb6rV6QVS1ZvWhGieA9
        Kc5rk/+U8lRkubZKiRQJ7JTz5zq969OrF4eyhM5rvvR5nGxSvt+Uu/NW++3NuxK0O37W9ti4
        PJm7Z0aZPsuNkmf+oXt9jt+suJdmalzVdHNPqv4RU9MXKrJ905qWx3hr3mjZ2bm5dfpm8ZdP
        qosPp/0qebW4UvvHJS09U8aDV4MyCphbhZZ0XC4oc7P++sJ2wjS2HTfi9R2eJt3UbK95FsB9
        8LDaL9Hs4rt+/Ir9XZGPbC11Ei9ecRK69+fYr8q+V83vVI5rrtHOSj/om5OX4jvtSJPwOUZ5
        6yOeDVMj12wXEHPmiez0v3/P9r9i5udnO9YYyS5mf+ATGZ3wxk2JpTgj0VCLuag4EQDgSxtZ
        9wMAAA==
X-CMS-MailID: 20220429145104eucas1p1b6a251590f370a28b664559a60a3b16b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
        <20220419113435.246203-13-krzysztof.kozlowski@linaro.org>
        <CGME20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9@eucas1p1.samsung.com>
        <870885de-33f3-e0ba-4d56-71c3c993ac87@samsung.com>
        <75b94ccd-b739-2164-bc4a-20025356cc34@linaro.org>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 29.04.2022 16:16, Krzysztof Kozlowski wrote:
> On 29/04/2022 14:29, Marek Szyprowski wrote:
>> On 19.04.2022 13:34, Krzysztof Kozlowski wrote:
>>> The driver_override field from platform driver should not be initialized
>>> from static memory (string literal) because the core later kfree() it,
>>> for example when driver_override is set via sysfs.
>>>
>>> Use dedicated helper to set driver_override properly.
>>>
>>> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
>>> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> This patch landed recently in linux-next as commit 42cd402b8fd4 ("rpmsg:
>> Fix kfree() of static memory on setting driver_override"). In my tests I
>> found that it triggers the following issue during boot of the
>> DragonBoard410c SBC (arch/arm64/boot/dts/qcom/apq8016-sbc.dtb):
>>
>> ------------[ cut here ]------------
>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> WARNING: CPU: 1 PID: 8 at kernel/locking/mutex.c:582
>> __mutex_lock+0x1ec/0x430
>> Modules linked in:
>> CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc4-next-20220429 #11815
>> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> Workqueue: events_unbound deferred_probe_work_func
>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : __mutex_lock+0x1ec/0x430
>> lr : __mutex_lock+0x1ec/0x430
>> ..
>> Call trace:
>>    __mutex_lock+0x1ec/0x430
>>    mutex_lock_nested+0x38/0x64
>>    driver_set_override+0x124/0x150
>>    qcom_smd_register_edge+0x2a8/0x4ec
>>    qcom_smd_probe+0x54/0x80
>>    platform_probe+0x68/0xe0
>>    really_probe.part.0+0x9c/0x29c
>>    __driver_probe_device+0x98/0x144
>>    driver_probe_device+0xac/0x14c
>>    __device_attach_driver+0xb8/0x120
>>    bus_for_each_drv+0x78/0xd0
>>    __device_attach+0xd8/0x180
>>    device_initial_probe+0x14/0x20
>>    bus_probe_device+0x9c/0xa4
>>    deferred_probe_work_func+0x88/0xc4
>>    process_one_work+0x288/0x6bc
>>    worker_thread+0x248/0x450
>>    kthread+0x118/0x11c
>>    ret_from_fork+0x10/0x20
>> irq event stamp: 3599
>> hardirqs last  enabled at (3599): [<ffff80000919053c>]
>> _raw_spin_unlock_irqrestore+0x98/0x9c
>> hardirqs last disabled at (3598): [<ffff800009190ba4>]
>> _raw_spin_lock_irqsave+0xc0/0xcc
>> softirqs last  enabled at (3554): [<ffff800008010470>] _stext+0x470/0x5e8
>> softirqs last disabled at (3549): [<ffff8000080a4514>]
>> __irq_exit_rcu+0x180/0x1ac
>> ---[ end trace 0000000000000000 ]---
>>
>> I don't see any direct relation between the $subject and the above log,
>> but reverting the $subject on top of linux next-20220429 hides/fixes it.
>> Maybe there is a kind of memory trashing somewhere there and your change
>> only revealed it?
> Thanks for the report. I think the error path of my patch is wrong - I
> should not kfree(rpdev->driver_override) from the rpmsg code. That's the
> only thing I see now...
>
> Could you test following patch and tell if it helps?
> https://pastebin.ubuntu.com/p/rp3q9Z5fXj/

This doesn't help, the issue is still reported.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

