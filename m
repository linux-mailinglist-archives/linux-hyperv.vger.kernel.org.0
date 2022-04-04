Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91F4F11D2
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352759AbiDDJT0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDDJTZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 05:19:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E503B3D4;
        Mon,  4 Apr 2022 02:17:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a6so7579465ejk.0;
        Mon, 04 Apr 2022 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFF6p4tYsR549sWrfv4bnU2v+ruL8I5/W5YzMr/thlg=;
        b=hQlbcki1WeC3gkSnk83L4xArF1FpAwUwcbPIaOMkJlzK+bh9pgMN60HjAqA9G0XpuC
         3Bprvok5U0s7Z1W/ZawyWzSbHo70bfJbRx7oPeBhE/2fGvpn7wCQbZqlvuNGvgHsVjQq
         r/wKFSU7xB5ZHODeRpMa6ErNEopcgryJWjRJjgXQCJkk3liL7jI4iywOC/rM00bXTbtl
         pmNkssVD/iJNe8tAe5q9UEBT+HP+cJeGalWYEIgNn71NWfAeNK0dD/7xSnaeqbeBCKsb
         THPnJ2jW59TDoW+ic9pCzBwfUOBySS1J3o8UfMTFXNWAg/FIQ3SVn0tuGl33QwLfjnUE
         +cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFF6p4tYsR549sWrfv4bnU2v+ruL8I5/W5YzMr/thlg=;
        b=I3AArcNIwFddVXB0NHsRI/yxeAnDM/xpK7wJpTP1jOZAgPr6CJRPO4jMtXEzaOtmcF
         oYuudev5rUTB/NgggQd4jEFFMKo/VbXTMtb78q29qkyBljDcWtIANZNK2fPi7Xlgd3YS
         MuUncrQe1dtRsPyD+03XbmOklLTSkJUXY/WrmMcbuOgNgWOaZIEYRXQjgpt8WjqKVm9o
         JkMvQseHWwStQNhX4sVDWAJ/t/qIXhN75vM2AOpCj1SpX2S0EN+US4F3lB8I6LkBW9oT
         ZoQ0trwWieWmyQwEnSEXWfmNthhOd4upMZ/IwwJaySWNNivlP+F0GKG7TgR67mWODXZc
         Zevg==
X-Gm-Message-State: AOAM533wub4fvBO9TaRLtc6rmd3mrXwzZu78VzM1TnNr1MzwFl5bjYco
        +kXmmE1UZvxcV0y9CJUj5ZnAmYpEFXYYLveSBGc=
X-Google-Smtp-Source: ABdhPJztVV4vk0bsoiQVYou423ZyvJCH+cGZa4t4gBoSJScuWRUyyZG1JPNItw+pyflHlcb4ktsJ/PrqzuCd6UZZVuc=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr10112344ejc.44.1649063847683; Mon, 04
 Apr 2022 02:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org> <20220403183758.192236-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220403183758.192236-2-krzysztof.kozlowski@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Apr 2022 12:16:23 +0300
Message-ID: <CAHp75Vczm9f9Bx_w4nW31cnBgwEzPiN-Eqn-7DKZuB+Hew0F=Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] driver: platform: Add helper for safer setting
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

On Sun, Apr 3, 2022 at 9:38 PM Krzysztof Kozlowski
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

...

> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;

> +       if (!override || !s)
> +               return -EINVAL;

Still not sure if we should distinguish (s == NULL && len == 0) from
(s != NULL && len == 0).
Supplying the latter seems confusing (yes, I see that in the old code). Perhaps
!s test, in case you want to leave it, should be also commented.

Another approach is to split above to two checks and move !s after !len.

> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;

Perhaps explain the case in the comment here?

> +       if (!len) {
> +               device_lock(dev);
> +               old = *override;
> +               *override = NULL;

> +               device_unlock(dev);
> +               goto out_free;

You may deduplicate this one, by

               goto out_unlock_free;

But I understand your intention to keep lock-unlock in one place, so
perhaps dropping that label would be even better in this case and
keeping it

       kfree(old);
       return 0;

here instead of goto.

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
> +               kfree(new);
> +               *override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +out_free:
> +       kfree(old);
> +
> +       return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko
