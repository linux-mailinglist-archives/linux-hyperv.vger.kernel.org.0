Return-Path: <linux-hyperv+bounces-8729-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFRfJ+ulhGmI3wMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8729-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 15:15:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26EF3D7E
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5698330160D1
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2313EDAC9;
	Thu,  5 Feb 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gLhUcKvR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9E35E54D;
	Thu,  5 Feb 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300745; cv=fail; b=LU3wsolOaSGzdycLomt3ibrzoUcWQcPGKCexHevvFBUw5ofZe8rFVNhFsqEyxap+Sz1S0ho2WspZAMotanzVAu9HZ9no8Oir1RPkDVHwk8AZfBkubmDM75vvsvSPOqZ+6DcpCf1tWjQhI7E0PXGFCV3NKtEy7JkpUQ3Q0tyXDu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300745; c=relaxed/simple;
	bh=qtRAQzNvVKmJ0pexXsrlMDFQnVkzSgs0n14kcYhwSFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WkrVzwV62Lv24QArlXnBEyJ9JzN3sMc8dkobqhMwWviRiVBxWUj0pyxyPa3l1UvrQFMuniH1JAwQ0VCpqPWlace6CjvTDyOfzu0weklPTtjRoGaE1QS8TXG2DTS/JX6GLEZoWjDMOjajr6zXFaQmfp3LQfvr+pX4Pb88do2TOZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gLhUcKvR; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA2GOdb4yL5ltqyAkm/vLLRz9llU+/sBX3BINCNz5hvo6GNuU2e92kHuYndkaXDCoCx0j3lH+qdNhRWqkU4eifpLcbwKaz3n6SBbG+jmJyn8WAq9Tt4l25G5Fk3zWKl4KrfF5T+DsiNhL8JwrPpb0V8nX++Dd/N3HcycIlMU1QBf13wHSKbEe3/D81ff3oyjBbJlVjO+XmgXDZH+YWIq9ahOvgiBSt8oCKJmutIH4zAVSn/gxSVvwT/BtiKLZe5PwBt506Dj8i+JudBZ0AKkKmtaOCU9axBUeycLbvWd5MBqFzulVBVNA2/6u2jnltVd9pexuBypAOuEeEmjtxz8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtRAQzNvVKmJ0pexXsrlMDFQnVkzSgs0n14kcYhwSFM=;
 b=qwCjD8rusmFYB1zB4cYS/qgxcRhl5d8ntmlwtzj179ahGRIzafJfvz1fh6EMqgdkzQ5HoxEKJQBGEzkknR9ryL6IrZxNL4a7PJxbKl/BBAaqtCIreQovOIA0FyCouo8oLbnm8qC4SnGdv8/6wFG3IgyhVYAL/btKB79/2VPxSgP2cxLW9YhPNWD/GQOnSDUBvq3ZIpzrAdSGhgryxYuxQDE/Bdk0dWHgcBn1in0d+vDyxSJjULBYi08Z46yvWWqrcQ5Wd+9p9VdrxDqUXPyHjhTmqsa04JA5Kox0E6/JoM9mRRhe9l/InTLYTfzzlnZc6hlIg7leyO5ZIPGjK2Nybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtRAQzNvVKmJ0pexXsrlMDFQnVkzSgs0n14kcYhwSFM=;
 b=gLhUcKvRAj87z2Yh2qDDMBp4dPwVW8vFXky97ng5pYMPzxVGJFWBGE92S1jIhU1/TKLafmDmzSTWHf6Bmr1hOhzsX80V9qdVlOcEVvC6WS2efwqpX61YvXmCHs91IEdWDLqCxGc4pmcCiC8RE6wR/+mgWB42jr3biGOgjgbyEij3tqRYgfGW2B9vvef+2Ih2eQi0yOJ62Fox9Se8iw66EEktWV84O069EE6PSHwRK8Zp58vehTA2+030blc9OfnC2gMZhka3dcxhpSJd6XeYrddBAMF4Ou2uSIvV5zzB9J9VoWIakSNBAsNX2zs6rCRx9mRku0Swniv2KkM4Inyvng==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI0PR10MB9252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 14:12:21 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 14:12:21 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "bp@alien8.de" <bp@alien8.de>, "longli@microsoft.com"
	<longli@microsoft.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Topic: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Index: AQHclSZfUjFXccByLk218LNAy+7FN7V0KJQA
