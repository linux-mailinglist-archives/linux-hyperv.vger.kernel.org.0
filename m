Return-Path: <linux-hyperv+bounces-3003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36264976DA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EEB1C23EF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46751922D8;
	Thu, 12 Sep 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GuT8ZUxB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2015.outbound.protection.outlook.com [40.92.20.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FA548E0;
	Thu, 12 Sep 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154478; cv=fail; b=GSQstVAwOODIcYzeSJTFMeb8l5NFspQZLNFOMrOT9hb8IQ7w5TDbY/xi4GLZGtLWahqWo3yc7j45kyLnb5Q6/7sduqu/ssurvNAqj06F47A0sJGfRFd9bZlrUSSYUdZvmKD3JBFw6p3gxttHgN2RXHAWJYsHQI/f1cKiPv07N5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154478; c=relaxed/simple;
	bh=ujDhE5Dj4VmyiNmw04u6javUfuPTCYto28x0cxmS88w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbphetz+ExOTpoV6dQNQIcXfF8kqA1r4Va8GGFOeYtZVEMd6bVbY9pWMIVTIgX43qvzXnH5fUTBhs9CcT7etvYyj5ac1l7pyJ3fTasu4pwhgAM/YwApe1vDnMDCT471frOeX5D1rj1DVJMwcBWuaIh2WGay+6SjPgbZgnH6JMfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GuT8ZUxB; arc=fail smtp.client-ip=40.92.20.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyCu3BATxEGC1jxEGaAOfCwxxa3gtAK3dZdHxF3EIdXesTlZeRzDHobcowXu0hihvUjib+ZQK/aCeF/l5ADjp/Ink+gYejVxhacOKEn3ji+8IWbt6ehwIk/faQsFfdeFiFW6EVYbpnuTEcFDD6g9/qMhPuzz/tJJQbiAqQEMaS9XkFaJS42A/S0xac+LLtt8uDy6cRSH1onC/MC6QrcySzUVVnoPh0UJMEDRcCdy0+uJDy0KZ31p+ctdABqNpG5rMojQJfSGy0hSEVp6PPnKH3p8jGvyhuMOWGYGJYYoSDGiIrIZOh4vgfTv1FF1Pv3tCl+I3gAnf1typYNfOQ7nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVAYKaePhUY/QT5v6m4DU1qvN+cbKXPgcVgpG5CIFTw=;
 b=t6lyF1ngTM1wd/IFtnnAuW+epeID/F/EWXHLBof5DgdELjtE0y/MNtLmDVYlhHtRtqBAk/t+ASvyVyzlYhID6qgC9rX74B2nOpl+7We2W3Bn4RN3LuM+fEeyUvR5aPBihzas0NXkm6eIdclAEepSM+LFXmnfIHiaX8ONUjZpU9EfPdUT96EiM6onIyp0aTTMLdaQ55moD+eFXQXmuNw5L7M2G2BgUiXPKtlX4vcqzRsBe8hq0AATf76jCuaqD4XLC5FgJO7vpEcyflQygUv0QxdKjFabFF2/UXKibY6b6P9xlRvGEGpo3QFdX6Hs78seVKw5r+tehl5yxELFZztN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVAYKaePhUY/QT5v6m4DU1qvN+cbKXPgcVgpG5CIFTw=;
 b=GuT8ZUxB1u7F6GkxcFjwPpNKJZEqzTtbglT9aahgsEXVVV3AXMJFuMxIpBE5YfPOJ34eUWgwGpmeAfT/4tV1AfivlxSQRLXqo1cUUdNswGJl/oYyYRPztetoYNvuPrWUFNwMLO4B19cN4/QKrMh7TTaTkFCGln265vVaexcxpUg2P6VxyHBWSPjYdD8peoOJI+Ez4KWyqlVPgRF2YDsLH+YB6eLOtwalPzM66sAbBOty+g7IZFFWqdxpZNEReL3J2XTSHAU3EPThZt9SXPdSueaZTx2BWH7IqctGDVhwc02YszVoXVTKIXzIeUgwo8sEKUruhFz7zfE0mZ/bfwDgzA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9060.namprd02.prod.outlook.com (2603:10b6:930:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 15:21:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 15:21:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
Thread-Topic: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
Thread-Index: AQHbBAcBfc77nN9oek2fyQW91c8qt7JTUAQQgABGjICAAKxhYA==
Date: Thu, 12 Sep 2024 15:21:12 +0000
Message-ID:
 <SN6PR02MB4157967915492AAF473CB682D4642@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240911045632.3757-1-namjain@linux.microsoft.com>
 <SN6PR02MB415797B9F0A29B91C6117D5BD4642@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c047e855-61be-4b68-8876-40d07e79bb7c@linux.microsoft.com>
In-Reply-To: <c047e855-61be-4b68-8876-40d07e79bb7c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [5y6UM/OsWqcDferT9OwzstJakGSBJkrV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9060:EE_
x-ms-office365-filtering-correlation-id: 3c679927-7628-4604-4c23-08dcd33e899c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 4tttuUJB00yZEX0SlReOSZNbhvUmpwMOsNd20oUlzrNiNKXnbzwL0W6199Nm6GzPtes7WjeO77FGyAh8qLBIHHd6Kk7UHFJDFXO0qAydl586R9BR1FYH1HYNP2EhvwNRF/FJy684HitKRYlGE2J9IokH8UHKE4U7+nVA6i9zsl8wx/GaqY6jzzxhiwynZq8eUlkQSKyFgzVqyIS/RegP9dJLAa3esJGFVw4ziwqox4e0/MvGMa1EkM5YNa9baeBI/7/hebI5057/7lynPhJI54JmhLWtXp1WSuIHGt+GOgn77o07ps5Zkbq79MWvmtvTwXW5vWOfCXe4NGd/NYg9AM9jWUEMyfATPQ4tHLGMBtabIADke6RSBS2sxNTeTVz5HdlTsvvQVr5uo3aXti5D//CkjxxMrl5wi7KnavIPi33AgJhHkyrqb1zIkY/6QohQc8k1p3wNJMxIqmiOFssBNhOCZDzgQDthSQiSca0jD72rRPD5eBu4T/czDLtfqto9jluy8fC7Faxju+mJY9CM7GcMlHKEETOMRnhCB/uAxKdTGHj2UleOs+7GcPuFPK4d5cZyWcohrGMWFo6cbzHhXyJGMSN32oWlAbvVvTd9eSGDhYnp0K7vDo1+1eC/djAfT755srsOX2GcqnnenQN7E133JxNY1IMc7bZLE010AOi2YqGgNDhMDOmovEGyV59L
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TKo9h+WlTZBLsErXKyE6Bzzolh5djGjtRf4wk5aPQD1737lMFpaWxPAUkGec?=
 =?us-ascii?Q?pZ2IToKXiZrQF5RHPp0aQ4AlHH7iOTjt7AoNQBqVd+yTonsC85WNehHML5Qg?=
 =?us-ascii?Q?YrNsTJmSIrFteKLpkaL6zt90c1jV2ba/WGw7JgZ7iH5n3AtrHgv2JUAe6Rtv?=
 =?us-ascii?Q?hLSiosxKUSPdLUPotc0g8P3A/Ij1OWOFiVbBI5bUzCFiaHNAgIC+xQePNljX?=
 =?us-ascii?Q?/NZsoDIuxJzEAKRoYRU1/hP4rcIJCIYFVvef6wL3AEhA7iR3Kje4ic3XsgVC?=
 =?us-ascii?Q?Qn2P9GytjA8UXcq7cuG4TLDvqRxls74QbKKG4S+lgyt8hEhiIs0E4sEGN7iG?=
 =?us-ascii?Q?MRYNDHWEF0DLU3DFdfLN1ysNHnXDN1p09BKCqu8e6ZLIEwtjDqoWGDH3r/Qq?=
 =?us-ascii?Q?dULeUVbz+6BgcOC/4tuTb1N3GRwS7z1rWv2Js6v4ijVqt/isHQDcs4LWBri4?=
 =?us-ascii?Q?ASlk65HoucT01q6O8NvJiAsJz3ArkwnenwQR/rdSP2R0ALY9ZG4awvwlq7iL?=
 =?us-ascii?Q?Ex8E12PJS5Sfp506ZvVh3UytY6KyTZCM5jpZh5vrOins8zfSorYFBMqjesdB?=
 =?us-ascii?Q?qtagXl+ttro1RPF8tY5Jr6QM0zKc6t7t4zfEQSozWEWescFjKg1UYVdnZfe+?=
 =?us-ascii?Q?16G7WUnIoyBYq6/iGW4s76eBa6DP96PYTILd4y9rkMOJci/U9vh8o7qNXhzI?=
 =?us-ascii?Q?K/MVNdiMxh3F9JniTHQF+3YGSQ3J0C7n67vzfV0UYn2KMylXn6GmZgNhJTWp?=
 =?us-ascii?Q?CJc03pHX6cp6Z8Kk8v/VOlD5V4QQvTe3svdEpwVT3kCK6xzsrszIV4HD11y3?=
 =?us-ascii?Q?f1buHFxt73SbnJqP/hvN0PknWvqgc637gfSqo3qAGLgepfxGtoVcETrcxC5u?=
 =?us-ascii?Q?cWSl1SjlId+MVktId5Ej+rEejLKRCtqad3LW9eeTIR5Syk23NLNfJk1cUdRg?=
 =?us-ascii?Q?fb5lceYj+k0fBCLAsDs+XZt8NPN9OnCC0EEKXRFdXQMeIWGuuoEkurCHttWw?=
 =?us-ascii?Q?dPG7E3sxyWTOXSTJxABwNG1WiUBsVQGV0MGuAN2wJysJXp3JtxWnkrseV/gR?=
 =?us-ascii?Q?4/+tSUriDzKhBFngnp0FNDiiSAxqDcankg4DMykd9BKJYBu/JJcrtDCGFYTD?=
 =?us-ascii?Q?2LIc0+j0ulVUuIiQJfQx7ukj5e3wOIIyrbp12caM5nh1TXtRc0hdKyP5CqxG?=
 =?us-ascii?Q?Z8VGFvwXxqRyuOOCBjlthL5wEp4q1L/S+XhJLfF4PIZbbbVxrPKx7MTKr2o?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c679927-7628-4604-4c23-08dcd33e899c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 15:21:12.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9060

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, September 1=
1, 2024 9:51 PM
>=20
> On 9/12/2024 9:09 AM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September=
 10,
> 2024 9:57 PM
> >>
> >
> > This version of the patch looks good to me from the standpoint of
> > separating the x86 specific functionality from the arch independent
> > functionality. And I think the patch works as intended. But there
> > are parts of the description and variable naming that don't align
> > with my understanding of the problem and the fix. So I've added
> > some additional comments below.
> >
> > Nit: Now that most of the code changes are in mshyperv.c, the
> > patch Subject: prefix should perhaps be "x86/hyperv:" instead
> > of "clocksource: hyperv:".
>=20
> Thanks a lot for reviewing Michael. As you rightly pointed out, these
> comments and variable names made more sense when they were in
> hyperv_timer.c. I'll change them accordingly in next patch.
>=20
> Will change commit msg subject as well.
>=20
> >
> >> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
> >> bigger than the variable hv_sched_clock_offset, which is cached during
> >> early boot, but depending on the timing this assumption may be false
> >> when a hibernated VM starts again (the clock counter starts from 0
> >> again) and is resuming back (Note: hv_init_tsc_clocksource() is not
> >> called during hibernation/resume); consequently,
> >> read_hv_sched_clock_tsc() may return a negative integer (which is
> >> interpreted as a huge positive integer since the return type is u64)
> >> and new kernel messages are prefixed with huge timestamps before
> >> read_hv_sched_clock_tsc() grows big enough (which typically takes
> >> several seconds).
> >
> > Just so I'm clear on the sequence, when a new VM is created to
> > resume the hibernated VM, I think the following happens:
> >
> > 1) The VM being used to resume the hibernation image boots a
> > fresh instance of the Linux kernel. The sched clock and sched clock
> > offset value are initialized as with any kernel, and kernel messages
> > are printed with the correct timestamps starting at zero.
> >
> > 2) The new Linux kernel then loads the hibernation image and
> > transfers control to it, whereupon the "resume" callbacks are run
> > in the context of the hibernation image.  At this point, any kernel
> > timestamps are wrong, and might even be negative, because the
> > sched clock value is calculated based on the new Hyper-V reference
> > time (which started again at zero) minus the old sched clock offset.
> > The goal is that the sched clock value should be continuous with
> > the sched clock value from the original VM. If the original VM
> > had been running for 1000 seconds when the hibernation was
> > done, the sched clock value in the resumed hibernation image
> > should continue, starting at ~1000 seconds.
> >
> > 3) The fix is to adjust the sched clock offset in the resumed
> > hibernation image, and make it more negative by that ~1000
> > seconds.
> >
> > Is that all correct?  If so, then it seems like this patch is doing
> > more than just cleaning up the negative values for sched clock.
> > It's also making the sched clock values continuous with the
> > sched clock values in the original VM rather than restarting
> > near zero after hibernation image is resumed.
> >
>=20
> Yes, that's exactly what this patch is trying to do. There was an option
> to correct in suspend-resume callbacks of original VM in hyperv_timer.c,
> but these are executed very late, and we still end up getting many logs
> with these incorrect timestamps. We took reference from the code where
> tsc clock correction takes place, and thought that similar should be
> done here.

