Return-Path: <linux-hyperv+bounces-5405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07BAAE000
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0201D3AD096
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D190126C03;
	Wed,  7 May 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BnWWWMso"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840E78F5E;
	Wed,  7 May 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622946; cv=fail; b=nmKCwnMtF1Sl//CieONR69KhSJJeIbHyTo5yFvif681SHfVunTc8wEoK4lbQpTKtWnOXMof3s40hXh8VqeLsAyA5TYmpzAY58s1VW6QjOVEhHnJp0mRXoVio40GYux3ckkOS6I0kSzcnimvMf2EwlyMP3Vw32LW7sW90IWy74zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622946; c=relaxed/simple;
	bh=XtPjOiM3m5dfVqbgqK+uV7/HmJ2wb0il+BmCcvr970Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2akJzxNmKfVwXpVwWM0iAWod2w1CsleLQvYJPuk0oobnFDHbqU5eBz3caEKhDL0fApO8CxASDuAaWIxWXk3tnus6Xf11XpfMnfPPRRCc2/Gf1u7bb3dc67J9Q/aHaBBLeRHBnB5Iid+dem+mIgJaxHx3WUVCa+ik7O3vW+pr0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BnWWWMso; arc=fail smtp.client-ip=40.107.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeywEZg5wAwgf+owZwzs2YfX26vbhvW6VSJKqbGhFibdpydFQ4Xz5K5LS06ONdzYMk3XNt+kmzd8vI2+/y8b05N/MpS98DnF1xLFgOKe4d8LDd6m7Tx/8MCdl++UhGwnNKctzUGorHiBF1NR7BYfE9YN36hdYm+UvtXkCb1wkc96gZXEh3L/TRXJbbQatMC8Wh2qjVzfJfpOxz4uAzJUKi34m9teJjkZ2ICZEpq1Z4JovlnjtZl9qNCqQSB5XAai4cNoWWqkO0XSpiZiftN+aJ81WMlLubcJQxDtMqDSuFfzdGfZaOZfwzewBLUlxOxJFi3DKWHV0SsJ2gOcOBxZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXpipXT+GAmlop4VL6xZ2OEQc8k6zj1EtjlnLMopqfc=;
 b=BlkpVefmVrzZscK9tOyrGnGiXcoPrvDdD4cTV/qh887CmqVyX4s8SJe9DyexCMmSoK1ZeziFhKRNOkHJ+j0G8oeQb/CWKzxIJmpDyxLPYvhkj10C5c7XCRa+uz4m/HBf9CzMA3TYWp7RJFCLSHK46jdJt83zWhAecK70hjOQiD1o2lX1AMbCMboLJThd9huJkBsqhNhrP2G1yyVAMkRtYpzCIx0LVDTXj+i3ZwwBFK4nKhv3g61EDtWXm2WCKVQ1FK9lD4LeCWv6kKUWQ13qH8vOu3vKzK6Fc+syLpwb2lh0qIJffakhs8PqbRUpG2eUuJKrxthj8K//le12X7NzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXpipXT+GAmlop4VL6xZ2OEQc8k6zj1EtjlnLMopqfc=;
 b=BnWWWMsorJVA0z6+NFqLlZyCzpVvRBjGCgHRxxXE7o+3vWUfKLQCTm/wCBy1Vna2gpgfKJuzqOcEUF6kSseU/ftUzqsABIIoXYStY7knd2qc0OTTSYi0grKq9IrTBlg6u83n6z0dV4DX3gRAWKYA6ZSMG72zNGQoYDCq7WBZizI=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SI2P153MB0639.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.6; Wed, 7 May
 2025 13:02:19 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Wed, 7 May 2025
 13:02:18 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPWwq1NkNsYtEq9b/XTYQeJpbPHBnSQ
