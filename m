Return-Path: <linux-hyperv+bounces-7211-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEEBD9F1F
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1708503469
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6247314D28;
	Tue, 14 Oct 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JgTiJ7yl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021114.outbound.protection.outlook.com [52.101.62.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA57314B8F;
	Tue, 14 Oct 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451089; cv=fail; b=kh55EMnHdY2vzd152dNzRKdha04gvO0siqAA5/zreQHPPzV7mmkhAWAx3d/0m9pQFlNxSgj6bIVsiU0byharxleOB/hG377HlfnCEiegHVIM3vYzJKRUu5gXozYTj+VssAOcQ2ny6T+e4gnsIExJ38UaGhTVzVsttyYcpqtRWhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451089; c=relaxed/simple;
	bh=eQ39fwvvLTjgmiclGQ7dke6aBejGNso7NUaEaHf0bi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cCye+SMdvnljpAR3Fg0f3xC90cZ0YMPv4dlpHKdjUVzAoAGXvMGMPIfcdLQwAl68jL7OJ2S93nWqT1NDB3E8tvh3KxW/ugcqnGRYwx5A93N2tENm/xIRmvg5Ms3fPoV7D4gKO10BAqfqO/i7/ehsbPMM4QT9T1Qk7RLZdc20CwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JgTiJ7yl; arc=fail smtp.client-ip=52.101.62.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1fr1OE7hXzIuwj3fYYtWlhV0W5hqnHvAWFbYDvQ4e/JeP9+8fYNB2NHMvPwjug4d1ICRznqznhDegw6FGkCh0iWtdyVpe6IMEpo3U57CD1KG1zYNj3MWnqC0FpHmG44K9SqJI8p8i2fs12+63kvkF/ugKfJikNlGh8q3lxz5I9H535HnSttay3Ds6xJ49SOeqqfkyow694yh5yJtzWnq9XOSTRYahC1UnKD9d13rcW+IVmbDnJ04RX5GtRx/q7aS5Yjx9fSILTY7v1Y1kodx4YC/4B73RlqIT5OSn7TE02UlepWm6XY8RslOE4MWGMoL0KFq2p8ztXOj45WxpLayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkHJh8c6Q1yMVnr/bmhbsgKkA8gowdlPpT1699pkHBk=;
 b=W23EZnqfGrzXqHy3pmUQAIzcS1QyxXpuWnTdp9aMreszhtqJtmCLFqftfTFEDZ7LUjeNLDAAN2JoCPd5tAuQbjz8vogghyHTjwnkdQVMBdIPB6WbDmhEzrjqIf7fQEZSOIk4DpgfDQGNHsv0SAfYsK6zgqAAze1nfjsy4UqH6pWdcdSZjX7XZGrCTTI3jwHuoxPDK+wbuyJhfDP1L27WOmkqCaQvUfp4wk6TLVXTBO5DifYgQTfU7UhBKDyX3r7LVLRz6P2FlFuj4IF3yuU3eQhYc2P3PCR4Pxx+rSNrMpHMplpUZCSFVqGTDTSJIVE8AC1aPsIbbH5HPaZRoxTItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkHJh8c6Q1yMVnr/bmhbsgKkA8gowdlPpT1699pkHBk=;
 b=JgTiJ7ylgJQx5yn3NBa3U11yodTpVMu6Z1GDA+m2tp0P7nYady7b1Oj0GtF9xGZ2udE71YWXz7Y/zH0EHHnqBWQl6Vg3hVp12W4YN2+NYTDuFkTMe02SdTxp1Y3jzmnVcYXq6HHF9Oq1DzX8Zg70MLpwSaeQDWWJWA7rD7njEfM=
Received: from CY5PR21MB3447.namprd21.prod.outlook.com (2603:10b6:930:c::15)
 by CY5PR21MB3711.namprd21.prod.outlook.com (2603:10b6:930:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.7; Tue, 14 Oct
 2025 14:11:24 +0000
Received: from CY5PR21MB3447.namprd21.prod.outlook.com
 ([fe80::a6a7:e6e:ce3d:15bf]) by CY5PR21MB3447.namprd21.prod.outlook.com
 ([fe80::a6a7:e6e:ce3d:15bf%4]) with mapi id 15.20.9253.002; Tue, 14 Oct 2025
 14:11:24 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>, Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Support HW link state
 events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Support HW link state
 events
Thread-Index: AQHcPHhE0kkRC6B4zEaD5wgJwu71ibTAk3YAgAADFDCAACDNgIAA+DfQ
Date: Tue, 14 Oct 2025 14:11:24 +0000
Message-ID:
 <CY5PR21MB34476DA4115A6C5D6B76E12DCAEBA@CY5PR21MB3447.namprd21.prod.outlook.com>
References: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>
 <74490632-68da-401d-89a7-3d937d63cbe3@lunn.ch>
 <CY5PR21MB3447B6D69542EA4532547A5FCAEAA@CY5PR21MB3447.namprd21.prod.outlook.com>
 <4ea9acfd-be02-4299-b8c4-95bb69ad04cd@lunn.ch>
In-Reply-To: <4ea9acfd-be02-4299-b8c4-95bb69ad04cd@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ca48914-a98f-440d-8292-5d58f25161f3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-14T14:10:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3447:EE_|CY5PR21MB3711:EE_
x-ms-office365-filtering-correlation-id: c55a8a08-60b1-4558-d28a-08de0b2b8efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JzkqUdT4PYifx3CqnJqaK3wUeHiySEomyBDZamSNo8AyHl3DE/aNkYX+rJzu?=
 =?us-ascii?Q?zUznmRqOjbw9RrvdzpIHUXgvMMEGxiirY6qEYT8RWOyL0xl/fpF9RSCyzhDG?=
 =?us-ascii?Q?HUcq/GU3+5gXg+Io418MiHqZgriBQQqqhgKwarK4UBjCCjtk+Azp/sN2cptj?=
 =?us-ascii?Q?5CRQYY+BLiDy6XHLozM81HkJ3nhntKbwyUIIZaJq5Giut5XlGlMu6MkZ4aLD?=
 =?us-ascii?Q?8gj/XGY/EgHllEbcpD7EhMzKwzsSFb+LVUTV7l6XxjhbrmXqSc7MJ2TeR4XP?=
 =?us-ascii?Q?iYFwmmcwKZJCPxWxiiGUr31tuOhmCNjABQIpGXzomcuwQbCA8dJLkhOwQuGs?=
 =?us-ascii?Q?Cz8zvCHL42mXkjZDaJWQIwBkGVOJ/FQVInG6KJfHS+uEsTrcWhOlGOGLk5Vr?=
 =?us-ascii?Q?dPRi1zVHPVA0nZqgRetbDqrGjJhcK/BA8Oemdyip/tEsSHESCXU27Zyw+HTd?=
 =?us-ascii?Q?VyLUk1fjobCDizxvLgur3UAnavNI/Y/4BdTV0/wEcgHbdT7GAYjmeMa+Lyty?=
 =?us-ascii?Q?lYEFeiIPGxjn129z6GQn1TwJmPG3rXmaH0idV1fNWDuFjJOmhz0hWy9xuQIU?=
 =?us-ascii?Q?4xm03byYAcRvmyR0skWptizPE4ME8vD4/Agq3espSBQ7qmiMR77vn5BaO1Jv?=
 =?us-ascii?Q?CnQcDvAuZwKk7IT9Bt5lK+YZnq8Oy4q/rQknu1wKIQVi4mOj3eZleyo2HDrn?=
 =?us-ascii?Q?XRfGnt71tTmTd9ykdGy85/b865JHOPoMlAoDfXYc4bIr975GSuqVqNtj8kUu?=
 =?us-ascii?Q?IAsvFDJVwCDEEtXZwyfS9fleMOJyIHJvHIX0IbzP0ik95Ju8uWLl2hB0KNh5?=
 =?us-ascii?Q?n0uPdNIz5ptAIA8j9PLuHHejpIb7q9sxX7RJQy29DLiR9VczCMy2luciovuL?=
 =?us-ascii?Q?QMBQz4HUQyi70wyRWbM9jT5gfTxdzWLVVh27ZrgUcmk/tqVXsuoko/DfOCkH?=
 =?us-ascii?Q?TkQfBStAl5Uv0FrQnO4Jj4jK/0AC5tKdQg6xqLEk5M1xmLyg9nYmNSMNjKCM?=
 =?us-ascii?Q?HzjKyXTSjhkUuVRMrcvyZgrJv3Ecc0eWU2Y/Pn6njy7OcTGvOMBoqIHd4I8J?=
 =?us-ascii?Q?GA5O3Y7D9qp0KE8rxYOLKB4CAGMaAf1zrzK6mICgq5Lekg96JiP4IMUsXvoz?=
 =?us-ascii?Q?DH/cnNAd7zMByyMa2+kUGq34sZGb+4KNxgumAfMlimpWcR6Goe6yxJM2AE2B?=
 =?us-ascii?Q?GqEAbssQ0dcxEeHd/JpXi1aEWXAAAEsdWGBYkfRsqSSHq33Ug7m9mR+aL//u?=
 =?us-ascii?Q?X2WeZyCLoTynOimC2AQokS8KtgYdNI+bQr1dxts7Wcc8xnWztJ9SvJ8qSRCh?=
 =?us-ascii?Q?zdvAwu96D4l480f87iD0gAwKF/+F8xRSS3BS0fstk6Z4ztgXJIce3Y8OfDzg?=
 =?us-ascii?Q?kT21wz2FsMN4FlPfbwKoCjGgbyeTMPep+QRWa7QS2vG9ghdgyeJt8nlZeYU+?=
 =?us-ascii?Q?ixQB0rPK1d+TWH8Y/D6BaxsLMHzY7Zwj4EAiq8mZyGTlGRCIGlc2SbT7zgS1?=
 =?us-ascii?Q?QQsiwgbZ8dO+Z74t2efevk5oO26ya3hbihbl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3447.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nLaVy4Itg+rVbxWNH/FQtQifDvVTmhZD5mh5hQOEZQwar2IVE012JYcsQKGh?=
 =?us-ascii?Q?3PEygLLQdmQifxuPDqlLxDg89CsG4m/LR2pyR9AQkJvpUIaZEDKz4EPMLUCX?=
 =?us-ascii?Q?TMvpnh/DWXt9jIWXATnN1FmzL1rqUk6GKQ2WgLj6KPkurBztPQz5mE6KiMXW?=
 =?us-ascii?Q?mtHN28glL+S66IpDMqnYy+mPaOEuASBSIaZ1rvqzJGlm4e6/pzSlK37cMOSE?=
 =?us-ascii?Q?Bu+I2hFyfz6EMz+sglQ3YMYEvi3tWk74XJJVyjcHAtcsPdGp1sQTLQ2F9KII?=
 =?us-ascii?Q?oSaUwgdA6jROL8pi/rhazmayUey7F8fomMs0I/juTQUxTVIRE2FpJHNqvDCS?=
 =?us-ascii?Q?YzI/ORsKE8ZqeeAW6rn/TYoHr21YHFD9nLTopXkhuPItf5cd3G3SPYa09ROD?=
 =?us-ascii?Q?HZfVcw2zynuYKBEG6KvHgnA5HjCvYzPdBlvUhAniO/ZV2eIIgmRVuwPnFnFD?=
 =?us-ascii?Q?jWBAz2kibC6tJZ51uMjadCwcEfy2x7ufCb9GFAXGnsf9CLzkwsU6n00K+6JK?=
 =?us-ascii?Q?GkQs7dnkUaQ/w63eca/c41FvhOz//g1Q6cCoPhHAAm6Csf4opPC9UN9TVsUG?=
 =?us-ascii?Q?KCM+LNzRAW5EjGewPdRWfjlPvtSrFPqCVnrRpiS9hiA9HXdfemj6HfkS0Uri?=
 =?us-ascii?Q?6RX8ljHcPD7jdTL7C3zUebV4GyJNXbQ0iUqXDM9RF4AaqMz8R/vkHfpYzZvr?=
 =?us-ascii?Q?SW0HOC0W0VVrxL2POFUDKZr6IEni7nc0iVVWpUlooj/YdbvZCq7pQY7L8UQT?=
 =?us-ascii?Q?bBqb/juzXplgknIt16a7qPws7YEYGmRhV838bq2fzw6oyHrolAaAyUQ6gZys?=
 =?us-ascii?Q?8a74Fy3SLRXCOEaQPbFHhny1FUm1uu/kG8iN/9KiQj/Wc3qszmVE+aIODTE6?=
 =?us-ascii?Q?IpZKNasWWgv5bTzGlnKGu0locm3xZeKv4oGuHV86h7lSszBwUf/hkVtL0ijX?=
 =?us-ascii?Q?BMa0d4LL3KViRt/X39mk4BbUlw4YYV9ZE5Zbz0Q9HSSqtNXA8+to76tQBopE?=
 =?us-ascii?Q?yTMNC7hA/XZh8E+TVxaO+SQSrKm7aTF+/XJ/3Z2k2MrOVN3IgnZdu8ZXbYK3?=
 =?us-ascii?Q?cNaxcBTg0RAjaafU9m78hoFYxIv355lWcUOQEUpJaGpqkPpTyE45IGj8XQV+?=
 =?us-ascii?Q?6qG1mRa+J4eNtpBQO/OfTbKCvUUY2rY9DklJHkgea3c5Mzs0uUhieOIwE/fr?=
 =?us-ascii?Q?3YfwI44JOL7B8m+w11ZfOKXkQ5xysjZSkDPseVP/WE8HqE6PJNT8jYxznau+?=
 =?us-ascii?Q?aTiHsOOqmDGTLJqYRvJFsdAbBvLUhZaBQIBKHB55Sjp3ETmPtAAojlX6F8rP?=
 =?us-ascii?Q?HAPgZev5B9F2Hz7oAmLLoX6TfvshKc0rKPPHpNDZCGm5RL2cKlSPP3RUDAYd?=
 =?us-ascii?Q?mvy8f7L7ktg+izR1wjtul5vyP5SY8TtKGaRWD+Ixo+hdCdMCM7m10f5lqXfB?=
 =?us-ascii?Q?dMZvJV8zfWx8GpIgmNNUHQbm0T7k4SjbdpnS+szV3reXHrYNvKmqJM+yFT8X?=
 =?us-ascii?Q?4x8rCJZQktUfgFw55WYqDS+Ur1ADDMFi++lZ5RP0XYAHPDCMIGzluB7+rj5j?=
 =?us-ascii?Q?C0NWwrkjCHbRXFjPKOTZyqAGNGXFzPQprTniuwcq?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3447.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55a8a08-60b1-4558-d28a-08de0b2b8efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 14:11:24.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH3H88g0LjpIGh2BY+6g3FMYJjRbi5/kBO3CAEWIWjzUH6jgFpU52i4UNWXP7BnoVm3Z93s1SvDR/gw/PRbWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3711



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, October 13, 2025 7:22 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; Paul Rosswurm
> <paulros@microsoft.com>; Dexuan Cui <decui@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; edumazet@google.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; dipayanroy@linux.microsoft.com; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> andrew+netdev@lunn.ch; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH net-next] net: mana: Support HW link
> state events
>=20
> > > > +		if (link_up) {
> > > > +			netif_carrier_on(ndev);
> > > > +
> > > > +			if (apc->port_is_up)
> > > > +				netif_tx_wake_all_queues(ndev);
> > > > +
> > > > +			__netdev_notify_peers(ndev);
> > > > +		} else {
> > > > +			if (netif_carrier_ok(ndev)) {
> > > > +				netif_tx_disable(ndev);
> > > > +				netif_carrier_off(ndev);
> > > > +			}
> > > > +		}
> > >
> > > It is odd this is asymmetric. Up and down should really be opposites.
> > For the up event, we need to delay the wake up queues if the
> > mana_close() is called, or mana_open() isn't called yet.
> >
> > Also, we notify peers only when link up.
>=20
> But why is this not symmetric?
>=20
> On down, if port_is_up is not true, there is no need to disable tx and
> set the carrier off. There are also counters associated with
> netif_carrier_off() and netif_carrier_on(), and if you don't call them
> in symmetric pairs, the counters are going to look odd.

I see. Will update the patch.

Thanks,
- Haiyang

