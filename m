Return-Path: <linux-hyperv+bounces-11825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FHBuDo2kRmp7awsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11825-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 19:49:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DB6FBA65
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 19:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=YsU6Xe2m;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11825-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11825-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 886C1302F709
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF5381EB6;
	Thu,  2 Jul 2026 17:48:14 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011013.outbound.protection.outlook.com [52.103.1.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA738381EAD;
	Thu,  2 Jul 2026 17:48:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014494; cv=fail; b=Ik+jAGtR/ICnLi77wzkWbjwWMYWr9bKZJW1jQubvByxAzj6kg9Ymk+Mu7/wnkWyMXimNbUPVBx4HYcju7AHH95vo2SgV9OKHJ8VSAGPHKJ4wNxwVcA+N8yjLR7o1lcvnRJ/PY8tiDWb1BdrqV2ND5At3jNoYvzsIYkJSJrmy13M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014494; c=relaxed/simple;
	bh=FfQ035JU6D9MpQ+vrH0Ze0IW59fTH4qmXq1lQH0VNVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAK5OZhYStG+IJNikcdzze6AuHKafsDaHd5m7Jwn/W1m6s0P/4gkVIz4nnBDABS1bzWCbDaeG5qY+NaSVznuatsNVPwd7XFnHUonnYbCtj0nDer14IN4E5NlXn26Vqg+tPe0APVi50Cyww5zjnqanWEGieSZLnPMDy6dtKhBG8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YsU6Xe2m; arc=fail smtp.client-ip=52.103.1.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtYz6mZVqa+x8k+wF/ExqMa3lMG2xQ89vEMzvj1jy4kYvuqUqCrU+zvDWECeujr6duw4q+MGef/aPYbW5DyxveRpEFD9IviMlNICIblVr62jARsqWc8vyzZpoNXKbfOOB0mtIjlWOU48kVOxutoWeIvdCA6vqA6Cl0oK1EBymVbIQmfxnbhSbB08O6I9nYdkB35XYwAuiahQoxe65qBvjHnTgv9ee+P9XLAS3vA/EB9eXk0okHi1vQxrHIR7XjKi3YUQdOBsVObbiAgDrR7M/JJJUPj8K6EsMQMz9JWhwqlgsriOQ8GFLeiR3bNcG5rPm3dkco5XIKnoDPeDQhIX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF/dNgUAPKgXvgYHOIu4XocLCofCHLr1YWn24Zv2Z+0=;
 b=Oe2s20JC83+Z2Lwrg1m8O8+N2Jm7nqnqKQmjNsaNOtZBqp9EDcHr0cYh7qy4e+2k8DFJ47mpbcTlAhjRyXp5jMu/iXa9rxvbeHR7rT3+ycc8damCmxgsqNfoTnWRfLfpnBV/6KzpAHyMnCJIE0N0amCr2xYSW9eWznsZlg4ejwI7QyQ2zyA5AJ8iFCwmbyU4oGU9deV04rrdxuBsS1VG5QnsJsj40c4KRBGom9n4CUd3/xYWKiDTgQpQSc5zEexUaAd1xsRYjTK3Lr4v45lK96pZdxxyE/DbyItR8R+FdOnZpy3VBbZ6DOrQAn6tc4mP+JOrXfv/l8OzDzJAB/ZJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF/dNgUAPKgXvgYHOIu4XocLCofCHLr1YWn24Zv2Z+0=;
 b=YsU6Xe2mKi4pkrWmG465otDnzxZhDpfKwy7HhSX4fsl9MMSCMVCAKuwcJzKiPpv8SE3J01UL/W38oZCKcyS2z2Bz+ltS33wArpmXBmcoZ6JoXi9CrPVopWwXx3P/EkMatS0Obsp6mGYPOo3eWR54/pXdIjR0Vc1iCRkJfgKikm6txyJa8ojCz35dDJkyU72/u9cCp+9jhkhtTzHDBwdEKmZG92OjMC7gdgxuPp9PbgcX1hp8cDtuk3EkJATb+/D7XnLSP4uI/T0SapU1W8CVyzb8YsygyrsbidqtpUPZLYEIljGqyr/jIpsRlY+bNZPRovgfTkUziUoCnKrVEoEtzA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10144.namprd02.prod.outlook.com (2603:10b6:408:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:48:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:48:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Kiryl
 Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen
 Gross <jgross@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, John
 Stultz <jstultz@google.com>
CC: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>,
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v5 36/51] x86/paravirt: Pass sched_clock save/restore
 helpers during registration
Thread-Topic: [PATCH v5 36/51] x86/paravirt: Pass sched_clock save/restore
 helpers during registration
Thread-Index: AQHdCZB1dwmhmpW5S0uF1Oay95dScrZagr+Q
Date: Thu, 2 Jul 2026 17:48:07 +0000
Message-ID:
 <SN6PR02MB4157B9479825C6EFDCFCADA3D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-37-seanjc@google.com>
In-Reply-To: <20260701193212.749551-37-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10144:EE_
x-ms-office365-filtering-correlation-id: c3577bdd-ddd7-41d3-8060-08ded8621392
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxO32JBo/6Xj0q/IUmNyxK81DjJPNRS+7GLYAeX8QbO+oXhFFrbJB8myfneXiZHb4wpCkSb1knjoi5fJ2SzBjtbKkwz2HggYIp3qH4EMSOVGj/ID1EiDoSTSsNLy5W8JKhXABkiAcHsYPOvzQ7A1J5PkOYTPSUsZCDFtBiFaE9OcowlIeR2HStX9DW5RQct6iXUHNlw1Bkvy1S2OpMsbYtDEpbJ87QuqoCQwdAel5iMQvgCKo/NmC+hhDy5LNldjH935YL8I5D3qDEYPhwBaSR2Z0fjOaagYj9tEE2d94nnJfy0eDXGbNPXEy6uN0yTZXNTDFBnV1nuwmEds+SVuGIHPk2+zt22ZIVdTvPfIo74NJBwtGV0O80YNnN9MbsbsjS06p0DDqUJbgRzq1nSK2iNI1tgPOxX3ha3LFnq2UEMeuh45D19QqlE6lBbIIXAf+f6cgOZd3ofTL6esOzyJpTXIAMwE32QmrzmjUw+FLYz28x3tq9hY5KMEXyTD7IN7bzP4NhwFxGDU2GcKyOiCEwJcqoQOFuMj1dwlN2eoeGYZhNRbil21mjCVQSa+68QtdCwlgayQVuT8vGkDTLshY8soMhxazUxRs9+K5CiYrwZ7WK8dB0+cqZQrWfDHNXkw2pm/rs8CagOrmHq3acGv5i1kv0lmnnM2LDfQ2SF8EhBzaYubyM3gm9bbX8aYLmI0SS4eyFjQ0y/rI2rTDwgHGEJtXYhZWNE+PaTJ+eAPcPxRAI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|16051099003|51005399006|19101099003|2604032031799003|704163111799003|37011999003|13091999003|8060799015|8062599012|31061999003|41001999006|19110799012|25010399006|15080799012|12121999013|40105399003|19061999003|11031999003|12091999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?583mfXen6Mcf+6N8jqSL54LaJIVBlLQShuVP/FobtVnWTBhPPScF86q7RHZ0?=
 =?us-ascii?Q?Ru7tPxaIzfCprph77DjJLFaVDiu3hYPrfWkSktGO7a69RWUrnrGWNTRi9ucN?=
 =?us-ascii?Q?v18/zs2v/Pq5JNkf/VkxJ+c3MIt7T1vo13dfDubpl9TisDActYf5G38unkK+?=
 =?us-ascii?Q?ENhpLZE61P5DB27ZiMGVjnHY1AoDrbo+7H7xFHguGYvT2NkMwcQpMV8TJvsR?=
 =?us-ascii?Q?hHzB5X6b2mxvTy3MJLBVKnzRfk7+T9wcxjHDmXGAkWcEzkL8mrap41yIMFIE?=
 =?us-ascii?Q?QNO0uJM14S8WA9NLDSuKcVINCuXu3dfANiCOreXLX0Zbe263o5D1bGLr5z/8?=
 =?us-ascii?Q?84bSDGtRzOBgDUk8b8bEoZ9yRD0yvhkaSf15I5IUQl4fuZQzUW/O5sK6CF4C?=
 =?us-ascii?Q?lbTMWz/YuDfSjn1dRhf3t6jNf5alNCs4TRB/XvKyzuDJ8lsCJOtPF5AQJphu?=
 =?us-ascii?Q?l6HCuFQeNNEUyFXEc7gK5E1nUUrIH9TvTTzRFedQz0Sinp2LPOwldQQFoVXO?=
 =?us-ascii?Q?Nreod1Vd7eGwOtH9ZYN0p+SZhcW4lHZQzozfyaKhOYnCG4OzshLakSzq3OMT?=
 =?us-ascii?Q?scLf+C12e9qXDDbsw6xr/hzck2mddyc45N9ic3hABTSO3v9i5AsfxbkgHlBN?=
 =?us-ascii?Q?M3jkgXzl9Ox3ng/rWoQQXzfawtg6gzY7WwkhT9VvUY3XQsEYr+yJ2Jkx6CAR?=
 =?us-ascii?Q?4fsV3Xe1gLxmTwt/UlDbfMwRb4bpkFFkeXJNGmOehHqRtUrr0fvmRnct9DmJ?=
 =?us-ascii?Q?Ziamcnp3SXdo0sg8T19FEqICzywxyKWw4ryVc2ZPnmlRSQ9gN3iVYmAj1lLE?=
 =?us-ascii?Q?ra9OpKmlModRZBR8jmRn8ty1kooLar4AbDQJHK6YXczcINKZPergSq8zfdv3?=
 =?us-ascii?Q?vKGhyUgxgOjIxhsor5N+gyWdV23ebh0sXNxgKFhXrBx1o4wwKO0AMXOpQaCw?=
 =?us-ascii?Q?kkxz2ZHCHb/0u/6t/3GH0r93VAUNRKLJ4Um2Mbefm8Q1GCKYAgCMQDSIYEaX?=
 =?us-ascii?Q?2nPkeoRmu4MQ6XxHfyIslv3mCYzwbmbe6hW37uLEIpGOSTQCMZuEIJIszBF2?=
 =?us-ascii?Q?TY1dHesSnZvcXasP/yDorZ06ypiJN0gYco2/sceilJ5TYWhvBBoTNd0uByXH?=
 =?us-ascii?Q?lohrZoV0BbwetyFbFKeyl4zj7VQyAo1cLczRUFdqUsWsnXv/+N5n/MwQ9XkA?=
 =?us-ascii?Q?5LaZBeI2tc+lkO+h2rAqkpaRL7UZ7LAx8zsvA2jk6U+gJOYK2j8i58uB1t1V?=
 =?us-ascii?Q?72yiTPFWK0GN7ESg+5qJZzfwb4QH6zw1kiPr65VKbkm1+MI3Nxl6GbMtROCD?=
 =?us-ascii?Q?HSw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ooju6lp8Kv0IJer1HnQ3REULmZb5dOz25hSVv5ifBIxccmJfxbOBwAIB0ubY?=
 =?us-ascii?Q?4r0trWqslkalqnuJcBFBNpSYdINUBIyh/OBw/BtG21imZ7PAdk1IW+Lywt+r?=
 =?us-ascii?Q?Bfl/teca13r6hAANUGB9pTZNK7YevcV81SV5I54J9o5ht4hJPrrx+AOQ/fGM?=
 =?us-ascii?Q?jUDuabevRuiYA1zDkUJcSPP5sCoAAKceSfK6rwt3easEbonDache1r7GqdyO?=
 =?us-ascii?Q?+/RaD/Le9rC9lGRjMu/w63CryrPX3MwvUTtVNaOi3ec9e9wbKcNqGj9JX6CA?=
 =?us-ascii?Q?xolc1jnHpjbTuqJxXjVBYPf1g9mtmhYzKMTgYpIUmlMkIE0p0p4TBDZFfriZ?=
 =?us-ascii?Q?KSP4uQXJ2v3KYWw5hQIuMlvBvmqWzz/U8eot7GXoDAWHbslJq2khOGJSt9gj?=
 =?us-ascii?Q?+vTbLuT9b2rbyrXKKn6gzhUiZIVXyOWlfCi01i45GlLI52DxQEPZURSu+SUx?=
 =?us-ascii?Q?r06TjAN7AMvPoUklUBM1Upkn49w1R4y2nBXB+orLKt3QTqgc+qvLvHXXDi41?=
 =?us-ascii?Q?Fbu4PNcUs/JBTc5S/GOncMR1REsW+ckxeE2S8yPA3+7mE4VUa9updlrCpcfV?=
 =?us-ascii?Q?dPO1aN+PU/qLukk6FPj00zdgFzIuKhM80AGUUfPNZ3n9Eekyi9MYSHXWuV4n?=
 =?us-ascii?Q?zwXJr3nMGWp2a8ZhOC8nEZa15XRP/z7cNI14z3xbmfWZjixrG4Avdy0ZLMcO?=
 =?us-ascii?Q?tPM8Bw32dOSAdL7tMYSWjnTs8T/2XgePWc02dwYt/sxFlZkKfOwVcyP1hBAu?=
 =?us-ascii?Q?73iE7ri0MNsXA4nhiMJ0EKe7gg5I/1DqetHptC8nfLKLZByM/t3PGOLDqP5w?=
 =?us-ascii?Q?ZnVDVw177bgBd4R/+RxcdgUvOwGhgjcRZcsKuZxUGf7iNRIlpXLbsm4U1wJX?=
 =?us-ascii?Q?bD57Zwt4fHtZEiAPR6PB9iM+s9PZZe9oeOdLdFFsE0xpwS04S11n7wW+Tl0f?=
 =?us-ascii?Q?ua4L1GSkZUIe6GJSraQ53OKxVSQ6PqoVx155ECoQttE1g7LrsJwBLaBKgoEb?=
 =?us-ascii?Q?7gO+ym72UhXK7ZxX6JJERriyOuLXM4DBSUM02oUV7eO2vSCNob7LY9L6LxDG?=
 =?us-ascii?Q?gomdvZrna3E60aL4Q3nGlwxqjY1ofayQ3ExPN133bfg4ot1lh5ObaMi1KYB6?=
 =?us-ascii?Q?CcMnMbbEFr0SRJxI+KzrJEG/xPGJw1MpxWDZxPKRSDJQS5n/sNWtrq48Ky5P?=
 =?us-ascii?Q?zGW3ajxvruWow4SliJ0eYE9KKdDTb/Et/RpH8+blxlH6lLpEUt/92E6NtIbF?=
 =?us-ascii?Q?912JXJ8ZY/xCk9L39VWnEutHAMwkxSqdcDaqSaGSFkq8WMCM10Vy3vKY4D4U?=
 =?us-ascii?Q?DLT4elQRFike6WuVODeauQxJusObRNqow0JuTsi1F9Ni4RRJ7Tu3V8dy/TUe?=
 =?us-ascii?Q?OR8U0lo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3577bdd-ddd7-41d3-8060-08ded8621392
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 17:48:07.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11825-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C98DB6FBA65

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, July 1, 2026=
 12:32 PM
>=20
> Pass in a PV clock's save/restore helpers when configuring sched_clock
> instead of relying on each PV clock to manually set the save/restore hook=
s.
> In addition to bringing sanity to the code, this will allow gracefully
> "rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
> access to a "secure" TSC.
>=20
> No functional change intended.
>=20
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For the Hyper-V changes,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/x86/include/asm/timer.h       | 9 ++++++---
>  arch/x86/kernel/cpu/vmware.c       | 8 +++-----
>  arch/x86/kernel/kvmclock.c         | 6 +++---
>  arch/x86/kernel/tsc.c              | 5 ++++-
>  arch/x86/xen/time.c                | 5 ++---
>  drivers/clocksource/hyperv_timer.c | 6 ++----
>  6 files changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
> index fe41d40a9ae6..e97cd1ae03d1 100644
> --- a/arch/x86/include/asm/timer.h
> +++ b/arch/x86/include/asm/timer.h
> @@ -14,11 +14,14 @@ extern int no_timer_check;
>  extern bool using_native_sched_clock(void);
>=20
>  #ifdef CONFIG_PARAVIRT
> -void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
> +void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
> +				void (*save)(void), void (*restore)(void));
>=20
> -static inline void paravirt_set_sched_clock(u64 (*func)(void))
> +static inline void paravirt_set_sched_clock(u64 (*func)(void),
> +					    void (*save)(void),
> +					    void (*restore)(void))
>  {
> -	__paravirt_set_sched_clock(func, true);
> +	__paravirt_set_sched_clock(func, true, save, restore);
>  }
>  #endif
>=20
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 5c1ccaf4a25e..232255279a6e 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -347,11 +347,9 @@ static void __init vmware_paravirt_ops_setup(void)
>=20
>  	vmware_cyc2ns_setup();
>=20
> -	if (vmw_sched_clock) {
> -		paravirt_set_sched_clock(vmware_sched_clock);
> -		x86_platform.save_sched_clock_state =3D x86_init_noop;
> -		x86_platform.restore_sched_clock_state =3D x86_init_noop;
> -	}
> +	if (vmw_sched_clock)
> +		paravirt_set_sched_clock(vmware_sched_clock,
> +					 x86_init_noop, x86_init_noop);
>=20
>  	if (vmware_is_stealclock_available()) {
>  		has_steal_clock =3D true;
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 07e875738c39..5b9955343199 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -158,7 +158,9 @@ static void kvm_restore_sched_clock_state(void)
>  static inline void kvm_sched_clock_init(bool stable)
>  {
>  	kvm_sched_clock_offset =3D kvm_clock_read();
> -	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
> +	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
> +				   kvm_save_sched_clock_state,
> +				   kvm_restore_sched_clock_state);
>=20
>  	pr_info("kvm-clock: using sched offset of %llu cycles",
>  		kvm_sched_clock_offset);
> @@ -367,8 +369,6 @@ void __init kvmclock_init(bool prefer_tsc)
>  #ifdef CONFIG_SMP
>  	x86_cpuinit.early_percpu_clock_init =3D kvm_setup_secondary_clock;
>  #endif
> -	x86_platform.save_sched_clock_state =3D kvm_save_sched_clock_state;
> -	x86_platform.restore_sched_clock_state =3D kvm_restore_sched_clock_stat=
e;
>  	kvm_get_preset_lpj();
>=20
>  	/*
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 7473dcab4775..83353d643150 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -280,12 +280,15 @@ bool using_native_sched_clock(void)
>  	return static_call_query(pv_sched_clock) =3D=3D native_sched_clock;
>  }
>=20
> -void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
> +void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
> +				void (*save)(void), void (*restore)(void))
>  {
>  	if (!stable)
>  		clear_sched_clock_stable();
>=20
>  	static_call_update(pv_sched_clock, func);
> +	x86_platform.save_sched_clock_state =3D save;
> +	x86_platform.restore_sched_clock_state =3D restore;
>  }
>  #else
>  u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")=
));
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 477441752f40..8cd8bfaf1320 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -566,13 +566,12 @@ static void __init xen_init_time_common(void)
>  {
>  	xen_sched_clock_offset =3D xen_clocksource_read();
>  	static_call_update(pv_steal_clock, xen_steal_clock);
> -	paravirt_set_sched_clock(xen_sched_clock);
> +
>  	/*
>  	 * Xen has paravirtualized suspend/resume and so doesn't use the common
>  	 * x86 sched_clock save/restore hooks.
>  	 */
> -	x86_platform.save_sched_clock_state =3D x86_init_noop;
> -	x86_platform.restore_sched_clock_state =3D x86_init_noop;
> +	paravirt_set_sched_clock(xen_sched_clock, x86_init_noop, x86_init_noop)=
;
>=20
>  	x86_init.hyper.get_tsc_khz =3D xen_tsc_khz;
>  	x86_platform.get_wallclock =3D xen_get_wallclock;
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 220668207d19..8ee7a9de0f4f 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -570,10 +570,8 @@ static void hv_restore_sched_clock_state(void)
>  static __always_inline void hv_setup_sched_clock(void *sched_clock)
>  {
>  	/* We're on x86/x64 *and* using PV ops */
> -	paravirt_set_sched_clock(sched_clock);
> -
> -	x86_platform.save_sched_clock_state =3D hv_save_sched_clock_state;
> -	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state=
;
> +	paravirt_set_sched_clock(sched_clock, hv_save_sched_clock_state,
> +				 hv_restore_sched_clock_state);
>  }
>  #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
>  static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>=20


