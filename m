Return-Path: <linux-hyperv+bounces-1116-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2C7FC8EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 23:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13109B214E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E8481BD;
	Tue, 28 Nov 2023 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WSLa365g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D319A
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 13:59:48 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35ccfc5323aso3313495ab.1
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701208788; x=1701813588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqXh8h2TE9EqBfbi7m4c/BFMHO+IwfCong5cfxOFR/E=;
        b=WSLa365g2mqIEi0is0kQkWMUvC6BvhaaanbR5cVI6iHQI2DxvYhylWKRi691idP4ZK
         eYwMn84ysqp2ewUzffB4B3ZA+fQ7dQnbeDUMV3yeZiBzIH//KahTeV7vbzTLNDLiOLcJ
         0A0rS3cgR0O2dpSQimDzdnvBBJEKfuyIyoQ1prfGsuU3Rt2pN2ZowsoIT53uqZzi5qRF
         w7rUx8rbIijbqY+rTDdK+OQ8f4+0BI0W9c7RYucrQWYpVajb08IdQaK0hxhSVk7FbiUW
         11DQJ4l0JY2itQhHM0wxVnSv+HIqRlrcQ60DZmgs1VGmXMEY4lNour3XGjlwsQQq8vQD
         qeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208788; x=1701813588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXh8h2TE9EqBfbi7m4c/BFMHO+IwfCong5cfxOFR/E=;
        b=RNrlEHhhxoz8owrcBtngMUoP9x7Leh8S2wUdxOrQeNfcrx055UoVtMs+ePPisDac5B
         2JRTBy29fFh2Gdksh2SAW+2BHLOZ+3Tz/UrJyFAXjbee6z/lm0r8QgBkhJ6bwWQXxykF
         O356x+1ftVkAndvR0M8gjxyGoOXdAWGF1/NxpCqujYz1uCYVQzl888flQzkQEuXCp6rw
         j6RXKe8UYpGnzcWff1MP0GLx9Rhw3jft+wyYyT0zhdjer7IO8bSwNLvdjZrio15Mccid
         OASn8wZqiHEbB3tgMXIUC/d34PszWb+t4uBRLrJdcgCe1xrM+oNb1SJHZu/+cAn1AoBW
         17tA==
X-Gm-Message-State: AOJu0YwB67jtMtD+7JZRgzaNNqY0woSie78+lGUC9cDllgyX0bouwWZk
	9aH/mah7CNkebxmuyNUUPI84t1BYlnoVvGFHnYGXMA==
X-Google-Smtp-Source: AGHT+IEVso2zBXyIILDyd1NKHjfwFmHQZ9RyRGvd8AQMvztNKwPP6rHt1yS8h8/sfYKGkxCFjt9tKg==
X-Received: by 2002:a92:c84b:0:b0:35c:baec:750c with SMTP id b11-20020a92c84b000000b0035cbaec750cmr8318971ilq.1.1701208787912;
        Tue, 28 Nov 2023 13:59:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b00694ebe2b0d4sm9483791pff.191.2023.11.28.13.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 13:59:47 -0800 (PST)
Message-ID: <66be0c42-2514-436b-bbef-3bd9ab123594@kernel.dk>
Date: Tue, 28 Nov 2023 14:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Merging raw block device writes
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20231127065928.GA27811@lst.de>
 <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
 <SN6PR02MB41578DD2B7A1F25336B0224BD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <SN6PR02MB41578DD2B7A1F25336B0224BD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/23 12:29 PM, Michael Kelley wrote:
> From: Jens Axboe <axboe@kernel.dk> Sent: Monday, November 27, 2023 8:10 AM
>>
>> On 11/26/23 11:59 PM, hch@lst.de wrote:
>>> On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
>>>> Hyper-V guests and the Azure cloud have a particular interest here
>>>> because Hyper-V guests uses SCSI as the standard interface to virtual
>>>> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
>>>> so the number of in-flights I/Os can be relatively high, and
>>>> merging can be beneficial to staying within the throttle
>>>> limits.  Of the flip side, this problem hasn't generated complaints
>>>> over the last 18 months that I'm aware of, though that may be more
>>>> because commercial distros haven't been running 5.16 or later kernels
>>>> until relatively recently.
>>>
>>> I think the more important thing is that if you care about reducing
>>> the number of I/Os you probably should use an I/O scheduler.  Reducing
>>> the number of I/Os without an I/O scheduler isn't (and I'll argue
>>> shouldn't) be a concern for the non I/O scheduler.
>>
>> Yep fully agree.
>>
> 
> OK.  But there *is* intentional functionality in blk-mq to do merging
> even when there's no I/O scheduler.  If that functionality breaks, is
> that considered a bug and regression?  The functionality only affects
> performance and not correctness, so maybe it's a bit of a gray area.
> 
> It's all working again as of 6.5, so the only potential code action is to
> backport Christoph's commit to stable releases. But it still seems like
> there should be an explicit statement about what to expect going forward.
> Should the code for doing merging with no I/O scheduler be removed, or
> at least put on the deprecation path?

It's mostly a "you get what you get" thing. If we can do merging cheap
or for free, then we do that above the IO scheduler. It'd be great to
have some tests for this to ensure we don't regress, unknowingly.

But in general, if you want guaranteed good merging, then an IO
scheduler is the right choice.

-- 
Jens Axboe


