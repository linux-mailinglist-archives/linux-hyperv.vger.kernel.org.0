Return-Path: <linux-hyperv+bounces-5070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF0A997EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1234A2AD8
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F426562C;
	Wed, 23 Apr 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bgn52V6e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023074.outbound.protection.outlook.com [40.107.201.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD162857C3;
	Wed, 23 Apr 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433024; cv=fail; b=hy85S0fUpZko9JqffAPXBxKcN3QH9doYqaEwFAJkJ8er+PNb52oNz0rJeMFySSG9Fya5xCrm7ptqlO3oDXLQcv972mKIJioQBB2LyZYjZa+Vb+4NrYMluGdiRPJZEAmwfdMAYm9nbG8LjgHibab9XvNMvxaNzUIdJoFQQR5MZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433024; c=relaxed/simple;
	bh=ivXAajD+gStera4eGtPza/IkfEtwP/w+wnYKZcGk/v4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYDXCQanQDBi01tS7nlRExbsXgRI2D09GO9ueVrN26iG02ZJf+W0Tv9UfTEENR3/e9HdA9JftfwQR2FFaxQB8VM7VueAdaczCIFJixCblkBxe6k9x2YO3HQKByvVumG+n3X+/2P86SjaYd6HfGL1csT2DGeJdON7sveAPw9GzXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bgn52V6e; arc=fail smtp.client-ip=40.107.201.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7sxAcfH2mq9JfPdPmj/wz7yW9/poB1y1lnMVrfd7rmvG/Kh0fmoo7fv+GQ81y0H3t5ddH4O5zi2HsmP1qipE9BVhFXiLZD2xcMIPJH1J1W0/CjdAs36gqhXxkbJCE1vp044IfewWSeDnCzrFF6BBJN/XToIJH9EOoFGkS9kCZ0dqRhCW3wnuYdzbsCCunSKw50t//BcTWoiSvLaOaHbKf8sdXVF+70eupLlE1QPSc7yxtNGOtdtm49krk73XHL4UNNfx6zAzRt5utPpBiTb0MtfrGCTUjq5q1qXQI9nSeGZ7DkDSEETfeWbEiyWximNpEJFcrM2l8M5Q9NuTZlw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzTYj7nIzzCaRic8M9hIasq5ZDCnP+0XKginy/9g7CE=;
 b=km5ceyzneMwHvMr3BLLmRqe8Go1HVaK5/XqAMubCEYt9hlfXZF9nCQpAfwCUk7vOACwR/B6OKzU0yLnxtADHSBn5LQ6vm6FP3+jlGomlrqXpNSutEX1KLK0BBPxvqNUsaOG+KcQ/hVe/6UsKBmJt/vm7k9jZ2aZQQBf6LTF1ZGgVa9XOBICZJ1BWzcowWmfOZOScoUgGPVvGQWcRadiK2Y0BhS6f/Tr7aQX9mKvPMyL2qrq37SRxLQAEVSD0gf5kkZwOOd/nDnN3yp4PRoTa/VYlHbora/fyiWcj+LbxHoiPdHPv6WelKhS+chFcd9crsAXdo3c7ivnVPtb48ony3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzTYj7nIzzCaRic8M9hIasq5ZDCnP+0XKginy/9g7CE=;
 b=bgn52V6e3x65FQJTIlYA7yfQD+2SaslvZxKMkR2zINk/VZonk3wfzQH/ufcmCE657jTGojVh1dPRQ9OIhq8/Vn3kIRbsuUJE73v+PWt8NJvMFuLVWQEYm+PwuwAwSWcrlXEpp3XIIxs5SZxHBdVwlZZkzhj1NDCNoGa87RoqSVc=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by PH0PR21MB4483.namprd21.prod.outlook.com (2603:10b6:510:330::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.4; Wed, 23 Apr
 2025 18:30:18 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:30:18 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Fix uio_hv_generic on 64k page systems
Thread-Topic: [PATCH 0/2] Fix uio_hv_generic on 64k page systems
Thread-Index: AQHbsk/vev7CYGApCUm330WfjNHG7LOxlrPQ
Date: Wed, 23 Apr 2025 18:30:18 +0000
Message-ID:
 <SA6PR21MB4231AFA71519914D77F8EC07CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB4148A6C1A29019D9B016D1FCD4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB4148A6C1A29019D9B016D1FCD4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f80a537-034c-4232-b2b1-21fd6e71ca99;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T18:29:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|PH0PR21MB4483:EE_
x-ms-office365-filtering-correlation-id: e9d03dd6-75cd-4741-fe06-08dd8294e625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1k+THsK87jdEpZh6g3BWFpx5DX1HYhA33YZDictcK9c3TfhPrwnD3OrUF+nq?=
 =?us-ascii?Q?hpkHCEIvXGV5TkrYQV5Jzdb1SCNn6swwrw8wLjiVVoGBlqPUESoIiMwJntn9?=
 =?us-ascii?Q?FuwV2Hm+AVAIraBTsdOF3UZe2qrpjhi0NxiRwF59PKrxIJynm92WT5aN4oh0?=
 =?us-ascii?Q?nDWNvvroOmie9Ji7H2AF10UsoeTGrMuUwV5gVUyoiO2Fi+tWPK2yElKKTMe/?=
 =?us-ascii?Q?CaydH96H144kTg5aIYieJWvv08n2ZTLCp/ApxOMfVZAzGv0Jg7wwMzD5thod?=
 =?us-ascii?Q?oMgAsnp6zLLMPq2o4vP6Gow7meUWBMeg/qC8wLS4FVAiypivamilBN2mXP3b?=
 =?us-ascii?Q?dV6UfpK7gDQ8ZimKzL2gCkeT8N0shIHTRqBR8uLI1yTia+hjpZXlwN0Adht8?=
 =?us-ascii?Q?OotaAfV5Mazv/ByOL4K/O4yj11dn9HmuTOD0nyKfJyafuaV2VrycJR9XZ5hc?=
 =?us-ascii?Q?hO2ALLfhXifdi9pQ9ZHsdBYgKsjkfCZ+CYNtLkayUUJ7UYqD/P2ZUz/2x1Fk?=
 =?us-ascii?Q?XmYJ4iEaHK/y5OfcfyMQsRs93MJnxg8H3/BF+Ty1iho/HRd+PhP2U5YZspyl?=
 =?us-ascii?Q?aulc8plwJAJ0NiW/UbqUjeyONUbulBHLdV71GKIHOKGpBfxSc76O0b3np+m7?=
 =?us-ascii?Q?K7SRONir60VYYhVqkMBNSBP0XJ7jRHqDrcb98pGgT6bla0PMb/MUVSbXVB4o?=
 =?us-ascii?Q?Ya5z01s7XfvT/3FtA/4MeYjf9+Z1iaXElIZlGxosTQXpjx52oz8I5FqTyh2n?=
 =?us-ascii?Q?262lnbfina596a/6IzpIoKw7LNj8VHqp6QKPrPLioUxaAz5dNAFkZ3oJu6Qr?=
 =?us-ascii?Q?SRZmKVV7Y0iv+jtX/2ykaLURObbOMBwu22LWiret4DHfAWEpRIdbBjZYy0K6?=
 =?us-ascii?Q?MT3JbvEoHYfs8/ynGVPKqlczN3c2/SYBFYncpcYUJzDGG5HqUfh97sqB8E63?=
 =?us-ascii?Q?AYarKiuIZHC0x/amGvsHcgBFjMdN3FS4z+ggWTWeUkmj3zCPy+ksZo5IRIgQ?=
 =?us-ascii?Q?+n2/L2UYWj97XbZ+0xgJL5WHpqLel9YT6lnUFyhTGWh069MSJJiqXEFINWka?=
 =?us-ascii?Q?Cj2R5P1gWDNNO8Qb0C/7ir5SABHwm3eO6G+6v2dfjEQ05FrVGCJG1IBideQ8?=
 =?us-ascii?Q?OEo104H14gZKd/GQyhU5vbFbBCOES439nCSXR/ctCNtoAvsA2tFoUEP7s4gS?=
 =?us-ascii?Q?V1QAEkGDHZZjqhVsu/viRNiFvVj10i2KewM93ti9OpZGzsw8bFLwCG05h9jn?=
 =?us-ascii?Q?rEoZYDhpD3A6FH1iVzTggmWL6t4aVJF5yx6hI5BxqThWortTTudTX2fVMYrf?=
 =?us-ascii?Q?pPxsJCk0OLSdSV/5N96Nj/4+xLNzzUM4KJYlFRRQ+SSik4ms6ri7mr0io2IG?=
 =?us-ascii?Q?ACVg2aCOWABoHxh8WCjX6wrCyJz5K7W1n1Zo+rmvrd2p+eYVufLrCCgBCvWI?=
 =?us-ascii?Q?pSHIQUWTVW5wj38PluTHWz8w+PViz7teqNNF7k1dXy8aoY2t+IBgra6lSOih?=
 =?us-ascii?Q?WcMIwJii2GzywtA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ajfwhT9lN6nYF6kkkuLlgiVJripB3zBkqPoVdAhSt2cHTQcYQtlCVpiR0UN8?=
 =?us-ascii?Q?7EXnmOQfY1HuHT537xABDuuCE+kwkq4EsPqR9Vu7kiHcruTdqORLvPs4RGt9?=
 =?us-ascii?Q?4ruF731LN0ehez/Ia42iofsALQ9UXQt1wPzifcjrhKg5KxxCdGAmH12xZOmG?=
 =?us-ascii?Q?xePt9lcoKyGxDKyQzd74F8sPLrki8ajzxhJpNpjNMbhLYW/UugjhJQYUbEn7?=
 =?us-ascii?Q?ygS51nyC4xOIUy4fy0In0YzrA/z3k/1It8zdy07R/Nx9rPuvhXD5UuSgIOvl?=
 =?us-ascii?Q?reJuiuH8k4Vk5V50ayOVsTpr72lMQSL+bfVDR8fScJ5GP5LOvrbyJD98+MVN?=
 =?us-ascii?Q?Ha5SZ2eBvzV8TPun7+CGx1FkkYCzfky2LCcCt8Mkzo1VMPABcp6+csptoG4t?=
 =?us-ascii?Q?hDPGvm1zTYJ8Qec/oOF6zEpxep99gpSXa3ABMeUFakmLEGX1qp75cLc3TBZa?=
 =?us-ascii?Q?H8y4jMlVqN0EF48ig+W4nVvgnRY4AJ/YCtCKt3cWA1IlQopywTMoeLhNHsJA?=
 =?us-ascii?Q?hs75TAoK5/TO0Li8bQlqhIHl21CojAhzS5C+7CrKjYNmInwbyCHJbVdn3Ri3?=
 =?us-ascii?Q?PrydQEdWoRMhsbc2guR1GW0Az0TH3OqiOYGtG5G0feMnIpiZ+B9qGhPmFNcu?=
 =?us-ascii?Q?CvU3BYZostfPEbJyotUSAKOyLbTUp0myZm7le7iUZZaCpdtnwQnJT600UzQK?=
 =?us-ascii?Q?emc45Emiw0L9qmkqMypXwP8sLZxJd+ankap0VM4BU2CgK+7qLFerK6aPRllQ?=
 =?us-ascii?Q?EkG+3Wq7U0f41GO/tNF2pNt7rb9QZV4cRzvGBnm5fs1f59sU/A2Owe7d5rsc?=
 =?us-ascii?Q?D6uBo4lma2a7Eq9QqcEDL2C8lBgD3lWEByZqk1qrYt+YDhFvBsW5V8GXtOt0?=
 =?us-ascii?Q?DJlkInXuiRFwttUU5DuZEyCb3l1/yRot7J6PxwaOitiJgaw4oDdS6jfD6vCv?=
 =?us-ascii?Q?HzKPq/nluCjwd7DcaYHE2OGauzO4sm1zh50eWiNEqVlF3ErzKz1wVjRMH5B6?=
 =?us-ascii?Q?PLlu9lSLH9S9ppad7xTFqffnpK4nFioZ3BrUQioTcmlc4L/svQrOdn8tVoHn?=
 =?us-ascii?Q?CGA+GnjQOvQwbBcSvCVvgpRCL1zIxpEiMgnl5t0Ahi13oc21+Cnb1WIZByDA?=
 =?us-ascii?Q?0WOtwupeucu1SjH/F9eL4EOG4w9OSLKLcKIi+u6/sNClR8Q99HL1g+v9oLJQ?=
 =?us-ascii?Q?03bFD75jMCyvtW2NRNr49a2iy9ovh/jljJz0WXz8a5FHWd6R2+ZtxmsO+R/+?=
 =?us-ascii?Q?XAiIzh6/BOR10OA1pcIuw6FyYhVB9NK7A/xZD3tic3WGl8r781yAo1XvNeX1?=
 =?us-ascii?Q?Wr7+w4Zy1Xa/M2rmD8UpsnM3H9LbpL5RgaHqlq3VJ6WjfsRXH084J7DtpfUx?=
 =?us-ascii?Q?ozQ1epXMDxY7RfZhXzjm8fdJtWySmtg78V87zQj8r4YNXrHdgLkfIqX6R8gi?=
 =?us-ascii?Q?aNoEyQt5fWbLbIXToxARWZnQa6gNAnDH0kGMx4VPsaaIuEWhC+uLaWpfbcFP?=
 =?us-ascii?Q?l3LoMmk82gtY3S7akw5FWEYiKeDfCRI5KZcQKlwiVyTUXspRs3JixiyfFcIH?=
 =?us-ascii?Q?0FaHyejTVvS9pFSLOYfJ9vXtg7MFFrB9fQ6e8OxQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d03dd6-75cd-4741-fe06-08dd8294e625
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 18:30:18.4403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBGynvnPveTuFX1a7KZKxyefuQdgiTYkMXZbUkfT1uhoSy5V7ubIEM7wqzCeoLqgS9+MritMMEw4qsdgUi4VvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB4483



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, April 20, 2025 4:57 PM
> To: longli@linuxonhyperv.com; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] RE: [PATCH 0/2] Fix uio_hv_generic on 64k page system=
s
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> >
>=20
> The Subject line of this cover letter is a bit too narrow in scope. The s=
cope should
> be any page size larger than 4K. For example, the arm64 architecture perm=
its a
> page size of 16K, and Linux kernels built that way work just fine on Hype=
r-V arm64
> hosts. Perhaps:
>=20
>     Fix uio_hv_generic for guests with page size > 4 KiB
>=20
> > UIO framework requires the device memory aligned to page boundary.
> > Hyper-V may allocate some memory that is Hyper-V page aligned (4k) but
> > not system page aligned.
> >
> > Fix this by having Hyper-V always allocate those pages on system page
> > boundary and expose them to user-mode.
>=20
> Also within the scope of making uio_hv_generic work with page size > 4KiB=
,
> there's an issue with the ring size. When hv_dev_ring_size() returns 0,
> hv_uio_probe() uses 2 MiB as the ring size. That works OK with the larger=
 page
> sizes. But when hv_dev_ring_size() returns a specific value, it might not=
 work. The
> fcopy device returns 16 KiB, which will fail. hv_uio_probe() needs to use=
 the
> VMBUS_RING_SIZE() macro to increase the ring size if necessary to handle =
the
> larger ring header that results if the page size is > 4 KiB.  You might w=
ant to
> include such a patch in this series.

Sure, will use VMBUS_RING_SIZE() to increase ring size if necessary.

Long

>=20
> Separately, tools/hv/vmbus_bufring.c needs work to operate correctly on
> arm64 and with page sizes > 4 KiB. But that's probably a different patch =
series.
>=20
> Michael
>=20
> >
> > Long Li (2):
> >   Drivers: hv: Allocate interrupt and monitor pages aligned to system
> >     page boundary
> >   uio_hv_generic: Use correct size for interrupt and monitor pages
> >
> >  drivers/hv/hv_common.c       | 29 +++++++----------------------
> >  drivers/uio/uio_hv_generic.c |  4 ++--
> >  2 files changed, 9 insertions(+), 24 deletions(-)
> >
> > --
> > 2.34.1
> >

