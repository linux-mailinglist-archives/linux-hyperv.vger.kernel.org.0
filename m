Return-Path: <linux-hyperv+bounces-1987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F68A8D7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 23:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52DF1F226B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2F481BB;
	Wed, 17 Apr 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="h5clj3FW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DE482E9;
	Wed, 17 Apr 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388095; cv=none; b=PkeeEEVLZrbexS7Rej+ZJkB0v5dUI0KFZFC+ULMKFzPd1zxP+YLbZfAvy9DZh2JNcgRuoL8mu+YY9tBFxU4r0xpKeaILpELDJu75JKmvBFuWoFlV3q19gAli0MlE26kBd4Qd7lP3usm2LIh9U0ic6smofv6s0amy1s6by0zHSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388095; c=relaxed/simple;
	bh=6XTjhVfcWILz9IhImskIpIS6JABggbT2vm44o9St4nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBXchEbBKpFzxBOOXPXAhRUABf9zyBLKVhr6nAcAZWsKlUcwA0Ph/ZcgOJmozxs4dgPODsPIJTfrUc5uTYGN2OrpjF3bAhT5h+zZDAQY/cFy4Gr1AMiIGeb3gL5rynq/IyIHuOBzPER46+DtyRs0SmheaTggs6PKXEgAQV35zsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=h5clj3FW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713388081; x=1713992881; i=schierlm@gmx.de;
	bh=jXS9XUf2pBfgJlVF7riFaa02n/bwTfTOXxl/5eo9XnM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h5clj3FWbkePSlmrBjQCXxacPgdd7Eqq6UB92ZHRrhyCW7Jqh5EXCdBxeNsxPEwO
	 5oHGfVmyWwPXfpegbYzaJ+TWjhDXNOp3tDMtgRs70+dZu0YUjGYDYBFhSLhKiJ9I6
	 cleu1FtSLJNS+G2Jll/vXXuSjAxMS0B0BAH1moXgudjf8BN6eLH2HFzPxtl5u8zRl
	 AIAfvjhaTz//+PG/Az1R15XkSiZoE/D0rax+JRlx0gy9L3RUxajmvZ/HptXN4G9mh
	 Z3DSttnARI1A04zBNzAhdd38PnN44PAhBuvFQwNW7NK3DWU6fWJTGDIhC7j6qtTtk
	 srgZHqOwRQKm1VVxSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([84.145.176.14]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1rqpmS2UiP-00BNdP; Wed, 17
 Apr 2024 23:08:01 +0200
Message-ID: <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
Date: Wed, 17 Apr 2024 23:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
To: Jean DELVARE <jdelvare@suse.com>, Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
Content-Language: de-DE
From: Michael Schierl <schierlm@gmx.de>
Autocrypt: addr=schierlm@gmx.de; keydata=
 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
 uxTR60TDY/d6Kz8=
In-Reply-To: <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YEpYJHhpX4E9ZgmqqHEssdGxgLiil9SD1qU3DCWxhw7iXVJluTX
 4WGYQT+OCpt34b7N+wylVDhC7x6Ek7AxdGBfk343phS+/bk0KYAsHf5EiD/vKeGR+tw6Zu4
 17UuhJ2RRz0WhLlJUyn/z/ktPGPLRr0icllh8FUlJy0dutf3+r4jCciYdyHymbioI+zMnaI
 JI63KFPk3vjH0MDfiQOYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BqLB82CrVaE=;XOV9qmBrIVRKlqI7oFDEP8/6Fp0
 yV9td+yFPj4Fx+agdVXSiQ2vkN29XPN5Yo1vvy1Dt1zBX/jnoZ0gh2oQShqwlMnT7TFoO6rBY
 Fjr/VSM/nRZviP1oZD033N+I8bMyYZ+/V07rxq7ueUaNslvsfZ51iaslT/C/PON0K7njh+kX4
 q6Q1IOFCxS1tO3qGH9D+732/MKVTmUsiyXp/ejNgVEBZpehjucaLmDw2H4Xgn+tfv4FbzgiNA
 Nzn7K94Lf1Ah/nplW7Y9K8ZtNjJ1Xr6evAaJrBZFaXptepKYz1jSgv2Ye+ol+VnE8JkGj/zYy
 Qj24EX6f401bHmvaxucmuG1OeQX96yJf3q8/O/+UfRpuptPjn78vvdS5JRzBhxkVPN/G9o4e6
 pSnT0MS5xTZ4hX+ClpBoXLSFHhaYY4w9CtGvbpGAXivA5Ew6PUa9sxHsLdNS7j/y4+fQLkqFm
 bcqfLq07dNuhiQm+eT7SzJBVM+SLyhwa05Ys8P70/cDgenCszWyh8RcXiN/jlBFzIq8vNCHjx
 AFthJB7sVO9w5VTOaUYqH6q2UjpifakTbTI7M5VCt00HW/AD67qNvkZ3lTXCh5Fs10063aAou
 tLsP+OYzV3LbytFHwbGbfPkRheU2/GAX7nwJDdgCiTpNs32d85wVG8YCyZYebEbFMVo1y2Tgr
 P4+PA3SwLeRZO6cwqowyM22wOf5cyZb4zQxtptoXVIZ7SxEAfR5PkyhNo9lrg3FSeCtm51ZNF
 0Zao1jDCxqszmIvj2BmYJMYAKU6ac+DIdr1Ia9ZLvJnJ1HU7rSKsUejwVkRkyWokVkxuWiYhZ
 Balm3qLksTN0V/Enuq/XVEzp4NSy5jxTCmLoaVIkv+3KI=

Hello Jean,


Thanks for your reply.


Am 17.04.2024 um 11:43 schrieb Jean DELVARE:

> Don't let the type 10 distract you. It is entirely possible that the
> byte corresponding to type =3D=3D 10 is already part of the corrupted
> memory area. Can you check if the DMI table generated by Hyper-V is
> supposed to contain type 10 records at all?

How? Hyper-V is not open source :-)

