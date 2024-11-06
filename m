Return-Path: <linux-hyperv+bounces-3271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F69BF566
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4F1C22404
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8664208234;
	Wed,  6 Nov 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jby1XA8A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012053.outbound.protection.outlook.com [52.103.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E9208231;
	Wed,  6 Nov 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918166; cv=fail; b=XOXYyTURtdie1xzeBt3rSKVcONZSFvxVyWn3xUtN/4Wz7g2uBUUAGlDVOmd1gqplH0VxfFr0Fjcn2Ip+NRyutUYuG1E7aaoLAJytYWFe+VLFGL5i0++tlGOYUEfnTQ3U62T+ORFvnfonP88DCOxAC7vXKSswl2BcxT3ih/qv/kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918166; c=relaxed/simple;
	bh=JbfslXCCmOec8v4lgS1FGjJY1ecf02aco3oNkpGk+14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MIFcr4f8Ts3SDfrMFinhGkhAHUXqaQuCCi9QujcLdhDTPG2EPY5ha0jh+6VeRe7ttxd/D8gn4bScoo+Nrhp09BTT7MlJm2fltgWAHwQ7E3Bd5e7yeJE0sC8Uc584Dbps2WMWoPmyDAzaFzc0F/c9fMDYZ69IZ+M1wyofeBvjBys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jby1XA8A; arc=fail smtp.client-ip=52.103.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxULdvLjeIr2VuB5uX57/zEERJ5VIfx/LHlmroTFuXCUAOXgv8lVWC1dKNt2SbwrVmfOtqo507R3T+xGvWwo+TqEzOIQPmIwo/Bx+YPDPmWn4UO3uf4X9o+9NMC+EHbhPwUiwmwiKtkxxQp1kf5p18vC24Uko/pal8Qlct0ox/PuB99EwHf6jrAsue4fwar52gwippKL7FjbWVfEmuBJa6M6c3LhQnA8wIC7GZpwegkz6GU8UnmD5w9Ich7QtAnMz3VdfM74J8+e9vpxP7gWfGwyvUZMDypF58REf31Su1Ln+5iDBkKLlFJeemj8qvS8uRnTvkrrgJe8kEWEqVyCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMUrQJpISugJn9f5hUxntg4EN90tSjB6mFk7624UHmU=;
 b=Gy0W+xuy5pQ4lhxjB3DfFk7DwLRzdpKR3MvvJ7ENXPmsQ6b48Q6RtkeNkfKM4uj4PhG1jll3xnc7WcaT6gsj3GZL5rbIc9zZXO8gHTPzBA+d9wj3pgGCdHHfn1SU3IkaLe6L9ixl3bOsBDBS4qvFMxsgSlfOAT+qKHOZ4JZ0TuogPAYvCeFucFFlijD9Vodh4SlUJ5Kas34ahJNGT9CwvGcD3wbJekOesj210O5xz162dg7xII+HMAhOb8x3U0R2WGdADR+eBKI9vhpb0VHXGt7rzdhqgLD3WZHOGBgl1p0P1QyIcD44+M2kmPEIo9bJ77KJA71leagWqETapSPQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMUrQJpISugJn9f5hUxntg4EN90tSjB6mFk7624UHmU=;
 b=Jby1XA8ApNDjTWy0z+owx3774c0cT5HUI72a3VbQcjv0w9bmWS3UD20VjoqAVPnmZ7zwuJcBAWXpQ3EW7tQKGSEdkocn9G9AMpijbzeh0Oi2xtKLsNEhGARXoYgKmqsmr9apg1Wic3qKit3r5n1CAqldb/0FoSwtuVOeKpKw6gtmHZXa+CCA5FXKMI0Q/opT6FO/WnBFB6VsaTy1082zMRj6EY79ye12pSvJJdqyRBkyPu1f+jdfmADHmDHccPAnm+24H0AR5Uph25taoYNijd+q7ZILUDzwwgty87KU+hPh5oONMrKXmfY0jepJeAxQ3w5NfC9OKpRMakJ/MvGCOQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 18:36:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Wed, 6 Nov 2024
 18:36:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: RE: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Topic: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Index: AQHbL6XJIfadeDv0d0yyLToHQBS7K7Ko9XYAgAGYDrA=
Date: Wed, 6 Nov 2024 18:36:01 +0000
Message-ID:
 <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
 <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <877c9htw1n.fsf@redhat.com>
In-Reply-To: <877c9htw1n.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9865:EE_
x-ms-office365-filtering-correlation-id: 7b9348df-700d-4a23-8aab-08dcfe91dd63
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|8062599003|8060799006|1602099012|102099032|10035399004|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1+Bzs6t8+jg56uVJeG3+a21kd8/x4Bn3+DZ07LXGq1PzIJmquXntVU6h4mYm?=
 =?us-ascii?Q?C+1v8qpRHt09dqTuvC2Y/jbI6jyDZrhnpDf6hrAcRKVlxccmRFO7ZSYe7nG3?=
 =?us-ascii?Q?c4c4FKc5rAI6OSa3hGbWjxxTvXRHzM8CIFRVtxcnbji4iJfgsuez53QwlRjl?=
 =?us-ascii?Q?tC3x8Zdbs14G5UpzLsFFPL0rgR4b3o2UoV9qoLeouCQYdZc8RMBfRXkSLWv9?=
 =?us-ascii?Q?ukPCJlv/BzmbJ32eU+9RhCTJ8xOBlDDiHN5oEWrLEDb/Ew13sYmXvTVOqLGR?=
 =?us-ascii?Q?OXJHCs3L6noZ39j96x7Csp2Ye0EPmfk9rZNlJ1mJrtt1z9K8QlJKgI0ltaBs?=
 =?us-ascii?Q?3oZnFdDamoDXZuXeztzfg1c18EOz3q6veEB97PA725lpNCNv2msGgHd8F/qf?=
 =?us-ascii?Q?mXypyFYeGDsAj+HdkZGWjqdoJyFfDQCwFii6XOT51UZDnwN1UqycY5YWcO9R?=
 =?us-ascii?Q?3i2y4b9N/oovcDI0nbQJ1cqetnAwC8sV9oD+0fTc2F3byRETiOw2i/9bBo5R?=
 =?us-ascii?Q?LzFo0dy5Bklzwx9mQITk3/eOJ9kacSUQvRXZYw62u798xB9FR2bLrW3zN7gQ?=
 =?us-ascii?Q?zf/G6jYTmTfld3ce0+gz2GxGPdO+zOGjmCDWttAKg9drWatR6PpYIfA5tnOZ?=
 =?us-ascii?Q?3WjPaM7qlY6g8owtqleCqp4HgISfDc94dGzS4xYf0spwqMMYO9n5ONTdZnI3?=
 =?us-ascii?Q?yRWdeRgmr76nxTnyTSDNHGBucZJtb04qsLhrA7xEgpHBMUBuwZT8yrxvK3GM?=
 =?us-ascii?Q?dZ1+g/VDxoj/A2FzTdFG1RUdGp4Ev+61R0aufffLGpDRmUCljWD4w25SGURZ?=
 =?us-ascii?Q?sTxgU8KhCiR7yuNlvG9Pp+HkLyTMyglXCDt4sA+LOuRv/uqxZU3ARRqD/EoM?=
 =?us-ascii?Q?opYDZ2tCWMnYjOn34NhJsOzheCPsRW9Tg8Lp9UnZzJxejmTcwYdA7EZZT1+/?=
 =?us-ascii?Q?5Iwq9vqNhtHFM3otlLTx024jAzoNSm+T5ZLhJCVO3f/FRI7LZp6fiDabLHze?=
 =?us-ascii?Q?T6L4a3Ln2fe5YN9HWLhWrBT168RBLWdi43aDlL5aOKqVmRU2Dniz4Nmu3jWj?=
 =?us-ascii?Q?u2Ue9vNsONrOY2CURXLO+WjvZSQsplw3EW8RgEG8/urbDm8D00CEbDIdcps8?=
 =?us-ascii?Q?b54aY0ddn62/m2EumN+MJ12bcZ02nDDv4psJwS/nQC/jAo9MHMQ0SL8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qbeNr2lMa9okNlHhlK9m9WAM69yZhTJIfjLM6prTuUPtcd7JoAuaEmmoTQJ3?=
 =?us-ascii?Q?Lk16Ys34O/t3tebf0ZxYudaA3j2xkMkHHPhGywGsyFjsBxBqc0zsuOY683V2?=
 =?us-ascii?Q?p+yMwZN+EQ9nXPBZWHVn+9c7zGZWzj77kn2Tg6HTVrJwr3/OXXrZkF264ce9?=
 =?us-ascii?Q?phv1h5YMM6txvPxfy76h24ADmJVb/ahWEep8PkvtIWzENPdBA5yB/UF9yHG+?=
 =?us-ascii?Q?u/FAC9B2t2XxPUrPA2MVYsgNkHt1V876hGN1d4IE8uXPv8Y7lzQcPb+RycLN?=
 =?us-ascii?Q?qfhm+RmU91qELYVVTURABGjm/Cd27zoOOlA13ZFLxxlS8BtK2qfNGxKJMNBY?=
 =?us-ascii?Q?XzSckREJoTquwmEnHc1eKcn6T2bA1S8+3LZVznS9AVowUp3dWm1xAAJsA2UF?=
 =?us-ascii?Q?uwAs4UTFZZMKUI7afoVwZQg6Jsu81rgAGF7KJGF7jhqBa2NYFwylgCmAyzlK?=
 =?us-ascii?Q?GfWIcpeRbiX3HVG0DZVPCUClHADr/qVJ/e14+D9uyyyBLVpxFWofQCKCVtO5?=
 =?us-ascii?Q?mHAGqa4dSn1uZ2O4pimDVv7Uh5kdUMRCS4Ss3m5l71D1JrSSrYYMmBsIWyLT?=
 =?us-ascii?Q?5rfGInCzkIokJlmidMGgzpaJuyGemYP4wtOXpHPMYJSCHKXlt53Bai7fPPD7?=
 =?us-ascii?Q?9sRJoakFgxSeOPHIgyRimr2s52oYDk7nEiSD29G0pv8ruGXPOAL+RA+CmacF?=
 =?us-ascii?Q?xHyDnhx0wRSryhM9AvfnIEVl8HvPX9mMQIStAQ1GaVEd1JW2bN2NwY4VpQd8?=
 =?us-ascii?Q?wTcPl3kVrFrQO649NjeI4iMXQH+xRFDfzKnFXSXokCzDAxDM1BW6MhsIKpKE?=
 =?us-ascii?Q?xceARYwjKMN0g733fxicBa56skoKgk13XxoClfq+Z17KRTUz9gTxo+gcgkSp?=
 =?us-ascii?Q?lQn9Jks0NYtOlH3Em8pia7BS1/i10RWtR7XIE2b+DDdRhW4GhFH8wGhMnsv3?=
 =?us-ascii?Q?LIOhzG9qCgGwLnAe8d5EBdnx2BHnfHCv1aCbp6xGKIOtFK/40sQ9mxyI6GWr?=
 =?us-ascii?Q?SPgbsCP5E9oRXd4hzPanbAfT/KaQU4yN5Isswgk2S+VXUvCtwf5JND+o8gR/?=
 =?us-ascii?Q?c9t+cPLNh5SjdV2E5QXkB4D7G1zXzEiFxKtdOlNptTGQPIQxLIqpBs3J7DSX?=
 =?us-ascii?Q?9Ac77Bv02L2457tlYAyUwyUn+erewQVAHNMDCddj130BYTBF8INe50Zrh+SM?=
 =?us-ascii?Q?N7am4ePUZrOzBMhviKD6AaCKUg8OXng5JTJv77BZ5TxeCxrYZ5SR2dagtms?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9348df-700d-4a23-8aab-08dcfe91dd63
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 18:36:01.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, November 5, 202=
4 9:45 AM
>=20
> Saurabh Singh Sengar <ssengar@linux.microsoft.com> writes:
>=20
> > On Mon, Nov 04, 2024 at 05:48:24PM +0100, Vitaly Kuznetsov wrote:
> >> It was found that unloading 'hid_hyperv' module results in a devres
> >> complaint:
> >>
> >>  ...
> >>  hv_vmbus: unregistering driver hid_hyperv
> >>  ------------[ cut here ]------------
> >>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release=
_group+0x1f2/0x2c0
> >>  ...
> >>  Call Trace:
> >>   <TASK>
> >>   ? devres_release_group+0x1f2/0x2c0
> >>   ? __warn+0xd1/0x1c0
> >>   ? devres_release_group+0x1f2/0x2c0
> >>   ? report_bug+0x32a/0x3c0
> >>   ? handle_bug+0x53/0xa0
> >>   ? exc_invalid_op+0x18/0x50
> >>   ? asm_exc_invalid_op+0x1a/0x20
> >>   ? devres_release_group+0x1f2/0x2c0
> >>   ? devres_release_group+0x90/0x2c0
> >>   ? rcu_is_watching+0x15/0xb0
> >>   ? __pfx_devres_release_group+0x10/0x10
> >>   hid_device_remove+0xf5/0x220
> >>   device_release_driver_internal+0x371/0x540
> >>   ? klist_put+0xf3/0x170
> >>   bus_remove_device+0x1f1/0x3f0
> >>   device_del+0x33f/0x8c0
> >>   ? __pfx_device_del+0x10/0x10
> >>   ? cleanup_srcu_struct+0x337/0x500
> >>   hid_destroy_device+0xc8/0x130
> >>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
> >>   device_release_driver_internal+0x371/0x540
> >>   driver_detach+0xc5/0x180
> >>   bus_remove_driver+0x11e/0x2a0
> >>   ? __mutex_unlock_slowpath+0x160/0x5e0
> >>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
> >>   ...
> >>
> >> And the issue seems to be that the corresponding devres group is not
> >> allocated. Normally, devres_open_group() is called from
> >> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver=
'
> >> with 'mousevsc_hid_driver' stub and basically re-implements
> >> __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
> >> devres_open_group(). hid_device_probe() does not call __hid_device_pro=
be()
> >> for it. Later, when the driver is removed, hid_device_remove() calls
> >> devres_release_group() as it doesn't check whether hdev->driver was
> >> initially overridden or not.
> >>
> >> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
> >> timely release of driver-allocated resources") but the commit itself s=
eems
> >> to be correct.
> >>
> >> Fix the issue by dropping the 'hid_dev->driver' override and the
> >> now unneeded hid_parse()/hid_hw_start() calls. One notable difference =
of
> >> the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT wh=
ich
> >> implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate i=
ssues
> >> but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in the
> >> driver for a long time and it is unclear whether hidraw was excluded o=
n
> >> purpose or not.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > A fixme tag would be helpful.
>=20
> I concluded that it's the unusual 'hid_dev->driver' override in
> hid-hyperv to blame and not the 62c68e7cee33 ("HID: ensure timely
> release of driver-allocated resources") but the override was there since
> the inception of the driver so I'm not sure, mentioning 62c68e7cee33
> probably makes more sense...

I've finished looking at the linux-next issue in detail, and I agree that
the hid_dev->driver override is the underlying cause. I was
commenting out that line Monday night, but had not gotten as far as
removing the the hid_parse() and hid_hw_start().  Then your patch
came out, Vitaly, which is great!

>=20
> >
> >> ---
> >>  drivers/hid/hid-hyperv.c | 17 -----------------
> >>  1 file changed, 17 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> >> index f33485d83d24..1609a56ffa7c 100644
> >> --- a/drivers/hid/hid-hyperv.c
> >> +++ b/drivers/hid/hid-hyperv.c
> >> @@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_driv=
er =3D {
> >>  	.raw_request =3D mousevsc_hid_raw_request,
> >>  };
> >>
> >> -static struct hid_driver mousevsc_hid_driver;
> >> -
> >>  static int mousevsc_probe(struct hv_device *device,
> >>  			const struct hv_vmbus_device_id *dev_id)
> >>  {
> >> @@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *device=
,
> >>  	}
> >>
> >>  	hid_dev->ll_driver =3D &mousevsc_ll_driver;
> >> -	hid_dev->driver =3D &mousevsc_hid_driver;
> >>  	hid_dev->bus =3D BUS_VIRTUAL;
> >>  	hid_dev->vendor =3D input_dev->hid_dev_info.vendor;
> >>  	hid_dev->product =3D input_dev->hid_dev_info.product;
> >> @@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *devic=
e,
> >>  	if (ret)
> >>  		goto probe_err2;
> >>
> >> -
> >> -	ret =3D hid_parse(hid_dev);
> >> -	if (ret) {
> >> -		hid_err(hid_dev, "parse failed\n");
> >> -		goto probe_err2;
> >> -	}
> >> -
> >> -	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HID=
DEV);

As you noted, using HID_CONNECT_DEFAULT in the default probe function
__hid_device_probe() ends up adding HID_CONNECT_HIDRAW and HID_CONNECT_FF.
The latter is benign as it only affects devices that support force-feedback=
. As best I
can tell, HID_CNNECT_HIDRAW causes /dev/hidraw0 to appear, which provides a=
 raw
interface to the mouse device. See https://docs.kernel.org/hid/hidraw.html.=
 It doesn't
seem like making this interface visible hurts anything, but I'm not 100% su=
re.

The alternative is to keep the "struct hid_driver mousevsc_hid_driver;" lin=
e
and to populate it with a name, id_table, and an HID probe function specifi=
c
to the Hyper-V mouse. Then instead of the incorrect assignment to
hid_dev->driver, add a

	module_hid_driver(mousevsc_hid_driver);

statement, which registers the driver. The new HID probe function does
the hid_parse() and hid_hw_start() which have been removed from
mousevsc_probe() as your patch does. With this arrangement, the
hid_hw_start() can be done with the desired HID_CONNECT_*
options so that /dev/hidraw0 won't appear. It's only a few lines
of code.

I can try to code up this approach if it is preferred. But I'm likely tied
up with some personal things for the next few days, so might not get
to it for a little while. Feel free to try it yourself if you want.

Question: Have you tested your change with an app that consumes
mouse data in the Hyper-V console window? I was trying to figure
out a convenient way to do that. I usually install the server version
of Linux distros and use only the command line, so didn't have a
mouse-consuming app easily available.

> >> -
> >> -	if (ret) {
> >> -		hid_err(hid_dev, "hw start failed\n");
> >> -		goto probe_err2;
> >> -	}
> >> -
> >>  	device_init_wakeup(&device->device, true);
> >>
> >>  	input_dev->connected =3D true;
> >> --
> >> 2.47.0
> >>
> >
> > I have tested this patch, but the original issue reported in commit mes=
sage is
> > not observed in latest kernel due to an other error reported by Michael=
 here:
> > https://lore.kernel.org/linux-hyperv/SN6PR02MB41573CDE3E478455D17837DED=
4502@SN6PR02MB4157.namprd02.prod.outlook.com/
> >
>=20
> Let's Cc: Michael then!
>=20
> > The error addressed by this patch is observed before the commit
> > "8b7fd6a15f8c: HID: bpf: move HID-BPF report descriptor fixup earlier",
> > and is resolved by this patch. In fact, this patch appears to fix both =
issues.
> >
> > Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Yes, I agree that Vitaly's patch fixes the problem I observed in linux-next=
.
I've looked at the details enough to believe that the fix is the correct fi=
x.

>=20
> Thanks! I was reproducing the issue on 6.12-rc6 by just doing 'rmmod
> hid_hyperv' and tested my patch there.

FWIW, I also tested device unbind/bind of the VMBus mousevsc device,
and its companion HID device that is created in mousevsc_probe(). Doing
unbind/bind for the VMBus mousevsc device works correctly, and the
companion HID device goes away and comes back as expected. Doing
unbind/bind for just the HID device also works, and the VMBus
mousevsc device is not affected, again as expected.

Michael

