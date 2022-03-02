Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69C4C9E97
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 08:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiCBHtd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 02:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiCBHtc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 02:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA5E317A9B
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Mar 2022 23:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646207328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSCz2pxA5hTBIRgPDgOdyYSFpYrMbh4E3T7sCMIW0vU=;
        b=bvIWOWY2qUy3chL1HKVSZZhj30ffgJtRMW6tABNTAg9N0DmCK+lJsTRFlIE21t900G4Nnb
        nKn7LfpVVQeIvL/RWWI00PihqP99jspNi6AWRFoRj9LoppxzaOl8Y8acq/JmOOn+Uw5wIk
        qoZdtyo0z/9+A4f7cixAnQ8tHxBxx44=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-s6eifOQoMbOrbyKoFCUzSQ-1; Wed, 02 Mar 2022 02:48:46 -0500
X-MC-Unique: s6eifOQoMbOrbyKoFCUzSQ-1
Received: by mail-wr1-f72.google.com with SMTP id ay18-20020a5d6f12000000b001efe36eb038so308858wrb.17
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Mar 2022 23:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSCz2pxA5hTBIRgPDgOdyYSFpYrMbh4E3T7sCMIW0vU=;
        b=4iPMmGB8ZfrSNfkdT6TQ9iKrMJ7MRnJoQrc1/p1bfyXXI8vMfHKEyT3izB15yI+uwj
         8Qd3UbNEBGg7eh1eAqrR5AXXQZtBBnBdRxlg9jUSTW4XsIuzhPjAYginT3kV9OIxPYL7
         OSLmHV/xsKx0lyyGWRazDTMSwyZCcJytBhhMDAESmgICwmpA43jSFXDy4gRyEcylTc21
         W9bGnOsLigMGRdfAr5kovOvCAl+i7cGN/L83xEFY0JerAf4US6QEuhJC8JZF3nHUu75G
         M/1krbFQGUsW9sUjAWFsxtSzy5h9hQskTiZpriG3hmLSmCUsMUs2j55eOv4BRI3M6Tbx
         4opQ==
X-Gm-Message-State: AOAM533dPF24M26D7R3o4mTEUXHT1YbGKzxpIUAZ6LFFfBhuHFRQHvZP
        Logf5GAMUY67V5wSU6grlpCUJFLIhSIP/pU08yN3emYMPebyFNgvlkZZ+PsZSKGt1qATUy8JOJ3
        8vQQqlN8slRCq6zBa20YO4vH3
X-Received: by 2002:a5d:6da1:0:b0:1e3:2bf5:13c with SMTP id u1-20020a5d6da1000000b001e32bf5013cmr22959834wrs.316.1646207325584;
        Tue, 01 Mar 2022 23:48:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9fOxEBC6Q2x8n5VmxQ/dfWM6m6ZkjkZTGFJDBmExfNYsTGNqiw6xeuncf/kpMaUAwvGB/xg==
X-Received: by 2002:a5d:6da1:0:b0:1e3:2bf5:13c with SMTP id u1-20020a5d6da1000000b001e32bf5013cmr22959817wrs.316.1646207325304;
        Tue, 01 Mar 2022 23:48:45 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm6342218wmp.44.2022.03.01.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 23:48:44 -0800 (PST)
Date:   Wed, 2 Mar 2022 02:48:41 -0500
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
Message-ID: <20220302024608-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <223f858c-34c5-3ccd-b9e8-7585a976364d@redhat.com>
 <Yh5JwK6toc/zBNL7@zx2c4.com>
 <20220301121419-mutt-send-email-mst@kernel.org>
 <CAHmME9qieLUDVoPYZPo=N8NCL1T-RzQ4p7kCFv3PKFUkhWZPsw@mail.gmail.com>
 <20220302024137-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302024137-mutt-send-email-mst@kernel.org>
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

On Wed, Mar 02, 2022 at 02:42:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 01, 2022 at 07:37:06PM +0100, Jason A. Donenfeld wrote:
> > Hi Michael,
> > 
> > On Tue, Mar 1, 2022 at 6:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Hmm okay, so it's a performance optimization... some batching then? Do
> > > you really need to worry about every packet? Every 64 packets not
> > > enough?  Packets are after all queued at NICs etc, and VM fork can
> > > happen after they leave wireguard ...
> > 
> > Unfortunately, yes, this is an "every packet" sort of thing -- if the
> > race is to be avoided in a meaningful way. It's really extra bad:
> > ChaCha20 and AES-CTR work by xoring a secret stream of bytes with
> > plaintext to produce a ciphertext. If you use that same secret stream
> > and xor it with a second plaintext and transmit that too, an attacker
> > can combine the two different ciphertexts to learn things about the
> > original plaintext.
> 
> So what about the point about packets queued then? You don't fish
> packets out of qdisc queues, do you?

Oh pls ignore it, I think I got it. Resending same packet is not
a problem, producing a new one is.

> > But, anyway, it seems like the race is here to stay given what we have
> > _currently_ available with the virtual hardware. That's why I'm
> > focused on trying to get something going that's the least bad with
> > what we've currently got, which is racy by design. How vitally
> > important is it to have something that doesn't race in the far future?
> > I don't know, really. It seems plausible that that ACPI notifier
> > triggers so early that nothing else really even has a chance, so the
> > race concern is purely theoretical. But I haven't tried to measure
> > that so I'm not sure.
> > 
> > Jason


So how about measuring the performance impact of reading the 16 byte
vmgenid then? This could be a performance option, too - some people
might want extra security, some might not care.  And I feel if linux
DTRT and reads the 16 bytes then hypervisor vendors will be motivated to
improve and add a 4 byte unique one. As long as linux is interrupt
driven there's no motivation for change.

-- 
MST

