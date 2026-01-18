Return-Path: <linux-hyperv+bounces-8361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C4D39922
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Jan 2026 19:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BDBD30011A6
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Jan 2026 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A722FFFB2;
	Sun, 18 Jan 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b0FtQVkK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021087.outbound.protection.outlook.com [52.101.62.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6E24CEEA;
	Sun, 18 Jan 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761085; cv=fail; b=Y7xbw5n3zFCEwRbGTdUDzUWnfMhGPeeddhVaRZ1vPTr9GkFxV7wyDUlUmJ5dV1vSyV0M0YDNgI6H9UyOgW47sTlk9QGANPEFcdXGgJ1JWeSDQjzzxPG31oi0aWHGF1wgqBvMV7ZY4ZsQcAlgkjAFKquxLnt9l59A62rwLX672PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761085; c=relaxed/simple;
	bh=/UGY1D0DuunHrRN21PLXq9ritu5vUMjt0yIZUv/S8DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5I490OOZBsoAWvCrDkYdHyU6BpecOSYiglEBVOnl5mIH4O7zaJoTZ6NmCOdPzwz4EhSGvF6F43urKW78R53/IlVsFVrHn5fNn0x9ilv7dmRAV9rPiqyX8M8Cmxz9eWjvXvvyPPULxTLCG43u4m+ZVfhb5ckh6aJT9+SijYruwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=b0FtQVkK; arc=fail smtp.client-ip=52.101.62.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usvr7OghAJr6ayVMdCVOrPeeoq3dTBHfTsBcAR1H4NIAiNa4pA2xjEyXDspF3RGsHjXe1NSrvpnkMLDguk6nG6snkRoV3quWHaNa7TvQ2EL/Y9G7YuSjY+Y9GvHcpxmFreezxxGSJ+fcGDySSaFu+sBsDiU1FKTTLmrwzct/kvwbVXucYujBjutC+ZIgZ5ZZnQLbIrda/gPUB3+VoKisdLCFgsr1ygwGbEFJepnyEp3HhtzWyEDq5QvlNIkdXsS36OrnyTGcnX8brEskaMibjxGSyQud+Cyd44k73TueMiAyWvMLS2oPOUCY7+NApA3TuEsNZ1iXhoCd+8ItrYMvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf3492H4oeLTPEQFkV4v0oKIrJ3VszcWFBRIhn/brbM=;
 b=imSdfjF6S3U0CApEJqAN6msMsZ+heU+UCs9F3GXyEN7DQAExwlAD5B/4Sd3WALrFfVHAjLt0CbtbMQOr/S4HRsdaJgozrrZt4FJrCWzloUqwnG/GNoOckTc6MGPamgSRl/CaMSrFI0qqRqM4yKQ3H6BYAYboei2qExt8+dwH53RhmbrKCpt9oaGJnpM8g9FevpPF3E7X2W+AWdWs6uieFLNxcQK0Zn5nyyesbT/darCnxeC4R39kS+KOLYFGd87M7ym0WEq8oUudzj5ITuZYNvCGrAS8xGnA/BW0+t61siWT4ZtcRIGCzHpAUNAGkHQN5hYpYrqDGBilqr9v5V9nug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf3492H4oeLTPEQFkV4v0oKIrJ3VszcWFBRIhn/brbM=;
 b=b0FtQVkK/gqBOMe1nF80xXPuY8iF+JFTXsdHEe1rAPQ3ETt5lgbg5Tv40x4UnNOJgVpyZ50KXODg+wEVoTsbxpVVR4NuqgN1CmNq70fSAXmELy9tjcI+JSYKnG0FVMPlZRqv70gNmCJYGW82kYRSjyx+NetX2OFHcV7i4EKksps=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5769.namprd21.prod.outlook.com (2603:10b6:806:492::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.4; Sun, 18 Jan
 2026 18:31:20 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.003; Sun, 18 Jan 2026
 18:31:20 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index:
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnwgACOxQCAARoLgIAAbQoAgADxWmCAAZgKAIAABVQAgABccoCAAUplAA==
Date: Sun, 18 Jan 2026 18:31:20 +0000
Message-ID:
 <SA3PR21MB3867D4A1BFF769C3E91626B1CA8BA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260115181434.4494fe9f@kernel.org>
	<SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260117085850.0ece5765@kernel.org>
	<SA3PR21MB3867D18555258EDB7FCF9ACACA8AA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260117144847.20676729@kernel.org>
In-Reply-To: <20260117144847.20676729@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f7739fde-46e0-4199-8692-1a0d7d9da38e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-18T18:16:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5769:EE_
x-ms-office365-filtering-correlation-id: aaa947fd-b4f7-4654-1f73-08de56bfc673
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+AKH4Y5fDGIu6VNETlMIR3uzoP7/f9xUDrRqV2O/PLdo7KlAZvx37hp8bq25?=
 =?us-ascii?Q?iugeLTAMyVykwdUnmSjyLYX1fnt2LPNL22vMXyYIoUiI3rcwm+jZWYDDKJBE?=
 =?us-ascii?Q?Bj47dTie+P46j02jrqmsIPy/rz8xOhh1+2O6Yp/OoNUtlqfl7YC0bF1EMjTx?=
 =?us-ascii?Q?ccq5ArMAeb6OeqFfU8wmYi2mMBSJCIkAbmrVZsRCguW6pG7TLucMHcrUWy28?=
 =?us-ascii?Q?jerNFulSi2ryv3O4y1x7q2Olno78tbc6ia/N4nSsSLW+gXTLvZS8SRRwFNLM?=
 =?us-ascii?Q?zguBc/9a3P9Nk358RMA8exIxi72LlAnsu958u6nOki+Qy0rNH2izEauvL0RG?=
 =?us-ascii?Q?VowVTlYs0uDzBHOBvAMvNfLIa5u0SCstnSop8fL7nQSDBGsJJqsiBH6QMtDq?=
 =?us-ascii?Q?a+fAHmTc+U/ddbp/zWY1r4Pk88V6SW0xReHICEuETURZVvp18pS3PXpMcXH9?=
 =?us-ascii?Q?TAM3xGkeN8Zv7+eiv2YEeCWFZQ0Tfg0InS/G5z3P3Yr7HgT1lzg1GDWtjoUQ?=
 =?us-ascii?Q?eQGMpo+s5H7EL8gj1t2OuUnKvSRRxDXSE83ywp3oTjaxWcPfNFUV3/0+2yJp?=
 =?us-ascii?Q?57gDmK/75Mtgof0V5Od3id5f+GkTOvBymY4cvHd04AZwFtxQunnhEsnVY7iT?=
 =?us-ascii?Q?pBkVdopyywnBy/JVN9Jsu+nFnQ/okrvJwN58b776DatihiVdumWbNlXeRlBq?=
 =?us-ascii?Q?B81eAUXYitowaki0IHfQzZJ9yk1z2vHVmuM32tIquLWocXw82csM6bLyEp+p?=
 =?us-ascii?Q?Pywp2A5qj0Vti4LF4b1QWVdHa0rdjEqvGPRKxdY7Rv5LYDCJFbawWkWt7wAH?=
 =?us-ascii?Q?nrXmcT+IZSsszdQ5sZTSTPd4yYk1IJtwKdbj7QW0xrlHvWlkEhJohL5pme1/?=
 =?us-ascii?Q?ZrWQoPyUpMdysNVtmyazizk21s6x5OPh3qB90UBH85IFw49C+bkbNXn8vW6v?=
 =?us-ascii?Q?HIqepZmtwO9SoD1v9t7+czTBXC7xdseCtgza2LGX/rotOVbNtvnZu1ZL+bkc?=
 =?us-ascii?Q?M4AagJrZaiK97pzphhf8W0JhPVi93c4qNM7TbZnv0ukS7MNA7EdWPWmgJjGz?=
 =?us-ascii?Q?wNdI8y7Yny/k9vjskoZHjQUF1wx5fHMf/W/IOhqJM3hhdNsc+wBxEmHZJDIW?=
 =?us-ascii?Q?0IHM9sDk/TiwnvSPKnI4X9uJyXkxySaLuDaUxJOojVeBAu4/vHuatqnlbSb6?=
 =?us-ascii?Q?ql5q1txA1gbWMHHIrzerNc7tnDS6esJkcpqjCSyqgHF2+VZl2VOHTULDBMr+?=
 =?us-ascii?Q?84Js/P5kYZ1uEoPoQkO/yWn1ZoZ9qInqBDIGaISOMkDvgsI0u229Mn+d1qVQ?=
 =?us-ascii?Q?eNmWGdo15/5kiuBUTLlY9nG3ExtgfJmMe8WqIgjOB5drbyBh3jkoVA8UsP71?=
 =?us-ascii?Q?awFYeP5IiRALxuV/51hHwC5nkqiw9NHEUeUVH7WTsHevKmbaryt3BDQZFen9?=
 =?us-ascii?Q?zBrRy3Z1wdjUaMJuBJSChlNJ1fona4NTVvcEdIZKSLdKHEW7xOhcpYQnbi7f?=
 =?us-ascii?Q?qrJwPUUz/dQOyr2Er/c0J0JrVwbRtDn+c32wt/rqiGFfQ2n6Hk0fScsyJC9I?=
 =?us-ascii?Q?c7NijrY6xsKhUvtIUbX4uLvvqCAHNTeGbtpHJV0x4QRG31c8jFYA/BSsfbmH?=
 =?us-ascii?Q?ha4jqUft3Sv3yCTh2BlkWXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NZlXrQAQ+9oFUaF/wT85uF3Cn4CUOtLXtRI5ByVGAwMKDoVA6BMNu3W2j0jP?=
 =?us-ascii?Q?hVLD0s1lr1sUOSRnZ9s3KyCovwGbyM8YJAuToLYXlKp9wL9FoxIwjRv+SMuF?=
 =?us-ascii?Q?VGwbsNDtf2PzQJWZ63lx9Ur9yvzROYtlmXRUiKJWYVM+46PAaU6qF5uheFf6?=
 =?us-ascii?Q?HkY44s03n3m3VS/O1GFTdmGmmnXVbs2FBFOA0uvX67HX0u+RXesyiJSaw8ud?=
 =?us-ascii?Q?GjRU8FtqHwWfxh18rfNAhAL3gIZKZzCFpUBZGu1doftBQLdNObKoSzKUHePd?=
 =?us-ascii?Q?wy/wGqN1Wjasa9lriWWSyYVYbWtf00otwwgn7qv5DBHP2/I436BSRAftb3vG?=
 =?us-ascii?Q?gdkt0FlrtVEkK1zBA3zFdUDnN7SPkIXGs+b4oY1/k7i4GOrL5HbDE2et6myb?=
 =?us-ascii?Q?vFqXYNwV+mYD+hlw7e6AeSUk+12P2vJLxtRRAXLbkZeSP8H9rN8ZgYskA8gK?=
 =?us-ascii?Q?hJRVNZBCCv2OT4qAWewSIg3lToRNbYoAm0qwvtKanFCUifzgKAMTV+TJEK5d?=
 =?us-ascii?Q?ghFJ7ldECc/HSsub4rht1STLhO3fYfOSUQM1BDRKp9U+XD6DoRXoIir6yTk1?=
 =?us-ascii?Q?pbw5Oe52KXyB8o1RUX530CMKiaSPaL8ZPEkLpKPMge8pnCKFA50KoZ5YkjS1?=
 =?us-ascii?Q?PnApBPrE3VPBROnep57MfWZzipkhEA8D0K9Q9vDyzSeUIOpwW04Acq2e1mmn?=
 =?us-ascii?Q?/gTVC5K4VUCqUplCJPqupQk5Kgw39xfrsCDWm2X/Sh18fga8KTyEcSSYYWZ4?=
 =?us-ascii?Q?SX3wvZi7O4KPj4rrkcS5UHW3H20cuzuQGfo+nZB+OtClqJ2EIVYxZDPlb+xz?=
 =?us-ascii?Q?8jEKX26EEn1PnbdaIB5H1S2eHCKL50jpCfXzEWJFUSHU64HiZrZeJVPqDa97?=
 =?us-ascii?Q?0QBF9A8bnL8OxP8S9kfjqkIwNVIgXXInOx0wIHcaHkSO42wrrP+sSudPIJAr?=
 =?us-ascii?Q?Y23Rd3gZh/ucrat+jPxSv60hcAkb4mVb3jqzsSDk1IHymWhxbdLFFFhAwpmS?=
 =?us-ascii?Q?UK6URrTwc+IlgOORNj/VZxpbMPY1F4wC+t/lk2Un+GIb8mlDJSLvNnnj0hze?=
 =?us-ascii?Q?mEGGDT/QVQWmM6M0XmStLCtGTpbwRw32E0pu/pchwm9zdnnaGKpAAMq5v1xO?=
 =?us-ascii?Q?v5svBKIaeHcKGQ2/H4PQ1gkv0AIQ1IMVItpmxg/U+IrFI5cYhCAmRqxPeCBH?=
 =?us-ascii?Q?Dh4pTW6HlLhWEjbxCeNtGYFawrMJlhgBU4UfPD5GtLjuu/EPPWyd+N6ra03r?=
 =?us-ascii?Q?PcE3WjsWVgtCGVX/uRWHv5yux5fcKI7H05UI0rEAVkBGHvX0ku1g+8zxHrab?=
 =?us-ascii?Q?RZ3HXrtGy/wo6xYmUSqm/GXVZkshnqX+12HYHyvbY54wNkOGJGLGZWR+GUTs?=
 =?us-ascii?Q?Vl6JjFw4zVYuf/UTD8by99+CGgTdwLuX5+LPiuNDSxGLYNOBafT+AevG5Zrh?=
 =?us-ascii?Q?n7jKm9oUmB27nj8CQQFKWkydNTl4mYHvLgnO13io8txrRjs9jMmpCyjx+fF8?=
 =?us-ascii?Q?6ihWkiY73fZRIrsYbtciZuu29qhaeP8UQq2vofUAiTNkx0cmAITbJsYfVJ5+?=
 =?us-ascii?Q?1dshLoTj/JNGmrxQy1p8UrpZmbtBTWX8pwXfgaInhZ150nLSxA4kMuM239v/?=
 =?us-ascii?Q?OD6J/q/mmvbhhGv5S9F7H+8gHcTgt2qKUT6ufDKuxFYecbqk7Eq/CiX84ugf?=
 =?us-ascii?Q?wQlO9++FixFNmPC+//TacAd1eXzbjdb0l0KzbEenAIzqTdB5Z68JPosbabdv?=
 =?us-ascii?Q?C9goNcnVFA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa947fd-b4f7-4654-1f73-08de56bfc673
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2026 18:31:20.1115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lvAMZaLiiZ1PR13yzNndAAax0JUpZfIoYhjvFnsizPzdhASjEvr9Lo5krxdymBM9xcVSEpE5+QjGeJYJJXRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5769



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, January 17, 2026 5:49 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Konstanti=
n
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
> On Sat, 17 Jan 2026 18:01:18 +0000 Haiyang Zhang wrote:
> > > > Since this feature is not common to other NICs, can we use an
> > > > ethtool private flag instead?
> > >
> > > It's extremely common. Descriptor writeback at the granularity of one
> > > packet would kill PCIe performance. We just don't have uAPI so NICs
> > > either don't expose the knob or "reuse" another coalescing param.
> >
> > I see. So how about adding a new param like below to "ethtool -C"?
> > ethtool -C|--coalesce devname [rx-cqe-coalesce on|off]
>=20
> I don't think we need on / off, just the params.
> If someone needs on / off setting - the size to 1 is basically off.

Ok --
I will add a numerical param "rx-cqe-frames" to "ethtool -C":
  ethtool -C|--coalesce devname [rx-cqe-frames N]
   //Accepts 1 or 4 frames/CQE for this NIC

>=20
> > > > When the flag is set, the CQE coalescing will be enabled and put
> > > > up to 4 pkts in a CQE. support
> > > > Does the "size" mean the max pks per CQE (1 or 4)?
> >  [...]
> >
> > In "ethtool -c" output, add a new value like this?
> > rx-cqe-frames:      (1 or 4 frames/CQE for this NIC)
>=20
> SG

Thanks.

> > > > The timeout value is not even exposed to driver, and subject to
> change
> > > > in the future. Also the HW mechanism is proprietary... So, can we
> not
> > > > "expose" the timeout value in "ethtool -c" outputs, because it's no=
t
> > > > available at driver level?
> > >
> > > Add it to the FW API and have FW send the current value to the driver=
?
> >
> > I don't know where is the timeout value in the HW / FW layers. Adding
> > new info to the HW/FW API needs other team's approval, and their work,
> > which will need a complex process and a long time.
> >
> > > You were concerned (in the commit msg) that there's a latency cost,
> > > which is fair but I think for 99% of users 2usec is absolutely
> > > not detectable (it takes longer for the CPU to wake). So I think it'd
> > > be very valuable to the user to understand the order of magnitude of
> > > latency we're talking about here.
> >
> > For now, may I document the 2us in the patch description? And add a
> > new item to the "ethtool -c" output, like "rx-cqe-usecs", label is as
> > "n/a" for now, while we work out with other teams on the time value
> > API at HW/FW layers? So, this CQE coalescing feature support won't be
> > blocked by this "2usec" info API for a long time?
>=20
> Please do it right. We are in no rush upstream. It can't be that hard
> to add a single API to the FW within a single organization..

I will discuss this with our HW/FW teams.

Thanks,
- Haiyang

