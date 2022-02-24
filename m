Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C54C248D
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiBXHrf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 02:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiBXHrd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 02:47:33 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C77487B
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 23:47:03 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78A2C3FCAA
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Feb 2022 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645688822;
        bh=FxOVZjnNiVO0i9jH0i6UiovfwrDBwVKl5GL2sYOaVX4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YhVaA7UJN9z4b3F6vAxLvYQrYGK1yoJIwMtX41LJ3QgHsSXs2eEv2D88Qev+Ydlyu
         qijFV9K7FipVkQ9+uQtmdAqgLSe/LxXdrI7RiuwoRSbCU9n1GpgPyJXHoJx8grMMkj
         nYERX6Mkoc7dxGiIL32SGRtGA2Ja8HYLWq8hO+KIEA+S9cHbs218NIlkpbEA4hkT7n
         gG3OGy4tTpDeoxo37caay+Epi4DMIRqCOMXXv5u5RAvzHGj3+D4nLW2IuHVKne5NgY
         SP44lm2LDFnjLeuu+cElG0LKuJN7dCa0oHcTsAfX4IUINATVCd3h8L3fJBrZv4X8/J
         qLSi6Qn8hJ16Q==
Received: by mail-ej1-f71.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo816058ejc.3
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 23:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FxOVZjnNiVO0i9jH0i6UiovfwrDBwVKl5GL2sYOaVX4=;
        b=u5Mu4b/IzUhDQeh7bLf/0N12W9U3k4cf0dlfd/B5egDyGCn6HQ0XerNKrQHMTZy1de
         FUIleF1dJCXxfO2YDiNukd5GigyKu25Ip7p+aPNHCEFFc6r7kejqa5Yu5z3i58fJ3cNt
         YFoFP6fiG+FA8bzPBVoHgY3ZNipi9MsuCSJ+Id5/0ydUyVIUhVQloTqEPRvogikH6s2G
         Z3DHcu33vLyECb43TCaKcBnP2i32y+sp7ZPGmMDakl9RbTRtIvqkQTEPhiYpDxsk9NQ2
         +DJb9cg7EzKe9YqhGcZ5AWz9yFgCUjttQMLYpOSa79vaUHXIxoLdsja2aj4ahYD0ujfz
         gbCw==
X-Gm-Message-State: AOAM533i9Egz0POkTY/eQA/10OSuI3exuLt2sLKBQUAj11XS/Z78QEY8
        kqGf27hMp8O/2zx47iIMeXly1iWIVIn+RW1GwZHJTt7IKcLZnuamq1dmc4nfqyZXjmttk/gaBk5
        p3IcrO+qFuuOaMAJSKlzf6IApjAiJgBX9NZUP6SpAiQ==
X-Received: by 2002:a17:907:365:b0:6d1:bf9:9164 with SMTP id rs5-20020a170907036500b006d10bf99164mr1290200ejb.598.1645688811410;
        Wed, 23 Feb 2022 23:46:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyF2QxOV5sZ3l9SN1ANQlm/aYyNKUMNdm1sWIKjHtTsjqFzwsoCzjjUbc5J7jIvGVZuZRXOYQ==
X-Received: by 2002:a17:907:365:b0:6d1:bf9:9164 with SMTP id rs5-20020a170907036500b006d10bf99164mr1290164ejb.598.1645688811188;
        Wed, 23 Feb 2022 23:46:51 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id t24sm914666ejx.187.2022.02.23.23.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 23:46:50 -0800 (PST)
Message-ID: <3e4f387b-53fb-b031-223c-88adac7d4dae@canonical.com>
Date:   Thu, 24 Feb 2022 08:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 01/11] driver: platform: add and use helper for safer
 setting of driver_override
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
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
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191310.347669-2-krzysztof.kozlowski@canonical.com>
 <20220223162538-mutt-send-email-mst@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223162538-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 23/02/2022 22:33, Michael S. Tsirkin wrote:
> On Wed, Feb 23, 2022 at 08:13:00PM +0100, Krzysztof Kozlowski wrote:
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
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/base/driver.c           | 44 +++++++++++++++++++++++++++++++++
>>  drivers/base/platform.c         | 24 +++---------------
>>  include/linux/device/driver.h   |  1 +
>>  include/linux/platform_device.h |  6 ++++-
>>  4 files changed, 54 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index 8c0d33e182fd..79efe51bb4c0 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -30,6 +30,50 @@ static struct device *next_device(struct klist_iter *i)
>>  	return dev;
>>  }
>>  
>> +/*
>> + * set_driver_override() - Helper to set or clear driver override.
>> + * @dev: Device to change
>> + * @override: Address of string to change (e.g. &device->driver_override);
>> + *            The contents will be freed and hold newly allocated override.
>> + * @s: NULL terminated string, new driver name to force a match, pass empty
> 
> Don't you mean NUL terminated?

Yeah, NUL.

> Do all callers really validate that it's NUL terminated?

Good point, the callers use it in device attributes (sysfs) only, so it
might come non-NUL. Previously this was solved by kstrndup() which is
always terminating the string.


> 
>> + *     string to clear it
>> + *
>> + * Helper to setr or clear driver override in a device, intended for the cases
> 
> set?
D'oh!

> 
>> + * when the driver_override field is allocated by driver/bus code.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int driver_set_override(struct device *dev, char **override, const char *s)
>> +{
>> +	char *new, *old, *cp;
>> +
>> +	if (!dev || !override || !s)
>> +		return -EINVAL;
>> +
>> +	new = kstrndup(s, strlen(s), GFP_KERNEL);
> 
> 
> what's the point of this kstrndup then? why not just kstrdup?

Thanks, it's a copy-paste. Useless now, but I'll pass the count directly
from the callers and then this will be NULL-terminating it.

> 
>> +	if (!new)
>> +		return -ENOMEM;
>> +
>> +	cp = strchr(new, '\n');
>> +	if (cp)
>> +		*cp = '\0';
>> +
>> +	device_lock(dev);
>> +	old = *override;
>> +	if (strlen(new)) {
> 
> We are re-reading the string like 3 times here.

Yep, the same in old code. I guess we could compare just pointers -
whether 'cp' is not NULL and different than 's'.

> 
>> +		*override = new;
>> +	} else {
>> +		kfree(new);
>> +		*override = NULL;
>> +	}
>> +	device_unlock(dev);
>> +
>> +	kfree(old);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(driver_set_override);
>> +
>>  /**
>>   * driver_for_each_device - Iterator for devices bound to a driver.
>>   * @drv: Driver we're iterating.
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 6cb04ac48bf0..d8853b32ea10 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -1275,31 +1275,15 @@ static ssize_t driver_override_store(struct device *dev,
>>  				     const char *buf, size_t count)
>>  {
>>  	struct platform_device *pdev = to_platform_device(dev);
>> -	char *driver_override, *old, *cp;
>> +	int ret;
>>  
>>  	/* We need to keep extra room for a newline */
>>  	if (count >= (PAGE_SIZE - 1))
>>  		return -EINVAL;
> 
> Given everyone seems to repeat this check, how about passing
> in count and doing the validation in the helper?

Good idea.

> We will then also avoid the need to do strlen and strchr.

The strlen() could be removed, but the strchr() should stay. What
solution do you have in mind to remove strchr()?

Thanks for review.


Best regards,
Krzysztof
