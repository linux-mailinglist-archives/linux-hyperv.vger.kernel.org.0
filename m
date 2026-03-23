Return-Path: <linux-hyperv+bounces-9698-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBtsIZuKwWlkTwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9698-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 19:46:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD62FB844
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 19:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACFEE315217E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD23C942E;
	Mon, 23 Mar 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VYn+LNOX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021091.outbound.protection.outlook.com [52.101.62.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477223C5DAC;
	Mon, 23 Mar 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288484; cv=fail; b=IGYUlkoMQJvIgxfp0GjFauGPuJ8RF7AB0Ydl6MpkcL1/WKASna/85tF26eDX/FHrXip3hw0XPvPofTofidaHrQF6Qw2sNss8zmjr9/C8ClV8F0P2OghTpWth8jB29ZapQ8rl/iZlgjmE9h2fAK7rWdTx4hcGfUwaNfZA8N4rgr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288484; c=relaxed/simple;
	bh=B7Gglzknsyd/gNWSbze4Piop1XCg8zp51CBtQXUVjyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtCuaWu9DBoWUXBbFdSdwpzYotYeykZVfyk4F1UbRNbl/r19hI2KI8vy20GQhQONpML6XD6liU6lDYp2hSBXpfbo1RRFH9qvI5EKtFSLyB4quBI42s6bbDK7EwJYQ8b3vwtxSTao3PCvjMKacL59/6AhR9me8vMEDkxRY++jftc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VYn+LNOX; arc=fail smtp.client-ip=52.101.62.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9DP/1FNUVc7gIaB+jPrm4vc06F4IFWtN147q0u0LVTS2Q2EswOH2qtJOFTbzO4sUGn5Cq0WfNrRPrEYpyfJjf56CLkOtyseyHLUzM9N2ELo/G+6cuLyZ6IdRzYrR6hmQUwq9LW101tF5pAgZE2IBjrRVtwK+Iw/4MH4Yp/Kid2qRBTLB4bTyv3HF1wIgbphVtfF7PGffPiiZGnh7RXabuFDJZwHLAq/jsFncPOlanx9/DUKYK88+Mc23hYiIpizDt5uOo1b7zRhkpc26weSgiWR5F2896TuJzjaESN9e9ZEAjsokpGVzfHcGonNgDDiKAZjD52LD7ep5hB989sXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPYLIcbpvI2YBb0O2FyAhnGz4D8T1oRwOhYAife5QbU=;
 b=mNSSYB7dwc9EFJbijJRIkrAUq3JpAfatwg/9akdB+wuMK/i2+/oH2PR4RoqDWY3iQvHpp1LAOyFnWYptSaQte9GQR6s8z74URwcWdpNQaGIQqjP5Ye1/+zH8TR/nKxbaiyZf/XbqCpg6+VGFWaR17TyIhH4JHDIqPys6Ow0pFjHBrf5fanRftUHRubtuegkT42Ps0s1ZUqsqQ9GUaseW7oVjnIqfM/OivT7nLmr7RHumzpu+RkweuuYZNyRIIvP/WiL34fe9gF+ZbsPHcuOQatDcDT07H3HVk4zsdKjn5DRFrgpHDEd5kxcnz0n1k22hq4yEq5HH/DH09/MovPO8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPYLIcbpvI2YBb0O2FyAhnGz4D8T1oRwOhYAife5QbU=;
 b=VYn+LNOXy7hHJKD7A3PISJjYW3y9Lta6veZQZ8dSHphhDLsslSZnOj5Z93F1Okhftiwb8C7N/yM5pKVqaG4dBq/P/RsxulaGSgcO6Jmc8XruAHejU4NSzIUsq/csOaFUwNWR7PsT56oisv5IAz46OnWyKbhkX2ayiECudi83XKQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6491.namprd21.prod.outlook.com (2603:10b6:806:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.5; Mon, 23 Mar
 2026 17:54:40 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.004; Mon, 23 Mar 2026
 17:54:39 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Set default number of
 queues to 16
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Set default number of
 queues to 16
Thread-Index: AQHcuMGPjXjdMdDZokyzyRw1HtgbTbW8KNQAgABBsSA=
Date: Mon, 23 Mar 2026 17:54:39 +0000
Message-ID:
 <SA1PR21MB668396B0EA5D18AA6F9B3950CE4BA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260320233027.1603495-1-longli@microsoft.com>
 <20260323135848.GA81558@horms.kernel.org>
In-Reply-To: <20260323135848.GA81558@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f389827f-0a51-4c51-be36-054440aba960;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-23T17:53:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6491:EE_
x-ms-office365-filtering-correlation-id: 6b2a9c0f-bffe-45b3-8e88-08de89054173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 yesirtVIcypvzbdSLYhSmZaeAWzYGc1YIj6x3Cadh7MG4v9jRUQcZHqt063DruUoPSEydHosq92Wgd46hZzlgRZIDlRLCdNfNwTkufYWU4q4T8z7wJkoP5XssuB7vKHNY6mNn8kOO5h/4eu42wdW1DVjyI3IppkAVhwM5tLr3bs2A3XUCnaKBnwVYuXyRhmrkkRs5ZqUp9SDrBdz0NIAno+zINv0SbrMGf0zyT3EVLT4iLgo1ziGmp00l1uIQRyn3ecPPObTyvkNkoZLeAGT70yfI0eHR/ykRMniYPwryK8L3oPAtYBEFIOXhIXwbRvapBdWm7H88ST0eupy++mYnSwj7X67cR20bnzw77mA/jVm/c23r0m9ECAgrSNYYZ/w+hYVuL0sIAPyLs0Lj4YhE80tm/a+DkE0xT7i3wGmNvusoUDk8LjdY4ETecsYrjMSoQnpJysHAZhpQZUyRz123rnY7+EhxMpYb2vMAQXtuYatl8J25E5mbz73mpztDPPP/gSRAvMDfRHfb+uyrgzZu7TPVNFBKh/qF9w8rd52/kJOhUhiHAkwlqsP2o2YE/KgleMJ9Ewlxv/hk/6JYJiAc+yeeqEfV59N80a9lNNrdjaYnJKgRDQ3oc4ovUhMh0yyPvr4q0ACy6NP08xBRt2XC7o2Rb4ZshJczES09XXFJF67GjaQryRFA89nA9igdS4NxVuhRp2sYxmS8pssbfzKZMCuTtjjkcyLI5CKjP/5xsEeKxlY9JapN9K0tl+2VRCuOKVmBsmn6xDMYylpx40NOOfduyfrKV7vodtZbD1QOrg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8sMP3peYGXyPY/4n5MALJtgZ5qx24aD8E7hkTkAp6ZW2cK4k0XeL6ePvXGKN?=
 =?us-ascii?Q?6laf3ti+8VMNPgHw/DATzkCDjra8YhZ7/4KhICVx0r374qPduq4LHZQLauu8?=
 =?us-ascii?Q?x1t1tGxj72n4ig3a4xAYDG5H/H87HyyQUT5H6HqWpNejNZxOS2AecTfj+Bcr?=
 =?us-ascii?Q?KOVnNPvUxrnAWE/SsF/8RYcCmTAa70VG6B9wSoeWzbp5Rl7lxAsFbVkKaz/Q?=
 =?us-ascii?Q?A5NaG+oc9HNqAxL4bi9HJOdYtoa8Cg9Np0keGTjQyX0NB1zpEgpu/0tGTQt7?=
 =?us-ascii?Q?aJDi53WfEzJ2vTQjrtPJG8+rC+/ZzLg9kcivpQZzOaH89yrqFrrmrvg/+0hV?=
 =?us-ascii?Q?UIQ/w+tvcw4dPDa+gKuJSf9DMztC6bOnvBg7Yx76AfX4va3WoY4TS14hcE//?=
 =?us-ascii?Q?rvfv70C7zOwyTCnfnF9HBBPrdPLrQD8/xTahYPWUNBE5j/sBHIsEoUHaKp34?=
 =?us-ascii?Q?MwtKd4Xx0aOdobmlZj6D2jembc3TRKh5RQBxoeB1unGRaWRBYHGCHBkSKstC?=
 =?us-ascii?Q?2rVQr13N06ICepnmVIbdQX601ozcJ0sZArIcIEcWk5rFjVeQiFsQV0akhDlq?=
 =?us-ascii?Q?QEXwAbOM3RITzi54UKRUPktjoMESciT+UkbaIGYP7dHp/CZEn/EPuo5Bq2el?=
 =?us-ascii?Q?aSWFoYnF2fEihji0w0wMNtyN1XI0yaJ+mVAHtPGwpk/DZ/llLPvnH09U5hpo?=
 =?us-ascii?Q?js+IUdFdVYF1SYUSf5l1rx9KmKDp04xsJP+O0Cg6QtMWFUiemtSadrHmjwoZ?=
 =?us-ascii?Q?fbRI6lKqNXYpRaNYmQ2anD9V6dJQIWc8Eqbl088wWz/BP9tSOsAnjcklXFsd?=
 =?us-ascii?Q?YzXIe/YPZLP+U24vLf7DW9j9Cxr8aWRquhhyddhB7ivLENwpJZuiEe0MCdZ9?=
 =?us-ascii?Q?bHwJbv/wg+EgbA82zR6/Ps+8rVavzMmUqtUVEHizwRI7C/Q0kn+JUD2nmmjF?=
 =?us-ascii?Q?E3zZaFP+ir6rB295GSYVrvewm8RlccY82ieKG//rAmXHSGlaurj9K8ObkCLj?=
 =?us-ascii?Q?3n8NnYwh9kh/Xn+jfcr/cgb38X/TNVRtny/cwXxGGzXdyrr4H/QU3LgLe4WG?=
 =?us-ascii?Q?9i/YLzJltjLqHbDAJFShoXjpeFFJ2q4q5/X+IaDvonUQLO1w1uvd8TUDfIuS?=
 =?us-ascii?Q?T6ge8egTN219kzgLFBrZUx89a3hH6eDxgCM/RMTAcaM4a4fuHE1BsB3I4Wtu?=
 =?us-ascii?Q?uZ279A1vPbdIg8r+e3SWQSwFdqoNqyqI8NRx/0bEj4t65Mdp14tKVm9Jy8dh?=
 =?us-ascii?Q?oW7PvNCUu1OFg+4yMwIomgHdUHWat7cnuGiIGbyMjB9UmMJcdoSBNUllp/Fp?=
 =?us-ascii?Q?LuG6lX77u0+ZitmRfLn4jxyKec14mc4M9fkCBTjPhwQb+05y15wrz+qlAII+?=
 =?us-ascii?Q?VCSeV7mZW6CwqHkiXZ2LkAenE09aCqzSFkvxqgv6n3NougNGSm3c86wZXF6h?=
 =?us-ascii?Q?ZKvig6TflVymK8oUFM2i0+B6Dfuk73S8gCxFghKdXZQPbwrdDQ9W7e8r9PjA?=
 =?us-ascii?Q?VdSiHO4l4o67rCG2KsTXXzVDGAaDYgR6BRpIusV12xaU/rK+USrbd2O6BvJW?=
 =?us-ascii?Q?PXvNyvVB2HqFYm2y9E8tkCTKgMRfe88y/SnM1IJln2pPmfhs+0Yi+CONMiO2?=
 =?us-ascii?Q?6w71rL+KupIE9BGcvIQMgmIbMghumlOzqEjp1AplPBIynNjIQnkHVYEiwIuj?=
 =?us-ascii?Q?HuZpii9lv0PEMWxb9TfD8FveeJBMhN19D6Y7tHRJjkKp9IVU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a9c0f-bffe-45b3-8e88-08de89054173
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 17:54:39.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vc/RUX6WP51fa+c0MumUXEzpUlbFgAjLBmk/sAE3QFLJ7vcYsqiNFTGlqJuTDXCgeRU+qlMOqRY7awBZgjSleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6491
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9698-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDAD62FB844
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> On Fri, Mar 20, 2026 at 04:30:27PM -0700, Long Li wrote:
> > Set the default number of queues per vPort to MANA_DEF_NUM_QUEUES
> > (16), as 16 queues can achieve optimal throughput for typical
> > workloads. Users can increase the number of queues up to max_queues via
> ethtool if needed.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
> >  include/net/mana/mana.h                       | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 49c65cc1697c..7cae8a7b9f31 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3357,7 +3357,7 @@ static int mana_probe_port(struct mana_context
> *ac, int port_idx,
> >  	apc->ac =3D ac;
> >  	apc->ndev =3D ndev;
> >  	apc->max_queues =3D gc->max_num_queues;
> > -	apc->num_queues =3D gc->max_num_queues;
> > +	apc->num_queues =3D min(gc->max_num_queues,
> MANA_DEF_NUM_QUEUES);
>=20
> Hi Long Li,
>=20
> Maybe I am misunderstanding things.  But it seems to me that this patch s=
ets a
> ceiling on the default number of queues. Which is subtly different to set=
ting the
> default. Even if not in practice if max_num_queues is never less than
> MANA_DEF_NUM_QUEUES.
>=20
> If so I'm wondering if you could tweak the commit message accordingly.

Yes, will tweak the commit message and resend patch.

Thanks,
Long

>=20
> >  	apc->tx_queue_size =3D DEF_TX_BUFFERS_PER_QUEUE;
> >  	apc->rx_queue_size =3D DEF_RX_BUFFERS_PER_QUEUE;
> >  	apc->port_handle =3D INVALID_MANA_HANDLE;
>=20
> ...

