Return-Path: <linux-hyperv+bounces-3233-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603539B9967
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 21:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20969281BED
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D81D5AB6;
	Fri,  1 Nov 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XtTPef96"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023127.outbound.protection.outlook.com [40.93.201.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743F1D130B;
	Fri,  1 Nov 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492799; cv=fail; b=A/h81pUlntv25CaeVKuRgRYhANvYY1ZTpJjvVcWQ5iqw+beE35Zz8L1LXc+lbGMM8ypYfxS7RA0Y7azXjZazY6BVh1vqHXY3AeWPNRkToNEzImOJuEf7a4ad2XE+cEOS5OxnWCtmCmP2FgcKFQJ/PjmYXw6Q7KKvX+X+lBV10UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492799; c=relaxed/simple;
	bh=BwLea/tGujNBn82RdZqZ3hR914EUmzO8aFbgxEjf0tI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mo86bEy6+9hsXKuzmdm0f3GioO0UMv/g0UdWx070sw0fxp7YbgPriMjwkBGvkL1lAPvuTzywMFIuK6aL5KFPAiK1o0ICb6Bce9UdbBCgmJKmf3FV9BYO8E2zcTr+ad2qT4g3ZthqHDFzgLesfLGsYc3RoRUWoIJyGzgMWQuDypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XtTPef96; arc=fail smtp.client-ip=40.93.201.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtlwNkGuEg/O0MC4IBK0l8J6TjA2NjLaVZ/ASoku37hdXSRzRZ6owEOjc1cvOHyPe2TUDEOfXX1v5iUT/HEH3xMaNCfi2gP3Ly/F6ZQ281IKSBj36Gf36yHQej/+qtRjmKBQ12G60dRHsWSx3r+dFC7IKI9XLg7j0Ive4w6hqaYSBn+P0Iz1OoPtm30TRyj0MkY4grcRRLo1FCCaP9DEBWxY8orOMmpCYwWY2uZf70c3kM8AmIcM0Vbo8GwIHWTSzK4KMtIwl2KLAkiYrJG7X8ZatY+vM6V6ZVqnql9RFe0T/PxtCXhycp+hqU4Vc6oHG98fzknJtDriLwuY7LV70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH/Lwx8vShbnr1ILBIJHBEBZXrYhjjtqqv7AZWnlFAg=;
 b=uJic5sMNbnfhkExut5qXQ46RCgvqpmokPNSxbm1p4D9DPs87ipUEnft/707jR6Ubcni9R3aZ4lMtSzpon2z/Lm8lvv6n7lz+mTfhHvln2ELMbZnmNuXSj/do3O3Fk3Nkj1fTfn0fRlxZCfzV01UndBd30RumyLICipP4jVIoPwQqFYDLP5PZZXwsgdDYXGILHWk+s1Wn6mx+OcPTHWh/pliQf75fktyePV65f0QNFHK8wrVNxKcug8M0cRgjKxwTORW4qRArb6ML1jrDYTKVylvwLsAB4/dJkIWD9OwUwpk7h3ywqmyl0lbuTjqeCXSv7VEhdQ7ZGztdfeK3e4Twhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH/Lwx8vShbnr1ILBIJHBEBZXrYhjjtqqv7AZWnlFAg=;
 b=XtTPef96Ktru4hGx1JefdQAJR6hCFzSRRqXe6a5bjtEmEPHxmyv3ygkMEU2Ie9d61KQd7/g6He4N1hdO3n4Zv+Rzw9h/bGi75SGXhsrYKiGaOkqSt49syZahWK53vhZ3t2ltekbXO8VqgdWzAn9PO/m3M45FlE0JfC9PjAbhNIs=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by SA6PR21MB4509.namprd21.prod.outlook.com (2603:10b6:806:422::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.14; Fri, 1 Nov
 2024 20:26:36 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%4]) with mapi id 15.20.8137.002; Fri, 1 Nov 2024
 20:26:36 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index: AQHbKlyHss5KWmFug0aMZtYQWKCj3bKfoGAQgABd3QCAAY9pkIAAGyaAgAEysEA=
