Return-Path: <linux-hyperv+bounces-10617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LcnDigZ+Wlc5gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10617-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:09:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6E4C44DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390783033D1C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C158E37BE64;
	Mon,  4 May 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a9B1o2rm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2432E6BB;
	Mon,  4 May 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932502; cv=fail; b=Xf3V6YsKZi+SAFNPb+mD8lj4dVLZpZKVGps+4ChWNzfxG6PrzuD0XK0f9is/5H0FMC8fnk9pdv/MeWCwaKF9YPA53zhzhaIjfSKtk35tnw03t9h86R57Cq5b4It8r02YG07qdrUQyTqEWQL29QBE1iOL/4BgaGTWbrdp37QW94A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932502; c=relaxed/simple;
	bh=JzksFg2J9EdM0S6F7p4ROWCKRxKuurLxuEW32k8BmMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozQm8WLDqunfWPpP9lJDBaPtkgOj6UT9kmlDEhQIDyloK04X1LAUnt9yS9mXe6Gd3HmVHyFXp5taNM93YRtUKZFda3ZbWnnI2Tgog+oZjXWafDiHn/+CAqFO5CwrdI7ZIh2/jHobLqCKgchwbIikpjQWW1IZdg0nI2yrO9/C5Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=a9B1o2rm; arc=fail smtp.client-ip=40.107.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmJ0YWR/V15VxlYzi9uKhPeJBk4rgqC0AeQNYVknFw32h9aCMB8VGoqalVZ0Yf1fN5Ex0kWhsIr2Q++oiI9xfb5WqQVZhAf5mVsgyYn80PVLgvD44G1eWo16c99Qzczru2V05kGPj1VdE/J6qKw0n4j6FYs0EKCaNBGqpgiBCWvNb8AFiadybmGfY7nvpmvxvxGxRhYRMJhR8BXUBzw/25eI0EG+dEbxcJvIdpemaI1pNWRnHaGMuo3chiCe4m6k/vLkq5Dxk4CAciad9EXMbShLmaGO9q3PaS44lL3xbgMlh+sCZsOOcm68+xyCoajHFLIN1ouL8LiACG8WfMBMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzksFg2J9EdM0S6F7p4ROWCKRxKuurLxuEW32k8BmMU=;
 b=GhpxdK8oySTXyWtgWVAdS9mLPA7cSrK2fkwrkIl6Yz+vnGCYRH4qR03eTBwWGYykgoDcoqNlmSKmq1lShHVj1dhbpymY1C2zGSGH2QHBgZmZjWbjb49/TAPNo1T2JF3wlWPcm8jfBYMxDuq3Vn+l/LejKNUY6V7M5/pNLZYrmdabWUPTEFCAgBFCiGTQPV5iXbPEkCjW6YEFotbblz3ZNVhWR+jb+QXESkDWC1usssIl1Da58P6z/i2ctcd7IlegrouA6RNqX6CVnEnJoHcUcagDOPW46PYb0K/uNJJOxW1iuBamzeryyIEJoHy/7e1P6LggKn7bj70uHwQGykbfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzksFg2J9EdM0S6F7p4ROWCKRxKuurLxuEW32k8BmMU=;
 b=a9B1o2rmdkoSUVXEbmRs7leP2PaMirkubDQFWXayo/lD74F5sZkuJvxT7IWXwnJSKyWN2hNL4gYD6+ghcHLN2oBqPS8OvdR/mYZ+rBs4KN9cA4t/+fehqhb2vrD5B3X+caW+MUm0owZ5xa5GnaSa2DAFeNPvmw0TsK5+bsfbsPI=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6368.namprd21.prod.outlook.com (2603:10b6:806:4a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Mon, 4 May
 2026 22:08:18 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Mon, 4 May 2026
 22:08:18 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create separate
 EQs for each vPort
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create
 separate EQs for each vPort
Thread-Index: AQHc2CXaUSKEUxi2tEiQPQU00CBaQrX63xSAgAABj4CAA5P+kA==
Date: Mon, 4 May 2026 22:08:18 +0000
Message-ID:
 <SA1PR21MB66836EA289E44CC6897B8FBCCE312@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260429221625.1841150-2-longli@microsoft.com>
 <20260502152354.289044-2-horms@kernel.org>
 <20260502152929.GL15617@horms.kernel.org>
In-Reply-To: <20260502152929.GL15617@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0354aaa0-35e7-40bc-9dcd-6951f507f756;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T22:07:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6368:EE_
x-ms-office365-filtering-correlation-id: e87b6df6-0213-4a85-bdd2-08deaa29a5c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 c+uLhauI+LLtyygcUAbY8dAgUG5Uo0tzR56jgNfoUWrz9ADIa5TiiXD0bqx0MHRU7BhrkIJsN4g9aJtrAfZU1nsvpGQ9alK4zzhGpxLgiQb9x6pmR7j1XxDMLYsKfB2Jh3EnqXDhz19sSu3/SyyLV02VbUNDsyS6opJgoz7dOYj9yMneGx4537Kr29aSlrwtEenlCVFVSqSUDCr3Y7ic9o5XjPJtdzBlPrH6WcGsM5TCcgq3/nMo25oQ5ydythDwnvz2oLWKJykwFnk1tPg0Z9ZcF/4jOcEC0+lSrl7ZBunmVAM/CPXwEpcYH9FzTFJjB+KEw8DJ65kTgjsso1Yn3ffiWEVRN4ndzf3jTRtWv/HYF597++mTIsv+7uUC4SDbkxwt/ltZxFKglOlPOQ9YZQRmOZV/wMtWT7hXZfh61/9End5G3m70+wV8FxJymkm5AcHLUO4v10Vthu/EnGhe6Rv36XHNF52rG3tzMA43MNqG8aaAzrSJQg8qo6ZI5xaL4+dPrycS1NTu75DNObuG7lqk0d/TuvcApemIC0fkO2trj3hL5dy8YhUxmfaYeAQGJLkObYA+xgy8T9y9feQx/GMUxNKnp8k3+tLSCLMJAPdDFotmoK+zWbh6UaZFq0+UFIbYuB6LBbh4onAY+pNm4fltYjKMluK/Ar3RSM49sIPv0/qkeMDHMpSkj6FoMId0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qvg61zUngJcqvgYnx9KvA+AbuLK/tOYcG/G4O90GyqZmPZNcQ95OYJ5M96Ep?=
 =?us-ascii?Q?2HaZRWcUz9fXZFrQX66QE5fJ7XRuEiPIPqmYcnTY/F7MVWTrBiUTv2B/owXb?=
 =?us-ascii?Q?WTK1Zx6Q9f+ktqmNKzRAR+SRfxnF2zMtqY8eitAwM1+w/B+kpN9iacWSEILA?=
 =?us-ascii?Q?NC9VR/A7kGUnMte12QtWrWCYuaaXD1C0lfxwUCPcnK/zJCKBo+/I9w3g6V51?=
 =?us-ascii?Q?HTo4D9O0QFXNgvGPK5TIxAZdADj8sABaIuruJ3bIUHCSlRFY78pOFUCnDgp5?=
 =?us-ascii?Q?d5a/xe3SAFVNce0pa/mPdEZzV2Bzap/FCsA6SLr/TwN2APE9CLqyjeYPyIQv?=
 =?us-ascii?Q?JBlvS62QeeZpTt0SLmdTJ4j5X6qSbGA9qy3OoUZH9ALQ/39d2U1MkR746I0k?=
 =?us-ascii?Q?O2FfoiesfepCePABKSPwVZ9xb9uFr0K+TnQyMll4g6CYtTdFu21+soPSYK63?=
 =?us-ascii?Q?hgxqLCWDAKUBipnQd5Ll7GN4R/4BQ6SipQxMau+nqPTX464TPf0bJg9yXEbq?=
 =?us-ascii?Q?D+ObOr0tLeWfd6/nTig/XXQsqIQ2Jr9oqqbsKYe7cFf+4zuBrqpEJM+S/yjP?=
 =?us-ascii?Q?mQ8nPkQpF7s7qoMjhbMHyCutWE1+Ollt27hrrnBnVadhHGYqvHGZB30WONAO?=
 =?us-ascii?Q?nl2pypQ7pGK8Q9P+PY2Q4Sc/3fUquwrZeapxlulJO3iiWmcsp1vHvS6+ySV9?=
 =?us-ascii?Q?7Kfm8s8yzz+KoAud6DZK9qPtvEO0JQNexeOmnmWWq0qC90ImE4TDx7kc7dLq?=
 =?us-ascii?Q?+gNpj6ry6t+s/VetU6GR0T2C1HYnFlH1MK1a0YwXpxlhcygXObjSAIn3hQ+K?=
 =?us-ascii?Q?iaTMfTpzJR9jh9nC11uDJ0TSrGbxiXP+XUNnFv29Pvg2puTh2EwpiXu2apXc?=
 =?us-ascii?Q?6s9LsFRa53+nHalV/b+8JN89/2ifdcbwCEEt2G/9gIOcyRvzKF4Jj2gpXG3W?=
 =?us-ascii?Q?q1gBkpGTIvdZYrjgcLO8v2t85Tki7ntYb6oG60hGOVSH7n2GhiD3Wle3Xh1d?=
 =?us-ascii?Q?am2Q4i6iqGIhGzaEGTmg4ZxhxUGWLfMa0sxh5tr8jSW+etAVF7u2sSfrMkBA?=
 =?us-ascii?Q?vWLfIPoyjRWtRmvGspfdC+r4cccQOJ93i4SfoXXZka9dYN9AAi+CrFxyOtaJ?=
 =?us-ascii?Q?XsH6OYz+Pv+QOgqkVXfd1t7KzclPDN8gMgZu6XWuHQHsp0ue7B4O4k6Eretf?=
 =?us-ascii?Q?QXR1uD+IRGewyMqbWnMgJGVQ/QfO4cPZzhhilLhxBazBGhxDfqWFMPV4fmtA?=
 =?us-ascii?Q?2VHDmtB++EMnNGngC4KYYkA9lDUkeYv7Mf6iZgjecEPrYIFg9rlEGMAWWy9D?=
 =?us-ascii?Q?l0rYNfg78IePcr9VDaPpgDAOCz1qVEfOBdhtsVUsrqJWOaXwjsGV6S5va3yA?=
 =?us-ascii?Q?9S0AwGF2j1xhWfPFDkDLvcxoZcfmhe95lKIYL/snAN1EvFRlkadOPP9UM0Dl?=
 =?us-ascii?Q?wCqDtaT050MnMVwIriF47qiKSFww2xlxkRQnA2ovaHwnT0RokV84MUEKKxgh?=
 =?us-ascii?Q?Gt3a9ngqZiduPF6x2j6X4T0x+WrZlrV/Kqw/f4Sek1NKnexs3A/2f6Jh7m5B?=
 =?us-ascii?Q?FEQe/uJuR807RUVxX3My2bvrp+eQRSRTZwLiu48kCuK26aqh5+v5OPu91n+5?=
 =?us-ascii?Q?dwGAXY32sqykxkkybLnouKrMcO4fXjAsOyaYr5I0m5/7A+ysd2owUuLfvRZB?=
 =?us-ascii?Q?QRSi6wk/OIKLb27cKioa0ZDWssR3MN6KGwbw5ELMSmADxXhV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e87b6df6-0213-4a85-bdd2-08deaa29a5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 22:08:18.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYK58utjedgX9z0dCeEQrtEVRiujryMvuPhOky8g5QgdcRKn7cVxsmE+c2Nou2HhZQRwIoTh9CqpL3VfGIe9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6368
X-Rspamd-Queue-Id: 89A6E4C44DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10617-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sash:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]