Yes, agreed. I'm glad the mechanism for the TSC clock correction
is available to use. :-)

>=20
> We can tweak the commit msg to add this additional detail.

Thanks. I think the change to make the sched clock time (and
therefore the dmesg log timestamps) continuous with the
original VM is important to call out.  It's a change that will be
visible to users.

[snip]

> >> +/*
> >> + * Hyper-V clock counter resets during hibernation. Save and restore =
clock
> >> + * offset during suspend/resume, while also considering the time pass=
ed
> >> + * before suspend. This is to make sure that sched_clock using hv tsc=
 page
> >> + * based clocksource, proceeds from where it left off during suspend =
and
> >> + * it shows correct time for the timestamps of kernel messages after =
resume.
> >> + */
>=20
> I added it here, but the same should be added in commit msg as well.
> I'll add it.

Ah, indeed, you did add it in the comment.  But yes, it should go in
the commit message as well.

>=20
> >> +static void save_hv_clock_tsc_state(void)
> >> +{
> >> +	hv_sched_clock_offset_saved =3D hv_read_reference_counter();
> >
> > Naming this variable hv_sched_clock_offset_saved doesn't seem to match
> > what it actually contains. The saved value is not a sched_clock_offset.=
 It's
> > the value of the Hyper-V reference counter at the time the original VM
> > hibernates does "suspend".  The sched_clock_offset in the original VM w=
ill
> > typically be a pretty small value (a few seconds or even less). But the
> > Hyper-V reference counter value might be thousands of seconds if the
> > VM has been running a while before it hibernates.
>=20
> I'll change it to something that conveys the right information. Thanks
> for the suggestion.
>=20
> >
> >> +}
> >> +
> >> +static void restore_hv_clock_tsc_state(void)
> >> +{
> >> +	/*
> >> +	 * hv_sched_clock_offset =3D offset that is used by hyperv_timer clo=
cksource driver
> >> +	 *                         to get time.
> >> +	 * Time passed before suspend =3D hv_sched_clock_offset_saved
> >> +	 *                            - hv_sched_clock_offset (old)
> >> +	 *
> >> +	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a=
 correction.
> >> +	 *
> >> +	 * New time =3D hv_read_reference_counter() (future) - hv_sched_cloc=
k_offset (new)
> >> +	 * New time =3D Time passed before suspend + hv_read_reference_count=
er() (future)
> >> +	 *                                       - hv_read_reference_counter=
() (now)
> >> +	 *
> >> +	 * Solving the above two equations gives:
> >> +	 *
> >> +	 * hv_sched_clock_offset (new) =3D hv_sched_clock_offset (old)
> >> +	 *                             - hv_sched_clock_offset_saved
> >> +	 *                             + hv_read_reference_counter() (now))
> >> +	 */
> >> +	hv_adj_sched_clock_offset(hv_sched_clock_offset_saved - hv_read_refe=
rence_counter());
> >
> > The argument passed to hv_adj_sched_clock_offset() makes sense to me if=
 I think
> > of it as:
> >
> > 	hv_ref_time_at_hibernate - hv_read_reference_counter()
> >
> > where hv_read_reference_counter() is just "ref time now".
> >
> > I think of it like this: The Hyper-V reference counter value changed un=
derneath
> > the resumed hibernation image when it starts running in the new VM. The=
 adjustment
> > changes the sched clock offset to compensate for that change so that sc=
hed clock
> > values are continuous across the suspend/resume hibernation sequence.
> >
> > I don't completely understand what you've explained with the two equati=
ons and
> > solving them, though the result matches my expectations.
>=20
> Yeah :) it made more sense when we look at it from hyperv_timer.c driver
> POV because these offsets are nothing but reference counters at
> different points of time.=20

Well, yes and no. The value of the Hyper-V reference counter is
an absolute value at the time it is read. But the hv_sched_clock_offset
is a "delta" value -- the difference between two absolute time values.
While hv_sched_clock_offset is initially set to the current value of the
Hyper-V reference counter, it is used as a delta value. And after
the adjustment is applied when resuming from hibernation,
hv_sched_clock_offset is definitely no longer a reference counter
value from some point in time -- it's clearly only a delta value.

> Having said that, I think we can go with a
> comment explaining the intention, and skip adding these equations which
> may be confusing here as there is no concept of offsets here, as you
> rightly pointed out in your previous reply as well.

Works for me.

Thanks,

Michael

