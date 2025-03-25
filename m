Return-Path: <linux-hyperv+bounces-4704-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427E4A70B77
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3B167BBE
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E04261581;
	Tue, 25 Mar 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MuNmNpdW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023136.outbound.protection.outlook.com [52.101.44.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE91A0BF8;
	Tue, 25 Mar 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934520; cv=fail; b=e268aQortrOqgTK3Avj+fom0xopcX5IRhkTwjO4uQmkK9QyvDfe4NXPIUsQxHKn46Ll+qGuCjMZtQUXef4OxmE9o34XPFW73NRMOKp74WTVHPU3d1Q0udBuFSSpdPpIquGdl3f64P4I+fcpRofmu+3tdqhvgMEYUbsapLLLRIuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934520; c=relaxed/simple;
	bh=CBHg9WFqHp/R/csgFKeGFKujmmMqCL/sGcqyT19Mf68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWJBQKFjahHuz7e/Wt4CvBJrQeBm21kmi6I6W3PMtGoZpg5A81PLF5DO2s0m1AvQR4SChEtC16Y0ppaGITQQmZgUSDGZhFFr9ksnDeoyaCvDKyYDgQitrisUpShz+7unU3MEoTaHKogpMHT4fcPxHKtR32lzXixBE9dAfzqk7Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MuNmNpdW; arc=fail smtp.client-ip=52.101.44.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1qz0CYywOqSZkk+AXIafaUsijISwRtWBbmN1OWz5Iy6JIwNk7FNX4aZZTe7yhfCrF0JdrN08A34cIp8GV3OD0REHumoPE/HTSmF+TVdOSKcv97Koqh3mahn2uPP7DH2VXFUClu18itkCauykaaAhKFE6/y6M6Hu2ckK5eg1AV+wrFgftUY+GIX3tw64qd3dJAadTdktHpzn6iNjk2CC2hBb/J8vjTBvCnugZUpmMR3N0t6DzqAk8AmL5nOef2mcPWM/0EF9m06RBHWxhp5ggbwi5ft500YCImTgxUa2H9NjbztIt6cDKCAmI6fT9WROcXIrAhtEWtbYq9Prqodu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBHg9WFqHp/R/csgFKeGFKujmmMqCL/sGcqyT19Mf68=;
 b=rn5ofkqsA6Cgij84CVc3ProdwRfwlIaf/9G4HvbGoKHw5n+7coIY3fll3CJeZ4N9VIbWpqzBkOvLd64rRxdK8QX4OBIFP5ZppTfuGFEPJp9LE01TW/e9x6R6/Lxy+R/YNS3mP5W17ptjfzu8mFI+dYn5zOHryaKjeq/UrW0nA/KEuvzQpgRoikQQxdWBhGITNsHeMqHuCOwjBdGO+w7Ckr0NlY72j+uaEPg8xYZTcscDrw5JtaHvrIojrt1xPtE8M602UvMUUMVm92IO9RNDV7gsiAH3LWyFu5l7nDoqt+4hgk1YRff0ZXaPo7H8gQe1jQQK7+98h6C+nrxc17SWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBHg9WFqHp/R/csgFKeGFKujmmMqCL/sGcqyT19Mf68=;
 b=MuNmNpdWoc2HZ8lnq/1yLL3M7cpEYYfdFLhXYhZUInnqjA1TwTFc/0WgprvSzGp/XBI+7L5MzIcdki16J41eJTHCmz/HTKHMLpqOv2bL/AJXDQCr743UW0VMWqSKioGwxDCV0C0FNDx0eZq2PTqNa9Pg3NoaerYYkCQaSt3rHg4=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL6PEPF0002E785.namprd21.prod.outlook.com (2603:10b6:20f:fc04::c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.24; Tue, 25 Mar
 2025 20:28:35 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8583.023; Tue, 25 Mar 2025
 20:28:35 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
	"surenb@google.com" <surenb@google.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "erick.archer@outlook.com"
	<erick.archer@outlook.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Thread-Topic: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Thread-Index: AQHbnai9kkA9WGlPSUyCoOvnIZFl4rOEIhUAgAAY2ICAAAdYwIAAAxUAgAAHb3A=
Date: Tue, 25 Mar 2025 20:28:35 +0000
Message-ID:
 <MN0PR21MB34376199FAFAE4901EF18E75CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
In-Reply-To: <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b36c230-8568-4ad1-9510-e2f5ccdd9c22;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T20:25:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL6PEPF0002E785:EE_
x-ms-office365-filtering-correlation-id: 0c4630c7-ffd3-49a0-f7c4-08dd6bdb9e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FBKZGEhAt0yDV8TRF+2LoOdpDlHD+XjMQw/kPg9hzpiGl/arp3GfEFipIm1X?=
 =?us-ascii?Q?F97Ib4OvEFzTMCkHmE2zs5ksaXw4p3xtTzXv7y/mWJ0aQVVB3ssVR+oeJotM?=
 =?us-ascii?Q?8J1gl4WnCB7wgke+elm9DI8RpNNJHa8ZDLPV0kQbs9MITULojjWO1dn1b8WM?=
 =?us-ascii?Q?kryGcO6NInKRmECU0Z4INTSvZPFHkErcxf6C1cBDf6bNRawYrWH0G7bN3w1a?=
 =?us-ascii?Q?CjazmGKxU+65uTaDdirMhIcV9u49ru17wTuhkZ4Z9u2kS7+oOrwPiGmJcVz1?=
 =?us-ascii?Q?FD+F+FZ07DtciuNhhEUdZ/feu2vjne6u30XI+rath0Ico9L+mklrEctz/VeR?=
 =?us-ascii?Q?X3lJ2ty4JjsKwLlHgJDOC8wuRxKS1cs8/2c23DkY6igVriGH7y41vQnAzzsB?=
 =?us-ascii?Q?KRE1sdLtR8sBx17TsUGOVywrTXbN37kjzm8Ro5HOKJH3KoaGdh0B+6Luc5ew?=
 =?us-ascii?Q?gbFDX4/njAdVW47Kd2bxAb8pBmJJyBb+cTALfkexsn1jobSuJOEcDlKzx1po?=
 =?us-ascii?Q?hFq0U8TNC/k1tgHVXYBF5CvjCl/aIv3PDiFagoYTZ9pCGY39YhjyiZxszt4M?=
 =?us-ascii?Q?pRQ0HLRtcGPhTH1voj16VvXbXNJ4IRx2RN4lzIY2ePm9ZIjuqX2zHqrm2Z1w?=
 =?us-ascii?Q?zSXGRmEt2vDrni16HxVQeuOC4JcZOu1z2s0WGUvASJITDD1lLZCUayOKQsEM?=
 =?us-ascii?Q?IF0dKRUpx1yCBhpHU5SC9Wt+LphE+TzpY0OC6DjzYi1Ioz2FWXI4NCDNl86L?=
 =?us-ascii?Q?JXtLcXYBfIwZDBsz8wO+XZolMairSvRo4hnmRT93Unf46bfM+Fgm4uBZdnhU?=
 =?us-ascii?Q?9yXve+IwfABQq2Y1m/Lvch47uh8Uf2jldsoZAwLtndDUZu6mYBOSDdi4tEn0?=
 =?us-ascii?Q?XpAD6ngKXqAxGS/Dk//0o57yK0tdu2Gp8btQr5K4YSKxorArQqz8oHtEca+n?=
 =?us-ascii?Q?SQpBmRfNQHue2EA6WW/PqA5hj6b1m+fm8DknNXLHDG2XudILlEZ6NZ4qBxgo?=
 =?us-ascii?Q?GMBYMJBWiLbF89y7+7R230ShBg4fNa917LJUsALoBqzg4an8ZrwcJaEqaUwg?=
 =?us-ascii?Q?gnRAr0UhYVBJsQdxFqhGTOUFUudBI9KJuxQvVCj9euKtwHV1+BSm4APxuyZ3?=
 =?us-ascii?Q?vDoIevSPkjgW4FjXbgISSsCKzfEsck0PKejTx+SgLCvt6f+GLfiWASNIpfKc?=
 =?us-ascii?Q?5UZh/d4GmFAI9NQ4XMX5AEd6bsEJ42FkoFxHqKobpPbLOKIGIjcHwuhgXXqt?=
 =?us-ascii?Q?ozkfHtgTtkhP9dKL0QLXTyHF6rwVPKGyvtqG0jpQ44qPY6lnDascH0NSW4Dl?=
 =?us-ascii?Q?zYk8pQ79ZOFJOgOd93Re9aZa4B7b6FBnISTqsX9MugyXp3HU48btRAGYtIes?=
 =?us-ascii?Q?ioBFvB9f4FwRfakDmbRf00Y5yrxIGUcBsop6BQPLsd+2HYN3PlElhxPjXeaU?=
 =?us-ascii?Q?DzIcday4eHOv/Y6knecWywPAiuifCJ7AMra87S6WQrmtJcIcZajYuoe7qPLG?=
 =?us-ascii?Q?BKQl07FZH1q/Hfs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwWKPD4prEwJtqQL4QS8cHsOg5r8i4Jx2aCHtLl5TsXm/2Ta+UBZUMBm4Q0P?=
 =?us-ascii?Q?uXesdVKKb1urvyM7jWtkfhPdU1+RPqxl+DRTbrFTKIrXBtPjRyWtV7OZ6Mn5?=
 =?us-ascii?Q?HYJpqOb19vCA07XafXLk+PL2VYuy++x/UmKASfAWhWMBEb5g2VC8AaexYVH8?=
 =?us-ascii?Q?MVlZ92DgirB5fGXG5x/uIGb+cKj/2EROxB5HLoGB2HYI4QnPTVx9i4TNTLyR?=
 =?us-ascii?Q?DB4JhshIJqwfpW/EejrcGtP2athw9yVlnZIhK3NUxJOkE9K4nIUi6If5BYmf?=
 =?us-ascii?Q?x4WPUqB0W2oDFB6WMiyWt3Rz4RozgUx7sQDkz8PhE1ongg8jEDiOYfbjVc2D?=
 =?us-ascii?Q?BLWZ6bIC+rLmLA4GtmRDKUocUd55Ok+wnXwoCBUJg/RjQnUIxJfet4D+liQY?=
 =?us-ascii?Q?ToiW+LZZ0fdWqJ2WReCWohQ34K7YzqQsNq0bnRUos/MhnuOU3vnYnUYqBesI?=
 =?us-ascii?Q?wIfUOD3RwQBN/PyF7BWObUwQOS0MpRH2Xj2C3NZWjuiX7EVyXAdg6f8G2s2Y?=
 =?us-ascii?Q?+SFfAhF/2rtVzSuEaGnWYJVJHPeHquIItAco9oDkdj7HhOd8huS9Y4VLlb6J?=
 =?us-ascii?Q?EoJcrvkd1PsNMpXxMXk71wF+/p1s4GIPrV9S2JNSATvIOrxJrPm/bEnUwBIH?=
 =?us-ascii?Q?sUH7NcxFm8Qz5H0KR2YQtl4oc/fJZLTxTjNPk9wbwqnJTk8ujZG3O1Fkyx3m?=
 =?us-ascii?Q?wdAUSY3yHAY8aY5Arb6/ImvFFFRNvxn5L6HaxgdYnNf/KkTZW/SmZHHIf4Qk?=
 =?us-ascii?Q?F6gEEcyCVeFMXxtiar6Do9mgOGDOZQsM5GJWurn41/8hcLImA0oIRv/GcSMU?=
 =?us-ascii?Q?kmyPSn33gvAU3CnJhL+I24iAGy8vqZg5x5WUZcAvWcjpfn5LgU6mGXHIf29D?=
 =?us-ascii?Q?hzOeE5l9WTXcdVdvBWSz8urw43BSVej1hXApFBo6lJqglyeP0Ung/L+rJY9Y?=
 =?us-ascii?Q?vElja5WPM1DEuY0Q+iq06GBYOPQ2XBOMXeGC39fLsdu+7ggPqYKwuMKWnm5D?=
 =?us-ascii?Q?YJdrfgfNFR7IGqOSjM92uXdpiQunVm5VZjRs5EUq/qtcq7REmWu00SN27yaN?=
 =?us-ascii?Q?poeD4/stjQYFTW45QDJRiwn2Ck25c3YCWGBUd0GjCMk3qchuYhfF6t557oFY?=
 =?us-ascii?Q?NpkBRT+MNwYpBUUchI5RCTPZ+9mlDmjpRHl2TT3GCuipZ6q/v4jAw7ar6/yu?=
 =?us-ascii?Q?HYV/9sV6iIc3OiXD0CqsiauIrvFfb6SyOtacELVAOj46vTDDzt8v2kc4d6lS?=
 =?us-ascii?Q?VVa/pjg7NgaVwo1WPrgEt+jfQdb/Bb/etWN6gU966eXIq4PXfQ+38j3VNzBO?=
 =?us-ascii?Q?C6O8vYXUFHnRQBEe07CWRR+lR7ko5eVEZWidfOXYoR/8Km2t4cvvsI3aGHFU?=
 =?us-ascii?Q?Xe5NvMY5CUss2ORkqQDirrvjGavYD2D1xc2IyA5HwKsIdei+0wRxZM0kC5OM?=
 =?us-ascii?Q?Km/n/jlu2gb5ylsdXZyD5H5ZWqQxhydsxQB0W03DKwzuWfGD87x1OjDVeyJn?=
 =?us-ascii?Q?sTYYKCAgC08br8ZCnjKnzSArBckSyadvjM9CYZVPrenFuGNM4dfKoYhuO4ie?=
 =?us-ascii?Q?r4Elux4S+KcGBbMkRW4SVOHi7oKKA23dcb9pA9kl?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4630c7-ffd3-49a0-f7c4-08dd6bdb9e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 20:28:35.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsn9MpCFBhd6P5+BDELUim8VAb24DmhaXkVUwVkfSgcw3pN0SuKrNvgSjerrKo7o+JREpHjoGSLibHPyMF+SiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL6PEPF0002E785



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, March 25, 2025 3:59 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org; brett.creeley@amd.com;
> surenb@google.com; schakrabarti@linux.microsoft.com;
> kent.overstreet@linux.dev; shradhagupta@linux.microsoft.com;
> erick.archer@outlook.com; rosenp@gmail.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
> set_link_ksettings in ethtool for speed
>=20
> > This patch is just to support the ethtool option for the speed.
> > And seems there is no option on ethtool to reset NIC to the default
> > speed?
>=20
> There is no such thing as default speed. Speed is either:
>=20
> 1) Negotiated with the link partner, picking the highest speed link
> modes both partners support
>=20
> 2) Forced to a specific speed, based on one of the link modes the
> interfaces supports.
>=20
> Since you don't have link modes, you are abusing the API. You should
> choose a different API which actually fits what you are doing,
> configuring a leaky bucket shaper.
>=20

Could you please point us to the interface struct, callback function
names, and/or docs you are suggesting us to use?

Thanks,
- Haiyang