Date: Wed, 7 May 2025 13:02:17 +0000
Message-ID:
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
In-Reply-To: <20250506084937.624680-1-namjain@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=847d2a03-ddfb-4f04-b17c-39c336cbfc70;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-07T11:17:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SI2P153MB0639:EE_
x-ms-office365-filtering-correlation-id: b07bdd2e-718b-492d-11bd-08dd8d676527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lEIcdl+jusu3Rq04xB/1exI1oYZBFR3G5FAlkMlS3g70xiKTnlOryIdCi35q?=
 =?us-ascii?Q?rCjR2K415aRAiveyAn7qaBBpmVd8vpq8DBMXjOOiasXo+i+nce8FNMvkbfiQ?=
 =?us-ascii?Q?NA2RHoBwtiuNWY5M8t9QxrrSVDGYohXfvt/VcJr3D9tzByS6EXuKE5Lh1tLZ?=
 =?us-ascii?Q?4snPEkbWEFOIwnoju+gA/fOM00T+aLFr5NovFDF3TenomWPJT18J57hHaAvW?=
 =?us-ascii?Q?H6WsNJ4zruQ9A2/ZFJt2wk3R5ZmvOZjrZgIWAx2eeNRdxOCrRGM+4a3+vpac?=
 =?us-ascii?Q?OxNi+OI3SGB51PqF+b4aVuh1JP+IJRoJHCebV+nIuE1OdqzS6c6zwNz0RYOJ?=
 =?us-ascii?Q?ouOMdxA9bVuwLqSxgbtuGm0peyO55I9tjaRti7TiBZZyBDyFXbggh+tgLEm1?=
 =?us-ascii?Q?5FDGXeAU6zBl49eIjp56SlavvrKpdFkauQVlt7s8DC+VyqPQ1VMf7qo7yVim?=
 =?us-ascii?Q?8Nk2lAmoj1JBlBM17hkYvmjIxJ1jOZKDTbqRoegDutT1WUC9SjQCNrstICy3?=
 =?us-ascii?Q?hSR+AIRCVOW5JIUNYwn7T3w3pviZ5e+FyDR4A04o+AoFHzIlGiWHPRfNdIsb?=
 =?us-ascii?Q?kaWsr427G9U4cWcbllwR4WgEubts9TigpxU8qFafhuZSrIsc7c6Ei95Imurs?=
 =?us-ascii?Q?OMYWyoctqg+mZbXKsAeUR4jn7Gd71rVPD4gTWH81VSNP3O7s3eL2rRiZ2ioU?=
 =?us-ascii?Q?ipKxPixagtSq4uDB9qDCPcwBhFuYZFN0Ey/p11yUDOQgw9AeqVxFwmhayskV?=
 =?us-ascii?Q?4MKCbbfWwt/cFZNePdnMgrP+y//OzcQnd+OjxyPADik8dK/S2heEeHfBjAOR?=
 =?us-ascii?Q?J6NvnIM0TS+czIP4TYcbmKRnIBmeQODJ9ksez1Fxkcl0d77PukPLmzzz1QEK?=
 =?us-ascii?Q?3iL29ilXN0jU70ysNPtXAJJK2CiVDrO1S8L3sKg8F82+a63+6H2WIAaWcdG2?=
 =?us-ascii?Q?BdiPOouRlgF2B3h5mbd0ruH2euKfjzCjnqB0AOQ2xW2usIB2x81fDuycaKRu?=
 =?us-ascii?Q?HO/XDqAO6y6J/XX8Ne2rgh6898+RkWshXoAJ6zjualGTr6FmngGh3FSvdiHn?=
 =?us-ascii?Q?eUdMRY5IK8eJPPNHARo6csV9n4JXURFx924sMJaclfmjejDJMZj6H2Dod5XO?=
 =?us-ascii?Q?RMd+Pd2BJyMGhe+nCBTd5yViBMIEVbzsxou7x9U3UVvPCj+LmUYwTiSPJjuN?=
 =?us-ascii?Q?Mol7jpwYN7mpNzeIWgLpGakjZ/ihJQ4G197q1lcuADTuMKwnAmagEugaA9fI?=
 =?us-ascii?Q?/AGaePiMETxgXnwBDBbaRNwJO/LxyuXX/mfnSDak12CNBkSEnjEQYlq6+UeR?=
 =?us-ascii?Q?O1k4ccUVxJiah0DA2l4NEJJaAw9pW10iOxj1j4p1NTlOGdlXz15tIAE9ZVQS?=
 =?us-ascii?Q?9Pj71p5FDEvG0jOr5nzOzQHncRVf2ssiBWdczFW7VdeGD6lQu+8gS7tlnBcO?=
 =?us-ascii?Q?DrI8PMlDZS52lkiVV31IZSdfTlYP92YmJrXb7n0x4GEpZUWobjNYC0MAJKSD?=
 =?us-ascii?Q?STiCA+KyKJHzamY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tu/AtjkPWZtqTFP+9DofKxxcIvDp85nsiEvJ5ZKVPQXJjTeIefu4WnNznJs8?=
 =?us-ascii?Q?v/ApEuv0MXLoJchRm0J0EsWOE+lXojPKfTvrOg+Mzbrj9kaDLJwh4hK8vWTX?=
 =?us-ascii?Q?P9wUKEGlWoH2Y59wFpIaeB/f75NPhSF8V0ahRlTV6pW/igoT9hGNB9QE2A0j?=
 =?us-ascii?Q?sqXx2T2W1UMu4mm44OHouWK+c9i9cRKkAnHr//U5uNdQ/++u0pCc8fa62+eR?=
 =?us-ascii?Q?Cgx+hp8CABbUCMyDKZkN24N8JWFbEc7XatDyOVKLcNpCRpzLP1GlG6Dg34IH?=
 =?us-ascii?Q?Rh2j56jonV+cVnKkYQCWF7NZdh/SJTT+yyz/qFyJXgWRUQqA7S6qxS7pCeiM?=
 =?us-ascii?Q?zzvSO62HelaGFUeezpX3E6Hgd7pY8Or6zDsZ7Kk3yHemNYOERidCRUfZ5YcV?=
 =?us-ascii?Q?zX8xGbKbOnNIAgtfvQTLyTqB1bzV2o9hj/OYtryPANjbIgjklSzYeCFIz8ju?=
 =?us-ascii?Q?RvEbgL1LdiisFAL+SEJWQN45155rSb8kP82wCgBVQaD2METznUOQqwDABGJe?=
 =?us-ascii?Q?gzxvbHKOmTolZCXH0jkIzrJpYsWuFZ2/DsbHwTlXQ3314XnIwOCXgyuAFNUL?=
 =?us-ascii?Q?mxFikZThJbMrRRzwunCCKOWj2moRo/lqR45Lcb/inSjRiV7m35iqEYBaAk/z?=
 =?us-ascii?Q?tRBPRtrDjsCTzYV+OF/OYzB1JdCznQjySqU4uGMCS2Ai/psX13kZgdUETCYw?=
 =?us-ascii?Q?QVa/qsohnW7tU+ftg3bRX9GDQt41U3bcnzd1IX5xW75IpSIOJICWO36SZ2+z?=
 =?us-ascii?Q?qQZZSLet4IVaksIbskEbWqIJ0Ia62ktlgza/1u4QgZEegRsmV8ECof6DG0Gx?=
 =?us-ascii?Q?zaxGb9mY5wshlY0ptDKY1feyO1wNsqrnoO47WJ9mRJIWFAXV2OWHL9TC+h00?=
 =?us-ascii?Q?f5tINlX/luDqjZHffz29+tiUyi4AgmE+1zr/+aejWTqpVPXglu3hsiJKs6Io?=
 =?us-ascii?Q?cJdD9vXdFYwPUtIxTQ/eVGGFnQvTO1CtJAz9Su+cvOmh3ox3zH1dl9pEBqjf?=
 =?us-ascii?Q?gB+VusPiG8L7SrsA08HyRVNnZPmnWUxeWfp8yrTD3CY6KUFU+UVZydpvMLA4?=
 =?us-ascii?Q?9UdtrWuWhVvGdCZ1pzyhaipP9IB9jYbihRr+LX62aMRKDUyh8fwAh86P05HS?=
 =?us-ascii?Q?BuOliNGTuGpGsQtqVli+hyVlEklpX5WeuLo7pu6EDUgooMKAKG0MMKXZzP9s?=
 =?us-ascii?Q?SfYfUvkGnkGrEs7FvUk3QAfUOPxLcveoPmSUyu2Zeu2gA42NNprcgLa5V5fI?=
 =?us-ascii?Q?luFTABNc2QUY9Y3cYjUOsGf9IGJfk8UUSynponVkbSWqNkzS0m41QBuMJUzM?=
 =?us-ascii?Q?2iXKYjgjyoiXp/M7hdAcR9FOAhtOFfZAzu5IhGPDqUThm49B7jrTsazZpYRE?=
 =?us-ascii?Q?t55n9VPbDU7SrO0ts1UDFQN1/WGG8+F5k/SZPX2Bqa2Ub/s2C+WjCI6Dj7Vc?=
 =?us-ascii?Q?8JeJhhk+pE8o6dvVctKh3IAkF5nVoSuNhQT90GbaYPS/aGwpyTCKKlhyjXzS?=
 =?us-ascii?Q?CZ4GiJVByNRIlOXMHQVzwppCIKZbdC+UzjaZENfxlgi1cMXGyGYUlI6wat1+?=
 =?us-ascii?Q?8u1Bioa9onMcIbaQ34ZJT5udnIw/Msz7Ur3NjllU?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b07bdd2e-718b-492d-11bd-08dd8d676527
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 13:02:17.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ys17oqvW+nBI4FEkcsSliEFUgVK7A4ajXqvJIKgK8DipFSKykeUFgZ/rMdF9JOcGXH2Zxzxb4KQLlZh+VNWMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0639


> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>=20
> OpenVMM :
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fopenv
> mm.dev%2Fguide%2F&data=3D05%7C02%7Cssengar%40microsoft.com%7Ce3b
> 0a61c2c72423aa33408dd8c7af2e9%7C72f988bf86f141af91ab2d7cd011db47%
> 7C1%7C0%7C638821181946438191%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DuYUgaqKTazf0BL8ukdeUEor
> d9hN8NidMLwE19NdprlE%3D&reserved=3D0
>=20
> ---
>  drivers/hv/Kconfig          |   20 +
>  drivers/hv/Makefile         |    3 +
>  drivers/hv/hv.c             |    2 +
>  drivers/hv/hyperv_vmbus.h   |    1 +
>  drivers/hv/mshv_vtl.h       |   52 ++
>  drivers/hv/mshv_vtl_main.c  | 1749
> +++++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c      |    3 +-
>  include/hyperv/hvgdk_mini.h |   81 ++
>  include/hyperv/hvhdk.h      |    1 +
>  include/uapi/linux/mshv.h   |   83 ++
>  10 files changed, 1994 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 6c1416167bd2..57dcfcb69b88 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -72,4 +72,24 @@ config MSHV_ROOT
>=20
>  	  If unsure, say N.
>=20
> +config MSHV_VTL
> +	bool "Microsoft Hyper-V VTL driver"
> +	depends on HYPERV && X86_64
> +	depends on TRANSPARENT_HUGEPAGE
> +	depends on OF
> +	# MTRRs are not per-VTL and are controlled by VTL0, so don't look at
> or mutate them.
> +	depends on !MTRR
> +	select CPUMASK_OFFSTACK
> +	select HYPERV_VTL_MODE
> +	default n
> +	help
> +	  Select this option to enable Hyper-V VTL driver support.
> +	  This driver provides interfaces for Virtual Machine Manager (VMM)
> running in VTL2
> +	  userspace to create VTLs and partitions, setup and manage VTL0
> memory and
> +	  allow userspace to make direct hypercalls. This also allows to map
> VTL0's address
> +	  space to a usermode process in VTL2 and supports getting new
> VMBus messages and channel
> +	  events in VTL2.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 976189c725dc..5e785dae08cc 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
>  obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
> +obj-$(CONFIG_MSHV_VTL)          +=3D mshv_vtl.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> @@ -18,3 +19,5 @@ mshv_root-y :=3D mshv_root_main.o mshv_synic.o
> mshv_eventfd.o mshv_irq.o \
>  # Code that must be built-in
>  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
>  obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o mshv_common.o
> +
> +mshv_vtl-y :=3D mshv_vtl_main.o mshv_common.o
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..11e8096fe840 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -25,6 +25,7 @@
>=20
>  /* The one and only */
>  struct hv_context hv_context;
> +EXPORT_SYMBOL_GPL(hv_context);
>=20
>  /*
>   * hv_init - Main initialization routine.
> @@ -93,6 +94,7 @@ int hv_post_message(union hv_connection_id
> connection_id,
>=20
>  	return hv_result(status);
>  }
> +EXPORT_SYMBOL_GPL(hv_post_message);

All the exports should be in separate patch.

>=20
>  int hv_synic_alloc(void)
>  {
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 0b450e53161e..b61f01fc1960 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -32,6 +32,7 @@
>   */
>  #define HV_UTIL_NEGO_TIMEOUT 55
>=20
> +void vmbus_isr(void);
>=20
>  /* Definitions for the monitored notification facility */
>  union hv_monitor_trigger_group {
> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
> new file mode 100644
> index 000000000000..f350e4650d7b
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _MSHV_VTL_H
> +#define _MSHV_VTL_H
> +
> +#include <linux/mshv.h>
> +#include <linux/types.h>
> +#include <asm/fpu/types.h>
> +
> +struct mshv_vtl_cpu_context {
> +	union {
> +		struct {
> +			u64 rax;
> +			u64 rcx;
> +			u64 rdx;
> +			u64 rbx;
> +			u64 cr2;
> +			u64 rbp;
> +			u64 rsi;
> +			u64 rdi;
> +			u64 r8;
> +			u64 r9;
> +			u64 r10;
> +			u64 r11;
> +			u64 r12;
> +			u64 r13;
> +			u64 r14;
> +			u64 r15;
> +		};
> +		u64 gp_regs[16];
> +	};
> +
> +	struct fxregs_state fx_state;
> +};
> +
> +struct mshv_vtl_run {
> +	u32 cancel;
> +	u32 vtl_ret_action_size;
> +	u32 pad[2];
> +	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
> +	union {
> +		struct mshv_vtl_cpu_context cpu_context;
> +
> +		/*
> +		 * Reserving room for the cpu context to grow and be
> +		 * able to maintain compat with user mode.
> +		 */
> +		char reserved[1024];
> +	};
> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
> +};
> +
> +#endif /* _MSHV_VTL_H */
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> new file mode 100644
> index 000000000000..95db29472fc8
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1749 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Roman Kisel <romank@linux.microsoft.com>
> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
> + *   Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/pfn_t.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/count_zeros.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +#include <asm/debugreg.h>
> +#include <asm/mshyperv.h>
> +#include <trace/events/ipi.h>
> +#include <uapi/asm/mtrr.h>
> +#include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
> +
> +#include "../../kernel/fpu/legacy.h"
> +#include "mshv.h"
> +
> +#include "mshv_vtl.h"
> +#include "hyperv_vmbus.h"
> +

<snip>


> +
> +static const struct file_operations mshv_vtl_fops;
> +
> +static long
> +mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
> +{
> +	struct mshv_vtl *vtl;
> +	struct file *file;
> +	int fd;
> +
> +	vtl =3D kzalloc(sizeof(*vtl), GFP_KERNEL);
> +	if (!vtl)
> +		return -ENOMEM;
> +
> +	fd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +	file =3D anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
> +				  vtl, O_RDWR);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +	refcount_set(&vtl->ref_count, 1);

Do we have any use of ref_count ?=20

> +	vtl->module_dev =3D module_dev;
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +}

