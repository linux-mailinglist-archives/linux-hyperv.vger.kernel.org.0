Return-Path: <linux-hyperv+bounces-1631-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4886E608
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 17:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FACA1C22495
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939A7472;
	Fri,  1 Mar 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kwnUg2m/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2068.outbound.protection.outlook.com [40.92.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A032570;
	Fri,  1 Mar 2024 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311310; cv=fail; b=IFP2YhYPCpk0fWLEjDa8zWppFo+vku3ozu4aU6e8pxGHh7A/SjmQHTIqNdoaRUaSrbcWY7K5TRzxYlwdMmx+YlIfu/VH8Lhxjh7lYMv2STyGBamDYkdJgURPALP/gmE7qIzqGeG+yc9HjtzX1uuZ5fCJK19p5/dkMvi//ihFJ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311310; c=relaxed/simple;
	bh=G9HsVcXZ9lsxWGm5x/K64SwnIBZv2ywawVTZH6OCNV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5Si6SraWGDnHU0H3UTivP3Mr7Xx+kARiKfCSQtOirwCs0ih2sOsthqzcSKuIs2V9QYeAJBCvFy4G1ofd0RX4MqKoHVvkPPmLy6d/PxNlEjzH8XVbdYraFihDlJGHQ5/qXO11zgNOiQphFlAix3BaQ6VS2uoOmGUBwXsqF8Bh6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kwnUg2m/; arc=fail smtp.client-ip=40.92.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS3YZffbgTqo8pRGMUFN37sGBNIWFsYkrGlMnVLQ7bq3YqC/BK8RODYotiKzwfUnFyUSm1tQRIKR8G/ziBNMxAJbVu80wxrONo1ClttqHmTXXSetl/P3P9l9XEeIDBlhQ5n964WHuB13M0MVsqnI2PZpZ28uvcWhhwGZyJUMfgRs9SC66U0f6seU6KnbrNvJ7hVTV2iRNpar3RXmUJ0DVpvXSbzjlGcdLshjP8+zOfehvKCirK85p0FDTJ0M7gwjIfL5Jl21awN3Jf1vV73Fv/jKkcm+vLzusXA444txixzdA2a/rUDH/uqUq8AYrDZmPuO6vCIwqs/CL82x3PjMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0/Id39riAABkADgUo2zzD8Hb6ezSQpuYbZkSh9YAjg=;
 b=EbKRYb0GUaGmsOvrNv+8YQ+C4UT4rt7oWq154/mwbDKVPWqTwjGQO1ICpISJdpBkZSTkPRQ9RouvfvSN0OoufoGt2a5tvldCzhIZK2WjUKjUxABxFKoCcs8edj00zCR1nQtRCJcfEQfP4ZKgzvULBJPKVZv1ICaScOulsbvnMi4A+gDfeblscAYtRgQK16ZBtwBG+7ixqpRv2LFz11a8kq5SonEp2z36SSf3EN3NqXlQcO8fRdFp0QwBeriuGRUHJbKmP8eqBYCC6kLNXpfwGCY+c6NzlbbRfs9b+WIm+0WH6HTY6BmU7iYhtd1pzEPloaf0YmDaxsEJtU4vgMnA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0/Id39riAABkADgUo2zzD8Hb6ezSQpuYbZkSh9YAjg=;
 b=kwnUg2m/Ua15zCU4jAwjVLoz29vqmzs6SAw6wN9fk+U1ZOr1CUggHTEuExUCxqb9LblMgL//qfwHPsKAL+tOhuHoJNKAQBLrlu4BamJJakyLi6Rk+0up/15/yuGwGFRflTP2rJ3/7D85n5hHat2v9EPXtvTkR87DDIs3Dmw/wSXWPDlmIHqqc6zwRTmGuemrYOrKD9G474mpDJZ5hmrlthnCkl89qLUg0RQTIp6EqSjKNGJeWlt8aMh8jSolJIi9JM6F0bOk5c2Sarcsf0WY/mVOdQNHYdat8sT9iCvoa/JyZAQWGyBWnqLTQcQ40y1MhMCMM+RxsgUuFChy2A5ATQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7840.namprd02.prod.outlook.com (2603:10b6:a03:328::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 16:41:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 16:41:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Helge Deller <deller@gmx.de>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"drawat.floss@gmail.com" <drawat.floss@gmail.com>, "javierm@redhat.com"
	<javierm@redhat.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"airlied@gmail.com" <airlied@gmail.com>
Subject: RE: [PATCH 1/1] fbdev/hyperv_fb: Fix logic error for Gen2 VMs in
 hvfb_getmem()
Thread-Topic: [PATCH 1/1] fbdev/hyperv_fb: Fix logic error for Gen2 VMs in
 hvfb_getmem()
Thread-Index: AQHaVNQQLtKdxJeAI0qs1qW1SCByZbD1JHwAgA0F6sCAAAw7gIAglJEAgAB5dfA=
Date: Fri, 1 Mar 2024 16:41:45 +0000
Message-ID:
 <SN6PR02MB41574E4874A1A23A8A9ECFB7D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240201060022.233666-1-mhklinux@outlook.com>
 <f2fe331b-06cb-4729-888f-1f5eafe18d0f@suse.de>
 <SN6PR02MB4157811F082C62B6132EC283D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8f6efa96-0744-4313-bb15-b38a992e05fc@gmx.de>
 <ZeGfFAWD0KfClwWI@liuwe-devbox-debian-v2>
In-Reply-To: <ZeGfFAWD0KfClwWI@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [UuVsuDFLzXWgzGHqDYUF5D6gdOCXhiHL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7840:EE_
x-ms-office365-filtering-correlation-id: 84975581-7ea5-4742-ee99-08dc3a0e7ba1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tzZawiFGfB25RhGUX+yiTBIK/SHHQ4Re0hsaJHmPxlrU/+0vyQZGFqH7dMnze16ZOYvqbmNh9ZibhpRl3CHqfRbVldpN+bfdo+5C5w+G1GBs3R3SmJlIwQuPv44vJyBaCBXnuJsHknIq9mHGTZVKShD9Ms4cg19ifc5o6UZb0v7+GqBobXNgj4pI3ylfMrDA315xo1t3XujFeEGB3I2t5lmQ7RdIVpFzDEcQmWjAaY/Pcg1fwJa4D83aAIkr9lzkFDR+3CYB1w4miQRz720KlKDJW+rY8kulhdxn0VzCS2svhHKWasljRlMyAdNCV4Z9qp5J7vq30JLXxZ0E+WX0JMLBM8soCt9bgj19jNHuLs3JiZbWw+7CYyBCCbmH9qh+NohZTcz0i4jHU3BopivTw6OkcxSocHfwIPU5FzEsJUUpy3J3tWx210L7E51AqXwBdOB8ZqTURngTH9Yuj/Rh3gzPb0if48n94veoxFKyjn+F/RkNks+GrE7BgGdyDn4sNPsybUfPLaKgze8F8BssTRCw32bcYH7H6JQBqLXZvYctL/5ONL+zOA9TReznUEMt
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MovUHqfaLecOdfbmiR3RB/nujnVv3F2wI9VRXypRl2YPfsdBnhly/N6nXN9L?=
 =?us-ascii?Q?Vxdo3u23rQM/TnWQHXLxoq0ltpjLtf1X6uO0LpgRaUJ/cNmnKX/5WCVyqHGL?=
 =?us-ascii?Q?1FU1pyDbr2J8I8eSVkN7H+tMMXnlg52l5s9Vkr6/iNMK0t7Lg5kqyHrzXyrb?=
 =?us-ascii?Q?RODShSb8QczO+Ga258tD9YQjYk9uM/zifFhMhWTlYZl+y4XQGHfQX50XAbnO?=
 =?us-ascii?Q?Jyuqn/jKPYUP8A+KYWaC5OjvzmM9UtytLtRlJh1PfaI1mLn9lrF+QOLpqWxh?=
 =?us-ascii?Q?uIqO24Vvsm5hs4s09YQRk6JoLD3cX1LXJwS/z3KXD5BnDevRtmV8q8UncTy1?=
 =?us-ascii?Q?AirwUmzcFEqfYhPS1z0TnsiCSxAEUfvh51Vm3vNTKELp7wUB4zZ+GqeDG5eF?=
 =?us-ascii?Q?sifniGZP4x0vqlEKtXZWCbg2+UpTdoHIimSdml6K4ZasDttOB3rBXtY4u8VJ?=
 =?us-ascii?Q?asH1RZ9ITdjJ+uZDbcxbr95EPaLUObdMx3rDYS0Ibcpfk5g3A8Aply+mMSrE?=
 =?us-ascii?Q?hOw+ZJ85ruTozSDT4YV1S9gCMBbnDa5yqLcTwGuLsthQ3xVqZLor2yPF14p3?=
 =?us-ascii?Q?G9OnV0RWxT2ut29/2N98bJJ6PdPa/Wo9hBAFAMPIitpSu7LSPz1JbvI4u6UU?=
 =?us-ascii?Q?F9YqD87iqPDCtjAtTAfCvKf1gEeIkT5DelrRQpfs3dWkMzD0tCqOIV64AHeh?=
 =?us-ascii?Q?qM4Fl9C/4tR/AOrMgs8RkGAiCYZuZY+bvqGGg7VVnZ4Q9wIE8Y+/JKFvI7Az?=
 =?us-ascii?Q?RK+G5OMMmax19Dw6cOLKN6NUxD85O4W5jf43r/GZr5GKRNASUsInuhvez/PO?=
 =?us-ascii?Q?xOFpFlqRM675DhchZjVRobsmu5ug06g/NANN/ZKSf6y0soV8+PjGcdgVLN+l?=
 =?us-ascii?Q?92kQdfCvOjzS8G9RKUiwjMHsv3j3FUR0p1pnuTKuDIS9GbHcGoyw0ANHsHdH?=
 =?us-ascii?Q?g2H8G+MWizV/OiyqJeLATBWKqKwARMO65TNoOLZOFQu0yHyrNy28M0/ZArBy?=
 =?us-ascii?Q?VqDJP9xlsjSB+A0ERdDpIZYHI0adCiqNPgQ/cmAGilGHH6c94m7mMeJAWk94?=
 =?us-ascii?Q?82FRFrxXCOctAXlFnQFKepaRSOWuztSMfDvdYMFnIbeZHqqd68SzF66lFZ3A?=
 =?us-ascii?Q?Sf5qwsEmgHiatdrcFuoCgvFCPIMRV4x46Z2KVGu7l4IjwB2iSzYaUpSCj5Fd?=
 =?us-ascii?Q?4jun4zMF7I4UNCCRY+ZiLD9KKmCMrq6OTbXhNQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84975581-7ea5-4742-ee99-08dc3a0e7ba1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 16:41:45.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7840

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, March 1, 2024 1:26 AM
>=20
> On Fri, Feb 09, 2024 at 04:53:37PM +0100, Helge Deller wrote:
> > On 2/9/24 16:23, Michael Kelley wrote:
> > > From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Thursday, Februar=
y 1, 2024 12:17 AM
> [...]
> > >
> > > Wei Liu and Helge Deller --
> > >
> > > Should this fix go through the Hyper-V tree or the fbdev tree?   I'm =
not
> > > aware of a reason that it really matters, but it needs to be one or t=
he
> > > other, and sooner rather than later, because the Hyper-V driver is br=
oken
> > > starting in 6.8-rc1.
> >
> > I'm fine with either.
> > If there is an upcoming hyper-v pull request, I'm fine if this is inclu=
ded
> > there. If not, let me know and I can take it via fbdev.
>=20
> I've applied this to the hyperv-fixes tree. Thanks.

Thanks, Wei, for picking up this patch as well as several others of mine.

Michael

