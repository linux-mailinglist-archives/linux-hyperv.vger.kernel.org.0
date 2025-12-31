Return-Path: <linux-hyperv+bounces-8108-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47246CEC6C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 18:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F17300ACD1
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EE2E6CB3;
	Wed, 31 Dec 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="casxHiQs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012060.outbound.protection.outlook.com [52.103.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAE2E62A8;
	Wed, 31 Dec 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767203584; cv=fail; b=D3yCbJ7j3PpFTzscd/KqEPfkKSlCMjr5rXHB014brlCSB9+RTjbCtXgmRdpfzBWmSBiuJb8m3FrtySUDwEWHOufC97swDxaq3DZWf+gHWCuN1E0hMsxWiGJjSAmBiE8zIq1+PaC/gJxcreNmF3gz2BjygWVquB/TUCLUk5kqI9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767203584; c=relaxed/simple;
	bh=rMYISTDo8UoGwTFzljoLahmXtrhiWgXPwL0aatOuDUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz8KF/muMtOD4NHhrO1bfDVJ4+5NUIxKzTMkBeasZSwKXxnrrgrjCuRb0+lFytFzptMf47ElSX/c+cEirFOh2ZUC+Yv7qD9olL175sMxAvSkQnCYO07WmiqvSmzjkHTNJTcpW58EPYBmYospN6h7drafpXeSjIEvWrRy3uqYxKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=casxHiQs; arc=fail smtp.client-ip=52.103.2.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY4L/g9Oazsl/DKRitMXluo01tAI7KKK2xPaNSvEL9sjWcb70IUPx/S3laQXrVt7Mde9q+aum3IBGqQJ6T7ZQJ2Azd2zLaCCO4cUw7M/+4sUB2ZlWLLpy2mq2r0PkvcqAm3zyiOB5aRADwXWNxkiIJFyrLaYXtQu9e+zWavaPCdyGf0hsuijYECAWfRVcqjWelFWVPGVqEvob2o0c2hjYBKuhvV3+IBnPBxYpe3d+8f5xVgpN6KDXU1Eiep8EWyPRBA91JZdy66huKoR3yeP9nJFCIUDS1gnfWSY5TzVAJXErgwC/jxrG0j3Og8OboZnw+g1+DglTo0oM9H70JXEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wEZLOswG3s/3icb8EJiOnMiusRR6pAxNVN7ktBsnFc=;
 b=kLQZIzsqGQ+GKrKQTHh2dWMagb0bm0ZYTg2LZm11r5zCe3L0ADxxqV7D8MmR4SCfsy0R3FXe456RooAYAom7SG2bjVfKykVYBqlvMAh9MxzpTs7022C+ueI7AQnvy4ehz753v9VqM0B6kOh2xrn6Vjq8H34K0j+ds0Gz4CXXFc+wzds+2vt6zvZQnz/TcHQI3ZAjAgiu8YsfuaI9RlZrKMa2234wG8v7/FmpO3S/fHWtcRME7VUG6nXVJZJ74XHMrKmG+fq8Koa7fIC4DIH/zEvQ3uUdFt+s7pxOHvJ6+v037vOr/dh2L2CWGTHRJQT2/ooqlNtiEGF9n3mOBHA6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wEZLOswG3s/3icb8EJiOnMiusRR6pAxNVN7ktBsnFc=;
 b=casxHiQsZfIYZhpSGBZ6YEhI2kwFoMCTZ0HtT6AGlh5CaUd9xWUUHBhq5D0X64tc+XVSQwR9n+MXdb4GesUFbkt2i7yzSEwykQSBVm1ZSGqFwVZdJYoRgTX9Qfbg5mwsD8I3vDCjsieHBF7TzpgGkQbeIxd81xV2gicEKoV10labHJ04irb9BB0o5mvKyT1cdAU14ZOdXOrGGwfSF0dD05ne/XIyo+caIIePhQT4Uq3kl33+km5XGObnPHLJ5ZssRmb7MBFvwewKvmkS+baPUsa3ZTXbhicNZmGYD2015ePNGa2LKylZF3GgDrX6O73mFKPUxHCOx//ov0vHUZy12w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7373.namprd02.prod.outlook.com (2603:10b6:a03:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:52:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9456.013; Wed, 31 Dec 2025
 17:52:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, "vdso@mailbox.org"
	<vdso@mailbox.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in hv_msg_dump()
 if CONFIG_PRINTK not set
