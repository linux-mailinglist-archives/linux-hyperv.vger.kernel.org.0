Return-Path: <linux-hyperv+bounces-8335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E607D33A31
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1DA30329DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AC28C009;
	Fri, 16 Jan 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HMngbwhY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DCD337BB6;
	Fri, 16 Jan 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582869; cv=fail; b=rhVFl0djKLP7jgUdup1Ng4tv6NfvAu+OJAMWdZHnm8ugxCfOliMTY5J7uZw0lWHr6VW0mJfHVFXVybYTw1ikjs6sRnrxoAhfTEnxaBwK3hHycXcvT/evYc3Wi/6DwXfD0XYnK8XAf0fY0KMm/OuYQSPzGDwujsTz0Yjcq/QdawA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582869; c=relaxed/simple;
	bh=VqBUrveYEuEzDMmC7NCUIQTxQzU5dew3tdnBMbG8Vfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbD6q2ocYQRKPRLBkqX1lLPbRebms78M+n3x1kHkgOLuIhLC3MLUxIn/kKTH83DKbJUkpoSoBGvi0LV3rE8zlYD/ILURr5E6bGQ88qpHLDkq7Yxcz0l/knKTF1ScWlYB5aHVlFedS1x8AVZTr3VpCtPDKIRNGWpTIaedFqbRBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HMngbwhY; arc=fail smtp.client-ip=52.103.14.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3TQ0PqS1MiTC6WPz++qzxems+nJ19IAD2s732HYij9fQevMUDGcoT6d1ZWj143IaaWmFm2EJFbmdsq05GkGeQNORDmrshdPfkdjoNVS8Zz1pWqnrUK+e4QB2jGkhZ2UT7DD/G4OkBF65lWHFSFgCL4fB3g3f/DsSYO4igOHuAL7D+yMfmgyFsbQUlCBVeWzKRlI3CBfJRvOAPuRUkykQF93DhIKQDKvGCrjNyeTikaXpMOE+1GsRRBflciV1xGIiDXSVhKBFAUefd3vu1QhSSTpGjz9xsx4VzMAR9mTgce77RU4qCK6lmbI4EZUYn80W4HT1PI8R13DZGn8JEBS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOoCO8HklZa4di9VAxwvj6JVhnPBL+FlcUKSC6RpzJI=;
 b=rKqD2fAF+Fl6ynSbXMYu8jCgwLxJWcI4Z7yS8HcJvjRM5WUjjD+p/ll/gWGAAGAuzewzSFVxfDpZpt71MWbYIpVwEerOVUq8yTCO/p5MTJIbP1KVJhmBMjolDxKI0newiRwAjlT4v5f+QKVdL5C7uyWscJtZl2yy7p0d4PTsuk/JB90GESZlHlxwNNmv2qbcS7lbg3VI8UlZ0hew5nH5+/KpTPgOV01xfCsTJns0xmVkH1Olk4tJ4ltTftLwb0MTgUqQT+a3XLvpvo4bfz6jSwEEJrvBB/hlS+U5mZD9UrELnIeak7E0WiqYNTooWFCURnggujwpgcNeJ8uEx7colA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOoCO8HklZa4di9VAxwvj6JVhnPBL+FlcUKSC6RpzJI=;
 b=HMngbwhYwBgXxopDD2E509SDaYr28gXSO/BtE7vU8g7YDi4Tx/A06aL91dsRMFVlM0b3JwZl6lda+zroqjeiE4Jx/ggnFTBangYRUP6YGdMTq5Gmwvdx7RbhMWZO6j/TRInvEUaRCk1f060+8zLVL1jpcm9Po/2mCjxR2ASOBTIk16kc3hJW6hFlZLfVbOFoU2wVmEWCJ3vbbRQAAmtawQZZwcrOfYapQdlDfMGCWscCPOsBDItY9YfOWmpARAA6Af9hHu2x477HlSJ6VrmmG3TSymA3oToYgAbDdj0hqYQfzcek2/GeHiaTEbzFC+PUtO9YlnTzHsDSdD+oPvntbg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8069.namprd02.prod.outlook.com (2603:10b6:8:16::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 17:01:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:01:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v3 5/6] mshv: Add definitions for stats pages
Thread-Topic: [PATCH v3 5/6] mshv: Add definitions for stats pages
Thread-Index: AQHchZ4UcA24foQfF0GZedhpagKJy7VTaheAgAA2sQCAAVUysA==
Date: Fri, 16 Jan 2026 17:01:02 +0000
Message-ID:
 <SN6PR02MB41575DED97B3E791238296AAD48DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
 <20260114213803.143486-6-nunodasneves@linux.microsoft.com>
 <aWkTd2zkbVQqePVa@skinsburskii.localdomain>
 <89385dc3-e702-4bf6-8ad7-f6e634851851@linux.microsoft.com>
