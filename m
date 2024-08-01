Return-Path: <linux-hyperv+bounces-2647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA53945055
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DC71C257E5
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D31B4C38;
	Thu,  1 Aug 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B1LSG9v/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2042.outbound.protection.outlook.com [40.92.41.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33213B590;
	Thu,  1 Aug 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528859; cv=fail; b=Cd6WB1VTjSRQbCTEZ7sni0zVhe7MZoX45i99ozHqs37jRuzX1I0YAKSUe61/3SfsYsnBWCRccaH7/E3ocyWPjH7nMgcKLboNYlGyugi9qnGYpjBsZ/lgWugkyOlboM7Z+kRX1BSgOX2tcHaaJEpw0KTg71C3XVPvuQ1yIEzSwZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528859; c=relaxed/simple;
	bh=Et4VibKXFOFPQ+MRcsSBPfgILxeLJrnISnuVug9F64M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6XKFvfTC99/osFqMzurxVUyjpfnBsrq021p1aM6sQ7GEwDuuwO7bOPOeyenUr8CGmZo1gqr8xRgplROCSuZJmnzC2msDv7WTXuxUxwcmtWmFhUx+wG5r7GPQ2Z+98ZmDGt9HG71/i3a2j76hT/oyoXkfaO6mFlCFmYpFTotqKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B1LSG9v/; arc=fail smtp.client-ip=40.92.41.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFkajlh8sYrW8621SpTFswiayYrIql29/weeZfrqe1QizP0K0xzla9eMKeeXPoaOc/+Dme31BJSGCpaX2jXHNEtZMq2YroMMs9R0J7q31tw+tu3smmJmncoSmf6lSdTa5NYpw8GWEnM65JF5020Pkm4kaGIRvP3/NVA0IDhebbM28oD3duGrdZAN9Du/N/eFvtQvUE5tvtdJMVxzGh2WIiKQtEyG1v7TtK8tU3EXXNBqFBd1AXBIheyT/HJyuBk5A+XAHO7hfCc6zF+FAN+lmH2xQyNlPhAAtsIzpq1rn8/9F+HKeQ/A5Q+54LzFdHly/siFPGUnX3idzf8EzZUsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InvlBF13WsgB3u/5B5JwFUricQtrj7dVEtZY6VI/XKQ=;
 b=WZtIYw3lYDoKteMUYcqyqoWyykkvCREr8QxK9+IHs/gPlaH4Jo7mOqAjnYKnGSx4XNHmHslfyQiZD9c+M9jFqklx9GlYyiZg7NrrLF9A0eLQRpYI54FZBAnJu2HJUbh3aHV8DuCJMX1S4ixg/JW1KM8RLBzczScn+ZVxkflMTXEeuYMJ932bglrqJywbjCGLix58JQ54gK49B9oxCSQj5hnChQTLYoVJbhhVV8npm6PS6qO/soI/9WLeL567EfRU1BqZNXLRE+JqM+JXN4YcWc7y0aqv0m0/m7pA0KkEG2/PE7UNtai1jE/5RZkAiuzujIi2mK/ebXZuGOZ1qI1n+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InvlBF13WsgB3u/5B5JwFUricQtrj7dVEtZY6VI/XKQ=;
 b=B1LSG9v/ETXbru1hR9+AkulfSjtLTmnPbdwwaQVSn/f+v8q0/gExAeZxXolJZ29y5pSofhkVW926qz1re30R1BlWfN7FS5PAZs/4hfCm6D5DpmYjfzKJGo+qIe/g5BzX8E5aKdYBk2y58sEKuR7qV12BiEXaxBZhG3xY5Po5mdTiTHQMdSFT5KYnFU4wHpPg0Z2eWtvtkkB2IDb7XaOIRUOARZRG8lSyRBrJmXkqskCULiQ0HYDSKmpLMR0FoN5iA4h4PUPQO3iyxKHuoPZyWNVFIlQGBBRRH58erf8bV+IAKrfd60/IAKjBAgxgkv6gJrlYaz4fqIVL1C1pK0RMZg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6719.namprd02.prod.outlook.com (2603:10b6:208:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:14:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 16:14:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "seanjc@google.com" <seanjc@google.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Topic: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Index: AQHZOpLxbV+L28WTRU2RxqUIZ1Q90LIVxvWAgAAeUXA=
Date: Thu, 1 Aug 2024 16:14:14 +0000
Message-ID:
 <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
In-Reply-To: <87ttg42uju.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fsq2JszTHRrVAvVWbZU0CigKSs1GcJb5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6719:EE_
x-ms-office365-filtering-correlation-id: 915d4265-2b2d-4e7f-87d4-08dcb244fc90
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 ILS32mV3fopI3frjF4n48dMfo1sepHroehsmBneDL1dRLmL98jnFgl5O3+GWQLgcacDjebKvtkqQprb/B6oFR1F0yzYoYbCjfD/k01NdwBWK5vKLdntKt0iabTXH6JdpAa3RXtIuaG5PiotX4ntw43KxXAhhxRJKPudU6Uymaxmga9bfZoCw/A4QwE2ajUqERwN3w9id8m4FG8uilB0j0h3OYY/PNRuyXvdp/MyJSmz6su5+IgXSQ39cf3HENljksQnVcnQC3JB2J4FZtsmz9ntCR8E2iuB2MO4Pa2BX/6lEP8DkYEy3rVXl7XTympt6Zz7qeteQ6tEZQ49kShectEBda82lN/Mh/69DVn+OSP0T7iZl7DmRF8fIFY2auKXDlwp5UmHHo2+8ItZLMl7HcK4JW6+E16erEHpUJYhGgRudTuhYb+NcAZwEFuX2h9QexcLEdOHIFmXgYS1dz1rU4+1HvYIN0/4H/sEIweVTQN6Nd7wWwiWXCH81JJWWNcF88aCWHZw3/cjsWLAdfX4sY1q1QRscWB2qC7uFerN+t/B3AjJDlYRNKqATsQMg25UvrtXGx65IxB8oEvPBI6+Hp7R5Kj3HkCwFOizANt3qVR6pWaZILZa0kH4KenAzRh7lVZqdSnIG2nYZNti5+82axg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UZXdVuBkSz9LFmfqtpbVp9F16FfsFCHPLmY/eGvjWU/Y1JGkIGgkACjnhCcT?=
 =?us-ascii?Q?+WAteB8EL8hnUGF0iEZpC6V8SGtkrL2FAR7XCEZOaqXOUOd0Cy3FcL2wdOVp?=
 =?us-ascii?Q?kg0/RQOKn/qDE5jAUxclXrkJ035UAwfvDqaYvXoqVG0FQ6TJh7zsyAF0esH3?=
 =?us-ascii?Q?IcJwoAQZFvBfjIzSBT8M8PN44TwptAA7VDwP/ZQ32fA4A3BJ8/mI5Pu/O66Y?=
 =?us-ascii?Q?CIBU6N6/NFLdabMU1cv6HLJUO3pDIQwrA63JaYW9FfjaWRRaxy8ugU8n9yVd?=
 =?us-ascii?Q?KCW4qBn3dKaQds8oumYHgIrDrzsoMq7Y3RN6jFlDHIohrxjECmVO1KYIcai7?=
 =?us-ascii?Q?JS9Qr4cJXfgp3ZjSCocmxj4gj/he9exp7MJIsedXaVwtJXggWvhLqwQaZ8Kc?=
 =?us-ascii?Q?zHhQVPo8ylDSs1EsQfh+P0GVOD+D0RdnxlHjqP5Ql+uSCeeZ1kQ/M7R/F9j2?=
 =?us-ascii?Q?uruVL3f5kHMoTVmfsnSsIxTtXLQTyk72TJMt5+SlpKgGgAl8oysnjxJpwYK+?=
 =?us-ascii?Q?M0IjWv6XLhoQeJynGlnrquitG5R+0OU+kLEuoDFKOASlJL7azJM9Xq9Yvhkn?=
 =?us-ascii?Q?pmIzsoiab5I20L4XW3N4F/PcX4UtgmwjN6sjYHGPXcGiVmXg7THMCzvvn5/P?=
 =?us-ascii?Q?1pcDuKKpp8is0b8THj9bMgTCKyzQZXNe7p6Tezx94Ey/Ss0vop6LktdKxn+E?=
 =?us-ascii?Q?NGMYP8tkzHAQMrcaGqk/xjDe4717ZBLxSS/SL+EFA6sskmcPnveSBlRD5T49?=
 =?us-ascii?Q?9H36msbza0SJLbsb115a48hpKlaOKxj26lfhrVXF2x1cH7s8r5U3Xa5U/9Jc?=
 =?us-ascii?Q?BN5+g94srUbYBbxRq2WicsHzcwohfJTy8RZj7XTvmzyD3Ybz3+dW4Knxgi1Q?=
 =?us-ascii?Q?33Eb6zBND8Vi1HYDIBan98Xy9WdoG5nzuxrFCj+/zLojiYkNHwJWF8iBRnN/?=
 =?us-ascii?Q?H0+1U6NRHTlmusWIZuSHVISaLNg+WMjk2F+5fftU276/gt8X2T0auGPpEYe2?=
 =?us-ascii?Q?Sny7q32y7YScR8DB/puCM6YnqWQ/lydx2MYwupLnvNR+BeAp3Oh98qru2HVw?=
 =?us-ascii?Q?+MqV/Fgu57FmgbLwta7eVCrhfdOMsREdjY+guDdNgVKHbfMfNGk4/qyTV+m3?=
 =?us-ascii?Q?EVHU7cFa1LD+EN9Xqfhqvwu4Te4fRaqOlpCCHQAMdTPIjEMdDvYc50EERrlS?=
 =?us-ascii?Q?opaTspswyvVa+qF7zyE8A5gFYAd3KzrNy+cCN3wY2Zo4/2dad1FEG7TKQB4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 915d4265-2b2d-4e7f-87d4-08dcb244fc90
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 16:14:14.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6719

From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, August 1, 2024 7=
:21 AM
>=20
> On Tue, Feb 07 2023 at 09:14, lirongqing@baidu.com wrote:
> > @@ -117,11 +110,6 @@ static int pit_shutdown(struct clock_event_device =
*evt)
> >
> >  	outb_p(0x30, PIT_MODE);
> >
> > -	if (i8253_clear_counter_on_shutdown) {
> > -		outb_p(0, PIT_CH0);
> > -		outb_p(0, PIT_CH0);
> > -	}
> > -
>=20
> The stop sequence is wrong:
>=20
>     When there is a count in progress, writing a new LSB before the
>     counter has counted down to 0 and rolled over to FFFFh, WILL stop
>     the counter.  However, if the LSB is loaded AFTER the counter has
>     rolled over to FFFFh, so that an MSB now exists in the counter, then
>     the counter WILL NOT stop.
>=20
> The original i8253 datasheet says:
>=20
>     1) Write 1st byte stops the current counting
>     2) Write 2nd byte starts the new count
>=20
> The above does not make sure it actually has not rolled over and it
> obviously is initiating the new count by writing the MSB too. So it does
> not work on real hardware either.
>=20
> The proper sequence is:
>=20
>          // Switch to mode 0
>          outb_p(0x30, PIT_MODE);
>          // Load the maximum value to ensure there is no rollover
>          outb_p(0xff, PIT_CH0);
>          // Writing MSB starts the counter from 0xFFFF and clears rollove=
r
>          outb_p(0xff, PIT_CH0);
>          // Stop the counter by writing only LSB
>          outb_p(0xff, PIT_CH0);
>=20
> That works on real hardware and fails on KVM... So much for the claim
> that KVM follows the spec :)
>=20
> So yes, the code is buggy, but instead of deleting it, we rather fix it,
> no?
>=20

FWIW, in Hyper-V guests with the Hyper-V quirk removed, tglx's new
sequence does *not* stop the PIT. But this sequence does:

outb_p(0x30, PIT_MODE);
outb_p(0xff, PIT_CH0);
outb_p(0xff, PIT_CH0);

outb_p(0x30, PIT_MODE);
outb_p(0xff, PIT_CH0);

I don't have a convenient way to test my sequence on KVM.

Michael

