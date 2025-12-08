Return-Path: <linux-hyperv+bounces-7991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F9CAD892
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D5353018D7E
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8824677A;
	Mon,  8 Dec 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NrmlN1NJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A671C84D7;
	Mon,  8 Dec 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206783; cv=fail; b=j7XbGB1Qb6AY/Nx1nm4/+Jf95hTjiUf6x0RlSxc0mw5Y0NuD+va1TyCEnWIYL9YauJ7uC2/Y0Ik/cUFweuW/JRYfDNF2GHHiLDDUG4HcV6tf4Qj/Ane3US5jL2GOeS7ND9IcY/0gSHE2GhDyhO1My+1VSS/Fo0tszPkFlbKha+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206783; c=relaxed/simple;
	bh=90HY58914hGASimwBgnZ3aYZ5VAs6mzlRCroHD6ZrD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hHfpJffJPBpHTzGxRlzQMhUaXHggRMq3GAzavWAsVST6sTQITJxCjGm/RSqQCW5Xws8PlmnrwDf8sGLYtQeSU8ufqAoHxGl0C/vy5IPlw5+xw1OgWtufXFnvqa5KVWHUvpm2Asei9dkCmD9iyzbH+3EBWdvEuPGAHx5v7o0OpKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NrmlN1NJ; arc=fail smtp.client-ip=52.103.10.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5vTf1kZ4WLKeB7k8SG+bzhlzLcKHYCM/UKIStLc1oKxjIGHeYQ7zILiSEnOb18Holvo3CRrCFFmFmFE/xHKZIRrx+oCjNii9ZnLeh5HoRlwB3etFpfAERHFKa+vCTgYwQvPqykHabEMXv3Y7cSVeew0jPfo6O90/SljqM0TViyDilaGU0edcDkwk9es3S98cYKphh6no0Nh7Pcokda9V0OhK89K0rBet7YtMfmUQ54NbSdRcTEZjZOlCUdO8C920YylKA/YY/Glsp3VcB6ViDVbKM1kpX9C2senRWexcw8Sg/J5sRHdsOlk4EHZi3WnZeQb48vCB0UbhHmBCaOfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdxnmSCc2TNXv3smsTANqJoqj6HQ4UFwSezlVZwI8nc=;
 b=b4vUUNY1ghzP8IMckCjHofdZyN3zi3W0FbPwQpHeTv+jrakvw5bVyta0deQ4eqIaD74yWbaRXOJL71eKHv9IyCk5g4LVt6ioUS9DgyHmCE9adiATvx/5dY9sQiAi01XQJQX0hqcQ3iR6ux1BDc2BT0Sa+nMcK1FmlMOA7sckjcgMzvuUo2S1IXchEQ2P7qwnYnCepsUa/nllt1KLi8/JOIRQaLSlmwQCy8t08MfdzmwgJhZwnV/QKcaoJqd6nrk7wjxin1fOVDs6DxH2Wk3Ij921GoytwkaNDP1tE3X93poASXDpCZA9E5hl+ZlSTTghZ3bK8YgFMqjM4MhDPcmfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdxnmSCc2TNXv3smsTANqJoqj6HQ4UFwSezlVZwI8nc=;
 b=NrmlN1NJnCmuLOz3NbZBgyVCVmWFQUZiXHZ4sxev/UZrjBMIJxyW8rGkNfIyMaO28AYTlY7IqqdZ1gN3usKLXU6WC/EoScRD4tqLXf9W+50cwPapyXJ+C6Hqj6kUjO5SIdx4roycB1okYO31Zm29AOLVi32eAG1sS34TaC502pA9Pc+MgXS90iA+TX653lxWhm76Y+7YDItpeNr3GZtHE3/B1SoG93qTM8FjTeZ2sPsjHf4qsRbTEsphZhc+GikY0YsXkskaDPUsGE9HwQ1hqV9ei08Hs5/fGmu8LqpBnnf8bE+8o08CWalM6kNRFL/42fz2+ukkXOvKvyBV+Bz+Yw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB11197.namprd02.prod.outlook.com (2603:10b6:208:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:12:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:12:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Thread-Topic: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Thread-Index: AQHcZhkveM6Wdb5Qy0aycTcpRguOfLUXNUnQ
Date: Mon, 8 Dec 2025 15:12:58 +0000
Message-ID:
 <SN6PR02MB41578C85BD5C114340677F84D4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB11197:EE_
x-ms-office365-filtering-correlation-id: 9b6967e7-09fb-4cba-8d1b-08de366c4565
x-ms-exchange-slblob-mailprops:
 9IecXKUgicB5Y5xtj3Bi4po1AHQXatGhKQ/JOOTxyAIQ+qJ+YEK1FbHowXG8c3Ej0SVM5E1EzrAZ2JZcJj1w5IJ3x1ph8MleHyiHnfzN4l+GGw0hFGzV8SxcV357IOwcOiGycdZOCg1gZ8+2oF/fNXeyl4EMO4enm1svsAfD0qaMnSh9s4f+ggkN9NgD6t5xx7NK454tuI0Q50xetdt79ygFm3d/7IfznGDXR5OgnUErL1SIMctqAjkvtEkkttzoM11DSxxUWRROcPZUvBnka9mKTFRJ+Z5PHe/ffTLetGRlvAwQpl57Nbw+AxuzfIS16EU8H0Va+z4nwYMfCYqHMLKFzK4ljH6f3Ncz4QIdLgX1rBEMxoG3xpwvtamroQZYySSx0GfytzeyA/BcsFiizyp+8NHNqM5NEdWd1vgcUdRE6F3esX1wjBiueDriKh71N3T6IAx9zX+IQQiDcJuUnmZw3DVX2rC9zdKdrUBz8imYrgfOazeelZAF2mZVFni0uY2N+mZi37ZD5Am2WtfTj77gPGrFapCRSyiQiFqYcAJRVFDTAi6PS5QRgYA1iqmbzu/Dli35f53ebgCZcIpq8YY8+0R4Wi7vv4q4mXTEl6/VXsQdyq7U4PLaBmX5MpAZanoNV9eFXoR3hv2A+ctVyvMQCRTghbSQG023mMajI8Yt9UZUUKISAds/caNL1LC6tjOY2yhIqRiNWnVm0OgEpu6GTc6xNzFOFeZX8IKQtyJnSzKytxY06Q==
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|41001999006|13091999003|12121999013|8062599012|8060799015|51005399006|15080799012|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PtTybSw1pEr7ft4hFu9g9h2EDSkc6g8kECf7mZWj3cJw/vRJPf0UEDYNPBWO?=
 =?us-ascii?Q?thyIevETCh9pQjr1FZTI/IHnxDbvoMYolOYQE92OtyBqrWfhXYB//sNLdZVf?=
 =?us-ascii?Q?JEchGhrdYlWNhNI3BdY2v8c/ofkh54nJa/uWRDsrYiGIuhOiIYZYmsJwHeIv?=
 =?us-ascii?Q?r+JTMzUn2Zh51ttdVoow1ZlCW2u/iLHowoWnfLsiiaWje+UtFgozHy4v+7pT?=
 =?us-ascii?Q?OEty8t5NT+haF9NWMPeAVRIQ33ejXt4HxtjKpTUl3k9T9N3UrDo/FZhFKTmH?=
 =?us-ascii?Q?W6uOL60A2i4BXw3BwB4TmCWYbSWKODjMdpoj72Rz5nH5KH4kaaK/neJI/WN0?=
 =?us-ascii?Q?c7udXUJPPH2j0BgU1vzuUdpHY8x5Z2uLLqN6yxTwuo0aiISL3a58s5WVzryQ?=
 =?us-ascii?Q?flFEYbHgOFzLLpT1nlrGFl7VwVhC4IN2k4r3BBgo6B0lotSyCMx4e5UW70NS?=
 =?us-ascii?Q?Ww5Wwk8tduKwoUHhlUULRbTM1yDWEZsekXajSQQ7vyHQb+lGMlF+9DR1di4Q?=
 =?us-ascii?Q?7IWGjpPwjl0EA714hLf8PLYSUAIpN/y2PnGK5gXipojSpcWN9oInmss2+7vu?=
 =?us-ascii?Q?G6TKb1rGBNIr7LdWd9VMIXgOKeqUiqfzE4/D4gjGiY7HEjMUXUZu52+wHKAa?=
 =?us-ascii?Q?tAGJlUB/hTlC5xB7gZo++ooUk0mqPnpNSjKjN3Rsp4jWBJ6tTXAa03FXEZkr?=
 =?us-ascii?Q?Oth+aYp3U5dty3qoUmv8qLpn8Z3zXCLxmJUCqzNwdArKiooWadSMpqu3alG4?=
 =?us-ascii?Q?HU118Y1pI+k63NklQc9PHVoHuOiLmwyOHdGajTN7qeeyrN3jvruzc5kRQLYi?=
 =?us-ascii?Q?hsBgrE6J2M1Z/iA8kYKpNGcGjdgkSe0Ha9dZLcmfvMbqTnzXDADgMaUWDfTE?=
 =?us-ascii?Q?H0QKoiaBJKyOE3aCLlx/PJRt6BRFiXyDMGvr6DyobvKx31ndglB3OMQBM2iv?=
 =?us-ascii?Q?zDHjq1/MzykQY5OVQhXOcrd8oIlTzAWSZUn/SUAuKshIXLCmrDdBE0yQR4uu?=
 =?us-ascii?Q?j9BejuzhUkHktvBJFJCpma6wgUmy7vS8Uj/fHBOSiGViFYlCgTBpp9ZsvjsF?=
 =?us-ascii?Q?9xVxKsBoBjtliJpHRhe0aNDslagYOIxJB+F1MCXKRyFT1jziD55RuBeyZLaD?=
 =?us-ascii?Q?prJwMx/Xvxug2A83zMwCj2DoM4p1VYDrkLiYv34cc23raVHRdNeYbD4pZN2D?=
 =?us-ascii?Q?pE59NZOtjhr143cUX3CLxghojz0+tVrimKhH7tFUn7hbQkDLB6O/br9p5IyZ?=
 =?us-ascii?Q?QvjpEtXYseVifTCCNH07CkPHfdSUZ7OU31my+imw4oi/mN4QfsX07Vr6V5Ji?=
 =?us-ascii?Q?Eu8TNSmusRUrS//9S0qLwVSI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jCMoS3p2CysnieQX2VJwB7a/ipEBDhyPvZFR9UU/CKqktFjojPiFqNtPzVun?=
 =?us-ascii?Q?03Rp8zy1j0TiZIGioq643j6u6wMfkfUI8PhI4bmlJlaq1KIg4hZ90KZCtCLw?=
 =?us-ascii?Q?v1GUaqffySimi4GOcUQjZcZf8SbxXPWJSO08xy77nrfCTBRaIb7lAq0ESGET?=
 =?us-ascii?Q?iNHienPyeFKbPHrQXw3floWWLdtptfQK90SA1AvFNnURwh8ZeDE7ui3t4g0q?=
 =?us-ascii?Q?s6DS8aylbEkdBVM35FxX9gqEogDUAYswazEFcTAuF9zjSqIsFYVlQW96MWl4?=
 =?us-ascii?Q?usrOJL8rWjJTJXeu1UxmDSLVG5lBOeUoUq/qZk/8qMhpIkFw6RfyShnBTUQZ?=
 =?us-ascii?Q?lZvrvy0S4DiasP4MwR1A6H2akF0ntf9Smxhscdv59nRNweBD4PfAmpKIlnes?=
 =?us-ascii?Q?ARawg6AvARG4tP5p8kKr4Uglf2Ok7bCt5eG13I2gQijyqPfsSMb2ZiCEklaT?=
 =?us-ascii?Q?N5Wvo1oYhSTarSnFw/dl1fOB8eYe8DuSHY9SwXTNdf+kC1HxZ8U0AfiBV1P+?=
 =?us-ascii?Q?5BYKBBaeX14DVqSm/1rhykfMVLTxcIntBrEOZLpv8GIv/LmpIFgKdkMQhNeF?=
 =?us-ascii?Q?Ei58r/Whtov+B87fIfsyHc2w38Ze4cJU9eGLB1KEExRoaCG+4M1X7nOslbE8?=
 =?us-ascii?Q?d3uc0SHYIx1/1QbPHEghkeqTYEL2YBw09/RxBW2ZJLv15Dc3PGF9SM85bltu?=
 =?us-ascii?Q?F8PQ5Myhc6+Ftj1u/TmA+oI73bnkDZhYmYAu61pxuloYxD/Ap64IAvhMOadO?=
 =?us-ascii?Q?t2xnqiBcSjoN5P5xBjfBjbcWDZoEnbLjaq6puDfsYjNVS/bkth0ZjoNDJ36U?=
 =?us-ascii?Q?xDOp9jBp4q/CRWABbPs2hkX4hxCRCebEb4CUo52zCyvU8zxVIITL6DK3h7hs?=
 =?us-ascii?Q?oEdyjYRtYaS23jqfkrp6+x5KHtcnSjMdrZNKRzG6AgwPEQm/I3weVV17jWm7?=
 =?us-ascii?Q?TrHpTccRAYPTWBhj8qk8GXaORTtvjYeWh8W97Y0+bL6LmMiwyeiTVyvbU0aD?=
 =?us-ascii?Q?Cdh4o2VphTawESSm+5e+EuJ3u8avRkTm03Ud/+g/BEVL5cOqpRqmH4eN9TrY?=
 =?us-ascii?Q?7riOJf1JKyKUPnH7rDLFFoOm4YzX2RKfjuUri056U6Hkui71dBsnBh+tDC4k?=
 =?us-ascii?Q?ewoOPtekoDGqCZrlKbey2Fj3a1vLdpjo/wONLjlqCvUY+4eUZ9qYmewqlnIE?=
 =?us-ascii?Q?Ub2FVMkN734T0O0+BLY+kO3mVN2YaiAFmnIlSuDetEq2tgd0/SpMhdmudj0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6967e7-09fb-4cba-8d1b-08de366c4565
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 15:12:58.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11197

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Decem=
ber 5, 2025 10:59 AM
>=20
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>=20
> Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
> and return HV_STATUS_INVALID_PARAMETER for the second stats page
> mapping request.
>=20
> This results a failure in module init. Instead of failing, gracefully
> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
> already-mapped stats_pages[HV_STATS_AREA_SELF].

This explains "what" this patch does. But could you add an explanation of "=
why"
substituting SELF for the unavailable PARENT is the right thing to do? As a=
 somewhat
outside reviewer, I don't know enough about SELF vs. PARENT to immediately =
know
why this substitution makes sense.

Also, does this patch affect the logic in mshv_vp_dispatch_thread_blocked()=
 where
a zero value for the SELF version of VpRootDispatchThreadBlocked is replace=
d by
the PARENT value? But that logic seems to be in the reverse direction -- re=
placing
a missing SELF value with the PARENT value -- whereas this patch is about r=
eplacing
missing PARENT values with SELF values. So are there two separate PARENT vs=
. SELF
issues overall? And after this patch is in place and PARENT values are repl=
aced with
SELF on older hypervisor versions, the logic in mshv_vp_dispatch_thread_blo=
cked()
then effectively becomes a no-op if the SELF value is zero, and the return =
value will
be zero. Is that problem?

>=20
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_main.c    |  3 +++
>  2 files changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 598eaff4ff29..b1770c7b500c 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum
> hv_stats_object_type type,
>  	return ret;
>  }
>=20
> +static int
> +hv_stats_get_area_type(enum hv_stats_object_type type,
> +		       const union hv_stats_object_identity *identity)
> +{
> +	switch (type) {
> +	case HV_STATS_OBJECT_HYPERVISOR:
> +		return identity->hv.stats_area_type;
> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
> +		return identity->lp.stats_area_type;
> +	case HV_STATS_OBJECT_PARTITION:
> +		return identity->partition.stats_area_type;
> +	case HV_STATS_OBJECT_VP:
> +		return identity->vp.stats_area_type;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  				  const union hv_stats_object_identity *identity,
>  				  void **addr)
> @@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_objec=
t_type type,
>  	struct hv_input_map_stats_page *input;
>  	struct hv_output_map_stats_page *output;
>  	u64 status, pfn;
> -	int ret =3D 0;
> +	int hv_status, ret =3D 0;
>=20
>  	do {
>  		local_irq_save(flags);
> @@ -878,11 +896,26 @@ static int hv_call_map_stats_page(enum hv_stats_obj=
ect_type type,
>  		pfn =3D output->map_location;
>=20
>  		local_irq_restore(flags);
> -		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> -			ret =3D hv_result_to_errno(status);
> +
> +		hv_status =3D hv_result(status);
> +		if (hv_status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (hv_result_success(status))
>  				break;
> -			return ret;
> +
> +			/*
> +			 * Older versions of the hypervisor do not support the
> +			 * PARENT stats area. In this case return "success" but
> +			 * set the page to NULL. The caller should check for
> +			 * this case and instead just use the SELF area.
> +			 */
> +			if (hv_stats_get_area_type(type, identity) =3D=3D HV_STATS_AREA_PAREN=
T &&
> +			    hv_status =3D=3D HV_STATUS_INVALID_PARAMETER) {
> +				*addr =3D NULL;
> +				return 0;
> +			}
> +
> +			hv_status_debug(status, "\n");
> +			return hv_result_to_errno(status);

Does the hv_call_map_stats_page2() function need a similar fix? Or is there=
 a linkage
in hypervisor functionality where any hypervisor version that supports an o=
verlay GPFN
also supports the PARENT stats? If such a linkage is why hv_call_map_stats_=
page2()
doesn't need a similar fix, please add a code comment to that effect in
hv_call_map_stats_page2().

>  		}
>=20
>  		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bc15d6f6922f..f59a4ab47685 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp=
_index,
>  	if (err)
>  		goto unmap_self;
>=20
> +	if (!stats_pages[HV_STATS_AREA_PARENT])
> +		stats_pages[HV_STATS_AREA_PARENT] =3D
> stats_pages[HV_STATS_AREA_SELF];
> +
>  	return 0;
>=20
>  unmap_self:
> --
> 2.34.1