Thread-Topic: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in hv_msg_dump()
 if CONFIG_PRINTK not set
Thread-Index: AQHccQSCpYnwovAUE0yn4gaYWmR63LU4EIEAgAF4c2CAAo8ZkA==
Date: Wed, 31 Dec 2025 17:52:58 +0000
Message-ID:
 <SN6PR02MB41572FFDEED0D472F9FC5E5FD4BDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251219160832.1628-1-mhklinux@outlook.com>
 <21281086.36492.1766981516854@app.mailbox.org>
 <SN6PR02MB4157065BCB5064B3587F9E4AD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157065BCB5064B3587F9E4AD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7373:EE_
x-ms-office365-filtering-correlation-id: c84d27c1-9e7b-4eed-9e2c-08de48956f96
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|15080799012|12121999013|41001999006|51005399006|13091999003|8062599012|8060799015|19110799012|3412199025|440099028|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hslama/KCihrZqS56gO4XsQE8DcOJoQk5sXVB2PoaUjVD3k8VK8SlyvfCTDv?=
 =?us-ascii?Q?WAUv3l4iYbeOl1IGEC51XWJwdfigBuMvDEItgYNhyxeyq64Kpw590kH6OzOg?=
 =?us-ascii?Q?svyfbfQ7y16D+bwcZJs/qRxEwf4wOww4QNWYz7PmamUGaBa/yjFDnfwjMnC7?=
 =?us-ascii?Q?nQjVfhEJDlvX0UwXoAMK54JrennOSOkS7r2vS9GaSNHu52PBkDJsS017bAYP?=
 =?us-ascii?Q?+DD9qo4W7SAKT4Le6aauGJmNy1M1XVc5W14HtmHDZd7VgEHvUVPdpiT/vgdG?=
 =?us-ascii?Q?0WKyyV850WV3PW/4MG8IxuHqfviYfaIktWSZESRigOxY0zSZlAu8QCwdL7AF?=
 =?us-ascii?Q?ulyURcFtAORTBppNWI74yLL6Leo45F7/sPOcUwqbGgxvgCOs+45+7rPZ1hWe?=
 =?us-ascii?Q?eyX7X+cPlzWeoZhK+ZnPYvylI2g2x3u1KPIJVg35ehQVcJGihwWO8clJPEDM?=
 =?us-ascii?Q?dBsy6vmGCeYYcSv67VHpJ9K7cqQjmFlltpH0Q56cU+5r1Vteeah1Am+gq+J7?=
 =?us-ascii?Q?eRQ+nBSIyzL/nj7ojtRu25JZuIPxQdxWOUyd/Wv3z1n8fFndoynQxfIpFbs1?=
 =?us-ascii?Q?scvJGJf6wDCf462jOoDZyaZSCdLOo7t7VnsobXs5reugwqrr7HkeSIZ5/Unn?=
 =?us-ascii?Q?Bq9ONLX6mPjLWrreUROgV3cc4MYpnWbDlte9BIitvh+52dgrs7TMmbaLHXsG?=
 =?us-ascii?Q?6MXu594DINCt2GM6XwqArno0MFGcHLnuH+88CPhDi84g+KSIV3k49ftpRWl3?=
 =?us-ascii?Q?m8biV6Y2JKaSG3bZRVei/GcoVXwZWjUPJKfIQX48PEdkp12AOZLASMzJla73?=
 =?us-ascii?Q?qh33p5UAXJsLJoH5gW3MoNSrB7AgPXI5Ty0f2oVl5bklYt9BYiD7TI6jMtNS?=
 =?us-ascii?Q?hPuiWz4Zz79/FjlF0ompF/9aMCmvQphUMdHtbl3Nkwo23e/0VxRZuF0y33pZ?=
 =?us-ascii?Q?eI0vsSfpkKNRY2DaoxIAKB4EGl4pnxJ2ugwu+c6mMdlHdTN1LPTdHiRJMbyR?=
 =?us-ascii?Q?eGBUH9JO1nUhtNEIaXo/Uu2fRPbLn0iiuuAmNcPI6b6rWempM7hJoqLphJ2j?=
 =?us-ascii?Q?H8XIJQIdDr6mGPfmHx+4P56ghBvBYNCXtreZRaYETPO1EYo6dzTVQlzSmcOG?=
 =?us-ascii?Q?zkMJdPU27IlrxNLS3+apcIYYVLYZmJike3kU+/WSWsitNyOMQWTZPbzUfqOy?=
 =?us-ascii?Q?l2eNUx/C+P11OJptBiZc18w42yG2YPDUvtA4kHST5KDR1Tc1HOetTIP5oH9q?=
 =?us-ascii?Q?HqN2TX2+NSwL/gQ39kLh6YQkSMrGR85bdYNMbZBhvN+cm/0rmDQQrreGY/kS?=
 =?us-ascii?Q?gV0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzwt0jWoTSBhNN4TBwri8iwl67zJDbUyHqbZBRrpLrsvPva3Az51Fq+ye/0U?=
 =?us-ascii?Q?W8JlYyyUoTkiIqttESXDCNldsUKns7dE65gLRStHggE3R7zl5vxHNuRU5rg3?=
 =?us-ascii?Q?+2tDOkZLarMEgMMRS0k422R0Ri3CXyHIFp5KCiSfW7VJDZZdWMQDdbHFXe9v?=
 =?us-ascii?Q?+SJbZ+t4OAh01kxFEqJX18+Ecfb4MCpBk+/+xaAYyQ4OFGYxIPmR+IXRxkub?=
 =?us-ascii?Q?Hoe3K2Prr46/Dp/eGuuR1UALEWcWhoXmfOQd2jiSxgbZyisXKhpPSM7iQdQC?=
 =?us-ascii?Q?pvLPyMBTwiJcOS7b/Y/JnMi3ESMZ6rVehUsmsOefQQk+aHAOu3srdNGGvnSU?=
 =?us-ascii?Q?xDnKrT502p5U5qfaUIIv171t99xa8nkGK7IjPUVeHwEPRtKSU2MJH5d+VtHL?=
 =?us-ascii?Q?Y3VA/WyPH08JdtywxvfjI9pFt9nmVYlbnTwK6bkdby+SI+aO+BLL3Fl+cF05?=
 =?us-ascii?Q?GAomT3GaX6Q+nothpKinRfjiwHCsryJxQDQTn0KLYdYwc2DSTBIjWR2NU/dL?=
 =?us-ascii?Q?whQA920uyc9Dj5BpQ6rkPjv616g6JShMwY2Wm2Vq7ZLlkDTaWEMPcGKsSTAH?=
 =?us-ascii?Q?J3W3ULi/m8UGXL2zWhGIrD8585zUihC7/jCVcidpCi9Ayc3cGK6oodizTaWB?=
 =?us-ascii?Q?5xpbJEIRDFIxFY6vJ1s6TynpEot/kmiSyQ6RMsTB0o7PGvIDvUQ95Z6ewLJ8?=
 =?us-ascii?Q?F+kamYBzmyuK0V6MYp+FrK4tLKHEvu6AZet/wKh1o972h0v/vMkomKuS64Sc?=
 =?us-ascii?Q?RkJbz7OdjVsEumrlMKMMz0e95fgCMeeMv80asbU5Mtf1HEchy0er1HVEWY7p?=
 =?us-ascii?Q?8/ynECHhiFq18IbtbMSYHnnV2qnOCvFMXeFQYfnewb4no9GwD0+D5ZGbITz2?=
 =?us-ascii?Q?o3mMm3EFgkFo8yD8XqPMsa2/Fps2KINEnw2M4iY6GJeRsQvOD5pdGQayN4Ww?=
 =?us-ascii?Q?qYc2kpDtchhEMSzbqXrzW1DD2CDluxAq2srp1vbljovM7siiPdlXRXo0We5c?=
 =?us-ascii?Q?mGD7lMwColtr9v7hA+2o90Til8i5I3tZa8G70jAgFagREmlw873wh7joG7vL?=
 =?us-ascii?Q?QvA09G1euAtFOMhgNQvpjF4Jdlr8jr4lvdrqwi8ol1yhHOH0p+ep34fuB+/P?=
 =?us-ascii?Q?myoXi5FdUauoQAYD3W39h2TEV9HPlepWYlcAPHFqAr8A012wtfEx/gyU35ZZ?=
 =?us-ascii?Q?TLbw0q9l0bGI/B6BczdZ+P/2GqCCPHLrCyjXrQ3KrZanyUkTq7vEe1KqELV8?=
 =?us-ascii?Q?6eGkwgK9UUDGIxC9X8dwp3q8RRVqUgEaJoRJkBv//I8cq1tI/mRK5s44V1Rl?=
 =?us-ascii?Q?ms49gNpp7BU2lsClAnWYnKZHIJ6q5Ajjn+fx4OwR8qcEO3SW/vcNATtJ8WYg?=
 =?us-ascii?Q?LwGN7Lc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c84d27c1-9e7b-4eed-9e2c-08de48956f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 17:52:59.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7373

