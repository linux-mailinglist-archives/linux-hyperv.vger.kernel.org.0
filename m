Return-Path: <linux-hyperv+bounces-11621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oDW3DBzCLWpujgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11621-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 22:48:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FD67FBBA
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 22:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=FuurhuFV;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11621-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11621-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595E4300B9AC
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F330BF66;
	Sat, 13 Jun 2026 20:48:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020092.outbound.protection.outlook.com [52.101.46.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AA1E9B37;
	Sat, 13 Jun 2026 20:48:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383704; cv=fail; b=sdFj3T1/rpToA0jKGZqrdn58z0CkW1KWWrXnSpNsbaJad7baVbfnFMGJtnbA58tECStRlxJzpY5UmrWPOPVAIauNWhQGkGTotLT0HbTdWKTMbWOPiEXDoDiWzivuTe0V/zbi7iWfwdOGeNiSgG6TOiFZ0JFJJMIc+qkkKen1Gy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383704; c=relaxed/simple;
	bh=TfKWvwYrH5yHfoyUG06TpMTU8BZ+fQP+Kwl++GS7A/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwYUcsoU+qZNO0Qhx9/jPGuo3JU+12dhG10ypPNWEUB5h0iitWES1MZES+14rYOkbOOASXC5RVpm7nzhntiL2YhE0GYXqmWMRHeMaATMsA2S7B3K2Dh4AtIrx3x581mGVFOU0W8/+dfnsiNPGNcqcomWydZkeY0eAVVwWBoScU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FuurhuFV; arc=fail smtp.client-ip=52.101.46.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f14MSLRQGr6nsyCQTBm/x+nglPCvHdTHzpWz3DkxkdcG8msoiyJWdLpz0LDNJbkG0L+j/4Ifg4nphuF1WdVClXMLcAboN9HjuhwTimHaBy5FFRDlOcMhKDbVg0Hd8uR6FF+A6zlrVMUz2DhB1Ibi4uGSb/ipPnkUF+AYY4c+kFT5F/0mwWKJML1WWB/m1qmffHCpiOsVIYu4qBIl26+JhnM8yqueE2tZcJCjliFaYTKIe31EfJnLOON4PPuVcWei5Z+nEiTqGQ2fTDyy469dljsUlGj7btZ+DInjQC82560V2MuLWxKp183HKrbmZnL+yVKYKcgxeyqczKpYMZrCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8ynJsWPc+SplKEdeqfTjkConnrNe4J8VQk8HIe1JmM=;
 b=Sr0xJ6j3rk+eGZBnL/wI+8Lxcp8C9HqBnXFhz+iMzZ9TcidYIYRSvTUtqeupGCw/lDqGPj07ZEY7jb35a6CZg3OmZY2ZcUdoY72eMBUxIo3dK0hZk3V5WbxMi0B11k9VmABZ4maZHSPBA94jw8Z/4xQexBiYDgvNbxfzOEgDAGwmiby5Or4tkuAj59dk6iuUcH8CJzHDkCF01FVbwqwcVKU8L9OUkcpE041C0OuQ7iZ1OqWYHM8BsGXRWAgIUjbE8HqkEfx1Q02RumfqYqVDlUMIvHiYKrdqhDN0yOvHJYKL7d/VNjkT0mHox+u0yK5FTNAXvgOmcahtEmRJVGdn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8ynJsWPc+SplKEdeqfTjkConnrNe4J8VQk8HIe1JmM=;
 b=FuurhuFVywSbpBySLi3Td9LRd6K8GPxjWOCe1rfNKDTNad+iiCRuARuzl2mCvpYsrfogEMDoBHbokn50JRd8uoeB9Xl9LwbsnUqRNGhGzftG690IqGE6ehkugDC/sdOXUhX/ZOzXHN7jdbJl0xeGQXzp4e2w9IUeCc+GQdW/swI=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB5937.namprd21.prod.outlook.com (2603:10b6:806:4a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sat, 13 Jun
 2026 20:48:19 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0139.005; Sat, 13 Jun 2026
 20:48:18 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	"gargaditya@linux.microsoft.com" <gargaditya@linux.microsoft.com>,
	"kees@kernel.org" <kees@kernel.org>, "leitao@debian.org" <leitao@debian.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3] net: mana: Add Interrupt
 Moderation support
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3] net: mana: Add Interrupt
 Moderation support