In-Reply-To: <89385dc3-e702-4bf6-8ad7-f6e634851851@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8069:EE_
x-ms-office365-filtering-correlation-id: 4e3f09de-d83d-41e6-b588-08de5520d43d
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TXC3SDMOKasxb1Truxn0Xe/iAwjed58XnpUEQz9Z2EhAYntb4lkiFfkeYrAhLOREDq0UecbeYCNSm/lGHmCtn9aHJ5lSkeXV4RfIjblnn9dtHmTV5kR7QAD2VcQU8The1gSGewlHt6pEKZ5uHrVdDcylAcP3av/C1/FEvXzLHhkAHCi4BNxuwoFtVNV//uXMvuqwzLzZ0FoM1OZpDg+5BYkZESMa4deRvRjcn0ESM9tYggFKX4TgWcdwj6NyVY9jLl7T1B55ouprKChMOZgpJiOQswb44Wsu1jifKJRM7fY/xmv91x7y5JWCOvCF93A17MM/Dmqj9aaMv5k1dQAgyHW5JR+JGEx3dRN3ISvozYnzpOk/0LO6w+37ID6Zf7pJwY0HpMI3QKzJDOXBRQ5SG5ZyKCLun3q80aY16m2RG/EIiXYvPoj1PW0SZ/qLUqZuacf874kcHu/Xvq/9FO5hUaHCtIE1KwPbTRCkF2V4T/wjD2wm0zDRQXEy67d+0+j/M1cybRVkFdqEKxGe8KSOiAsOmPlkC1iuaZhVAIKcO/1EaxYtt+ZCNzSyYYt8lCCh//LDAd7LEpLuuBIbESI4uQwC8FdDV6tQ9d16zm58mUdVEaIy5eEbmCyngEa8lKt86iQG8zisVzKEz0+APtfFAh+4jtQrhClAKAT9MaXyw2FaoWNHtbF81kla6mOCqzzjTwzMxSsJ9D4CEr3i6IkL31oy1hffmfKPT+hrABcQ9FbIGSqKfiKoMmB7RAvRxUGsV21EKmcSdRQxaUELoEoJRMwHiyEshpTBLI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|51005399006|13091999003|15080799012|19110799012|8062599012|8060799015|3412199025|4302099013|10035399007|440099028|40105399003|102099032|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M1RN5Fq7Gns8jrLrFWYGghl6V5UZiCNMs/xdH2NBpEc3qAYjICj6NM1v+pEK?=
 =?us-ascii?Q?FQxMVcAoI7Nn5i5qoXP7F0vdP3ILtCKdP1W8Am3PFV1YInqrm3fWRATTww0k?=
 =?us-ascii?Q?GQTqmFL+3HYHIylBt70/kWpgRRqa1xLj3a07sq/4yBVrz1fxxvnc2ThyNwRn?=
 =?us-ascii?Q?akmtxEzlPjZkKjQwMdMK9KRcJ+XkUhX+wSfj7NxazvplkR6jyZ5VGKaYeuPe?=
 =?us-ascii?Q?yJH7KWNbkttFeFlAFBMYUphjtuarksw2A/dS44QrHwrj9klADQViS9/yuM0c?=
 =?us-ascii?Q?Nb5l1nOYDTwPhH3UqN82yvZT19WhM5kPTKZDXtCaVMdXI5laCa2bXXeVsTDq?=
 =?us-ascii?Q?ol1AaJskDfZ6fO2ZLbuO01GJ8k1BYgQIFs6r3WqyuOROIA3Gpv5CmaP7q58c?=
 =?us-ascii?Q?xacsb3fq78wWR/SFZyU+eqipJ+TI7zQ4kxvFFPc788PcEUQC5Q0J3NJTNfQu?=
 =?us-ascii?Q?TyhRcMm26jcI5qMLvb6zm3nbU7hRXrLEa1n7BfOHnlPY+4Skp+k6Erz9sST5?=
 =?us-ascii?Q?f6tEecEYB5qdudtHw0qAzP3kJUzWPqfi4um+PEDT30h/5Bt7YkKPV85AN78W?=
 =?us-ascii?Q?o+LtazJnPrriK/xrWpWoFxHXfHq+TsXzh6xMM2kWyDI5XL9ZrozHJIt3q7YK?=
 =?us-ascii?Q?JciyJCHk8a+Un3pfYuN/QoTLxb/jFD4JFjOJQHETwPEJ8j/ZSvEOMIW92Zb2?=
 =?us-ascii?Q?ddcfUHs7eSPzBRrO+mf+zb+Ckj+NcDwueKvKqGxlKEZ+WRNq1DTfbtHm6n0p?=
 =?us-ascii?Q?y7aH8PJpgyszPhqqA3M3hHm+PsY4/Q5/2GDW6PMLW5xMcr+eLLZe3a4z+vtn?=
 =?us-ascii?Q?PN39zMLNkFjiwyTCPoV6qQG47N8Jnr4c9FEeru0Ubyuf+n7EQ5TLZEV4IZdt?=
 =?us-ascii?Q?9Muh5acArgfU13mcKYhhx6wICrptO+381hvpIz6beopjWqwJ3UY+xWEuVrmF?=
 =?us-ascii?Q?7+AwSTBckBJxQ2F0QWpD4s3X99sPt4FqewddKdvuosZK9yCch9jRIsZcRP0j?=
 =?us-ascii?Q?uNiYLWWFMjNFF53b+8ZXpccNJBnc3Y9K64RUXQbh8L3Os2Dp87jvRAZMANHE?=
 =?us-ascii?Q?LS6vxve/INmsCPFsxoIwb3vdDYctAzlCx0XHEFyBppQz+hOEWDXGfRV2OqMY?=
 =?us-ascii?Q?6DHrojSEX0EoOu1JXPmQPpqBwss5h60me7W4E2a/H5BCcG48WY20toY98NlU?=
 =?us-ascii?Q?NpC4YqzWTnypGsf9WVD6tUp/weAkqGldvYFX2zvMUF+GM2kprpVQKunjKd1x?=
 =?us-ascii?Q?JW1dwiha31DbqJDGo3n3IUxKxJnMvLrq2eUfEBnJa9pRz1TxUCrQGEzKYA1R?=
 =?us-ascii?Q?6QxvZv4hfbg0ZufF+OjleS30ug9nTPC2yipf+H5LsGrb2w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xLxVw2RCZadq1Sy5DSwFNoghIGn+Z7ryElqAJKA5jWOvgER1liwp34og9+ee?=
 =?us-ascii?Q?3BHLRET5C4EyHclgNkaUUn/hgii8gtKaD+alBHZmy9EksfBLljHhZalaVgtD?=
 =?us-ascii?Q?awchXA33qnAlYGC1ffAGo7GYwz4ZnpSvwAStqLN3eqqOmrdf2LCwUoAKhPs/?=
 =?us-ascii?Q?NLgNFQyh985FehS1dPASStFSbH2nOC466LWryZjmJX5gKHOyIhJAC14HoVhj?=
 =?us-ascii?Q?P3sbHFcYOnBNzGbLqCrH3Ng42Edc2ZK+VntMdG3FOZI37RR3wiIPS11XzxqW?=
 =?us-ascii?Q?zg2c+IyqUJk/3S5pE9evzA1wiEBhSoikDtJGIJZoEGrUpD4+352+3wxVxv65?=
 =?us-ascii?Q?4VBGX2w9jHTFnMjhAQWDsFSJKLgISG4OwYJxSYkKHkMa3GG5rwfwkZ5T9lKH?=
 =?us-ascii?Q?Rvqzs3xlHfjUkh+oanUEqJS+vLgU1HE9giDE7Nsth/Mf7hhM8holG6s9xv3I?=
 =?us-ascii?Q?zV2wRDgB1x6CiwklgsZWh2MlHbldL8o2O8EROJzGzlsqKaX6N3vj8DqmNes0?=
 =?us-ascii?Q?FzL1S3UMPuf55yVFlaCnU61laOrKULVCszX2h61V+0ydcuUewY7Nr/LbNYr2?=
 =?us-ascii?Q?AZKDdLoVQbEQ4YjuYrlETUr2kVd7GW6WqMyYR8YzUAw16D341lBsyZwMTiph?=
 =?us-ascii?Q?bajgegC6rBroU5T9xhhMx6se+rwJ6Mqlx6RaULuOjQtJd+S5nKb33XT2gRbc?=
 =?us-ascii?Q?6g++f9yAWsDIwL6Thz0vCUiqPEXH1+oPqn9vvRjjW7XZjaIPXvtEcqeSsJve?=
 =?us-ascii?Q?+d4qkWobH84ufjBTUUUTUKiiTDOg5ay5Osivhd8wbjlDYfTWw26DDIP9hdQQ?=
 =?us-ascii?Q?1+ZINDgv0xi1nAabp6jCEfg2OvhetoqyaKYvGcEJay/SzC3MT7LFTXyI0dzX?=
 =?us-ascii?Q?GGu+t3e6fc9E7Vw9xxZ4C2PA5rAd1kKqfMpOxzEub9frwUsRPLboplT1i3kN?=
 =?us-ascii?Q?jAJeVqwRcc16r3URIKz27NHfJLRJfkmPkOH5LXirqUPhP2GmgbDzgpFVXuex?=
 =?us-ascii?Q?dMv8kZkXKnn82UrusjsN9nE0V5ZyG/4M1CIWHdIOIYZzhWuu7PiiU5cdDSlF?=
 =?us-ascii?Q?m7FEvZftYsXObZIrIGXOA4MgJkPHRqMvVQyAU6z/0xMk0QUaB9NwQeXykJCU?=
 =?us-ascii?Q?hl9MCTL3zpmbeuwrDomY1ZlJH2E9xrLLaTRFaGgcmAllwsMlNmcVYX6etXuh?=
 =?us-ascii?Q?H3SiUCUB/2hhPvxwzwRU5mApMrYxVF15Q90Fx/XiUlDR2ChTSSgjWHN2e+o9?=
 =?us-ascii?Q?3AwcwaIkHYPUoVNdeSgNpuOJtzDVa7bQvAcoCKcwQT/2aHnF6uBqaTLzdtRH?=
 =?us-ascii?Q?9zeIo4urJBsUgRyJlbZDDMdA4lOHYr0I4oTrVjJCGjZrf4bm1Y7rLP/1w8wf?=
 =?us-ascii?Q?F+2LRyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3f09de-d83d-41e6-b588-08de5520d43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:01:02.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8069

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jan=
uary 15, 2026 11:35 AM
>=20
> On 1/15/2026 8:19 AM, Stanislav Kinsburskii wrote:
> > On Wed, Jan 14, 2026 at 01:38:02PM -0800, Nuno Das Neves wrote:
> >> Add the definitions for hypervisor, logical processor, and partition
> >> stats pages.
> >>
> >
> > The definitions in for partition and virtual processor are outdated.
> > Now is the good time to sync the new values in.
> >
> > Thanks,
> > Stanislav
> >
>=20
> Good point, thanks, I will update it for v4.
>=20
> I'm finally noticing that these counters are not really from hvhdk.h, in
> the windows code, but their own file. Since I'm still iterating on this,
> what do you think about creating a file just for the counters?
> e.g. drivers/hv/hvcounters.h, which combines hvcountersarm64 and amd64.
>=20
> That would have a couple of advantages:
> 1. Not putting things in hvhdk.h which aren't actually there in the
>    Windows source
> 2. Less visibility of CamelCase naming outside our driver
> 3. I could define the enums using "X macro"s to generate the show() code
>    more cleanly in mshv_debugfs.c, which is something Michael suggested
>    here:
> https://lore.kernel.org/linux-hyperv/SN6PR02MB4157938404BC0D12978ACD9BD4A=
2A@SN6PR02MB4157.namprd02.prod.outlook.com/
>=20
> It would look something like this:
>=20
> In hvcounters.h:
>=20
> #if is_enabled(CONFIG_X86_64)
>=20
> #define HV_COUNTER_VP_LIST(X) \
> 	X(VpTotalRunTime, 1), \
> 	X(VpHypervisorRunTime, 2), \
> 	X(VpRemoteNodeRunTime, 3), \
> /* <snip> */
>=20
> #elif is_enabled(CONFIG_ARM64)
>=20
> /* <snip> */
>=20
> #endif
>=20
> Just like now, it's a copy/paste from Windows + simple pattern
> replacement. Note with this approach we need separate lists for arm64
> and x86, but that matches how the enums are defined in Windows.
>=20
> Then, in mshv_debugfs.c:
>=20
> /*
>  * We need the strings paired with their enum values.
>  * This structure can be used for all the different stat types.
>  */
> struct hv_counter_entry {
> 	char *name;
> 	int idx;
> };
>=20
> /* Define an array entry (again, reusable) */
> #define HV_COUNTER_LIST(name, idx) \
> 	{ __stringify(name), idx },