From: Michael Kelley <mhklinux@outlook.com> Sent: Monday, December 29, 2025=
 7:04 PM
>=20
> From: vdso@mailbox.org <vdso@mailbox.org> Sent: Sunday, December 28, 2025=
 8:12 PM
> >
> > > On 12/19/2025 8:08 AM  mhkelley58@gmail.com wrote:
>=20
> [snip]
>=20
> > > @@ -198,9 +199,9 @@ static void hv_kmsg_dump(struct kmsg_dumper *dump=
er,
> > >  	 * be single-threaded.
> > >  	 */
> > >  	kmsg_dump_rewind(&iter);
> > > -	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> > > -			     &bytes_written);
> > > -	if (!bytes_written)
> > > +	ret =3D kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PA=
GE_SIZE,
> > > +				   &bytes_written);
> > > +	if (!ret || !bytes_written)
> > >  		return;
> > >  	/*
> > >  	 * P3 to contain the physical address of the panic page & P4 to
> >
> > The existing code
> >
> > 1. doesn't care about the return value from kmsg_dump_get_buffer.
> >    The return value wouldn't make the function return before, why does =
that
> >    need to change?
>=20
> The existing code depends on the implementation of kmsg_dump_get_buffer()
> always setting bytes_written, even if it fails. That's atypical behavior,=
 but it is
> what kmsg_dump_get_buffer() does -- except that if CONFIG_PRINTK=3Dn, the
> stub kmsg_dump_get_buffer() does *not* do that. Testing the return value =
is
> the more typical pattern, and bytes_written should be used only if the re=
turn
> value indicates success. So that's why I proposed this change, instead of=
 just
> initializing bytes_written to zero when it is defined. My proposed change
> makes the overall pattern more typical, and would work if the implementat=
ion
> of kmsg_dump_get_buffer() should ever change to not set bytes_written in
> some error case.
>=20
> >
> > 2. returns early when there are no bytes written.
> >    I think it shouldn't as otherwise the crash control register isn't w=
ritten to,
> >    and the panic isn't signalled to the host. Is there another path may=
be that
> >    I'm not noticing?
>=20
> You make an excellent point. I didn't even think about the possibility of=
 the
> current logic being wrong. There is hyperv_report_panic(), but it is not =
called
> if hv_panic_page is allocated, in order to avoid duplicate reports. I agr=
ee that
> this code should go ahead and send the panic report even if there's no
> message data. And in that case the discussion about testing the return va=
lue
> from kmsg_dump_get_buffer() is moot.
>=20
> I'll submit a new patch to change the behavior to send the panic report t=
o
> the host even if the message length is zero. I did a quick test of that c=
ase,
> and it behaves like the case where HV_CRASH_CTL_CRASH_NOTIFY_MSG
> is not set, which is fine.
>=20
> I'll submit a new version of the patch focused on submitting the panic
> report to the hypervisor even if the message size is zero. Avoiding the
> uninitialized bytes_written will fall out of that change.

FWIW, the plot thickens here a bit. In testing my new version of
the patch, it turns out that hv_kmsg_dump() is never called when
CONFIG_PRINTK is not set. In that case, kmsg_dump_register()
fails, and hv_kmsg_dump_register() sets hv_panic_page back
to NULL. So hyperv_report_panic() is used to report the panic
to Hyper-V with no guest message.

The original uninitialized variable report is actually bogus since
the non-stub kmsg_dump_get_buffer() always sets bytes_written,
even if it returns false. But it's still worth initializing bytes_written
to zero so the static checkers don't generate noise.

I'll take all this into account in my new version of the patch.

Michael

>=20
> See a comment below in your suggested patch.
>=20
> >
> > That said, would it make sense to you the patch be something similar to=
:
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 0a3ab7efed46..20e4a9a13b32 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -188,6 +188,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper=
,
> >  {
> >         struct kmsg_dump_iter iter;
> >         size_t bytes_written;
> > +       bool ret;
> >
> >         /* We are only interested in panics. */
> >         if (detail->reason !=3D KMSG_DUMP_PANIC || !sysctl_record_panic=
_msg)
> > @@ -197,11 +198,16 @@ static void hv_kmsg_dump(struct kmsg_dumper *dump=
er,
> >          * Write dump contents to the page. No need to synchronize; pan=
ic should
> >          * be single-threaded.
> >          */
> > +       bytes_written =3D 0;
> >         kmsg_dump_rewind(&iter);
> > -       kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_S=
IZE,
> > +       ret =3D kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HY=
P_PAGE_SIZE,
> >                              &bytes_written);
>=20
> Ignoring the return value can be made explicit as:
>=20
>  +       (void)kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_P=
AGE_SIZE,
>                               &bytes_written);
>=20
> Plus an appropriate comment. Then there's no need to introduce the "ret" =
local
> variable and the somewhat funky:
>=20
> 	(void) ret;
>=20
> Michael
>=20
> > -       if (!bytes_written)
> > -               return;
> > +       /*
> > +        * Whether there is more data available or not, send what has b=
een captured
> > +        * to the host. Ignore the return value.
> > +        */
> > +       (void) ret;
> > +
> >         /*
> >          * P3 to contain the physical address of the panic page & P4 to
> >          * contain the size of the panic data in that page. Rest of the
> > @@ -210,7 +216,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper=
,
> >         hv_set_msr(HV_MSR_CRASH_P0, 0);
> >         hv_set_msr(HV_MSR_CRASH_P1, 0);
> >         hv_set_msr(HV_MSR_CRASH_P2, 0);
> > -       hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
> > +       hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_pan=
ic_page) :
> NULL);
> >         hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
> >
> >         /*
> >
> > --
> > Cheers,
> > Roman
> >
> > > --
> > > 2.25.1

