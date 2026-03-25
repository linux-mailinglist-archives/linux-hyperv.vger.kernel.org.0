Return-Path: <linux-hyperv+bounces-9776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNYBEdQ+xGnZxgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9776-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:00:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC932B88C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7F3308B61B
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3E34A783;
	Wed, 25 Mar 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XpWsEyjr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020097.outbound.protection.outlook.com [52.101.201.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755E33A9C3;
	Wed, 25 Mar 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468665; cv=fail; b=AXq5h4hozLEk1mPonoegzqEUUJwau4BBJJ9hzCNlVDuoJ3ZGH8T7CrYTrF9noxkW28kJdd8fabt4yzD5pwlcTcCd3y5tHnfU6FanESGPLyEkHOVYWQy6MWlRFDyKlzTLPe5Vt12jXttyc2EEwbY0hiJyGXkjrR5S415w+ejJUp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468665; c=relaxed/simple;
	bh=wNpga2FPQUDVZ3/clblKPUpQobRKXmc7gEaYqVP4PSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tDfdU1TYWaHzBO/q2O+MC29xUt7YliLTMh+zc78a9T1meSAglccQKAF7U/xGWUl2RSFbLUVnlgWRL2/Z1JUEV8egCccvN/mzDRUPZP8ldGIxyUJ9HUTTgG0hyrt3Eoe7mBzsbI9eULByTjsp6x3+qYpXk7zvF3zPX7iBceHVTpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XpWsEyjr; arc=fail smtp.client-ip=52.101.201.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDPVykgEu+Ks2rsTMLn6CowK/wXHLGA0/PNN4JHgoDLhkN7md2ZttKZNhWKo22LZhKMP9NM6Fm5OLi/JJB8h2pDoJXNxdpXZNUFNxdAsQ4wwRJjfmGDioNiw2XUWWTgH0UGwxdyBJI1JN1LRH4hHjy72zmbJ4O3c7wruCJ15IeJTx4cq4ohNRXOZpI8R5tTowMI8It2Ddhn+uG9sOqgituakKMH3uqKF31oosWkukBREFH5c/XHIy/jMFWK8ZMykaLwBR8OaW1nt8xJ74h4jhq+g41o9VU4GDOBwIM2Y9qwDjxTGJinO1qQ+vErmUOyQ8pXwBcuyayJpIjGeueBxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNpga2FPQUDVZ3/clblKPUpQobRKXmc7gEaYqVP4PSM=;
 b=feqsmRrQLYmNZqHQCWdC7PldPtCMd0E4yvxS3ReHe/4s+5ZYBOwDm+TF8qyDh1owLLWEzLUdpca+7Zz4hNi3hnloU5NiVsu7zAEl/HtijCSQA8mLDx0tC9SizpZv0UqexQzXkM/tzd6VP7th2aJVtudw3YXIMl8G+CAyFVEFeIx+nq1+BFdP6500PzE2yDuqMpnaYpzraTD3QDvOL7gSCEZzUD6+YTS40AR9RPCaNHjpRzsmNcSjvuO1M61rMesmORWDywyHXgg7QQ1xSLsWxuJp9BCTj8p6bvJt9+JCSajohW+5acu82505bSbaqSNYl8WzdGCdzEMlEv1jCpOngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNpga2FPQUDVZ3/clblKPUpQobRKXmc7gEaYqVP4PSM=;
 b=XpWsEyjrlF8FzijfoocotOaUaUazb4liP2c0wDbaK//bmGr3G0sQajgmRIskFH+FyGlqoaP9gfqQPw9yZHaxrfgSVomRmFQMrQJMAE43qv0WeKV2rqyKI07Z7Zw5ixcy7Zb8ob0iFaXi+EMXWcj+uZS+a8C/qPjHEkgpDBAEnrk=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6059.namprd21.prod.outlook.com (2603:10b6:806:4a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.17; Wed, 25 Mar
 2026 19:57:41 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 19:57:41 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Index: AQHcuv+uY0rQdFhn2UyizOQL5sQArrW/ersAgAAxGzA=
Date: Wed, 25 Mar 2026 19:57:41 +0000
Message-ID:
 <SA1PR21MB66838DF94EC752617C9FED20CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323195952.1767304-1-longli@microsoft.com>
 <20260325165646.GH111839@horms.kernel.org>
In-Reply-To: <20260325165646.GH111839@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cad47e1-f906-460b-926a-2da47ee79709;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T19:52:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6059:EE_
x-ms-office365-filtering-correlation-id: b805eeff-2620-4db0-afac-08de8aa8c61f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1cv+SktNeLoH+KDrCYfP8Kx7GGfcT8e8gaJIUZxdzU9V7PeFvJSQsS3zqNmexS3okfX7qIEy4Ule/DZwtNhHlx7iKaB4Ydbpe4HhlGmBjejPnapCCjK/64/u8RTVCkUdeS3DelzcKKHpujzyfy9MeKkLRDp4luoTswD8uB2DacqzybBqFRhlBMMsHNNleMrzy0FZgsGLheiJkFyb4Nys0SA0GXtfXvdSN8CxdrsrYyzB8fLZqwMdB8zjvoNoRJ6jqgTrWYePbBi5+0k6FIemXWcFSqonQdMA+IPWpdupyifPqiD0vp07CqH85I0YiyeEh7fcXQY/cYjrzoEdLT7IQ1jT9OnNrF18D3n5hEVoEi5Igp1MmNSH2+spSo79QWDJrSczERg+UIKUO5OMZq18MZmGFOcAxZrMXryZ8U19NRRgS/+SfZtpcdzs8XUC990NPRcRPr7JfLR8BvNuPDrdi87SspWvYyRaYfKG3xXJPiedYRfUfNsNNMFXteCK/BefZaTZNI4Yd0dsmAc7+mLVcNZWBrPG2hRxnMplR+3JiZYt4wgu1ceMgtCxBtOEMeURK6OrL2DIrkpJdSk5dvT5IPtDdBtx5ddVbl1FNyhBEc+NISjv1nz2VH+e7G6HGTkZyN+yBoMsHMyKTb7Zv5Ueh5miAcHcZhEqxY2UiqauJW5JMmEhFpEm219jLfUTCL8vaL5t6hijmW2ly2PYjfxu63VES+79jyVYmgP5fAcNSIrsIuGcb5NnJdwQcL0BVDeACZhs4EN4mQlCd+2vcdYCPLItZpd7JzDZkZ3fKfxUOEk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Szj0a55kSkaraTjr8ZGNUkqlvvj78/Q3J+u/Dz3y+Umi3gI8u8Im9Dtpk8Fl?=
 =?us-ascii?Q?5VxLWtSHcKX9PckqoXqUS1+453J9AbBTiO6DoRvXM2MbQ/DkVGnjho0++TI3?=
 =?us-ascii?Q?qt5+gSc3usec4h3TXpwiiAG3Z9tCOYEzfShskyM/ZVgp8RfBLUuS0vyM1q3Q?=
 =?us-ascii?Q?p42zqnR0Z8jkatZsL/OoKl/yFVwlDffcQ/tpVpy/pNDZLXMk0aN095JS0MGk?=
 =?us-ascii?Q?5qvqQsVIsLKJjcWxkYR39YBpee8crPXf9BaeBSGywwHlKw6+X5/GwZqMwKTW?=
 =?us-ascii?Q?duIKGDKC/idUep1AKZTCV+WByYxMcYualNfwsAmKK9PB98qYakNT3WTPw5c6?=
 =?us-ascii?Q?dq+WZvk3dsMWPYIZbPegTStKbVSoysWqwYbfSaFxhsKE8/HiVP+piAMuSNcH?=
 =?us-ascii?Q?QfD/brJr+Yyz86nmlFM/RtDN5QQYAPBRCbldeW7KG/0AH00w6VNiqIONdsoV?=
 =?us-ascii?Q?cnYPydM8VUqGQ19z2u0v5MmP3nsfrkVOdIGfNmcZ/uFThQT868bvdWPWtPDS?=
 =?us-ascii?Q?kJeA6FSVKpDl7MScr9En9zPsKIVf8pGqeJv0UjFjFS0sJdb3OBlZPgLlR2wt?=
 =?us-ascii?Q?HeYW2NSdy97jTTrrEDW454RXYtXDB2Kkrt5WglyP/P3hVlRAd8NxGjrqiPo4?=
 =?us-ascii?Q?Ce/qR56J13OE9z+zHlGDPhR1O8sLdOB3IHFrlVDo+pXRZ/+WJ+9TeAMymahq?=
 =?us-ascii?Q?4Nby06pKJX7k4AhQ3ZrX4/k2yYQW8OJC4ZBJFN8yy2JwP/sbUJSyjdq5IKFC?=
 =?us-ascii?Q?qMM1fAfoK6qW/G71CJg4HYCPi1YCUfb6f4E3BoGKyzmWKlFUHWNGwy/NEGWj?=
 =?us-ascii?Q?JWlgdSVKzLz+84QSkxSXIoYb8FoZzDA7G+Z8ojApxEL/WHPHsTg4tIEYd0o9?=
 =?us-ascii?Q?myFlibMirZgNaRlq8zwNX2L9v7ecpNal3WHk401nHS5no2BFgtgFErmfoCIJ?=
 =?us-ascii?Q?S28+ttuQxh5+xl43z6Xf1XV6qLpwX9LUYt9GFQP8OkbrJ8OMLhNn+EqRjrqm?=
 =?us-ascii?Q?bBtAT9qlvdIeypmz76S7Z6JPa9PzFGBk++i7Dfsvox6I/IkggsrrBadk6CiK?=
 =?us-ascii?Q?Ji6jGfa7wyYsSwKo/LE8QE/1C4dVhD2vl18gU2ogeJ7hdIry/cBk2j0YFJWF?=
 =?us-ascii?Q?dUew3jw1uGV1WR0VCBlZ5QeNTZw1YBMg6IN3Q5U59uwepfC7vfrg0+mRxDcl?=
 =?us-ascii?Q?fCRyrLm4ifKZiI/ScR4vv1cRsR1V+vxjIOo5TScz28iZK12lGC7jXUKqN71N?=
 =?us-ascii?Q?eN/cM4MZs81QH4JSFbgnSCwixA2JvgwxjPrFC0y5xHHyFWGN/jIXHSUjoHFe?=
 =?us-ascii?Q?ophvDWVfJNQnllxBAfda6Xo/dPz06qziNq98oWwfZEU+4RByDo+zcylofR7z?=
 =?us-ascii?Q?ESQiQqE3eoz2fIHRXvWB/VJsB8EYW3rg3zV3kVefvO5t40MjhuBIKesAy7gV?=
 =?us-ascii?Q?izZtmYcI8Q3UaYFPKFUOk66z3SQsHzG9F7ZulQYKXvDpb8hUrvAPaWamTSfZ?=
 =?us-ascii?Q?QorWSQZxN71jeZFcbxOzuIkWuoSSIwaPKUhAuEbqJkxrAlcqYr42lS5S5jvP?=
 =?us-ascii?Q?RYrD7vieXjfvi3cPEJvK/8KwBKpYptN31eLFNT24FHHasb+azf4+hYb7Z92f?=
 =?us-ascii?Q?dw2sZKhIqrYaRgn58HG8Qwhy6j8EpvNbwEY7y7K8e4HS3KCTBFy8Q/x4G4p1?=
 =?us-ascii?Q?w1dO/kuFRhEIAUHWbEXY1vHrjE6Rmo+SKIWhpcRLiqWum7Ek?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b805eeff-2620-4db0-afac-08de8aa8c61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 19:57:41.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iW1JizwfIPuZGWmWN/fkLURsz6Fkg7+XW0/GHJhGCOCDqSEEorm0UTO7NBYOSvVpzSwGDsMpv/OWDRD6f1tbxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6059
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9776-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6BC932B88C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Mar 23, 2026 at 12:59:46PM -0700, Long Li wrote:
> > This series adds per-vPort Event Queue (EQ) allocation and MSI-X
> > interrupt management for the MANA driver. Previously, all vPorts
> > shared a single set of EQs. This change enables dedicated EQs per
> > vPort with support for both dedicated and shared MSI-X vector allocatio=
n
> modes.
> >
> > Patch 1 moves EQ ownership from mana_context to per-vPort
> > mana_port_context and exports create/destroy functions for the RDMA
> driver.
> >
> > Patch 2 adds device capability queries to determine whether MSI-X
> > vectors should be dedicated per-vPort or shared. When the number of
> > available MSI-X vectors is insufficient for dedicated allocation, the
> > driver enables sharing mode with bitmap-based vector assignment.
> >
> > Patch 3 introduces the GIC (GDMA IRQ Context) abstraction with
> > reference counting, allowing multiple EQs to safely share a single MSI-=
X
> vector.
> >
> > Patch 4 converts the global EQ allocation in probe/resume to use the
> > new GIC functions.
> >
> > Patch 5 adds per-vPort GIC lifecycle management, calling get/put on
> > each EQ creation and destruction during vPort open/close.
> >
> > Patch 6 extends the same GIC lifecycle management to the RDMA driver's
> > EQ allocation path.
> >
> > Changes in v5:
> > - Rebased on net-next/main
>=20
> Hi Long Li,
>=20
> Unfortunately v5 also doesn't apply cleanly to net-next.
>=20
> --
> pw-bot: changes-requested

Hi Simon,

This patch set should apply after this patch: (which is also pending net-ne=
xt)
net: mana: Set default number of queues to 16

Can you apply the patch set after this patch, or should I wait for the next=
 patch merge window?

Thank you,
Long