My best guess to get Linux out of the equation would be to boot my
trusted MS-DOS 6.2 floppy and use debug.com to dump the DMI:

> | A:\>debug
> | -df000:93d0 [to inspect]
> | -nfromdos.dmi
> | -rcx
> | CX 0000
> | :439B
> | -w f000:93d0
> | -q


The result is byte-for-byte identical to the DMI dump I created from
sysfs and pasted earlier in this thread. Of course, it does not have to
be identical to the memory situation while it was parsed.

> You should also check the memory map (as displayed early at boot, so
> near the top of dmesg) and verify that the DMI table is located in a
> "reserved" memory area, so that area can't be used for memory
> allocation.

The e820 memory map was included in the early printk output I posted
earlier:

> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] us=
able
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] re=
served
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] re=
served
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff] us=
able
> [    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fffefff] AC=
PI data
> [    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] AC=
PI NVS

And from the dmidecode I pasted earlier:

> Table at 0x000F93D0.

The size is 0x0000439B, so the last byte should be at 0x000FD76A, well
inside the third i820 entry (the second reserved one) - and accessible
even from DOS without requiring any extra effort.

> So the table starts at physical address 0xba135000, which is in the
> following memory map segment:
>
> reserve setup_data: [mem 0x00000000b87b0000-0x00000000bb77dfff] reserved

Looks like UEFI, and well outside the 1MB range :-)

> If the whole DMI table IS located in a "reserved" memory area, it can
> still get corrupted, but only by code which itself operates on data
> located in a reserved memory area.


> Both DMI tables are corrupted, but are they corrupted in the exact same
> way?

At least the dumped tables are byte-for-byte identical on both OS
flavors. And (as I tested above) byte-for-byte identical to a version
dumped from MS-DOS.


Regards,


Michael


