Return-Path: <linux-hyperv+bounces-8904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rDXrKrA0lmkkcQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8904-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 22:52:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF715A6EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 22:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BE9E3018BC6
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90482F1FED;
	Wed, 18 Feb 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fbTe7j2m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022129.outbound.protection.outlook.com [52.101.48.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867913EBF10;
	Wed, 18 Feb 2026 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451565; cv=fail; b=D/QGP13POTQ5OFlZaHRT51fehshWdGJ6D3t6FKJI4/TCMmNwhaeUdRtspklTYoTPqVyR2N1Q9iUVg3rFNgHgt3KqeAHegV0F1yA6ur4vCR70MhEPJeIfBiR9c4psl/WKA/+yGBByMvFfwdDnN1SVwEEfSNw4xiG88Mx2RwDJ5Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451565; c=relaxed/simple;
	bh=WROu786Q2tVf5uL+piH6Wp54cOo7ik3+6gAxqxBsCTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1d1PziCeFeS0f+e6I0Vmx7ctnCPj+vV/ZBaZn6FXWObISwIgDpBXN1s6ROc8xKfMUBrrCUFZGWfCVRM65StrWO/MmBryAaAfv4yv8v+D4xFENA/4PyHWpd5jM5cwA7z3cl4x+k1xz0V80ptFv2DrzWZzMgc7Tw6XPo7nS90bHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fbTe7j2m; arc=fail smtp.client-ip=52.101.48.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOUbNzZ7xxbguBoWPkJSIpjEfze8FDfWwzBKUxtLHDRQaP+P2MwK+n+XWaUAzJBdE5UVdpfAtWxftmv7beNybRyMhTq6VI8wVLwWN5TkNw0clZgdlcjD633iUXEMiQanDkYVERlzNVKaRYRd490mXC09PPKE/5EU1LRz1nevo49ZQNfjyn6KrLYgOGnP9epk6GGEMJrTybi3V6szLflpQ0Md8Wt10zAt1+gHxRr86IQSysslONf7xokXIKP7gn7LgAxkOp6eFLa57iZI2b6rWO/tgcV1jDQskwob2qvA4uZTZuaIkajmnNlzVCFAWyEwXSqAeUKIyniSh1/mAafokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IgPS5pOW5vSMqyDph1CMIaUuXmwPa+PZ/1fcETXgYQ=;
 b=GfD7Q2fhSigvq10DjGz0G9TPRKil5XSEffC1JNikCnDvlz4kT2sIwdHWJmNuLzeR/WU4PsCCk6CaCJHW9yzCY5Q9odvohAgNVWG/pBIHQZzusjCIEHZNDEnOEm678THnsSYaxsKu/hvT6uj824dzdRLXxJAoRrsFDET3UoY1Ef2Y7xERMtJ5mPK/gmWB16U5DEnMQ2lyCXcv58o2OM0CuMfjBTVkMm6oylkVu89bnUOxbZIfUxr085FjY/Wjmz4LhSmQDsPjhPKe+eBffoy2iJR1/bGTLLhGa2oBJb79ADlvSZEJR136ppM4ozUFrFeTpV7d9QwGqOphQkBtOvx3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IgPS5pOW5vSMqyDph1CMIaUuXmwPa+PZ/1fcETXgYQ=;
 b=fbTe7j2mFx+YDqUvOi97xKlrqgxYBI4XyfYOV3dasgBSf3MyzEr/4tSWLJxbv6aLvV8OFe6skZlfmJacQ5gV+KiXaH4sU2ftGVT9yyxfL8+43HflXRNnVyLDsFJ+TRrP6Mt7SissirnQ8rto9amR1pSVxY1mRK/rRd5MifL1N7k=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB6771.namprd21.prod.outlook.com (2603:10b6:8:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Wed, 18 Feb
 2026 21:52:42 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9632.008; Wed, 18 Feb 2026
 21:52:42 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] Drivers: hv: vmbus: Simplify allocation of
 vmbus_evt
Thread-Topic: [EXTERNAL] [PATCH 1/1] Drivers: hv: vmbus: Simplify allocation
 of vmbus_evt
Thread-Index: AQHcoPg/54bI0rVR70eCRofn2ZCPf7WI/xug
Date: Wed, 18 Feb 2026 21:52:41 +0000
Message-ID:
 <DS3PR21MB5735CA49BF2A99E320D69C8ACE6AA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260218170121.1522-1-mhklkml@zohomail.com>
In-Reply-To: <20260218170121.1522-1-mhklkml@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=61aa2c9d-d7dd-4df9-8778-106152c874fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-18T21:49:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB6771:EE_
x-ms-office365-filtering-correlation-id: 074145c0-3b11-44c5-2ef9-08de6f380a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bHLLzdtPryE69hwjlSpbW0FZ79+y4eup6/M16Qvh9tZIARscMYmyeuGZRAb5?=
 =?us-ascii?Q?aPquHlkY8gXcwBywKTy1EFww74qjLyBqHQr+xgSS6BENc6S2EnAHZb95wxhD?=
 =?us-ascii?Q?Q5OfG6SkDyH89iMn5mFjOWuE4aUZdwDOgTmF/E/F4v3w42G51ZO6pReZ0oW8?=
 =?us-ascii?Q?7tAcyT0xU/35b48yY2OuKomAFlN2CAJ7BfOoF7GeDutIrzY0RS7DDRMbWwnB?=
 =?us-ascii?Q?LTxoCgNkJkobs3A8LXPcpBUJgr06FVRNHkMl4M3abWqSg04t4FS3mT4pwDPW?=
 =?us-ascii?Q?DOihHoHu7CCZaHfQQQ/6gQ102ka73HUrEKaf/AwAQdM8qEvt1R7L+qDVmzaK?=
 =?us-ascii?Q?+b8VxAOkyPqqW3xIDszswfWbdWwSPZDRu4XXbYmt2PZBBqWbn4lAR5DegIsb?=
 =?us-ascii?Q?SK6EhFx+CSu1iRQ9uULvx2BdMvB1omDNPBPdQUR/S1QEjNC1AqtW+gOJRq6w?=
 =?us-ascii?Q?WREU89wOZWOsEUjzAOQTWfZtUw2OQIUFqwAWrNPqFV/hLx5sZqzxHLOj/nyY?=
 =?us-ascii?Q?o0wyJqz1jvsENxX+l0GJdH75H1X/WOPlU4pZLeU/3KYIJAXtBkAVW97pLY07?=
 =?us-ascii?Q?e2+ip2q7YKf5fEa8DE9kyFaKsEapIq4NNE5ekIpX5Mc162YXNkg2gBDCg2iS?=
 =?us-ascii?Q?ZAbZepRLkPXNucOacQJk1RHK12Qbwz15vkw956z7P1L592dLZIkb9o0P7mC0?=
 =?us-ascii?Q?+j2ZWE6x1MDMeymJAobVlw3yHCFhWaMDcgtTAwmLg7OjL+gHbHhyVwdfGrqH?=
 =?us-ascii?Q?HPdhtq76/Hwc2YynbtBVS9B236mri0Avt6dqH6bqSRtSJl6Ey5WrX93gX3LI?=
 =?us-ascii?Q?EI/sDkW01FPIXSG+bEHlDa4f+3vqPMmmS5RVztN9aU/fgI2cLkjIIVsc/Rwc?=
 =?us-ascii?Q?3cOeS/RsQGUqwZRNpNkhlJmuQbLI/1wrhLI7ljRQqWIM/1ksr7CXGgfOYo2T?=
 =?us-ascii?Q?UcWoDjvoo05ePAu1cG8qY281ZgDMGSpf4Nxi2OfAbYBLcDKPa/aA1McbxEg4?=
 =?us-ascii?Q?VYWNXssO0x1S3IIcCi8nhNwWUoZ+ibE0ZvVbrAnhpz1+YQCNm10/12iSBu/g?=
 =?us-ascii?Q?6H/oE4jq2CpPO/6M5uHyygLQnMZhc31MJIjxQYXBHJKIzw1RRFUoL8vW2raR?=
 =?us-ascii?Q?Tt5A9vWmABbWW3iFUVyLVaVS3G7xRmn5gx4dHdxjXXnl5JKl7g19jusGTLw3?=
 =?us-ascii?Q?AG/szdZsZ5Watdrre+k15Ldgj+WtT/Q5WeaKOkavQpRM1fBipC2kB3OSfbin?=
 =?us-ascii?Q?Cz8TTQ9cp4+ppwsGlhd6ialAL5j0uG5m48qtrvW2ob4B54qZwUipW+Znq2d3?=
 =?us-ascii?Q?4LY7Z/P7+szSc/QnNfb5bUMJsrpCy+pInQhS0MFASFq43pFPsapTE2WbICwB?=
 =?us-ascii?Q?tDFubjTwtpsqZ7UfNIwD3fkTMqQBAk6aYyuFFfqXiWF/vzg5+BhKULvcB2b+?=
 =?us-ascii?Q?VcWnnvsyki9iohnNQsJmUIFcurSmgzvp+u8bjzbThxTkw9DM460ip2191Ws7?=
 =?us-ascii?Q?ZJRTj/pbo6OCny8uaGRfTLEzbu+DaL7v72BP/PWMwuOxSLwGA0fTq9ZK5o7y?=
 =?us-ascii?Q?K49hSYaddVyj7ApL/jtsRy6UWCQaKOnCpqNjLiEiytZON9ITxtelvIbyPGKA?=
 =?us-ascii?Q?Ljb7zbr97U/88e9zSVTnWuA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GlUmall5V0zub17nBKmn/grX4q2BIy6O5Q+f91bqNyGu59JJsDxNnWUg6XHy?=
 =?us-ascii?Q?KC3tjSNmNkZi/Amabw2G4SFmKd197sN1wjdwmVrNtMO5WTgUEZLJwmpngsXS?=
 =?us-ascii?Q?7MuLXVclk54F1Q+wGanFgOfVg/KE4mxJcnMrs0kDs5cPP+eHzU7lIFO0tCj1?=
 =?us-ascii?Q?ZmaczmCUPTJCXJEdj9AvXXTpJlVq16z9AZdcGEgA/vw4kJkDzMXM4Yc2LlQR?=
 =?us-ascii?Q?5GRmaa/aSMV3+87yZZtNIPtL9/Wxw/vbcK6SlO+UAYRHtb2NVPJfVoMg2BYq?=
 =?us-ascii?Q?2cPXns+u/XipobsLomYTIkjAJAfRMe+GUYasb/sb7hMDVD2G0q6GGsNjQwuV?=
 =?us-ascii?Q?29CQa/29bBYgy6b2vAM/FcpSk8gn8M0235Rtxy4SDEmYglal3Nq6rwxrNEIg?=
 =?us-ascii?Q?NQHp9eTmk9SqgppkbRQYdqDAUdx15saYXaaRDgujdUSVv+GdZm1f7xm71NIz?=
 =?us-ascii?Q?vj+N1/wKLZ8c1imeSuv1faVMhb94O7DBZAZ1UwAuudsFZNDU7HvVzUeHJLo6?=
 =?us-ascii?Q?wsMy9NA+u07cwbcLPf+vvrBiLJqh8OqdrrXApTcBMKuFanHYAuEtcrA9GwwL?=
 =?us-ascii?Q?MHAM+Zrs/Ynr+K3HQ31hbOfB8EiJhoU1su7s7uVdCPc2Py9pDmdL0/fQG0+Y?=
 =?us-ascii?Q?Wz3vW+U6lUf26aPDYT7DTVicnkWpSazVk8KTVCOfJjAlhBOJC169YCeIjU6Y?=
 =?us-ascii?Q?fMSaDfFZSI+9z1oBPnz2mFhx86JUgYxGfpD9/VQi/oR3vOayAzqvNdU9bxqw?=
 =?us-ascii?Q?sJ/JWzSk4G5BKTo9gdZr0M1yrsUcr678E30wpj5kwxYWSV9VC0+QI4N3AY+5?=
 =?us-ascii?Q?ryIW7z6P/UNjoHK07r1aIopdtpwc2aqGFeb/+cvfEYgQ/JYlv65OP9XJE3FQ?=
 =?us-ascii?Q?bK+MBPUirCN2W3fUGhmjQ5BswDtBa4XeqnUqlSM/SiDnitd5F+9A0qWNgrfC?=
 =?us-ascii?Q?721csquXA/qs3SBcZ9Ixm1q9+fx9Lu1JjlpiZrF8HIBIkX7InSFfXmeOmK1E?=
 =?us-ascii?Q?RQMUk5zSGKiAImHWyzgT0hc9t4AqxEmY5cKejSZ00a2XqKV4eVmYaUzSVM6o?=
 =?us-ascii?Q?DuYkkuImFHYZtc/ziO/+7OKiGK+lOajt4vYOFfQxKxvsbpUAQzMC22IIFLpz?=
 =?us-ascii?Q?rj1Q6K9rCfBa9awhkiq62LL27MGv5BpmkxpuG+Kg3Mjt/sAtceBukVvuj9LB?=
 =?us-ascii?Q?l7uCf1fTcvFwRFIj+L7kSGxLVY9FQLvW0dcC6ufrj0f5/ajSKrwHp7tTyUZR?=
 =?us-ascii?Q?whtTxkf3Fil+4qHABE2E/9SbItveWI1xbHhXC5GwOIBTa0ai/R4UndNTSLlc?=
 =?us-ascii?Q?FZU03hH697cBiZDdLK6ouJ/6fDcExdNSfVp9a9uigxG40Nft7Z+ZvBWESEd7?=
 =?us-ascii?Q?tEDPq8mTDdi+SDY9IDqTZdVJdi6nzjdPECNlpmTjm/OTibO24SrdBgCT8QE9?=
 =?us-ascii?Q?QIkSqZ0O7THVfoDu/4ZSOMp7n2UbBWmOUd19Lw075CO7kkMd0pJEiXzZvz5/?=
 =?us-ascii?Q?OvVeh28ZAoEQdqpmbbaRTt/vGgq1Uej3qI9NU1WQG2hVNff39mdDKumRW4Kx?=
 =?us-ascii?Q?zE20ReEBdpJSMVwR5yH1x8xePEttXw3+aX/1EXzJy8XCaExK7l+bn2ALXPV8?=
 =?us-ascii?Q?sWb3hMaxr39mVtU90TxmpA177kaLIKb6H/x/l+lt/lHTwR3nA4CUWqoD5604?=
 =?us-ascii?Q?17YkHab9zBnb2ZuKycMoN3q3XithSecBBChB4aE6eoWgflrL?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074145c0-3b11-44c5-2ef9-08de6f380a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 21:52:41.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSnPHG2dI0WzpYtR6X4YpkqVq7bHZ1OH0VDBrvkjozUlKOn2Us+oLC9wX7QrMT95TFykqaWGWAgxOImMpi4ppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8904-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 08DF715A6EB
X-Rspamd-Action: no action

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> The per-cpu variable vmbus_evt is currently dynamically allocated. It's o=
nly 8
> bytes, so just allocate it statically to simplify and save a few lines of=
 code.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/hv/vmbus_drv.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c index
> 97dfa529d250..2219ce41b384 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -51,7 +51,7 @@ static struct device  *vmbus_root_device;
>=20
>  static int hyperv_cpuhp_online;
>=20
> -static long __percpu *vmbus_evt;
> +static DEFINE_PER_CPU(long, vmbus_evt);
>=20
>  /* Values parsed from ACPI DSDT */
>  int vmbus_irq;
> @@ -1475,13 +1475,11 @@ static int vmbus_bus_init(void)
>         if (vmbus_irq =3D=3D -1) {
>                 hv_setup_vmbus_handler(vmbus_isr);
>         } else {
> -               vmbus_evt =3D alloc_percpu(long);
>                 ret =3D request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
> -                               "Hyper-V VMbus", vmbus_evt);
> +                               "Hyper-V VMbus", &vmbus_evt);
>                 if (ret) {
>                         pr_err("Can't request Hyper-V VMbus IRQ %d, Err %=
d",
>                                         vmbus_irq, ret);
> -                       free_percpu(vmbus_evt);
>                         goto err_setup;
>                 }
>         }
> @@ -1510,12 +1508,10 @@ static int vmbus_bus_init(void)
>         return 0;
>=20
>  err_connect:
> -       if (vmbus_irq =3D=3D -1) {
> +       if (vmbus_irq =3D=3D -1)
>                 hv_remove_vmbus_handler();
> -       } else {
> -               free_percpu_irq(vmbus_irq, vmbus_evt);
> -               free_percpu(vmbus_evt);
> -       }
> +       else
> +               free_percpu_irq(vmbus_irq, &vmbus_evt);
>  err_setup:
>         bus_unregister(&hv_bus);
>         return ret;
> @@ -2981,12 +2977,11 @@ static void __exit vmbus_exit(void)
>         vmbus_connection.conn_state =3D DISCONNECTED;
>         hv_stimer_global_cleanup();
>         vmbus_disconnect();
> -       if (vmbus_irq =3D=3D -1) {
> +       if (vmbus_irq =3D=3D -1)
>                 hv_remove_vmbus_handler();
> -       } else {
> -               free_percpu_irq(vmbus_irq, vmbus_evt);
> -               free_percpu(vmbus_evt);
> -       }
> +       else
> +               free_percpu_irq(vmbus_irq, &vmbus_evt);
> +
>         for_each_online_cpu(cpu) {
>                 struct hv_per_cpu_context *hv_cpu
>                         =3D per_cpu_ptr(hv_context.cpu_context, cpu);
> --
> 2.25.1


