Return-Path: <linux-hyperv+bounces-11887-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F9rNHrzzT2olrAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11887-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:17:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BC734DB0
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:17:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=naoh+wph;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11887-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11887-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5754330FD1C6
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03169357D0A;
	Thu,  9 Jul 2026 19:08:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012059.outbound.protection.outlook.com [52.103.2.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CF449991;
	Thu,  9 Jul 2026 19:08:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624130; cv=fail; b=XaZ9ZyKsSaeFQvmsgnm2IKZ3k36Exb6zmNi5uhcKCU5HdpQUAU6vwefKKbDW9ABnFsnagDwfP5cXmpXH+sx51NIMD3DkRe2x8gZBVcC9EuNBQXFJKcdP3fmcddj7YMWDVhv/ahOdzZ27tR6w/EfdPkBxuUYEAO/FGEE08n3drM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624130; c=relaxed/simple;
	bh=qW5Dry2QuVRbldNlOA7ru8rZO4UPHltinYF2a9THWO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nk3ecn54g+1oPKQ/owwlsjAsdBX52Tvadd7kRawZEb4ZLP2UD+/kKR5AaZZjMVhMPp3nyJoAxYHdDqqDDESsbrb/cBR7P8OpB/9i+xK0yfiZRn3n/nk1aL8qP1GI3SrLBBJrT62l3ictdV3r4Ir4E6Kh26IPzV65RLyu0A63JwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=naoh+wph; arc=fail smtp.client-ip=52.103.2.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za80asbC5NSIdfD3FFIacO0MgO/Wr7qBLZUUfEGUF2WSX78263MXDLNKMWCCK7AiFSi5/HvwLDiW2RVzLvA0s+DiUqgv0JDLfJJqF1LBZXY/uFL0SPQVDlX1R9kckqU8FdKc/5qRkNm5tEqgvpTa6VB/RNAOaVCOd4lW2hBlCkwRn0wpRHhhQOdNdYuQWbKfcvMS4nUIHNpk6mtUMA9bs8Cvs0PBZ+9pUPFG2LFk20hk/gtXumn+Ar/g4qmg+xymzNSXdT4GSos3UuOF6yOHW0adw2kcEDg++ldOOYAwTbdmTUfOPx4eAW0TCf2UFjuqln4oV7jlKw8GAm48Orz6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8mOSiJhvfQBH7mmR9C+TI/+K00LyuBPwtXohZhtgqo=;
 b=d+zW1jzp7wu3WKrZg7HSF0VnALq6grsOY/JICLv96kSIvWD7ezyaYBWK9byTlVBtPnolCuOCHfCkendg4152pKpbn6d1NU2JBX52N4tRIh+BRndXOReYTFEb5+cz5sTv/ldiMsyTu5yDjA2CbaD3tMCoe8i9u0PzznrLBDYl4TIHrbwsM85El8/HM0e3nkihMLiHTRU6YDHHXZyP869z4FbU1nlfQ1444RqXw7IS2xTF9tALuWpYgwEP/sYETEqXz4xpUihwF3FRK3kOj7oWGIgbJjNfSPamUFdOiu8TsjUVCGow8B3eY+eL80opG05tx9GXU82IyxOcvlOO78ZQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8mOSiJhvfQBH7mmR9C+TI/+K00LyuBPwtXohZhtgqo=;
 b=naoh+wphc98ykz8V20N9yzB3bW1AuAZlOyxgXTt6+U6VC91WRuLTfh1XEXyjBLfHANzedUoo/+IG4O5/0f2W9bLBHTMc+AAGB9NwwTn+gPHmzcpyIXk3GVt6o9hDw+jmReXnYJ3jmMpJA50UKdJ4S0MgvOsVz6qMc00UBRsVUfzGXOTvuVpuAtrKOVR7FUlfUoRuUY66BcOtTjzfresFe9pzGzopmQY9H18Ni3EzNuXRa63+I7TeOmC2lSyrJtLkJquCjpTbU077l09ygiteQXCi6c3jUm1UU7znqlD+Dd0jGiAaizZT5etPBhazm8fLkcZPI1FhApqk2aIi8qRMQw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6905.namprd02.prod.outlook.com (2603:10b6:5:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 19:08:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 19:08:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHdCjymkcgjkjrpdUyYQ1Fm2oFqarZlmEJw
Date: Thu, 9 Jul 2026 19:08:47 +0000
Message-ID:
 <SN6PR02MB415780D9D86B04EA1AE1B2BBD4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6905:EE_
x-ms-office365-filtering-correlation-id: def0f78a-60b0-4694-1e87-08dedded8119
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8062599012|8060799015|51005399006|31061999003|19101099003|16051099003|25010399006|37011999003|15080799012|40105399003|12091999003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EqsJjSCmJEBrj21XBAJLjM+nZTUerl5mw2EBIxtUIHFGqMiU3LsxzvMoqKP5?=
 =?us-ascii?Q?3lLKOj+Iwnoo1y91efnP9QOC2N+0Uak/q7O+NqvyCaGWwisLpIUeelBjWghW?=
 =?us-ascii?Q?ezqCKOSBXpIXwLDFEM2sxU2MzE9uv1scD8da/5GtZ4tn8i/fw6Dfv+FQ40qs?=
 =?us-ascii?Q?sakVDgCQI6EXru3ze92ygVie+w9zw47n88+yKvBbprkDoxo9R/kh0WpXvqkS?=
 =?us-ascii?Q?pWJrWYubLPxGaF6RCxNr5R5kKydomFl9hFEuq4YvCG9N2Fo81FpjBxwzm3Up?=
 =?us-ascii?Q?6OXEmpchmKqRKU9mRVNdOWYL+owNJsnIh5yTZlFkC8ZHRl6+ysWX1RH6z47m?=
 =?us-ascii?Q?AJtw/CZFbpSK8x5Mj2JYDI39k5qEu5prYAy/3NEoAljHM+dAzSR3zNoli2KE?=
 =?us-ascii?Q?7r72C4bEsZWIgJfJNOTh2wD7/I54RH0eQjVqZmcE3F6bWfn1qOpSjzOD8tAi?=
 =?us-ascii?Q?iV1BxVTpgbdDLq1FgFrXBbIEJC2QangMsiKOzJAy4qfhyn6XfOeNwBqJHfwF?=
 =?us-ascii?Q?lGMvi/M+N8Ikte6EcsYW0A634DEGch3xXwmi7x/GHLTRW5+cRn7sVXRO1jZc?=
 =?us-ascii?Q?1hoyS7K1R9Al4gCxmdrrvrWX7x+cfa3dAeaQGOiaOBodloD67xT9tU2rb2OB?=
 =?us-ascii?Q?9bZw2qwvfehMMf5t1F38ATTgKGq0HiPwXgQfOEFdAvd3cUAMt+XK8S/tAX5m?=
 =?us-ascii?Q?TURIw6n+sXQROE+V0ZT2eHJG+9mxm9tE0hDyzAvDFtE77MD+g3G/MTfHN4eJ?=
 =?us-ascii?Q?qQKvXJ71G68uZ0+XNG/JTJ0MLG7yE6USZcBMn0HvKS55eA82hztdVuCMPgG/?=
 =?us-ascii?Q?O6fBxioZ9RPaFS1D4LM9olw0KkUiydPuAAwX5+Qjp1xzlJVSKeNV7zn+gcpj?=
 =?us-ascii?Q?kx30bU6VLX2zFAkHLCbWknah7SZSIwkkNAtxPIHOxTjcLUOE3XJLqI2Pa5+m?=
 =?us-ascii?Q?2LC8f90GTxE8zzEIJN6jZ2O5lzUlN2dxQgmJX625k6R/LiXflyVXS6Qd5Vcz?=
 =?us-ascii?Q?M8mMgHLvEIEOCB90yPR2CSlA7soaET9pz6hO+Me1AzXwedtPigS60WbVewu8?=
 =?us-ascii?Q?JRZ93bUJFSsBTf9N1YkuJtS59D+uqLEd1eXPSBBWZp1kYmS/CZ4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OALv/0laQSG8Zt6AY0YIFGGHsMsL4ieID4x7hkVSaj9juTGtGQK03HYxwSx9?=
 =?us-ascii?Q?gThsBNn1vNjRmVyGHATL9cn/KVgGvFSgN49T/bvLG0v1cojSgcD7Zk8dYBlM?=
 =?us-ascii?Q?0Z2FAMh2Z9gtcQ7792EBVZDApw+ilDGR0wIfjllVerugwgiD8rkXh87TkC/0?=
 =?us-ascii?Q?Yl15ul9d58ZXnKgx5uhIpcd9ygSDZDvOGytOREppu0laQubNZwoo9qX6DfqS?=
 =?us-ascii?Q?e9sO9jsxTKKdGQ/O0OWw9m2ejvpLNDrylCBszoVldIiK9s+OkvlPHbIkLH+M?=
 =?us-ascii?Q?F6AXQb/2ppQ+mhvgQItGFgwUvYbjeLQ4LuU0NR9lRpydn9iT4OCfVheR+Hdy?=
 =?us-ascii?Q?LPz3IN+Oa5Y34H5kCYSiDkM/267QUFu5AEaMNuZVa/Pj4TO6B0KZ8sky4b62?=
 =?us-ascii?Q?y7Bod2gza7KO4d2vXN21O7rrN9B085L4JUjTb1Zu47s9DP1HdUVzIpiLtpy7?=
 =?us-ascii?Q?7hzxRmn8K/kKK7LxWhLzac2Rl2WsVdh7b1/OlirDTn1wxw7wyFCtUe4FIlXm?=
 =?us-ascii?Q?lJM7xVKjwd84ux72wC7bC9UQEE+XgAk/pua0pcdJkAtBeLshrb+3To7HBH5u?=
 =?us-ascii?Q?5V8469vYBNO4HZWVEG+AIwqvBm1FMDClJksl0micuEjP3MetZbfwxo99zrOm?=
 =?us-ascii?Q?Y2LE8NBq7ln4jnzVu1CpqnXeCC+tzpQxBqcwbRDAAjfQgGx8zDGAs8IgNrbc?=
 =?us-ascii?Q?KW+LE8jKzEURh74x+h4M2NUhnzb+hBdOFmAlelhsjOQ4lyuHSVElet1JA783?=
 =?us-ascii?Q?rlLKrD8HMFF2IhPQn5Jj/i2CkLCzytste8MON7mC4B/MwHuDMSHL08Npyiyv?=
 =?us-ascii?Q?F157cq84VMAoaMiwwxNShTPDy027Rog35gxJ0931rnfih5ekslhHdUVgNrgd?=
 =?us-ascii?Q?BYbTtQ+V8pjnNvVEtEdwwkCsc8jH4iji4Jnxe1nWU/MJzp+cqa7Sx77bnE2/?=
 =?us-ascii?Q?2/Z2eO4B0iv2pcKTsjaIxg5oAuyw8nn+OrlsVOV+jKWRlKfYYO8V06JTWSxG?=
 =?us-ascii?Q?CQ6+UJZ9BJJu/gk9kX+lGdcsZGXhZueSfFFML9XljHpQPWTMJYyJYBsDnP8z?=
 =?us-ascii?Q?4iUinZBjWJepUFpQKJDcHrUBlXhlVB6b8CnVZSZosWioRD2dp+YTTRGUh7H2?=
 =?us-ascii?Q?WzSwDKGtN24qcr2Y0h8MKm/0WAhmwbYbOs9octAIfcykTLaZ4GnOR6uIlFXh?=
 =?us-ascii?Q?auic0FG4+CexPBl6YhS5XBH6CHlKcjM795HfZVx3OLFBpn8W8dm0ge2yygny?=
 =?us-ascii?Q?yt0mVOvIIlV6Fzrv/MRdc/2ElTy1pu5qkc52pAgBYAd8IdvIkTZO5tGhBs83?=
 =?us-ascii?Q?Q2XuMJYIhP5zG3eTQKpSmECehHBhCk6FlxHoD/Z9en+X0ncBU36urLNGHXfd?=
 =?us-ascii?Q?JhTB6K4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: def0f78a-60b0-4694-1e87-08dedded8119
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 19:08:47.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6905
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11887-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:from_mime,outlook.com:dkim,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D4BC734DB0

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 =
9:05 AM
>=20
> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/iommu/hyperv/iommu.c | 68 +++++++++++++++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h  |  1 +
>  include/hyperv/hvhdk_mini.h  | 17 +++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> index 254136946404..e9b104a322fd 100644
> --- a/drivers/iommu/hyperv/iommu.c
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
>  #define dev_fmt(fmt) pr_fmt(fmt)
>=20
> +#include <linux/hyperv.h>
>  #include <linux/iommu.h>
>  #include <linux/pci.h>
>  #include <linux/dma-map-ops.h>
> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_d=
omain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>=20
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, =
end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligne=
d.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long=
 end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn =3D HVPFN_DOWN(start);
> +	unsigned long last_pfn =3D HVPFN_UP(end + 1) - 1;
> +	unsigned long mask_shift, aligned_pfn;
> +
> +	if (start_pfn =3D=3D last_pfn) {
> +		mask_shift =3D 0;
> +	} else {
> +		/*
> +		 * Find the highest bit position where start_pfn and last_pfn
> +		 * differ.  A range aligned to one above that bit is the
> +		 * smallest power-of-two region that covers both endpoints.
> +		 */
> +		mask_shift =3D __fls(start_pfn ^ last_pfn) + 1;
> +	}
> +
> +	aligned_pfn =3D ALIGN_DOWN(start_pfn, 1UL << mask_shift);
> +	va->page_number =3D aligned_pfn;
> +	va->page_mask_shift =3D mask_shift;
> +}
> +
> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> +	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
> +				  &input->iova_list[0]);
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> +				     1, 0, input, NULL);
> +
> +	if (!hv_result_success(status)) {
> +		/* Page-selective flush failed, fall back to full flush. */

With the selective flush now simplified to just a single entry, it really
shouldn't fail, right? Doing a full flush as a fallback makes sense, but
perhaps do a WARN_ON_ONCE() first so that there's an indication that
the selective flush failed.

> +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> +
> +		memset(flush_all, 0, sizeof(*flush_all));
> +		flush_all->device_domain =3D hv_domain->device_domain;
> +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> +					flush_all, NULL);
> +		WARN(!hv_result_success(status),
> +		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also failed: %lld\n",
> +		     status);
> +	}
> +
> +	local_irq_restore(flags);
> +}
> +
>  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
>  				struct iommu_iotlb_gather *iotlb_gather)
>  {
> -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
>=20
>  	iommu_put_pages_list(&iotlb_gather->freelist);
>  }
> @@ -455,6 +520,7 @@ static struct iommu_domain *hv_iommu_domain_alloc_pag=
ing(struct device *dev)
>=20
>  	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
>  	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.common.features |=3D BIT(PT_FEAT_FLUSH_RANGE);
>  	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
>=20
>  	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KER=
NEL);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 5bdbb44da112..eaaf87171478 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -496,6 +496,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>  #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
>  #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> +#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 493608e791b4..f51d5d9467f1 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -671,4 +671,21 @@ struct hv_input_flush_device_domain {
>  	u32 reserved;
>  } __packed;
>=20
> +union hv_iommu_flush_va {
> +	u64 iova;
> +	struct {
> +		u64 page_mask_shift : 12;
> +		u64 page_number : 52;
> +	};
> +} __packed;
> +
> +
> +struct hv_input_flush_device_domain_list {
> +	struct hv_input_device_domain device_domain;
> +#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT (1 << 0)

Use BIT()?

> +	u32 flags;
> +	u32 reserved;
> +	union hv_iommu_flush_va iova_list[];
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20


