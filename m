Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CA4DA1D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350863AbiCOSCY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Mar 2022 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbiCOSCY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Mar 2022 14:02:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329D58E6E;
        Tue, 15 Mar 2022 11:01:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h13so25237638ede.5;
        Tue, 15 Mar 2022 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9egEby/kGDQx/H2AywacJdMEq9UWb27T57iBP6MKY/M=;
        b=X459zaz8rBpHmz1eWRM/nXKPoCcWwgv93mgo1kUIqKJmmrFSVbFmtlBkSyc7oZbqEA
         9iE/wpN2ldzWFyDARevE8q4aWwftUcTWrj/hZGCp5c/nWOErfTWiotj502O2E3wRub8x
         fAvwgbWwEpPPMZKlHleAIZ5b3NuCDHQaUCu3o6zMz3Pk9oBOWUhxp7FqU8z4OYlvff33
         vjwTCIZda48THwgM2za8HjIs/dPh3/+wx8u7uUvYGGau/xbCmqh8QSdYU72RKq3dM+TV
         7s/9EfIhX6BorS0N3xa1MT7AdVO4JDq0rPwvec+a1/gkrmCnUuEgVF5WsgvwobwSbCSf
         ZFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9egEby/kGDQx/H2AywacJdMEq9UWb27T57iBP6MKY/M=;
        b=XzfM2y1/piwXOHyvUJCRTcLMyV5F25NwyAJ3OpzE3GPeEYCL6U9QtqD23JMPJV0Dlm
         7Cd9roX0kyKTR3QEyPNBz7P1CTQQdguanEMw4FSfhmX7UWjfUgLeQiCFa+zIQZPXBRbP
         fVruSaKpdK9Nj2pQUqrEVlgMh/AZYNyEU8/ABFX10M8ukj2vAlNcIGthtma/HVPMpqFG
         eqHaWFywtWxx7W7kKn/3gr//Ca7cgl6MKQVOIjdnR0sT7WwYJmwA+p+LxEmrnryMr8zr
         3zGqTbm/cgWVzJypTcsv1YoAaYPodndYKENU1w65gMnmadBR4NPRWrr/poSTTz9kAVwH
         +/lQ==
X-Gm-Message-State: AOAM530LkyqLKpknuIcsqFSJWgP9d+kI2fTmX20AJM3dDQJS36PD0aSm
        M3ETKmWVYbHCuaFa4FQN0K7Dpq3rsDCIzIWhgY0=
X-Google-Smtp-Source: ABdhPJz09b9Fm75ixFJtzUGUkS6dUid3EAUCrWF+jfN6zd2zyejpSwybW8/2BkPFf2PjWP6mgqXTNKVgn2eTNF92NTk=
X-Received: by 2002:a05:6402:3589:b0:416:7de7:cdde with SMTP id
 y9-20020a056402358900b004167de7cddemr26440456edc.218.1647367269998; Tue, 15
 Mar 2022 11:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com> <20220312132856.65163-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220312132856.65163-2-krzysztof.kozlowski@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Mar 2022 19:59:56 +0200
Message-ID: <CAHp75Vd6yu0OA6wYvPVs8J1wRDPyb6tCYXOjp9poweJd0sfPcw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] driver: platform: Add helper for safer setting
 of driver_override
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 12, 2022 at 5:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.
>
> However such assumption is not documented, there were in the past and
> there are already users setting it to a string literal. This leads to
> kfree() of static memory during device release (e.g. in error paths or
> during unbind):
>
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)

>     (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
>     (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
>     (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

I believe you may remove these three.

> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce amount of

the amount

> duplicated code.

> Convert the platform driver to use new helper and make the

a new

> driver_override field const char (it is not modified by the core).

...

> +/**
> + * driver_set_override() - Helper to set or clear driver override.
> + * @dev: Device to change
> + * @override: Address of string to change (e.g. &device->driver_override);
> + *            The contents will be freed and hold newly allocated override.
> + * @s: NUL terminated string, new driver name to force a match, pass empty

NUL-terminated? (44 vs 115 occurrences)

> + *     string to clear it
> + * @len: length of @s
> + *
> + * Helper to set or clear driver override in a device, intended for the cases
> + * when the driver_override field is allocated by driver/bus code.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;
> +
> +       if (!dev || !override || !s)
> +               return -EINVAL;
> +
> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       cp = strchr(new, '\n');
> +       if (cp)
> +               *cp = '\0';

AFAIU you may reduce memory footprint by

cp = strnchr(new, len, '\n');
if (cp)
  len = s - cp;

new = kstrndup(...);

> +       device_lock(dev);
> +       old = *override;
> +       if (cp != new) {
> +               *override = new;
> +       } else {
> +               kfree(new);
> +               *override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
