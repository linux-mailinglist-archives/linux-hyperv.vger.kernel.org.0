Return-Path: <linux-hyperv+bounces-2944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5796C79E
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 21:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E895C1C238F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234371E6DDB;
	Wed,  4 Sep 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LWvTptRM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020109.outbound.protection.outlook.com [52.101.56.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996B13C3C2;
	Wed,  4 Sep 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478397; cv=fail; b=KDMUIFysNsZ9dcGjyAvPxduM+aPyT3yJRTtyf2EMiOagIMgktbAl7kK2SNCDBQCMEkPvKb1K8iC8dH8X4ZET29ve3y2uUmTlVDWXW6QlJ8zOFxJn0zxiYd17yUMc35IGgZAbj/s4s0BxhD+VJwcv6100lARfbMGJ7ob6Qm1vWKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478397; c=relaxed/simple;
	bh=naZRaPHb0mNzBCJOmD8I62E8TsP90sxCnbYUMzRhNp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fszmoi7IKAaciybDPNPJ+wXceTBhvO9LBxuXsDjf0qXKMyN54cNIPF+ve+necyLnQDSReBpRQ0Qq4SWX7sFNhHCT8DlwcXAZd/T6+AS0hqUckUrh4PkQxOXczqwtIg0qN1fD/Y2wE9ZeVXk/eAxvAT0Lfem2/fQczD1sgQbXGb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LWvTptRM; arc=fail smtp.client-ip=52.101.56.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfN38qRkoreNPJ3AxJwfQaAMejyp48uLYYPqKDr8wNths/SXGPcraWJnnlwHYFQlrhxNcxLeNEf+Y9dalklH4hcYOnLhwbOJFhQa6UI9RudkD/HeTx93V8GRjz2z4nJNNEY/vyPbqY2j/xydNQThJR8qhv8LTHwrR6y7OR9ALDrOJvYyZhBhl8utmZzPZI6wJxb6DcL2NDk3r9mjvuvQNKe7lcdJHPlk5ZvRhK5ZDxBWiNLBPBKO1Wlk7D3wCxfJRPH1JxGIF2KDkvYCvfuixy4+Be9gxWBJbFRgndR/rgHmcYNFzvrxq6gKkdROfyv7C0cFgEV2ZEuyKuSNoC9L6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naZRaPHb0mNzBCJOmD8I62E8TsP90sxCnbYUMzRhNp8=;
 b=bgna1qY2eUhQ+4rMbwK8Q60gervixQhb2JIADJtDwgWIyVWByXLee6HnosXpx4B1GLAwpXWgiVWC98hbsHs2zBgu79adMvvcly5VBdYDHV/wEU37CzkWiXVoqis5DyaqrO7NKqnCN4kEvHi7gsmVYSG7aEl1rkphdcnBe8cwSvGE3O2H2NEpQSGNLSzbRQiSgA4elNp0xHtHsYOjn6h9JhYAyjc/VL6JBGTiIuj9ds/0E7eqpttplP70x31k1o17U0AhK3kY250zFhwF4iJB8gE++KL8JO97oAy0z7zLixJgfkg2kv+imXAe4qn4xKJPARvvLkTUU8i3h457Sm9f9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naZRaPHb0mNzBCJOmD8I62E8TsP90sxCnbYUMzRhNp8=;
 b=LWvTptRMPSPItzHkkWe3yIpUmrgRxwQrJYGnlLCjn+ycS0NgIJtJKPBzWLyZfp+Lac/M8JSNu2GZy/w5HONCSVLA0pZrjV/E6u55D4rEseMy13ChDi1hLarRxvQhCjotn3QlGBg3LWAzYi6d2IeuntHEHNIq43fpNulnAq8M88o=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by DS1PR21MB4498.namprd21.prod.outlook.com (2603:10b6:8:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.6; Wed, 4 Sep
 2024 19:33:11 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.7962.002; Wed, 4 Sep 2024
 19:33:11 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Long Li <longli@microsoft.com>, Simon Horman
	<horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH net-next v2] net: mana: Improve mana_set_channels() in low
 mem conditions
Thread-Topic: [PATCH net-next v2] net: mana: Improve mana_set_channels() in
 low mem conditions
Thread-Index: AQHa/OqVWso8X4XxnE6WGEcmxZzCubJIB78Q
Date: Wed, 4 Sep 2024 19:33:11 +0000
Message-ID:
 <PH7PR21MB32600F26F4B287BDA8B493C7CA9C2@PH7PR21MB3260.namprd21.prod.outlook.com>
References:
 <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07098987-9430-4e1c-970b-4cd4f181303a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-04T19:29:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|DS1PR21MB4498:EE_
x-ms-office365-filtering-correlation-id: 32634821-8fda-4490-0c33-08dccd186970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6q92V+Eo475I4byv0PIahwLNA4ztelYnAVXgQEk0cYyjgP2+LNuNTJjxo4p3?=
 =?us-ascii?Q?MG4InXfQ39VpRTGAybUmCVWl5ZcxS73XDaA08Lb42vC9iXHziFYRyUCqqdJV?=
 =?us-ascii?Q?UFIzYco67zOi51zRb62QE+X86oXhcmrter3KJy3I78Q2wtkot+pewptAKaTE?=
 =?us-ascii?Q?629ehafQ1GPnhK6l3jbU5P0Tqoi7J3QSFDkI5FxQOt+wLurDhiFyqjJzAb1y?=
 =?us-ascii?Q?XgmGBfA+ov5bKup8BBt2uEF6LDDKGQxlVobui//niYJbg+VJFjMViujEdPq0?=
 =?us-ascii?Q?ZK9k0jYB8Tmo+01tnRAPA2kNTUF9sQQsSGKA6WyBqOXjHqe9oS/eShLHDOcG?=
 =?us-ascii?Q?TdC0cbIHPVzRsjaFVSDxXoq+whnPafKG2rueOOLZQFVNxxxZRr49fVlZTvrx?=
 =?us-ascii?Q?GnPQrxmm6aVdTWWJdjgtyNTEx5CjB23FAiynXn+7ThFw8wvf3E2/gaSH7NX6?=
 =?us-ascii?Q?C3KX8T8eR+8g05hmCR7cTCJrcV88lspjqsz8iq/4iUPkMLhCxL+723iWzTK5?=
 =?us-ascii?Q?aZ09N03CxjzSMZqhjkjOTiKF9hU4KOQrqagVt9nU+dCwP9EgCm5cWLpx65ck?=
 =?us-ascii?Q?PZTeH2ryiNMuwB1gHSAXUjZNP5SIBRNFRkLeG2Oh3YF2kPqYRrH6Dz8gbSjH?=
 =?us-ascii?Q?eGgVLRRELetGpgF8YVoo+LkXWN7Zm+arG7BzZ4dCz6FIiiXxbzLEQyBHT8s2?=
 =?us-ascii?Q?Wbt3+WRxQ/8xs8MVp+6t80w67xhYXUheRE5fBVFY7uoMjvKJ5FqDQ/y0UaIt?=
 =?us-ascii?Q?aKKrBXDOTdPdzYRhF5NS9xsqDzxKhJQYqmQkRQnThw9kV37x7OXVRKOai+p5?=
 =?us-ascii?Q?KG0HTriFRjS6DjOykRqbSIif2OZR9Qg7Np0OYYLIFlnUDZGHbs+06qi4YG+d?=
 =?us-ascii?Q?d0AKJFzHPX198Jjwhv7B/SE9x8PQJSXb1wEngAEN3U4h0v+1HaHT5rJqsXbF?=
 =?us-ascii?Q?7zegy+JXNSGo04bKzo2YsKOUA2mhrgL0wzs43anxLRdGG1BfkzmjBGBp71Cn?=
 =?us-ascii?Q?5NnHTAbnDdd79JbfEYeGhYvasEEwpXLtiOkHbXYoLTd1kr6qcrJHq3QdZgU/?=
 =?us-ascii?Q?f3Gd8W807K2jd6Zd+4WSdnaRJEWOFZLRt12NPeI/wqGwRNuCQh/o5f44+FY+?=
 =?us-ascii?Q?XMbqENG1pMi24I2G0UNgZp2DNyT86oHwpqliG8I5qsZXJQ7WpF3zMLVgWhuj?=
 =?us-ascii?Q?kceTLlu2oCH515cXK4uKMwcbdyFB/i+IlsJ02KFegkCIGQHdmfiTRz19ef1n?=
 =?us-ascii?Q?Ls3bzSK3b68y64HusnbMxnrjuwulAuIKKBaOTFtP3+gjD3fzkKkaEec2Vw/V?=
 =?us-ascii?Q?DGIh5x5BLRORYxzIJuHOUyksfXI8ZSbkZoVATojerZGDNGbU6w+1AKT71LDZ?=
 =?us-ascii?Q?upB9Fz2SjRAL4yGcBwGRMW7R2LfGjdJtOIqLmgHkO3rixc0vsA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?snoeXNR0P92k10u3i/JJ29FQ+GhbUTSMjKP19PBXWnTHkNCZr7MRlL76oS2E?=
 =?us-ascii?Q?vkBGJ+VHt/jmgTNLQPRGGckTnTR3QlG4x0VYFNLUeJIjTJE2wi5FfKY7cJLb?=
 =?us-ascii?Q?O9rEV8AZi7blOCkG7d2xoTJ7Su/kQPyRPb636fujz87G7qLeXl4tvKFc1uhG?=
 =?us-ascii?Q?hd+j+DLWbh/XHPtnQjMzwtzbk2XX7pHKUZFkHaz3UP059LJ4w0j7RULfzPYA?=
 =?us-ascii?Q?8QO+2OofBr/O55KoYfCR1ds/TMXJMTDhTuND6jlLTR6x960vfg5d1QfeUANW?=
 =?us-ascii?Q?jA4q9hU1R5c4xRPKPXjvoRoAbJ2UxIkoN+55LPQAD8A2ywHEWC3F5YXsfoUt?=
 =?us-ascii?Q?5evMKPvDqOxZXatlYiGMZp7smcmhuHxePid+LeCf+V5VsRFqVVZTjrMbYPjd?=
 =?us-ascii?Q?ukI/Kyv/V/+jrTAXXqs1Xre09hh6ir3bDp9xVjeNvlTxWkxhjwSbqq9XHQ7p?=
 =?us-ascii?Q?A4Ym5wVHo+uco80OeeC4c7f35y2kN1ocq9Z1iniuruKxalES1ijgjIkTqT3x?=
 =?us-ascii?Q?YvOR+LVDBlbM2fprsiXNYBjzH/OKY1jIDYAXyu/bsMcvlMjy+t5jqqXMn6ug?=
 =?us-ascii?Q?V4jibN5b19wOfi+ZLXE51qFR/7Q/7hMpz4ZZkqdTFYoahUT/fxj4qxob1o6p?=
 =?us-ascii?Q?rksyZ3Fzt89G84W7ks7LNP0y000JkOIb4pZeIH6vnTm3PjOxugyKQSecYY7z?=
 =?us-ascii?Q?NnPGybV0nQLjllHfF2h58maLgecZA9BZDKpaClGZBvYyLu7j5sy4gAF+ucU9?=
 =?us-ascii?Q?typ0oIcEh4vBFLI/qo+x4NKSsEEzjC/p6Pz7Bmv5lmIKSNssqjfAMq5Gkop/?=
 =?us-ascii?Q?3f2JIchSAPxlmf9HiMfPaMsBSshGRtuOsPZyS53slDPgaKKNyTnuPIPj2ze8?=
 =?us-ascii?Q?0JPIPXhvECSIznitkS33Jz2fK4+553V18uBQo7kVMgBabqQWzkq02GEshY/T?=
 =?us-ascii?Q?A3kvupE+UM2lSFhuWZbCkBUXM7VBvhizd9337auex5RREuBL9+gvrO9yinwB?=
 =?us-ascii?Q?4zJE8flx2yFz5bHSUafVjD+dFiEsy324MLqj/BlhQg1+BhymmZsLBw43/b/n?=
 =?us-ascii?Q?R4uCDo4Rfi0bZYcG2ltHwytShEykIN1TKG818G01Nh+9B+j58bvfMEN6HG52?=
 =?us-ascii?Q?8+dfYXIe1tJSl42E1IfqYoC+/iomZ37u9bDhKfyMyBv9uYcjOiFtoKwGm6On?=
 =?us-ascii?Q?cpyOSCDHRw4QovBaBZdL9AbuIuDZ329o6GQCgX5Jkp5Y1PrTfwgmXzHdJokf?=
 =?us-ascii?Q?YXC/Mc1kerSVItZOszYr6xwVWfaApnnGW/5b+AH6/TaQaLnOoXr0kstshzz1?=
 =?us-ascii?Q?gTv/tJpFpjlBjT5xKJtHUP6sFghIm4zctaY7fqHXwQQJQ92UjYR1ziSDrZAg?=
 =?us-ascii?Q?CVdgV22MJV7H067U8SqyS4uEZafzhizPdEOr3En5zEnaqu8wwafK19NhGJlO?=
 =?us-ascii?Q?OdVBSAnHO7w5X0mn26gtXssIad9woRrVOpZ+Z46P1FImR3L+b/q9q+FZszNT?=
 =?us-ascii?Q?Mcbtiz61LGbNEd25hhnqTkCMa1pZIIFlZWknb6kgMgzbeG2tIMgMsRNFy4KN?=
 =?us-ascii?Q?90YmfgyRs68GtX51a5bdD+c2JEh3l3Kvxyrg5gm8?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3260.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32634821-8fda-4490-0c33-08dccd186970
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 19:33:11.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaQr4wJ/tdHblYzZjtfovN/LzXcuv/mk9gDSlIGuCvQtSlagUSV5HlMrFU2ztkmzzal4N1Vfnj2HoEjmwlIDmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4498



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Sunday, September 1, 2024 11:46 PM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Long Li
> <longli@microsoft.com>; Simon Horman <horms@kernel.org>; Konstantin
> Taranov <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; Pavan Chebbi <pavan.chebbi@broadcom.com>;
> Ahmed Zaki <ahmed.zaki@intel.com>; Colin Ian King
> <colin.i.king@gmail.com>; Shradha Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH net-next v2] net: mana: Improve mana_set_channels() in
> low mem conditions
>=20
> The mana_set_channels() function requires detaching the mana
> driver and reattaching it with changed channel values.
> During this operation if the system is low on memory, the reattach
> might fail, causing the network device being down.
> To avoid this we pre-allocate buffers at the beginning of set operation,
> to prevent complete network loss
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Thanks.
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


