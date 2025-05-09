Return-Path: <linux-hyperv+bounces-5446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F8AB1BE1
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC47E4A8563
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A28239E71;
	Fri,  9 May 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZyJ76Etm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021141.outbound.protection.outlook.com [52.101.129.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37323C8A1;
	Fri,  9 May 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813784; cv=fail; b=UB5+yErOUptZ2Rd2N2J9RiDa3IxTWygGfq5DSsclEV+YidknF3UCUw1EEukOSzPgCv0xGSaHoDEqds5BM4dmsMcrFHoBsTkOPQDzdLHbs+MPuClJKjDuoHv6TcgnwTmOQlmHTeDLhtJFDFkEHJG25g2sQNa8BeSVQnkaUyF2nZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813784; c=relaxed/simple;
	bh=vtAU26z9ezxDSDv4YjF5dSKkQys9ySL+sbxqRVfUV88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMCX9Nn5LaJZ4E7ls3P3n6KFN098FH9kmy27PB4X5BhTcs6N65iIevzMIJEk1M1Qf53L0SCr39MwE6W74hP/KaiNBma5Hd/Zs5TlWvtJubaTMNfe+yeX08BEZEZokRyiSFwTA7Fuew1pJFK6Etso/WUlm+q4LlNIobVzjONTQbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZyJ76Etm; arc=fail smtp.client-ip=52.101.129.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEEyLDwpgzxIpAjy0lax6H6YtiaMMxoMZ8zNiJuR5dlq6rgC7foUqUzWBUnv/uDCHL5YBfh5oQE/6OLfqLZ5mBKFKtaIdt9HxQUi4c5B25dXU/PrfSsQoYECkeGlbDDqUlLP1FCYbjGcg5M5bxwUSUKS0JtVpJ4eBNHyHzPMSCeayUoDKqDY8hjawAGHLSXICDxS7mSJ0I2PjvCjoWOiGs0QlbaTKOaVyRw0FREnfzrDbZrZ/HYAwUqRrjQoQZv/PmwVdh7lFaP9ewuhL7CSnqdxaqUUKbN02S4NN/myiNCYdJKfLOwjgxwVXYA6Mk6v7m7mCZg3GXlk9mErMrEgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfB890TzvoyQO6xWHFmz+H2/QcMh1f1+NnwEU+FGsRs=;
 b=T4b5qRuttWH0wVFBsKYzpSyNSqSmfTJfVy+9xjBLXMu/bg2q5ghk22sMDESTM7g+9i7/BdC/cSkIv55No6pO2/j39ChLdAgybe7fr5foTmxBTZ6IXoygeQB7t8ixDBo4fx7mgUisIMIxXMK0Dyn570xnIDxd4BMhsPvDAgrG68ARjRIBo+qMPvP8iM2CZ0dimIHUcimkKMB6o0CTn6OmfiGCz/rj+/e4SNKymlltLdvUTRYo5shPdcCW+Dm6IIRxpXpFOZhLFKzsfSzOpwfyvkdjGLJIK0hE4X74+BLEH/HE2fI0IAB1nu+kKCMI9hzK199TblWsXICv0FLg7xRlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfB890TzvoyQO6xWHFmz+H2/QcMh1f1+NnwEU+FGsRs=;
 b=ZyJ76EtmA8M9WkCGD8MX5ga3wLYNyxAPPPM8guQhkBq07gSRKBpr9kWUzCGBDuTN+8z/pC6M8wDHnQZg4cElnrKF9OKzO0fi4o+gI4m2RkNBQjlRh/i/DJNP4nKmT8OW3SMF0ozkQCaCZj2c32W1m54nM2yIOmxElsZbVfh7J4o=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SIAP153MB1340.APCP153.PROD.OUTLOOK.COM (2603:1096:4:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.5; Fri, 9 May
 2025 18:02:58 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Fri, 9 May 2025
 18:02:58 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPWwq1NkNsYtEq9b/XTYQeJpbPHBnSQgACG/ACAAXzIAIABkZyA
Date: Fri, 9 May 2025 18:02:57 +0000
Message-ID:
 <KUZP153MB14447CC188576D3A7376CEAABE8AA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6ff1c44-4d74-4a20-b38f-c066d6ccf37d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-09T18:00:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SIAP153MB1340:EE_
x-ms-office365-filtering-correlation-id: 01ff478e-ff96-4489-91bb-08dd8f23baad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cBI7MbrkHvK/At8tXeW/0xz6jTcrfoHh5n/qizQsQhADgIh4pmghh0SjR57j?=
 =?us-ascii?Q?V8CjVkOoAlywv7EZDpw4ElKn6F9bcIQr74UyfpcMsiTn94xfisLj4pBqiT4l?=
 =?us-ascii?Q?usep5KDt97KSZeAKftyeHvvfPbdtHyLLx0pcJHi2l1iWJOk/Jkjm6iUMooyE?=
 =?us-ascii?Q?TUelhDMHyKbl1L5aQrdFuvW3miJVJppO7qP24pBuloAaKL7cI/7xVy9cInY0?=
 =?us-ascii?Q?wZNpMU4RJejCoNCb1taH1AL/V+eU/jMsMOBpMAQe7wz9hoDl1OI+Y+FiPX7A?=
 =?us-ascii?Q?OyVeUInkFobP5P2vIy2pDkh5tTZCwboFIoeercGhxuobkP51yYouP3zIwH2t?=
 =?us-ascii?Q?78U/GebCFohnFY5dB2LnXRWNVzp7Bu0LUXhU4qTeu0tqUd6u/L+J37JPdxfl?=
 =?us-ascii?Q?gWmI+cKUlmSf5F7ls1FtffpsjK8Kzm8L6Z9Cs6oOUzd1aSrqL9nDE6NvNSTt?=
 =?us-ascii?Q?ezMADwaZ0eZNXF8FE8bxAbAjDKnQwOWimPS6Mi2FPNepUwhI0whiOKg9OFcw?=
 =?us-ascii?Q?nXUP+xXFnxQAJX1Kys7OOmDPHlybQsyTeo2FEx73T82fWCQ8LyxDhHKZtUOy?=
 =?us-ascii?Q?cbyl0sOE1zbhZUo37xhMT4S9S+L/nB8XKQI3KPi7khdzOQDoCZIHpRHM0JTZ?=
 =?us-ascii?Q?ZZ12jiLs7ohHCv5TTHkEgTQ6G/iIkU1fmK0bZ/5sqr4bUcSVHEvRdED4AKS4?=
 =?us-ascii?Q?5O4GQYHyoQu8zXGYnJawi1NdVqlnK3H8MGywo7U26g/hAkvKgRWAWoSkUqhJ?=
 =?us-ascii?Q?MmGhg5Z/BO3weEjdTJsKnt7rHhrDdjXj0nzomUsbe3ue1g0YYcW/bXUEDR/S?=
 =?us-ascii?Q?8w+Aq2HurN8fOvuNg3t2+cr2KrFkkx+nf7RESnw3vE3q8johru5xoTki34py?=
 =?us-ascii?Q?lGjlceAHMEAwv97sf5TG7Wz5UJDZRlbi756RGRREIbjuq7XauNgx5jkkopQp?=
 =?us-ascii?Q?+8j1tyFEi7gZPLJAq6Yq5N5WU8cK1+krXiQ+GD/zlKq5dUD7ODkTaQx1bd3i?=
 =?us-ascii?Q?4+BDh4TvwtLtYRXg6kZL7Y876CX6qgIu2MsR1JuiniM4X0g0K5OmgIXHaumu?=
 =?us-ascii?Q?8c5Mu2gajt0OIztJe0ZFNXL8099N8ZNR5tc0rdasoVAfiaWMZ/2uQ1t79ueO?=
 =?us-ascii?Q?9cJkS3MbeHoPJu3aFG75jXI978sZQDgxdzdYT8lx1TRLwyc9Cpvc1eD+8146?=
 =?us-ascii?Q?NLfJ0Ps7dSz6qYup48yGwZNfwyWWCXbW4hW5r80Lq4uQvsf3pEbTOMR84lNU?=
 =?us-ascii?Q?n/c0m6SqAktJC0wWrVy+iMGjU/EP1BSt/fCe2yVxar1NYbqkBPAlWd2Es4mw?=
 =?us-ascii?Q?+m2xNTfFHLPKXVH2DWUKjbBswIexGSN+VRohCb7/sBUScU+prClb8JTLL5nK?=
 =?us-ascii?Q?zISO4Y0yUhHGHZ0K56xiumMeBgwjBzDo2UvomHMMFt9dpww0QDAg/RDyXaXt?=
 =?us-ascii?Q?VO8ThCebda1xT4rFyldc41Yn4WZ6az6HLE4U8ySY1SVkjhyCryGLPQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z16ZGzOnIMJyiS0tYZywto/5+XaIugeu0pq20ZGjkz7R9CyoT/XrIu1mcQqa?=
 =?us-ascii?Q?Yjrc5obZBq4CY3jx6sCjt2ZsGwVagg4ZpIL3XN6GKllJJTz/mQPWpgTzSqiW?=
 =?us-ascii?Q?5mkV3B3dwi+YS8AE2ADUYTqwcsBYTY3Cm1w8a/9ouMpmFd3o6I8R67qMkXO4?=
 =?us-ascii?Q?6Pv9DFkKytcYyIPLN/GtPY7N90vcyOHqgdq/gAfE0WJDCcmvE20+BhGZp7ne?=
 =?us-ascii?Q?7Nwl3u9ivlPlItNGda7c8MvcI1qGbBzkSWqOUMXMgvJQhkCGDrbejJ+uCyng?=
 =?us-ascii?Q?k0p2jXRYM1Y6oy8R7errQeGNW6oyjcPRr4Vw7WYj3wNByp7785GIn51YgEB4?=
 =?us-ascii?Q?5qhV+WCdKbPVQAwVrWcADM9aZZOgvlbN0zqPrzDKoccUsSYXYBBDehSHCUwa?=
 =?us-ascii?Q?7OATsyarw9NQ92nI8AP+1AAnyDD2svo7mhBOwtyInQujqKTikR1C8hsWNPlo?=
 =?us-ascii?Q?ZfmFpbsbm9ZtgmbcBvCq426ZWnTauJe8KPKlgdWn8IQALVMEe1CPykwylPlO?=
 =?us-ascii?Q?gZecnGoMlMGCN4Oce0IeQzzdTa4Nu7lv5au6F3SgGF0SDhKZT+tjGVs9o4Is?=
 =?us-ascii?Q?3UGvrTCKz0hkuOXdA0PjPy3u8t92lzir/T0A83F6CaLVe3UEzolwWS7BWIaf?=
 =?us-ascii?Q?EgLHbgFatRftK2GIa3C9khi2sNxLb69GKozDrXm+V+mi1DcDivdOCKnjxYzh?=
 =?us-ascii?Q?t3awUiWjEGUiDw5b+2MsX/GrZvyhtYyzuzMv8zNQdKn+/pf5eFtD8cjCRPVs?=
 =?us-ascii?Q?w6LE50rlFbhqTFaGxlhcma0gtYQlf4IsVh9BuZCWCzU9LzjMrPzNCpADRn3N?=
 =?us-ascii?Q?T9LRurAy8ABuNOoctuOYvwi8ZkWHkISH2nUH73k55HQPfH80rIed+oeD0JdX?=
 =?us-ascii?Q?jx3L/umX0rx5x1/7f1Dsvd04znR9uB4xcrFRM0S1wF5SoRGh5/HTNCjxX0rb?=
 =?us-ascii?Q?nfHjsxC0Te9ahAMWGfjX2RGFF/T6J423tK2KtKYhsMsxk46MAQrjdE9/RaRm?=
 =?us-ascii?Q?//Hz+OuF6G6A/w/UUaJsugynNk0Nn3f+7kT9p0ZKCqFGth53p+cbnTR3neTF?=
 =?us-ascii?Q?8t1B7SfxXPmd8HP2syPgxIkWVtZtENbW42O9ue0tXY4dcpnEMk/qYWnPmvHp?=
 =?us-ascii?Q?vR850DDWyYWVeBhzRfrLhshXG7iUn8AXBa9uvfuwv2DoUacGVswT0lPy4i0z?=
 =?us-ascii?Q?RmZ/BgoFteJ+KxHVytfMgSPZg01ZGpVXFLl3kDxz+1ECCg2lCRebNuk/fGhe?=
 =?us-ascii?Q?O8osezc75MD8jqu2KEYVbAQUQKNtJdWB9ZmJeODUVZ6URiv5IX3l+xKDrqgu?=
 =?us-ascii?Q?WrFKRaG6O5wHQqbAtkHVL305mvJvPpYn5cQLbueeuRPF65Sym5sNikBmRVAX?=
 =?us-ascii?Q?IXsqVG2jUJMBJOy8kiTkKcIoXb/NIyr+Brb3rznsKJUbjUhHejbDTZL7Ch6q?=
 =?us-ascii?Q?r0jxVexzUVceHww+ViuwmIovaHuTAQBMRY5QmOL/574DPOjBr7Cg75+3dObv?=
 =?us-ascii?Q?YNa7tjAPGYnonfcWaLTylB7JvDnN+c7Bmi/HHEqdEkVD+h9LN20UEnpCutMi?=
 =?us-ascii?Q?kRT1KY5Z1pCXvUFvyGtFMzRRzdijd4L9/Wjwq9jY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff478e-ff96-4489-91bb-08dd8f23baad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 18:02:57.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHAIvM9nJFf6BA77C6Rqc1h9i0FuIOmShfxDmVSmNHROukv5xjxTKaYAaWusumjy/CYsBHvi/HRc4ERc3C4AGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SIAP153MB1340



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: 08 May 2025 23:33
> To: Roman Kisel <romank@linux.microsoft.com>
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; Naman Jain
> <namjain@linux.microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Anirudh Rayabharam
> <anrayabh@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Stanislav Kinsburskii
> <skinsburskii@linux.microsoft.com>; Nuno Das Neves
> <nunodasneves@linux.microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
>=20
> On Wed, May 07, 2025 at 12:20:36PM -0700, Roman Kisel wrote:
> >
> >
> > On 5/7/2025 6:02 AM, Saurabh Singh Sengar wrote:
> > >
> > [..]
> >
> > > > +	}
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > > +	out =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > > +
> > > > +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
> > > > hvcall.input_size)) {
> > >
> > > Here is an issue related to usage of user copy functions when interru=
pt are
> disabled.
> > > It was reported by Michael K here:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > thub.com%2Fmicrosoft%2FOHCL-Linux-
> Kernel%2Fissues%2F33&data=3D05%7C02%
> > >
> 7Cssengar%40microsoft.com%7C3a21fc17545e4bafb86e08dd8e5aa427%7C72
> f98
> > >
> 8bf86f141af91ab2d7cd011db47%7C1%7C0%7C638823242185564641%7CUnk
> nown%7
> > >
> CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ
> XaW4
> > >
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DpdQ90a
> aKZsy
> > > 67qkPZkV4BfpwM6cM6scUbTeH9lT7s6s%3D&reserved=3D0
> >
> > From the practical point of view, that memory will be touched by the
> > user mode by virtue of Rust requiring initialization so the a possible
> > page fault would be resolved before the IOCTL. OpenHCL runs without
> > swap so the the memory will not be paged out to require page faults to
> > be brought in back.
> >
> > I do agree that might be turned into a footgun by the user land if
> > they malloc a page w/o prefaulting (so it's just a VA range, not
> > backed with the physical page), and then send its address straight
> > over here right after w/o writing any data to it. Perhaps likelier
> > with the output data. Anyway, yes, relying on the user land doing sane
> > things isn't the best approach to the kernel programming.
>=20
> Yep. We don't rely on user land software doing sane things to maintain
> correctness in kernel, so this needs to be fixed.
>=20
> Thanks,
> Wei.


How about fixing this for normal x86 for now and put a TODO for CVM to be f=
ixed later, when we bring in CVM support ?

Regards,
Saurabh

