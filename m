Return-Path: <linux-hyperv+bounces-10456-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COnMAO1l8WlfggEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10456-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 03:59:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BE48E302
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 03:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 924DA301530D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268A22A80D;
	Wed, 29 Apr 2026 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AfmcBZ1R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B123ED5B;
	Wed, 29 Apr 2026 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427905; cv=fail; b=YlLhGSj6/TY5TqahENrkZlkQgsthcfWDyfHgW2u80VXWf/GvZRX6RywD6p0fiJdfE5+w6U2kJIwgrN8GiBbrAaX4UhXZ4HyTPF+VREu7uzgQqvMcWCwE5BBWMFJ66peoU90rAE1r7ybaZptOtFk0vnqym6VBgvCfpI0Um+PUVHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427905; c=relaxed/simple;
	bh=aSTcYHca9ECfU2Z69e9LHAhvpdfazq9yp1YToKLDXXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+hJJ3WOjnp8gly5isS2ZQu9IUeoL+pTkvBrXrLT4hkD5Z0k7/A4dulbKTOusQ7/kuA8655J0OkQYjKBhBVoLDch4BrFv3ePHC92YKrCLEEUc3VSECSJyPHvbqt0gUJVm3CfaoT64rNh0/2wwrg92Oqly8kQm754zsNJ4nbMFSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AfmcBZ1R; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG54f/NUZauEBQO9MR8hVc1dmUexz3zBX4CPd8S3nENJnYqfc84BSnzivcRnJkQwVLMpIncCqHOoWRoY4iV5904uv8j0pmO26QYaUtaeynOttWHE2Ti4diUebqBa8i8PHDnz80ZElvXtdemR81oyT8bmSTltFi8NFMeur0cDBP3qgo9bjYVWxz2SRxkBBba3ZI9oDb+NU1DHd87HBIurr3JZabTZO3msHSfRudqn/lk5w1/w+4G5vgJU9yfPAXo8jzDZCyRFZ2wWixWoMqE8QKTiBCPSxtGnfC7IE4nSc23H7eVqsOZi5YBdQXjyt8HrIcmniY6VPKQU/hckVSQrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cTvGkAlkH7djI1Dk59/5Bls7bi7xvvtkbLFgUAiPyY=;
 b=mx9OdCl013X4gId2X0fLregFgtY9cLNhcTSNH+YMFlnUcXqQfwqe3Vtla9d/5SQhocg6yUyTvzI6RrOpMS7k3QNzKubeKPNzXyWnN2GThj95OcLCbXcXp16Uy5MYY3/tyWJsIZVIKk5Ttn3K0xLn5ULX4idFoXfyigD4MEFClo1Q6Zi46jQtIzZTsOcFAaWSfX/yeW5OPDgfu5ctmfYN3OqkomPEV4RSXmpObTxiPj3nExJ5ZjWIUFOPCUflZJ6rV/8/+zxatU04twwlKlJjFfUXfcQDxWpkbMzMWifWFL2kcNFKQ8yQTuI7LFO8/fdUcMv9mDfl0B+ipXnRYo7sJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cTvGkAlkH7djI1Dk59/5Bls7bi7xvvtkbLFgUAiPyY=;
 b=AfmcBZ1RpGVP5mfv5NVs0yOQW4xrMjAsUg0eXSu21GOzZgioF69IoHMdV8fTp7Hn2fghqmOdf5wT8HEzFAv6miODK6/6vm6y8mTWLIoSHpAZ5q4v99/YEvI1EbpMr2/K5tTFu99ziTzetTCryxM4nRIcoCSjpYLwCNoGT61SvvU=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA5PR21MB6945.namprd21.prod.outlook.com (2603:10b6:806:4d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.4; Wed, 29 Apr
 2026 01:58:20 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 01:58:20 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "matthew.ruffell@canonical.com"
	<matthew.ruffell@canonical.com>, "kjlx@templeofstupid.com"
	<kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkIAKqeRQgA0oSLCACEewkA==
Date: Wed, 29 Apr 2026 01:58:19 +0000
Message-ID:
 <SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5BAFAE2134276241FFED42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157D5BAFAE2134276241FFED42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e73110c-cf31-4373-a3ed-8fccb895746f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-29T00:06:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA5PR21MB6945:EE_
x-ms-office365-filtering-correlation-id: 01c5b9e6-0403-4016-8265-08dea592c9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 JHDe2LBREGzymIKUfNuCEwEdt0my3A1asdAJNoIUY0aO83J0PRpNLKzzmiT338vG2FgehRGRSsuFmheA3nHmtuWPzQHcTBpqdMX6un8e4xdqNjzcZjQNvmUtxeznJjkVWwYPlapEOJdDJe1Rh+H6VNg9/9UwBVEfxvTQY4tIKSjIpdieFp9icFjrj6NAcnhUK3xMxWgtfKxiL1/WDPkCGBsJXUBCf4ARojNpp+OGpukJug8qRHdXph3McFv0FBuRMWEmweYm7E0NMxfn7IfjhTYDd7QAfzR+LFEocAGs/8x0/K3LgEHb7PXQoLpjA/2r1fWfrsUuSMm2YO2zcfFISwZfT9tyj0GrKrFcCn0poKoNF8hpfVDG6S3uChu2TulNp9J1wqpyw6oBrmO0rIJj00OPLqKjaLM2ggvqD13I1OZAKKavhjoEe5N9m5IrjgFV0z+Lkm0xYDrLEvX9n+VsnQ61zT1rb7bPUaEJaXrMcOofmqZbVBNT6vIDO+67819iSEEhs+BbjLpuQ5mJLUX/5dC5qJ7V5CiL6aC4J2ED69EjHTshqsXfmdF1of9VTLnPnlswu0IvHidadBD04p+A0YCtH2ULUem2qhJ5nsAl/TPy2BCTyd4xlQJ3ZXPtbxA5NKdkn/jzo4VoPk7BNDsoOFBbpyjD8BwpO86NtMORr0fVY9nMUfTUWgP7HK0r5vSRPFtCTXMIzVBlnmkRPnKfnw1Rl29x+2c+mR4/QsF4Ou5klPyEP660eQKfsA53ypr0ziDroGArEi6EzzGashRitWhYL0PQ6ztD4ufMzu6qUNUzmwIlLjx/5RTqWGIFn+l0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WmrSm7Amng+H0ENsHmAB3PHH/EayFFz0R6jn5k1gxQE2Zd4rNiLV17l+F2cm?=
 =?us-ascii?Q?TZjlnVvTy8vEpB3rVvy6AA3HWpNz2Cxf+5IBdUEjETl630ehhiaI8Yc4/u/e?=
 =?us-ascii?Q?gnqfVmyFKuAVA5S5+bTh/wMn5KxZdY38KbJt167nHqSAkMEEqUx2GuGUNi30?=
 =?us-ascii?Q?1Nf1lM6ixlz1evqeKM8d076u/zhHqI7WFsH+3txPn8kbWKvH5EmO5117chgj?=
 =?us-ascii?Q?+3LNS0BcZUB9rfsbahfaqOl987akA1j7BYQfIhRe4hzQmt0LMojlqP1Vz/Tx?=
 =?us-ascii?Q?J3fF/8XAEiSPnD/AmWvkHuFJE4ej7k9VnUFDtsW/N9o2TcQM20JMnIUL1C2f?=
 =?us-ascii?Q?D+fiuXAOh2KWvxI5XICXh7V+xhJL0Cd32Mj52XBor617jaYO9P7M73cifc78?=
 =?us-ascii?Q?TI6OtMg/lZJ79/fbIYtu5q8tGHrUgelRwhRo4NOq9AvZq1sXPLcDP/x9Fucy?=
 =?us-ascii?Q?3c+w0/9E3p4YTxylMl1iAAUg8cdsNYAkYTnYnhBJiqhUAPP3h9IJJG5mX5cU?=
 =?us-ascii?Q?fMg9yuKNninp3qR+Ciu8txVP6PjQJNTmyH3z35vgJEcyIB273JHdssZ6Bpnm?=
 =?us-ascii?Q?kqOl3lnYqEOm5fdfSQEmdaZyS5IBBkYA63P9OURzkgQREfxWRMaw0IOFenlF?=
 =?us-ascii?Q?/kyvO4AX07enu+fZ4RwpcivkKZGOUdMRA0+TM6PwtiCAuTdPGW2jKZzQYMCQ?=
 =?us-ascii?Q?0+4TnBF9afH0awCIs8ZGHDev3i0ch5pMVHSO20phG6OzM5L5ecDfsn0Qm0mq?=
 =?us-ascii?Q?HXTXpM+LP8uWBN/RdrlHpH80D3DKKGBQyfM2soT6qgkTB9PjMdqrcuT7VpmF?=
 =?us-ascii?Q?j5gAruv1eI/mbvM4RHg0guVzFu91BDUChr4m02lH8EkOtOCBI5dwg6tMOCUJ?=
 =?us-ascii?Q?Eg3k78X/FlKw58od/AYUaiX0kNdafLF3USdaHDtgvqt+WuuZgC1XQcKYwZYr?=
 =?us-ascii?Q?UOgwYpV5larwQcOonHCyguJSB0TsPWjU/kkw1bpGD8CPRa6AmPRIh5BXh8KD?=
 =?us-ascii?Q?V6/fjxl7FFC42aNWBe2pe38Db9x559pswcFU0SISoeO7sz7VgTXndj0zzsdS?=
 =?us-ascii?Q?42dUaJx2zHG0ub4wz5JaQgM9o73s/CipJ1fenYuvFMKnbzhEJMwSyXGcD4b5?=
 =?us-ascii?Q?34QbDxXOCpU4sbhDRole3lAEWNs8cmqrgwzovOmjBLpRhZnWqlZzkUjrbDix?=
 =?us-ascii?Q?jwqRRTJqul9LFtWQirP+LqYU8K8vN1XqYSHyOjNsYFGAKOJGJFvDkh/cSM0d?=
 =?us-ascii?Q?lV310jnnQWSPoMYN2ysEgNzjPeUrxWWrWbltKUteRraiV+tUpqMtdYrvgJNI?=
 =?us-ascii?Q?y1cC6LdqqAl8VsmiV7hTbqig5f27Azh9h0TvVZPst/15xcqm0sMsuAEkRaAy?=
 =?us-ascii?Q?kADDr4BW7xtTKb+gLwTQRVE5amYFCRBq18Vwu1lz2lUd5x1LYJy9ds5VJIsf?=
 =?us-ascii?Q?mX3nhuPN1wBa5A7/4r6GOZVG/3M0WoKxtfSd7B5MuTdeSWzCxDnDbkCRd0Nc?=
 =?us-ascii?Q?Sx5uEQXeFl38SfRgSChzLjreiWFoIiZayhVhfeuuIHnPjvLQLI5PTvapaQse?=
 =?us-ascii?Q?A1hnC5lyHl5ttNvNmRb+JTQ6BV4a8VJreGO6+y1CX+uK4EB254V/czZaPpCz?=
 =?us-ascii?Q?mgY0CUNHOCC5RyHNyVx1x+U/EjoSxV4YQ+pgXVnB8tSf0zWlv+rfghH9fiSv?=
 =?us-ascii?Q?anzAXKwBuFRvzw8y6PiOnt8eP+j6OucgpZuEneWZMNPXv9MTmdZYmkKYG2dh?=
 =?us-ascii?Q?vIUZYIqzWw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c5b9e6-0403-4016-8265-08dea592c9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 01:58:19.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1vzzx5BmwUvAC/qZvjyEoD2MGZuqmo5NMWqZmzGAC1WT3o07tl2fYdRI+4nYf3B7wqHskpeRjzx0/sbUAcbxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR21MB6945
X-Rspamd-Queue-Id: 277BE48E302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10456-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid]

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, April 23, 2026 10:40 AM
> > ...
> > Another example is: for a Gen2 VM with the below commands:
> >    Set-VM -LowMemoryMappedIoSpace 1GB \
> >           -VMName decui-u2204-gen2-fb
> >    // i.e. the default setting on Azure. Let's ignore CVMs here.

