Return-Path: <linux-hyperv+bounces-2774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B767A953639
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD47B21F72
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8321A00DF;
	Thu, 15 Aug 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OQzLOV1B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021137.outbound.protection.outlook.com [52.101.62.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A03214;
	Thu, 15 Aug 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733463; cv=fail; b=VQIVPErCX4YF6vCPPeWvBtg6PYHRChOLK9nV7B4IBJ9YRST1JndyRJ0GMdoXQ1FcxUBIFl+/gM9d6ifQF/Nn+nIb+p3hmGQYdgy8UwbVbxy+fPoceDpnwOZSU2atLbW+9fZsnCujgWHJUkIjA/PonIMrLqJhKTlXe7KaBFX8DfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733463; c=relaxed/simple;
	bh=fyrl5dgYgjIotzrLVYD11A9E9ZMdCjFbUMuPaR+dags=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCnFr71zWbUqBP9Bo/cjw03emp8c5KyVOaA/CjuP5LL8ulkW9utbNES4i0e+DYWxQfk7v57Z1zXH23lxHZuRJzr0+AelTcaC3cf7kRIAlp+TXDjlcq7SDeyCcHCxp5A5dLb/r3KYTB4azJAQYMQ9tfih7zY+lMaiekKQws+Sqjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OQzLOV1B; arc=fail smtp.client-ip=52.101.62.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em2Ashj5HGQ1ulPuqGBkRfNGd3ob5iCQEphXeF3Ul0FF56cwH02xbSjXdKUP6eShUR2zQ2NdAwnDGz/zPYGZlPXzCRwSYZ4oEnWhI95KnIR+F8576Jl2tszNVu0PSve7eMA5EqXBRWdTfosx4bSEbUCbgjq2mQ7EdQjAWuMSe+KrdwsOrlgEVDenO1S3yAV2tDIpF4V2YfIw9BAlHAsf/49CdfGefIJWLo7sG83NNk6MNTrdazyIzLg4/CBu/Ys+zbOkMnga8j0/Dy4gOHfxVlCMjZd6GiS8yWbecbRRZ9u2SIIckEfHnIJK+ddZ2+mlkVc0s4nMs0JUqKHteA+YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EtxbEL+vQDqya+zNN3SMgKreijPD+60wsrCjQ2G7sc=;
 b=nU9VBkoOUowzZvSCWPAXHnQtvnNHMaXtsaCGRv8qO4w13EInjS9v8HxzdCWEkFbOkVMQdpqnxEhosA/N4Q5i7uUVqkrsta2Hjpq1gP8TqC6U54Jyb+tterlCUzI1YIdE5qTNiuUeDD3HM47dCmqbQp4cIP7nnraPX4llZeuOpy0E4YhbwUFDwWWD2Pvo1zB4BQRW7LTOylwQlebXdVUjbWuAPut1GKPPq2Pb0IX5WZRVXH3ueu+MYtiXgaLAk9HHoCabEhqli5gfaP87M4EnYEgisbu5qlo3Ic3b0jukcbFutmBWONOFl35ZnAA1ypdVwry2AMMJ7Lp1B3Jc9UgrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EtxbEL+vQDqya+zNN3SMgKreijPD+60wsrCjQ2G7sc=;
 b=OQzLOV1B0Li/zo1iMKQOqD7P3JhspKjDeeTJeiNuHEenX0P3NCjPwKtN9gfdfdl4ylPwZm1Id+Le7LN1YGY9u3sRNAyu+uZROT89E39qDawlgrLr58SZNy6OnoIBYDsqFl9mKktb009kjOh6RipAEIq6aA1lDndH4QiQjDoooqk=
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::14e) by BY5PR21MB1505.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 15 Aug
 2024 14:50:58 +0000
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747]) by CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747%7]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 14:50:58 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: mhklinux <mhklinux@outlook.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Erni Sri Satya Vennela <ernis@microsoft.com>
Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Index: AQHa7mtV2XlZOJGmCEaDVZjl//CytbInbn+AgAD4tFA=
Date: Thu, 15 Aug 2024 14:50:58 +0000
Message-ID:
 <CH2PPF910B3338D030358D7ED43B94F261ECA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
 <SN6PR02MB4157330500B79F4E728DFF7FD4872@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157330500B79F4E728DFF7FD4872@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c17a7c17-b30d-4d78-ab50-db073c498fcb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-15T14:47:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF910B3338D:EE_|BY5PR21MB1505:EE_
