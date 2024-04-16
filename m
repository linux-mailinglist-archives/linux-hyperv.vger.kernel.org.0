Return-Path: <linux-hyperv+bounces-1976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A853A8A76C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9F7283C17
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693213C673;
	Tue, 16 Apr 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="RAMMC9Je"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE66BFAC;
	Tue, 16 Apr 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302676; cv=none; b=XrCeZjKAO6NirNG2HMR6MvdLj0eQpyPyP9OQjA8qKBHIaCK2Ps1muEOsAfFIzCBT9+FbxLhrVN/SPXmsz9XwtX4eKDnYgxpxZFJLl/cdfUCQo6WR3xh//wdlbYE3GtKqRMiPd2yZOEFgqEm5Tz/CcjSsgTpBKTCgH/BlTaLVoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302676; c=relaxed/simple;
	bh=6Er98QEzCV3v4jZJfnwfJ5MZqGreJzJUCo8yTwZXUVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHo9XjSWpzQ8uBEQbIlh2BNNOmN9857XhbaTzVwqNW6M2giINJhuw1f3gmqvanxrkATTRNgtQNIYl+dHGH/w0U9Fy+MkeYxbKZg5Z1WubtRoLLCpg9oxq25T8bhakNufJHZXFK5Nw5GsWWfl2P49kuKXwVU109jbI4J504b3qkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=RAMMC9Je; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713302661; x=1713907461; i=schierlm@gmx.de;
	bh=Ka7LPxFhhP0ZNYDyQkBs58K1jS0AmF/oAMEmYL467FQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RAMMC9Je7Wm4JIrhW/wQ8uq7xxgfyWuK67oimBToPWFom2TWFNurBWuHjpQfUq56
	 4/dkQqmQAejk6b9K2uJWETt6kChBri5ixNN4+1N5+8SuajYFdtbaKMyE8gBE5sapC
	 Mhp+IDOB3ZS6DZ5HegVSMkBQrW1FHiupXvbKOHdMmfnFXjqxnND5lC496zjxSt5S2
	 oFGpXpRP4NUAlhc4Rua4GI+EKkVKCJcc+JT92AH+l0gWRIOf/Puf2jsA4uUqCOcBR
	 CuJNBSK262vTFE/BXvl9/a8Umf5yiSirE3TxljIUFq+rd9JgCAJ/5CzI531mOHb7K
	 kZTBrYui6rj3s3Iclg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([84.130.61.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1sK6LR399p-00U3Sm; Tue, 16
 Apr 2024 23:24:20 +0200
Message-ID: <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
Date: Tue, 16 Apr 2024 23:24:21 +0200
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
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: de-DE
From: Michael Schierl <schierlm@gmx.de>
Autocrypt: addr=schierlm@gmx.de; keydata=
 xsFNBF+amRYBEACvwIMUTYHep294xNuk+jKA63GkZl7D3SlI4LbzJt1Cm4AvT/mQ5/UV3bAG
 VeB6iXDeCH28bQNXd4DymSMEzgXVkmcNws4MzFhhA/mbRuVntN8G6zGnAJb9NerBLwhEcSzN
 vCG7FnUKOLs+z75rQfyuBpYnzMj5prrFvCBW/3fBElajvLbDT/ZRdU7QqFmCVy7dtdk++tz+
 5pZzN4Tfy2f+DVsvdWjrQ0NX8J0FsI5QtdRLHP3oRJLTuNl7Vff6CE/wPnvFQQjguoapolFz
 jQFX5krR2C8axNg00qIMviGpio/AAI6La1QdSP/CpcD2QfzZPIdIaQy4yUCE/BoTBPgZWdC5
 zwhmpN/qfSBs5QtUacL/4I+knomX/XyIqZNWqoVZ8FkX7i8AZO4ymuBwx8wZP5XUZwM6rzAd
 MMEKWrWWvks67uYmEuL4isP9QhZmG7EniWVt7is+X/alCT9cULEg+sXhHW4NOhCNlg020Bdg
 CHmdo7RecGqzKFIE/3RgYm+TwKc3YU/bgslIPu6Qz+Qqvz10Y4DFpyuNH6yOJMdRjpYpXYSF
 6EjkFdFJKBmdpbYx08QRjPaQzt6ZYLEVm/bFhtyoBE9fyLLOjt/kERoMs+Ho4uNpjPKFfFR8
 UD/SMkP7AaztCaQJT8EtczAXOtLdVar9+7143jEUuJlgg232SQARAQABzS9NaWNoYWVsIFNj
 aGllcmwgKFRodW5kZXJiaXJkKSA8c2NoaWVybG1AZ214LmRlPsLBlAQTAQgAPhYhBDX8Kw94
 NM6vtg6y281NaFzbm/3GBQJlHx1cAhsDBQkJRv/KBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 AAoJEM1NaFzbm/3GlIkQAIXZGienuIciGMXWcvRwDSjtm+tgoTXoyFCQKuhoa2EArpa5mRQS
 EXZ/68jdeaEoHii4u8utNSccLUVtM8DQTGOhuwhdjDYN2a9YcUtyVCoHuE9kqd6yURzu8uEU
 cb3ViQUDEkv3s0ZTty4VYuEYnV+BrhFMOvfY13HsMZQ+HNpqOt+3FjB17YBXyUc84RRanmIX
 BcLTW+LB/y+jpWaK6CvP7Mpst3HAXTl2fp/lERGLkDjFABqgbTxAvZG9baigUoFjrhniuukw
 7dZ0T7fwjDNvMRXFU4sigP77l9vwMqGwCrykYm0KnxtdWNM8mu8iPfHZyZTHv5siYv1URovx
 abh/6e0sDJKPipsWTIbD9AokYPzbinJNs9iVly5aAFQuo53hUnSxxjoWTPLtbgoAV4TBuScJ
 h40ij1cgq7cJgFORb/FhuNjgv/SJhQaL/YWBgywxI4XdMTj5mh5vIhJnewTiaLrSxDGm2aTQ
 O+T1r96052STv/yz8hFT2N1pMxXGtHONjQzrGyqg4b8oaBUv/qTCYGAJmFDCy5UC1awPuRcp
 pTmW5U75XjdxjO1pVxrZfWTMYy4I02XlEb6zisWZpwrq14rcl1C2XyNtD/q5I0q3MgKXpzxT
 AHSuS/IMrYHpCi4gkFDCuEQIa9QM33kPh6eAIL6zevBe1XnU1FIuk/y0zsFNBF+amRYBEACo
 T8ZSaqeSZ6RxkNu5f9e+Cnlvyc1R+UJUTD34nQMDzupXbbo8xCEjF6AefjopsOQ/6w4P5shd
 2RGlt2cUxq4RaNlogJSwXL8wzPJSkROtDrhYMBtLiZI6XK6H6IAlnkEZIvzZCVd0y1muhKXw
 C5x/9aKPkWFDVfpXvSHQ9chGOWVu6QiWHVSgg/y0+cATbun1gv/zkwD+pu1N6uZdlTw34uL/
 I2MRkuJIbb4M904y548aHXMDCILBRH26VQ5LwJ2jd0HblZEt+O+I6J7OovzAkFZTHu/2RvX7
 Sr2rN5XIMYTKApe+nqLW3nbCD526TX5mh99+4R6nQE+A2CF4Z1uBfXkVIZftWQ4zv6qJiqrm
 fCFH0uOcgN/Lrz8yz3iGZ/+cbV0B4IWeZq0EVHuKzD9mZyM2j7Y6Ih1gGIqfokNgueUh/hyv
 DY4fEW4QZQfGwXDCxUY44dmFAcfA941S7EWDp1XqtSS4COtejPzIud3zsGnpOQRJi2s4oUOn
 HHVr5TdDIRD7zu0hiOkv5C4k1PNJ68goMeu1FJzFcZDOd7sZ0x71OPi4FZ10hmTAB1Op+kiu
 RYoNuUfCA0xwZsGF7KUdIm/Qg69FIVCAPa6Vd2rTXIbB7pgmi595wVWObaSRYrwyBbUDCfMu
 K1BHqMUxwnZMYcELVYAkRq3U3uL7EihvaQARAQABwsF8BBgBCAAmFiEENfwrD3g0zq+2DrLb
 zU1oXNub/cYFAmUfHV0CGwwFCQlG/8oACgkQzU1oXNub/ca6vRAAlKbBvN7QJz5x1mPooqY0
 qz6+yJVYA4wWCFEWfdOF4oIDXR6WJpt09UNrp7JUNF2NtCZAoLdHMACMAaGM+9Ujrz93hZPP
 tRca7gyyolWHVIAz+setuGU9UDC9ut4MpolZbhbDunX6Ris8mkoQoWU7FgfQ8TOGTIhaPb2G
 rLWAIs6Qc5jtoIItnc8bbebZGn7drGKY7FFqOsggERR/6oO/mkcP3NL+5NAAX6p2w1fVLmrV
 D21olKqOBmSK/DS2UAKf22/MxsT0/3IKxrcL8sOqHkQ2TaDTysdWVyF1gTo9YUlbw6y/omzZ
 irDlwcCAxPSG2ysiDQTK/jWhmsPMZ5QclsC5/DBi369zZfVyzU6tIylThddxM+EV+l9GWPm+
 wTTrVT9VStkm2nQFIfOfZrmAX7o0hNiK+cB8u8EFni1MrMk+BY5EskFRcxq97+nhFZ3z0I6q
 obUwLL0gH1iO/zFXdStHju7NV5d9V/OXwPMcRvSNOBPoC2b6ekP7iN0RUwBHCyNrL2Vu3LHy
 BwZ3jk6JR+xhRvVn2gXIMKA6qJ5XEhzGjKYYg7MnbA73jXuaa8RIvWJbMmnzkk57czt+Nycz
 X/YlaN5mlntK0gHYX29ddh59l2atvpzOiOi9uiRMJI6ZI+jy141kvQTgjnxUOS9mQN853jLL
 uxTR60TDY/d6Kz8=
In-Reply-To: <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z7o3Ads1mcXcCTU2E8zTY/MWzn/c0Q+dPQ3Z8fLPcU9+Dt0zjic
 Hc5HE3tBwT7CECpxqzBCjtWT9VmK3lSuMeNnrgQnjti4vvwo0cKPj3tguRkNgrv8gfbjVCo
 2OqM8d1xj6Nlf7ENxLqrJYr7mlnxfD1gna0x0inNk3B2NdZCNc3uEkx5mgjE+z5OD6ZVGWs
 oRPyNqRYi05Tru/oAt2Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ATgbfHdK2VI=;bO2mVvUWqTtT1wd+CbJF0FTOVNf
 S68w+YTUu09BHLrsp8+yIVsQ/58hYOM6zvVBSYflGmiLp7KmK9CNsPlP7DPPJeDossZ2Q+QAe
 oUGoe1ssy7g/yCxaxBeP3AVQngRB7opPYzsXCeNf3eKQktjkcOVN7E0CUBkiVSbXYCdfFSJz9
 KXCNW0smLjzHW6/DyO2M63TnLz04xM6X0etc0GTl4/oi/LAVyMKG0ER1Fzo7P6BpuQKwMOLd2
 cxXjhbieHGJApLk46ETQifZprdcgutmjOH3JXF/N2UDoGorZrLinqJQ3XeX9mXSZn38KKJZZK
 Nwk492Difi85ANsHUqjP6W1m89dvG6RlonYDiha27RfFuMVsLzcslX1wck+wAURH8bYcJkEUG
 w4gkP7eo7a6zdovboTLsmB/6dhIVKU4LAXx8iX7DpZU+tj94WMVbpjqtlfZ02M4Rp/1yd09sx
 ai1RtLtC/jsQzZ2OnnNnhD+13vWKdGzmqWoOnkrs3zLusiIRUkZm+tdOZxLc9NHNeNWu1VCt6
 t6rmLScAD6PPDpaNi7kyUM9qKdAX6HHPTw4R+cqPDNOnPWYciGUh9bF7Kn2bHF9SAVay0TBRe
 Wq8F60mLVWLBB2yUUDIyPqQgj3wdycJo08PClj8BkIj4Z65FLjxghWcqkG1L0tHK3aCpC92NG
 JkEOyMj3kPnmOu9fyxWgKbA7jaG7NBZGEE3XhERK4f2uOIXLMB5ifemAQa06NENKOSvc+TTW1
 G15fJ0SSTewUD+rjGoxiFdvbjQl3AHiKhFpRGUnXvIfBqVY0a764fivYvPj6yHxIZH465NxXM
 e0GDuidTiopnlmQHD7E9GoEURT33jIYIUASxFnSIi9vIU=

Hello,


Am 16.04.2024 um 01:31 schrieb Michael Kelley:

> Can you give me details of the Hyper-V VM configuration?  Maybe
> a screenshot of the Hyper-V Manager "Settings" for the VM would
> be a good starting point, though some of the details are on
> sub-panels in the UI.

It used to be possible to export Hyper-V VM settings as XML, but
apparently that option has been removed in Win2016/Win10, in favor of
their own proprietary binary .vmcx format...

Also, maybe it matters what else Hyper-V is doing. I've installed both
WSL and WSA, and Windows Defender is using Core Isolation Memory
Integrity. I have also enabled support for nested virtualisation in the
Host/Network Switch, but not in that VM.

Anyway, I just created two new VMs (one of each generation) with no hard
disk and everything else default, added a DVD drive to the SCSI
controller of Gen2 (which Gen1 already had on its IDE controller),
disabled Secure Boot on Gen2 and added a second vCPU to Gen1 (which Gen2
already had).

Afterwards, Gen2's dmidecode looks like the summary you posted, and Gen1
reproduces the issue.

> I'm guessing your 32-bit Linux VM is
> a Generation 1 VM.   FWIW, my example was a Generation 2 VM.

Very interesting that Gen2 boots 32-bit Linux better than Gen1 (there is
a delay during hardware autoconfigruation (systemd-udevd) for about 30
seconds when booting Gen2 which I did not investigate yet), despite the
documentation claiming not to use Gen2 for any 32-bit Host OSes.

So I assume this only applies to crappy OSes that directly couple their
bitness to the bitness of the UEFI firmware.

To be fair, the live media I'm using uses Grub's "non-compliant" Linux
loader that bypasses the kernel's EFI stub. When trying with Grub's
"linuxefi" loader, Linux does not boot either, as expected. (On the Gen1
VM, the panic happens regardless whether I use grub's linux16 or linux
loader, and also with SYSLINUX/ISOLINUX loader).

> When you ran a 64-bit Linux and did not have the problem, was
> that with exactly the same Hyper-V VM configuration, or a different
> config?

All my tests were performed with a single (Gen1) VM, and the only
setting I changed was the number of vCPUs.


Regards,


Michael


