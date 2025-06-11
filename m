Return-Path: <linux-hyperv+bounces-5876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D6AD5D54
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 19:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196533A8A5A
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB76221F1C;
	Wed, 11 Jun 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jBK5PV4W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022123.outbound.protection.outlook.com [40.93.200.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BB19D890;
	Wed, 11 Jun 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663416; cv=fail; b=c8irDvSrRnglzjk+tYrYadtJkGG53+bOfxRmqQti6qXYlXsKd5h/z56CuVBBbdHu4REl+g8UW6jr1Ia86CgBa/GLopXmBqLc10v1DyEGj7Tt91HOI3MArUPxfXBtNz465EN/ehyEuCUf/AIJedrLcS9D4PWsMZnXmEjsvVKxa10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663416; c=relaxed/simple;
	bh=LO0lR1u4+O1VQRbdd3YfeRcgmaj3llnqigsNiFJTNgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5iTeNcUfVQRUYjjIpwuR6w+TA446BwIOPn+vvZtfAmFgbf5PvAx6EwDHeq8yHkk6ZDGYH8a1dXz/yDwAZ5LT/m1LBjaOJqL0m5/KcZ6NyplHYe8k3Sz9cpsCgtFZpK2tuJ3ec6c/YWs79ipSd0S3KSI9YK4JK0n9ay8nQIk1pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jBK5PV4W; arc=fail smtp.client-ip=40.93.200.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwpMbTEdir/aOa3GFD9lJBWx0zwjAMkpDoRCZgfyWVX1kowCNYDpO+PCPSdndP690+gPVsLrF4duu3VedwJJGbnptR8XWiJj4p1gcGy51pvRxjcGZWxFkeEjm3i8d1/ms2clo6kHjwoE6VWYOE3/j7chQDTzgRTwo2PGdAaNQeuo/Ymq1fR/GhS8362Fm6xPdAuN5E2lEXKcQkyGBrHmGWzc9QwOyF9T1WqbpBlUHVePjMblEsJZMxulu79z5Blh7v8eYsTh6xVj3Aw6T5UDlhWG+PoZU3ic+u2miHpcUdzqEH1+Y4vsz3v10/BVy2cvapLstXpG/Pl9WvvgpA2c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moGdc9e4E0UnR+uZbnzDgs/rkt0q982icabrdVJ8UzU=;
 b=ylZYolAtpwK15cVMUoqVWP65hjn9oU5L0V0ZjNsi1/+0dDNj07wcFU4Q/b1Ghdldyp/6Ws1/GiSjoNncPUlH1SAXOKZeCjdtW47sU+DWiwTIMuBi28pWpAWwDTYCxGpBly4WVlAYSQ6W5nx1zSEQqB8MvTwqRBqjrj7NhMxo/P4M6qXCVX9uxFJ7DnC9rfxaF5TAmQ5JmilTq8MYCqOx/qIXL5CxPSZ2inE97uh4MhXoWuuuhqwdngiaynlhCNbDRetObvpiBmncgZ8J/S3/lB21mnYyHLFDDErj7JyEbCpnfKRSCOFCzSKI9OhTsukDz9BC1Ps1aL2iuxY0ZM4UaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moGdc9e4E0UnR+uZbnzDgs/rkt0q982icabrdVJ8UzU=;
 b=jBK5PV4WNvwKXqjQqVDL9hHmvpqpcwp9WSf/RbdaBPbfWlX9JcB3m4qZlZKwy1toBl4U1w+61WtqrcY8ydlEFWYK/wwVYVwo8E6/Fc1Ojqswr79INJEzTk2bqcPMwELCOfM2NQrmX5eqb9RrP+2Y6hG7Pr3UoOwax5ZzB+b2VLI=
Received: from LV2PR21MB3300.namprd21.prod.outlook.com (2603:10b6:408:172::18)
 by LV8PR21MB4339.namprd21.prod.outlook.com (2603:10b6:408:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.14; Wed, 11 Jun
 2025 17:36:51 +0000
Received: from LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380]) by LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380%3]) with mapi id 15.20.8835.006; Wed, 11 Jun 2025
 17:36:51 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
 napi ops
Thread-Topic: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
 napi ops