Date: Fri, 1 Nov 2024 20:26:36 +0000
Message-ID:
 <SA1PR21MB13170389BCF4A5A05FE359EDBF562@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB1317A021B6C5D552B38C4368BF562@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157D9B44F3B94E17993BB6DD4562@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157D9B44F3B94E17993BB6DD4562@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|SA6PR21MB4509:EE_
x-ms-office365-filtering-correlation-id: 9b4b60a5-bf18-4672-4da1-08dcfab37bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1h43QqG19qCt5lflsiK7WmV1e9eRU9zgvn/nZ3RByqFiFF1N1plfaHx63ZFw?=
 =?us-ascii?Q?78LXlRRdmXbbbFyUw8WlCtJJ3G++VAts/Jv68cO7marmhkVhHu6lzB37cKP/?=
 =?us-ascii?Q?oFsGckHPoxuvurJuRYL6QhhJ5H6VUAu/w1iNViv0d52qP2oGcZpxkNWBkd+A?=
 =?us-ascii?Q?2yVuDK9ZGdHSbCu4+apj1xbMombLdNNeQMscK8ZcX2j16xfjVqfLZQrBetiL?=
 =?us-ascii?Q?7XUnOEdwVt9NaAIETnk3OVGY6npVAyNeKSMcGn6JJpi7dVwsLt3nsQzaS64w?=
 =?us-ascii?Q?HFGcXE75DupD6ly/1SYKWjqmc5dvPa12Jj1szJ+eZm8Ow0gnJg2Vk7ciK84U?=
 =?us-ascii?Q?OrOPvs7bc7Z/FfHD3mVi+WsnbtXmdtjsLuvHtN+vAQD5cEpSq3w1ZvSMY0x1?=
 =?us-ascii?Q?+AZM3r88Yw1ubwenc89sovTkk6DoUZ9XP2913vduH0mlpo1fby0cFfkOxbNv?=
 =?us-ascii?Q?oB+fC7dgf9hhH/bznFnbxdLpDXIwTbHHyuOQJ8ZTPzgyhUkwvqSyPSBlUQ+n?=
 =?us-ascii?Q?elY3ElOPxpY8xbnjbATxKdDXm2UcDLuXM5A4FPYljiHLlcST1nvHBSD4zZPg?=
 =?us-ascii?Q?+nJ2DfbZi8LMblNlJPESFMu4IBIv6Hca/bwp3hlGtW6rk3fRkCUXuPLCddtc?=
 =?us-ascii?Q?BK5rQ72CzAbEe/P+1bvEtRsvGi19tq7L/I3uSQdTJgofcmB4LT6hEm4KvbFN?=
 =?us-ascii?Q?l2to2s2Z/bQgog5tS9/GlrIFNeW2tWQUFbY0YMRGnyRyMC4yPOfeeX/2I75d?=
 =?us-ascii?Q?oJ9N1EViW78yThw+94b2wZTU98kJQ7I5e1wJqVqwRhfrDARVAJMKquyIbvvo?=
 =?us-ascii?Q?yDXDb1d0O6d8APNQgg3cn+UMzdFrKxouaqoBYcPIRkwRCvK+LOKyEHGPvsg5?=
 =?us-ascii?Q?hgImFWRfUYMApglLcaL4In4eQkjoq8J5y5tald51G38eZp5QN/HdH+taXTTL?=
 =?us-ascii?Q?flOWcU6lLfGZHutvSl9E57WIXDX5GIKRWYVdHS272Tg0qc/RG7ZOufIC00Ue?=
 =?us-ascii?Q?9arDMRxOekee9X2Ia05tGktRJadeO2iDu3VrNzOb3KXuPNVFOvFU50cJW6z6?=
 =?us-ascii?Q?A4MhaGz4hbJ3IE1Xv/nwYiVjjTW9D40CSlrRC1iiC9QJiYLhUTIRzUThVsJM?=
 =?us-ascii?Q?dYcbaYMcOPWaV+9DyxZi3DNzXv/FU/CnqlVQhCXQ4Pjw8tWiiGosIBOJJKlt?=
 =?us-ascii?Q?kgFhr/p8UvuuEuKNK4bq20POB4TKLGSblstcEeaVo3BvrgkZtUdqcJ+er9FH?=
 =?us-ascii?Q?+2MhFBK6liAthXXXSoXNQjnFAqWFHX+/L5J/rCZ/ovzH+x03jPz/ICXp4tzn?=
 =?us-ascii?Q?B8bHHGyuo09BY1pKGKXXecOGt0cq96BRO6EM6po/thmr1DXVsRuVPv8tyrUM?=
 =?us-ascii?Q?WrJpuy0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VfqzBE8UDZYx3cd7gaD0V8S0KSyRpzCrUpxFhLEJGpBebZbEhy1TVGVY/KqV?=
 =?us-ascii?Q?+J38wnYimoU2HfrLBCz2Exk7SJ1Ar4P4278JbkTEeRiyyv/hKzg0JcSgYrXh?=
 =?us-ascii?Q?BuFzKdGahl5SXeOepqbQjfW+WsLhhVg/YyKZ45enEmB7+KJm/1TH97zOtzXo?=
 =?us-ascii?Q?VuTR/sVcS2ezH2EzmPFsx1YxhPrwSKiO6X78jh7AC1W/O3vK8iD4CNWsoU3c?=
 =?us-ascii?Q?u5C2Lx247j3DgGQ6leAiPIEZzwbPuHr3AdPIDZzQW/u8xBue5RLr0Z9D2WXc?=
 =?us-ascii?Q?G7bp7AbCacpfHJ2FeJAiQfxpzMLwG3enD4a1XVeTwVGkWVX18JQVt5mL9OXb?=
 =?us-ascii?Q?Wq8OWkYDX6Gai6ODwi5zuJB2AGQp7s27zD7VWlkQUlqJAMx72kzgcXaLU0Ud?=
 =?us-ascii?Q?bL80gclPyF4kuN68pbuuHaLkVAJI0rAlxpS0LLCzHD6gkrkVoAYGPQhWhk+8?=
 =?us-ascii?Q?+myuiFeSwNoTHXr7b6ojuf/x8OwHRrAY8gZ48SkrpDF2uUakCzKJSolGRg2R?=
 =?us-ascii?Q?NGt5vfhSSC+4LUa55i29bt2/Mp3qOWiIAaUWZd0Dog0ujK6DSwtsOr2g80Z0?=
 =?us-ascii?Q?/IaUwa0Q48oZYxjmyhJcvq3hIyVQXDw9YuZei/d4Ky46Bnlk4Ux+K1oFPvea?=
 =?us-ascii?Q?Z/wpLY9NIymB2teG3EDqrjZfrC2JuR4joPkBb3cvLGa3wtDtYlKzXmrureEL?=
 =?us-ascii?Q?YSsIhZ0APndQfOTcHeft0Enkw2M3Ei09VqvniZ1cCQwc9pS0ltGhYtQ33V3l?=
 =?us-ascii?Q?vwJhdO/NtLaiaLXN7Ct7+IWJmZhgqwS8jbJzub+T6ekkMy2piZruomXwr/ln?=
 =?us-ascii?Q?xSC/31O8fQsuPlIgcpOMaSKFBgPiMbBfDd1V/K1DJQnGrhC1vQig0HuQS6af?=
 =?us-ascii?Q?1AD2UFEUuvp9CkszaG/JPn6zxscYyGlyYlKwwLbP4YTBN+ymtaCi3IWwSd6H?=
 =?us-ascii?Q?apgXB+/tBYYOfSgUUUR5yhSi6sxuXRMe2PGuo6WlqNyS+5358+5T8TqSM1QN?=
 =?us-ascii?Q?exLIFkXN2gFE1H/TwrY8xRpq0iHSySOU+ByTf6vIxCv79+FV9YeWWCkRrfGz?=
 =?us-ascii?Q?oYQdLqsBy6IGTZkF+HOq1w8801nFZ827noCqV0W81DiXpgpoirl61CcUsVvg?=
 =?us-ascii?Q?M3ehduyjBFe3XX71jsmUnwnO4nqTEcg7gsAHJ/Om/NsyJWQjcAbV0Lx1h+1q?=
 =?us-ascii?Q?Atk2bgBPEPAKebOv4fBpjB4pd8/aNHaTC7ZfSsHhqzUzyQX/I8p+Q6i7zJ1f?=
 =?us-ascii?Q?2KPcgqaRs0g+FGq2CZKCXZTcQMcoGM5hIQErItpS8Imelid+7woMeDb29HK6?=
 =?us-ascii?Q?RebKFdkOAP1a8hoekvEfZpSh+Qok6tJF8N9vhCrJEmaPM+7LYd7MMnVbeTiI?=
 =?us-ascii?Q?KZeosV1rCtg5pd8VkN/iqdhJmb23AJqws+S2Vj/WOx5OHFOUQpT4q3a4hw2Q?=
 =?us-ascii?Q?luBMYSBNXrYFngPX4fn2VLau0KLcCsDSJMtviPGreFgMDOrIayyvrlrwXtIc?=
 =?us-ascii?Q?RuXaPdpROtPESGqte6Cubd89jxWOTwlnkZGtW/cN+5sEfpgoPRMxv0WZJUWG?=
 =?us-ascii?Q?u58M+eoA9jKDdLPbNc9Bm1vPyON6D5Nfg13vQIi0vmAanIcQv4PmimXOYESD?=
 =?us-ascii?Q?Uf4SJxE6Zu7hIpssKRMmpCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b60a5-bf18-4672-4da1-08dcfab37bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 20:26:36.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIJsBxokbb2rQQj/a91DDHQ/5gVaYCTQtTCt1feXrl8k1e7t5lgaF7r8DfL/b0e/19u4QBrpCNmvFKjE5BH7HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4509

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, October 31, 2024 6:39 PM
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Wednesday, October 30, 2024 5:12 PM
> > > [...]
> > > What do you think about this (compile tested only), which splits the
> > > "init" function into two parts for devices that have char devs? I'm
> > > trying to avoid adding yet another synchronization point by just
> > > doing the init operations in the right order -- i.e., don't create th=
e
> > > user space /dev entry until the VMBus channel is ready.
> > >
> > > Michael
> >
> > Thanks, I think this works! This is a better fix.

