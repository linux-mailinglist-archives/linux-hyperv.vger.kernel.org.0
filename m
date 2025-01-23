Return-Path: <linux-hyperv+bounces-3756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B23A19E01
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B97188B604
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D731552E7;
	Thu, 23 Jan 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QhGXKo/D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318335959;
	Thu, 23 Jan 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737610589; cv=fail; b=aE2gvAJnFlx7mD9vf+r9XEkuzMgTjVO4oehg+16TSAGfJm7x0FjkoaxQo2fYrRpZPUgxn0s16P5DG0CSDGxPCm8GKJv5Z7dj6c0vQLqe72F7bIqC37qJNca7ic4r7R04peL+rIJncWYcj4ZwdQo/zv1SdHn41cmz30oYytHkyYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737610589; c=relaxed/simple;
	bh=ZD1wz8ehZa2/inAOl0bd5YTBjZ/+2PHIjF1J2LMewSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRpZNSDxb6WnRpjYD+Afwgldh4PyqhDD+w5vHUuw6u8RlSbSI9eXbZCKMkBTNBFlw4m5OI9Ris0GX9znamJCoqB7Y+eCqCsUFPSvs/wuJQuFrJKqcgyfcVy19FGbD9704Nieb6e9JeWK1RqFa3gZAne42gnC3oz0vlI6gyb3dcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QhGXKo/D; arc=fail smtp.client-ip=52.101.57.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chz9TkbPxgpVMUnv99lBE58yvRVSifDKVJWyAeFNRiyb/4nVFNHUrsnuu95tBNiJ5pkBntLj6iwjlSqqwSMAkTzoq8FpQCjzEvFNCmK6LhHEswrV2DwVUkbzik5D4LO2LgJ7IC3UCberqbYkbUnoqX558XoLopYHSusTy5OAfvPUcFPtqbhDsvHLfR3wSqq0p4Xwtc2PsE6qyLmxYmOSwkLome8xX8oYVW+36rEfLZS9725+ldDPu8k+SnEc+3sbIzcMG2+lylr8/QAYQkAJCAwWUhgyPkqb3eqiJtp+vvoRt2+2Fa+Vszl/FMcB/LiL8JneN/+7+LlXAMN2oE3Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIlWNc/acmRZJuN5bZNTQdWB/yzYs9j8rY7PwEW6j9Q=;
 b=EPku6un1Z2cJ+8tilPP9zzAtqig4d52V62uOOycXIpzwPLNgaou5KrIHNygtSblutRWuqr+awN4DchMz8KVHajJi7r4gVEbHAmIGJ1aRkKcjK+ednEjb467XE56cUci+eH2l2sd9nj/2+FA4QHzqOcGSRZFdpj/2D0w2QBvGjs8cx6VJxEUWFpGo/CrZai1g+J/7mN2kVKIRGzSLrudADUP6a6EqST1UrznRMfZ4JkKFL8mgFQTp6bosyo+vZXiSJ6mHOw8nILpUWTKVcowpSKAxQi6rMCe68RuaMuV9RXDdxrOrF0dh951frrmPcRF2tdKTTMkpCY2tIAKNMJVY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIlWNc/acmRZJuN5bZNTQdWB/yzYs9j8rY7PwEW6j9Q=;
 b=QhGXKo/Dbwv1lPgroWfRvlt1SgQ+qoe8I2XMXkXvpizW7e9rUog9sFxrqJmtIUl/E1xo//cLKii8YKNURcUBTpQxZYt3KouDcXLw6nwgaO0s5/ykBcTU2fCogC7oLhgx1hbd9+A+LPWZ0HwLvzytTtvIbTGKu3bqsUtuLxqS+EA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4263.namprd21.prod.outlook.com (2603:10b6:806:41b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.8; Thu, 23 Jan
 2025 05:36:23 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:36:23 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Topic: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Index: AQHba2CX673w+Di5EEyvbnDtOFQ6ZbMj2ifw
Date: Thu, 23 Jan 2025 05:36:23 +0000
Message-ID:
 <SA6PR21MB4231B32163CE8420F572538ACEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=883730d6-b699-4b62-82a9-2ffc22f6c14c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:34:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4263:EE_