> On Sat, May 02, 2026 at 04:23:55PM +0100, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at:
> > https://sash/
> >
> iko.dev%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C50f9138d30ca49fb0
> 5b
> >
> 708dea85f9e35%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C639133
> 32578
> >
> 9863881%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
> LjAuMD
> >
> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7
> C&sd
> > ata=3D1Ew7dYw%2B7zQjROcj63hnOYFUfak20Pi3ytzOf2J0JWg%3D&reserved=3D0
>
> Sorry about this, there was supposed to be some different text here.

I have replied to both comments.

Thank you,
Long

>
> This review is available at
> https://netdev-/
> ai.bots.linux.dev%2Fsashiko%2F&data=3D05%7C02%7Clongli%40microsoft.com%7
> C50f9138d30ca49fb05b708dea85f9e35%7C72f988bf86f141af91ab2d7cd011db47
> %7C1%7C0%7C639133325789877695%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIs
> IldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DF4%2FR6eEmKkHI0%2FkuGfvuaM
> 42oss8KCUb9J5Bw6B682Y%3D&reserved=3D0
> And I apologise that it overlaps with the review from
> https://sashiko.d/
> ev%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C50f9138d30ca49fb05b70
> 8dea85f9e35%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63913332
> 5789886888%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7C%7C%7C&sdata=3Dg%2BFgPtQXNQSqC%2ByHDua2twXj%2BufRZ8yCze757NpY
> vU8%3D&reserved=3D0
> which I also posted.

