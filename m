Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25185AD740
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIEQVJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 12:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiIEQVI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 12:21:08 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396871658E;
        Mon,  5 Sep 2022 09:21:03 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id k9so12033413wri.0;
        Mon, 05 Sep 2022 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Gx2C5541U0n9F5AFMZqVior4xRBmycropymV94ddXYU=;
        b=zfvvD1A+MdSmsalio9xUO6JKxDwyKBAY1/tgoOuTb7RUqVT+XECU/PqE+zuGK5NG6e
         x4Ed0gCw6Hb2s4OcAuPOJwdHHmnezzV9kuFzT0idPT/YyGK6+nOhYjP65KLKfcZE8j+e
         q7YVd2KKyPEX6AJHfMbFW8zp+MhY9RGbJg62dquviY9AHAkjXspDhIrSRMult611sdVY
         ll7FvXAphcT/eFfLGfMPsyWCkhbmurVYCq/VWxtMSPqTp9zyzs32uGePScdFyxZVbgSo
         nGfUxkCOc3eIDgwyBO+tfNaODve2tL3S1KatdUIXhj3gvVmq67HrZri4mu2zdUQ640qO
         0NDw==
X-Gm-Message-State: ACgBeo1hNxcJ74BJyKv24lESZtJvk55l0hQUcAk5jmealIUhcqQVILXq
        nORaqVwMsvck52tMmK+LsFU=
X-Google-Smtp-Source: AA6agR4+hWjWV8EgKdW/S061vco+NeYFjf0xzpfg83y/YlrXl78vhZBROj49BYV/ZLeSb2FhQJqyaw==
X-Received: by 2002:a5d:6d86:0:b0:226:e362:237d with SMTP id l6-20020a5d6d86000000b00226e362237dmr18612804wrs.453.1662394861605;
        Mon, 05 Sep 2022 09:21:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4532000000b00220592005edsm9358278wra.85.2022.09.05.09.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:21:01 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:20:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Message-ID: <20220905162056.puazskmvzd7oodre@liuwe-devbox-debian-v2>
References: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
 <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
 <20220713151927.e6w5gcb67ffh4zlx@liuwe-devbox-debian-v2>
 <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Sep 03, 2022 at 04:37:12AM +0000, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, July 13, 2022 8:19 AM
> > 
> > On Tue, Jul 12, 2022 at 04:24:12PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Monday, July
> > 11, 2022 11:18 AM
> > > >
> > > > Allow the guest to know how much it is ballooned by the host.
> > > > It is useful when debugging out of memory conditions.
> > > >
> > > > When host gets back memory from the guest it is accounted
> > > > as used memory in the guest but the guest have no way to know
> > > > how much it is actually ballooned.
> > > >
> > > > Expose current state, flags and max possible memory to the guest.
> > > > While at it - fix a 10+ years old typo.
> > > >
> > > > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > > > ---
> > [...]
> > >
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > I added "Drivers: hv:" prefix to the subject line and applied it to
> > hyperv-next. Thanks.
> 
> Alexander -- I finally caught up on the long discussion of balloon
> driver reporting that occurred over much of August.  I think your
> original plan had been for each of the balloon driver to report
> useful information in debugfs.  But as a result of the discussion,
> it looks like virtio-balloon will be putting the information in
> /proc/meminfo.  If that's the case, it seems like we should
> drop these changes to the Hyper-V balloon driver,  and have
> the Hyper-V balloon driver take the same approach as
> virtio-balloon.

The debugfs interface contains far more information than what can be put
into meminfo.

That being said, I can send a PR to revert the changes if we need time
to wait for the other discussion to come to an conclusion.

> 
> These Hyper-V balloon driver changes have already gone
> into 6.0-rc1.  If we're going to drop them, we should do
> the revert before 6.0 is done.
> 

Agreed.

Michael, let me know what you think.

Thanks,
Wei.

> Thoughts?
> 
> Michael
