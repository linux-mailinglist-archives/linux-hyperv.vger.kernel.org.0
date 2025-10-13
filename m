Return-Path: <linux-hyperv+bounces-7207-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C581ABD6674
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD1405CF1
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322B2F9DB1;
	Mon, 13 Oct 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RxPnoL+M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020073.outbound.protection.outlook.com [52.101.61.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEE2F7AA7;
	Mon, 13 Oct 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392053; cv=fail; b=oNPgu1qWMCQC7GzfLqSVJQi4YkfC1E9T87eKPzSLvKnx4Wdb8QlvLmdX5HEK2+UjDGS69KwW2JhXLuQIx8tOF6eWO2oxDRhj/xh3fs6vOEH5Gj2yTYtZ/XMcH6vgiOeyM5P2/+oHAb/4eWRXAyCMhAt3+CAUVV8tDvwM4OvyOOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392053; c=relaxed/simple;
	bh=pp9NsFHvf479VPEDNqmMy/WrRTQ4QAdDyJxtGUzMhAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUEWpcqNfEa6bh3sXNLkguT4PXJUCW16FGNIBx2OZYve7IQ92gaPlZmF6rXq9Acc9mrtKhQAosAe9bZa0jZpXE/FZyOvLWbM/S67P4UDf/ids8JAhHEY8AbW4ZBgGd1hrOSiWm9WouxhpcOve5nQgUaG3onKCqQ3hHS3YpmwZmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RxPnoL+M; arc=fail smtp.client-ip=52.101.61.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDPi4TX98Vmwvt6H3rKZKtF3tRUpgzxZS5MSFf00s9Ae48WJxVfQI+fC/yBbFW8Sz0V9lejtoZdnj16rh5JPCTfod6ZVxaixppSWubNVFB4wNbAv5ap1PV/eE1z7Fg4/+3v2L8QDUuf/hteWNz1Vr8RO9hsT4ifHXzbciGgj3I3R5y3rxGIsx0wBbRpr3QDGoFeLWBSn+D+R18mkEadszVINLUhibJD0Fd0HWRmghv6EUjjUkt0h+vk5vShy9d6FaVehATY0SaBNWrLPV8gXqFaUTmmGGGTh+AYVGrN6d90AB16Lqu4rRxR2aW2YbLAiZKPY2JruGhzOJG8hNVoARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu0WP0LNORIzTKgg+IL4WFe1TBbC2xiVYho+VjpFYYU=;
 b=jD3vZIafzugvASCIO6lWqQ6VIdymWuCjvdIT9ITjyrEmHsyFrJ1cAmBmVB3+nyl5JE5z55baHDnpuvKPYst62FrGLICtWvOoW85spunRWuwU836FRfZO9M1+gFj92BizqjsQ4r4Qobh5UaGFbkYotrrZ16qv6b0qfNVGfKmRiekLaE0HKBWBJ2HbnFi7NH0cEsS5VeMDIxFYx9FRXxczSVKQc9zOff0X7z5xjbN6tljvgmsxHmLPq38VhXSQ3/gfdNX/IawLgROsMa0NF+iHLXOQPgBLF3SBca/l1o/yBpOl+XbDcFW8cBuhIGiS5djfaXM/sj8WSB+dDE9MWB3BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu0WP0LNORIzTKgg+IL4WFe1TBbC2xiVYho+VjpFYYU=;
 b=RxPnoL+MBuheYZIrAmyKZT6UDksWNKxeDqK6ioo8d4T8MMadsnmxNYKEIK6GeM1lb69aW7rLR3FvRJQhWEOwA5eqY/XF5CGOKz+a/sTiVsPjz4cfwBMSKhG0WLeDJJqLpiKzC8R7gbrsKhebHBmmDTgMcMQ5kMWkplpu/23SXco=
Received: from CY5PR21MB3447.namprd21.prod.outlook.com (2603:10b6:930:c::15)
 by CY8PR21MB4047.namprd21.prod.outlook.com (2603:10b6:930:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.7; Mon, 13 Oct
 2025 21:47:28 +0000
Received: from CY5PR21MB3447.namprd21.prod.outlook.com
 ([fe80::a6a7:e6e:ce3d:15bf]) by CY5PR21MB3447.namprd21.prod.outlook.com
 ([fe80::a6a7:e6e:ce3d:15bf%4]) with mapi id 15.20.9253.001; Mon, 13 Oct 2025
 21:47:28 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>, Haiyang Zhang <haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>, Dexuan Cui <decui@microsoft.com>, KY Srinivasan
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
Thread-Index: AQHcPHhE0kkRC6B4zEaD5wgJwu71ibTAk3YAgAADFDA=
Date: Mon, 13 Oct 2025 21:47:27 +0000
Message-ID:
 <CY5PR21MB3447B6D69542EA4532547A5FCAEAA@CY5PR21MB3447.namprd21.prod.outlook.com>
References: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>
 <74490632-68da-401d-89a7-3d937d63cbe3@lunn.ch>
In-Reply-To: <74490632-68da-401d-89a7-3d937d63cbe3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=325a03bc-765b-4a53-aada-40c1700371fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-13T21:24:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3447:EE_|CY8PR21MB4047:EE_
x-ms-office365-filtering-correlation-id: 483d4588-0fa6-40a9-3510-08de0aa21a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xUnwtooWk15jFksIC1sqXGh1tn5vXfMD20xjcgwaI5WBAafhOohyhXHkVzIL?=
 =?us-ascii?Q?QN7ZC0whGlEOXPFJ9wgIoOSRwlQ7k0/sC1LiqEHuSbyUD9Dped31e8LWHIfz?=
 =?us-ascii?Q?xoDw1HmyG1DvWzPKhJjl51G0qtkZfH2bs3nK7dkL3YDkIoLIh5K8ZX0C8mIv?=
 =?us-ascii?Q?fP3/Q37JqPHlaYqXwqSKPAFIo/BGxeyXpjCmQV2qFjoknQBg/dPO7JESo9p4?=
 =?us-ascii?Q?sqDKyxfrisG0XugPPmHQlA1vhJTpMcyy/5hiv79xLC1hrc1Wn2nUebrCm4wS?=
 =?us-ascii?Q?c1hH6aUPN8B1C4YvZar4PF5WPOx/4XI/Sox3TAzlE5CToK/HSfixe8VD8rKl?=
 =?us-ascii?Q?Bh5dg64hKNMAnCdxSEMN4m1zotZ4FuTeB3E82i7WjGdxwVmdBU81J7hvKuRt?=
 =?us-ascii?Q?4BrEsHEexbZJaBPUTrKiU5u24+Woi60PzRMz09pI/1rAn82rx4IFpcRXKhLs?=
 =?us-ascii?Q?6+TToOQSEIbWHJ2t08bylSYFT4M7uG9fZB8jAFPcqgy+mAwhg+6RXRkk39yE?=
 =?us-ascii?Q?5quLJkpgQSK73S+17P67P2b4l81rmmzEzi+AUXpvaWhJRtAJIOKd9plc36ky?=
 =?us-ascii?Q?HKOiECvBoY9kQwTt57GHJS2VDzILubaM+8DugZDWzhEBXWYtsGDguVrkVY2H?=
 =?us-ascii?Q?UyFqC3nC30COan1uD+SpM1R3tGwDNGBU5M78SGVJx1ChiXGLgzzs16ccOMg1?=
 =?us-ascii?Q?Qo/AtsCmP+yx56o6CDzqkoipI5vBA7MghrrPXdwsmSKJNWJ3TAdr5Ghh5LQN?=
 =?us-ascii?Q?MtAUmgaf64xd1K2OV8gODhfyBT/LZmi6MOe8KBqOvKCCQ3EaYAiM3scXoghS?=
 =?us-ascii?Q?zhiOJQgPOv+bGNnSB2LLn4jRm4rxblcSYJkaQ+RR3izcS2wFVbyA63UtLep2?=
 =?us-ascii?Q?DS60/4Hx7q3uZPoiRkg4ybY7K/IzG7RK7mkZIcCHQR3hyHTBWzNAGXbRG0Wv?=
 =?us-ascii?Q?AsLvzVaevA0ZhkkZSbLUqsGt/1cdEulbkDMUz8/lRO3jPVHd/QMTB23iVdaZ?=
 =?us-ascii?Q?WSK5QuIKtGb+dP8CXXBmwNiojmoVyAUPdWbkzW3Jlz1/TVh15tD9HT4PCw8S?=
 =?us-ascii?Q?u+Q4GPA39FLEq7jtcCWCGqF6gR7IW1CK/1OSU4QngS5dzoCyfQaBmyAUMi2n?=
 =?us-ascii?Q?dUdJABJ5Sx8YmwzwF99DtH93c9iX8Ee+QyJJMNcJwGUGNnULebIT/wvVVGmP?=
 =?us-ascii?Q?8AOgInvioe3MPjkJjH6pMn4MwHGYeI6tM3gJL/4BzcOrKcWvCjIWaZ5Q5WP4?=
 =?us-ascii?Q?dmWhnmsJeaLKL4QT8zvCdaByjjJBMF7oRJalQa6T/R4dswSZMP0qZlHK7vuo?=
 =?us-ascii?Q?b7l0hm/wFcsPJZFXHZr+gSwJNRoho4NuBgZfTrSPW+fl4K6nWmq5gZwoPLyj?=
 =?us-ascii?Q?gzz4nNQKl/1XF7DnXvIScddQJCmOc7HufcS6fJ0ADKlklaVs8pqWTmgjLn7M?=
 =?us-ascii?Q?RspsMq2DESHP47OO04fBXtjDzNBYjBQpGpa7pRiGB9DmsTKI0UGEYDXB86Hk?=
 =?us-ascii?Q?qCH9T2orcPu5K8VRAB4Xqx+WqqOY+jLl68Jx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3447.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kvlEV7tLbZyYRHgnkz1dHC5kkCZ6m8rONT9mkXD3WUfD2yN1KGLkJjYI/3S6?=
 =?us-ascii?Q?1UyOPjI9WFFxcG5HQbLy+pe4yNEtLjqP4LA0MT60iU2LmUYnctn/zzTcixUL?=
 =?us-ascii?Q?A7ai+4O0TxamTDp4jub/Yg9bzzD2VX5dKMaGJQR0p6kdawRYOelJ5NxTTJIj?=
 =?us-ascii?Q?/URKfiVWuirzgKkjHohcnNtLuUaTK+IwxuTTy0b4KY7v/By+3SO0go2xEY/z?=
 =?us-ascii?Q?jXKbVRLFCC0abXZLRePRgjLl6GHKH/5UMsscTovSOb37VvoQAxiXw3ILOiwX?=
 =?us-ascii?Q?LA6J+Yo5eJhFTPeb6ZA4t0P5v41MW847NBsHj0qLja6HyHyxEF672TvZgrOW?=
 =?us-ascii?Q?xKtvYpOeP8yP1gqKXCR3qDFw4Bjg1lxO3ZItzfEppsEkqyfHx6gbKE1HRh9c?=
 =?us-ascii?Q?3Hh2ZHN1z3my6Tsnwc0BF7p5IWZ7T3Iy5+UkLrLyyVfjY41WwpngubRePI32?=
 =?us-ascii?Q?29kIx41m+yMJqUHlJJh0hx3JtDKyFxUGYnOOOH4ksGet2XGVL92Qa8fUe77E?=
 =?us-ascii?Q?9lTMcrLk++oeBXANqLx6lgX0g78mHmsTzfUEW90DRP3SV571vTgDj9GBT8no?=
 =?us-ascii?Q?tcILj3gN6c6wRIspA2rG/ZUJCkS0XIBKGD3ACR7qM0AnZp3vgDskQdNxkgFS?=
 =?us-ascii?Q?e+J5wV4XgkXKUPkK90EXN2erz/OyaL5FZN/Q5GLpqmWn/B+ZzSIra/M4UqqI?=
 =?us-ascii?Q?Trav4FcRByWj5tO4gi2wpxlnMD9SwRePOA2AOQjph78mXOzDMp6apDB//e01?=
 =?us-ascii?Q?GLxzhI2sCkvDfbNlr2YSIlJHYfG3iqhJhefBtS+qtL5uyMVlyOc+E6Nv6+HD?=
 =?us-ascii?Q?Rq2qQ1hR1q64plHDDO1lFACeTbNVmRTcxLDsxcBkQ2UdyEg4pYUQ+/FCIXUe?=
 =?us-ascii?Q?gJibSl7YUBYCjhNNi/UKontG4xCuXdpujl81eBHmcLx7f0ym1uViyvg5qwq0?=
 =?us-ascii?Q?ZrwVciUJ0Wa2Q106f0kKPJdtoM0bTz5N2JLsDXxu+st6G+b4Hlt+zd9//pRh?=
 =?us-ascii?Q?moPZwz5Ftu3bxIRUi/vuDcNcEvLPHjQa15xfgW+q+hDRA2ihR7sjtohQs+Kc?=
 =?us-ascii?Q?aMN1EzN25401hbZBzcRjMfwHDQhrscSS3wdSqUO4B674LixnmnZjw2wcLF/x?=
 =?us-ascii?Q?PPWeN3RXlt7kJyAo6Rp5iIA+w7lH7AD1SZG3EeuQCIlVR9yJkQuZl6U4MfJi?=
 =?us-ascii?Q?DfltXTlwff/N8usLR7jRdcBaD62GyJk6aUZ3JUj5Q+k0BE524e2WImKIFwUd?=
 =?us-ascii?Q?kvpPjBvUwg/+7QlptOleby3ZjEfq27qckcNKkOZNdccE3xrY95H87vBmbr4n?=
 =?us-ascii?Q?/RHkBZ57gv/pGRZ84JQZR3nj+WiQ3KSs3nK13N6aBlMDn4/dCjTLwqD7Xhsk?=
 =?us-ascii?Q?4U+9+dd6wC+FtH90IoT7HlOdLUGNPQMqCBe9/34sy4LPIgwEHZ0PWlc3CUdP?=
 =?us-ascii?Q?ffuJCRWIeURyzvU7LE3vIG1z+VqzcRZgH52ftsqHkBetB89vQzaQ+wFzgDOq?=
 =?us-ascii?Q?tVTDn2WAQBclKHBohAJSojyXOW2A2IKGHW4MuC0zPDIQcglleG1usoB31SoP?=
 =?us-ascii?Q?rvOlbFGTX4OzVqI8E8Jtv0Vf/5MEa852nTDivT+v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 483d4588-0fa6-40a9-3510-08de0aa21a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 21:47:27.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVP+rTk7iKFY77/VezK/lSAVcTJxSFJWYCwH7Vxrps2EoPlTHwIOspGfPti6ojtADdsL5G2fr8xHMg9DQsNWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB4047



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, October 13, 2025 5:13 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>; Dexuan
> Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; edumazet@google.com; davem@davemloft.net;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> andrew+netdev@lunn.ch; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Support HW link state
> events
>=20
> > +static void mana_link_state_handle(struct work_struct *w)
> > +{
> > +	struct mana_context *ac =3D
> > +		container_of(w, struct mana_context, link_change_work.work);
> > +	struct mana_port_context *apc;
> > +	struct net_device *ndev;
> > +	bool link_up;
> > +	int i;
>=20
> Since you don't need ac here, i would postpone the assignment into the
> body of the function, so keeping with reverse christmass tree.
Will do.

>=20
> > +
> > +	if (!rtnl_trylock()) {
> > +		schedule_delayed_work(&ac->link_change_work, 1);
> > +		return;
> > +	}
>=20
> Is there a deadlock you are trying to avoid here? Why not wait for the
> lock?
I think it's probably not needed, will double check...

>=20
> > +
> > +	if (ac->link_event =3D=3D HWC_DATA_HW_LINK_CONNECT)
> > +		link_up =3D true;
> > +	else if (ac->link_event =3D=3D HWC_DATA_HW_LINK_DISCONNECT)
> > +		link_up =3D false;
> > +	else
> > +		goto out;
> > +
> > +	/* Process all ports */
> > +	for (i =3D 0; i < ac->num_ports; i++) {
> > +		ndev =3D ac->ports[i];
> > +		if (!ndev)
> > +			continue;
> > +
> > +		apc =3D netdev_priv(ndev);
> > +
> > +		if (link_up) {
> > +			netif_carrier_on(ndev);
> > +
> > +			if (apc->port_is_up)
> > +				netif_tx_wake_all_queues(ndev);
> > +
> > +			__netdev_notify_peers(ndev);
> > +		} else {
> > +			if (netif_carrier_ok(ndev)) {
> > +				netif_tx_disable(ndev);
> > +				netif_carrier_off(ndev);
> > +			}
> > +		}
>=20
> It is odd this is asymmetric. Up and down should really be opposites.
For the up event, we need to delay the wake up queues if the=20
mana_close() is called, or mana_open() isn't called yet.

Also, we notify peers only when link up.

>=20
> > @@ -3500,6 +3548,8 @@ void mana_remove(struct gdma_dev *gd, bool
> suspending)
> >  	int err;
> >  	int i;
> >
> > +	cancel_delayed_work_sync(&ac->link_change_work);
>=20
> I don't know delayed work too well. Is this sufficient when the work
> requeues itself because it cannot get RTNL?

cancel_work_sync()'s doc says "This function can be used
even if the work re-queues itself".
cancel_delayed_work_sync() calls the same underlying function but=20
with WORK_CANCEL_DELAYED flag. So it should be OK.

Thanks,
- Haiyang


