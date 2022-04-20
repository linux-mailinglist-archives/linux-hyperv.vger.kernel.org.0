Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEAC508E26
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Apr 2022 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380955AbiDTRPs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Apr 2022 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380918AbiDTRPr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Apr 2022 13:15:47 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BA4578F;
        Wed, 20 Apr 2022 10:12:59 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id r189so4067669ybr.6;
        Wed, 20 Apr 2022 10:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ASIWAo0HytBTKR5fLcMLGJJVl7MsnssiA8AeEXSjEM=;
        b=5AqwjLuC7iGEN7nUuMBVNi0hJCU8/mG5z+y0WMduVsnNvQWMvn8DCjbDd8mRCfldDu
         xOT0qpG1/wAWTrt4RIHkceY33Zhk2+xceQaYubMlX82yphuJKgT9lBrFYt3QbIR8rwC/
         TIMCVzT50dDnY1sjk/3KvBe/hTNmigvi+hTRrX2rsmpSHtcP0WB0aDAjAZNfasak5Had
         F6JoJNLBU06nxWbT5a028vhGjtNpKIoBfOvixnNl1z5mRkBBIPQTAt5sgpCaDzeGILJ5
         gTHeZ8T1j3q74owDJXg0EzMRF7IvP+wqRnhSiawrU5l2Bo2UQ2+0MF8Y6WMdOJOeEFDq
         qX1w==
X-Gm-Message-State: AOAM533wLCYbFFPPJ5Twf/Qe3Mi/eSTjJoTfaN0vUojmIqgeOvRC7iFG
        QIMFQeJq9Ou7qt+jgsefXzQDWr4CqPMxKuCDpLg5t/CkNmk=
X-Google-Smtp-Source: ABdhPJygxTqwH/fYP8f9/TOx3wegsu6FxX5O1kN/quLL9EMh/cabSnVGqayxP5pVJxnDK33VgIW6Cm39TvZfF3wMYBU=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr20887561ybg.482.1650474779115; Wed, 20
 Apr 2022 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org> <20220419113435.246203-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419113435.246203-2-krzysztof.kozlowski@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 19:12:48 +0200
Message-ID: <CAJZ5v0ijsLvgeN5y+T1D+iLAkYEOiSTPd0+m5_GMpBnVuqEOKA@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] driver: platform: Add helper for safer setting
 of driver_override
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 19, 2022 at 1:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
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
>
> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce the amount of
> duplicated code.
>
> Convert the platform driver to use a new helper and make the
> driver_override field const char (it is not modified by the core).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/base/driver.c           | 69 +++++++++++++++++++++++++++++++++
>  drivers/base/platform.c         | 28 ++-----------
>  include/linux/device/driver.h   |  2 +
>  include/linux/platform_device.h |  6 ++-
>  4 files changed, 80 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 8c0d33e182fd..1b9d47b10bd0 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -30,6 +30,75 @@ static struct device *next_device(struct klist_iter *i)
>         return dev;
>  }
>
> +/**
> + * driver_set_override() - Helper to set or clear driver override.
> + * @dev: Device to change
> + * @override: Address of string to change (e.g. &device->driver_override);
> + *            The contents will be freed and hold newly allocated override.

I would stick to one-line description here and possibly expand them in
the body of the comment.

Regardless, I think that the series is an improvement, so please feel
free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch and

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the other patches in the series.

> + * @s: NUL-terminated string, new driver name to force a match, pass empty
> + *     string to clear it ("" or "\n", where the latter is only for sysfs
> + *     interface).
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
> +       if (!override || !s)
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
> +       if (!len) {
> +               /* Empty string passed - clear override */
> +               device_lock(dev);
> +               old = *override;
> +               *override = NULL;
> +               device_unlock(dev);
> +               kfree(old);
> +
> +               return 0;
> +       }
> +
> +       cp = strnchr(s, len, '\n');
> +       if (cp)
> +               len = cp - s;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       device_lock(dev);
> +       old = *override;
> +       if (cp != s) {
> +               *override = new;
> +       } else {
> +               /* "\n" passed - clear override */
> +               kfree(new);
> +               *override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(driver_set_override);
> +
>  /**
>   * driver_for_each_device - Iterator for devices bound to a driver.
>   * @drv: Driver we're iterating.
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8cc272fd5c99..b684157b7f2f 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1275,31 +1275,11 @@ static ssize_t driver_override_store(struct device *dev,
>                                      const char *buf, size_t count)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
> -       char *driver_override, *old, *cp;
> -
> -       /* We need to keep extra room for a newline */
> -       if (count >= (PAGE_SIZE - 1))
> -               return -EINVAL;
> -
> -       driver_override = kstrndup(buf, count, GFP_KERNEL);
> -       if (!driver_override)
> -               return -ENOMEM;
> -
> -       cp = strchr(driver_override, '\n');
> -       if (cp)
> -               *cp = '\0';
> -
> -       device_lock(dev);
> -       old = pdev->driver_override;
> -       if (strlen(driver_override)) {
> -               pdev->driver_override = driver_override;
> -       } else {
> -               kfree(driver_override);
> -               pdev->driver_override = NULL;
> -       }
> -       device_unlock(dev);
> +       int ret;
>
> -       kfree(old);
> +       ret = driver_set_override(dev, &pdev->driver_override, buf, count);
> +       if (ret)
> +               return ret;
>
>         return count;
>  }
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 15e7c5e15d62..700453017e1c 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -151,6 +151,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
>  extern void driver_remove_file(struct device_driver *driver,
>                                const struct driver_attribute *attr);
>
> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len);
>  extern int __must_check driver_for_each_device(struct device_driver *drv,
>                                                struct device *start,
>                                                void *data,
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7c96f169d274..582d83ed9a91 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -31,7 +31,11 @@ struct platform_device {
>         struct resource *resource;
>
>         const struct platform_device_id *id_entry;
> -       char *driver_override; /* Driver name to force a match */
> +       /*
> +        * Driver name to force a match.  Do not set directly, because core
> +        * frees it.  Use driver_set_override() to set or clear it.
> +        */
> +       const char *driver_override;
>
>         /* MFD cell pointer */
>         struct mfd_cell *mfd_cell;
> --
> 2.32.0
>
