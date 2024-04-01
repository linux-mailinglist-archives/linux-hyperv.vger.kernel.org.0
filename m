Return-Path: <linux-hyperv+bounces-1893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBA89479A
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9725283720
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666F156B81;
	Mon,  1 Apr 2024 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DBm9rGj+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15156B65;
	Mon,  1 Apr 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013676; cv=fail; b=ev27c9RmzTLlc4uwF6eQz5HBiBiJ507Jyj2ufeeMawJoSCOOxgMLkUZCybROLZmk6fnSa4V8Iz9KxHTH/CJsu2lN9wD+PWC554dnbBxzkKyHSoiZi2UbUwF8zQihsmDMwdgZ9CTtUOXG7luz6je5Uf3mktnqO19U2xqql6I3FHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013676; c=relaxed/simple;
	bh=C1FmXASU5cNJ8Z6XaCTYmUFzWEaHQWGkDp59yUnPj+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shg/8jNdotcE74+eYgbuMxeR72Tx35p7+ywPJMRKwJfBZQkS2M0bWx0jsFQKOvgXU0Z8xPAMhkhi7kk65DWQEgW4tzUmsMxTpbqg4KPIsnx6z3hdOJwBq8YdzjwCuewa3SvRgslGqrohI08lQlXfMRKt8BNuweEUzqeh2HfSyA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DBm9rGj+; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyDejsjF23IngqXoiWhXJa6Xfjl47ebg0Ro4GcTB+q7eCSnhSmAN8hSs9qXSwAC9qSNtO7pXXhYtl2D3ahl9qJQ+IDFZK2UU6qz9hSTQs8LkVM3Ez23cfyN6qGBm652ftV9RzsOyYyOdM1zxbwd5f1xucMcL7+V/gGQimYp+jm7BZgEh1EanEenQ2rxuPozW21eiB5lPzpx8nNbxYX4CeQyzFS5chtnziM3YEhT3FTbPKPamGhtY4sFsWR3NGXUDIxb7FFGkIsjX3fLKvucB6kHviaCEZ+af5ja6s89YSqEZn7koRgfTnIU2lnRH0TGHzyII0dt5B8xLebk3Wztvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L6Ilcaidr9Rn6NrB9HA5AShNaGcdr8h07rDmXiOWn4=;
 b=hhlhMnHc+IQ0z2bemRVAbt+PonYCB6UsalOrcANvWByFSS32NhBy6h1ZIAf4ze2l9gm39Soj48vRK6rosyTH2MdffjJnaMQphvJbtTj6Fe8DoZdPmB9mVnYt1rBfcVM6cR0epR65qH5JZ7fS6uaf9s4qJSMq8bY54yeRfPi2X3WVynJcMkCZr7RfoUjtlq5TAMV0z+8bdC6ZBsRcrw9jEwN9vqCDmU1AhnrOJh43oZ02/zpHdaj4Cv5cicbPq/lhAHQKeFYcn0FePv9d6/MIv3m1wu1gs3r/kog3aH0HT6ciJcXxixoXeDj0+T0/22/HqN/Io/oqDvP2TSJ5xKBDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L6Ilcaidr9Rn6NrB9HA5AShNaGcdr8h07rDmXiOWn4=;
 b=DBm9rGj+lRFNvO7LHI2uiSn2S6n43AC8gzJ0yM16xyx0KkOeWvnh+FkJBRBDq+ATiKccPoRdF8Hqo/mjSMBJfMISEh7MBS5rh9TVYpLfr5QgyBmmfxi6DsLpM0xW2y6t6jWdzwh6WGtzCDeS1zR8ospoqK+RfSHwsWWeX5f/x0E=
Received: from CH2PR21MB1480.namprd21.prod.outlook.com (2603:10b6:610:87::22)
 by PH7PR21MB3945.namprd21.prod.outlook.com (2603:10b6:510:249::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.6; Mon, 1 Apr
 2024 23:21:07 +0000
Received: from CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401]) by CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401%4]) with mapi id 15.20.7472.002; Mon, 1 Apr 2024
 23:21:06 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: stephen <stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Topic: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Index: AQHagiFTMR5ZlnaVikeExhfsF+DuY7FPaYIAgASmJ+A=
