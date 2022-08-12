Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0C45912D1
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Aug 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiHLPPF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Aug 2022 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbiHLPO6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Aug 2022 11:14:58 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D67A7A81;
        Fri, 12 Aug 2022 08:14:57 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id l22so1522314wrz.7;
        Fri, 12 Aug 2022 08:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EoiVDV1BpkQyac6N0M+0zVwSj3WK1AdJP/ntOJZkbiI=;
        b=y+C6TXoGy+311Sk25HndUdD8oAFpkGvgecJybzjCxB2DZEJQOrZkmUmsuPiqCI7MYK
         nSygq/qCXeJkAetWuNZmVuqOLpfhIkZiyi0PUksGqaPvRgPGMfD10an0EY1LnHsiXQo3
         O3MX5M+fD8ovdchs7GRBFr/RjXfv9rE6CclRf8ZPdwZZaUuagAc1rHUclt2hzaABqtgV
         0DxTl0Fku6UTlBwX4KzWQb/yr0gAf2i6NiI1nzzKmlpxYe/1XLlsSFgdZ9rMt22tu9qo
         66s+eu6aVCvbHc7D2a0LxigsTFTjugt752viL8GosJrhBi95OmTwhQLQb8GaCWykYqH+
         4V5w==
X-Gm-Message-State: ACgBeo3nSzT4v8Au/HSgM27ms/en+vyPUdFXUwwqxZ0TRMQD9/M4YbuF
        uRzVSSMdxMhAvLRLVTR7DZDdfh1pZ9g=
X-Google-Smtp-Source: AA6agR67pF4bd0Gg+R7FFH9Fs1c0QAkU7YjmSu0wWkZPvc1aU+z3yNTU4l0akoiHi1cnVXOTwkrsNw==
X-Received: by 2002:a05:6000:18a3:b0:21f:d6a4:1aec with SMTP id b3-20020a05600018a300b0021fd6a41aecmr2444780wri.468.1660317296338;
        Fri, 12 Aug 2022 08:14:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h41-20020a05600c49a900b003a5260b8392sm3938969wmp.23.2022.08.12.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:14:56 -0700 (PDT)
Date:   Fri, 12 Aug 2022 15:14:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
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
        linux-hyperv@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 5/5][RFT] ACPI: Drop parent field from struct
 acpi_device
Message-ID: <20220812151454.fqt2gknsoqjco4mz@liuwe-devbox-debian-v2>
References: <12036348.O9o76ZdvQC@kreacher>
 <2196460.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2196460.iZASKD2KPV@kreacher>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 10, 2022 at 06:23:05PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The parent field in struct acpi_device is, in fact, redundant,
> because the dev.parent field in it effectively points to the same
> object and it is used by the driver core.
> 
> Accordingly, the parent field can be dropped from struct acpi_device
> and for this purpose define acpi_dev_parent() to retrieve the parent
> struct acpi_device pointer from the dev.parent field in struct
> acpi_device.  Next, update all of the users of the parent field
> in struct acpi_device to use acpi_dev_parent() instead of it and
> drop it.
> 
> While at it, drop the ACPI_IS_ROOT_DEVICE() macro that is only used
> in one place in a confusing way.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I may have missed some places where adev->parent is used directly, so
> if that's happened, please let me know (I'm assuming that 0-day will
> pick up this patch and run it through all of the relevant configs
> anyway).
> 
> ---
[...]
>  drivers/hv/vmbus_drv.c       |    3 ++-

Acked-by: Wei Liu <wei.liu@kernel.org>
