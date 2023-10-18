Return-Path: <linux-hyperv+bounces-552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A827CD666
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Oct 2023 10:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CC21F22D9F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Oct 2023 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942C154AA;
	Wed, 18 Oct 2023 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaRxX2OO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2C1401C
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Oct 2023 08:27:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91EEA
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Oct 2023 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697617665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5myctI+T5Cg08XOlMTBvgWtZvdhuo39M1fwXVkEoAQw=;
	b=eaRxX2OO3/zrg2PFw/aOpa3yWYXfTVg3mMtqxuwrpwAM1qpO0LuQZHMqCIN8XyjprfgYn3
	g9vpzpLYmJM9q4/ab2AJvB/7ZzhV1iBlrUQS4hlcC8cOPA6elyNE6rLT2f9yhQTw3I1AY7
	5aOzkeH0OMG6lV/mcEBahPxhnm7slZY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-TJu_c4w7PFaly-i4HYVdQQ-1; Wed, 18 Oct 2023 04:27:33 -0400
X-MC-Unique: TJu_c4w7PFaly-i4HYVdQQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507cb169766so178184e87.0
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Oct 2023 01:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617652; x=1698222452;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5myctI+T5Cg08XOlMTBvgWtZvdhuo39M1fwXVkEoAQw=;
        b=cALdRWXXLyi41YlWgr0UyF7XF8xeHwLuViYJkVzYUGCHYpXTLuz9XlxykKwlvRJeoY
         r5dAc4wnQI4LqZqq1woNu1QQdvrM27WAv+zfHdqOBbdXAuX3HqczBL+pnoBFBOvhuyjT
         JBKhfMnF3D+meOErgxptzLwuhIPzTLBy1GGaTZcyFzd9G7Z/r16btooOvzFHscFfsK3b
         zPUohXEOjQrHAdOA+luP1lZS6jEpz6klmyJ7OWZMEbilQIJVqCb0ktXcOrQjF3b/CQ2T
         xnQLxZmaLcz6XI2vBIIA+3a06zm05oIosxIZho+Pg3+lhV/APN582r9dHYCBYofKqtvd
         d4nw==
X-Gm-Message-State: AOJu0YwSE2VXWpYNGnUcNQ45wBY1b8NfFM/SlzHaZCFvyVNVk3PiYwGJ
	xvg71YqOnBD2A9aMsHymu1FtBfNG2KhJsI8skADIxESV8EiiMYjJR+NKw+ubGxTkkxiPhlMB0nU
	gdP86fc60Rt1QEb8YHMp/X29r
X-Received: by 2002:a05:6512:3b0c:b0:507:9693:12aa with SMTP id f12-20020a0565123b0c00b00507969312aamr4713190lfv.15.1697617652432;
        Wed, 18 Oct 2023 01:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIrJgfOZ5wI3NwKzoPhuc2u3+jMX/qHA84uKjhekRit/zjddhWIi74k2GsOXWGi2hyuIJALw==
X-Received: by 2002:a05:6512:3b0c:b0:507:9693:12aa with SMTP id f12-20020a0565123b0c00b00507969312aamr4713172lfv.15.1697617652089;
        Wed, 18 Oct 2023 01:27:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id f15-20020a05640214cf00b0053e88c4d004sm2355554edx.66.2023.10.18.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:27:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>, Angelina Vu
 <angelinavu@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
In-Reply-To: <BYAPR21MB1688AD7F27C9CA40F7FB4EF1D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
 <87jzrl71me.fsf@redhat.com>
 <BYAPR21MB1688AD7F27C9CA40F7FB4EF1D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date: Wed, 18 Oct 2023 10:27:30 +0200
Message-ID: <878r8072tp.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, October 17, 2023 7:41 AM
>> 
>> Angelina Vu <angelinavu@linux.microsoft.com> writes:
>> 
>> > Currently, the balloon floor value is automatically computed, but may be
>> > too small depending on app usage of memory. This patch adds a balloon_floor
>> > value as a module parameter that can be used to manually configure the
>> > balloon floor value.
>> >
>> > Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>
>> > ---
>> >  drivers/hv/hv_balloon.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> > index 64ac5bdee3a6..87b312f99b2e 100644
>> > --- a/drivers/hv/hv_balloon.c
>> > +++ b/drivers/hv/hv_balloon.c
>> > @@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device *dm,
>> struct dm_info_msg *msg)
>> >  	}
>> >  }
>> >
>> > +unsigned long balloon_floor;
>> > +module_param(balloon_floor, ulong, 0644);
>> > +MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ballooning
>> will not remove");
>> > +
>> >  static unsigned long compute_balloon_floor(void)
>> >  {
>> >  	unsigned long min_pages;
>> > @@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
>> >  	 *    8192       744    (1/16)
>> >  	 *   32768      1512	(1/32)
>> >  	 */
>> > +	if (balloon_floor)
>> > +		return MB2PAGES(balloon_floor);
>> > +
>> >  	if (nr_pages < MB2PAGES(128))
>> >  		min_pages = MB2PAGES(8) + (nr_pages >> 1);
>> >  	else if (nr_pages < MB2PAGES(512))
>> 
>> A module parameter is probably useful for debugging but it can hardly be
>> applied in production environments as it must be 'one size fits all' and
>> e.g. for different VM sizes it can be different (that's the purpose of
>> compute_balloon_floor() heuristics).
>> 
>> In fact, does it has to be statically set? Can we have a sysfs entity so
>> this can be a policy (userspace decision)? We can keep the current
>> compute_balloon_floor() as the default but users will be able to adjust
>> accordingly.
>> 
>
> The module parameter can also be set or changed at runtime via
> /sys/module/balloon/parameters/balloon_floor.  Changes made by
> writing to that path are immediately reflected in the value of
> the balloon_floor variable.  I think that accomplishes everything
> you've outlined while also allowing a value to be set on the
> kernel boot line.

Oh, thanks, I've actually forgot it is r/w. What's IMO not ideal with
this approach is that if you don't pass any value on the kernel command
line, '/sys/module/balloon/parameters/balloon_floor' will contain '0' so
the user will have to guess the actual current value. Would it make
sense to do:

  if (!balloon_floor)
          balloon_floor = compute_balloon_floor();

on boot/whenever(if) totalram_pages() changes? Personally, I'm not sure
it's a good idea as I've never seen kernel module parameters which would
behave this way :-) Another thing is that I'm not sure to which extent
'/sys/module/*/parameters/' can be considered a stable ABI, i.e. it is
not documented like Documentation/ABI/stable/*.

-- 
Vitaly


