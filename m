Return-Path: <linux-hyperv+bounces-1970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C518A5C8F
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93A41C20C80
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063F156960;
	Mon, 15 Apr 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="IMrOl8tK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79004154452;
	Mon, 15 Apr 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215009; cv=none; b=lyZaSvQ8gFBTKVuYT6Mlu434MvYw6GbCk51by4qio6bOI1H25dFDfivcnKZhs2a0vweqk5OIpME4UoRmTHDqSnDsOaCkExUctG58TUXCWJpb1nVINFUsPImt/1oFLdzKPKCbodJf3RXe3+S5Q0pF3SAsGTlZoFXjfxn7CbKLB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215009; c=relaxed/simple;
	bh=IQBTxWzfZWJOnehnyxvXhc/K0wYe3wbyqabJe2nCPEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEGGrSOh/g7fKIzP1X7Naj0GJR53wlGrsIJ0P1YfGIDPtJvobzBGro6/cfv5cqQ4pLq1MbKEYfwDkLls6CTvcirEILlLEs7nhOr2kxiN7X2pqEOEMRifHQrtEdBPwBMsDX0+i5sF9Io2sOi538blu1xOiZ8OHwmzyUcSgFMtLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=IMrOl8tK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713214993; x=1713819793; i=schierlm@gmx.de;
	bh=xBGCFuRo9W2rRub7BgbidjDbo1cCVInZYN5PxwDq+iE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IMrOl8tKJsSyzCDq2YwubRqIvuMm+1xV/btDi4u5ECMCyEJ7q4o2KMaIQdEAKBLM
	 QoGFMDOeVjrxBppHtmphB6sB0IFQWL52uIrDMCBIC/ID+vt0Y16ccXVZnQZLFfmfQ
	 8AVyDIxDs5O/uSm8XYekWsfXRpQPXGsdD9DHwdu3kl+UjXNLr85IZIg2alMGjRvst
	 c9pT0vkVf884S3tYLr8t2vOmUbqmzMGy9ZF6oyPOpXSlylnwyVjVZ64yAaDfkt322
	 WO3och9qtYWfKcuyVnJWVFb3d2e6C9BBSK05rO6g8dcO5oSRjU7HE7MsnOAYFQGe/
	 R8o3m9yM2+qj6KvsRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([79.195.87.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1rqxAS3HrI-005XLZ; Mon, 15
 Apr 2024 23:03:12 +0200
Message-ID: <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
Date: Mon, 15 Apr 2024 23:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
To: Michael Kelley <mhklinux@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: de-DE
From: Michael Schierl <schierlm@gmx.de>
Autocrypt: addr=schierlm@gmx.de; keydata=
 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
 uxTR60TDY/d6Kz8=
In-Reply-To: <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sdj1S0oXqz9y5sDQP4MZ5V/gmnx0jpQihVG09Yh0eshe5RrZVXv
 2nIvALIe4IwAardPGkPYqZzC9SgvmZ2OnENDO6wUXdLvhnl6nPHdrXdtvC43hOjndf5pE43
 wdWZrtc8nCL4Vlu3L+w9/d51cyFq2jfBhdf0FGG74AJWMgLjLe9BvJ3zKLBTKN7ean0jwDk
 y55KsSqiM8DjvpYkNnckg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n/jK8yiSaE0=;ISr0eXkXCP9r80m/b1SWt+Mbp2e
 lQ9iA7iFnjCgK8Ix5/X6OHiFo7bhHKojMXsM3GsPTmWO7sDl9PWp0Fo8j2Aoss10V1Y1Jhp9C
 I5Zf889zf6XizkFbAj4kk/LIt7SsdDm1cFipAfXDJn7kXNLTvALfu1dk5wcxYamBD6JLI6UCq
 WhFWCazkk0ioOoADsUSB0MdXJM8vDz9tF7i48LsUX2yKAko8eQpP4lE7xWLEMwELsfJpf786R
 HookWf2obo9fvQdtBNJMD1yAfPC/wN0goDBraeMVrtwnRUtX8zQg9kw6/RaJLZj+/BglBZOz+
 qGYFiwrH8IUEbZVrFtt9QIsaL77OCifw624fUjgrrtPI50p4ySSb9HOyk7hDeEDDQqiive+xL
 NWdr371tOg9Le6dvJc/Lo6tuDavH54bzPe+ygwlNeFbumMCa64EibOPw07xiTTTrXMn1TYoW7
 +uQ8pfWzXOAT7hSYGhDB5MqmkcZKndlnHnb2dgB+Dg0pdzvZCvyCpYThAJtI1RuVl+EmesIZ8
 ohh3IjfOOTWz89WVPyQEaiS4BzJtyHZU48rBz6Z20ApleKeoFUseQElXfdpHtEjuQDcWvvYFi
 s0v+gBwypZu5WV6hShEjwMGZpLHlh04YSVWEvW1TXALuimn+qLFEsDs2Yoc4cqak5tJzPc7/b
 kOoYRRqYVI/+W5W8AHED1vt2BqxZSmnPWEt4S9JboqYvVnIm22XoWd+b3Fz2J1UOowhba8nj1
 VqtZdGHv3gU5kIKNjMxWIcPIsu7xqzpaxdcT0WKzSGX1jKB0qtLQG5rKWD0QczESvzFYJI0TW
 lReUHcNHLUI0wh/nc+AsGCZ9AHr52hMDsRmUIII5RSjWE=

Hello Michael,

Am 15.04.2024 um 05:17 schrieb Michael Kelley:

> Let me suggest some additional diagnostics.  The DMI information is
> provided by the virtual firmware, which is provided by the Hyper-V
> host. The raw DMI bytes are available in Linux at
>
> /sys/firmware/dmi/tables/DMI
>
> If you do "hexdump /sys/firmware/dmi/tables/DMI" on your
> patched 32-bit kernel and on a working 64-bit kernel, do you see the
> same hex data?   (send the output to a file in each case, and then
> compare the two files)

For convenience, as I currently have no installed system with 64-bit
kernel on this Hyper-v instance, I tested with 32-bit and 64-bit kernel
6.0.8 from live media (grml96 2022.11 from www.grml.org), as well as
with my own 32-bit kernel (only for 2-core case).

In any case, I see the same content for /sys/firmware/rmi/tables/DMI as
well as /sys/firmware/dmi/tables/smbios_entry_point on 32-bit vs. 64-bit
kernels. But I see different content when booted with 1 vs. 2 vCPU.

So it is understandable to me why 1 vCPU behaves different from 2vCPU,
but not clear why 32-bit behaves different from 64-bit (assuming in both
cases the same parts of the dmi "blob" are parsed).


> If the DMI data is exactly the same, and a
> 64-bit kernel works, then perhaps there's a bug in the
> DMI parsing code when the kernel is compiled in 32-bit mode.
>
> Also, what is the output of "dmidecode | grep type", both on your
> patched 32-bit kernel and a working 64-bit kernel?


On 64-bit I see output on stderr as well as stdout.


     Invalid entry length (0). DMI table is broken! Stop.

The output before is the same when grepping for type

Handle 0x0000, DMI type 0, 20 bytes
Handle 0x0001, DMI type 1, 25 bytes
Handle 0x0002, DMI type 2, 8 bytes
Handle 0x0003, DMI type 3, 17 bytes
Handle 0x0004, DMI type 11, 5 bytes


When not grepping for type, the only difference is the number of structure=
s

1core: 339 structures occupying 17307 bytes.
2core: 356 structures occupying 17307 bytes.

I put everything (raw and hex) up at
<https://gist.github.com/schierlm/4a1f38565856c49e4e4b534cf51961be>

> root@mhkubun:~# dmidecode | grep type
> Handle 0x0000, DMI type 0, 26 bytes
> Handle 0x0001, DMI type 1, 27 bytes
> Handle 0x0002, DMI type 3, 24 bytes
> Handle 0x0003, DMI type 2, 17 bytes
> Handle 0x0004, DMI type 4, 48 bytes
> Handle 0x0005, DMI type 11, 5 bytes
> Handle 0x0006, DMI type 16, 23 bytes
> Handle 0x0007, DMI type 17, 92 bytes
> Handle 0x0008, DMI type 19, 31 bytes
> Handle 0x0009, DMI type 20, 35 bytes
> Handle 0x000A, DMI type 17, 92 bytes
> Handle 0x000B, DMI type 19, 31 bytes
> Handle 0x000C, DMI type 20, 35 bytes
> Handle 0x000D, DMI type 32, 11 bytes
> Handle 0xFEFF, DMI type 127, 4 bytes

That looks healthier than mine... Maybe it also depends on the host...?

> Interestingly, there's no entry of type "10", though perhaps your
> VM is configured differently from mine.  Try also
>
> dmidecode -u
>
> What details are provided for "type 10" (On Board Devices)?  That
> may help identify which device(s) are causing the problem.   Then I
> might be able to repro the problem and do some debugging myself.

No type 10, but again the error on stderr (even with only 1 vCPU).


> One final question:  Is there an earlier version of the Linux kernel
> where 32-bit builds worked for you on this same Windows 11
> version?

I am not aware of any (I came from Windows 10 with VirtualBox and wanted
to move my setup to Windows 11 with Hyper-V).

I just tested a 10-year old Linux live media with kernel 3.16.7, and it
behaves the same (2vCPU 32-bit does not boot, the other configurations
do). I may have some more really old live media on physical CDROMs
around, but I doubt is is useful testing these to find out if some
really old kernel would work better.


Thanks again,


Michael


