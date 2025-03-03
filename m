Return-Path: <linux-hyperv+bounces-4196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D9A4CB35
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645743AB95A
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F51217F54;
	Mon,  3 Mar 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FupQPt0Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021135.outbound.protection.outlook.com [52.101.62.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FC18D643;
	Mon,  3 Mar 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027661; cv=fail; b=g2L5pohs7MdK6ALw81AyBMUyI8bRBYmEc3JtKpLr5yW3Mj2/qb9tf7nlav9F5Q1UmBies1PIccr5nNd6XhyecwS20szAs2EliHq7Xd0j1SpEpdcZh8d2ocUyy9qWUzER3OLrCRNj2BwrLxWnkCU5Mq0cZ/CC1xb/Vkp7ND+qseU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027661; c=relaxed/simple;
	bh=aiJzk0CZ4JWI4PZMXQpJey3CK+H+e9JV8uSywKs/6rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkCGGw80AAH+ahqoOCwcn0lThT7ftBF18lboO/VrEwiWMG1MqGWK2jVying882AD5bVvjZIJCpHMCBAxFSTinEo0pLQK9DX9PDe6nRp5OU917JToc/uFo6SJpS79IAEFM8P+priC1NJLkSqrvMl1oCLlEZqvCXDA9rpvQ+UGTC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FupQPt0Z; arc=fail smtp.client-ip=52.101.62.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKZvqAnDawCFf+JWSz70g75utEzkCG+RlgEy0aVJY/xLD3BM0HqugIovxzyQX3BPMXEpxdPQaMEI1m9FgRMdkd8/t0dKpeNXroAPAkxmcssXbwOKtZA07vZYJpnNNQ7Rlep9zX9ziavWgobFHIkp8YIMMHcbHAtwei1V809/ci+tWJUEihS2KaGgfbnylI8FtA6pfG6WT68IiAcxEaJ/MG8sumqDYC4uykt2E2uSjflhbqf5ZxkWFpwVXf2AeG0szX4hl82glfdgioJlP4fHr8+OpLll+j3HUW42b4imf80p2hRV8Dwh7HXn33z0uH30NVcmIa8iN6v+NcTp9h5qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vml5d6nNDu3ExTEr35iQXy2q4NrlRJEq5s2htFJQIc=;
 b=IYTiSPh0lvLDjlL3K6eqGWLhvRRYMrHDRbpnpU0TdJsfKFWVY2WUGrW70wOL14KbLFgmTys3E9zdqE47uSqcdhkbiyNEsjM9jYZcwh1RnegMSRIZRX7grZScYTwScz13EqCg92BvGKiQ2PQHriCuQIFQnBCfVBFd3xpKqSDXqULHz4EC7IdQnnbBbmQ+Qiq+zXv9J8bxxUqmrquzoe6IGviKlsY9or0odqSC9jkXEL3ZXiT8KSk+L5LSNv6ip2PGQ4KIycf+xv2y1DPBgom9CipCdgKY3u/LSuifSaKF4ouMS7r6EX2bYqdUQ7l9MI3PWYN8yeEMhv+okK7DtpDEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vml5d6nNDu3ExTEr35iQXy2q4NrlRJEq5s2htFJQIc=;
 b=FupQPt0ZlLTQVY6brOpLHbgmeXCbKWAcQL3lzxd6mjmcyE0UB0in93K06HsSYMPgi5QOpvw+25+zIN61KksezU6ZdNZIJ5k3lhj3/ouJOR5aosrqy1qjmEb7Z+BFZ1+unugJjjQASEFCuRGtmviBtI8L1cVMyYFXzNcr1NeevNA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by MN0PR21MB3413.namprd21.prod.outlook.com (2603:10b6:208:3d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.12; Mon, 3 Mar
 2025 18:47:37 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Mon, 3 Mar 2025
 18:47:37 +0000
From: Long Li <longli@microsoft.com>
To: Jiri Pirko <jiri@resnulli.us>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags
 on bonding
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags
 on bonding
Thread-Index: AQHbjDEPGDbrW7tVC0OHODNLCmCkV7NhvwhQ
Date: Mon, 3 Mar 2025 18:47:37 +0000
Message-ID:
 <SA6PR21MB4231D93C746A70C24B79F806CEC92@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
 <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
In-Reply-To: <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2def3997-4074-4750-b0f2-b80cf4e578b2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-03T18:40:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|MN0PR21MB3413:EE_
x-ms-office365-filtering-correlation-id: 23e2a7c8-11bc-4973-1674-08dd5a83de22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DbM9bECXBwSVyaIr3O+lwo/nH3dqn204EXJABndn7Lc0W5GXa6t7OUqY+58r?=
 =?us-ascii?Q?on84AGim9k7/U6DRhQR0Kvcz+8Xvf/0aHTxYjQBhpqI2mA1aYezlbIc+N+gf?=
 =?us-ascii?Q?IFF5ms6ReKewYkg71xld2Vaz+zyAsXuEU9bC5w86Y9adQklScRY+fN74B1iE?=
 =?us-ascii?Q?Vj6cFGm3hWfah1EmPJPM2Uis/P6kIm7oKVuxSP02HlVMbDP+AZ4AHjLvfkjJ?=
 =?us-ascii?Q?0U5QZD8bgPkKTVvfDykj/geFRUeDHKJNY2Jrs3zJ6goi4qezN8Lw2PCTKNai?=
 =?us-ascii?Q?ZTp2njdcvFrw7Ew+Q7FA3Xpi5A5pR+QICfaRvGyYDVpwMiUufgsJz4qb4QO+?=
 =?us-ascii?Q?3pqDJmy2k173UeqSocolq5GOlRIV28vcungRzAIIUln5i8cP2WJGQbCnCzJl?=
 =?us-ascii?Q?5XsdURlW0zOqxNg3MbmGzIPzLNCGisthATOmVd1CP20DFrIx1FFm0c4PdvJr?=
 =?us-ascii?Q?ghnD+pfDJU37fGiGuMbjAEYikKY2ZRKX5lkNSEh0mOJJ0VzWPrnl/bqBcrX+?=
 =?us-ascii?Q?HSlPca1+BKn7pvCWceAU8Ax3v8bnU7q56kIV1rdx40QMMFuFfCiAlvJW9fgd?=
 =?us-ascii?Q?aSTp6MjpvLaKl3czMw5+wx9Sfg3oce87E8ylIW3nk+niHsv9FUawzYXJJN5L?=
 =?us-ascii?Q?TuIVAL0DU/oHvHSdSwu4Y1rYWA03WhGj8IlcrfA4xYcGj2EmN1sS1YQ/Wn7/?=
 =?us-ascii?Q?T7ierng9tQy2bX1LzoGJBBrm4bw66njEyRoQ06ceZuiXSBaE9ROwx8jI5kbi?=
 =?us-ascii?Q?/XIH0VmP0YrG2C4yfwGSJMc/ea3RT5zymwFDr4sdsbtVtSw8SuoNZFN8MsMX?=
 =?us-ascii?Q?XpQPdZLXUwitUrl9HxxctVPCjZ0J8UFThvqoo8vxIJxZ7LR+J7kc0nQyGf5r?=
 =?us-ascii?Q?3tcjJnxvR4O0TzbbNLsIQtDndS678wyz/9vVHP17OhD1SP0NGRYYxUd1yC40?=
 =?us-ascii?Q?5PlE7P20PcKEpRTz7Jm5UBbIjCCOr5LUjq3yrDRVwFpwWUHihUO2u8fB6Q/k?=
 =?us-ascii?Q?ru842+LDqOBaAyQ1WAvE8lVo/4ghFOwwc1vjm75+exfxoUAj2TP8dReZK6lk?=
 =?us-ascii?Q?0yaOKlcgO+saPp4y4eFBUSU2DTxskYjwD1KQuI72w/R72nrNMTgOZ2WMWhlK?=
 =?us-ascii?Q?TUVKGDK/y244RMoBzBDRAXlK89Q3NJddzdlige1+JDioZub9oytsj3hyusvd?=
 =?us-ascii?Q?sEW5CZeFI5NAEOeTJJ06+uqv2GAGL6CFljlQ7upZtX3ArWquW1PWqS3jD6am?=
 =?us-ascii?Q?mrquc8eP2L2Srp8ym4y6x2V/Mb0IoeZMkp4O6iPqGThrpF/gKcWIdxx+j1Xm?=
 =?us-ascii?Q?llL8uaMM9OcCf/D9SdgntNr1HT7KM8A4u13+PQHh+VEe9JbqkhwPj2xwR+my?=
 =?us-ascii?Q?X1TlNaa9qzLP/+jOZKVoyq3Kskb3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NjFdu9Nkb9k4h5whXcPb2jGmsykWOC6RzeXbt3T9V1gTqdStPpTSxOmsZuwV?=
 =?us-ascii?Q?fJ7UBFC8mxHzCdY7U5AHD3Zc8+oPAbW8VHPVM0HkaNYsKoumpDFD8SkOV39p?=
 =?us-ascii?Q?YKwRDxKjWoVuJDll84rfVy/CqQfRy5FH9EZBa4J7Zw6aCT9w/Uwq6xvVGlTs?=
 =?us-ascii?Q?jbSFf9UDeem5o+llH8CTBM/wbYhIowSGQ5DlI7Fdxiq2bMIKDQ+NvW3RqzGR?=
 =?us-ascii?Q?9E+SAwHmG+enkor4qqNnn8iSY077ooV+c2RGGBzSoyqg4Ayw21+72gpiDzhT?=
 =?us-ascii?Q?vqbE851G2TXz6H6SPukOEscnBIYXdMOBs8uHcvuUYWNt4R2mbfsM1+CTBTxt?=
 =?us-ascii?Q?hGAghD+1BncuzGNn9trd6h71+X3jQx+rzx5xZK39S/fXiL7iczBcdD2WONMV?=
 =?us-ascii?Q?OHhTwgE9N2PBeduVF0k4yHCdYCIVWINm/tdJyFA+6XeBpa6II4rxi3jRnCOe?=
 =?us-ascii?Q?6mpCl6Ahu//zJAHQZ2WiYWNYZ7tSgk1XoCF2dBW3LaGtjywkpeKlOKHKyoaS?=
 =?us-ascii?Q?Pc56+oVdDbQgsGvRrdNrC6kWA/04fL0hFIQcpCZWtKbI06LQIbfjctAzu3Ii?=
 =?us-ascii?Q?x0OihqJ4VAtMXMIulZy44Y/wYZdgBaSPjzloHs/dDnxfqknr58K2XpjowH6c?=
 =?us-ascii?Q?bdNikfO9r9jHwX5GvB1pPpcd2a0MEZ4Uk/sSd5jeEWID2aKjJCx0AajsL4yN?=
 =?us-ascii?Q?a1IrAA9nOxjM3eX9IUIf6LLNz64cN6MIDgtkge7rcsul8mcrqQDWNHk/MAgr?=
 =?us-ascii?Q?OT0d5zqKpa+VU10kiOwQuDupC7K6303vU2HqNtrcpDTenr7Mje652AwC3EM+?=
 =?us-ascii?Q?ZchQKzFcFFUTx0K1fnjpQ6gQzn0esWRppo1B8pSTWYoQSLhxQwRdQONTinLm?=
 =?us-ascii?Q?kxunnBxrcDyfDi5FBy8I9JEHvbHc1yEP9xcBNvPDXo2qnr1wJ2jCLx0sqJEM?=
 =?us-ascii?Q?Uc4K91/MFTXl3FoPcj+IDiDdUmtpp+KWPCLkSdaAMozMhPWTD3Zmx4jFQrKA?=
 =?us-ascii?Q?mdk4ObFgC8IFOvZHnV6MTLZjajHOTKSyluw/mlF4USQfJf7r6Yh2GSAk/fYK?=
 =?us-ascii?Q?/HrQi3gwui+MBb22JiWc1KaGp+9sCXoOmBZGUvx7k+DTfJWmP9DWkRz/GflD?=
 =?us-ascii?Q?SW+P0d+K2xugYDe/qmngzxLiWPjjQxT3ysTYza2MJdFTs0mESMzluyU8rO2t?=
 =?us-ascii?Q?56JZ0h3BfA4iztg763BfTtQm516XnNpmuvG9n788H8Om21otCJVBy+J/aIkX?=
 =?us-ascii?Q?ZdJwzoj72+13eJrQg8deQmDVTikNIRp9DKIFFBmTqHRNaOdlPr44lzznPBGC?=
 =?us-ascii?Q?1C2DYlqIERZCazK1b5OE+Xy0bdPHRLg5WI5YUr3B0nDaLjdPTGOLrIlDXHmD?=
 =?us-ascii?Q?ySCDiEr1T7ewIXTJp82Y3BgeOI2LtDJf9a8AILWGaWFOMEt57i6ZeUQcmWiP?=
 =?us-ascii?Q?L0b1NhSQkdqrRBa6O8mLkObp8ML3FrLI3sOgTG+Upd1eTorK/CC2g907h6cD?=
 =?us-ascii?Q?LhYHGxayi2pNbRm2YELMcAw7dxBg9HjGwGzZey13xdiHipVPHGYdAtH9N0dO?=
 =?us-ascii?Q?rmrQdO/0fDbL4A0z34ABtVu/2cZ1Rgvh9f7iwVbqOu6AZrPDBicDThXLudAK?=
 =?us-ascii?Q?9yrwPL+YJ8+iRaSabMYJBPIxuw4xWRTbJHlXhd9Zsrts?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e2a7c8-11bc-4973-1674-08dd5a83de22
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 18:47:37.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zqXtnD/8ni1lNEzzdlTWSO3rondlURrS2A2FoftLb0M2bWOkOa/LZmZxBId1GLyhFLB7xtzJtmXDditNtoXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3413

> Subject: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags =
on
> bonding
>=20
> Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
> >From: Long Li <longli@microsoft.com>
> >
> >Currently netvsc only sets the SLAVE flag on VF netdev when it's
> >bonded. It should also set the MASTER flag on itself and clear all
> >those flags when the VF is unbonded.
>=20
> I don't understand why you need this. Who looks at these flags?

The SLAVE flag is checked here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/net/ethernet/microsoft/mana/mana_en.c?h=3Dv6.14-rc5#n3144
 and is also checked in some user-mode programs.

There is no code checking for MASTER currently. It is added for completenes=
s. SLAVE doesn't make sense without a MASTER.

>=20
>=20
> >
> >Signed-off-by: Long Li <longli@microsoft.com>
> >---
> > drivers/net/hyperv/netvsc_drv.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/drivers/net/hyperv/netvsc_drv.c
> >b/drivers/net/hyperv/netvsc_drv.c index d6c4abfc3a28..7ac18fede2f3
> >100644
> >--- a/drivers/net/hyperv/netvsc_drv.c
> >+++ b/drivers/net/hyperv/netvsc_drv.c
> >@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device
> *vf_netdev,
> > 		goto rx_handler_failed;
> > 	}
> >
> >+	ndev->flags |=3D IFF_MASTER;
> > 	ret =3D netdev_master_upper_dev_link(vf_netdev, ndev,
> > 					   NULL, NULL, NULL);
> > 	if (ret !=3D 0) {
> >@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct
> >net_device *vf_netdev)
> >
> > 	reinit_completion(&net_device_ctx->vf_add);
> > 	netdev_rx_handler_unregister(vf_netdev);
> >+
> >+	/* Unlink the slave device and clear flag */
> >+	vf_netdev->flags &=3D ~IFF_SLAVE;
> >+	ndev->flags &=3D ~IFF_MASTER;
> > 	netdev_upper_dev_unlink(vf_netdev, ndev);
> >+
> > 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
> > 	dev_put(vf_netdev);
> >
> >--
> >2.34.1
> >
> >

