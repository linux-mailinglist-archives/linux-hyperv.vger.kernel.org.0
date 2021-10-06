Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A3423D70
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhJFMIF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 08:08:05 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39701 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhJFMIF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 08:08:05 -0400
Received: by mail-wr1-f43.google.com with SMTP id r18so8145940wrg.6;
        Wed, 06 Oct 2021 05:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNcn48D3nGpFlNGVJDCmmU3LLWCyAonv17pcR58BiMU=;
        b=eu6nB/v3+fOV4JlTd4xufhmD4JYdZinskCbidsIfaiwkU9DOjHyZ697uxc1cFKY0aF
         +zvaI5z9RuvH3s8EurfWa5pJsfUp4cV0RK23np58hjFcMerOASOvQvLmYwf6tD+siRBU
         AE/FRQrTQ7et4D+mU943mHeXZ5p7yglYkBT0cccLy29rZl88TIOjVbyJxePe9M1Cqsrq
         ZPbDg47g6MRTEO/joYauS4eejfZFlxHFHSfq1ooN2H7BmOoboiGGIlAtUoi0bTSXE+Fr
         oaRCUni0Y5rBQx4qDS5+L/MYkmppgATqHeJyJIaeV0aaDnsF8SNRdq/rInj2UP1Eiyp0
         Es7A==
X-Gm-Message-State: AOAM532ObXLdymmctVfeePTQmoyWa4FHsQ+V1gNnvwHnKFNdm5mtRkcg
        z5RQATB5uD1f09xgQC1+d58=
X-Google-Smtp-Source: ABdhPJz/FZOr9rugCjTDxfIf8i0lNqWchDjGijYX89i70CFeZrKOXpSc8NRAwkzQpyFLeQX3ZNv4Dg==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr24112815wrb.83.1633521972156;
        Wed, 06 Oct 2021 05:06:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c17sm4775662wmr.15.2021.10.06.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:06:11 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:06:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
Message-ID: <20211006120610.uvn37h4yrqrtundm@liuwe-devbox-debian-v2>
References: <20211001135544.1823-1-andriy.shevchenko@linux.intel.com>
 <BN8PR21MB1284A4B993EA1C8A51A043C7CAAB9@BN8PR21MB1284.namprd21.prod.outlook.com>
 <CAHp75VdXs4QWzeGrLoOEMEcQnC51J-bbsoQTrk+Ju4qL6KgdoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdXs4QWzeGrLoOEMEcQnC51J-bbsoQTrk+Ju4qL6KgdoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Oct 02, 2021 at 10:46:16AM +0300, Andy Shevchenko wrote:
> On Sat, Oct 2, 2021 at 1:36 AM Haiyang Zhang <haiyangz@microsoft.com> wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Friday, October 1, 2021 9:56 AM
> 
> ...
> 
> > Hyper-v drivers are using uuid/guid APIs, but they can get the defs from
> > linux/mod_devicetable.h:
> >
> > ./include/linux/mod_devicetable.h:#include <linux/uuid.h>
> > ./include/linux/hyperv.h:#include <uapi/linux/hyperv.h>
> > ./include/linux/hyperv.h:#include <linux/mod_devicetable.h>
> 
> Yes, drivers inside the kernel may use that and this is the correct
> way. The uAPI is not using it.
> 
> > So your patch looks fine. Thanks.
> >
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Thank you!

Applied to hyperv-fixes. Thanks.

Wei.

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
