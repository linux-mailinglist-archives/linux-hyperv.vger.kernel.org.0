Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C935460A55
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Nov 2021 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhK1Vb0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Nov 2021 16:31:26 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37836 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhK1V30 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Nov 2021 16:29:26 -0500
Received: by mail-wm1-f47.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso15251435wms.2;
        Sun, 28 Nov 2021 13:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+wK4OmDifQrSqKUMTc1/sdSUNGixNnHa1F6AolO5c4=;
        b=BSbVjKe/7dkt5ZS5Lt7Y8Rw8mifgzybyTRrMEkPibzDYDxbWJtK6BT4dPY7pVg/YUP
         9ifigZjnyouo684gv4Fo3IqqZJWA0klp5Ut0mAciBSWeHVmzNN/h9dnanVSTA3mQlm2s
         PSVdDRnasS2s0tB1L/tUWarcehuHce0cDtTvHji5l3cW3lFeWfUgdXPgZHlgCbF3aipT
         zpitVHxoYKkqLqgkaXDJdtAATPOTT25QLKWBEpM+ShoOuiOP0C321+3hNwwGSUwUe17f
         2tlOvMUWVs6QWSkn1xtB7va/H6qTuEB2sbF5u3JJwkL5Tmc/6zfRmAkAw7nMMoZAX36N
         wESQ==
X-Gm-Message-State: AOAM531ltSFJ1plWtyp3z+mNfoFgRp2OveXgo/8t5kc0oN/BYZSmUUR7
        tmMJWtGnGUTwBI1XkR8fCAo=
X-Google-Smtp-Source: ABdhPJwxm8SsISwobAty1d50Tfyr4XXxZPxgb0IV0ZY6pw9vKcFbEUiWNHstSLfth3I25dyrvZU75Q==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr33115229wmb.19.1638134768892;
        Sun, 28 Nov 2021 13:26:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b10sm11969801wrt.36.2021.11.28.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 13:26:08 -0800 (PST)
Date:   Sun, 28 Nov 2021 21:26:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
Message-ID: <20211128212606.ft3qzwcsy3divl7z@liuwe-devbox-debian-v2>
References: <20211126023316.25184-1-rdunlap@infradead.org>
 <MWHPR21MB159387A26F1FF1A77CEB4255D7649@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159387A26F1FF1A77CEB4255D7649@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 27, 2021 at 07:12:11PM +0000, Michael Kelley (LINUX) wrote:
> From: Randy Dunlap <rdunlap@infradead.org> Sent: Thursday, November 25, 2021 6:33 PM
> > 
> > The hyperv utilities use PTP clock interfaces and should depend a
> > a kconfig symbol such that they will be built as a loadable module or
> > builtin so that linker errors do not happen.
> > 
> > Prevents these build errors:
> > 
> > ld: drivers/hv/hv_util.o: in function `hv_timesync_deinit':
> > hv_util.c:(.text+0x37d): undefined reference to `ptp_clock_unregister'
> > ld: drivers/hv/hv_util.o: in function `hv_timesync_init':
> > hv_util.c:(.text+0x738): undefined reference to `ptp_clock_register'
> > 
> > Fixes: 46a971913611a ("Staging: hv: move hyperv code out of staging directory")
> 
> Seems like the "Fixes" tag should reference something a little newer than
> when the Hyper-V code was first added.  Either commit 3716a49a81ba
> ("hv_utils: implement Hyper-V PTP source") or commit e5f31552674e 
> ("ethernet: fix PTP_1588_CLOCK dependencies") when
> PTP_1588_CLOCK_OPTIONAL was added.
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I used 3716a49a81ba in the Fixes tag and pushed it to hyperv-fixes.

Wei.