Date: Thu, 5 Feb 2026 14:12:21 +0000
Message-ID: <95fbade0e6e304c207f1a4906fc8f3475eb8785a.camel@siemens.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
In-Reply-To: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.2 (3.58.2-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|VI0PR10MB9252:EE_
x-ms-office365-filtering-correlation-id: 154c800d-d86f-433e-359e-08de64c09401
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkpWUUQ0dHg0V1hDTDJCZDkwYVlWK0tSaGZPYUlwblZUeUlWZVVmLzNHeFhB?=
 =?utf-8?B?YUticWg0dzlZUXlkY204ZmlpT2xNQ0VhbFlhMmZRVkhnUnk5Q0FvRVhIRk9r?=
 =?utf-8?B?anlYSGtaSXhGdHBOZ0xhY1MwQWdMUndhRjBjcm90RUxyWWtvR1JoNHl5ZWFt?=
 =?utf-8?B?ZlMvWWRCNmJtdkcxalNXaklqTUxWN3F2M3RkWGpvV1FnWWs2U2pxSGJGRlEv?=
 =?utf-8?B?Y2VzeTR4VXl0aEZmVmR2MmJ1UXB3aEs0aExySVhvcVhkWGlCUi90YUVabUNQ?=
 =?utf-8?B?czJheEt3Yk5UTXcvTG10RUZjKzNwMW5XRzZQSFluR1VuTDljY0VycUJPeEVF?=
 =?utf-8?B?ZFA4TWZpaHlzbUdFckI3KzBSbklreVhKRm82cHYzTkNRcmlVNHhUd3R3YUxX?=
 =?utf-8?B?cmRZUTZUbkJJd2xqaGJsME1XR1pwc05aYXZSNDAyUHZNbjhSZ0dFT3R6TmZG?=
 =?utf-8?B?WGo3aWJBVWRsaVRybW1GTGhLbWI2T1Z0WjcybnF1YUljUFp0OUx2NjlIbE9q?=
 =?utf-8?B?eVZ1MktKalp1YXZ1ejh5MmVUYW9jM1g2R2kyOHNMeDdOTDdXMFZNOUJXbWRh?=
 =?utf-8?B?NmJRSkhiU1EwbEhoYlBWMDltVjV6MUNhOXpCci8zZURrS1pGWk1aOTRkbW5x?=
 =?utf-8?B?QnhXcW85VGpQbGNXN0hEaDdpTlJZQUJrTldqNERyenhyTHRJL3ZnOVd4VlZv?=
 =?utf-8?B?eFFZcjZOSEZidTNYTWJlcFdIWk93R05XMzJYOVYvM09JaDFhL1lZOWM4YVVu?=
 =?utf-8?B?aExuZEIyemk3L25ZK2daaTBjNEo1OGNPNUM5UkhRdHYzNW41SHdPOFZaSVg2?=
 =?utf-8?B?anEvdUlnUmdQdG9UekV0TlRpclVOeDd1bTlJVytsYU1CSStzcTdsdHFzYXhN?=
 =?utf-8?B?NW5XQzIzZVhuRzJoN1JCaTEzTXh1TEFRTnkwNXpETWh3a005V3JZQTZQZlFX?=
 =?utf-8?B?bDJQR1hnSWtvK3ZPOTE5MGVpWEY1Z1pnNmZqZDRwd1N3dm15cDV0SVBZNTRP?=
 =?utf-8?B?Y21OYmYvQXZyUnVLN0R5R2xJdk1JQlVGWFdSditXZXQyYS9YeVdoOElyOFEv?=
 =?utf-8?B?dVBoc01jMGNBeTJNY1lBQTJMY0RoWjRJTVUxOG1FSldUdU94WlpMbnFncGRH?=
 =?utf-8?B?MDRuSm9wZUR1S090U0NhR3hWa05lU2Jsc0hIK3VHNkJxUS9VVzNkKzgyRDNu?=
 =?utf-8?B?bUpsaStJOTVadmFBNVV3WFVhNENwcWRia1JmbytIb1E5ZnhXY3Z1Q0NvN2NO?=
 =?utf-8?B?dk9pT2RjUXVVMW5ibloweFQ1MUc1dGZoemNCMm94QWZwVldHTzVPTXhaTmh3?=
 =?utf-8?B?R0JhUmlKNVZDaytHd0RTT3JYOFY0VUp1OGtOMnF2aWx0RGRRRHl1SktXY2h3?=
 =?utf-8?B?cTNYRzM4anpQaXBEclpwVUNCRFpHbVBtOXFjMDhaeWhBdE9PeWNkeENvNjlq?=
 =?utf-8?B?YkRJNmY2U3Y2WitORXpONGhxSC9xYzl4bVFua3IzVkpmUmxYK0FhMXVyc2Zk?=
 =?utf-8?B?YjRCeVVTN01ENG1GY1FYRjRZaG1jazZkT01yRzhzY2dFbWc3OUhCVzh2eGE4?=
 =?utf-8?B?Z1ZzYSsvQmZjVEpiY1g1NExBcEVTUGozTzRPdnEyWFkweFJMZlpyd09KaDl5?=
 =?utf-8?B?TUtvT1hKdHlPK2pSd3J3UXUvTWxnUldrU0cxQ0FOMm91WGlkMlFIeER6QjEy?=
 =?utf-8?B?bFFYbG5BVHBkYmhKUmJyRWVMQ3BvbXhiSnZIRndqMUV2ci9Lc1RndG42cUZi?=
 =?utf-8?B?MTNBYU1jbFB4T1c4bytQczRwbWRuMDI4K210eGpOdXVrOUUyM0Y0YUwrbE1K?=
 =?utf-8?B?WHFBZk9LWnBjSDBXb1dCRU1ObzgwMDZYS0lHcHVWYVJ0RHRHZmtLT1cyQmdC?=
 =?utf-8?B?bEtnNWw1TWlpYURoa3BGVXJBY0FhMkNrOVU4dnJOVDMwYzFxdU9NdytXdW1a?=
 =?utf-8?B?UVV2bmlKbEpLc1FGbkkxNktGTVBHZnViaC9NeGhySytsdWEybTMyaUFUVzhj?=
 =?utf-8?B?M29PWFFFRXVOVUJ4SUdzdjhRWHd1SnFGdHRoRW4xeFZDdGpNMTN4OU5nN2lu?=
 =?utf-8?B?OFZEaXUwLytpMEZRYVFQUFpMcWJ6VEcvOHZMRGovcFEyb2R3Z1ZWU2t5N3h6?=
 =?utf-8?B?ZTl1TGNMV3dURUhWdzJ3cEx6eHlIUVhwOWw5SERSMXhNMXc4cW9sdHd4L1pR?=
 =?utf-8?Q?DsLWSzPSYL2JmOo/l/7lokvtYjjyojEIHx8FKKP+U91i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wmkxd1FGUTlKcGNudUl0QnNadGd3b3ZqcTJ1VHFmOGdjNVloMUVueWdPdVU4?=
 =?utf-8?B?UDA2d1g2UHJjQUN1UW1nUUVFZkFHTzBoQmZlM1RnbFNxZ0ppcFRETnlwaytH?=
 =?utf-8?B?Y1k0ZENPOEpUQU5vTzFKeEROVktKU3lJMHRSQ3ZqYzUrdVVocUFBazduL1I3?=
 =?utf-8?B?bkNwK1BEMjhsanYwVWRtbDRBVVMxZmVUS2dJTlB5bkpOTFRlNUJZNHgrS2ZW?=
 =?utf-8?B?SHRWTURJek01OHYvRnMvMzJaUVVCTzNQVVBtZXZRS1MwSERwUnIxVHF4bEtI?=
 =?utf-8?B?QnlwZTNQM3F4akR6bVVPb1BiQkRpS2FOUHNwbnZvWS96TytKMzh3SDQwOHhM?=
 =?utf-8?B?Z0VsdTNEMVNWSWFuSXFPZEw4SkIrTXpNTm83cWN1VjVBOWdsRnZvMEpQWDd6?=
 =?utf-8?B?bzU2TkJDcUlxY0hLWmV6Nmw4RmhkR1ZRVWxpWFZVYWtFaEVXditoMnh4NVFs?=
 =?utf-8?B?WkdSYVg0ZWZxVTQ4TGM3cU0zdU50Zk9aVnY2bDNyNERHQk1PV3pjTE1Pc3NY?=
 =?utf-8?B?QUgydXg5TzFWMGhMMDUvaG1rbjE4cUYvUVZDb0RiMmhwTjZTL2NMYVlCWGFj?=
 =?utf-8?B?UU1xcXF2WDg4TXAvdkwzK2h3MWpkdlladDdJTU0zcjA3aGxtcldFV3cyQ3Qr?=
 =?utf-8?B?ME5rL3llc0txMjZOVUtObi9HMGRLNmFDdlBUNXQyZzMwMW84M0NWQzdhNlAw?=
 =?utf-8?B?VFV6Qk56cks5NkFnU3hiVi94NTU3OFQwY3Z0NU5tMDRENUFPcTlOTFhsY3Rk?=
 =?utf-8?B?S2MyWGRhaGUzRGNPZndWS0cxTEl0MzVSUG1qeWRadlNFc0ZRcXJXdUJ4cFNu?=
 =?utf-8?B?bEdhZzE4aDIrSnNyUWh6NnFoOTlYTUxXUkliMU1mcTVzckY2MmtPNzhySUx6?=
 =?utf-8?B?ZFlxQlhGSU9HRW9wNUJyUXFDeXpzNEhhUDJlRlQwUFkvY2RsWmkzdmo2WGx2?=
 =?utf-8?B?SnNPYmJyZGVnZm5qNkNCNmFxM2thbWlReGFDYXNoMVE2M0g0SU9ENVVDU2Js?=
 =?utf-8?B?NXFId0w1YytKdTF0OVZMc1JWZURYWVZvNFlVMmlqV1JQQWMwejNvRW9aNzNp?=
 =?utf-8?B?L2RQdjhSRFRZSk0xYm9HdWhUL2E1RThSa3VCVHdaTzhxYmJKQzI4RXZOdzFN?=
 =?utf-8?B?MldUbjdFZElRNHFIZnc3ZENXYUNOazVQNDZOL1ZPVzdSeDJqNE9rVEdMckVG?=
 =?utf-8?B?OXFwQ3FWUUs1RGp2VEhhekkvd3BSdXhsT3lRYjZVeHhBQmFkZzhBRVk1VFNG?=
 =?utf-8?B?Y0g2UC9MdGtvd0RkcTRUYzVNTDhaTlhPay9hUU9qQjJ0SnpwaFU5RUMzcDdZ?=
 =?utf-8?B?R3l5M2VBU1hkUk5CckZaN0VrUHU3Z1RVYXFJcFhvdGo1SWhRYmNlZ3ZPcTRR?=
 =?utf-8?B?MWp2WXNmUUhGSFQ0dFYxRnpUMHB0bm0rZzRQVjRaZVBGalIwclR5OXd1amJr?=
 =?utf-8?B?eWpLMDdCVml6NVI3VGJvbVA0SDd3WjhEM2ZmQzNTTFBkeHUydnBPWGFycU9N?=
 =?utf-8?B?cGdOTStYeUNTeEpYRjQ0OGRGMC95Q0lhbFBTV0c1U2x5WkMxazA4K0QvSW5X?=
 =?utf-8?B?SnRVSk1FSGQwQ2FtL1BBWVQ0ZWxwT1l1bzhieHBYNHliTnE0R1RiVTB5eWNq?=
 =?utf-8?B?QzFVaG52NFhCaGp2cTlmekpuUlVaRndjUUpJb3pDeUhncVlBK3pYcWZRcHl0?=
 =?utf-8?B?QWFPU0g5Nk1sY291ay9MQ1pPUE5uN2ZRaXkxb2ppbnN0UUtvUnZtRlRUNDlu?=
 =?utf-8?B?MVpSWW05RXB2dFo4eWY2OHFNRzRDZy80TEZDdVU1R0RLVHFhWVd4UUtudktU?=
 =?utf-8?B?bU56OWxxemlHVURndnQyWENLTnFuMkpCVlYzSVUzd1JwM2hJSVFRWmE1UEs1?=
 =?utf-8?B?NVU2eS9UZ2FvQ2tHSjBrVjBUcFg3MEgwb1ZLSE51UUZoQ05pZjFic3JCRElV?=
 =?utf-8?B?cm1uQ1lURmVOME9tMjRHV2U0eVZ4TkFVeTRYRDZEOW5sWThFbW1TS3hIaXVD?=
 =?utf-8?B?NmEzRXR5L21oYW5YbDliUklmU1krQVVJRXpKb0RQNFBzaWFxRGc5WUk1TXkz?=
 =?utf-8?B?US9WNVhzOHh4K1RGZXhBZ09KQzBOLzNyWDZEYzcvSVR0ZDQwZjFkK3R2MkEv?=
 =?utf-8?B?dG4vZERMNExZVTVhSkJYbUErY3R3aEdhbmdncUx4dDFaK2xsRnpZMFRBT01i?=
 =?utf-8?B?VEV5MC9ybXVaOGhWNFhvNFUwU201ZDVvY1lTU2lUS3dsRTJNTmxCZWY1bnYz?=
 =?utf-8?B?NjBOMzY1TnZEaUNtVUt2MjMrYzQ3elArYktmT2F0M0lqTVc5U0NiYmpkeUJ1?=
 =?utf-8?B?d1Jkak1yc3lkYms4ZjhHWlZaSGlLVTBub0NidVAwb0NwcG9SaVNIdExxWmRm?=
 =?utf-8?Q?0LudVkRnmIGGHSliTUXC5FAcK6/evTZTAVFDuLvskT45V?=
x-ms-exchange-antispam-messagedata-1: 5FmHgB6you/rxSxndQ547Qj+V/Dn88rE16s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E186387876A6E041B230B3A9485B3D05@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c800d-d86f-433e-359e-08de64c09401
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 14:12:21.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfdIx9YQvZGn7Un85HluO4nDFC9iMzvxrEGAqjiUWgrMBJVmbtmqfLm7lZzqJdDaNUuaeEsn8zkBX/Z3UMnDEUPYpUecZhKsPcAQehPQEUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8729-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE26EF3D7E
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTAzIGF0IDE3OjAxICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gUmVzb2x2ZXMg
dGhlIGZvbGxvd2luZyBsb2NrZGVwIHJlcG9ydCB3aGVuIGJvb3RpbmcgUFJFRU1QVF9SVCBvbiBI
eXBlci1WDQo+IHdpdGggcmVsYXRlZCBndWVzdCBzdXBwb3J0IGVuYWJsZWQ6DQo+IA0KPiBbICAg
IDEuMTI3OTQxXSBodl92bWJ1czogcmVnaXN0ZXJpbmcgZHJpdmVyIGh5cGVydl9kcm0NCj4gDQo+
IFsgICAgMS4xMzI1MThdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFsgICAgMS4x
MzI1MTldIFsgQlVHOiBJbnZhbGlkIHdhaXQgY29udGV4dCBdDQo+IFsgICAgMS4xMzI1MjFdIDYu
MTkuMC1yYzgrICM5IE5vdCB0YWludGVkDQo+IFsgICAgMS4xMzI1MjRdIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IFsgICAgMS4xMzI1MjVdIHN3YXBwZXIvMC8wIGlzIHRyeWluZyB0
byBsb2NrOg0KPiBbICAgIDEuMTMyNTI2XSBmZmZmOGI5MzgxYmIzYzkwICgmY2hhbm5lbC0+c2No
ZWRfbG9jayl7Li4uLn0tezM6M30sIGF0OiB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjANCj4g
WyAgICAxLjEzMjU0M10gb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoN
Cj4gWyAgICAxLjEzMjU0NF0gY29udGV4dC17MjoyfQ0KPiBbICAgIDEuMTMyNTQ1XSAxIGxvY2sg
aGVsZCBieSBzd2FwcGVyLzAvMDoNCj4gWyAgICAxLjEzMjU0N10gICMwOiBmZmZmZmZmZmEwMTBj
NGMwIChyY3VfcmVhZF9sb2NrKXsuLi4ufS17MTozfSwgYXQ6IHZtYnVzX2NoYW5fc2NoZWQrMHgz
MS8weDJiMA0KPiBbICAgIDEuMTMyNTU3XSBzdGFjayBiYWNrdHJhY2U6DQo+IFsgICAgMS4xMzI1
NjBdIENQVTogMCBVSUQ6IDAgUElEOiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjE5
LjAtcmM4KyAjOSBQUkVFTVBUX3tSVCwobGF6eSl9DQo+IFsgICAgMS4xMzI1NjVdIEhhcmR3YXJl
IG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbiBWaXJ0dWFsIE1hY2hpbmUvVmlydHVhbCBNYWNo
aW5lLCBCSU9TIEh5cGVyLVYgVUVGSSBSZWxlYXNlIHY0LjEgMDkvMjUvMjAyNQ0KPiBbICAgIDEu
MTMyNTY3XSBDYWxsIFRyYWNlOg0KPiBbICAgIDEuMTMyNTcwXSAgPElSUT4NCj4gWyAgICAxLjEz
MjU3M10gIGR1bXBfc3RhY2tfbHZsKzB4NmUvMHhhMA0KPiBbICAgIDEuMTMyNTgxXSAgX19sb2Nr
X2FjcXVpcmUrMHhlZTAvMHgyMWIwDQo+IFsgICAgMS4xMzI1OTJdICBsb2NrX2FjcXVpcmUrMHhk
NS8weDJkMA0KPiBbICAgIDEuMTMyNTk4XSAgPyB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjAN
Cj4gWyAgICAxLjEzMjYwNl0gID8gbG9ja19hY3F1aXJlKzB4ZDUvMHgyZDANCj4gWyAgICAxLjEz
MjYxM10gID8gdm1idXNfY2hhbl9zY2hlZCsweDMxLzB4MmIwDQo+IFsgICAgMS4xMzI2MTldICBy
dF9zcGluX2xvY2srMHgzZi8weDFmMA0KPiBbICAgIDEuMTMyNjIzXSAgPyB2bWJ1c19jaGFuX3Nj
aGVkKzB4YzQvMHgyYjANCj4gWyAgICAxLjEzMjYyOV0gID8gdm1idXNfY2hhbl9zY2hlZCsweDMx
LzB4MmIwDQo+IFsgICAgMS4xMzI2MzRdICB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjANCj4g
WyAgICAxLjEzMjY0MV0gIHZtYnVzX2lzcisweDJjLzB4MTUwDQo+IFsgICAgMS4xMzI2NDhdICBf
X3N5c3ZlY19oeXBlcnZfY2FsbGJhY2srMHg1Zi8weGEwDQo+IFsgICAgMS4xMzI2NTRdICBzeXN2
ZWNfaHlwZXJ2X2NhbGxiYWNrKzB4ODgvMHhiMA0KPiBbICAgIDEuMTMyNjU4XSAgPC9JUlE+DQo+
IFsgICAgMS4xMzI2NTldICA8VEFTSz4NCj4gWyAgICAxLjEzMjY2MF0gIGFzbV9zeXN2ZWNfaHlw
ZXJ2X2NhbGxiYWNrKzB4MWEvMHgyMA0KPiANCj4gQXMgY29kZSBwYXRocyB0aGF0IGhhbmRsZSB2
bWJ1cyBJUlFzIHVzZSBzbGVlcHkgbG9ja3MgdW5kZXIgUFJFRU1QVF9SVCwNCj4gdGhlIGNvbXBs
ZXRlIHZtYnVzX2hhbmRsZXIgZXhlY3V0aW9uIG5lZWRzIHRvIGJlIG1vdmVkIGludG8gdGhyZWFk
DQo+IGNvbnRleHQuIE9wZW4tY29kaW5nIHRoaXMgYWxsb3dzIHRvIHNraXAgdGhlIElQSSB0aGF0
IGlycV93b3JrIHdvdWxkDQo+IGFkZGl0aW9uYWxseSBicmluZyBhbmQgd2hpY2ggd2UgZG8gbm90
IG5lZWQsIGJlaW5nIGFuIElSUSwgbmV2ZXIgYW4gTk1JLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCg0KVGVzdGVkLWJ5OiBGbG9yaWFu
IEJlemRla2EgPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCg0KDQpUaGlzIHBhdGNoIHN1
cnZpdmVkIGEgMjRoIHN0cmVzcyB0ZXN0IHdpdGggQ09ORklHX1BSRUVNUFRfUlQgZW5hYmxlZCBh
bmQNCmhlYXZ5IGxvYWQgYXBwbGllZCB0byB0aGUgc3lzdGVtLg0KDQpUaGVyZSB3YXMgbm8gbG9j
a3VwIGhhcHBlbmluZyB3aXRob3V0IHRoaXMgcGF0Y2guIFRoZSBsb2NrZGVwIHdhcm5pbmcgaXMN
CmdvbmUgbm93Lg0KDQpCZXN0IHJlZ2FyZHMsDQpGbG9yaWFuDQoNCg0KLS0gDQpTaWVtZW5zIEFH
LCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