Couldn't this also go in hvcounters.h, so it doesn't need to be
passed as a parameter to HV_COUNTER_VP_LIST() and friends?
Or is the goal to keep hvcounters.h as bare minimum as possible?

>=20
> /* Create our static array */
> static struct hv_counter_entry hv_counter_vp_array[] =3D {
> 	HV_ST_COUNTER_VP(HV_COUNTER_VP)
> };

Shouldn't the above be HV_COUNTER_VP_LIST(HV_COUNTER_LIST)
to match the #define in hvcounters.h, and the macro that does the
__stringify()? Assuming so, I think I understand the overall idea you
are proposing. It's pretty clever. :-)

The #define of HV_COUNTER_VP_LIST() in hvcounters.h gets large
for VP stats -- the #define will be about 200 lines. I have no sense
of whether being that large is problematic for the tooling. And that
question needs to be considered beyond just the C preprocessor and
compiler, to include things like sparse, cscope, and other tools that
parse source code. I had originally suggested building the static array
directly in a .c file, which would avoid the need for the big #define.
And maybe you could still do that with a separate .c source file just
for the static arrays -- i.e., hvcounters.h becomes hvcounters.c. It
seems like the " it's a copy/paste from Windows + simple pattern
replacement" could be done to generate a .c file as easily as a .h file
while still keeping the file contents to a bare minimum.

