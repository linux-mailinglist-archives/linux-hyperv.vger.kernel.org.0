Return-Path: <linux-hyperv+bounces-2012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D828AB621
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094291F20F77
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3642AF1D;
	Fri, 19 Apr 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="FRToPgA1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C729D08;
	Fri, 19 Apr 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559639; cv=none; b=Z35BmIR8Hp8Oebvx2Aij9BoNQZv//Ynf8igrBji1p/FXg7Wzk1B10AIQS3iF0PO4eVdKR4Ua/qVwCnkRB24bfZ8z9mykhsr3Ll3K4GVpqg/rc7Yuht7mtlIlEW8+1097bl+ENZM6M2dJnbFYusvJ1tt8KahdLhq2w3qEZFbgt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559639; c=relaxed/simple;
	bh=7VpAFwL+3D3ttyUaSRw3OHV7fZ9JS8/eyOEtgwtnOfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIMNvINCbF6xAqiIij45Rsl/OFPMZtkQPFir00ktGhglZV3WAq9aknzwFWxKwVmZPjbDFerhw4icerNUeHZJ0CQ8GWt18elSR7KQwaRvcn1zCF7Q46LLpXVWef3NcgbIvkdgZwHky85q0rrVPiwIm32cvmEtzInZ/e1ASWef1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=FRToPgA1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713559623; x=1714164423; i=schierlm@gmx.de;
	bh=wub6ANDd/qCXO19TYMbZqURKk23D8Fpaj/WSvGcqDJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FRToPgA12HcwnFfF1hK+YB6bUmkKmPdDuZCMyrQkYkyA/xSbRp/ylQnjLAywVwE8
	 OEDb5i9auTdPfMG8sVIydyqeJPMDQDgZ/fkkEvOIrzqln2b1KOHBjgS1NI2Z7+3so
	 a32Pqg8dr5F4P3/RX3ISt3jSgCVguBqe50M/K2SZLbSnwzKY2XcXIoNMeR9uEsZzz
	 eKS+TOaxP8Ql0X2UyYgMZIofzh/u2YlsY+vUSIWYS5hK6uIu0o8Xh1z0jRInUd9o8
	 2JFdQXohKdpwYRTgpXunmlgu0bbMFxMZIK4QTV5AftKfFbPp20O2kwo2BUta6HTTj
	 obvYDLAtazPaRWEhDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([79.195.84.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1smb1i300H-016euA; Fri, 19
 Apr 2024 22:47:03 +0200
Message-ID: <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
Date: Fri, 19 Apr 2024 22:47:06 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Content-Language: de-DE
To: Michael Kelley <mhklinux@outlook.com>, Jean DELVARE <jdelvare@suse.com>,
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
 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Michael Schierl <schierlm@gmx.de>
Autocrypt: addr=schierlm@gmx.de; keydata=
 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
 uxTR60TDY/d6Kz8=
In-Reply-To: <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGze0OYyFXfWQdPVxVUe3OPrTjUG2jhfXbvVUBet4bz6FO0uOel
 m18BzIEhxLtdBQxVhk9mCFfMYA2wTGBlSJE3FcA/PQEnGIeeMNfnU8JveqA/NXWOPJQTWjQ
 MTWfW4feC6dyuy4FuCSga7968BWdt/hluqcPQeDGpTo8FOUG/Ln7ErJAkl6bI0sMTY8PiMz
 jCeOMsVSMl3Ai2cqciXkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XIvjN/1++JM=;L68oaGmWlkAoSxvQdPCniZWBwBQ
 fd2upuHBEy93QVsBr3M5OkWg6YWuJNITGOv2qIExx7x5IPgAnmMloZPxkxrh8E0kRg07UNxrf
 CmzsRwgQ83cwnlABWuai3uf9FmmBCVQ/e9f5uGM1E8B3S2gj3hoWQFHLgu+Hspv7v9gOBEfGy
 o1c4lYc61Z5dFMyzGeq7aBai/r+UOO+mKC3WKHQx7G1hqJqpHG0pgu9/zMgTIGb4vqLXWmoLu
 8cg28zHFOpF/jc9NvCL20EFZ0AxIj8XNbLlnvhT9l0Ix/skm5o1v3stnCbKDhqq57DBTfQ+FF
 NfYErhrAKZDllSNUQeLR95GuN2Ex2wHzHZT/7UktcPLEqxNjP6xq1Qxt4XDtl3k5Qi5g/a+2R
 3hCyXFEbnPwx/CDxT7zfonenBQuk32Wais/1RzAx/j/IndVjwtvk2FwHpvtT49HscNyRALds0
 4fzBsFm/sxXfuEGCgn/ltszZFAqMtg0pNnuaUFCCXdQM3mqHML+jBdi+1DaeV2csEgA+AjC4Q
 YiNOitEvkbhb0TXNGIrPuuYGv5y88JlqEdEhc43Y3lD2PI80gNKws51Yzppli76Oa8hBf/pin
 CKHQ89qOrHPFjr36Xgr56w6h+UKFJ9NcQO4m6oeIOvHDlENW/WJ/unefLdSUB8aBTC1aB2bw6
 c7cntg7yvVfmckFkh8Jtcx+A75IeyPCms6zoaRlAtXwpwSvIELyzHOR3hNIQd2GJbs9Im5BRw
 c8l8tXCqYL/g8eNRrRXRv7Q7J7iMdag7LEjyreAyxWyhZE0X5khpUXIGMm9TEg7f4IZxeBOM2
 yLoCCWigjX5QnCPNpOngd+tvqNRgkFZrcBohRbeTIU0dQ=

Hello,


Am 19.04.2024 um 18:36 schrieb Michael Kelley:

>> I still want to understand why 32-bit Linux is taking an oops during
>> boot while 64-bit Linux does not.
>
> The difference is in this statement in dmi_save_devices():
>
> 	count =3D (dm->length - sizeof(struct dmi_header)) / 2;
>
> On a 64-bit system, count is 0xFFFFFFFE.  That's seen as a
> negative value, and the "for" loop does not do any iterations. So
> nothing bad happens.
>
> But on a 32-bit system, count is 0x7FFFFFFE. That's a big
> positive number, and the "for" loop iterates to non-existent
> memory as Michael Schierl originally described.
>
> I don't know the "C" rules for mixed signed and unsigned
> expressions, and how they differ on 32-bit and 64-bit systems.
> But that's the cause of the different behavior.

Probably lots of implementation defined behaviour here. But when looking
at gcc 12.2 for x86/amd64 architecture (which is the version in Debian),
it is at least apparent from the assembly listing:

https://godbolt.org/z/he7MfcWfE

First of all (this gets me every time): sizeof(int) is 4 on both 32-and
64-bit, unlike sizeof(uintptr_t), which is 8 on 64-bit.

Both 32-bit and 64-bit versions zero-extend the value of dm->length from
8 bits to 32 bits (or actually native bitlength as the upper 32 bits of
rax get set to zero whenever eax is assigned), and then the subtraction
and shifting (division) happen as native unsigend type, taking only the
lowest 32 bits of the result as value for count. In the 64-bit case one
of the extra leading 1 bits from the subtraction gets shifted into the
MSB of the result, while in the 32-bit case it remains empty.

When using long instead of int (64-bit signed integer, as I assumed when
looking at the code for the first time), the result would be
0x7FFF_FFFF_FFFF_FFFE on 64-bits, as no truncations happens, and the
behavior would be the same. This clearly shows that I am mentally still
in the 32-bit era, perhaps that explains why I like 32-bit kernels over
64-bit ones so much :D

> Regardless of the 32-bit vs. 64-bit behavior, the DMI blob is malformed,
> almost certainly as created by Hyper-V.  I'll see if I can bring this to
> the attention of one of my previous contacts on the Hyper-V team.


Thanks,


Michael


