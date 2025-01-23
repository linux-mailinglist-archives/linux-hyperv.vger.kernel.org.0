Return-Path: <linux-hyperv+bounces-3757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB443A19E05
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE33ACD6B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594E194A74;
	Thu, 23 Jan 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PzKxfABF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020138.outbound.protection.outlook.com [52.101.193.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBE13212A;
	Thu, 23 Jan 2025 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737610846; cv=fail; b=oI9km6RsJHHUmPdFFB9VdADx3+wJ8tJ4GAnn8zYXKJlx4fLE2Lt8NFFONQu34sv1AL/Tl/IMUQQ8q6e44rukBSMGX7sTMT0rFc8HEFN4MqVZUPd8WZoQAzfX4O1DfmS94lgsMGOC8Uui7HI7KHM8qV06t/P1CpZc0vbp+GSvCd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737610846; c=relaxed/simple;
	bh=hNWPx12wGcJJ/LOwtIKQDJSzHeWA4Lz1UGPe1IRbx9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnPXXRLNpu0HC2IqUTd+sDgPNkZiqsFkTC5iFp2No/pNkBC4qtprb/9Ue5fF0VqB3HHfc7IWL08eIZBTJDgk33hBgRPupjEDkGBzRVO40cF6t+eaGpq5vLZ/ngu3jW3jxn2SFTA+EgOG3/TyOb+mPM4rL/gqVNy1DQ39MFfvM30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PzKxfABF; arc=fail smtp.client-ip=52.101.193.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xynvc0IDopX0w2sbxg0IVU4B8Rzxli6JYT1JYO6iwZ18ZVXRVWXpcJCX/O3BN4S11b8z3QV7mYZir5sxOc6/xdEtmoEYmg1qr6bKDy1gvI/sfvnguPhusIIwChFWhN4We0spCHjRx/mB5j7i2MJYSBHWnwWD9+PwyXuxZwrE12KGdktI3uH7figB4TMZXJ9sFQxuRwjlfHfAFEf9Dll8nQ2Cuz/K9shWGz4tgeSxP4hEftpDjbhQG677l8ZdgjKRy9wTGbXGmg/bSRnzqr80HlTtX3ZhhPaqGr7eb6nD4Jrq2X+x+zNlzJGNA21yTwEBg11SNkvad8wwu5IQgeaKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlzhFcuAEvT6iCX9hVF7hVo5LD4DIrsLH18AKPbJhQQ=;
 b=hGWP/8yN4nM2T5P+BE8jICaqaD20URfIBG+7vcgnN3d05kmEpyVx9niknLcaGs6HJsAb5sY9I8glpPYNQqoI2zMkmHRMi9LLCxhZ6lEbstsXRpBU5eV+sh6PeUmmUmG3dzUf9FEhAWCXHaz25nEqMOwZiKJdorXwIjpVSCNV0gqycJ5CWVqFGOgqD5kso7ZEX8HNwzWxMSSmtDM2E1Z9DnGjnxvZWMpzPR9cZxGRJ/KSZwYA1utye1BZ9fO42HXwtNx8B9EXJUQXUGeJXdXpxpUtR9Pn7yi1OyME3/9UJYWKpH/+tWczW9iXVFfSBXK4XXqVa6IduCqdVLZiDTYfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlzhFcuAEvT6iCX9hVF7hVo5LD4DIrsLH18AKPbJhQQ=;
 b=PzKxfABFXgRVYN+1zhAftf1mf6FUSjSzCXNbEd0sRAREe5CfOS3zSuRMHoBvPmhZwRS88s1ibiximtuu2UYadw9IQvSdG64pA4BHMJpWM/SpF5VzwTuCOh0cHfwqPX+/JSuUVYOy0vXBLQEGAfVwuAYfGwOzi+Gxg6THS0oEjV8=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4263.namprd21.prod.outlook.com (2603:10b6:806:41b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.8; Thu, 23 Jan
 2025 05:40:41 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:40:41 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 05/13] RDMA/mana_ib: Create and destroy UD/GSI
 QP
Thread-Topic: [PATCH rdma-next 05/13] RDMA/mana_ib: Create and destroy UD/GSI
 QP
Thread-Index: AQHba2CVIzeyhr9rZk2+026sOPvlybMj29yA
Date: Thu, 23 Jan 2025 05:40:41 +0000
Message-ID:
 <SA6PR21MB42319AE47D2841A773F80941CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-6-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-6-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b7950bd9-0c54-4f4d-ba00-81ab84ed4690;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:40:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4263:EE_
x-ms-office365-filtering-correlation-id: 07a97465-87fb-48d6-c834-08dd3b707953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UBPOIwaFrWrltWJCuOMG7koIYZN8fZzJBhpTtLzo4RlrGdmNSoBxYWXaycAC?=
 =?us-ascii?Q?rNdL7rc2WDSv+zXjb2xbRrVU3LG85fu2QaB8xypPVscnZEtPomYMVxN6Cd4B?=
 =?us-ascii?Q?s3JS/RKGu0oG4q1STEe+qzhBC1uWhwK8bjVo6wxu5QK/rzUcCByBQZ2l/FNB?=
 =?us-ascii?Q?0SwOjx+xMoPcg0efd0UEnPTp41Ft29ny9ONA5hlrF8cyimpyLb/8Y8aI5l+X?=
 =?us-ascii?Q?/rmSRezGiI71w3bfAN3crlCRzGN5ry+AbfPHS+jzwwvloDUwbSc9XBead8ad?=
 =?us-ascii?Q?ztilI7AFCzRbDsV9d8jOE7vc0ZMlOyq4MT67WgQu87ntBtFBIlT1Y+bfTlML?=
 =?us-ascii?Q?ArRtDbHZtW+w8sH8OJrqBEA0jmeTU06g22RKmPHIQvhEUvY2RwAtzAkFUH3A?=
 =?us-ascii?Q?FRugNvc2TumqMHg3KEvfJ/WpmhhV94p3kmq4Qf5wAyP+qvzMh8QBD0gsmLbn?=
 =?us-ascii?Q?VmNysqn1J/FJwTQbRDuwYBmFLykYtWtkilIoeyKscKsAnZfwj1pvMtbylzTp?=
 =?us-ascii?Q?hri4F1gdRItAoK/s+f2/e07uauelvmcz0JFGzay0ADB1os7DOazDBiPYffV2?=
 =?us-ascii?Q?Qf6jktstK4OYC8sMM6P6U4Md89+hSCHnO2371BDep0JqZ8r/cSATE9at5Fql?=
 =?us-ascii?Q?R4lSelq++1s0fdMaVSyw6MlOCE5FEp6Bg0vXINSn5bg1gvs0PFVWL8sQH2+2?=
 =?us-ascii?Q?NpagMTLQVCO8jPTT1bNbWaA/R1DCUNiSZr6zOQqk/zQ0nw+vt/lYOwcPj9yh?=
 =?us-ascii?Q?DrGyyBNbCSwEuvXh+D5w51KcavE/7736c7mVAWQqzN2O/y2/wwjfb9Z5jTUw?=
 =?us-ascii?Q?y2bQP9nM3bR111Q4lfuZq+F11vD1nvLXtwMU1IcEaskcU1IwsXIRIQfLcbqY?=
 =?us-ascii?Q?UNwL8RU1eplAuqkAIyBpiLEvZfYZlrlFNgZ0duK0xLxYWViZGDf2dQVuzAgX?=
 =?us-ascii?Q?x3Vd4ltjPdrW+Zozu18nlD1bmcyJwrtnfLKzRa3gHZi4k2WGQ80dTTuacv50?=
 =?us-ascii?Q?fEA0f7DYM3Vu8ConfYqiH++inJj+F9ZTNt7A3kXyGW2qIOnjZhUnbxKsUIDM?=
 =?us-ascii?Q?suMSXRyOb4o4awzJl2+WEeAiG40aYM2jl2ZrINK+6mXgiRKMInGQ0gjnDUuv?=
 =?us-ascii?Q?/TBRfkG6ZIdKH82vtL5Fqz/jcHq36fjBeoFzfwpU19gDcM2j7tHC+tbtq+w3?=
 =?us-ascii?Q?bZ8iWOAmhY2uG6wtA17qSBx84V36T9y0FvwhzITsBTnBtljP0RH9Ajf/CQNu?=
 =?us-ascii?Q?e3jypllSZi9u5HHg5RfdN3OIzAr2rBF/u+1+c1WjC9NyG4St6FUUvR+i/+mh?=
 =?us-ascii?Q?MwyacBTdcQBisRPX6/mmSMoPGsjzs4obaEqpRZ13qtFvfj9LZk1zFr/BjbJw?=
 =?us-ascii?Q?l5ssPG15JR3V7qr9h2KmNg2PvuEdJD+lPzrN+oPAWTw0IuUdC0dbazYFyEQZ?=
 =?us-ascii?Q?vPhRdhJrCzoGLQtIzFkT6zBzp+YNzVieuehlP6wzazXXdyAwtNJh8A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U27Y+MOdx9+Z7KXxSRfA8GRPU0MclLrd76EU5EWkdZAPSu96ikNPvkmhqlR1?=
 =?us-ascii?Q?kcqKtDSGpYBQf3Mzx5Muk2z/I78NMXNDPFIWe60pqHO2uTI+tYlyQ9WaP1Pt?=
 =?us-ascii?Q?8eYmwgFyr6B05n5MjimwUr7j/u9ZFXzVuyXAyXT650o8fbu+g7vWvT2PKgpx?=
 =?us-ascii?Q?Twg+W4lqPuUqKqE1K/qFwfQ3VU5iMLf9zA8sM+cQep50MWlaXHNHsE7cxJQi?=
 =?us-ascii?Q?t6JfXW8T3ai113Vi3olXgrDQ/MV7WcW3AgKU+qBNNR6FPAJRNDxzW8f8NiFJ?=
 =?us-ascii?Q?R5M8eZXoVpW2G4jSL3qc6SeTnHNGCSWNmuQkHv3Ve+re8vFhb7A/XYEHwFg5?=
 =?us-ascii?Q?GE8v4WrhorLUCi8n8v9eAqGUGW3dtntX5gUSvFe70S6RhnCYjufIfjR5lymr?=
 =?us-ascii?Q?u3KrdbLbtWjOeLHnvvAIXa21z2P16tMnnvkW52K/0sCWHlLf5wrreRIhvAkl?=
 =?us-ascii?Q?686FwuRcHE+g6C5qHfr11MvrFycl5rrCdzQBEw4Xr2s77a7TXWyFc/RqGx0M?=
 =?us-ascii?Q?CyZrOB2N45JTjb0OeN4ZcfhazSGeiNYbXB/DMEryIxxNOfqEnp/VOLLStPi/?=
 =?us-ascii?Q?mDNnYBIbz5xolx8ryh0FCSLZsJQpqEdJvEaA6dVHvNIPTgzPGxX3SZ72sQHa?=
 =?us-ascii?Q?VZlM5XUy2pMnl3Un+nZ42b8d9YCdyvjUXHTK3cpeEzambH2dBJWKs36gvs0O?=
 =?us-ascii?Q?B0x9uiXPK3YNXYmIlutoeR9wXnTnYiqxbJkETdMyhB+aFUn+yK9sG53yzvCk?=
 =?us-ascii?Q?brXIB8pxWwsmKViBr4udkx+Ch4hn2lKSexXBk1iuPaBZTz0a4xSa1orRvLqj?=
 =?us-ascii?Q?9t0VKxnJx4vdBX8SEfCYSf/Bt3IJl+vwVSyzYOPp9xbg33Svk5KCBJi6twPe?=
 =?us-ascii?Q?lTL2vteu32noFhUqB5WmlYoZ3SbabsY04oqLBk4Y+vyZ3o0nU+PyXcDnc8R/?=
 =?us-ascii?Q?tHR6OQbHtwGbqoRbptSoq4rtjd166csz1htsDBbnSSx+p67uN0D+V7WeWTIW?=
 =?us-ascii?Q?DFANFgbW6ve8o5dB9nvuIuSNsihMkGObiSwIjcyYX0x5PMjwoLm/O0bGaePk?=
 =?us-ascii?Q?lGL3Md1YQRtBcxd5v7x+yaleHrNH4+HSem2gKo8K057jwfmr+/Zu3/ghCT0B?=
 =?us-ascii?Q?38cbo4DXIjQLxCdgFTmEZNYOOAE9oaqfV3VccsfxMxcVyFcvmVWsmoRrXolE?=
 =?us-ascii?Q?SF92VMxdOCJYDp352oRTkSD95FYYeIxHP6FbACpCMekbQHTqjH7kph+gL66J?=
 =?us-ascii?Q?SOggbPkUkNnj/lUXxeUAKQxdHpcG8i2dBtFo9Z7kTa1BnxPJ5wGVl2z/ZZ/l?=
 =?us-ascii?Q?ZYw/OgLi+lJpl6OpJnDQm7c/FSvOrPUXtB8kSgOwXMUaCuCfF+vnRl8SWGlF?=
 =?us-ascii?Q?VZwk/xXrYIb6ighuJPebo6+DYbEqSp2XCaB9n6/OukxedrGb9mfzBdqaNfwN?=
 =?us-ascii?Q?5SohkU6IuRipXPQXqOydWf9G+a8QzDB/tdf6UJf9M0BEchtnvkmJeY3kac39?=
 =?us-ascii?Q?8YrReudzTLEkSspLpOE9vj9Z4bb7pJg46wVPu7lTlEOxSJ6FW3Nf4J7/MIyO?=
 =?us-ascii?Q?vCCVVHCDzISlaLLq4fegf3ujew8e/tYqlFHSczbW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a97465-87fb-48d6-c834-08dd3b707953
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:40:41.4020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +doMPcG+Rf/AYLHYmFaAGIGN0fVNbhfqgrLO6h45FI+67RDfjKpX58IW938OzK51q7cOhU/Gkw9ZXA57HkuQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4263

> Subject: [PATCH rdma-next 05/13] RDMA/mana_ib: Create and destroy UD/GSI
> QP
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement HW requests to create and destroy UD/GSI QPs.
> An UD/GSI QP has send and receive queues.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c    | 58 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h | 49 +++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index f2f6bb3..b0c55cb 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -1013,3 +1013,61 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp)
>  	}
>  	return 0;
>  }
> +
> +int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp,
> +			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type) {
> +	struct mana_ib_cq *send_cq =3D container_of(qp->ibqp.send_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_cq *recv_cq =3D container_of(qp->ibqp.recv_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_pd *pd =3D container_of(qp->ibqp.pd, struct mana_ib_pd,
> ibpd);
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct mana_rnic_create_udqp_resp resp =3D {};
> +	struct mana_rnic_create_udqp_req req =3D {};
> +	int err, i;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UD_QP, sizeof(req),
> sizeof(resp));
> +	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.adapter =3D mdev->adapter_handle;
> +	req.pd_handle =3D pd->pd_handle;
> +	req.send_cq_handle =3D send_cq->cq_handle;
> +	req.recv_cq_handle =3D recv_cq->cq_handle;
> +	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; i++)
> +		req.dma_region[i] =3D qp->ud_qp.queues[i].gdma_region;
> +	req.doorbell_page =3D doorbell;
> +	req.max_send_wr =3D attr->cap.max_send_wr;
> +	req.max_recv_wr =3D attr->cap.max_recv_wr;
> +	req.max_send_sge =3D attr->cap.max_send_sge;
> +	req.max_recv_sge =3D attr->cap.max_recv_sge;
> +	req.qp_type =3D type;
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create ud qp err %d", err);
> +		return err;
> +	}
> +	qp->qp_handle =3D resp.qp_handle;
> +	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; i++) {
> +		qp->ud_qp.queues[i].id =3D resp.queue_ids[i];
> +		/* The GDMA regions are now owned by the RNIC QP handle */
> +		qp->ud_qp.queues[i].gdma_region =3D
> GDMA_INVALID_DMA_REGION;
> +	}
> +	return 0;
> +}
> +
> +int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp) {
> +	struct mana_rnic_destroy_udqp_resp resp =3D {0};
> +	struct mana_rnic_destroy_udqp_req req =3D {0};
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_UD_QP,
> sizeof(req), sizeof(resp));
> +	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.adapter =3D mdev->adapter_handle;
> +	req.qp_handle =3D qp->qp_handle;
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to destroy ud qp err %d", err);
> +		return err;
> +	}
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 79ebd95..5e470f1 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -115,6 +115,17 @@ struct mana_ib_rc_qp {
>  	struct mana_ib_queue queues[MANA_RC_QUEUE_TYPE_MAX];  };
>=20
> +enum mana_ud_queue_type {
> +	MANA_UD_SEND_QUEUE =3D 0,
> +	MANA_UD_RECV_QUEUE,
> +	MANA_UD_QUEUE_TYPE_MAX,
> +};
> +
> +struct mana_ib_ud_qp {
> +	struct mana_ib_queue queues[MANA_UD_QUEUE_TYPE_MAX];
> +	u32 sq_psn;
> +};
> +
>  struct mana_ib_qp {
>  	struct ib_qp ibqp;
>=20
> @@ -122,6 +133,7 @@ struct mana_ib_qp {
>  	union {
>  		struct mana_ib_queue raw_sq;
>  		struct mana_ib_rc_qp rc_qp;
> +		struct mana_ib_ud_qp ud_qp;
>  	};
>=20
>  	/* The port on the IB device, starting with 1 */ @@ -146,6 +158,8 @@
> enum mana_ib_command_code {
>  	MANA_IB_DESTROY_ADAPTER =3D 0x30003,
>  	MANA_IB_CONFIG_IP_ADDR	=3D 0x30004,
>  	MANA_IB_CONFIG_MAC_ADDR	=3D 0x30005,
> +	MANA_IB_CREATE_UD_QP	=3D 0x30006,
> +	MANA_IB_DESTROY_UD_QP	=3D 0x30007,
>  	MANA_IB_CREATE_CQ       =3D 0x30008,
>  	MANA_IB_DESTROY_CQ      =3D 0x30009,
>  	MANA_IB_CREATE_RC_QP    =3D 0x3000a,
> @@ -297,6 +311,37 @@ struct mana_rnic_destroy_rc_qp_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>=20
> +struct mana_rnic_create_udqp_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +	mana_handle_t pd_handle;
> +	mana_handle_t send_cq_handle;
> +	mana_handle_t recv_cq_handle;
> +	u64 dma_region[MANA_UD_QUEUE_TYPE_MAX];
> +	u32 qp_type;
> +	u32 doorbell_page;
> +	u32 max_send_wr;
> +	u32 max_recv_wr;
> +	u32 max_send_sge;
> +	u32 max_recv_sge;
> +}; /* HW Data */
> +
> +struct mana_rnic_create_udqp_resp {
> +	struct gdma_resp_hdr hdr;
> +	mana_handle_t qp_handle;
> +	u32 queue_ids[MANA_UD_QUEUE_TYPE_MAX];
> +}; /* HW Data*/
> +
> +struct mana_rnic_destroy_udqp_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +	mana_handle_t qp_handle;
> +}; /* HW Data */
> +
> +struct mana_rnic_destroy_udqp_resp {
> +	struct gdma_resp_hdr hdr;
> +}; /* HW Data */
> +
>  struct mana_ib_ah_attr {
>  	u8 src_addr[16];
>  	u8 dest_addr[16];
> @@ -483,4 +528,8 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq);  int mana_ib_gd_create_rc_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp,
>  			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
> int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp);
> +
> +int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp,
> +			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type); int
> +mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> +*qp);
>  #endif
> --
> 2.43.0


