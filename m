Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086F85A0164
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Aug 2022 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiHXSep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Aug 2022 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbiHXSem (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Aug 2022 14:34:42 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E07A515;
        Wed, 24 Aug 2022 11:34:40 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33db4e5ab43so1368647b3.4;
        Wed, 24 Aug 2022 11:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0fJKE51ZwEoPTaUMc8JUaf3dO19a2GBvZUGjA8lc9aM=;
        b=ZwAmpYJALVf29JVgH/ycyVZHqUcyuoaZ6sYEDbMsahFUFuGFpzyCXTn0WU5ndQ/tpA
         mq5tv9ClbV+js8SHHUsqFNeWqmvIafm3M/Ne2avIuO31a6Mdjppt0a56ys2i/J/1QXO2
         q2L/XFYyja+gUKO3GxH6imB/nQfSIj9ayY4MFNJii5HDYlyxN5FYHo6qOIhzbDDTQEDS
         hcd7drI46ljsW6UPWFvRx3nSn7Eskf2+CRT9/1OlEHbx1m+pKVdVhpEEk5fW0y2+G1Qs
         SMOFt3fl3Dwivwj4jaPzWwEAfnQrQSArFq9Gc9Eb9c9vQfxt/4ydt+6YoS2WAJJ0Gynq
         hJZQ==
X-Gm-Message-State: ACgBeo0G1FhTBOxPa//btogDVvolGNl9lEfsd9goR8xGd1h31cINtu9S
        Z7nHOAhI1DcMxjNxdvU1ZpAgMfV/386trPfSKdo=
X-Google-Smtp-Source: AA6agR5aJcrYwH49iHESjxTPAWqPBe0D8n9Ip5MMV3jUkGvXtNya+iOVTI3qvJUxh/NHkFav+oANxQPheMLPeXRe+wM=
X-Received: by 2002:a25:664a:0:b0:695:e7cc:9a20 with SMTP id
 z10-20020a25664a000000b00695e7cc9a20mr415847ybm.153.1661366079973; Wed, 24
 Aug 2022 11:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <12036348.O9o76ZdvQC@kreacher> <2196460.iZASKD2KPV@kreacher>
 <5857822.lOV4Wx5bFT@kreacher> <CAHp75VcjxUjH4p_NOEQjOuFO8LcSdUU_stEvfWvtbQc8hfud0w@mail.gmail.com>
In-Reply-To: <CAHp75VcjxUjH4p_NOEQjOuFO8LcSdUU_stEvfWvtbQc8hfud0w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 20:34:28 +0200
Message-ID: <CAJZ5v0hm8NszTDsq-KJ4iO452WZ7C7u4ufbfTDdFXX9YnXmTDw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 24, 2022 at 8:23 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 24, 2022 at 8:13 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The parent field in struct acpi_device is, in fact, redundant,
> > because the dev.parent field in it effectively points to the same
> > object and it is used by the driver core.
> >
> > Accordingly, the parent field can be dropped from struct acpi_device
> > and for this purpose define acpi_dev_parent() to retrieve a parent
> > struct acpi_device pointer from the dev.parent field in struct
> > acpi_device.  Next, update all of the users of the parent field
> > in struct acpi_device to use acpi_dev_parent() instead of it and
> > drop it.
> >
> > While at it, drop the ACPI_IS_ROOT_DEVICE() macro that is only used
> > in one place in a confusing way.
> >
> > No intentional functional impact.
>
> Side note: Should we not convert these to use acpi_dev_parent()?
>
> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/acpi/property.c#L1271
> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/bus/hisi_lpc.c#L397

That can be done later, but thanks for the pointers!
