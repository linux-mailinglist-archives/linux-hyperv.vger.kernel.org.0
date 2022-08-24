Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91D5A014C
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Aug 2022 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiHXSX5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Aug 2022 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbiHXSXz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Aug 2022 14:23:55 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF5E796B6;
        Wed, 24 Aug 2022 11:23:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id m2so5934337qvq.11;
        Wed, 24 Aug 2022 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yK26ITzqXq21qe37kX2FSO/m5ELFXUKoDF4JXVSf2Yk=;
        b=MvM8l4jybyLdDHdEzRIMNyw4AOmrePmypzWB/zttf9T0J7PG9J4Wx7dBNTuzVXoDk6
         Pts/G2fqgF/JQaMqB8fJCMqJ+beuAsVHD6sSwZSkmpwHWjs16E2IT4XNIe6Q6fgb30Zs
         ZcGIpsoNniM9EIH/+Zb37nJErUfqlUsOccOHh0uSZMEY0dSlyAXKjLqlO75Yqdtv7OO1
         dYCSyGktFrnrMS7HOVtlvTOS/XCbqoto8P5Sqf35hN1TiAKL6A/vNI3F+nGX8XYj/qRm
         v0nFEnMlNMqnOzVrB+gBsvrsuai6QZJ7YhzoDyRlAbIr6vHxT20Zg8tQelGuhq4BeT5z
         iqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yK26ITzqXq21qe37kX2FSO/m5ELFXUKoDF4JXVSf2Yk=;
        b=ew9wNes9zgcyGDsrd9Bi5eQkrcA/8ts6AbnCGm2s70xB4jHBeqa7W8sd89pDIeu4ni
         0kQjTxsT6Kr/pmoRhJBNYNF9t2tHzFre8+a/zev+qyeMUtz/jJiOeIgQwhyquGxk/rxH
         vCSqCT6gPXnlBS5xODD1yH7QLVBrHtaGS/qvfgEegPBboL9iU/OhsqrPSXyvO8ONTbYU
         uWmm0Pi/DRMUicCK8RzGy+tRxV26S1KJ6qwEu4UTZ61fj9FeukNgyQteQQOgkBfLC6YA
         4whmgZyiQirpwur0//6LYLmBBSYNjWN4GUplGGvjhioFLIy4P532lEiy6q16+eFWsO23
         +chw==
X-Gm-Message-State: ACgBeo1mIcw8u4OkCzInhBa79wJxYpkEWa69GAeKXIONalRajjGPESHV
        k2dXehjKwsFSnqdhqVbuCyZM91nFx3GNbXlw/FU=
X-Google-Smtp-Source: AA6agR7WR+Chq5aALN21nOJ8KtaVCyeyYnWxi+FloTWgbk+pFsOcnv1Pvt3w71jsFBNxphNxwDKQxBn+Vf6P77yzICI=
X-Received: by 2002:ad4:4eaf:0:b0:496:ac46:2d9c with SMTP id
 ed15-20020ad44eaf000000b00496ac462d9cmr345077qvb.82.1661365432794; Wed, 24
 Aug 2022 11:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <12036348.O9o76ZdvQC@kreacher> <2196460.iZASKD2KPV@kreacher> <5857822.lOV4Wx5bFT@kreacher>
In-Reply-To: <5857822.lOV4Wx5bFT@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 21:23:16 +0300
Message-ID: <CAHp75VcjxUjH4p_NOEQjOuFO8LcSdUU_stEvfWvtbQc8hfud0w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 24, 2022 at 8:13 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The parent field in struct acpi_device is, in fact, redundant,
> because the dev.parent field in it effectively points to the same
> object and it is used by the driver core.
>
> Accordingly, the parent field can be dropped from struct acpi_device
> and for this purpose define acpi_dev_parent() to retrieve a parent
> struct acpi_device pointer from the dev.parent field in struct
> acpi_device.  Next, update all of the users of the parent field
> in struct acpi_device to use acpi_dev_parent() instead of it and
> drop it.
>
> While at it, drop the ACPI_IS_ROOT_DEVICE() macro that is only used
> in one place in a confusing way.
>
> No intentional functional impact.

Side note: Should we not convert these to use acpi_dev_parent()?

https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/acpi/property.c#L1271
https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/bus/hisi_lpc.c#L397

-- 
With Best Regards,
Andy Shevchenko
