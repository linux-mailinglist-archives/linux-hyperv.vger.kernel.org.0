Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E56E4F12DE
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356638AbiDDKRZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiDDKRY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 06:17:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D532F38A;
        Mon,  4 Apr 2022 03:15:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so4175901edi.13;
        Mon, 04 Apr 2022 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/rlqtfSH/+OKtlWbKj/8X8QmPBtgrwTTfh5H/AMmr8=;
        b=M6UB/xq5U2lez0akpMy5cdYkLpWp5TY7avZOr9EOmD3mOmC7LnKWizhrsWVbS9OYXV
         WxZR1L3Zip6LzxkB/OPBaxvuvHRQ+I4ccmh7WVg7layXLF9PfwqQYZ+jlB6EvWgmb6tq
         0lZWCE3uc7LImkbQu2mlfWDe2OdVL/M2gk8b/f83Msuz2BzcI+DWU/n4c03LXmBik2KW
         KbNMC8korkh/nF0C0QAzLDf4TOGpyF8a6IoEG8l74xBIia5wiIab+cBhjD/6K3P9R06b
         EK2dkk2s3pESu8s3Lp5ePedMQzZPflgxpC1RgXqt3TXscJmh/VeMBZJdhbyeZhLuCe4J
         VwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/rlqtfSH/+OKtlWbKj/8X8QmPBtgrwTTfh5H/AMmr8=;
        b=kiRMLuFauMnZZ01SYxJ9sfWlLOwmSagcfxoeWjN5ZuDR+SXbbsRmp/TYxTXxOkVIn5
         Iqhrq8yPTGr+c2dINM2OCjxzfw2xv2EqP0qcIvgiQbXB6CFhupchg7qJS+X0SFW0zi0h
         10z9rSVGKRM9PyU3/WzwV9S1SorXyBZk8owEoeBF5BvRSX1912zRUBp6h+W2B9/APwbd
         D1VBLhGr5Lmpbys4MmvMixIj6/oTkawSZx47oYwBvU0AZnh+RMVs6q3g7ZTZ8tokMIJK
         hXhlcVtD46KCz33aG8ELnbIxXeAfJDYCvDprSuF631kzWu5eMu3BoFQGf+rak9l67Sv2
         LsgA==
X-Gm-Message-State: AOAM532mDF0NxFmVYKAjRun0f+rN1TnS8jOMGtuOqGm86aGKsg3CL7QC
        fBKuXcMCzsvwMkB1Y5qiH18eomqf3gUkvgfkSAFiJObyoq8=
X-Google-Smtp-Source: ABdhPJxh9T+A1Yt+ILwhaxqoZIRZw7XK7bOr8aWn5QI6DqXoAfRnxar+91mJpxHWbEEB8aKP53yR05gviFAyUrKxBls=
X-Received: by 2002:a05:6402:b19:b0:41c:d713:5cba with SMTP id
 bm25-20020a0564020b1900b0041cd7135cbamr2668518edb.270.1649067326747; Mon, 04
 Apr 2022 03:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-2-krzysztof.kozlowski@linaro.org> <CAHp75Vczm9f9Bx_w4nW31cnBgwEzPiN-Eqn-7DKZuB+Hew0F=Q@mail.gmail.com>
 <2976f4f9-4fda-c04f-45cf-351518f88ec0@linaro.org>
In-Reply-To: <2976f4f9-4fda-c04f-45cf-351518f88ec0@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Apr 2022 13:14:22 +0300
Message-ID: <CAHp75Vd-=-unRzQPtpfOs80dN=pDSsBaj=10nwOmmyWE8OqDPg@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 12:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 04/04/2022 11:16, Andy Shevchenko wrote:
> > On Sun, Apr 3, 2022 at 9:38 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:

...

> >> +int driver_set_override(struct device *dev, const char **override,
> >> +                       const char *s, size_t len)
> >> +{
> >> +       const char *new, *old;
> >> +       char *cp;
> >
> >> +       if (!override || !s)
> >> +               return -EINVAL;
> >
> > Still not sure if we should distinguish (s == NULL && len == 0) from
> > (s != NULL && len == 0).
> > Supplying the latter seems confusing (yes, I see that in the old code). Perhaps
> > !s test, in case you want to leave it, should be also commented.
>
> The old semantics were focused on sysfs usage, so clearing is by passing
> an empty string. In the case of sysfs empty string is actually "\n". I
> intend to keep the semantics also for the in-kernel usage and in such
> case empty string can be also "".
>
> If I understand your comment correctly, you propose to change it to NULL
> for in-kernel usage, but that would change the semantics.

Yes. It's also possible to have a wrapper for sysfs use.

> > Another approach is to split above to two checks and move !s after !len.
>
> I don't follow why... The !override and !s are invalid uses. !len is a
> valid user for internal callers, just like "\n" is for sysfs.

I understand but always supplying s maybe an overhead for in-kernel usages.

In any case, it's not critical right now, just a remark that it can be modified.

> >> +       /*
> >> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> >> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> >> +        * Thus we can store one character less to avoid truncation during sysfs
> >> +        * show.
> >> +        */
> >> +       if (len >= (PAGE_SIZE - 1))
> >> +               return -EINVAL;
> >
> > Perhaps explain the case in the comment here?
>
> You mean the case we discuss here (to clear override with "")? Sure.

Yep. Before the below check.

> >> +       if (!len) {
> >> +               device_lock(dev);
> >> +               old = *override;
> >> +               *override = NULL;
> >
> >> +               device_unlock(dev);
> >> +               goto out_free;
> >
> > You may deduplicate this one, by
> >
> >                goto out_unlock_free;
> >
> > But I understand your intention to keep lock-unlock in one place, so
> > perhaps dropping that label would be even better in this case and
> > keeping it
>
> Yes, exactly.
>
> >        kfree(old);
> >        return 0;
> >
> > here instead of goto.
>
> Slightly more code, but indeed maybe easier to follow. I'll do like this.


-- 
With Best Regards,
Andy Shevchenko
