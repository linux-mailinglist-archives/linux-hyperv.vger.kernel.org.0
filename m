Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DCB4CA86C
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiCBOrH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 09:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243204AbiCBOrH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0124AC7C22
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Mar 2022 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646232383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w205eOqOdxeAZdCILUJdCHi/CnhyFtZESdwZqehxcdc=;
        b=GZYZDlyesE/pp8ODtAnWwaaMpSkl4SvEc6dt0M86vxmzS1/uc47uZlz4cbmfgdl3u9lwNh
        x+P1Ha9uRcrDyYOVF3mtB1owRJLN1rofnHhn6iiJvwDmyld8JuZMUrIGYXEcPzzs6bPyI0
        FA+GTAJrcZ/nryT2VGbhRpqlZbeUuCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-DuWlS9fNPBCYZxaRfSbAcA-1; Wed, 02 Mar 2022 09:46:22 -0500
X-MC-Unique: DuWlS9fNPBCYZxaRfSbAcA-1
Received: by mail-wm1-f70.google.com with SMTP id a26-20020a7bc1da000000b003857205ec7cso441895wmj.2
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Mar 2022 06:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w205eOqOdxeAZdCILUJdCHi/CnhyFtZESdwZqehxcdc=;
        b=zdPx7lXwm2uUz+s93IkMful3AmVUauf9/ydzKwneXbKW1S1uDkUOYnGY66Li5ToqZM
         58WzUb2nybqZ/91oc2mX13YgxCBXCVLtLnEvAFrOZVJFaCllclMAm4QSGHJCQrsf7mK/
         IR1H4ZNbIXxEVqCKX1riXrSAyTuGymWFhYrewDXFCZyIRRMtTYj1MEBwP7PljZPFZUAm
         K7oCsUBIvezPgSDJPVZHkmGZVywjr+9+OPuTZHQcjRmctu++Zl96HiP4o1X2kmHJH5zo
         wej+YCawuuclLJYfvAv57XoiMV206m/p6uMI9wQl5xheC7mORISM1z03a7PY2xqmGdYy
         xlSQ==
X-Gm-Message-State: AOAM533E1882zbyLBydr23/lm5u/xEOQlDWscT710ibR6pNsIvQ/3hlW
        iyTTrZGFW6pz0MwksTCc8a3Pgtinwcn9KLgnZ/xQZhTJf3xz1YDPX1UsVuu5heT/7on8jn6Y53F
        2nLXVLxzZOZ+EYrTtswaO6mXc
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id u5-20020adfeb45000000b001ef60707641mr20390155wrn.301.1646232380698;
        Wed, 02 Mar 2022 06:46:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza4Ib8iRQhbK5h23mGl00nx8utPjoauWdru+z6xmj8vBVgS9w4ICFHCPrxOEOgLj/22uh95g==
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id u5-20020adfeb45000000b001ef60707641mr20390128wrn.301.1646232380470;
        Wed, 02 Mar 2022 06:46:20 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id z16-20020a7bc7d0000000b00381004c643asm5677773wmk.30.2022.03.02.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:46:19 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:46:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220302092149-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <223f858c-34c5-3ccd-b9e8-7585a976364d@redhat.com>
 <Yh5JwK6toc/zBNL7@zx2c4.com>
 <20220301121419-mutt-send-email-mst@kernel.org>
 <CAHmME9qieLUDVoPYZPo=N8NCL1T-RzQ4p7kCFv3PKFUkhWZPsw@mail.gmail.com>
 <20220302031738-mutt-send-email-mst@kernel.org>
 <CAHmME9pf-bjnZuweoLqoFEmPy1OK7ogEgGEAva1T8uVTufhCuw@mail.gmail.com>
 <20220302074503-mutt-send-email-mst@kernel.org>
 <Yh93UZMQSYCe2LQ7@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh93UZMQSYCe2LQ7@zx2c4.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 02:55:29PM +0100, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Mar 02, 2022 at 07:58:33AM -0500, Michael S. Tsirkin wrote:
> > > There's also the atomicity aspect, which I think makes your benchmark
> > > not quite accurate. Those 16 bytes could change between the first and
> > > second word (or between the Nth and N+1th word for N<=3 on 32-bit).
> > > What if in that case the word you read second doesn't change, but the
> > > word you read first did? So then you find yourself having to do a
> > > hi-lo-hi dance.
> > > And then consider the 32-bit case, where that's even
> > > more annoying. This is just one of those things that comes up when you
> > > compare the semantics of a "large unique ID" and "word-sized counter",
> > > as general topics. (My suggestion is that vmgenid provide both.)
> > 
> > I don't see how this matters for any applications at all. Feel free to
> > present a case that would be race free with a word but not a 16
> > byte value, I could not imagine one. It's human to err of course.
> 
> Word-size reads happen all at once on systems that Linux supports,
> whereas this is not the case for 16 bytes (with a few niche exceptions
> like cmpxchg16b and such). If you read the counter atomically, you can
> check to see whether it's changed just after encrypting but before
> transmitting and not transmit if it has changed, and voila, no race.
> With 16 bytes, synchronization of that read is pretty tricky (though
> maybe not all together impossible), because, as I mentioned, the first
> word might have changed by the time you read a matching second word. I'm
> sure you're familiar with the use of seqlocks in the kernel for solving
> a somewhat related problem.
> 
> Jason

I just don't see how "value changed while it was read" is so different
from "value changed one clock after it was read".  Since we don't detect
the latter I don't see why we should worry about the former.  What I
don't have here is how would a code reading the value look.  It might
help to write some pseudo code to show that, but I'd say it makes more
sense to just code the read up even just so the overhead of the current
interface can be roughtly measured.

-- 
MST