x-ms-office365-filtering-correlation-id: abd8eeae-edb4-4ed5-1a47-08dd3b6fdfa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MC/i9IyCFTDY0jrC60TaUsNAYOLkg6VkDdDkCSeOJhqPwy2wMPeOPzt6NaUo?=
 =?us-ascii?Q?E15v+QVqWrjcBGC90ADAsV6+afcSL0wb3TkWGaR8Ca3oFtNSoj6iccuG/3AM?=
 =?us-ascii?Q?4fTu8UPgrsRt0PFut7H+canKzoaQMZaIESbdOeP5FeeEzqP0BVEIFO6d9K4q?=
 =?us-ascii?Q?Hx0/3gRRj2xkU6HU0eNumbLo/6ep6nrP6r7VTJRW/XOy72gwv5+ZMmJQ2lrW?=
 =?us-ascii?Q?AYFfFgZfsiyOu5rrCYu69tnMIzuYC+uTI7pVtpqwJfF1Dcj5MDFb/1S58t7q?=
 =?us-ascii?Q?KTpcovLevkKkaaqckF27ahRXuE915gu4pq5Ez6qfiOwNrYC68ayl1o67sNnC?=
 =?us-ascii?Q?8GgA+iip7P3Z8/ogLnGDe8QfYma8sa37IZYXvQvKjMiLIQ0k2DN8YYVqTFeE?=
 =?us-ascii?Q?INUk2cHipdDtEcTsostLVzucM5suGDZLHCqnDmsPxB3qoRShnmTI6EqGjkPB?=
 =?us-ascii?Q?ZTPAqhoYd0pLiPXfrqzELThq2tkxpi/VP1xEZcMKEitejOUB4jmKcBrq6xmi?=
 =?us-ascii?Q?NHWKMJ+QnP0ZGUXwD+mtoHtHQx3CNnmoZGwgLoiC0AEl/UgK13NKBKLTsvjq?=
 =?us-ascii?Q?kOOlmcXSFRc/WhR7x/tzvNTfAg2rss/UoNT/1SLJwwkjlkuoTQkZGG0JwEwf?=
 =?us-ascii?Q?YoNHnqZd13+bV6mk+m20OTZChRq2PRo2dVj+QMV7iIQd/08uvAfRBZJILGGB?=
 =?us-ascii?Q?/G0NwmQLo5PHuISscbekcC8t06duMFcDhV3cddvbDAAIwxPmGhcy6z04t7gP?=
 =?us-ascii?Q?V/1WNy4wwWsyRDMet+mSJavZgc55vJatMmGHQTz2PuK+d4mDVaO86wl36mCn?=
 =?us-ascii?Q?TlfjbmNCSPcPXPSmvzr80KHpZTxtJbZCZZHVnK6sYP1OgskH9fjYUKgopg8I?=
 =?us-ascii?Q?EVGYvOtygbEdnrW+89ZAjgxfmkNTQQEe7++W0d5+CDjJTkYLeMUo3sdr0xew?=
 =?us-ascii?Q?LmXQkHQCC2LC2Rm5BQa3BZp6l3wRmoRzJC+C00DZxj+AisiPdTSjzR16B4gz?=
 =?us-ascii?Q?99Lm00NqomxHKHdDBYs51bGuHp7bvNmFO27nujI22XtgDNtRmmpCKDwzmMHw?=
 =?us-ascii?Q?W5mqslqgHFcTENT7PzGf7WHE2+y0t3MX9bKmms8eiU4TvtXdI4Grh741mde8?=
 =?us-ascii?Q?J++NfBAz+gB+pgrPXvoRF5CTbMwpPNn4B+XA7ly57pc2ldaDbGTLUQ1GJ552?=
 =?us-ascii?Q?GZCE6O1AeadVOPD42z3i2rI4J6U9cbkzdP/jpJgv/nN2HQaBXHNU3uREx+Ry?=
 =?us-ascii?Q?C3tiqzBSvwUjco2bNQvTWMkap+X6ZR0axgHNRbaQGUt5iEBh7HrMA8fZyNm/?=
 =?us-ascii?Q?4XLMjkBvwlcyQQgxx5gNQEt57xAQIAUzalAgvr61VnTNt63ICn8srMgh4gu7?=
 =?us-ascii?Q?6fp0MX8jdVUR4mQUjKmeUUZyBl18afIi35952G0A/y2dxXHgVN5spN45kGzn?=
 =?us-ascii?Q?2BaeCaBrYFS/CzRKxB/l9myT5MbUmZHgVHDW+0CJddKu8zaiCzHsiQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MnBhsQYrSantYIOBUeyDqIVKV+Q2TRNjvxka4diG/NUngjLOzPquBs0hdf+Y?=
 =?us-ascii?Q?+cYcg0vl+2UTPIajN3KwdsfZ3Ap/c4FuyTRZeR6wYwxPhSZEr+pHsYhOMBlq?=
 =?us-ascii?Q?G7MxvZfCFIxbeiDqmgkjC2hBBOPmEDVDsEyQMQ1GPmyjJJgdifZlDsGeg5MI?=
 =?us-ascii?Q?wPJwqBuAHgjDT3T4QRZoaA/Q3qNcPBH4Tb7HYmkEz0NM4DecTQTS9oaW3njJ?=
 =?us-ascii?Q?+WJQHK3dDR1/HGEmG/1PkdXhq/HASgohFXr0cRVLU8E/rf8Q9flV6wHiO8x7?=
 =?us-ascii?Q?sXhsqZi86rzHvNBMpWLyRcc/BebTrh42AhbzJK+o51I3H3AFUop3CGLcFzpq?=
 =?us-ascii?Q?dq4tuP4P3EZgugWymYDapG8UtXOU5AwRQniFIPtsw+Eyx7e2n0V78OSwVfQ4?=
 =?us-ascii?Q?GXd4QR22zo+TLsWQs1a2gdmo0Zw2yiHBSyEjtgXalv2MozenonluP9Afc/Lz?=
 =?us-ascii?Q?RVhu0OZxnQQok4MnZADVgLuy/G0CbeOXeElGZXsplSiFxhAV5R4MR+kqIEe/?=
 =?us-ascii?Q?8b5onf6ZbgLJJKNVf86QSMYeh/Ra4cDzUlVFcq5xuk+dtoK6QSJR+SXgfPya?=
 =?us-ascii?Q?zp1bdkcr/vGxEuY+3v2O7oBcLCKAESAdBHA9ryw3oI0ANgfc73lP1fmXNVbv?=
 =?us-ascii?Q?GqmKaKRaQoKRBaGVHJVeMJDByfklfot6N1xs7f8MayamFphVNiGSzzSN4J3r?=
 =?us-ascii?Q?MexWPZdPReQeq8cFO51wCagIauYqxQBC3Fx/+/RzksP/xWJOMXymcrEVvj3a?=
 =?us-ascii?Q?QKUixRqDWdfsV3Bzi5AZPAgI3L1gn9BLdz7T8YR5nFcP92LyWuS64W6HdKc4?=
 =?us-ascii?Q?9mz77U7bic5mSSkhhpdco/PSwRiQGrtJSlXgiKHwAtY2+Dm/dPgoodNTWttG?=
 =?us-ascii?Q?zf0WCaJdBenOKeMI6ZDtUtLUrYhtNYUMVZCo8xNhsRevRQVh80uaqMUABCff?=
 =?us-ascii?Q?1sMuCRJdmbhbfr9f4M3qr29hJNS00Sa5ZNLVXgnVRVk50sf0aolqGRC73GrK?=
 =?us-ascii?Q?l7eEBsrnGFyQ//p9QbAIXt6wrZXJX8OYfFySfl/lwf9V+AK9+rDUoseWGbsD?=
 =?us-ascii?Q?9SGXA0eFTCgHFqkB4vpt0rZmo3Z/sBUBI8+PXkiWbW4Xa/tbbwhfumfntlHM?=
 =?us-ascii?Q?e9W1jiPAjo88GkbBVQwQ4eJbK+7KVwbnwqNP+l6F7+dftZH2VL92fy5BrZd7?=
 =?us-ascii?Q?EgD7ER2byN2b+KZEeNEGdiCMK/+IGi7wwwLTEaBIS7gVmKGRLJa0XqKxoxF6?=
 =?us-ascii?Q?j9Moj8cH0Cw5BDDLRR2vOpKz/e8cr4H2RAeeWDNbANIJKOs85nGZQb5bRBMm?=
 =?us-ascii?Q?GEv0vTruBwJOf0PlSUxsgbPhlxwcgQNGxYo8+VVkUXJH7ni/cXDga35rMLhi?=
 =?us-ascii?Q?qQ6bpP9WqGgyJYDeKOsRSWyul7N96tIzVeMUfIQRZ5p5C/BYJCGa6tlEO5eo?=
 =?us-ascii?Q?D6GQ+MWpi95HoyKSvtpfaAkjWW1URaPWWw825AVzqcbvIjkDy9QZm8TiKBKA?=
 =?us-ascii?Q?PWX5MsLs6+n7pq9dZln+mWkxJHX841tUSo+FW+H4nR6G7hJ+/fg/ymT8RjbE?=
 =?us-ascii?Q?zgCHWzucxlne4npO26YSrKgCfim5TGyk5PAkjzFC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8eeae-edb4-4ed5-1a47-08dd3b6fdfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:36:23.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpC3r6E4tG3d2ykKY+Xjq+V6Cj/vy5hIeMhCSRGT+e3VhuSjoZMyIpRhC0hRRciU5xXXTGGJz1LAeUGKzxHP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4263

