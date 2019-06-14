Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F626456CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 09:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfFNHxP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 03:53:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfFNHxP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 03:53:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1396887wrw.13
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jun 2019 00:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8fphykZty4ByRRDrabr8kIG4WtC4MdL+z6VNpErB0g0=;
        b=L5lLIam1ghURF6u6OZfab5ejwS2awhioLN3r2VNGezBtDs4StnHYaZprrE9PNqmWYR
         4MTlXVD9EMQL6QL4MQsFtBaWhFPtfhDHBYVDSLUDdM6nkt4wMQ29NpgZftw6WH5rwjGi
         thkbjNLTIavhK7J+Xo2B8Ley82OdZ/gAEYM6rrEJ/KXOXatLX2Jf7jgL6OS2dMK6OHIW
         dTwR/V7HGqYoN/eho4PWmW4IQ7VEJtjZ/iGrJU0IVeDbhyOkS2Zz2sd2tzX5RAZQ7hbB
         Y65wdajXdbDDrWa/sHEO/hOB2f4ipsMVURODeahtnm5ruVzXroYtuAwJprTOjkGs+lfm
         rbpA==
X-Gm-Message-State: APjAAAUHFcRqQpaShNFsKniPbUVQ6UXfeW8yM7khytuq8SGpVPY3aXRW
        n9AIYqXuMIt1jl+WtmpS4zoG1g==
X-Google-Smtp-Source: APXvYqwudq3lF4n8Rq0cC6F8jfIcXcCrwvwQ7V8kVVjpQeinklynWmw5QYHdkRp6uBhckMxPdXxU9g==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr4390021wrn.216.1560498793342;
        Fri, 14 Jun 2019 00:53:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n10sm2013838wrw.83.2019.06.14.00.53.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:53:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>
Subject: RE: [PATCH v2 4/5] HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
In-Reply-To: <BL0PR2101MB134877ED5DCB9F23033C92D9D7EF0@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <0e9385a241dc7c26445eb7e104d08e2e2c5d30de.1559807514.git.m.maya.nakamura@gmail.com> <87h88vdr36.fsf@vitty.brq.redhat.com> <BL0PR2101MB134877ED5DCB9F23033C92D9D7EF0@BL0PR2101MB1348.namprd21.prod.outlook.com>
Date:   Fri, 14 Jun 2019 09:53:11 +0200
Message-ID: <87ftoc7gd4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, June 12, 2019 3:40 AM
>> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
>> 
>> > Define the ring buffer size as a constant expression because it should
>> > not depend on the guest page size.
>> >
>> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
>> > ---
>> >  drivers/hid/hid-hyperv.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> > index d3311d714d35..e8b154fa38e2 100644
>> > --- a/drivers/hid/hid-hyperv.c
>> > +++ b/drivers/hid/hid-hyperv.c
>> > @@ -112,8 +112,8 @@ struct synthhid_input_report {
>> >
>> >  #pragma pack(pop)
>> >
>> > -#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
>> > -#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
>> > +#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
>> > +#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
>> >
>> 
>> My understanding is that this size is pretty arbitrary and as I see you
>> use it for hyperv-keyboard.c as well. It may make sense to have a
>> define, something like HYPERV_STD_RINGBUFFER_SIZE.
>
> Yes, the size is pretty arbitrary because it hasn't been important enough
> from a memory consumption or performance standpoint to run experiments
> to see if a smaller value could be used.  That said, I would not want to
> link these two devices (keyboard and mouse) by using a shared ring buffer
> size definition.  Logically, the ring buffer sizes are independent of each other,
> and using a common #define implies that they are somehow linked.

Ok, makes sense, let's keep them separate.

-- 
Vitaly