Thread-Index: AQHb2q1dvqd7zLnej0iG9VSKCfeEGLP9y60AgAAfF4CAAE544A==
Date: Wed, 11 Jun 2025 17:36:51 +0000
Message-ID:
 <LV2PR21MB33009692C01762F9BCF06D98CE75A@LV2PR21MB3300.namprd21.prod.outlook.com>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
 <20250611110352.GA31913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250611125509.GA22813@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250611125509.GA22813@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff282109-80e4-4ac0-a4a5-b60020952bb5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-11T17:35:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3300:EE_|LV8PR21MB4339:EE_
x-ms-office365-filtering-correlation-id: 56c0a3fe-d862-479e-3562-08dda90e8cb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iNCNy96G1II2Fdduu4VNSZUDUnThCmRDZc1ZsaKZQrmdmp8+ljMnOJSJklBf?=
 =?us-ascii?Q?yuFYw21FxfCPpSEzgMn0C6G7uTOAo67bjx8gAGBn7BFTV5xuLqHgRuoqBYBi?=
 =?us-ascii?Q?eolDx0iFUPPBUmQagLO2O4SmvLQG5cQDns5KqlM5nWTLAID9upof3BCzXfxJ?=
 =?us-ascii?Q?zo3C8uxKj+L10NjBJWxOL7Yw/xbJ6vSkE2QZjYbXGO11b+Uo+Tjde04XQKl7?=
 =?us-ascii?Q?kq53MmhT6TatPXt82ca6NgoGv9Rw2VT2pJPvDzJAm2zg/FoChFFk31s15BDV?=
 =?us-ascii?Q?VjZdj6pRkB8nm1wynuTojJLHaH4WDtOmgJqDjJgIqEwhgOLssxB47Q7isLVn?=
 =?us-ascii?Q?7rcqY0hWmY9/lSqWRMhvp4GKHtQCBP6OCmY1h4NSubon0HgqXrpOfl8GjnF7?=
 =?us-ascii?Q?d/TchLqmou6OrQvk45sQ40WFa6sj0G27cny1skLbBrqVX+BrmJ9X2dzl7eBJ?=
 =?us-ascii?Q?noNgEDcjZFaZgEZonIhbcLYOld6ZytvdPcg2fo5N7q0twwEiqMwqVVkC4Ldv?=
 =?us-ascii?Q?7Zcm6R8cw8YkWcVycG5pVGER+nM7oLXMlv20t97Nm6+9wE0HgCJJeNFDxg/H?=
 =?us-ascii?Q?wFDj8QjU0bHSFTZMNcvdRfPTMn7cWzelce812vpTGzxemsqKGXoF1huqKBfX?=
 =?us-ascii?Q?Em1hir1im1CuTKZ5Tesz/NG8iUJT0ninKdL2qUKIrAaRMb6jQA65bLwGsQHI?=
 =?us-ascii?Q?azypx6zYYFizYUlQirAxA/iTJ+aM4/r7oqm1Z8pashifN/92ZDAbp/OBGDrq?=
 =?us-ascii?Q?gqG4Z2hq2U0qJn2fy6Tim5tYULgJBiitwPfy3LTsvAieLlay5GVTYB8RXlKE?=
 =?us-ascii?Q?2YH1ad/2QDp1cY9xwGXS1gLygsam1p++Bc79laMDWfepYVpE3+9EgNCvM9S4?=
 =?us-ascii?Q?c8s+jiElhZNWW/uyU6XChwMaFI9+8aZQdkwajbLgnOR+KH47Fu4Z5nCunEJp?=
 =?us-ascii?Q?QM+MM+xstOFMLxvsFPd5vc06MHpuXHaWqGXEyY1oef/IlFtg9pvv/h5ThC3B?=
 =?us-ascii?Q?4WwQqRT7lB6HxDRKr/NpF5Wd9GdohBTV+TUMMfsu+0ebHsuw4lou+67bfWjc?=
 =?us-ascii?Q?uCYGav831OxMf7fCfpmWTuCNRKw8T5PcRNfuQMSrXDkL9/bySje6IpkwBkkE?=
 =?us-ascii?Q?SPNgnibCjxKzM6K03HKyYRH+CIUd6c5x7lvNRPOSov61USVj9kd5HK5u1k+z?=
 =?us-ascii?Q?LcLpjSTRuOgCt/ys7PhM46tHit+sFUu5h4s0QzvJtDGt7PqkAlaCxuYhj5/t?=
 =?us-ascii?Q?NUNuPmrZFzU+hO2Fy8fngKJxIunWpfYEwEb3ccKiFq4Ymxw8QazHJJEdxNKf?=
 =?us-ascii?Q?dwutRm5v8kmTCITsZ38MfJzOocx0XhGemuupitUr/IeE2XwadQbBgem4J8jF?=
 =?us-ascii?Q?hGVTVGc5U/GUmAilDrKLZx8yUKuIgOF4tgKy+FPW7eX4wWZDnuOYVpQDhgdv?=
 =?us-ascii?Q?5rB2gAjxxtyeMQF1P4xQg9C89ewEG0vKjVSi35j0Olg0TFJcDJ+NDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3300.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Eg1VOfYWoCozUwkE2U7lP2R5xBnglhDPcJVFszlUiE3bANnRPBTcztzHZ+Jd?=
 =?us-ascii?Q?c+BviVsnxrKCqCd9Rh5B7GxbFqLMhICpSUOcJe1Vl2Dv/Z0JTJQIUXaoU2aT?=
 =?us-ascii?Q?hUbpq1t76q0X6wdp3upnBtsZLr++Gri5IDlTVwiHltbLR/loDIud099xk+hS?=
 =?us-ascii?Q?qCaXsJOyzUbzRl5XIADcW2BB3HQ8usE/hXtq0SHTPzYR6lPbzYvdT1effSCS?=
 =?us-ascii?Q?PIXEfu/mamCW/gP5TtxEXaF9eEYUdBM3/7aLJTv1guNGrv+yLyhLY6HRuewC?=
 =?us-ascii?Q?x0n9AbiFj1/e571a01uI8twKoTEOKzSnOi/VtLL6Ca20s4Ca2hiOsgfmhO7P?=
 =?us-ascii?Q?6lBV6Wsqr/2DFdXWjTvpwL1fLjSasB++1QiZcOY3mqAgHd5occ50TqTC5w4v?=
 =?us-ascii?Q?37Tpao9Lh4NIk0DYf1P/SsogQAbyiyyWIjOvKi7otx7D2MTT3Xn4L9GNOf5Z?=
 =?us-ascii?Q?cEcufPt1FdUt8gtdlOyQCi9n2lTsa8f9emnodP+PaB7gdv+4Jbkd5wc8zxjL?=
 =?us-ascii?Q?W5pxPXLkcoqa+/2pmzQ2O0C705KnJ6oLh7fG6cAnzVo8Cho2HwBUDmjFlJMZ?=
 =?us-ascii?Q?kZht9+8/CYh5Xt+rG9RWoDnb2bFYl6ds90iyteERLmmqZsyLYhzuuvHBaQ0l?=
 =?us-ascii?Q?jUwPPaHKUcmep35UVTZrYIMQfinrnXz6yM9KLHLcCjEL+M5A8lAaIIKZW6jq?=
 =?us-ascii?Q?pU+zGNKFKYpB89Bn1FZIezSMQzOhVw7QfaLsOIDTy2YxpbtjrrZC2K9Tcbgp?=
 =?us-ascii?Q?HEiYnjD8WubFeW3IXzwrfwjLalDaM8ZbT127jDxProOGJ8Il2Am6459mrbN6?=
 =?us-ascii?Q?StLBb5NNOIaPzoeI3JGJNqTQKNKLkiRjvAXF0NtEV4RgwZip0YS5SF26nOlp?=
 =?us-ascii?Q?tWR6nFAr6w4fo2hG/Pw0igTz3TeHEux0Alb2VIrNaiQHwzGg86HKvRfJu9IN?=
 =?us-ascii?Q?F1Uj1HfxJgTHid7AwhwY6+eOFUj/NqoLJQFCShsPTocM59yQ5GmZBSaGJSDU?=
 =?us-ascii?Q?jLLCmJEkK1sPkTHWt5i1QirdlEPLg9kJhC5sjiOfZPfsp9+Bsl7VUgUv8qNv?=
 =?us-ascii?Q?N2kv6CPZ6hHC9cHCtZ9eIw578IOS8QpLSlpUf46lOpwAlvpUDJD+0SY6wccz?=
 =?us-ascii?Q?Y7vto7nmCO9Cx/Res0ldvN9fRceKYdfkqoN/Win2B/FLKbsZDdugIHwZNk6r?=
 =?us-ascii?Q?KfdwC0pdsLIRlKvSUH61B26D42LBhj+D5cbZEoy6WxNToTJ2P7kjj6Dy7Zle?=
 =?us-ascii?Q?TlLv8gux3x1bwwLKIn5VSxqzDPVZnpiNwv3w8aPLth8EtxjEXNS4E+8Ijlrm?=
 =?us-ascii?Q?mHzWk+FxJ4FO19J6mTg0hDOhpUbGq3dK5SBqnESAc7q/ZhFa2NRAwZjIom1t?=
 =?us-ascii?Q?X77cO/miFBzeakzGPgbZ9mi2id87KFQoFSZNqzkJFnGjWtHsWLeD6V38i2Dy?=
 =?us-ascii?Q?b4Ni1cIsafaLWv3sofsV6sLM58tftTpv5lLSqzswDJGPs4LJN4okeC7zMKOF?=
 =?us-ascii?Q?W/Lo8RSG/Ps8l9EBzlYqhELWGaQlD6ZzNnTIyhVIIpFp8zuO0v1IcSWZJaBf?=
 =?us-ascii?Q?PO8ZCyWVigCQtppiGfjh5S+1EUixmPF33qvOOJ3V?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3300.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c0a3fe-d862-479e-3562-08dda90e8cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 17:36:51.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIpTNidsun7YWHLCdrhtFyCk1huyLv0R+NsrDs35TeXbwpaDkuQScGHeKXHOoOdxbOclenDNpv6hJwL9GlJS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4339