Thread-Index: AQHc+dT0MmNj+txjpUG1Qor5J83NQbY8J0EAgADOfmA=
Date: Sat, 13 Jun 2026 20:48:18 +0000
Message-ID:
 <SA3PR21MB38675970B36ECABDA7E9C72DCA192@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
 <20260613082014.715350-1-horms@kernel.org>
In-Reply-To: <20260613082014.715350-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8a1479e-2569-4f0f-a4ca-7854f4e2483e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-13T20:39:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB5937:EE_
x-ms-office365-filtering-correlation-id: 3d63e690-4b1b-4563-52b4-08dec98d1969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|6133799003|38070700021|4143699003|56012099006|11063799006|4133799003|5023799004;
x-microsoft-antispam-message-info:
 swGShTvEQijOUMI/3oK7LRM0S8yvE3EE6LW213ia3IdUBalm3HtBqE4mcwjq8R7MpNaEA4KCWQSjl9jl8HFL10GtypsFUepY7D/ar2Xk3S4I/LB0QiA4JlM23wx4N+TYURzkyOam6TabtNdNgzLaH0iHaPhrtoCFGha2DhBFRX6HZGy/Ak/AqLm/CPOglChJSEQuoCCEntt6jYLdaiFloOy4hoYgy9IFILyjlRRj6XIMEFKPRrqpWEsjfamv0yidTaib7xqOFFZIxSqOIX+OABzz+FSeW6oJzpENnxU69cguVTYPv1t0QQyicAsfpghNwN/g6CZ8fef0tXqymoIkvbFm9Wp8mREjKtdKC0ngMu1w0x9qliYKxVNqyuXIxBTb4rpgZsz7H/ro6BAJAfz9SEdV0jdjZnNlu8Usih9BbQBeTOTNHAk9PBft3nEouj6Xxmorn6E7Ln3pjQC77WczMcryO4wq9ffcgvqqlOlUtaVH2MmNHSiiYjKUggV0MAwvFQtf2MK9BsDy/tKLvQlgGtlnRuoufGDEE8nJmncD5o2Ymk7ogEB1meSEFCYCJIlJHtfZgnXsLoxE7341NWBNKZMhqvbCKzVpRUh6Ks59CXYL2TUAhFiEv0kQzmom8a+Cz0+g3QXjpururSwTCNr+lMc5szEwSPlcwsbAkE+3XmQvV+3OIh5pCudzlO+Br7GBjcUcs5kbwB8/RhL6/XbEaVNAoYCOOc1o/nCKayHKVLy3RVBRX1pll66vxHwZQSsF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(38070700021)(4143699003)(56012099006)(11063799006)(4133799003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qtWUhmajZ0ZnVG6jfDNjzqkhX1dLH4iO+GW/1jwEtMmvXfbIOMW3kPy1rkgV?=
 =?us-ascii?Q?xyGM1X5/ZKI7gJW35LmhU/6R3xBIy4+JBBjKnz7k+4cXX08cBZQt7G4lKS/0?=
 =?us-ascii?Q?PNa/s7Y1xxMtSqo1QcnP2opDIwhX4q4sBvnU7mthHtL8LyU/0CgNXq66ARYF?=
 =?us-ascii?Q?GLZHkyQ99lzUwc7jCA9NBSxJY9vxUooTHfRas/Sp1yiNak/12fXzAd0tE/+E?=
 =?us-ascii?Q?a0XMpsxix7nIaJHAtnrjcQXay5b6Fl1CSVWJm2k2a4/vv8mfaIjdGMjF7Vq7?=
 =?us-ascii?Q?SgOoAWz3uEdFao+o5H4KIHIL/+R154OPd/toGN3wVandTmsBTz4s7NfYCF/M?=
 =?us-ascii?Q?aMcdv12oqmUlXxe+wSxU5BBkwnF0dy99Nhvym7ht32iUJXJ6IchUvQcAmoJk?=
 =?us-ascii?Q?AoDWLPWW7VxTrPmLgPmCODJ0+CkSHE5CaYUZ+vyHP1H8ub21UILWoAVlYG2U?=
 =?us-ascii?Q?Yn1TMWA0q8qQyHbZ5gO/PxPlVc2j0vfdxTsLt2DUL6WnEF42IeIDiP1ZSMaY?=
 =?us-ascii?Q?05h7DptyDafZOavRiDPrraLoJ9gXIlxvuCtR53CmWxu79u4SEM/3HxiMyoUS?=
 =?us-ascii?Q?9Jskoh+Wp0Is050+wdrFJeGjarI8ZUv7F7QVd2Lw455A/sEK/xI9a+xwyMaj?=
 =?us-ascii?Q?isvl4ZWr9Mlswnf6509/g82x0l/PjD4bzFTykade6mxxQRUc3XT49fO7FvjD?=
 =?us-ascii?Q?sphi8LwiGc4cV+1OV8hCXF5fYodMNPqZUcasre1YBfPbncTb9WxaMige5eak?=
 =?us-ascii?Q?VjRKbjBZcOF6DjChFqkGr9Gss0ncfwJlGh3S/t9nUmx9In1NW9BZVQCBcjDF?=
 =?us-ascii?Q?rBH8XtWt5CIp/TxPjgHWdl4CLxFQeDul5yzlE+nGgLlZgJ/N5Q6pK6B/1n6/?=
 =?us-ascii?Q?opn06gnx6a5yNUlLFjXQTGRL9cSy9ZtniL4cBD9eHOIkuzC+kAU68nXYeCji?=
 =?us-ascii?Q?PC06lSqTsY64V+dPr5FbqVgm2fpwjvlji/zgGt3vQThPo59xwQ9wv0+OOAmb?=
 =?us-ascii?Q?GgxbN49ew3f3lAPy+kL9qf6+KD8MymY7kCvbTc6zqSnGrj0LiQoaFR2KaTZm?=
 =?us-ascii?Q?8F2cmyR3B2R8tr4bhK58pExQNSNxEH9ojV4dw75EK/Yk30wr97AT4blERc0E?=
 =?us-ascii?Q?vTJGaYqXDGCiALDEA3F2G5mNhzSXXmCemrsq9Q9066tCJyN0YYRB6ZRDDGCO?=
 =?us-ascii?Q?ixTk5zPOZWwbd06ef6eewrj3LDVsOIeYpNqO1DXzI5O5u5gDIQ+7cX8Ui7cr?=
 =?us-ascii?Q?pGMB/OWiZwXK9hiAton4UwguDqzo7oZFvgcmW9aqi6XofcrkHV2B9k+1NFfe?=
 =?us-ascii?Q?WrMCHW3cRqxFLcMrGiYU83ITlkmCJibot+3cXzmfliBuw8v+sXVveVKNb95T?=
 =?us-ascii?Q?LxoEiBXsiPMnP4tdgJCPzChCK7io9JPMxnPkOjspRZY5OMSuXxHV9IB2eI2l?=
 =?us-ascii?Q?xGDTRYw8FvgCP+fSd5iABIlkKXM05WF2k7iRX1R8rBGfFNd3pdpk+B0PONiF?=
 =?us-ascii?Q?rqYxhtME217VJc9CitIe8xOmjJZ1CfYYEAdErN1S9iheS2Zbk1MYyS5F3Z2I?=
 =?us-ascii?Q?O+qOkmc5lv50Ys53xrl2t6Bo1hE8maXqmmIi/wxRDu1cbA7Nt0PEOn00R9w9?=
 =?us-ascii?Q?ttF83IZdB+5JyeTrgAFH79ZDLLlmnIIkHE3fipmse9ZkgMsHCnxStnOT5rEj?=
 =?us-ascii?Q?omx8fKcE7itNJEOCrZ+WWzoXEAfb90BG2nYh714+B3WSMEzIUj8EF80es2xV?=
 =?us-ascii?Q?40uh9Ay+jA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63e690-4b1b-4563-52b4-08dec98d1969
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 20:48:18.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M517nlUbQF6h4SmCdX6mRyQYf6fASFGyELAzalbL+0AZMracwLXHJXNVnWv6PNpet3KUmocBIflhHPmY7y+b3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB5937
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11621-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D5FD67FBBA



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, June 13, 2026 4:20 AM
> To: haiyangz@linux.microsoft.com
> Cc: Simon Horman <horms@kernel.org>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Konstantin Taranov
> <kotaranov@microsoft.com>; shradhagupta@linux.microsoft.com;
> ernis@linux.microsoft.com; dipayanroy@linux.microsoft.com;
> gargaditya@linux.microsoft.com; kees@kernel.org; leitao@debian.org; linux=
-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next v3] net: mana: Add Interrupt
> Moderation support
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsashi=
ko.
> dev%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7Ccbca53cce3d24759006708=
dec
> 924a556%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C639169356403391033%7=
C
> Unknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ=
X
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DD2ZPGJ5XznE=
kcL
> uH3Cxtze0FYOL3xxDIY%2Bg2DP508Q8%3D&reserved=3D0
> ---
> Date:   Thu Jun 11 19:02:22 2026 +0000
>=20
>     net: mana: Add Interrupt Moderation support
>=20
>     This commit adds Static and Dynamic Interrupt Moderation (DIM) suppor=
t
> for
>     Rx and Tx. It updates the queue creation procedure, adds functions to
>     collect stats for DIM, and provides ethtool handler support to get/se=
t
>     the moderation settings.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 26aef21c6c2c8..d92e022d8533c 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1579,6 +1579,9 @@ int mana_create_wq_obj(struct mana_port_context
> *apc,
> >
> >  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
> >  			     sizeof(req), sizeof(resp));
> > +
> > +	req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
> > +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
> >  	req.vport =3D vport;
> >  	req.wq_type =3D wq_type;
> >  	req.wq_gdma_region =3D wq_spec->gdma_region;
> > @@ -1587,6 +1590,9 @@ int mana_create_wq_obj(struct mana_port_context
> *apc,
> >  	req.cq_size =3D cq_spec->queue_size;
> >  	req.cq_moderation_ctx_id =3D cq_spec->modr_ctx_id;
> >  	req.cq_parent_qid =3D cq_spec->attached_eq;
> > +	req.req_cq_moderation =3D cq_spec->req_cq_moderation;
> > +	req.cq_moderation_comp =3D cq_spec->cq_moderation_comp;
> > +	req.cq_moderation_usec =3D cq_spec->cq_moderation_usec;
>=20
> [Severity: High]
> Does this break queue creation on older Azure host firmwares?
>=20
> The code unconditionally bumps the WQ object creation request to use
> GDMA_MESSAGE_V3 and passes the req_cq_moderation flag. If the firmware
> does
> not support GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION, could the
> firmware
> reject the queue creation request and break device initialization
> entirely?

Our firmware is forward compatible with newer message versions, so the=20
old firmware still properly handles this message, just the new feature=20
fields are ignored, and queue creation will be successful.
And if the DIM capability bit is zero from FW, driver will keep the DIM
feature to be off and unchangeable.

>=20
> [ ... ]
>=20
> > +static void mana_update_tx_dim(struct mana_cq *cq)
> > +{
> > +	struct mana_port_context *apc =3D netdev_priv(cq->txq->ndev);
> > +	struct dim_sample dim_sample =3D {};
> > +	struct mana_txq *txq =3D cq->txq;
> > +
> > +	if (!apc->tx_dim_enabled)
> > +		return;
> > +
> > +	dim_update_sample(READ_ONCE(cq->dim_event_ctr), txq->stats.packets,
> > +			  txq->stats.bytes, &dim_sample);
> > +	net_dim(&cq->dim, &dim_sample);
> > +}
>=20
> [Severity: High]
> Does this measure the CPU enqueue rate rather than the hardware completio=
n
> rate?
>=20
> It appears that txq->stats.packets is incremented in mana_start_xmit()
> upon enqueue, not during completion in mana_poll_tx_cq(). Dynamic
> interrupt
> moderation relies on measuring the actual hardware completion rate to
> function correctly.
>=20
> Additionally, is it safe to read txq->stats.packets here without the
> u64_stats_fetch_begin() retry loop? Reading a 64-bit statistic locklessly
> without the synchronization primitives could result in torn reads on 32-
> bit
> systems.
In the next patch version, I added counters to cq, and track the HW comp ra=
te,
And the reader is in the same NAPI thread to prevent any torn reads.

>=20
> [ ... ]
>=20
> > @@ -2324,7 +2434,13 @@ static int mana_cq_handler(void *context, struct
> gdma_queue *gdma_queue)
> >  	if (w < cq->budget) {
> >  		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> >  		cq->work_done_since_doorbell =3D 0;
> > -		napi_complete_done(&cq->napi, w);
> > +
> > +		if (napi_complete_done(&cq->napi, w)) {
> > +			if (cq->type =3D=3D MANA_CQ_TYPE_RX)
> > +				mana_update_rx_dim(cq);
> > +			else
> > +				mana_update_tx_dim(cq);
> > +		}
>=20
> [Severity: High]
> Is it safe to call mana_update_rx_dim() and mana_update_tx_dim() after
> napi_complete_done()?
>=20
> Since napi_complete_done() ends the NAPI polling cycle and relinquishes
> mutual exclusion, and the hardware interrupt was already re-armed by
> mana_gd_ring_cq() right before this, couldn't a new packet trigger an
> interrupt immediately? This could allow NAPI to be scheduled on another
> CPU
> concurrently while this CPU is still running the DIM update, potentially
> corrupting the non-thread-safe net_dim() state machine.

Thanks, I moved the dim update before the napi_complete_done() to avoid
concurrently running it.

>=20
> [ ... ]
>=20
> > @@ -2562,6 +2685,9 @@ static int mana_create_txq(struct
> mana_port_context *apc,
> >  		napi_enable_locked(&cq->napi);
> >  		txq->napi_initialized =3D true;
> >
> > +		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
> > +		cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>=20
> [Severity: High]
> Could this allow NAPI to schedule an uninitialized work_struct?
>=20
> napi_enable_locked() is called right before INIT_WORK(). Once NAPI is
> enabled, it can be scheduled to run immediately (for example, via
> netpoll).
> If NAPI executes before INIT_WORK completes, mana_update_tx_dim() would
> pass the uninitialized cq->dim to net_dim(), which could cause a kernel
> panic when it attempts to call schedule_work().
>=20
> This pattern also occurs in mana_create_rxq().

I have updated the init order in the new version.

>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 94e658d07a27e..67a2b282ff4da 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>=20
> [ ... ]
>=20
> > @@ -440,18 +474,123 @@ static int mana_set_coalesce(struct net_device
> *ndev,
> > +		if (enable_rx_dim)
> > +			apc->rx_dim_enabled =3D true;
> > +		if (enable_tx_dim)
> > +			apc->tx_dim_enabled =3D true;
>=20
> [Severity: High]
> Could the lack of memory barriers here expose uninitialized DIM structure=
s
> to NAPI?
>=20
> The driver initializes DIM via mana_dim_change() and then sets
> apc->rx_dim_enabled to true. Without an smp_store_release() here and a
> corresponding smp_load_acquire() in mana_update_rx_dim(), weakly-ordered
> CPUs like ARM64 might reorder the stores. Concurrently, NAPI polling migh=
t
> observe the flag as true before the initialization is fully visible in
> memory,
> potentially invoking net_dim() on garbage memory.

I added smp_store_release() & smp_load_acquire() to fix it in the next vers=
ion.

And, I will submit the next version soon.

Thanks,
- Haiyang


