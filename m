Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1E4C6A7F
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiB1Lbb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiB1Lba (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 06:31:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70051E47
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Feb 2022 03:30:51 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 772404031B
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Feb 2022 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646047849;
        bh=TqoJaizFHWK8/heI0IG9vgkdj098BV5WNR7J8iP/dOc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oP1dduqvIsPl+g7c1mWdFXOsn57WzlWlKJSlK2vB/F8dGZlWSYiqbynW7VtvSGz6s
         FRS6RiQua6+GdlOU0GEq9qdgq55H2k7IRSgWaatQoEYTeVkEO8qLABXEE9jme8AW1B
         UDoZLDuGg801DmAFpyXyKQmpTZVZrApkDNVDPOjhZ9djVrR4niU0QUkO0xYNPeztSC
         zjJALxFMNF58CehCpA48m11gU0jNrOHUYGOcK4KaQUHs736d7VKonZpyTJullp61l/
         oHxSYuQW4X1ActxDb0AktqyEIqiKdKJakPhDnX93kCc+RP4Zmjtg7EZFpuiq4WNgRU
         oJKDIgEu2DqjA==
Received: by mail-ed1-f72.google.com with SMTP id x22-20020a05640226d600b0041380e16645so3790735edd.8
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Feb 2022 03:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TqoJaizFHWK8/heI0IG9vgkdj098BV5WNR7J8iP/dOc=;
        b=19pCXdpLQvguEfHyPsWw9DLGuLiq7yQftEEIEvw+VRXtpzI1DfOipVQ1Fg3g1pfwgc
         HVpFIdqye8BaTM3iWW+Sxexp6bsYgDSrKu7T2pZoioV3hs8QdgCCERINoeiiVLMyrX5Q
         7okAAtxzDlzotH0EM+rwpMxntvFpEMdX6/OxMaugmig67Ao0bhZzBQij4/HL9tiZ5YO2
         f0geVPfSP6wY9ypEZKIXFCknstJD40uYtInwLyWZxByaC3DcstEPtnKJ3trxgCV/BlRM
         cS0+mVjRp7EydWxMJ/01sMCiVGSvbx9qgylg2o5AyurlNHoluCFgfu2Dg//MWEAkxEdK
         YVLQ==
X-Gm-Message-State: AOAM532Vt1CO8mj3zXElkM3bj/Q4A2eZy08hxwlYojP+RQDoCF6lrMbR
        a+yiLf9uMFOhGxvvqxph24xO+tGe/CtTPX6Y9GxYy/GL3yfonbbJJyP3uB22VD5RzM4o6K4VnHM
        ZNxslrASVFg0auJJBlNn1v/+3py5vR/XWU7Qw05UHCw==
X-Received: by 2002:a17:906:69ce:b0:6a7:8c03:3caa with SMTP id g14-20020a17090669ce00b006a78c033caamr14869872ejs.335.1646047848634;
        Mon, 28 Feb 2022 03:30:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8wXt+PKUVmt9ZYqUS8EzsJUeRWG5FxAFTct2htJDic6wAfCk0sPsop3G0sa4LoCQVSlMP6w==
X-Received: by 2002:a17:906:69ce:b0:6a7:8c03:3caa with SMTP id g14-20020a17090669ce00b006a78c033caamr14869844ejs.335.1646047848374;
        Mon, 28 Feb 2022 03:30:48 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id cc21-20020a0564021b9500b00403bc1dfd5csm6063924edb.85.2022.02.28.03.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:30:47 -0800 (PST)
Message-ID: <b428f7b0-9f3e-466c-9386-9f72f13ebbd0@canonical.com>
Date:   Mon, 28 Feb 2022 12:30:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
 <YhypTr5754yK9WGi@abelvesa>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YhypTr5754yK9WGi@abelvesa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 28/02/2022 11:51, Abel Vesa wrote:
> On 22-02-27 14:52:04, Krzysztof Kozlowski wrote:
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
>>     (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
>>     (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
>>     (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>>
>> Provide a helper which clearly documents the usage of driver_override.
>> This will allow later to reuse the helper and reduce amount of
>> duplicated code.
>>
>> Convert the platform driver to use new helper and make the
>> driver_override field const char (it is not modified by the core).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/base/driver.c           | 51 +++++++++++++++++++++++++++++++++
>>  drivers/base/platform.c         | 28 +++---------------
>>  include/linux/device/driver.h   |  2 ++
>>  include/linux/platform_device.h |  7 ++++-
>>  4 files changed, 63 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index 8c0d33e182fd..353750b0bbc5 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -30,6 +30,57 @@ static struct device *next_device(struct klist_iter *i)
>>  	return dev;
>>  }
>>  
>> +/**
>> + * driver_set_override() - Helper to set or clear driver override.
>> + * @dev: Device to change
>> + * @override: Address of string to change (e.g. &device->driver_override);
>> + *            The contents will be freed and hold newly allocated override.
>> + * @s: NUL terminated string, new driver name to force a match, pass empty
>> + *     string to clear it
>> + * @len: length of @s
>> + *
>> + * Helper to set or clear driver override in a device, intended for the cases
>> + * when the driver_override field is allocated by driver/bus code.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int driver_set_override(struct device *dev, const char **override,
>> +			const char *s, size_t len)
> 
> TBH, I think it would make more sense to have this generic
> driver_set_override receive only the dev and the string. And then,
> each bus type will have their own implementation that handle things
> their own way. This would allow all the drivers that will use this to
> do something like this:
> 
> 	ret = driver_set_override(&pdev->dev, "override_string");
> 
> I think it would look more cleaner.
> 

The interface in general is not for the drivers. Drivers use it in
exceptions (few cases in entire kernel) but many times they actually do
not need to.

Adding a dedicated driver_set_override() brings intention that such
usage is welcomed... but it's not. :)


Best regards,
Krzysztof