> Subject: Re: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in m=
ana
> napi ops
>=20
> On Wed, Jun 11, 2025 at 04:03:52AM -0700, Saurabh Singh Sengar wrote:
> > On Wed, Jun 11, 2025 at 01:46:13AM -0700, Erni Sri Satya Vennela wrote:
> > > When net_shaper_ops are enabled for MANA, netdev_ops_lock becomes
> > > active.
> > >
> > > The netvsc sets up MANA VF via following call chain:
> > >
> > > netvsc_vf_setup()
> > >         dev_change_flags()
> > > 		...
> > >          __dev_open() OR __dev_close()
> > >
> > > dev_change_flags() holds the netdev mutex via netdev_lock_ops.
> > >
> > > During this process, mana_create_txq() and mana_create_rxq() invoke
> > > netif_napi_add_tx(), netif_napi_add_weight(), and napi_enable(), all
> > > of which attempt to acquire the same lock, leading to a potential
> > > deadlock.
> >
> > commit message could be better oriented.
> >
> > >
> > > Similarly, mana_destroy_txq() and mana_destroy_rxq() call
> > > netif_napi_disable() and netif_napi_del(), which also contend for
> > > the same lock.
> > >
> > > Switch to the _locked variants of these APIs to avoid deadlocks when
> > > the netdev_ops_lock is held.
> > >
> > > Fixes: d4c22ec680c8 ("net: hold netdev instance lock during
> > > ndo_open/ndo_stop")
> > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 39
> > > ++++++++++++++-----
> > >  1 file changed, 30 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index ccd2885c939e..3c879d8a39e3 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > @@ -1911,8 +1911,13 @@ static void mana_destroy_txq(struct
> mana_port_context *apc)
> > >  		napi =3D &apc->tx_qp[i].tx_cq.napi;
> > >  		if (apc->tx_qp[i].txq.napi_initialized) {
> > >  			napi_synchronize(napi);
> > > -			napi_disable(napi);
> > > -			netif_napi_del(napi);
> > > +			if (netdev_need_ops_lock(napi->dev)) {
> > > +				napi_disable_locked(napi);
> > > +				netif_napi_del_locked(napi);
> > > +			} else {
> > > +				napi_disable(napi);
> > > +				netif_napi_del(napi);
> > > +			}
> >
> > Instead of using if-else, we can used netdev_lock_ops(), followed by *_=
locked
> api-s.
> > Same for rest of the patch.
> >
>=20
> I later realized that what we actually need is:
>=20
>   if (!netdev_need_ops_lock(napi->dev))
> 	netdev_lock(dev);
>=20
> not
>=20
>   if (netdev_need_ops_lock(napi->dev))
>         netdev_lock(dev);
>=20
> Hence, netdev_lock_ops() is not appropriate. Instead, netdev_lock_ops_to_=
full()
> seems to be a better choice.

Yes, netdev_lock_ops_to_full() seems better.

Long