Sorry for the incorrect statement: this is not the default setting
on Azure. The default for regular VMs on Azure should be
"-LowMemoryMappedIoSpace 3GB".  Not sure how I made the
incorrect statement -- I guess I might have confused my local VM
with my Azure VM, and at some moment, I might have mistaken
the meaning of the "-LowMemoryMappedIoSpace" parameter:
for that local VM, I might somehow incorrectly though that the
param means low_mmio_base rather than low_mmio_size.

> FWIW, I'm seeing that in Gen2 VMs in Azure, the low_mmio_size
> is 3 GiB. I'm looking at a D16ds_v5, and a D16lds_v6. The v5 VM
> is newly created, while the v6 has been around for a few months.

This is also my observation, after I double checked my Azure VM.

> In a CVM, the low_mmio_size should be 1 GiB. This overall example
> is still correct -- it's just the comment that I have doubts about. Or
> maybe you are looking at a different VM size that has a different
> default?

For CVMs, yes, the low_mmio_size is 1GB.

>=20
> Some years back, I had gotten into a discussion with Azure about
> this size because the swiotlb memory wants to be allocated below
> the 4 GiB line, and reserving 3 GiB for low mmio limited the size
> of the swiotlb. CVMs were changed to have only 1 GiB for low
> mmio because they need a larger swiotlb.

