Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9095350753C
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiDSQti (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbiDSQp5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CD3B39692
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650386592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3ODNWfMW+rRhSokZu86v1GXhJjBricpy30YxedvS1g=;
        b=GGC/aKc6epjyb8qz33WDzkz7vdHatLFmsDOSeJq77hCEJ6oyzCiZ0EFdOm52+mMK1ay6Ju
        xXNCJDNzjRJ4OimnpdrBcIX9/M6OpCf18OiLh84LH/skKgzZQbYlJ55COX7O6F6g12hcBD
        T3Tpah57XcNPKzT6ZXuaTyaIiH1NCsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-YB0P7OgAOsuhPJP1FaJHqA-1; Tue, 19 Apr 2022 12:43:11 -0400
X-MC-Unique: YB0P7OgAOsuhPJP1FaJHqA-1
Received: by mail-wm1-f69.google.com with SMTP id l41-20020a05600c1d2900b0038ec007ac7fso1589125wms.4
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 09:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3ODNWfMW+rRhSokZu86v1GXhJjBricpy30YxedvS1g=;
        b=tpolN4GAR3gOXmKUOFXByJs4Dr+Al0fHyNvEyd/AWJFc1DC8tmQ+qU7qUOXZDorIxr
         IDYShowLlvG9vH+bJyBjkRR+cgZkqiRy3LaxIEUFUMCkZmJlIT9BgGd2whM8BLhBPb3w
         nTOjJLLNDT4IWRfxtBOj7yO5FLmHXWcyk2YMME2ZW2qSosoimWtFW41RiMNiTdMJ/gA9
         A4hOWH7QVxKihwfqKF/kqutEp/oyNAc56PuAD3ponVes0RqgHweEz6+p+ZP+FPoCvBH3
         w23JXIdK8mMWf1gmcL5ABBedtwHS6D0vRoKkyVEcrdN/co1k/zMZ9i0zcNlOVTxYxddY
         uzFw==
X-Gm-Message-State: AOAM5327P36ZNUS9gb6QHzZzBWMpuOGvHxhHylCbg9Tpc+21wnBfwhl6
        T0Zgfc/wcFXYna2rQkjye+5sylQfvJeFJf+SvwkF00V6KmHPik83mWAtb+yVu3CAcWmV8bTC2+4
        FPIrDarYIg1W8uZzvqA7zBZck
X-Received: by 2002:adf:f981:0:b0:205:c3e1:9eba with SMTP id f1-20020adff981000000b00205c3e19ebamr12387512wrr.244.1650386589520;
        Tue, 19 Apr 2022 09:43:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/sBvEGx6+IXc/dmS3LEsLdRrH83M0si6np7xgLC//YEu1El92MuYL5XEmIp9phspX0ZKpFQ==
X-Received: by 2002:adf:f981:0:b0:205:c3e1:9eba with SMTP id f1-20020adff981000000b00205c3e19ebamr12387485wrr.244.1650386589266;
        Tue, 19 Apr 2022 09:43:09 -0700 (PDT)
Received: from redhat.com ([2.53.17.80])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm16631515wmj.34.2022.04.19.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:43:07 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:43:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexander Graf <graf@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io, Laszlo Ersek <lersek@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220419124245-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <c5181fb5-38fb-f261-9de5-24655be1c749@amazon.com>
 <CAHmME9rTMDkE7UA3_wg87mrDVYps+YaHw+dZwF0EbM0zC4pQQw@mail.gmail.com>
 <47137806-9162-0f60-e830-1a3731595c8c@amazon.com>
 <CAHmME9pwfKfKp_qqbmAO5tEaQSZ5srCO5COThK3vWZR4avRF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pwfKfKp_qqbmAO5tEaQSZ5srCO5COThK3vWZR4avRF1g@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 19, 2022 at 05:12:36PM +0200, Jason A. Donenfeld wrote:
> Hey Alex,
> 
> On Thu, Mar 10, 2022 at 12:18 PM Alexander Graf <graf@amazon.com> wrote:
> > I agree on the slightly racy compromise and that it's a step into the
> > right direction. Doing this is a no brainer IMHO and I like the proc
> > based poll approach.
> 
> Alright. I'm going to email a more serious patch for that in the next
> few hours and you can have a look. Let's do that for 5.19.
> 
> > I have an additional problem you might have an idea for with the poll
> > based path. In addition to the clone notification, I'd need to know at
> > which point everyone who was listening to a clone notification is
> > finished acting up it. If I spawn a tiny VM to do "work", I want to know
> > when it's safe to hand requests into it. How do I find out when that
> > point in time is?
> 
> Seems tricky to solve. Even a count of current waiters and a
> generation number won't be sufficient, since it wouldn't take into
> account users who haven't _yet_ gotten to waiting. But maybe it's not
> the right problem to solve? Or somehow not necessary? For example, if
> the problem is a bit more constrained a solution becomes easier: you
> have a fixed/known set of readers that you know about, and you
> guarantee that they're all waiting before the fork. Then after the
> fork, they all do something to alert you in their poll()er, and you
> count up how many alerts you get until it matches the number of
> expected waiters. Would that work? It seems like anything more general
> than that is just butting heads with the racy compromise we're already
> making.
> 
> Jason

I have some ideas here ... but can you explain the use-case a bit more?

-- 
MST