Michael, will you post a formal patch or want me to do it?
Either works for me.

> > > +	if (srv->util_init_transport) {
> > > +		ret =3D srv->util_init_transport();
> > > +		if (ret) {
> > > +			ret =3D -ENODEV;
> > IMO we don't need the line above, since the 'ret' from
> > srv->util_init_transport()  is already a standard error code.
>=20
> I was just now looking at call_driver_probe(), and it behaves
> slightly differently for ENODEV and ENXIO vs. other error
> codes. ENODEV and ENXIO don't output a message to the
> console unless debugging is enabled, while other error codes
> always output a message to the console. Forcing the error to
> ENODEV has been there since the util_probe() code came out
> of staging in year 2011. But I don't really have a preference
> either way.

util_probe() is called by vmbus_probe(), which uses pr_err() to print
the 'ret'. If the 'ret' is forced to ENODEV, the message in vmbus_probe()
may be a little misleading since the real error code is hidden,
especially when srv->util_init_transport() doesn't print any error
message.

vmbus_probe() is called by call_driver_probe. I guess originally
KY wanted to use ENODEV to avoid the extra message for the util
devices in call_driver_probe() in non-debugging mode, but the other
VSC drivers don't follow this usage.

util_probe() can return a non-ENODEV error code anyway, e.g.
ENOMEM and whatever error code from vmbus_open(). IMO,
srv->util_init and srv->util_init_transport should not be treated
specially.

IMO it's better to not add new code to force the 'ret' to
ENODEV, and we'd want to clean up the existing use of ENODEV
in util_probe().
=20
Thanks,
Dexuan

