Return-Path: <linux-hyperv+bounces-8223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C84D13C29
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB81230D023B
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEF35F8D6;
	Mon, 12 Jan 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NhW5I0pp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021110.outbound.protection.outlook.com [52.101.62.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22335F8AA;
	Mon, 12 Jan 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232103; cv=fail; b=nyqnJyyp4ArjrTCSjVvzrenHGqJTdQQ711CmKwxWmFsyzZpupOdk1nwtVSKIc4jF2f7e5oV36Xx/HXbiw7IRfkk+g67qtUuwokX4Kr8gNboNzMjT4lwTNKGCPzdx/DCj55RgIGZ20bqHF5crbDkrn1T0IV8oPBbA7E7QfufEyMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232103; c=relaxed/simple;
	bh=Gb6IDFWS1zP4u61lc4SW8a1onFsyFUFJ7fJAQCHvjGc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3xMRo+Um8/9Jw14ECCJV3cf09Sh0j3Q+lU/18fknrxMAQdus5VpEi9Xg8pNsMcv5KLqFodfDO7SPHhaiggS9pMU4SiuBbwPVzu8aU+gu0QrqLx/Na21fMYKXIJPT9Q6IMi5jfOMlUpBNo5nLN6EECPaIZorFmzg+DgoCKf0xXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NhW5I0pp; arc=fail smtp.client-ip=52.101.62.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4gwTzXUn+xf5VBOPKCUve1OnRUyKvmGpkUK2DvTChaZHzZdni5jyr7alNflkxNdLuyO7eeCPX3+aQGPO5Bm4fav5G1IYwFXgaOLm+lJ/gP8TxrUZ4e4LLGkL+5m7zuwbxNDxxoW5D3zbRzFPYIInjXFSfBGbNov1SHk+O0wO0QLTYoY8x5Y/OZAV8yTntjb7/SdrTyJ6NDrXHVbH5T1hop/Rb2WX/qVlyOOUwzQZdFjMjE/fgGpWd9GMjXFlQl9odNNBbEssRDA8Zd1VVovUpkoFUfK7CZLZ+BLsNC3WbY7Jr6U/J2gzF/4YWu6ggS0wS6zUtbpituAFLd8a03ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6IDFWS1zP4u61lc4SW8a1onFsyFUFJ7fJAQCHvjGc=;
 b=QawKLUFqwjQa3xz7xmArcMne44rfv0Iv9xFh9cLoYYoq9BILK1GW+bhQypgF3hwX+a011a4JdasjxZWQynDZgTIbMwC3HszAjxPdVak/ZXsv2xL/p9CzK3DGTIU1ZjOLNdZTeo2GLR+1Bgb497y/Dnx9StZaRGQEYSR4YtnMRB6sDEdIQorDWbF6OmlOlEeP51WguIih5KhQEhtwL+YD6iLVzgRQmw0UMu9orDT3Ti8eMjQRP+DMLAd2C7BZz30dCjysd4ngEiQToQ8WSnP3H0OGzpKvhRNPUwHa7AN+S0wPPpx4AcsFczF0fAEn/oCQkDiYnCBXUWrxfX8z+m2qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb6IDFWS1zP4u61lc4SW8a1onFsyFUFJ7fJAQCHvjGc=;
 b=NhW5I0ppxBgNo4JcnYGJrRM5kE1/MrmEm6QkJ71APrNmlUEgFLH4rKDSsWE2B6KRRN4ySHvEuL0BRGyJJkIcOgVxXZyixYQDv8pqX0Lr7NCHoCoW2FOFcPWOSHpiceVthHyaR/RUde/ym+e6IC5D/L4+27mJBsPc6bTw1S4fvnE=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6058.namprd21.prod.outlook.com (2603:10b6:806:4aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Mon, 12 Jan
 2026 15:34:59 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9520.001; Mon, 12 Jan 2026
 15:34:59 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>, Aditya Garg
	<gargaditya@microsoft.com>
Subject: RE: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming
 without RX indirection table
Thread-Topic: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming
 without RX indirection table
Thread-Index: AQHcg6qEiIS7Jlmg8U2ogNOKW3DLI7VOqkqA
Date: Mon, 12 Jan 2026 15:34:59 +0000
Message-ID:
 <SA3PR21MB3867F67C949B42DF5984A71CCA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=58883b51-fecd-4e79-90be-e636c928ea65;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-12T15:33:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6058:EE_
x-ms-office365-filtering-correlation-id: b316a31c-6609-4898-c185-08de51f0257d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|7142099003|7053199007|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sQq1C+gyNTniXimIihHraC0QaqAsfbGa1Eef7/Cq0AwpZ7eGkqVccHSjmVpN?=
 =?us-ascii?Q?8okcyRMP0OxEgsLdnKcmbMRcxrS4zhpux8Xwq4LovD1hLz3deIp2ZSeLmHyO?=
 =?us-ascii?Q?tSBg/ABb9N7hSM3nliXdYuklQg6HN27jTQSN5biimMG6hZ4cJcOZkFoWbDmh?=
 =?us-ascii?Q?fLX0pcIAyBZ/JfEWwyWnCISrcLzT58sRrdlEpOqPK4l/WrsjCgXEGTT88KIR?=
 =?us-ascii?Q?pOCjlIBLIjY3sraYVPBAfVestEdDP3Go5hrHrfwdT/4VLfkWndTP9+UvDbBH?=
 =?us-ascii?Q?ezq8til+dETT+BVz416PNnBQemR2w6txAFjACrwMSDfN+g9yNc7OVZn8MoSe?=
 =?us-ascii?Q?6Wjy7iqKc8eZ/APFVtMDNkkAw3x4cDvn9+ohrpkgvSt8/+SaFEKQAOjrbiLH?=
 =?us-ascii?Q?i/CPcyYsbooTLE+ZV41FDVPRh8eK2XuNDcp7MGxPxWOyKt37xJEN4wE71gd5?=
 =?us-ascii?Q?7bHsGfi8EOvhI8DQNeKu8emnFKr6x36h2Ev4h5NVfMheXcp+2uaOIuEEG5DV?=
 =?us-ascii?Q?0iHhF9HtZ4Yh3kLRNtm3MLtFwKisqGjzC+4IyhJoVt+MMevNqE+pkmzVpy7z?=
 =?us-ascii?Q?86cJGYA3rF8wsr3L4VdndbqYEgosreWjVXS5o7xAgTsVOL6oQPhLeyUNkzUB?=
 =?us-ascii?Q?6GMMRtj5pY4h2gXZqJlbIWllTPTRfyzCGfcPydg5BfdTYptbfbox/qvnu3kr?=
 =?us-ascii?Q?iQxervyWl+K7ULGMsL0DTt2f0t5hLHqoVbgSUmibJVHP/pqDt3r69udd47l4?=
 =?us-ascii?Q?kg5mzLfilXXf7XwrsItO1/nM6gOidFq1AVmJ8YUXiKSvbG3W2ygeCyyZynVy?=
 =?us-ascii?Q?HUhlDsVh9RKkx6jKae8Za3ecWEBMMmQwIW0SvLrqrHkzX/ewCs5lif5Buhht?=
 =?us-ascii?Q?V7HZI6UxGSJzrb7Raq3GKSmyIzkGCGuM+hOdVmWGFHb+RUo5d9+uDwcYAErR?=
 =?us-ascii?Q?6rgkG5eqMlOky1xu3duTcXTJb5THnBB1Wwcb7Q1GoOHdKjru1t553zZAMdJ9?=
 =?us-ascii?Q?qDdEwBx4Tz+XFQWIZmhv0VdxJz+L9isrsAy4Dxj4MpuHNILJMQL2XWxKjlzr?=
 =?us-ascii?Q?vf2b/sRaUeYJZNSIcKiJ/5S2NKiQLOBekLzMJZPwxzI/fmrrAPrGsn8WkhVD?=
 =?us-ascii?Q?EPzAhu5ZboY0CvR+FRp68IWiTct8ObFQZU5I3HtJw2Zm8wUxV4u6dOzYHjMI?=
 =?us-ascii?Q?5lpm/n6aUB0zdjxWNk6prH825EyVmytCCFiJs2CRpuvjZhtP27rmaIyXR+4x?=
 =?us-ascii?Q?fP1YGKhKW8w8euhAtkoaHAcqe9BJOfHwsbberV7x+Y37/LeYYD3i5XN5KTng?=
 =?us-ascii?Q?vtd8+mKjkYVGTsRz7q+bOh9xb2bMm9HIMkLTXkCceD9kVT7fU4h0V0xoEIN4?=
 =?us-ascii?Q?N/lZYbe6Q3vBcCu+RCEssQqobb6jr3WkbxwGXeW2CPKNUlfoMvnuAQsX2dkB?=
 =?us-ascii?Q?3vx8px9eiPUANsPoYMKjn/5Joc07wso1LWgoGqt0rdBph0zR2w6feuYWc1DQ?=
 =?us-ascii?Q?xt8NIUpcc1g5gKKCeeKreVTIzOTA5XDjnH5nY7RzkrgWq23JQ08SNcfV1g?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(7142099003)(7053199007)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PMQIe76DHCiE91zkEUvjHMWfa8fJjCNJyolxS0PKMOwcE0u6C/tgDdy6NnSA?=
 =?us-ascii?Q?FhO/pF92bWvNKNu8/IJV6C4vqjHB/2/9xGzGZjYQ2KPWneQXxPjBpniUHXeR?=
 =?us-ascii?Q?Dxv+vQz/iDmrcfgjhsT7CFz8o1DQ7AoW6yPKN4GgHGt8BaWzRmiZzC//M34N?=
 =?us-ascii?Q?Ke1k4WGdsfyDKuohWwnt6D9h1c8sLvxG7GJe+X2ZaUYZkZ5pJrCzdWf9J0y6?=
 =?us-ascii?Q?bNCQhfiy753IIqws/z5nk2I8E2kuAUrI0geQpiyWFnucBPLbCXL9Nc0t4zrx?=
 =?us-ascii?Q?8Xw+n1RmaiwcHrYVjkMaCUrftwNmaHkgX2MwJy4izqrdEK4mLdUGAEita3KV?=
 =?us-ascii?Q?NFdTTnGp6oZ9gnsIlv+eQfDI6rnEhUKeG85n0dlGUbqocrskzdnjb3rSUEjb?=
 =?us-ascii?Q?6JcCu5mAlJc9/+oNGoOGrcix8NyXeWppmP0hKROT19IO+KEdvkItQgPAE5aY?=
 =?us-ascii?Q?17l9wBF3oP5AbPIvrKaIYbs3k/HIhk5S1jrnvnH8xsNLSS1rawICxXKj2wxJ?=
 =?us-ascii?Q?R2CeU091jPoKW3xD2lalhKoE4mcluLGi+XExkeAkH4n+AjHYcFGMJojyrUhE?=
 =?us-ascii?Q?91hDE2C+NKWEd1+JMrSdJ5VqlYHykDLWu4q6hsq8b09GMfODtP95pEM7hxT8?=
 =?us-ascii?Q?dTbjB+5qoun1WRHn0jkPBB9NpDq3wgyIFhxI4KSRqjNHiDSNUFOGkhnHsFYx?=
 =?us-ascii?Q?t+6d7I/8DNu7nx3GbSuzrjlmwZ0dK2z7Y6w7PgviTXJcuL8W6kzPra3OVcqa?=
 =?us-ascii?Q?I+C1Z3HjN+S7e3j6PSyhmSz5feyhJWcfr1xye2nlnwZ8vA8zgRBTuH7OF5PB?=
 =?us-ascii?Q?L8CxJnN5xe0h5OeqMGLeC6zrOPo9KnGP6Rrn1Q2N1H7LBWvftkW7mgDEAlCz?=
 =?us-ascii?Q?DaAx+oweQoKHgQPI/z7GeczxLj/KNmWxepfIwgXnw0BRt7eA/yChG3h609BY?=
 =?us-ascii?Q?CaVo3ohrIpU6lwhTFdjq4avDz8bDBXmZidrt/mJdzTiQsQBIh/J8U4Su8lHy?=
 =?us-ascii?Q?AGVH9VQcPS/XLhCuHlQni+H46T6+se1HZF9H7DjTLpaHjjiuQgA4J6SsJNTp?=
 =?us-ascii?Q?hg7pzlz8MhmQqgEcEJPpGKQT/ril/q9Hi/dVWOrshvk9pfhY4hVMJtKei+CF?=
 =?us-ascii?Q?5LQP9ZVKrM37zfE0iqNH7yA6UGXRrB7bjndBarBQwNKU88ni9/ZeH+YkP1Sp?=
 =?us-ascii?Q?uAkc/TZZWc//zynfe8m28LJdgGIEyPewJ3IvTNP9c2IdhC/YdXUIODJ6VQ3Q?=
 =?us-ascii?Q?JAoEA5mT2uqhyHqIaVxIEnnZWeV0YvkY3jDUAfbtM2x8INk/SjFLX5pC6pm7?=
 =?us-ascii?Q?EuuA/u46tiyy5pfKcdjzFppuCSMaXKT4593bPKI2EucuAWOuO3QdKnctD5X7?=
 =?us-ascii?Q?4JffUniUJMDc0LbSYl91tWxFNJ6lPaZwXqk4vpijJLrLwBNitzhHvNWLDxfo?=
 =?us-ascii?Q?uol8w9eVQHo1RLDMLxAaXi/Xkke25cHvmLziaVK49ADBeO82dmw/sJDeG17h?=
 =?us-ascii?Q?g6XQsobvMlGrTiBSKdwGuilyUR5iZxh2Kg9QPEO2+fcm+a2rbA4ssV9rFqZY?=
 =?us-ascii?Q?O/xs7wKpRt1YF3+oDLPRzZVHxpgHhmM63Z1EEbJzNRB7OL2v++TCnkFGd8Bq?=
 =?us-ascii?Q?lfm0wnSVnATiqbkBuV9Ez9eMViO9K9IZuJYRPxtrDc1HoNG3+Q1Q1QC0TlB4?=
 =?us-ascii?Q?bLQh8aDi2nXO2JL+dj5m29lAfJQO3/UiUIb/KT0UvsRDX2uI4qEQlj466sHK?=
 =?us-ascii?Q?mgDkC38lQw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b316a31c-6609-4898-c185-08de51f0257d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 15:34:59.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9DSBCzy6nBjCMrHlLeEgLcq9L1rfnuJwYyFrB0hjPyhG4IBLCnmyg0MT4S8bdeiY6YGG0GYYipY3ZUjlxDqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6058



> -----Original Message-----
> From: Aditya Garg <gargaditya@linux.microsoft.com>
> Sent: Monday, January 12, 2026 5:02 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; stephen@networkplumber.org; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dipayanroy@linux.microsoft.com;
> ssengar@linux.microsoft.com; shradhagupta@linux.microsoft.com;
> ernis@linux.microsoft.com; Aditya Garg <gargaditya@microsoft.com>;
> gargaditya@linux.microsoft.com
> Subject: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming
> without RX indirection table
>=20
> RSS configuration requires a valid RX indirection table. When the device
> reports a single receive queue, rndis_filter_device_add() does not
> allocate an indirection table, accepting RSS hash key updates in this
> state leads to a hang.
>=20
> Fix this by gating netvsc_set_rxfh() on ndc->rx_table_sz and return
> -EOPNOTSUPP when the table is absent. This aligns set_rxfh with the devic=
e
> capabilities and prevents incorrect behavior.
>=20
> Fixes: 962f3fee83a4 ("netvsc: add ethtool ops to get/set RSS key")
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