<snip>

> +static long
> +mshv_vtl_ioctl_get_set_regs(void __user *user_args, bool set)

I didn't find much use of this function. I don't see any problem with separ=
ate get and set functions.
But I will let you decide on this.

> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *registers;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count =3D=3D 0 || args.count > MSHV_VP_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	registers =3D kmalloc_array(args.count,
> +				  sizeof(*registers),
> +				  GFP_KERNEL);
> +	if (!registers)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
> +			   sizeof(*registers) * args.count)) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	if (set) {
> +		ret =3D mshv_vtl_set_reg(registers);
> +		if (!ret)
> +			goto free_return; /* No need of hypercall */
> +		ret =3D vtl_set_vp_registers(args.count, registers);
> +
> +	} else {
> +		ret =3D mshv_vtl_get_reg(registers);
> +		if (!ret)
> +			goto copy_args; /* No need of hypercall */
> +		ret =3D vtl_get_vp_registers(args.count, registers);
> +		if (ret)
> +			goto free_return;
> +
> +copy_args:
> +		if (copy_to_user((void __user *)args.regs_ptr, registers,
> +				 sizeof(*registers) * args.count))
> +			ret =3D -EFAULT;
> +	}
> +
> +free_return:
> +	kfree(registers);
> +	return ret;
> +}
> +

<snip>

> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
> +				struct mshv_vtl_hvcall __user *hvcall_user)
> +{
> +	struct mshv_vtl_hvcall hvcall;
> +	unsigned long flags;
> +	void *in, *out;
> +
> +	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct
> mshv_vtl_hvcall)))
> +		return -EFAULT;
> +	if (hvcall.input_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +	if (hvcall.output_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * By default, all hypercalls are not allowed.
> +	 * The user mode code has to set up the allow bitmap once.
> +	 */
> +
> +	if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall with control data %#llx isn't allowed\n",
> +			hvcall.control);
> +		return -EPERM;
> +	}
> +
> +	local_irq_save(flags);
> +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	out =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
> hvcall.input_size)) {

Here is an issue related to usage of user copy functions when interrupt are=
 disabled.
It was reported by Michael K here:
https://github.com/microsoft/OHCL-Linux-Kernel/issues/33

- Saurabh

