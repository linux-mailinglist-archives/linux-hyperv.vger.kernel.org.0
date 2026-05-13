Return-Path: <linux-hyperv+bounces-10880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLG5C77+BGrxRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10880-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:44:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D053B96D
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6E9306B386
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C53AEF49;
	Wed, 13 May 2026 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GoBjbnBK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022112.outbound.protection.outlook.com [40.93.195.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E88184;
	Wed, 13 May 2026 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712190; cv=fail; b=Ur8s+MMO3NgFilWvlPL7yhldpxY39Zr5F0XoanXd2YF+Luj1R5dvTJpmmRyhfekbvtKZpLBj4dxJZXSqWQzW8GIS4s53hg6/warIOIjxQFYHcTPOzUJahGR1OOHntWh750rGvB1jwOVvUYChjQ3v2Ho183oRgGaCwsaoXL9z7cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712190; c=relaxed/simple;
	bh=dbQg3v+QLE00pLtHxEZhrFgmrn3SybKlA9Cy7CZX98g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nRgsZlVwpzSgf/Ts3vl0qwz7wju0G4P4JkQMx14fi/1kg6EA5/RpTB2lTl4reg9ll9IWJWfbOTdNF57vOPbXmnhLu/dnN11vtTdRDdkNXlY3KMdU9HWEXl1z93BTb32lKNExqxLaRsQs5vswVZPd8pkYxOdl8G2rMn5ln1QpgY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GoBjbnBK; arc=fail smtp.client-ip=40.93.195.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGuQEwWhK5/6bLMxvKX2/lXbveNvnH1SWpaW8zviX0jDfJAPYHcs5n6vivA2bKHAQDNbmcsPxyJQJQyGjf4ki/lgyPbYEGsVVz1bhYLJv715jKspV/FjJlFZudYOBf/18ieibmM4xn9ZDhY4aXCUUewyeGckoO1ntMB/XDxsj4+ilSxECBYBQ+qh0TgrbdtnSGHaKDs5Xyi0uU6eCvmjMWVoQTDaCFSXK9us69fqichMUbyZf15v9waxddJ+qKE+x25w2TNXqNXKO1qQALHj8p/cdzB41iZyubJtu9lfj9MoaF1PpDOFpP5V2ElGlP68KW6gqiP8NTW/XMIVpZomUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgv9r7FQTVagiSWXA/9gOoE+dGSp58bOl8l/iczCihA=;
 b=mVN9vCe9o6k1zOKREOdjIOu3/Zbuk2BwkNSSyKqPUScjP8S+CoWbhSA7SbPlrIUAgitU7rITP/CiwUQ0BC+rnxvZZhXrQvSz6knOVJd8JaE32pL1ABhxf0PSIhPSDnWFtfpr1k4EpEQf8EN9dNMObmTuH0MocvRWlLUXPIYGok76GxSbBjG6sOkdFEw1ClYkGVilCRAeJAXMvGdJFXpd/ryam7NwTBBOxdATu7AJenEFqgx1xJ2FUX9Mj9urEPGOjqt/Ev5LG8RLxwRaeWo0Go9lj7CkiVp9Cpa4gOcXwjxLb5hlIr+m+q12tToQzybFrR8PfBo7uxt4R5SJiyla0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgv9r7FQTVagiSWXA/9gOoE+dGSp58bOl8l/iczCihA=;
 b=GoBjbnBKcTo/ZQOuuFCS8gi8kyfp9a7n+4qaWkBcZih8mByNEuQGLE2IaGt0X19830VukbrKZ8DLgnPTlHKNOD4666zOrFrrc4qd63p9Erx2hMpynhKcjfuc/6KhzCR9PurROA8hVW/VRbQZFw5psQNXzVJMRKTDN1adftsrc6Y=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6657.namprd21.prod.outlook.com (2603:10b6:806:4a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.4; Wed, 13 May 2026
 22:43:06 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Wed, 13 May 2026
 22:43:06 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v7 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v7 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Index: AQHc3lWD1bAKCSrtB0ChlJBmM38yNbYJrckAgALpH0A=
Date: Wed, 13 May 2026 22:43:06 +0000
Message-ID:
 <SA1PR21MB66834590730F31A880ABDB06CE062@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260507191237.438671-1-longli@microsoft.com>
 <20260511191540.630e09b3@kernel.org>
In-Reply-To: <20260511191540.630e09b3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56a5ccf3-6017-45c9-ba5f-8af8b7e01db8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-13T22:42:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6657:EE_
x-ms-office365-filtering-correlation-id: 6f44c26b-ad07-4d65-a4d9-08deb140ffde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|11063799003|4143699003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 AeQwHe2ZYHWNENtlDKUJrdGEaC3vFgQ/VAogFNiOT6VFQSvyBF78M5nmE9rdq74iy530JMZN3LseE4NXCv10r13wGuwwWaA6+NPQQfPdhVKyUD+az/ZKsfwJ4HSUk8H57Yi4Y3THrFaMUEdc2XpL8A0Zr49eC/lgFCEHek0lfXWN6U5g4UNRzRneM+RUwfTOJOPwkZ0JL2KHYyZL3nQCAVzdQcFEBx2HXuXniNeVldfiGIMdyqyUVEVg8VNJQ8E0ZAT93+03zakBS1TV395S9R/9O32vQ6WMTyULsJrB0c0rfpCch3WR1WGpe//qNPE8SqQ7G+Ji2Bt9t/thDRshEiWX69x38AcIprSTOtkCEW5D9fw2RzALRYcinl7CyW6KkFQ4vlOq8bLLrzViUHLc5s7sheR5NSOqW6576vmLk23NI58E5lpy9wvkpyUA/W6s02qannn8x4Xam+py7RmqKvLkQ0Z3FCUEVATMoP+4j3rxHz7d9tsdoBQPXbL4v53o20fTVBkrURwjrONy4OldZB+evh5iUcM1Sm6Sn3nTZ+tvoi05T1esf5FaletPmPP9l0nbNB7AGDZS6YNfvewt3BiOmT07uL85zMlm7KXEC+fPf0k41hMNzcYog7HmCKp7XyBEfSllxoaeDyfEg2PkelAy7I/yrVcGjhJtRMVJhdL+FYdymurQf/GlgAgfFy5eaa3JQVlz7tgFMERNAzVCjCNgvFqgGWd6d9nnQXvmhuSiV0g5gdjZ9aycKb59rkcJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(11063799003)(4143699003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/HlpFPvIs7BM7ZSJ4W4He+KWh8mJYpGW6KL6pS/Qgg+3ROac9xUHkqmgbask?=
 =?us-ascii?Q?UocFRLW46GmLctsayZD4mfTEl3NZh6Ru/nTjly2D7aff+qiQ/YLor3bTMLXq?=
 =?us-ascii?Q?6DBOusj99l8Sz2vLTIcAkFLfigMDxOgldT362Tj+6tDdgEvPEghkx7+8IQit?=
 =?us-ascii?Q?Q8DjepLfP09IaUo20hcQ2Xcj9cE+X2Vr4zb4fUkn96In25cHz/dKq/IJjzyq?=
 =?us-ascii?Q?ZXpYHSrlbiGsUC55m9wtboYpnJMw0rNGNQhFK+vFqgfJ0SxuatC1I/2kTevc?=
 =?us-ascii?Q?MhBHbEkAXQD26sYnRvTo4YvRM8CLm/oKC4tCWNXGjmO+Vz0qNYw4Xlu1YwGC?=
 =?us-ascii?Q?moCiG8SaPWrmEWTnC+jmTEQ8SBHmTPcPBLwEYF1ODw4BlKipXY5dGpl34rJn?=
 =?us-ascii?Q?QE+KTZTPwpp7LR2IVS9fHRPb9EaTlyC26QFc06qpdWTd8xNKwjqytpa9+Ldt?=
 =?us-ascii?Q?qWnZ/qHuEB1jllfte5ArdVjx0gsxn7xVsBdciXpsBVuFisMHXBkrnj61XBVh?=
 =?us-ascii?Q?ih5lgYb5czos25qzHzOV3nV/0lwl9krWuM/T/D3NK82ZKQ/aVbwiSCAJ4lJB?=
 =?us-ascii?Q?31esbQovp2l7R9pjJgRaSzPv1iOc6NGdXNx4RoEra1cEW5rQ5rNDBA2Uz16z?=
 =?us-ascii?Q?IbAXkuJqk0hHxw4BkgWLcs/ZjnA4EbRgYOPG24UcfxqHRxGMv35a10CMRJDv?=
 =?us-ascii?Q?k6ySNMOJJaadXYbM7VmmT4ZpQu2qZ2dsPRfWareWDFfjhy9N2O774aBvZ2Dt?=
 =?us-ascii?Q?DnMZZDy6Bai4rtzfuk/tTn11f/2FfqnKhtrnIXM909xpO6QZhzDwNXqtGzGk?=
 =?us-ascii?Q?5C0iY4pS+XT3LEv5nAF00N+8QvJMRrDd47d/VKUvmlaivJp9h3SvWlHiAocc?=
 =?us-ascii?Q?H/OHn6739t9m4Bge9obvjwJ2ULprKHp+/+Zza6WqUn4rJmApqP9tl+9KdZc9?=
 =?us-ascii?Q?kesZYjnrviO5M4V/1ZuUl1I299xpPURSapw7vphzV7Z+7MLfFOyJgVdbZHtv?=
 =?us-ascii?Q?W2QVkwEgHzUF+m7FImN50LbLywEMdipUO5Sp+bTqQtGjDZmkBdAKjP6z7V2d?=
 =?us-ascii?Q?PLs83N+dIqHftqoCS667AspDqL9SYBQQSSIK3W60Hqq80UlcjjnBzCCaGT93?=
 =?us-ascii?Q?TnAZuAfptN8AHapaGNV3DQnW3ujPB2SgxyTwBMEhQc6ZyDRktKbT9yjxpJ+0?=
 =?us-ascii?Q?kesLdq2cjhVht6wGkYA2vH0ro0XOvXj3dyDxWPmeLOCJix0FFoNjRlgIWdiM?=
 =?us-ascii?Q?8svNuCmVocXC2wngZ9LpBBSO4ttfzu717+DDYJXcVAtM3vJptB0a9FVvEBh7?=
 =?us-ascii?Q?U5e+QTJhqUKKAtV38OhuU9wjJZ+lgh7akMqyVtdV87fJPZWSBuaMdVs6RbyX?=
 =?us-ascii?Q?Bq3b+cFBUu37HKRECCoBwXUhSQgLrJ9aIZOReXtL6uvQzdtxuXXjWpR+MFdc?=
 =?us-ascii?Q?mOe/JweEEDUHPtfSGLQKNdoJzF4XaKwp7i3UDfVxsngUY6lx/WhGzNydHjnP?=
 =?us-ascii?Q?a0NtHXcHoIk1aedJxrakdNqSMj/QaPv8NA2Tp6aSCFGi0f9gMenjLPp4bMIc?=
 =?us-ascii?Q?odB0dXN08mwIx+UIzbxevx101Ut7z3H7DAIHGNmtKOJUNcd+Aw4OXpiacfA0?=
 =?us-ascii?Q?8uS3bmE1ADwmSfXPkOdKe41nhAhwh4EO66z3+4e8UGBv5oUpiAnPFWj6E2Cu?=
 =?us-ascii?Q?geoffJFk+BpP01ojYajfujq2WR4Dy5DQEC/Xg4eChhaq0WDN?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44c26b-ad07-4d65-a4d9-08deb140ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 22:43:06.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsHgVZIHIaAV+OdOjvJooQSlW3VR5Nsx4/Ap2H+teF9cEtvuoZe0gZlwTXxNn84SGG5Uup7Ov+aOJpbnE59msA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6657
X-Rspamd-Queue-Id: 866D053B96D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10880-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Action: no action

> On Thu,  7 May 2026 12:12:31 -0700 Long Li wrote:
> > This series adds per-vPort Event Queue (EQ) allocation and MSI-X
> > interrupt management for the MANA driver. Previously, all vPorts
> > shared a single set of EQs. This change enables dedicated EQs per
> > vPort with support for both dedicated and shared MSI-X vector allocatio=
n
> modes.
>=20
> Once all the AI review comments are address / only false positives remain=
 - could
> you pop these patches on a branch and add PR info to the cover letter so =
that
> both RDMA and netdev can pull this?

I have sent v9 with PR info in the cover letter.

Thanks,
Long