> Subject: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement creation of CQs for the kernel.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 80 +++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index f04a679..d26d82d 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -15,42 +15,57 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> +	struct gdma_context *gc;
>  	bool is_rnic_cq;
>  	u32 doorbell;
> +	u32 buf_size;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
>  	cq->cq_handle =3D INVALID_MANA_HANDLE;
>=20
> -	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> -		return -EINVAL;
> +	if (udata) {
> +		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> +			return -EINVAL;
>=20
> -	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (err) {
> -		ibdev_dbg(ibdev,
> -			  "Failed to copy from udata for create cq, %d\n", err);
> -		return err;
> -	}
> +		err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> udata->inlen));
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to copy from udata for create
> cq, %d\n", err);
> +			return err;
> +		}
>=20
> -	is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> +		is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
>=20
> -	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
> -		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> -		return -EINVAL;
> -	}
> +		if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr)
> {
> +			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> +			return -EINVAL;
> +		}
>=20
> -	cq->cqe =3D attr->cqe;
> -	err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> COMP_ENTRY_SIZE, &cq->queue);
> -	if (err) {
> -		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n",
> err);
> -		return err;
> -	}
> +		cq->cqe =3D attr->cqe;
> +		err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> COMP_ENTRY_SIZE,
> +					   &cq->queue);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create queue for create
> cq, %d\n", err);
> +			return err;
> +		}
>=20
> -	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> -						  ibucontext);
> -	doorbell =3D mana_ucontext->doorbell;
> +		mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> +							  ibucontext);
> +		doorbell =3D mana_ucontext->doorbell;
> +	} else {
> +		is_rnic_cq =3D true;
> +		buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe
> * COMP_ENTRY_SIZE));
> +		cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
> +		err =3D mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ,
> &cq->queue);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create kernel queue for
> create cq, %d\n", err);
> +			return err;
> +		}
> +		doorbell =3D gc->mana_ib.doorbell;
> +	}
>=20
>  	if (is_rnic_cq) {
>  		err =3D mana_ib_gd_create_cq(mdev, cq, doorbell); @@ -66,11
> +81,13 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		}
>  	}
>=20
> -	resp.cqid =3D cq->queue.id;
> -	err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen)=
);
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> -		goto err_remove_cq_cb;
> +	if (udata) {
> +		resp.cqid =3D cq->queue.id;
> +		err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata-
> >outlen));
> +		if (err) {
> +			ibdev_dbg(&mdev->ib_dev, "Failed to copy to
> udata, %d\n", err);
> +			goto err_remove_cq_cb;
> +		}
>  	}
>=20
>  	return 0;
> @@ -122,7 +139,10 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq)
>  		return -EINVAL;
>  	/* Create CQ table entry */
>  	WARN_ON(gc->cq_table[cq->queue.id]);
> -	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> +	if (cq->queue.kmem)
> +		gdma_cq =3D cq->queue.kmem;
> +	else
> +		gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
>  	if (!gdma_cq)
>  		return -ENOMEM;
>=20
> @@ -141,6 +161,10 @@ void mana_ib_remove_cq_cb(struct mana_ib_dev
> *mdev, struct mana_ib_cq *cq)
>  	if (cq->queue.id >=3D gc->max_num_cqs || cq->queue.id =3D=3D
> INVALID_QUEUE_ID)
>  		return;
>=20
> +	if (cq->queue.kmem)
> +	/* Then it will be cleaned and removed by the mana */
> +		return;
> +

Do you need to call "gc->cq_table[cq->queue.id] =3D NULL" before return?


>  	kfree(gc->cq_table[cq->queue.id]);
>  	gc->cq_table[cq->queue.id] =3D NULL;
>  }
> --
> 2.43.0