Right, I also remember the story. :-)

> > With the below command:
> >    Set-VM -LowMemoryMappedIoSpace 3GB \
> >           -VMName decui-u2204-gen2-fb
> >    // i.e. the default setting on Azure. Unlike x86-64, an ARM64
> >    // VM on Azure has 3GB of mmio below 4GB.
>=20
> See my previous comment on the same topic. I think arm64
> and x86/x64 are the same.

Agreed.

> Question about Gen 1 VMs: If the Linux frame buffer driver moves
> the frame buffer somewhere other than the default location, and
> then the VM does a kexec/kdump, what does the legacy PCI graphic
> device BAR report as the frame buffer location? Does it *always*
> report 4G-128MB, or does it report the new location? I can run

It always reports 4G-128MB.=20
BTW,  I suspect a Gen2 VM may have the same issue, i.e.=20
currently we only reserve 8MB below 4GB; if hyperv_drm uses
high MMIO, I suspect the UEFI firmware would still report the
same original low MMIO framebuffer base/size to the kdump kernel,
but there is no easy way to verify this for Gen2 VMs...

> an experiment to find out, but maybe you've already done so and
> not reported that detail here.
>=20
> Michael

I have a Gen1 Ubuntu 22.04 VM, and I run the below commands:
Set-VM -LowMemoryMappedIoSpace 128MB -VMName decui-u2204-gen1-fb
Set-VMVideo -VMName decui-u2204-gen1-fb -HorizontalResolution 7680 -Vertica=
lResolution 4320 -ResolutionType Single