Either way (.h or .c file), I like the idea.

Michael

>=20
> static int vp_stats_show(struct seq_file *m, void *v)
> {
> 	const struct hv_stats_page **pstats =3D m->private;
> 	int i;
>=20
> 	for (i =3D 0; i < ARRAY_SIZE(hv_counter_vp_array); ++i) {
> 		struct hv_counter_entry entry =3D hv_counter_vp_array[i];
> 		u64 parent_val =3D pstats[HV_STATS_AREA_PARENT]->vp_cntrs[entry.idx];
> 		u64 self_val =3D pstats[HV_STATS_AREA_SELF]->vp_cntrs[entry.idx];
>=20
> 		/* Prioritize the PARENT area value */
> 		seq_printf(m, "%-30s: %llu\n", entry.name,
> 			   parent_val ? parent_val : self_val);
> 	}
> }
>=20
> Any thoughts? I was originally going to just go with the pattern we had,
> but since these definitions aren't from the hv*dk.h files, we can maybe
> get more creative and make the resulting code look a bit better.
>=20
> Thanks
> Nuno
>=20
> >> Move the definition for the VP stats page to its rightful place in
> >> hvhdk.h, and add the missing members.
> >>
> >> While at it, correct the ARM64 value of VpRootDispatchThreadBlocked,
> >> (which is not yet used, so there is no impact).
> >>
> >> These enum members retain their CamelCase style, since they are import=
ed
> >> directly from the hypervisor code. They will be stringified when
> >> printing the stats out, and retain more readability in this form.
> >>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >>  drivers/hv/mshv_root_main.c |  17 --
> >>  include/hyperv/hvhdk.h      | 437 +++++++++++++++++++++++++++++++++++=
+
> >>  2 files changed, 437 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> >> index fbfc9e7d9fa4..724bbaa0b08c 100644
> >> --- a/drivers/hv/mshv_root_main.c
> >> +++ b/drivers/hv/mshv_root_main.c
> >> @@ -39,23 +39,6 @@ MODULE_AUTHOR("Microsoft");
> >>  MODULE_LICENSE("GPL");
> >>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface
> /dev/mshv");
> >>
> >> -/* TODO move this to another file when debugfs code is added */
> >> -enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> >> -#if defined(CONFIG_X86)
> >> -	VpRootDispatchThreadBlocked			=3D 202,
> >> -#elif defined(CONFIG_ARM64)
> >> -	VpRootDispatchThreadBlocked			=3D 94,
> >> -#endif
> >> -	VpStatsMaxCounter
> >> -};
> >> -
> >> -struct hv_stats_page {
> >> -	union {
> >> -		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> >> -		u8 data[HV_HYP_PAGE_SIZE];
> >> -	};
> >> -} __packed;
> >> -
> >>  struct mshv_root mshv_root;
> >>
> >>  enum hv_scheduler_type hv_scheduler_type;
> >> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> >> index 469186df7826..8bddd11feeba 100644
> >> --- a/include/hyperv/hvhdk.h
> >> +++ b/include/hyperv/hvhdk.h
> >> @@ -10,6 +10,443 @@
> >>  #include "hvhdk_mini.h"
> >>  #include "hvgdk.h"
> >>
> >> +enum hv_stats_hypervisor_counters {		/* HV_HYPERVISOR_COUNTER
> */
> >> +	HvLogicalProcessors			=3D 1,
> >> +	HvPartitions				=3D 2,
> >> +	HvTotalPages				=3D 3,
> >> +	HvVirtualProcessors			=3D 4,
> >> +	HvMonitoredNotifications		=3D 5,
> >> +	HvModernStandbyEntries			=3D 6,
> >> +	HvPlatformIdleTransitions		=3D 7,
> >> +	HvHypervisorStartupCost			=3D 8,
> >> +	HvIOSpacePages				=3D 10,
> >> +	HvNonEssentialPagesForDump		=3D 11,
> >> +	HvSubsumedPages				=3D 12,
> >> +	HvStatsMaxCounter
> >> +};
> >> +
> >> +enum hv_stats_partition_counters {		/* HV_PROCESS_COUNTER */
> >> +	PartitionVirtualProcessors		=3D 1,
> >> +	PartitionTlbSize			=3D 3,
> >> +	PartitionAddressSpaces			=3D 4,
> >> +	PartitionDepositedPages			=3D 5,
> >> +	PartitionGpaPages			=3D 6,
> >> +	PartitionGpaSpaceModifications		=3D 7,
> >> +	PartitionVirtualTlbFlushEntires		=3D 8,
> >> +	PartitionRecommendedTlbSize		=3D 9,
> >> +	PartitionGpaPages4K			=3D 10,
> >> +	PartitionGpaPages2M			=3D 11,
> >> +	PartitionGpaPages1G			=3D 12,
> >> +	PartitionGpaPages512G			=3D 13,
> >> +	PartitionDevicePages4K			=3D 14,
> >> +	PartitionDevicePages2M			=3D 15,
> >> +	PartitionDevicePages1G			=3D 16,
> >> +	PartitionDevicePages512G		=3D 17,
> >> +	PartitionAttachedDevices		=3D 18,
> >> +	PartitionDeviceInterruptMappings	=3D 19,
> >> +	PartitionIoTlbFlushes			=3D 20,
> >> +	PartitionIoTlbFlushCost			=3D 21,
> >> +	PartitionDeviceInterruptErrors		=3D 22,
> >> +	PartitionDeviceDmaErrors		=3D 23,
> >> +	PartitionDeviceInterruptThrottleEvents	=3D 24,
> >> +	PartitionSkippedTimerTicks		=3D 25,
> >> +	PartitionPartitionId			=3D 26,
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	PartitionNestedTlbSize			=3D 27,
> >> +	PartitionRecommendedNestedTlbSize	=3D 28,
> >> +	PartitionNestedTlbFreeListSize		=3D 29,
> >> +	PartitionNestedTlbTrimmedPages		=3D 30,
> >> +	PartitionPagesShattered			=3D 31,
> >> +	PartitionPagesRecombined		=3D 32,
> >> +	PartitionHwpRequestValue		=3D 33,
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	PartitionHwpRequestValue		=3D 27,
> >> +#endif
> >> +	PartitionStatsMaxCounter
> >> +};
> >> +
> >> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> >> +	VpTotalRunTime					=3D 1,
> >> +	VpHypervisorRunTime				=3D 2,
> >> +	VpRemoteNodeRunTime				=3D 3,
> >> +	VpNormalizedRunTime				=3D 4,
> >> +	VpIdealCpu					=3D 5,
> >> +	VpHypercallsCount				=3D 7,
> >> +	VpHypercallsTime				=3D 8,
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	VpPageInvalidationsCount			=3D 9,
> >> +	VpPageInvalidationsTime				=3D 10,
> >> +	VpControlRegisterAccessesCount			=3D 11,
> >> +	VpControlRegisterAccessesTime			=3D 12,
> >> +	VpIoInstructionsCount				=3D 13,
> >> +	VpIoInstructionsTime				=3D 14,
> >> +	VpHltInstructionsCount				=3D 15,
> >> +	VpHltInstructionsTime				=3D 16,
> >> +	VpMwaitInstructionsCount			=3D 17,
> >> +	VpMwaitInstructionsTime				=3D 18,
> >> +	VpCpuidInstructionsCount			=3D 19,
> >> +	VpCpuidInstructionsTime				=3D 20,
> >> +	VpMsrAccessesCount				=3D 21,
> >> +	VpMsrAccessesTime				=3D 22,
> >> +	VpOtherInterceptsCount				=3D 23,
> >> +	VpOtherInterceptsTime				=3D 24,
> >> +	VpExternalInterruptsCount			=3D 25,
> >> +	VpExternalInterruptsTime			=3D 26,
> >> +	VpPendingInterruptsCount			=3D 27,
> >> +	VpPendingInterruptsTime				=3D 28,
> >> +	VpEmulatedInstructionsCount			=3D 29,
> >> +	VpEmulatedInstructionsTime			=3D 30,
> >> +	VpDebugRegisterAccessesCount			=3D 31,
> >> +	VpDebugRegisterAccessesTime			=3D 32,
> >> +	VpPageFaultInterceptsCount			=3D 33,
> >> +	VpPageFaultInterceptsTime			=3D 34,
> >> +	VpGuestPageTableMaps				=3D 35,
> >> +	VpLargePageTlbFills				=3D 36,
> >> +	VpSmallPageTlbFills				=3D 37,
> >> +	VpReflectedGuestPageFaults			=3D 38,
> >> +	VpApicMmioAccesses				=3D 39,
> >> +	VpIoInterceptMessages				=3D 40,
> >> +	VpMemoryInterceptMessages			=3D 41,
> >> +	VpApicEoiAccesses				=3D 42,
> >> +	VpOtherMessages					=3D 43,
> >> +	VpPageTableAllocations				=3D 44,
> >> +	VpLogicalProcessorMigrations			=3D 45,
> >> +	VpAddressSpaceEvictions				=3D 46,
> >> +	VpAddressSpaceSwitches				=3D 47,
> >> +	VpAddressDomainFlushes				=3D 48,
> >> +	VpAddressSpaceFlushes				=3D 49,
> >> +	VpGlobalGvaRangeFlushes				=3D 50,
> >> +	VpLocalGvaRangeFlushes				=3D 51,
> >> +	VpPageTableEvictions				=3D 52,
> >> +	VpPageTableReclamations				=3D 53,
> >> +	VpPageTableResets				=3D 54,
> >> +	VpPageTableValidations				=3D 55,
> >> +	VpApicTprAccesses				=3D 56,
> >> +	VpPageTableWriteIntercepts			=3D 57,
> >> +	VpSyntheticInterrupts				=3D 58,
> >> +	VpVirtualInterrupts				=3D 59,
> >> +	VpApicIpisSent					=3D 60,
> >> +	VpApicSelfIpisSent				=3D 61,
> >> +	VpGpaSpaceHypercalls				=3D 62,
> >> +	VpLogicalProcessorHypercalls			=3D 63,
> >> +	VpLongSpinWaitHypercalls			=3D 64,
> >> +	VpOtherHypercalls				=3D 65,
> >> +	VpSyntheticInterruptHypercalls			=3D 66,
> >> +	VpVirtualInterruptHypercalls			=3D 67,
> >> +	VpVirtualMmuHypercalls				=3D 68,
> >> +	VpVirtualProcessorHypercalls			=3D 69,
> >> +	VpHardwareInterrupts				=3D 70,
> >> +	VpNestedPageFaultInterceptsCount		=3D 71,
> >> +	VpNestedPageFaultInterceptsTime			=3D 72,
> >> +	VpPageScans					=3D 73,
> >> +	VpLogicalProcessorDispatches			=3D 74,
> >> +	VpWaitingForCpuTime				=3D 75,
> >> +	VpExtendedHypercalls				=3D 76,
> >> +	VpExtendedHypercallInterceptMessages		=3D 77,
> >> +	VpMbecNestedPageTableSwitches			=3D 78,
> >> +	VpOtherReflectedGuestExceptions			=3D 79,
> >> +	VpGlobalIoTlbFlushes				=3D 80,
> >> +	VpGlobalIoTlbFlushCost				=3D 81,
> >> +	VpLocalIoTlbFlushes				=3D 82,
> >> +	VpLocalIoTlbFlushCost				=3D 83,
> >> +	VpHypercallsForwardedCount			=3D 84,
> >> +	VpHypercallsForwardingTime			=3D 85,
> >> +	VpPageInvalidationsForwardedCount		=3D 86,
> >> +	VpPageInvalidationsForwardingTime		=3D 87,
> >> +	VpControlRegisterAccessesForwardedCount		=3D 88,
> >> +	VpControlRegisterAccessesForwardingTime		=3D 89,
> >> +	VpIoInstructionsForwardedCount			=3D 90,
> >> +	VpIoInstructionsForwardingTime			=3D 91,
> >> +	VpHltInstructionsForwardedCount			=3D 92,
> >> +	VpHltInstructionsForwardingTime			=3D 93,
> >> +	VpMwaitInstructionsForwardedCount		=3D 94,
> >> +	VpMwaitInstructionsForwardingTime		=3D 95,
> >> +	VpCpuidInstructionsForwardedCount		=3D 96,
> >> +	VpCpuidInstructionsForwardingTime		=3D 97,
> >> +	VpMsrAccessesForwardedCount			=3D 98,
> >> +	VpMsrAccessesForwardingTime			=3D 99,
> >> +	VpOtherInterceptsForwardedCount			=3D 100,
> >> +	VpOtherInterceptsForwardingTime			=3D 101,
> >> +	VpExternalInterruptsForwardedCount		=3D 102,
> >> +	VpExternalInterruptsForwardingTime		=3D 103,
> >> +	VpPendingInterruptsForwardedCount		=3D 104,
> >> +	VpPendingInterruptsForwardingTime		=3D 105,
> >> +	VpEmulatedInstructionsForwardedCount		=3D 106,
> >> +	VpEmulatedInstructionsForwardingTime		=3D 107,
> >> +	VpDebugRegisterAccessesForwardedCount		=3D 108,
> >> +	VpDebugRegisterAccessesForwardingTime		=3D 109,
> >> +	VpPageFaultInterceptsForwardedCount		=3D 110,
> >> +	VpPageFaultInterceptsForwardingTime		=3D 111,
> >> +	VpVmclearEmulationCount				=3D 112,
> >> +	VpVmclearEmulationTime				=3D 113,
> >> +	VpVmptrldEmulationCount				=3D 114,
> >> +	VpVmptrldEmulationTime				=3D 115,
> >> +	VpVmptrstEmulationCount				=3D 116,
> >> +	VpVmptrstEmulationTime				=3D 117,
> >> +	VpVmreadEmulationCount				=3D 118,
> >> +	VpVmreadEmulationTime				=3D 119,
> >> +	VpVmwriteEmulationCount				=3D 120,
> >> +	VpVmwriteEmulationTime				=3D 121,
> >> +	VpVmxoffEmulationCount				=3D 122,
> >> +	VpVmxoffEmulationTime				=3D 123,
> >> +	VpVmxonEmulationCount				=3D 124,
> >> +	VpVmxonEmulationTime				=3D 125,
> >> +	VpNestedVMEntriesCount				=3D 126,
> >> +	VpNestedVMEntriesTime				=3D 127,
> >> +	VpNestedSLATSoftPageFaultsCount			=3D 128,
> >> +	VpNestedSLATSoftPageFaultsTime			=3D 129,
> >> +	VpNestedSLATHardPageFaultsCount			=3D 130,
> >> +	VpNestedSLATHardPageFaultsTime			=3D 131,
> >> +	VpInvEptAllContextEmulationCount		=3D 132,
> >> +	VpInvEptAllContextEmulationTime			=3D 133,
> >> +	VpInvEptSingleContextEmulationCount		=3D 134,
> >> +	VpInvEptSingleContextEmulationTime		=3D 135,
> >> +	VpInvVpidAllContextEmulationCount		=3D 136,
> >> +	VpInvVpidAllContextEmulationTime		=3D 137,
> >> +	VpInvVpidSingleContextEmulationCount		=3D 138,
> >> +	VpInvVpidSingleContextEmulationTime		=3D 139,
> >> +	VpInvVpidSingleAddressEmulationCount		=3D 140,
> >> +	VpInvVpidSingleAddressEmulationTime		=3D 141,
> >> +	VpNestedTlbPageTableReclamations		=3D 142,
> >> +	VpNestedTlbPageTableEvictions			=3D 143,
> >> +	VpFlushGuestPhysicalAddressSpaceHypercalls	=3D 144,
> >> +	VpFlushGuestPhysicalAddressListHypercalls	=3D 145,
> >> +	VpPostedInterruptNotifications			=3D 146,
> >> +	VpPostedInterruptScans				=3D 147,
> >> +	VpTotalCoreRunTime				=3D 148,
> >> +	VpMaximumRunTime				=3D 149,
> >> +	VpHwpRequestContextSwitches			=3D 150,
> >> +	VpWaitingForCpuTimeBucket0			=3D 151,
> >> +	VpWaitingForCpuTimeBucket1			=3D 152,
> >> +	VpWaitingForCpuTimeBucket2			=3D 153,
> >> +	VpWaitingForCpuTimeBucket3			=3D 154,
> >> +	VpWaitingForCpuTimeBucket4			=3D 155,
> >> +	VpWaitingForCpuTimeBucket5			=3D 156,
> >> +	VpWaitingForCpuTimeBucket6			=3D 157,
> >> +	VpVmloadEmulationCount				=3D 158,
> >> +	VpVmloadEmulationTime				=3D 159,
> >> +	VpVmsaveEmulationCount				=3D 160,
> >> +	VpVmsaveEmulationTime				=3D 161,
> >> +	VpGifInstructionEmulationCount			=3D 162,
> >> +	VpGifInstructionEmulationTime			=3D 163,
> >> +	VpEmulatedErrataSvmInstructions			=3D 164,
> >> +	VpPlaceholder1					=3D 165,
> >> +	VpPlaceholder2					=3D 166,
> >> +	VpPlaceholder3					=3D 167,
> >> +	VpPlaceholder4					=3D 168,
> >> +	VpPlaceholder5					=3D 169,
> >> +	VpPlaceholder6					=3D 170,
> >> +	VpPlaceholder7					=3D 171,
> >> +	VpPlaceholder8					=3D 172,
> >> +	VpPlaceholder9					=3D 173,
> >> +	VpPlaceholder10					=3D 174,
> >> +	VpSchedulingPriority				=3D 175,
> >> +	VpRdpmcInstructionsCount			=3D 176,
> >> +	VpRdpmcInstructionsTime				=3D 177,
> >> +	VpPerfmonPmuMsrAccessesCount			=3D 178,
> >> +	VpPerfmonLbrMsrAccessesCount			=3D 179,
> >> +	VpPerfmonIptMsrAccessesCount			=3D 180,
> >> +	VpPerfmonInterruptCount				=3D 181,
> >> +	VpVtl1DispatchCount				=3D 182,
> >> +	VpVtl2DispatchCount				=3D 183,
> >> +	VpVtl2DispatchBucket0				=3D 184,
> >> +	VpVtl2DispatchBucket1				=3D 185,
> >> +	VpVtl2DispatchBucket2				=3D 186,
> >> +	VpVtl2DispatchBucket3				=3D 187,
> >> +	VpVtl2DispatchBucket4				=3D 188,
> >> +	VpVtl2DispatchBucket5				=3D 189,
> >> +	VpVtl2DispatchBucket6				=3D 190,
> >> +	VpVtl1RunTime					=3D 191,
> >> +	VpVtl2RunTime					=3D 192,
> >> +	VpIommuHypercalls				=3D 193,
> >> +	VpCpuGroupHypercalls				=3D 194,
> >> +	VpVsmHypercalls					=3D 195,
> >> +	VpEventLogHypercalls				=3D 196,
> >> +	VpDeviceDomainHypercalls			=3D 197,
> >> +	VpDepositHypercalls				=3D 198,
> >> +	VpSvmHypercalls					=3D 199,
> >> +	VpBusLockAcquisitionCount			=3D 200,
> >> +	VpLoadAvg					=3D 201,
> >> +	VpRootDispatchThreadBlocked			=3D 202,
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	VpSysRegAccessesCount				=3D 9,
> >> +	VpSysRegAccessesTime				=3D 10,
> >> +	VpSmcInstructionsCount				=3D 11,
> >> +	VpSmcInstructionsTime				=3D 12,
> >> +	VpOtherInterceptsCount				=3D 13,
> >> +	VpOtherInterceptsTime				=3D 14,
> >> +	VpExternalInterruptsCount			=3D 15,
> >> +	VpExternalInterruptsTime			=3D 16,
> >> +	VpPendingInterruptsCount			=3D 17,
> >> +	VpPendingInterruptsTime				=3D 18,
> >> +	VpGuestPageTableMaps				=3D 19,
> >> +	VpLargePageTlbFills				=3D 20,
> >> +	VpSmallPageTlbFills				=3D 21,
> >> +	VpReflectedGuestPageFaults			=3D 22,
> >> +	VpMemoryInterceptMessages			=3D 23,
> >> +	VpOtherMessages					=3D 24,
> >> +	VpLogicalProcessorMigrations			=3D 25,
> >> +	VpAddressDomainFlushes				=3D 26,
> >> +	VpAddressSpaceFlushes				=3D 27,
> >> +	VpSyntheticInterrupts				=3D 28,
> >> +	VpVirtualInterrupts				=3D 29,
> >> +	VpApicSelfIpisSent				=3D 30,
> >> +	VpGpaSpaceHypercalls				=3D 31,
> >> +	VpLogicalProcessorHypercalls			=3D 32,
> >> +	VpLongSpinWaitHypercalls			=3D 33,
> >> +	VpOtherHypercalls				=3D 34,
> >> +	VpSyntheticInterruptHypercalls			=3D 35,
> >> +	VpVirtualInterruptHypercalls			=3D 36,
> >> +	VpVirtualMmuHypercalls				=3D 37,
> >> +	VpVirtualProcessorHypercalls			=3D 38,
> >> +	VpHardwareInterrupts				=3D 39,
> >> +	VpNestedPageFaultInterceptsCount		=3D 40,
> >> +	VpNestedPageFaultInterceptsTime			=3D 41,
> >> +	VpLogicalProcessorDispatches			=3D 42,
> >> +	VpWaitingForCpuTime				=3D 43,
> >> +	VpExtendedHypercalls				=3D 44,
> >> +	VpExtendedHypercallInterceptMessages		=3D 45,
> >> +	VpMbecNestedPageTableSwitches			=3D 46,
> >> +	VpOtherReflectedGuestExceptions			=3D 47,
> >> +	VpGlobalIoTlbFlushes				=3D 48,
> >> +	VpGlobalIoTlbFlushCost				=3D 49,
> >> +	VpLocalIoTlbFlushes				=3D 50,
> >> +	VpLocalIoTlbFlushCost				=3D 51,
> >> +	VpFlushGuestPhysicalAddressSpaceHypercalls	=3D 52,
> >> +	VpFlushGuestPhysicalAddressListHypercalls	=3D 53,
> >> +	VpPostedInterruptNotifications			=3D 54,
> >> +	VpPostedInterruptScans				=3D 55,
> >> +	VpTotalCoreRunTime				=3D 56,
> >> +	VpMaximumRunTime				=3D 57,
> >> +	VpWaitingForCpuTimeBucket0			=3D 58,
> >> +	VpWaitingForCpuTimeBucket1			=3D 59,
> >> +	VpWaitingForCpuTimeBucket2			=3D 60,
> >> +	VpWaitingForCpuTimeBucket3			=3D 61,
> >> +	VpWaitingForCpuTimeBucket4			=3D 62,
> >> +	VpWaitingForCpuTimeBucket5			=3D 63,
> >> +	VpWaitingForCpuTimeBucket6			=3D 64,
> >> +	VpHwpRequestContextSwitches			=3D 65,
> >> +	VpPlaceholder2					=3D 66,
> >> +	VpPlaceholder3					=3D 67,
> >> +	VpPlaceholder4					=3D 68,
> >> +	VpPlaceholder5					=3D 69,
> >> +	VpPlaceholder6					=3D 70,
> >> +	VpPlaceholder7					=3D 71,
> >> +	VpPlaceholder8					=3D 72,
> >> +	VpContentionTime				=3D 73,
> >> +	VpWakeUpTime					=3D 74,
> >> +	VpSchedulingPriority				=3D 75,
> >> +	VpVtl1DispatchCount				=3D 76,
> >> +	VpVtl2DispatchCount				=3D 77,
> >> +	VpVtl2DispatchBucket0				=3D 78,
> >> +	VpVtl2DispatchBucket1				=3D 79,
> >> +	VpVtl2DispatchBucket2				=3D 80,
> >> +	VpVtl2DispatchBucket3				=3D 81,
> >> +	VpVtl2DispatchBucket4				=3D 82,
> >> +	VpVtl2DispatchBucket5				=3D 83,
> >> +	VpVtl2DispatchBucket6				=3D 84,
> >> +	VpVtl1RunTime					=3D 85,
> >> +	VpVtl2RunTime					=3D 86,
> >> +	VpIommuHypercalls				=3D 87,
> >> +	VpCpuGroupHypercalls				=3D 88,
> >> +	VpVsmHypercalls					=3D 89,
> >> +	VpEventLogHypercalls				=3D 90,
> >> +	VpDeviceDomainHypercalls			=3D 91,
> >> +	VpDepositHypercalls				=3D 92,
> >> +	VpSvmHypercalls					=3D 93,
> >> +	VpLoadAvg					=3D 94,
> >> +	VpRootDispatchThreadBlocked			=3D 95,
> >> +#endif
> >> +	VpStatsMaxCounter
> >> +};
> >> +
> >> +enum hv_stats_lp_counters {			/* HV_CPU_COUNTER */
> >> +	LpGlobalTime				=3D 1,
> >> +	LpTotalRunTime				=3D 2,
> >> +	LpHypervisorRunTime			=3D 3,
> >> +	LpHardwareInterrupts			=3D 4,
> >> +	LpContextSwitches			=3D 5,
> >> +	LpInterProcessorInterrupts		=3D 6,
> >> +	LpSchedulerInterrupts			=3D 7,
> >> +	LpTimerInterrupts			=3D 8,
> >> +	LpInterProcessorInterruptsSent		=3D 9,
> >> +	LpProcessorHalts			=3D 10,
> >> +	LpMonitorTransitionCost			=3D 11,
> >> +	LpContextSwitchTime			=3D 12,
> >> +	LpC1TransitionsCount			=3D 13,
> >> +	LpC1RunTime				=3D 14,
> >> +	LpC2TransitionsCount			=3D 15,
> >> +	LpC2RunTime				=3D 16,
> >> +	LpC3TransitionsCount			=3D 17,
> >> +	LpC3RunTime				=3D 18,
> >> +	LpRootVpIndex				=3D 19,
> >> +	LpIdleSequenceNumber			=3D 20,
> >> +	LpGlobalTscCount			=3D 21,
> >> +	LpActiveTscCount			=3D 22,
> >> +	LpIdleAccumulation			=3D 23,
> >> +	LpReferenceCycleCount0			=3D 24,
> >> +	LpActualCycleCount0			=3D 25,
> >> +	LpReferenceCycleCount1			=3D 26,
> >> +	LpActualCycleCount1			=3D 27,
> >> +	LpProximityDomainId			=3D 28,
> >> +	LpPostedInterruptNotifications		=3D 29,
> >> +	LpBranchPredictorFlushes		=3D 30,
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	LpL1DataCacheFlushes			=3D 31,
> >> +	LpImmediateL1DataCacheFlushes		=3D 32,
> >> +	LpMbFlushes				=3D 33,
> >> +	LpCounterRefreshSequenceNumber		=3D 34,
> >> +	LpCounterRefreshReferenceTime		=3D 35,
> >> +	LpIdleAccumulationSnapshot		=3D 36,
> >> +	LpActiveTscCountSnapshot		=3D 37,
> >> +	LpHwpRequestContextSwitches		=3D 38,
> >> +	LpPlaceholder1				=3D 39,
> >> +	LpPlaceholder2				=3D 40,
> >> +	LpPlaceholder3				=3D 41,
> >> +	LpPlaceholder4				=3D 42,
> >> +	LpPlaceholder5				=3D 43,
> >> +	LpPlaceholder6				=3D 44,
> >> +	LpPlaceholder7				=3D 45,
> >> +	LpPlaceholder8				=3D 46,
> >> +	LpPlaceholder9				=3D 47,
> >> +	LpPlaceholder10				=3D 48,
> >> +	LpReserveGroupId			=3D 49,
> >> +	LpRunningPriority			=3D 50,
> >> +	LpPerfmonInterruptCount			=3D 51,
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	LpCounterRefreshSequenceNumber		=3D 31,
> >> +	LpCounterRefreshReferenceTime		=3D 32,
> >> +	LpIdleAccumulationSnapshot		=3D 33,
> >> +	LpActiveTscCountSnapshot		=3D 34,
> >> +	LpHwpRequestContextSwitches		=3D 35,
> >> +	LpPlaceholder2				=3D 36,
> >> +	LpPlaceholder3				=3D 37,
> >> +	LpPlaceholder4				=3D 38,
> >> +	LpPlaceholder5				=3D 39,
> >> +	LpPlaceholder6				=3D 40,
> >> +	LpPlaceholder7				=3D 41,
> >> +	LpPlaceholder8				=3D 42,
> >> +	LpPlaceholder9				=3D 43,
> >> +	LpSchLocalRunListSize			=3D 44,
> >> +	LpReserveGroupId			=3D 45,
> >> +	LpRunningPriority			=3D 46,
> >> +#endif
> >> +	LpStatsMaxCounter
> >> +};
> >> +
> >> +/*
> >> + * Hypervisor statistics page format
> >> + */
> >> +struct hv_stats_page {
> >> +	union {
> >> +		u64 hv_cntrs[HvStatsMaxCounter];		/* Hypervisor counters
> */
> >> +		u64 pt_cntrs[PartitionStatsMaxCounter];		/* Partition
> counters */
> >> +		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> >> +		u64 lp_cntrs[LpStatsMaxCounter];		/* LP counters */
> >> +		u8 data[HV_HYP_PAGE_SIZE];
> >> +	};
> >> +} __packed;
> >> +
> >>  /* Bits for dirty mask of hv_vp_register_page */
> >>  #define HV_X64_REGISTER_CLASS_GENERAL	0
> >>  #define HV_X64_REGISTER_CLASS_IP	1
> >> --
> >> 2.34.1


