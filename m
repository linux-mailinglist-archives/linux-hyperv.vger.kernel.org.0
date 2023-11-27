Return-Path: <linux-hyperv+bounces-1060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3B7FA5BF
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FA41C20E97
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A60358A7;
	Mon, 27 Nov 2023 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fvt1xH21"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FECBF
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 08:10:06 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35b0b36716fso3701225ab.0
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701101405; x=1701706205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIIccdhs8yz+yiJjCrLMyK2ZFy1CQEPmm7PUbEVf7I=;
        b=Fvt1xH210eU0Tp6AOVG5kL42g89qbCU+v3xMkVldRwz+w+SyT4sF2gTig63NG9An8w
         6XWxuhEmN/72kDT1VUjR8y2s7fBgFn6s4mkj652xAYasd7M0NoXsJs//fn1edF6Hy3ZN
         gX7HZDfcdR2/77zDc28YvedHmqUCgX6kiHYeoZMLPURqxb1cE015hArO7KB7DTCyt+5H
         WmSEbypw504TG4kTwmlTbx3kC1o9v4YjteytrqBUxOaEdy+qUk2D5ofW47dwCa1Y5aKO
         dzNSR05NZ1xKC3BrQf6uZ/yPI1AnawH3hgB10ikfgUwAglfJZ7WVGqBFRd+bMv+tK1pl
         tTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101405; x=1701706205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIIccdhs8yz+yiJjCrLMyK2ZFy1CQEPmm7PUbEVf7I=;
        b=wUR3VDWi9UPI9a8PMvxO/l8yb8OE/9BUDj6cN2Psn1nQU/Fb7hp/jMXDX4TwHIDcEP
         GcqVyk1GEbbILpfHl563BuNCzKC9d+z8/0j8Bf++XG3sx1feIo6f6zJkz14HdGAqfiYJ
         fpN3cg435E5A2bAo0+OFCFMlMkPfCWlNYxAz+mSROb9N0pb3r+a5py2K8L+L4AkOnK9T
         bZEhxyqqttbp/U12HURx99FxIkAK/frOs1I7YjHP7HvnkJsvfmJhqpN2HYtEBgHVh4iy
         3zSpEun5g/hlgvKR0z0DnfnPp2GCwSxJBgA8Y/7eZ9xoU/OWKbBYGSjbbcqEzLm05LMk
         vAKw==
X-Gm-Message-State: AOJu0YxOM6yDW/c33DIOZ8sqmfOazwq8ZDHmuCAGPJkw1RXwujG27esa
	Zz19NCBkGLciijYzRM5O9x5YvQ==
X-Google-Smtp-Source: AGHT+IG/IaqyGyROu7hEZKzZJuUB5m4Skn6QbtiicnN+TWTrcKiqLe/Y3pmcCOuwBT1U4spu+VXwcQ==
X-Received: by 2002:a05:6602:489a:b0:7b3:95a4:de9c with SMTP id ee26-20020a056602489a00b007b395a4de9cmr6090167iob.1.1701101405357;
        Mon, 27 Nov 2023 08:10:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c24-20020a05660221d800b007870289f4fdsm2459925ioc.51.2023.11.27.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:10:04 -0800 (PST)
Message-ID: <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
Date: Mon, 27 Nov 2023 09:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Merging raw block device writes
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20231127065928.GA27811@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231127065928.GA27811@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/23 11:59 PM, hch@lst.de wrote:
> On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
>> Hyper-V guests and the Azure cloud have a particular interest here
>> because Hyper-V guests uses SCSI as the standard interface to virtual
>> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
>> so the number of in-flights I/Os can be relatively high, and
>> merging can be beneficial to staying within the throttle
>> limits.  Of the flip side, this problem hasn't generated complaints
>> over the last 18 months that I'm aware of, though that may be more
>> because commercial distros haven't been running 5.16 or later kernels
>> until relatively recently.
> 
> I think the more important thing is that if you care about reducing
> the number of I/Os you probably should use an I/O scheduler.  Reducing
> the number of I/Os without an I/O scheduler isn't (and I'll argue
> shouldn't) be a concern for the non I/O scheduler.

Yep fully agree.

-- 
Jens Axboe


