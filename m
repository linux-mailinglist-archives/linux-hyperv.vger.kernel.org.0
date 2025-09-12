Return-Path: <linux-hyperv+bounces-6843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BBAB557B5
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794131D62FD7
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFD29E11B;
	Fri, 12 Sep 2025 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CryMipF9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020141.outbound.protection.outlook.com [52.101.46.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4825D218;
	Fri, 12 Sep 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709581; cv=fail; b=AUDF7HtPjJdhZVOGs35Z7y4GYCDXTt4LYorTmljoq0a0+Pc3ktKUDnw6IL05TyLOAd4VpQbe//vfOyQBmDCPnnuAHhSuimWZLYsYbaYPI9/tGxM2jcA1GXPWpDBy3fYFjwKNoZMy/mSNPqCXxNAAAb4DZojua7qntQlSM7iMNcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709581; c=relaxed/simple;
	bh=2d4IgPNM7Apq2cS+QtR7ED6qEZHBf00aA4I6U+GV9So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exMMuWwdKJ7O3qor2TrR0P3X3vcbaZXGd1Oo0OvW888Ha/tTseQbJ3TamSGt8vSI0zuEPKLQRAlA1EMULbsA+eWqEcs8Ib+2gd5RjGoU4qMDlBf0VS2exQSx/vzVuvhDl5xvuqm7cDfc0drUeZBs4uoKRO7+izBm2YaD7amoJsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CryMipF9; arc=fail smtp.client-ip=52.101.46.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pV0jeldaSYvp3b7BkLcdRnYw7XpEEgD2q/cpQ+RqFBACmWCGkIWcZMGpa9yapSmn12YAB55trYwCActQ3DDod6PdUQovsXpKcGiQhUWwybsm2AjdUhggDrLK/wzpDOvEkUVC+on8uC6L7e1BNwMzk4U2hrW9BWtFbvFTD/ax1UcRcWA5/OQljW6c4w85jdXjx1ak1K149LcH35V73+1ZlFYNKSeGIvDmPq995H9b2qud753Y32FMHGyr2rzACi0QLzx7O6DpLMqe6OzMVYjRC6geg4bB81bTkAu5swzW4gByeY4eQXFjOOwl7E/W+owJQYA2tySvE+s8E7L5fCDqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d4IgPNM7Apq2cS+QtR7ED6qEZHBf00aA4I6U+GV9So=;
 b=rKN7MucHezMTHdKGjySHHI5XBGSDhd4+wPMijuoAVb/u4zjV/6SGs9NbgJEZVtjpGxVUqwXolTaDM2GmkCvlQosoAD5dluA9C2FwaSolQJbzcI+jGCPa6jeuJmvXMxzQlAB9xsTMSzdoW80PQO42nP/I7gvDA2DHXeWcLQ6TtfbTAKOkUeYVQ9mcbYHHMmzCAmBNWR/ENx2OVhEe8epATzrFjK1pk1/0OJvyKl83Uh7pVKOXtrheJvXDDo/1sB7bDz2Vj6y4nyPQFJ1J4kte4C/fyvII2dfMI2ju9LIBNyJuoNvZ5UI1BrOggOf8fosZhTSP45a7FRGQdmVZ/OBKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d4IgPNM7Apq2cS+QtR7ED6qEZHBf00aA4I6U+GV9So=;
 b=CryMipF98LpxRDXYZaDN6+EMEbaEYJE0l22KH5F6LAFpPDcC8DzNwtNVXza9LD+VfTigO9UVhpZG4F5+pVAXrHUKR3lnI4UlQAO5h+3ny6UQUSgRoiMBlWqRyqX4t9HAoD+GmpztKDbScNUcJRmDL5x1xSWY9BUdghtlYmNSKwc=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:39:37 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:39:37 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Chris Oo
	<cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup
 Mailbox for Intel processors
Thread-Topic: [EXTERNAL] [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup
 Mailbox for Intel processors
Thread-Index: AQHb592x8wdveOM+ZkWT8plIQi0+abSQOxkg
Date: Fri, 12 Sep 2025 20:39:37 +0000
Message-ID:
 <DS3PR21MB58787CD89E8A90B2C076398BBF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b4170195-b024-4ae8-87d2-7caaae387695;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T16:50:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: dcc7003b-21b1-4a76-1706-08ddf23c7d60
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nqII/4pPWbZckV4QIwiq6fLyyLy59rpKCYg7laK3WwFL1cZGqvR4AoAKLrCw?=
 =?us-ascii?Q?2aJUgAEKk9f81vmRtyhzmsBIyZeT+IxNHx/GY/uN/4HwK3ofjTF5Hqk3S62e?=
 =?us-ascii?Q?/cSmSLqyW/YLuuawPmAtu2R5bAz75jWn1OiL6KzZmjiCAfdeFKkV8U6qcGZC?=
 =?us-ascii?Q?49k78G5matno0/Dugz/CHlrGqFFHG5QBfCL/m7PdAxrq5yg4wpfRnCIONKC+?=
 =?us-ascii?Q?alcD3eNQcV4H6ipjRNK2J50oAw/UOD6P9Sy0KIlBnYUehjZRoXS7grgHpwsd?=
 =?us-ascii?Q?oRG/tCf23UaQvATPvKovinnjCrt26ORuRLpDP6tIEElvNQn0OknjKosKv68q?=
 =?us-ascii?Q?WXs40U5W98AKsgTtnI+OTzOVBJBVjnALFIdYvutyesO7eDkgJiUjGAw4rlw7?=
 =?us-ascii?Q?Ep85nHtKe9oXpoPn/FFhzt11RH/2A2D/mn+BOiZ0f1jpP9LzgTC16DRKCukv?=
 =?us-ascii?Q?KTGQTUnsgF1uIH/+H5ArKcbVlspaSKuaXy1L9ohu1IMIyyEOjTkBq4j+axpX?=
 =?us-ascii?Q?He/O73rzH+Zyz4S0P9DiOUqA4nIBBXfM2zwfyxOgzdcQvnaUrLVXH4RZA4Ds?=
 =?us-ascii?Q?LExOD95gFZx7NxznoVnAmnpkHTvEpMbxQwx4Rv4Q0M7skXtd7QX3dXfwZb+V?=
 =?us-ascii?Q?yxI5AoA5mTXCSNDtdImEEJWjtSkNGo4bKIxbbuLMabtI1ySYfN1hhdMfDihq?=
 =?us-ascii?Q?kR4PA9WIdQGJx4+2d/PwWC37n3PjbCrfJhBjBkhQnbdUe3bN/qhrSYdCkp4p?=
 =?us-ascii?Q?ELdRztq+7SFWe4wGffNiH2ueO6o0aJvjMezVFjLc5cm8FLMzatcBUv4aFDb3?=
 =?us-ascii?Q?9xyUr28xU/drr05K40IW+31HtpER/zK10XD20yJ40mWvtFTQ3ddjt632G/Fq?=
 =?us-ascii?Q?d1/9+vtWJ76gKO1BE10THVBPZBnCfxMKcW2vTuVHb1759IJW0iaV1UHqV5Fa?=
 =?us-ascii?Q?oDdCCeYOH4CZ4scO4XYAv/7UWIEToMUSvec36pzc3M9pvZ+BdWaq6GRME8Jl?=
 =?us-ascii?Q?jLKyOfmmGQ8bL78IY53hJVJxiaaY/HTwu+gVt7WRbd0ErLT+ArN8cU5Q2J6F?=
 =?us-ascii?Q?12oDJMS87TXVD98Pv/U9kgxMUcvU5w8hl8fsRCbWTjatEcvhqr1m2TwQTKzz?=
 =?us-ascii?Q?dQ2on+ANljapuTqDtQrmczJjlRI7tpVEo8M7KVAcCPKsueAWGiFmB8ilUWqZ?=
 =?us-ascii?Q?rz0GGUrNy10HDPUubRZX6BDTLI35ibuEZQK2SAchtQrubAAiXR17N+57Zv5b?=
 =?us-ascii?Q?bDPOXn4ShmKbeo9/FZMe5+J2LVcEFEGV0Jiiy1vL90PrPHBH3IfWNOsrnt4Q?=
 =?us-ascii?Q?Q9JUfnI8vKmiRK5sAZHFVKyDXBrJkAh44BGKCDSYzCxLtRafbGartSYBFZLh?=
 =?us-ascii?Q?GkgrNnvNL336RuPM6OQFFn8v/1cxPke3OuEYLDpb7Fz4rdcvzVMQITxIj/Ns?=
 =?us-ascii?Q?5rOdZIkyCs4yCV/WEVsHLfFikihUFQ8BivcHb4nNe/VNB8gpFwCJ/Me7yYLS?=
 =?us-ascii?Q?lB9ghNc1JHAnt08=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jlfiaSPj7jKFJQXvkuuYmblfGsvZlMMeBLdQgY4r2RMRCkcO3Tq3hlNC4lIG?=
 =?us-ascii?Q?VJZARylThGe8LJ868k8sexNlBa2hpxug5/QWDR5RlCxdPXIvWRkIb6gRTRG4?=
 =?us-ascii?Q?pp1anDxaZtOc6+XT7EWzb8bzAuMIYFVR/QgsFOOeElawmkl1WAzIZKlFJeW/?=
 =?us-ascii?Q?7UGjfPC2Hb6aiNV82YKeFb+lK0z5b+BdyduEhJtjRdIGJKAM1RbgaptwE6Fe?=
 =?us-ascii?Q?P/stMJ9rvUoKO5yyRYc4/Y0i+e2ea0dPqVKlWPifaypCyHGgnRaPq0f5xnkB?=
 =?us-ascii?Q?0YjPyEIfBl4SgStQF5D/X8oBjIINsRAM4F1nomqeTD/TVXg4YGoJZ6VBPqpm?=
 =?us-ascii?Q?nr7I+sH3P0zlcKPbkhkNHLppL08NsAFa2H3R2OtmR/KmDzWh0Ju3sHkGANbD?=
 =?us-ascii?Q?YuwbHgwvhnQjzYV3iyzoj+UsdOy9mxqYaaRL7mq/XlwX29LrHW4DtugSzZDa?=
 =?us-ascii?Q?7V+/EtJNoOwO1BXSDP7RKiXjtiEY8Zo3C5hdcKo9C+rpTKRcY8mjsyGn8kUG?=
 =?us-ascii?Q?8+poEmkvOXz7eCdAhYN/A98aZdqyUROE6NKbCX1psEfDr8xOTLMTo8vlpTb0?=
 =?us-ascii?Q?xY40xQ8x86SgPd2orP3lgTjdtgt18iiglphn89gexQxSd9lPrLB9ZA9lbVop?=
 =?us-ascii?Q?ofdTPzFXO1B7yT27op9mVE6mmJjR2mzXzCSaDTVk9yY4h9dj5Hu5YNmTt5I0?=
 =?us-ascii?Q?89YeDBWzyEOno/LH1kbBAB5OsMa1zUHO3+GAB7YZr272k48lM6IymVyzPwF0?=
 =?us-ascii?Q?HXrbe3BX0Qfcj5LgcphfjzQ5B2YvhXoaNmwBvPDTwqmmeF0QmsFY+AYlv+Om?=
 =?us-ascii?Q?O/6VVr36kytnUnjLKHewuju7W2fMRjzFKO55JXWq/JE1CI8uOT1rzBmiRrV0?=
 =?us-ascii?Q?488ShLoXgavpIlVCcZwbVk2UZPwvjxcr3Q/aJMI1rghQ2E/sqiEl+L0KN/45?=
 =?us-ascii?Q?WMQCWkeGej8WpKUko1Sc4n/6psBFmS5S/NGgk2rfZgvXVXiap7LKjK+46u7h?=
 =?us-ascii?Q?DDFYHoZ+ygrJVadsZRUI+KQr1VEMLZFx9p7yNXyZLKmc9/yaAGX2EdNuhQjw?=
 =?us-ascii?Q?0syhycXJXuYqRzzh5Y1GqnvZhc5nRwyFRuBWbCwpWZ8jC8tGOEla5o/l8agX?=
 =?us-ascii?Q?qZgaMQqLu46HlUE+AsTVAbV7UUesgJXy1iCnwM1nHigw1gGIMLhDQOOJEYDD?=
 =?us-ascii?Q?Q5C3u++Mnls2ZPEQpr3DO8mEy/fconH/Fvfuq04+oiRPDfGB7kc15lHFe75t?=
 =?us-ascii?Q?Je3bre5jFk1d46BqY+ovKfH+sNAF6B+Wa4w03sZGchAAnBcYF9nzgMmSp/ZT?=
 =?us-ascii?Q?5RoK6TKBY2BfsRQd7JFwWuaEpDX6cGfLDjyZZwXvbo+61xiLIv3lQzRhyADL?=
 =?us-ascii?Q?M27EGynQtz60o6hzcyST6grjSqcOle1A2fGiZ1oN3UPKNEAXZK7F3CPjvXFt?=
 =?us-ascii?Q?/MkMBy3ArIHoSTAN9r+A9PU+ReODYCbRZJn8W+6lQUy9EgWohUf0F01UxFnU?=
 =?us-ascii?Q?oye3KAKjWYpo+jTmA/+3rpfeF8Ls7pPvZ5LafWyb51qDHMFQj/J8s+SJ22/M?=
 =?us-ascii?Q?4DoRVrhC7/OpHq56/VKLJguY+UK4vKIaRXmt1NQ8u0WYyOeZ9udSMexmDyIY?=
 =?us-ascii?Q?cMivS7CYqYT9nMan8Ks4zOpweKiwb8vzAK7MAQUBTids?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc7003b-21b1-4a76-1706-08ddf23c7d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:39:37.1517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRipHxpwIsLnrKV3faJ8zQPXQv+OkZG3x9fs5uuWTWh/+FMLjNhmu38cIDiVm3/yUgU/3+x0rGSBVzlm55FZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Sent: Friday, June 27, 2025 8:35 PM
> [...]
> Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> firmware for Intel processors.
>=20
> x86 platforms commonly boot secondary CPUs using an INIT assert, de-asser=
t
> followed by Start-Up IPI messages. The wakeup mailbox can be used when th=
is
> mechanism is unavailable.
>=20
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of same wakeup vect=
or
> for all CPUs while maintaining control over which CPUs to boot and when.
> While it is possible to achieve the same level of control using a spin-
> table, it would require to specify a separate `cpu-release-addr` for each
> secondary CPU.
>=20
> The operation and structure of the mailbox is described in the
> Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> that this structure does not specify how to publish the mailbox to the
> operating system (ACPI-based platform firmware uses a separate table). No
> ACPI table is needed in DeviceTree-based firmware to enumerate the mailbo=
x.
>=20
> Add a `compatible` property that the operating system can use to discover
> the mailbox. Nodes wanting to refer to the reserved memory usually define=
 a
> `memory-region` property. /cpus/cpu* nodes would want to refer to the
> mailbox, but they do not have such property defined in the DeviceTree
> specification. Moreover, it would imply that there is a memory region per
> CPU.
>=20
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---

LGTM

Reviewed-by: Dexuan Cui <decui@microsoft.com>