When the VM boots up, we reserve 64MB at 4G-128MB:
[   11.492075] hv_vmbus: hv_mmio=3D[mem 0xf8000000-0xfed3ffff],[mem 0xfe000=
0000-0xfffffffff] fb=3D[mem 0xf8000000-0xfbffffff]

Since the required mmio size in the hyperv-drm driver is 128MB:
[   28.631923] hyperv_connect_vsp: hyperv_drm: mmio_megabytes=3D128 MB
the driver has to allocate MMIO from the high MMIO space, because=20
we only reserve 64MB below 4GB, and the available low_mmio_size is
smaller than 128MB due to the vTPM MMIO range:

# cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000e0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-f7feffff : System RAM
  d7000000-f6ffffff : Crash kernel
f7ff0000-f7ffefff : ACPI Tables
f7fff000-f7ffffff : ACPI Non-volatile Storage
f8000000-fffbffff : PCI Bus 0000:00
  f8000000-fbffffff : 0000:00:08.0
  fec00000-fec003ff : IOAPIC 0
  fee00000-fee00fff : PNP0C02:01
fffc0000-ffffffff : PNP0C01:00
100000000-507ffffff : System RAM
  281600000-28295449f : Kernel code
  282a00000-283746fff : Kernel rodata
  283800000-283c5287f : Kernel data
  28411a000-2845fffff : Kernel bss
fe0000000-fffffffff : PCI Bus 0000:00
  fe0000000-fe7ffffff : 5620e0c7-8062-4dce-aeb7-520c7ef76171

However,  when the kdump kernel starts to run, and I print the
pci_resource_start(pdev, 0) and pci_resource_len(pdev, 0)
from vmbus_reserve_fb(), I still see 4G-128MB:
[   12.506159] Gen1 VM: start=3D0xf8000000, size=3D0x4000000

In this case, we can't really fix the MMIO conflict, e.g.
if both hv_pci and hyperv_drm are built as modules, then
the order of loading them can be nondeterministic:if the order
in the first kernel is different from the order in
the kdump kernel, we run into trouble.

If the order is deterministic (e.g. hv_pci is
built-in, and hyperv_drm is built as a module),
we should be good since both allocates MMIO from
the high MMIO range in a deterministic way.

Thanks,
Dexuan

