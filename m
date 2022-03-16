Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5054DB56A
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Mar 2022 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357395AbiCPP4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Mar 2022 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiCPP4e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Mar 2022 11:56:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944945F4F0;
        Wed, 16 Mar 2022 08:55:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so5077104ejc.9;
        Wed, 16 Mar 2022 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrv4PFSyhAtwnCAL/pjWyzmn6e9Q3pw3qGeeMjVLkWc=;
        b=ThLCeQCLe60XloIENcKZTLtoa92AsszbMGtlE1VP85Nj8ONYeGAtPtd3THFkwuE1R4
         Rb+p8levz1Kkk/esESpsWOOce4y/GAs3zE/h/Iq8JTZadMNMhSzoXuCsi65zQcSj9uj9
         roUu7BL6G2KSrbQdMUcXxa1eBfn7GLPhFdgtrRtKQ1B6XjhvDCk1M6WlSKyn57HnuVDa
         81Zd+YwZwjEFy9IgsZIWqi9+OJ0hcLCs/C3anzU5mAn4GgUA+5ei9x+U8aPDc4PlCURW
         8DQSGQ08z9c9bhp4uK79m+ecf2bqZ6sdte5Pd0FZyKDC2WwgAQ/cfFk5gcysCgAmWYjH
         wmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrv4PFSyhAtwnCAL/pjWyzmn6e9Q3pw3qGeeMjVLkWc=;
        b=jZbVG83EaNe51cfcqEo9zhXvbP0JhZmRa5ZQhstJYLcyw5r96NRrK+Quf/tVffXkRC
         s4KfTzJCbYt6XC3lKngK7Pt9Cg8ORMH9LLnB+SDHbXt9IKMZfKa5bLo1VL9zjdsPtn0H
         SqVNrKJp6hIjfAUDBJh0GMLgbC5PtvvPaXMhe1V+Y+r5o/vZTrbZntfJXz5ZcPvMonlN
         DT22h5wzva3KgO7A9Ms9tGDqMTRKUfhMPkrW+D48QnGLV3u0A8INbVEZ43VF/B4RG5/q
         DCedcz06rkUE02MyfAx2f927LmGrNhCkZnoQRIILqlyw0vy7Jn0wsDzDZ+Ns5lSCSQLi
         jQHw==
X-Gm-Message-State: AOAM532FM1C5NuMF+Jefu/fmEKnWuwFxwfW4y5qzanz2YoWIcBTMkeY7
        lVwHu1j6CbKdJUvidv7pmqkKuZydHQWmUgZOtDA=
X-Google-Smtp-Source: ABdhPJx7tfhflG1OGwg4hJv+lc6fCCCsMyBIcaeP4g7aVOZtvesN3U3Aevmj9sLhxYjH7UWlro+fkCpgMa2F3+GK74E=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr499870ejc.497.1647446118072; Wed, 16
 Mar 2022 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com> <20220316150533.421349-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316150533.421349-2-krzysztof.kozlowski@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Mar 2022 17:54:04 +0200
Message-ID: <CAHp75VeaQdzUKJSKzH9FjbmON5asqH799AS8OzHGoDiRnJifNw@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] driver: platform: Add helper for safer setting
 of driver_override
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

On Wed, Mar 16, 2022 at 5:06 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

...

> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;

> +       if (!dev || !override || !s)
> +               return -EINVAL;

Sorry, I didn't pay much attention on this. First of all, I would drop
dev checks and simply require that dev should be valid. Do you expect
this can be called when dev is invalid? I would like to hear if it's
anything but theoretical. Second one, is the !s requirement. Do I
understand correctly that the string must be always present? But then
how we NULify the override? Is it possible? Third one is absence of
len check. See below.

> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;

I would relax this to make sure we can use it if \n is within this limit.

> +       cp = strnchr(s, len, '\n');
> +       if (cp)
> +               len = cp - s;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);

Here is a word about the len check.

> +       if (!new)

If len == 0, this won't trigger and you have something very
interesting as a result.

One way is to use ZERO_PTR_OR_NULL() another is explicitly check for 0
and issue a (different?) error code.

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
> +       kfree(old);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
