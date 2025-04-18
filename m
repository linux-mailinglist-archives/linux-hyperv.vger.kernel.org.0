Return-Path: <linux-hyperv+bounces-4970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A2A92F08
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 03:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD2E1B61858
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 01:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527087082D;
	Fri, 18 Apr 2025 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GwGYjqI7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023114.outbound.protection.outlook.com [52.101.44.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F3335BA;
	Fri, 18 Apr 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938556; cv=fail; b=ZhEN7tnkB6pxlztwh3UJbbOezgjaEFkzUW/RoeWNFVXsF6RCDzi/fzmfiik9xE5HStVmjWFqSduq+8LJ1YeYKZGh+7nYJhWlAb5yanb7QZukdit2sgQDutZd4GVsR67D6QZLsvVo3KhJfR46KnuoBgpPcWm+2WghMi4EGxLZ16Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938556; c=relaxed/simple;
	bh=63wxbnNEMriMzE6Y4XsjCCuxQwQtetyx61hSFtdbI1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6T6Mit4RS81eBGgLeqsK+2nU1hrS2bBs/lkJu6vQQ1bf+Wttw0RqblwwQAPK81pkECB4913+sa1HBriHXkgWW9isTAfQbYQ1TlpkOnWDCQ1bwmQJ5YhNh/hUb0NyQ+ldc3M028JQBwXYdPgmr8IpxyS61nCm8ooVVJbStRCDtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GwGYjqI7; arc=fail smtp.client-ip=52.101.44.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ151fCX78C4chIhFuhJr/SKn2igD2Q5j7b+36ZgQIvH6Ros7f0sridsyOaUVSoB8Gd3WVIGaYa9x7MNdaYfbeT1pUEEulCC3Wh2krFRqmaFWMWdg2q1XtGWnY7gJFcE0vf8i144aTIElnpAtv5KRXSdxXdTrK6xih9vRSnrOFxNwRdmgp2WoKTKVF1QPibcG8IiDkqoG++r0C1+o5nBr6Scdm4VC9m4Gyi2DrclaIkpAvn1bNfVwt0esPhmL8WTdaVCGuOux4NHyRYoRqXwFq2ADNzZFwyx9FbJ5tdfSGVNXOPY/fbTMX5yP7f2bW1PXLNVZHGw6BFFF18msJLVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idkCJ9iOfrom6Fy2RayIxAn5lxPuPLPGK5UML960zmU=;
 b=pj3aV+0J6vG0ZLTHr2iiAHXEXZUNEsQ/2FwJB+SZmN/70RUqD9KPtx3gjjZ+hkYO8ryPqOCXhTxaeTOzddYW0Bqycd3tswDdtZLi+hPsaKLUoJ1zLLE4++Y77e1SVSRc/jBn9tQ5K557SVdKoiR3uh5njEGe4B03nNpNfzK0us4AKzwGBZSCRXtcjhV54XT6WVu/qoh0lnUEqarpUKfWhTioiqMqXycDLgQJAjTWGo/aZ0fqkWiXZcW/sg+7kBSoVNT5HSeRCeTh2ZgNOppfGR9Z/tRMvar2ulhb4Z09gOqxrfYeRpUdiQpwkF/qd3+FSdmPV7Sx8n6BwZoTXQE/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idkCJ9iOfrom6Fy2RayIxAn5lxPuPLPGK5UML960zmU=;
 b=GwGYjqI7Z2orRCysdYOl6xwBHd8Vf1pCMzzZCmdmuekavo4KtdUfIvMb81nTESdxdnbkai6Ztt7XOT6hjZd4vAHsU2P6O3Uodqfs4ygMnMLpJ7oVyvHu0mXgKf9p4xby/2dHTgiml/t9ItubNa1z7mGqE2TQcTKe3Vz2F22YD2Q=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by MN2PR21MB1438.namprd21.prod.outlook.com (2603:10b6:208:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.10; Fri, 18 Apr
 2025 01:09:11 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8678.011; Fri, 18 Apr 2025
 01:09:11 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v5 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Thread-Topic: [PATCH v5 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Thread-Index: AQHbriXBhlOKA9Z0wk+QbgZNtFbouLOokD6w
Date: Fri, 18 Apr 2025 01:09:11 +0000
Message-ID:
 <BL4PR21MB4627D99C78C22A8C3355059CBFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
References: <20250415164452.170239-1-namjain@linux.microsoft.com>
 <20250415164452.170239-2-namjain@linux.microsoft.com>
In-Reply-To: <20250415164452.170239-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4a65c538-2c9f-49da-aa0e-973a35011b87;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-18T00:10:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|MN2PR21MB1438:EE_
x-ms-office365-filtering-correlation-id: f4d579c4-6e2a-44ec-ae66-08dd7e15a0af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sbaq1vEqBAd3RjT5WYZyy9qYJ2Dhrv2/OK9lG8DGaSw76Qt0Kp+XQ3HB+d1a?=
 =?us-ascii?Q?qjHHtFY3KUXleYBd3fUvJjnOdu/kE8fnuWxONMiM1m8uzEwogn0tQD8M+oCH?=
 =?us-ascii?Q?F1FQke6IJRj/KQYnV7ecDHxnpLMwI9m8aM/Fv4bM3DWbkZAWsy2+Va5o2BQZ?=
 =?us-ascii?Q?nx7JAtxuytryTU+v+gRMkfUbfCXITnPUT1CPeAUAXafSABqo3a3UE2nWEUJq?=
 =?us-ascii?Q?uQpz9jxUJtrXLmab8OHs13uOrJZdcpR7nFOfrX5oBkINamJa2l7J1tqKfRON?=
 =?us-ascii?Q?0xdVIYWrbEus8zc3rR98ZXUgVzNN7Y07elj0Z3ku+LSSOGN35fz6UiUDVyx3?=
 =?us-ascii?Q?MCCG6LxS3Ylz15QYFbvyVkpqHuju7WVpkjpPXuGM2PMJDjnZ046tv1KYlYD/?=
 =?us-ascii?Q?maYvnga43sHMPqKMnO2FksL8ebjuOxFzgb0jpIHMfrWRa9XHw5qP8IqYPwtg?=
 =?us-ascii?Q?AvOFcuTaf/0Sgl7UAex3+M14/UrqEvB0l3mOgundkruEu+rzEZ4q+FoynBw+?=
 =?us-ascii?Q?vefpMSFkI/jkh+oyl9Nx4TkOs4tE+SlA+/3XrXwwv+IN/29yTUd1NRtdwH4u?=
 =?us-ascii?Q?BAoX1/hmGFYMN+UE6s4xf+synwwlaRwAYs8t/8GwAU+KQxcOsTCwtw7RjY6a?=
 =?us-ascii?Q?IAf0yUs/41OKtajIdcK2eFYSv5hrpeZStsnMNn+Ce70HWyhR4JlV9wWv50L7?=
 =?us-ascii?Q?UO3F2DDFAo74kZmUyN+4dZvmE/kNzHllFlpiSGalE80zHrcCg6aDnkA9GbT0?=
 =?us-ascii?Q?4+3q/B7ZSme4+QimYtUmKLn/mlSVT3T7yId6I0Rf5UsEY2+TqkqA78YxcqKl?=
 =?us-ascii?Q?9hct0CIHS/j2H44w3rLK+zC28agVmVpigFG1r9NmZMb1iYnhfp6mXGbTuf9m?=
 =?us-ascii?Q?OzVSUfp5QeOgaLFn2ifKbpOnocnzvLFxC2HirdZs3K01ffKj5Uh8T3Wv2bf7?=
 =?us-ascii?Q?76hEapsqSniJnmBkI3iZH8m9HO8cTORD6mgfDOBqMkKw6pE5YTAuhK1ECndU?=
 =?us-ascii?Q?CqHkGizOPNM4RwLB+YhZkGVwhXq9ZrLdBVVIqOs+a8GkJIn7x5cp8muOjASR?=
 =?us-ascii?Q?B+pC/JAZ+c899XUMTAnrpT0kXZM9iPILCReICXaGvhM3D9NQhKYU5bOrwxb8?=
 =?us-ascii?Q?XArK9YUbMeU0AO86XtF6a7EM2jXxpeEcvzwl1gxzX9t7MEkYo+kXy8t3J/Eu?=
 =?us-ascii?Q?fVC9WCp93qLbV24T3UAFzoKOafwjCfmZU996zqepnvG5o0DgzueQFKz4BMRg?=
 =?us-ascii?Q?Bdj4zbg3vV/Bgvk5MmGgygRnfTgcpRlJdfGVHbQb8Kt73ToqH64c38yKCjGM?=
 =?us-ascii?Q?ZYTVLgviUn0hgeUJyjIPDWLo0C0WZPv01q+cWM23VpOaQkhvHtWXjWXxX2t1?=
 =?us-ascii?Q?tHUFqdQT09Db3pVG8+ngGegqOarwJVPZNMW0GvEiwOZhTWwpanOvgJCiiKkt?=
 =?us-ascii?Q?WONMa/npbzBV3V6B8pPRw51caOdxrQyzImFctKCqaSdEjQP2fCxN0Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0U4ux+qPDIhsG7r/mzxqabPEAgvvMiby+HeNKmF5p8mXxNLXyMZqjtQuF1sc?=
 =?us-ascii?Q?xQX1IfydxoLiNAO+XwZsaOSlkLLnhQem3LKowAabbGI2gxP1+4NzvhtBoCL7?=
 =?us-ascii?Q?O//mYnEMaYdl+653m+DgpN0DEZPABe+aIYq3nLDiRIQo2jdQpo6ZTAj24Jeg?=
 =?us-ascii?Q?ivvFSi1ts6zYuZovzVoiMmEEUyIEhH+u1s5TMfc1SqHjZsurvqOdjlqHwTta?=
 =?us-ascii?Q?vx9MRP4r/MQppxizkor3seb27SCvmPKJU4lmUs/XbG0nMXkHeEo+xg2HJZHF?=
 =?us-ascii?Q?39iWRyh8vgEtvHbtZ4Q99nL25nmPkKbxtlPl1Si58MBrL+zmICFdGAN9C1u/?=
 =?us-ascii?Q?L4PjkHG8lwQTqgAbiAJ0+ZD6XAV4MVizWskqszat6ahi4sEAqyK9fHh/MJ2E?=
 =?us-ascii?Q?HDvCbtf9XzrwUBL8IH1jM8iMG+gNZJV6STCYiyOca8d6XtsFGSzmbQopb78S?=
 =?us-ascii?Q?z57hMUd/6BcN5CrJJVDoMAPRioI42xglGgu7mrFk0QdUFC01uhDU6Dwl55aR?=
 =?us-ascii?Q?aFfXzke0bqH2Sk3vfeTcWykNEL6VdxMYRYhwIWLlkTgeR8Y1PCov5tdl5XFX?=
 =?us-ascii?Q?LLAF6KU5xF9qLgcvaggE4JTjeI4MftcJ9L+FRgnIpk1157sB0tyR3l0RMsgh?=
 =?us-ascii?Q?nKENfZuJ2rD0ARZ3uQaEeQ0dcy+Dnq3LSNitB19hJ/WdmUc+SG5rhUTjUCSP?=
 =?us-ascii?Q?sG2ZpRJStcrTDoycaDdN2cBWs30yRB0CFqQnj76h4kqKHugoGVnFL3BleLVu?=
 =?us-ascii?Q?70HrOAV5JhS6QDT2aQiE4s8dr5zIttEJCIgZEN/Svt49BmKSwHxSHcDwMLRe?=
 =?us-ascii?Q?JieEc2COyUg1/hCkqYNFAo8SMl0PXHmweAfWyfPa5wn7QfK2AO+4l5depGND?=
 =?us-ascii?Q?Le4LOWJFLtePTv+Mxm0HX+eH4gnWcQ47i5+CnysoKQWvHOWKe1xWfjmuPwTn?=
 =?us-ascii?Q?IvhEWzHBS7kE4Qw+mx41zR77LGy2LHFoTj720vAw7WD4I0s+ToSK+PJyhQP8?=
 =?us-ascii?Q?SlErUZh0AwMaJBZaBEL4AIE3s2CAJrp2KGJ40m5WdgkZuN+vZHX+EMHWhiyC?=
 =?us-ascii?Q?0ytSeKq+BJ0eQNwQrjHKSmnrOIKg9MtbakrvUcz+Ol7AVGniPH1NejsLddzD?=
 =?us-ascii?Q?g3POgkn49/I6k/kbG1dJG6rFRRq48N8opu1QLlgdo2ppY+JQM01XieExlMLY?=
 =?us-ascii?Q?+OikBpZUraYSWSP8UmMzR5gCNxb9MCNN40penD54GFXX/sRN2ChmIjirAiUS?=
 =?us-ascii?Q?H7WuBh8Z4lUbNcaTx109vJZbzfwxkPo7HCRunTqaHl/BZ8A6U+wFD7/hPTIT?=
 =?us-ascii?Q?4bIX5Xk3p74NQBxgDfsljBFlHiKz3fk71GO8zVVcXPeqfKnal0PwnpoJqjvg?=
 =?us-ascii?Q?4vw5UIgNLSM3XRqw2twBI8NnN+Q+sgVcQvPWgjhIJGGvdXVY1PDGJx1TjuaQ?=
 =?us-ascii?Q?ZgwD53Uc+Clp6/2nktrv+8q4Jp/osnXHTcefffWnPOSGN7cHaUBMSivo2QZW?=
 =?us-ascii?Q?By9LbvDE/CB8JpCLjpI6FoF+nynfNPpG9m+ZRf3WomPgAtmalYnTn4wqzbHz?=
 =?us-ascii?Q?S2clr/rE/EN+bTjCt9/1dJ5JWAKeZ7yjitF9dIgU?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d579c4-6e2a-44ec-ae66-08dd7e15a0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 01:09:11.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwks+acepYJ2o+6Er8WcGXcwnJJA39pracKA8dSqyyg6FliP9i9QbXhZ1iTSVzYlZ851LR6mc8UKw+ZrepbMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1438

> From: Naman Jain <namjain@linux.microsoft.com>
> Sent: Tuesday, April 15, 2025 9:45 AM
> Subject: [PATCH v5 1/2] uio_hv_generic: Fix sysfs creation path for ring =
buffer
>=20
> On regular bootup, devices get registered to VMBus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed

Sorry, I'd like to nitpick :-) I guess the maintainer(s) can fix these for =
you
so v6 might not be necessary, if there is no comment from others.

s/uio_hv_generic probe/hv_uio_probe()/
s/device/the device/

> and brought back, the channel rescinds and device again gets
s/rescinds and device/gets rescinded and the device/

> registered to VMBus. However this time, the uio_hv_generic driver is
> already registered to probe for that device and in this case sysfs
> creation is tried before the device's kobject gets initialized
> completely.
>=20
> Fix this by moving the core logic of sysfs creation for ring buffer,
s/for/of/

> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
s/rest/the rest/

> attributes for the channels are defined. While doing that, make use
> of attribute groups and macros, instead of creating sysfs directly,
> to ensure better error handling and code flow.
>=20
> Problem path:
s/Problem/Problematic/

> vmbus_process_offer (new offer comes for the VMBus device)
s/new/A new/

>   vmbus_add_channel_work
>     vmbus_device_register
>       |-> device_register
>       |     |...
>       |     |-> hv_uio_probe
>       |           |...
>       |           |-> sysfs_create_bin_file (leads to a warning as
>       |                 primary channel's kobject, which is used to
s/primary/the primary/

>       |                 create sysfs is not yet initialized)
s/sysfs/the sysfs file, /

>       |-> kset_create_and_add
>       |-> vmbus_add_channel_kobj (initialization of primary channel's
s/primary/the primary/

>                                   kobject happens later)
>=20

Reviewed-by: Dexuan Cui <decui@microsoft.com>

