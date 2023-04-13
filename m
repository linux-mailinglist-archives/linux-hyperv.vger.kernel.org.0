Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6056E03AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDMB2m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDMB2l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:28:41 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33D32D73;
        Wed, 12 Apr 2023 18:28:39 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id d28so183763wra.6;
        Wed, 12 Apr 2023 18:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681349318; x=1683941318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLNvC46YUMmRd95OiEAIyCSkRHuN7St4j0IhJcSJ0oI=;
        b=Qq/qCxhqCBT0l+fU8ChdZTsyNnokKsVtqMgheTeqFegUANmr/GbR26467cPJk1gE9J
         6GdoqoCdUfwEOh6QUyx5iawuKlGVRRr9mYPfZK5I1ErqC5kkIh5nqH0g8Mgf5juBKGSZ
         s5fYyBfrS39PPz0WtKk4mEG/37hW5gqjPC/qz5qtRwGkdFFSZiQJBIa5us0SCjKiFL3r
         Nne1BnVX4mMWFxEJntLskbZInSj+Uy2dLEW/6vDi75bJKLbgzRZkmtKWf4ik4P5jIsFm
         R/1DN8V6I6HnDdClCemJKqaG6qRzeodofIzkI8SuWMy8Ml6DKxkjgGH8TCSaW9rKA2Vj
         cuWQ==
X-Gm-Message-State: AAQBX9d1CcZ9VKNqY5PEXpye79qTi0t9NR48ewX9ctSCzVBG+bBtkOh/
        7snUPU/IGDSUrK8Ou3Ot1yk=
X-Google-Smtp-Source: AKy350bA19sy73SEcWwr9D4guF2ZuzL4sRHxBEET0GWb/6fdnsU35y259LFuR5SoH9S2Iv1nI4+djQ==
X-Received: by 2002:adf:f9d0:0:b0:2ce:a93d:41a7 with SMTP id w16-20020adff9d0000000b002cea93d41a7mr141572wrr.40.1681349318366;
        Wed, 12 Apr 2023 18:28:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k16-20020adff290000000b002f53fa16239sm110697wro.103.2023.04.12.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:28:37 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:28:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Message-ID: <ZDdawTGHoa/UH20U@liuwe-devbox-debian-v2>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+O56OXIuARBhsg2@google.com>
 <3b8496c071214bda9e5ecfa048f18ab9@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8496c071214bda9e5ecfa048f18ab9@baidu.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 12, 2023 at 12:02:04PM +0000, Li,Rongqing wrote:
> 
> 
> > -----Original Message-----
> > From: Sean Christopherson <seanjc@google.com>
> > Sent: Wednesday, February 8, 2023 11:04 PM
> > To: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Cc: Li,Rongqing <lirongqing@baidu.com>; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; tglx@linutronix.de; mingo@redhat.com;
> > bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org;
> > linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
> > shutdown
> > 
> > On Wed, Feb 08, 2023, Michael Kelley (LINUX) wrote:
> > > From: lirongqing@baidu.com <lirongqing@baidu.com> Sent: Monday,
> > > February 6, 2023 5:15 PM
> > > >
> > > > Zeroing the counter register in pit_shutdown() isn't actually
> > > > supposed to stop it from counting,  will causes the PIT to start
> > > > running again, From the spec:
> > > >
> > > >   The largest possible initial count is 0; this is equivalent to 216 for
> > > >   binary counting and 104 for BCD counting.
> > > >
> > > >   The Counter does not stop when it reaches zero. In Modes 0, 1, 4, and 5
> > the
> > > >   Counter "wraps around" to the highest count, either FFFF hex for binary
> > > >   count- ing or 9999 for BCD counting, and continues counting.
> > > >
> > > >   Mode 0 is typically used for event counting. After the Control Word is
> > > >   written, OUT is initially low, and will remain low until the Counter
> > > >   reaches zero. OUT then goes high and remains high until a new count or a
> > > >   new Mode 0 Control Word is written into the Counter.
> > > >
> > > > Hyper-V and KVM follow the spec, the issue that 35b69a42
> > > > "(clockevents/drivers/
> > > > i8253: Add support for PIT shutdown quirk") fixed is in i8253
> > > > drivers, not Hyper-v, so delete the zero timer counter register in
> > > > shutdown, and delete PIT shutdown quirk for Hyper-v
> > >
> > > From the standpoint of Hyper-V, I'm good with this change.  But
> > > there's a risk that old hardware might not be compliant with the spec,
> > > and needs the zero'ing for some reason. The experts in the x86 space
> > > will be in the best position to assess the risk.
> > 
> > Yep, my feeling exactly.  My input is purely from reading those crusty old specs.
> 
> 
> 
> Ping

I guess you want Thomas Gleixner and Daniel Lezcano's attention.

> 
> Thanks
> 
> -Li