Date: Mon, 1 Apr 2024 23:21:06 +0000
Message-ID:
 <CH2PR21MB1480E02C74E7BB5A52A71859CA3F2@CH2PR21MB1480.namprd21.prod.outlook.com>
References: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
 <CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
In-Reply-To:
 <CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59ee9ed2-1d2f-476e-81a2-fdbc522a1f8e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T22:45:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR21MB1480:EE_|PH7PR21MB3945:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h9jvz3KlGUjge0YtfRZuLJ3JvwmvmPmih3u7bc2na4kz8l4UbvYUKy6LMYlKjPCYPfUkVSd4UjomZcl0KiZemI7k3wyVuaWxdvQmPmnyIugR5BmGyJ15HZaC2GqdU0JVM47jMd/U/f6DbhhOWggutX0gH4y1iDzu/8wsCnKfvN+ooaoozWGtGhzOAcRsrgV/vYDF5hw/ZpuRmRts1lk8nfC3YFX1l46mO8OpW3FVINd42WOQ1QZtR9Fi0Bn1A6W/i5I/e2iRWDm+oXuOwMPbVDrIFnMX7a+d0xgEl8RGkX0ZABIX1c2czkQgVjwFsGiKtBQ4eKUYjxzb0o7y6+e0rHUaXU8J6We5EjlughcgSiyOtITGh72gEy1KOrvAJ3rilIBE4jwLeSKJ1+sZVXZMhcDEdLUva9DgIyjjfomGTHQluhIBbZ8xMhCE92WkSM3/JOs9RuIYB82R2ZZvr90wSy0J8cqidX4o/0B4n1xyqn1o1u7SpDn7CCkqEW6XG/R28ZcsU6fGcDXgFeMR3EXoEnskXvQZahTOFOY8x3wyE5gbKxlmZ5kYVo4906N9ukLK85Ok+3mA2Iuavhw2JHZ1J7ekHBDVLVxCfPDn+f5vbcNlAjhZI3syrv2SSQERF3Ad62v9eygwR17FfAhgVLuhZJUdBprbyckHYZ+qanpZDek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1480.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6rg4Kjo4TTfbhFIHkITX0esBDrxoNDG7ud2a/pJhBHYsclpZxlaTXQSJQXND?=
 =?us-ascii?Q?whV4Msael0lm0tacy0uVTaYrlkT4PnrnjDyS4X5kTA8ex7v6zdzBoaefcbvi?=
 =?us-ascii?Q?tXTkN3YhahcCyZXXgOqxxz9CeAdMA1Varlq/F6W8meh8rVQdu7HGFS0G0BD+?=
 =?us-ascii?Q?etAAis4C7TKQMc++qMiSwlwW67T2WVPO60nRRfsZKvDMMNXmhLzu40X9jOOM?=
 =?us-ascii?Q?JghgfY9OFbZWTOuYh6dc/4UpuGVLWwNBikDZQ0xdogjUvVVfIUTMnbhSmLj+?=
 =?us-ascii?Q?3aAMntE3tezxOLUeG1dHv4oyzkM2xtKivjzGhATFRG5m7OalWxHSx1T3mtDE?=
 =?us-ascii?Q?S2oz3QX16RIyebQpNI89Och8hmkgUfscbEmbK+FnlwRVX59PkA76uFk2wD/5?=
 =?us-ascii?Q?SpvxVKq1EkBkStLMKJ/KLweE0GLFT7RuJG3R1jPwdjE11nFEv5WVCg49NQPP?=
 =?us-ascii?Q?tQ/9mchK2P/4qazkWmvPAZNbLlPTvUOAFS8UoPA5md7fJrjaMYdbNZfstjmc?=
 =?us-ascii?Q?nGssVqsXj4BorJqrHCIzIeW18iqpkpAab5C9bpA3pwVzsT30hJ3aHtMWFzbZ?=
 =?us-ascii?Q?cJBp1fudKoqW1jHefL56fJwEbAwWBo8kMbKBvBcOSbg0j1DqahYsvnLuiXJV?=
 =?us-ascii?Q?PifvBtvTpldwX3n4esLSxs7GD7zP6WKjfi6pLxOwDqAztV/rLIip8PpGrqZ0?=
 =?us-ascii?Q?yywXd3wSCT2Bqp+R7WOGmvu0CPhg1ceIH42dEzNygrNQHY84NFw+sejRi2EE?=
 =?us-ascii?Q?JYvB+DLvmKKMI60ithEguyWpfgFPBmgOcFjlaADPFmeDcVdA6WSvjW1xn99A?=
 =?us-ascii?Q?9Hjy3YBmUcqtGH0yioFmrbZW0q+RVxUCl47n4itpwzYXGbNpOTueYhNkjQfW?=
 =?us-ascii?Q?o5Pk9BEleezRNMN6g4VhEX9TxxrWtIILIjUlm+5J6FO4DelqMa1hD9dG8Be4?=
 =?us-ascii?Q?mbxalL0tF4i3rvR/7Xmvk9EsXUO6dMOzJHvcXpOeherQligUHY+v4Jq8Le98?=
 =?us-ascii?Q?hJ7SLi7G/NbX7tSVnltcoavgeDioRB7iZ8/xX7MPecCOqtvegcvOkNI8cXm/?=
 =?us-ascii?Q?aOwTxuI3lmq99cPy+zpFPTbA4wSP6NGSbcQ6FUYdP4ra/CeasRbKY1DOmHS9?=
 =?us-ascii?Q?bfuKD+nFXf5RkMzfCVIUsNeg+XOTJX9aI/NAzbLtaaArbR/qYEmR5zLaaIAC?=
 =?us-ascii?Q?Mmky75Y1prfjNnpCzuuAwIjHS5wIMcCAxeBYfXyiSg275L9eqgSIlmHaayYq?=
 =?us-ascii?Q?/JdYorphDHDmWLCAs8XWZAUfVxfO/Zv04sMT7jyLEywqq9erOiUbctspC0ee?=
 =?us-ascii?Q?iVFUKXbvgaVo6INNKtd4cQDi56lOHFsLItAhE7/YbwL2Wy58jkNqYVCx4wh8?=
 =?us-ascii?Q?YIdCk9mCKnuSkTasUyrpOgLBuwzUyT7fySs2Vqz5yv52/mVrlCoJX/lyVj2P?=
 =?us-ascii?Q?oodMTuVLsKIdnTywGciFS4rlgTim3JVXjNjhhpxTOZZr7ZkFOkrVJTcloMhd?=
 =?us-ascii?Q?frgb47R6p2oDQQ/p3+6up6+Nrgx5ngIYVU6BAdSx8AvkcIqjHRN6vZYkSCYY?=
 =?us-ascii?Q?BS7fGUOEFgddjqnSrHxkhZUIAk1OJV6LuoZTik8c?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1480.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97383581-7ba0-49f1-a9f2-08dc52a26841
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 23:21:06.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MUB80jWM1AiXb+aNYjrJOBPYLxQ2a05+qpcWmHVhwAif+q2HOmK8geeU+A8vkJw0HLHAjtA2sssRyswcEoNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3945



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Friday, March 29, 2024 8:12 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: stephen <stephen@networkplumber.org>; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; sharmaajay@microsoft.com; hawk@kernel.org;
> tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: RE: [PATCH net] net: mana: Fix Rx DMA datasize and
> skb_over_panic
>=20
> > From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> > Sent: Friday, March 29, 2024 2:37 PM
> > [...]
> > mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
> > multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
> > can be received and cause skb_over_panic.
> >
> > Sample dmesg:
> > [ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536
> > put:1536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700
> > end:0x6ea dev:<NULL>
> > [ 5325.243689] ------------[ cut here ]------------
> > [ 5325.245748] kernel BUG at net/core/skbuff.c:192!
> > [ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
> > [ 5325.302941] Call Trace:
> > [ 5325.304389]  <IRQ>
> > [ 5325.315794]  ? skb_panic+0x4f/0x60
> > [ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
> > [ 5325.319490]  ? skb_panic+0x4f/0x60
> > [ 5325.321161]  skb_put+0x4e/0x50
> > [ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
> > [ 5325.324578]  __napi_poll+0x33/0x1e0
> > [ 5325.326328]  net_rx_action+0x12e/0x280
> >
> > As discussed internally, this alignment is not necessary. To fix
> > this bug, remove it from the code. So oversized packets will be
> > marked as CQE_RX_TRUNCATED by NIC, and dropped.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> Network
> > Adapter (MANA)")
>=20
> While the unnecessary alignment indeed first appeared in ca9c54d2d6a5
> (Apr 2021), ca9c54d2d6a5 didn't cause any crash because the only
> supported MTU size was 1500, and the RX buffer was a page (which is
> big enough to hold an incoming packet of a size up to 1536 bytes), and
> mana_rx_skb() created a big skb of 1 page (which is big enough to
> hold the incoming packet); the only issue with ca9c54d2d6a5 was that
> an incoming packet of 1515~1536 bytes (if such a packet was ever
> received by the NIC) was still properly delivered to the upper layer
> network stack, while ideally such a packet should be dropped by the
> NIC driver as we would have received CQE_RX_TRUNCATED if
> ca9c54d2d6a5 hadn't done the unnecessary alignment.
>=20
> So,  my understanding is that ca9c54d2d6a5 is imperfect
> but it doesn't really cause any real issue.
>=20
> It looks like the real issue started in the commit (Apr 12 14:16:02 2023)
> 2fbbd712baf1 ("net: mana: Enable RX path to handle various MTU sizes")
> which introduces "rxq->alloc_size", which I think can be
> smaller than rxq->datasize, and  is used in  mana_poll() --> ... ->
> mana_build_skb(), which I think causes the crash because
> the size of the allocated skb may not be able to hold a big
> incoming packet.
>=20
> Later, the commit (Apr 12 14:16:03 2023)
> 80f6215b450e ("net: mana: Add support for jumbo frame")
> does code refactoring and introduces mana_get_rxbuf_cfg().
>=20
> I suggest the Fixes tag should be updated to:
> Fixes: 2fbbd712baf1 ("net: mana: Enable RX path to handle various MTU
> sizes")
> , because if we used "Fixes: ca9c54d2d6a5", the distro vendors
> would ask us: does this fix need to be backported to old kernels
> that don't have 2fbbd712baf1? The fix can't apply cleanly there
> and is not really needed there. The stable tree maintainers would
> ask the same question.
>=20
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
> >  include/net/mana/mana.h                       | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 59287c6e6cee..d8af5e7e15b4 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -601,7 +601,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32
> > *datasize, u32 *alloc_size,
> >
> >  	*alloc_size =3D mtu + MANA_RXBUF_PAD + *headroom;
> >
> > -	*datasize =3D ALIGN(mtu + ETH_HLEN, MANA_RX_DATA_ALIGN);
> > +	*datasize =3D mtu + ETH_HLEN;
> >  }
> >
>=20
> I suggest the Fixes tag should be updated. Otherwise the fix
> looks good to me.

Thanks for the suggestion. I actually thought about this before=20
submission.
I was worried about someone back ports the jumbo frame feature,=20
they may not automatically know this patch should be backported=20
too. Also, I suspect that a bigger than MTU packet may cause=20
unexpected problem at NVA application.

If anyone have questions on back porting, I can provide a back=20
ported patch, which is just one line change.

- Haiyang


