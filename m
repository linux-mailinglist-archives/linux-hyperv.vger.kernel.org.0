Return-Path: <linux-hyperv+bounces-3674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32042A0BA3D
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6188B7A3EC9
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DC23A10B;
	Mon, 13 Jan 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gVi72eWo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2018.outbound.protection.outlook.com [40.92.21.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45223A0F5;
	Mon, 13 Jan 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779528; cv=fail; b=NxYwlhfdOnbYNbs/gLDNmRRT5OIMX59bV1UDPgDDI2m8jvTRdXOB0hF6Mlek+mTQR2U/FwOXHSV8zK7hTQgFL9fIzyNrxrOOe+7MHBEifW+W0y6RFMqytaCzWafF8OdhjP+8L69FX8EnYm5MiNhp+hZSuRpK/lr3E9XQWXtkWpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779528; c=relaxed/simple;
	bh=jQOZUy8VQUALtAmtUrvAecdKqIDEOu2jxXeSHnl47cI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdkuh5sUsJGJP9zzkD91bHkwDec7izu7wyyp5S1SNddbmYN0y9a8NoDbaIfHk6yLPIfDrh6kN+t4HM7r5o6KWufFni3dvW3QwIAl3RKfAeJieLQmw2Nb54EFc81kvap4Ks01hFumCHqEbksOWVHbX9Cm+9Md9k+aZXo7SQZEpZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gVi72eWo; arc=fail smtp.client-ip=40.92.21.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHMsFXVQ+en8i9LvY0upPQI/HyoAMfV+7MRB3hT7A8aE4LUwaZrsUxVxDeUXjiyDhi1t2iIlcOdYhli8YlnNXLvv8o1m9NihBqFLOZkhbhg3JSiP20yiDBqean9EOQxAYO9wNnJM/pz4T5pF/4LaCGttITbUk22uafi04J922dpfMq2Cx1rYsTGUzZVkKBfAPfRqrfm4TB0kg+4a2Yb/Tpe/esHMjYhPg2++p7LJFIjizaEdW6aMvVhiblP7dpbKgTRJh52dDX5g8vvmMsyQX8GGhm1kPEKIYrnxQmxkB25X0lh+gcIe0UGYz+Ovr597//TXw2B/AtkvHB1zRs8O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8dSBDYV0E2fRj9Icdy/EzcLUcxfxUq/du0x+hYJ9B0=;
 b=YkOV7b7qLiynOavlRl7S8MXyz0OvmR6Vv9E3vhlbuj2vDxMW51NajObVkp6khS5HEy003knmE7rgKvBN5YxW+z4grnP/XTyilqXWfOtX6Tvd1E8rA7ogpfNUXSVCRtIPvTeX8HVyMDMmB0IrsFbL/7ELLtOc+DEDNw1kCgWm39uaaWx6kqCAnQclqLq610hbk7CJlUMjmp69wkJFBx1l8qNKIxk/20WUVs/+uwQHvRpwU3KgNUHFxYoXAXpItQk+3OVjGtZHFuMgAV/64PY9/U5HYtG1se4OQI8dLbhZ6UfyY5oYZQK4M2zLUaUVDQ27b+rp7AdrnW797qvK9uZjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8dSBDYV0E2fRj9Icdy/EzcLUcxfxUq/du0x+hYJ9B0=;
 b=gVi72eWoBOQ9qeFCnekqJf9iLmXHAWLj8kqWRMyXHrAHfgq7cWGRvzF1Dw3EF+4HXSMhwuTm93jCXt8XEUa6noEwQi9xMM/5PSsX0f3gqtVO0PZKeHhMj5A9sZGm94kVzWaWKUcaQCPBcqYOMGWJe1i/7/zjd87NnzVXXARb9wJktpj1DVtC2b8ti+67aS6HlhZhjknzvTo66oMH6DHC18gEwIf7B/6qkr7iN6YrCRf3+J/TmkNpn4ASPV1WyCFibf9xlwFgjIlczxw/MzmSfNlYuCRQZko0WhAjMzVucc9WjKFmBAbeJ/9iyWTsLi1tdo2/b2+FkEWtzbFGjYUSmQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7674.namprd02.prod.outlook.com (2603:10b6:806:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:45:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:45:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Topic: [PATCH v3 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Index: AQHbZXwcgOPN7oh0w06R7x5j1UPLQLMUemeAgABNWLA=
Date: Mon, 13 Jan 2025 14:45:24 +0000
Message-ID:
 <SN6PR02MB4157F5B615953FF2AE8A079DD41F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250113052903.1319529-1-mhklinux@outlook.com>
 <Z4Tlb8okZHM0OJq6@archie.me>
In-Reply-To: <Z4Tlb8okZHM0OJq6@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7674:EE_
x-ms-office365-filtering-correlation-id: 03cf8ca5-fd03-4792-4409-08dd33e0e9f3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|461199028|8060799006|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h5H7JAI+Kg4tV9xkug1Q8G8Gfp18wqLLhKhQGXCy4ffgrHKs3OAd8XCajRU+?=
 =?us-ascii?Q?7Qpy5ioCDnGjuDSOlbfZlMYhAEokklgeFSvSVSMN9bGxLWTrQ52p2O84154y?=
 =?us-ascii?Q?5DQLyKQDkzjK5KZs9JQHf/GIMdK5L7rbmaoNNRGVARTnUQYKOcVnc1vaXxFw?=
 =?us-ascii?Q?wgc4CJeHfmnC2e1LiPel5j9FLLR5UaHfDAs4J5bbVa9h6nm0kltLHJT9ybBm?=
 =?us-ascii?Q?BIbHxPzUakIPsO0Eq9AZkyzLz5CnVBRNIYa1EITSxGW1/qOwpowqYOvmyFhy?=
 =?us-ascii?Q?FOEumSvFznp0wXYIY/I/7TcUcHzBcGyCN1+4/0RgpzeCRseHuYsG8sgwTQQs?=
 =?us-ascii?Q?TOTFsSGfyae0aoI/aQiXNpt93OPFgG6rOdZ4Q9iDkBJ7slOzF5M4usV9y4D8?=
 =?us-ascii?Q?Z6qp/gWpqKAbqEn0zOv5W1DT/W/J4dtf2lc4N0fFQneA417/LcWpFKkDRooL?=
 =?us-ascii?Q?JuVVx6DUCcNb3/DmCpMY0pJ+3e6iKkaZ0wkUSHimWJJqro+hJn7K7l8AGS37?=
 =?us-ascii?Q?yw71/CfcUloI9x6iG+W6JLo44d3T+/05L3tHf+AFxSZ/3qztj1bC7zD1eZbO?=
 =?us-ascii?Q?TFszW3sDoQ9m651mz7w2+sEG9gYJWx5LYwP7Uucta35nEBrol38Z3sPssVzk?=
 =?us-ascii?Q?bTDkRd98q//BCtNWwwpeAJ6M/Zf8AC3zNKmdYOBPf/z4JWg98VqpcDIQy2Yg?=
 =?us-ascii?Q?pa3qY35k9imA1Re61hJD60fqC5OEbuzcknjBRidjZwn5P6Y4ZheJ1szzAakl?=
 =?us-ascii?Q?VMd4wVCvBWAmDM58raNagI0h7lAT39PKjpTuP0hzNf+P8SSpbtPBNZ9RyX34?=
 =?us-ascii?Q?/7kF6Kht/pzNy6sgAwfJAKoX/Q03sxg+28UaWohGlJa1jHi0Yr3d6HzWUlxz?=
 =?us-ascii?Q?M/ScuQVXIOUsfpZLjuUoeBzRb624fOhEWU6Y+jI5NCNsucfNeZue4X8s0pYo?=
 =?us-ascii?Q?I8QwzvlNUR56nzoKERP5BRpT/F7KaKn44/QJ+nePuynHAxMbEHaWIak+Kthn?=
 =?us-ascii?Q?mXtxJRxC6MJbiknN3RCGzmnIaGiqi2WK7pyaFY6RnoQ+gDc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?moByDc1WHlWuxjCqFWXo9ovDV40NPy5lxWUuGEoH6Xv2bokpOBx2iPOqH3Yj?=
 =?us-ascii?Q?fTKRUsYxWNQzrFCR1v+JqE7UJyKWnvvZfSDz5809u/Z72DZD/SpK2KTwf4UG?=
 =?us-ascii?Q?gdi4K1qb3TySBKYzgkd0NhLvkKvYIWOxf+3otQo58sN5R9OuSKspQCOsEobX?=
 =?us-ascii?Q?+VjW5IoUoYTCu/ZEeKhWgC4Rq/lfa+MgDm48TTALjXJbf9SRBMt1Ba7wL9b+?=
 =?us-ascii?Q?+S13+fFx4Kj3h4G4DXQQHPaHjLoeM24Qsy3BvdWVOmBz1WL18A/j6Aqncam2?=
 =?us-ascii?Q?LZpuioJ9oqn2PVXRaPSzeX9zgPkiOe4IMuQ1iKVkPMtIx7p8dQ70VXAdTr7l?=
 =?us-ascii?Q?3BYUwABWXN8f4+tl/4IkzuhJQKxeyi8TG1Agpn4lDq/K9ueihu48kulZvxGD?=
 =?us-ascii?Q?x1/2ILg00dfDSalc2jyhCWq6ND1tj6pJKqcCdUkRZM3yq8DZVJfdR0YJ9Q+B?=
 =?us-ascii?Q?ETO+29Yk5YyobrUuiNZIhU8x0LewXX8yiqPZjUgFs58X9mTZWo1yfQmxjuk4?=
 =?us-ascii?Q?J8cBmFA3QlH/KOIRHaPYTF5J8F6yEsXpoyB2pg2LCiit9gAqZiJFwsaTJBHG?=
 =?us-ascii?Q?SStD9IHAuOeDHw52UIdy26Zo2y9Jl+tMXNEKMZTpwJFEe9qxHcv4Xr2dzdhX?=
 =?us-ascii?Q?H0FQ8FUQ19/2j7a3kvaPjgEoMcl+umD/PiJwCisEKtSk4Z0wLrwi85ce2MBm?=
 =?us-ascii?Q?QMBHG+jfY4KBpUY8LjkWzPKdaKTppM1CndytvnaT086cRHx6bkp2JUbc5H3Q?=
 =?us-ascii?Q?20KwBjsXpAPFGVDs8JpuiKFCNep/uhPlL84e+p3vd7rnZnQ9I2l73Hto26Wv?=
 =?us-ascii?Q?5NnYuJXAsXPhZHZW1OaWRx0g70WOHpBbbzczItoRFfoxmp1tlgiWcA9lBr8k?=
 =?us-ascii?Q?B7KwJzF12XM2/UjZnd3ewsKoSrcnbk5kD7J5/Exz0Fxo6lGos085pHDpNbcx?=
 =?us-ascii?Q?sHloQZ8V8f+lwPOQzQbLhNBKP6ZLcP2YdSh+FLu/MhlL5fyMLGiHdacgmdpy?=
 =?us-ascii?Q?ZNB00LzCBJIE75VrqkE4pRoKThPd/vclIhp9+qRrTccER/PXYeqcMeM7RFdv?=
 =?us-ascii?Q?WbnBLo+DqehKoM7XjwBHLdDJGIKapxCFJ91j3iPXkKEptT6mEeFjOD3MFYGT?=
 =?us-ascii?Q?ocUVEeISTjLS+3wTZjRQ5laY9OtDSyeNzvC5DzyHrwnHijSP9L85xU0aAaII?=
 =?us-ascii?Q?mkeAYJ7LuktAyuoj4r9pR+pjZCt4XdnBuUPpZBF58ZaBWEXHBe+I6pAbCBU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cf8ca5-fd03-4792-4409-08dd33e0e9f3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 14:45:24.6960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7674

From: Bagas Sanjaya <bagasdotme@gmail.com> Sent: Monday, January 13, 2025 2=
:06 AM
>=20
> On Sun, Jan 12, 2025 at 09:29:03PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Add documentation on how hibernation works in a guest VM on Hyper-V.
> > Describe how VMBus devices and the VMBus itself are hibernated and
> > resumed, along with various limitations.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > Changes in v3:
> > * Added missing word "with" in vPCI section [Bagas Sanjaya]
> > * Reworked wording of SR-IOV NIC handling [Bagas Sanjaya]
> >
> > Changes in v2:
> > * Added discussion of implications of moving a hibernated VM to another
> >   Hyper-V host and resuming on the new host [Roman Kisel]
> > * Added section describing how UIO devices prevent a VM from being
> >   hibernated [Roman Kisel]
> >
> >  Documentation/virt/hyperv/hibernation.rst | 336 ++++++++++++++++++++++
>=20
> You forget to add the doc to toctree index:
>=20
> Documentation/virt/hyperv/hibernation.rst: WARNING: document isn't includ=
ed in any
> toctree

Argh!  Indeed, you are right.  I'll resubmit .... :-(

Michael

