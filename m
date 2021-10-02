Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0141FA54
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Oct 2021 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhJBHsj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 2 Oct 2021 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhJBHsj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 Oct 2021 03:48:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45FDC061775;
        Sat,  2 Oct 2021 00:46:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v10so43397180edj.10;
        Sat, 02 Oct 2021 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJg9+G2d7ooPfbqfkYfBieTy/55m+eZ3a38V/ihBSWs=;
        b=fgwmk9YZT+ogWvcMTYDpRFWQ5XdaiP4t/KZMDWnL9hBOhTILd9me82OJpFpzaDsoQE
         DwznfJHYG2vclF8JHRb8LkvyqxhTFuWYrA5JC2T5osU9th3hSQlGG/IRX0wBXnO40eFz
         sEWy4gavcen2tK5gKyc1OHIKGHIGkN3qF9s/OwYuFCKsTc10J9e8dWs/ENJBSv3XUTq8
         f86hmvEi0JM5DtPJxNclsmpdnJm5pHGElv2qIQ/FAT2ZDj63Vjr2SXE93fMPirZtxG/T
         KxBr53e4wZZO8Vp3WCkbybqteuZlXWXDfhFfd6aIDcDIu6BsPpWt8CcHQDG5Cnv0bCRr
         e4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJg9+G2d7ooPfbqfkYfBieTy/55m+eZ3a38V/ihBSWs=;
        b=GzoyAeZqh8xfn1Qs8EGlRylAgY2LRsCZyMS5FSIEAEtFfKBNfEwmLgBYihdIqYSGD2
         XGMuNY9dF5Y/Ye5eJ/tbWAOkhosbvzCE8+NaR2YjHyQR9toLYFTcqfP8jf02IkNd4+hq
         qHLv7pDnnAzSxfCk6L6wkAbYuge47wTA00I5vkqeLq0reSTzofiwC/sC7TTBIXXU2Ip+
         b5umOR0RfpohGJPUZMwHTt7DCsU8fLTzFUbgWa3nEI3jkdHBQSJmdtQQRDKRNgmqRty8
         6ROBWuLb2/izxU57M977N5yhA5vMvs4ZxLLEZaKMcOpEJxZGPs3XkFglTiAO6N/ZrkQS
         /wmw==
X-Gm-Message-State: AOAM530gGhi4qBezMfD5sHDJ9UzciH2b3cJXXG73BZlTwy8jaxRyTCcj
        +E46o2BenIkvR1PClyg1xAUd46ujh8aPaJEBmD8k6LF9m88=
X-Google-Smtp-Source: ABdhPJyifesxX0te54Yf2c3MJaKYVmW7xXeAoUpwd2Hjq9B9MZT0q4hSabgNIhuA8lKZtwSm3lBxJOKxJCIq71getXE=
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr2578037edx.224.1633160812442;
 Sat, 02 Oct 2021 00:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211001135544.1823-1-andriy.shevchenko@linux.intel.com> <BN8PR21MB1284A4B993EA1C8A51A043C7CAAB9@BN8PR21MB1284.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB1284A4B993EA1C8A51A043C7CAAB9@BN8PR21MB1284.namprd21.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Oct 2021 10:46:16 +0300
Message-ID: <CAHp75VdXs4QWzeGrLoOEMEcQnC51J-bbsoQTrk+Ju4qL6KgdoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Oct 2, 2021 at 1:36 AM Haiyang Zhang <haiyangz@microsoft.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, October 1, 2021 9:56 AM

...

> Hyper-v drivers are using uuid/guid APIs, but they can get the defs from
> linux/mod_devicetable.h:
>
> ./include/linux/mod_devicetable.h:#include <linux/uuid.h>
> ./include/linux/hyperv.h:#include <uapi/linux/hyperv.h>
> ./include/linux/hyperv.h:#include <linux/mod_devicetable.h>

Yes, drivers inside the kernel may use that and this is the correct
way. The uAPI is not using it.

> So your patch looks fine. Thanks.
>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you!


-- 
With Best Regards,
Andy Shevchenko