x-ms-office365-filtering-correlation-id: fd5cb8ef-3378-4734-f9c2-08dcbd39ac9c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iSApOhG4dKyvSRMg6ZznJq6bc+6H4F59ZIEwJS5TJ6DJOh2mT+1MWM/tbJUq?=
 =?us-ascii?Q?JCLSJgN/tXT3pVoyOk1CpbtF1QvIVJelf7EZzjXyjHPIjVHxlZqY18RNROEx?=
 =?us-ascii?Q?iup8c2D6p+QqjvPwRVYzX1rwIc1riIT9Wzre4QXEmwbQzAA3zoPw5h3nbV+b?=
 =?us-ascii?Q?vEcYJZWH74C4QzbLvMjekAM9kcByPC1UmQiJqxM8xyn85Oyd+YHRf91iMSpJ?=
 =?us-ascii?Q?h9/zfendt8MxEXzcv8ZKd8JRzKtLPheMUpVpGK1mGnxoR/qrk+6YK5tOk/uk?=
 =?us-ascii?Q?Hib+OAiMpfeHkQSXm6+trNZ0kd+WEPjqRFPnMSVC/eXH1kHKblegm4jHrlt1?=
 =?us-ascii?Q?oL1563smOjc4YFKzAr38ItoBB1BDgZrVoxd7wF5mTKXMS17JMSYFb7OdYKHW?=
 =?us-ascii?Q?zhNADvTAu1ECHROwmlp/Id650BlLsmeuo7311AjE4BurFz0EXyY+770TdzMW?=
 =?us-ascii?Q?sawW8m5ZaACrLBOW4NwCrSxomuVZUG12mipp24uXXd9D2uRr6tv2cIRVFawx?=
 =?us-ascii?Q?RAp35HH26EGjlS01cq1m5jK/MfNpxE0MgGc2NrhyfOqTQhQ2xjEUCU8dhBdR?=
 =?us-ascii?Q?Ci4WcEUg9/z1KdNKNEL9wy2zygcCIiQodtr6eI/5HoDZaD22in2Q+oYDVsxX?=
 =?us-ascii?Q?kZX6q4Qg71xGCA3l5VyV0wEZ/FkVL0nqM+Xgw1+X6oJrmAcysSCx6rL0BgmW?=
 =?us-ascii?Q?+bWIvmy7fSTf6IbD/wlo0i+Nrkq8FpqE7IO+lDbH2W/1sHpH2urmqFkVLg76?=
 =?us-ascii?Q?IlQJwfe/r5f3Pen7fBWpvyNcQ8TupI/zW4/hkBzNKXHG2wY+QGURUmhJmroQ?=
 =?us-ascii?Q?adiqH3KopThNF1q6LVkaKl7Czr92SvYf99nAKsMwEvHriepvv+qSBX7Nahya?=
 =?us-ascii?Q?c4WSAmgGolAPFOSZdKgpIPVoWIPk0PzJvNPgIG9Kti0AD+A8QZLKQAwB3WcQ?=
 =?us-ascii?Q?x7hSl4JKLhjOhjmobDFPaxpTW9F0oTfR1AwFLVHiWBV7+RkdeDwj5bKB77ml?=
 =?us-ascii?Q?OsYnsaRquoruUjW9te3beHL7M5L7MAq1lAQoSAkJF92ImBfl6080hEMJ5rT4?=
 =?us-ascii?Q?z3zKZ8t3m2dmf6tsoEPXJZ1V67Rk22gBwRTe4a5RCXgo6E8ZpWx0RnPiix7Z?=
 =?us-ascii?Q?/Ze7xmpqfznLQVV5/y2VdcVRArTURjdn8romY9KElw0JK8myCvc/1BbPSxYp?=
 =?us-ascii?Q?flt/5bqNAKaF1Fo0zQoqH5tdCZgR6bhxJUU1Uy2gk3OyoNZpQ2yGJPJt1IsZ?=
 =?us-ascii?Q?R1qCPqWdVVdSuPLiFAj6TRqG0q7m2Cgl+41FF53lE+WgWHLOwg1NHBvFfc+D?=
 =?us-ascii?Q?cU46m30dvIaX0wflkha65cCc6V/0DK6ASpeT3rnH5qeG0N3i7Sg0+rin7xmn?=
 =?us-ascii?Q?RNmbUJrz7R7BEGoWf2kkt4p0SQWWa0Oj6Zpy7rnXvANfE5jBndzMY8pFoX/j?=
 =?us-ascii?Q?XHigHRBWJII=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF910B3338D.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTCgZBbk5WlnpuFA2jxwDI6W55hp4OCbmltv5+Jn19QPybuKSM9xRcrNcsOu?=
 =?us-ascii?Q?IJr+HbIet9GvOYN6PQzb1f+IcB2sPksQjGIRMCbpVWd/DMEY9/9+gVj5PsFX?=
 =?us-ascii?Q?6uiPIiybNb/8tg/SZedxLaVMUnecggUIEqA1OQtRQxnDiYIK+8Sxbm0Uc49n?=
 =?us-ascii?Q?/WAFfoU5LiFvMTNPgMoKTPfsfsl42cf8qYMhYBMb6B5E9/Cxa6ekckwTPqPJ?=
 =?us-ascii?Q?Z/+d1ADvyIT1S4ggboPsFsnOBqUurQ4Chb73gbpVY+JNjBiK1KSe1z39AGk5?=
 =?us-ascii?Q?wF0peBEoaf5EtckZ2MJRofflWrsYoZ+tBpY+4IVaOeA8FdZjiaymhSe4/8Mw?=
 =?us-ascii?Q?Ip57oHKQo+Ia0Ow7Oaytxy2Mm76Dh/VGhyfo8tuk/WfOzhDB/Y/PEibSNVwq?=
 =?us-ascii?Q?msMGMWvnlCXHVtHoLABqqx7ievm4SiX2lf5V8qpA3mhSeLsp84spc5n8rTup?=
 =?us-ascii?Q?jSCafoLoiGhpP2VmcwnliWhbyf48JQcJbCPImt6bOAMf0kKZxZlN0TohRIg4?=
 =?us-ascii?Q?jxbEZtPsNP+tOB52b/a1LGGNORMsY9FL1y4phmYpvh+GmhkDkIt9WfjJDW9J?=
 =?us-ascii?Q?g3AJMqWi1x6jhg31Q2pR/XexxXvWksb9NoUJv6rWfZQ06pHnog/14Eeyo/rE?=
 =?us-ascii?Q?4wwh7zcDKDQbi6nTvC7JL1FLh9Jxe/UbI/60xyPazMCk8dorH5xrYxvnuNoQ?=
 =?us-ascii?Q?PnDzago+Xuz33ceecRNkUABjx2Dn9QbwDfTfTpvdQCREZzu3NcVcpwfYFzas?=
 =?us-ascii?Q?PUpSq8ctFSllzMTYaT8v6B8u4W2ZW1pC0VJD8dWfQVXTKBV+ddhsS2sccMs6?=
 =?us-ascii?Q?f/K3UVCK22nWRdcIUOCKEwqBHePZ844DaKge5Tcnvf3zNJkB4m4QCETVyhtp?=
 =?us-ascii?Q?+vOiFE92EawR70gK8y5cX79qsaonNnrOvx4KRA/x0MNbrQpJmUKmII3zmTX9?=
 =?us-ascii?Q?tQBEBXxxwE6axlEk+QM1+CTOIYXiVyUkoEJJkbx01ucrWA1nMEF2jo3PQK/O?=
 =?us-ascii?Q?gWuS443YqKfygZnmydQCnmbqWyGC+eG443O2f2YT/C71FD/lXaf1fjnUi51b?=
 =?us-ascii?Q?7VYFB7EV7Y5fngSn9LS5nIUq305ucjOuyHwOZ9F1drCAJQ3edpcVna6lDjDs?=
 =?us-ascii?Q?3JtoZSfFa3HFWDTK9sBR0QEVv/t+SHypPW5YL34WXzpfGshq0ACUzyZfY6Ek?=
 =?us-ascii?Q?ycT14CjVdi1/siLj/lKqBv/8UUVl2F7jRwtsZPmAg7ioY6XUtq6bwOak1kgO?=
 =?us-ascii?Q?3VKG0uEOfSAIefFrhUA0oHeuKEbVi2hgM9exQKaG63467BScyhdJzeBxiGaa?=
 =?us-ascii?Q?ik8mH7o2zrgUj/RimqwuvuaeA9c53oBfhXj9t3VD0CWlOQa0KNokrDr9vU0w?=
 =?us-ascii?Q?dEkX4Fkw3TSVlLJsWKh/1H6qT0IPsb0JzUdKlbAXSop7AHNtpxhHuaPOUTJf?=
 =?us-ascii?Q?gcXJoiXre7wwI9uFX3ckJPpmcdM4J3oBOY1ucgdtbeuFt0aNtlA9E2kFSTdT?=
 =?us-ascii?Q?0KyJGIO7uUq1PF3t044f4Q99blIZfieaCdyCzZZtSe6Ps7Lkybm4VWp/hqFo?=
 =?us-ascii?Q?0teFUOcVgvr10Fcv58oKas2tGjT4x1uqRV1xHmpW?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF910B3338D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5cb8ef-3378-4734-f9c2-08dcbd39ac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 14:50:58.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gViWzWOnEMIECRfXrJS2DjoZ2DAC4AJnovbniRW8YgVmSLCoMGrSKBDLDwhlmBLMTQ7peP2hojqgNRlniKxL4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1505



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, August 14, 2024 7:57 PM
> To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; davem@davemloft.net=
;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Erni Sri Satya Vennela <ernis@microsoft.com>
> Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
>=20
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Wednesday,
> August 14, 2024 9:59 AM
> >
> > Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> > Linux netvsc from 8 to 16 to align with Azure Windows VM
> > and improve networking throughput.
> >
> > For VMs having less than 16 vCPUS, the channels depend
> > on number of vCPUs. Between 16 to 32 vCPUs, the channels
> > default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> > set the channels to number of physical cores / 2 as a way
> > to optimize CPU resource utilization and scale for high-end
> > processors with many cores.
> > Maximum number of channels are by default set to 64.
>=20
> Where in the code is this enforced? It's not part of this patch. It
> might be in rndis_set_subchannel(), where a value larger than
> 64 could be sent to the Hyper-V host, expecting that the Hyper-V
> host will limit it to 64. But netvsc driver code is declaring an array
> of size VRSS_CHANNEL_MAX, and there's nothing that guarantees
> that Hyper-V will always limit the channel count to 64. But maybe
> the netvsc driver enforces the limit of VRSS_CHANNEL_MAX in a
> place that I didn't immediately see in a quick look at the code.

Yes, netvsc driver limits the num_chn to be <=3D64:

#define VRSS_CHANNEL_MAX 64

        /* This guarantees that num_possible_rss_qs <=3D num_online_cpus */
        num_possible_rss_qs =3D min_t(u32, num_online_cpus(),
                                    rsscap.num_recv_que);

        net_device->max_chn =3D min_t(u32, VRSS_CHANNEL_MAX, num_possible_r=
ss_qs);

        /* We will use the given number of channels if available. */
        net_device->num_chn =3D min(net_device->max_chn, device_info->num_c=
hn);


Thanks,
- Haiyang

