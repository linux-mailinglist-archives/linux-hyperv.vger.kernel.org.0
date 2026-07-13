Return-Path: <linux-hyperv+bounces-11965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tePxIsEiVWp7kQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11965-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 19:39:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC7874E156
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 19:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=CYaXFDnP;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11965-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11965-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8873021708
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6B34B1AD;
	Mon, 13 Jul 2026 17:37:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010036.outbound.protection.outlook.com [52.103.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E51349CDC;
	Mon, 13 Jul 2026 17:37:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964276; cv=fail; b=QPhAxbxKbbwNQQ5f8kipkZhIPgN2CFaqKkB9Ljf/7PmE4Zkc1npiRojGTAycXsTD8KZWCYQTUny2hNYnMCvWa9VD5MT7QsDlNcQBp+m3vU+hABAEDZNi357aO+yV6QvPm8cMa1M9PrejgKh8y0IOtMo5De0RP+fpWQPJqUWPiC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964276; c=relaxed/simple;
	bh=VnKzvYCyXXkAWm9b/OjwjYm63qk0Q65V7c2n/7SeJDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RITECWpW/q+Sw4vCJzB1NvaUc5our+ZIRkaX2jmNy6JhllZtlNLIMjfinmpdEwhgvsb4L3BTx1PUWeDN0gdpXHhFMx06uvCisskcdUWwpzah0fspfi4X6h1Pe7xLT0zNQTJT5sFO45ihqk0ptQkIC3MWLkrgX4TpMjPRfg/Fc2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CYaXFDnP; arc=fail smtp.client-ip=52.103.10.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGDxG7knbhY1OJTQb/Kd5T1PEyahcwK+kny1gkcFTbTsskM6GJxa5HECpB9UxbBDkrvyRe8yRMIYVu1LaZl76UEd1tTWyEEC5mQF7VPWWFtRC1MPkbYzp7Mw/zv4VeyxckYqADhn7MWK06h9bysOlUMRXbW/cqi3TzwCp9BUCLRAupfD1LsGn7Q/xQBgNZJtiWzBwwb73+0WaRWA7au2SVNPytseFLDLQSUHCGDM3nCYd0ROO5QFGHUTrzTV9NponJx/gnAXOc8AxCe4ZY2y+X9QCUeQGMju6TEDP7igqw09g5fpxoZtBLwe1dKxsJjDfT74bKgxKzXaFrqgbufZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkm0UTQBw8bDw5wqo8OQrDLCTSN1xFr0G0kLArLdDR8=;
 b=BrW9zxW93mPEL8LtWzaSLkIFnVrexvonTT8o0dNEqm8b+gqYFNpX02L6TiMpfBxseYoTwIsr+WPnGttPXe31wPQsIbkxy1j6/uqgIucC97powg6TKBExzv10LzI43zz43aungySKcARDaV4XzX2LqVThgzdt56mZO8IfA8KJ2pgl7H4E3m6v0uZvZZE7EzG4wKAz4Y9JvFnmTbCA7zLPcHe8cI3wvK7mGmLc9DVhrB6mLoavBNe89fBzpPxSK7MEm7bxXajeGC0rp5QZmyKqE1bxiK5pLLRpiSK3T6TF/a/kqZLu7YLrOY2FySLNoxAf9uyVUYL3qq3BXyHbNPL+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkm0UTQBw8bDw5wqo8OQrDLCTSN1xFr0G0kLArLdDR8=;
 b=CYaXFDnPHfkPpri+j+LWXKqGyjvX7MVVnF27q67lc7lAxn5GNaFTvsZJP9UYR4zhIDu/VIqDxxfCc7PYSLpta4YAqPPLkkBjfFJGcxkUp+14mmAVt1ovL976Ylo99a6Ez9T9brN6d8I1Aet0gBlfmXCA3nyZMU0y3D7573+/rC1hb1B43HNijcCuoY/E0Rr59tIUdUcW9oNQwDc0BnfIDkw0ZBbTVW365vib0N82kPPclOipJjAZO4voDRC7WMyNzl0EqVsGIaeKmDT/5xPChaVOzpL6SmeVap6nIc0uX0p9sei6f3MODV5o5kgoFcMZO/QE/XoMSbT3cU2mH/a8uA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9758.namprd02.prod.outlook.com (2603:10b6:806:373::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:37:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:37:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHdCjyk3FoDd2PvoEaR3JQ0We2DX7ZlmCnQgADQU4CAAknxcIADB1oAgAAOZJA=
Date: Mon, 13 Jul 2026 17:37:51 +0000
Message-ID:
 <SN6PR02MB41575E067DFEBEACF316CD35D4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
 <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3ty6yq6oftsvq52skrngjv5xpyixhsyfo3dndhoujt7emxsb2o@y6ischifpmfn>
In-Reply-To: <3ty6yq6oftsvq52skrngjv5xpyixhsyfo3dndhoujt7emxsb2o@y6ischifpmfn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9758:EE_
x-ms-office365-filtering-correlation-id: 331d68f2-8330-4403-c9be-08dee10576c0
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|37011999003|24021099003|51005399006|15080799012|13091999003|8060799015|19110799012|8062599012|31061999003|12091999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kj/Qf861LN+zQB3HyRGM3oR3LzUqDTXWoAFnz8MCGdXVaYwQs5TGu4akYmXM?=
 =?us-ascii?Q?eJIivpKkj8yewZbwVvW5h6D56SikfH/35vzEp3RQVaVZXGejZUi7wxl9AK/u?=
 =?us-ascii?Q?ovhJWiaZ3rK1QW2ccBGZvVaHmcfL7K/GADyUG89so0qoCKpgtYVq5+KM4/ef?=
 =?us-ascii?Q?Ldeb3+TdkeGNg/GT9tCzPky7yqSvZT/EpmMKGuoK7M+2G63OHpKslAxFHsf6?=
 =?us-ascii?Q?WXz0tIb978fTiEW7GTDn2WxVjYtOgFiqrZR0lVSwMs3sHQdnGLmi5me9ioTd?=
 =?us-ascii?Q?71uoIkWFKzhVvlbWzhs21/I6q/MxsNLGUzfw44USxz6nYr/GMPL2cw+VmH0L?=
 =?us-ascii?Q?ihvgwkcSrFul/6W7EwkI9zi7Ox8Cfa7guHYE6IO1MOayluzspJQBUURz+yCn?=
 =?us-ascii?Q?uwy7Ovfpj60n65habH2n0JknLG5kUbV5QOvuIMAuejeBVLOetqHv+tdXnZdF?=
 =?us-ascii?Q?YczCUwv/NDdXB6F/uXiaEFsL9fXzdYM+0hDeR8VuL7hUy2gMkJDuMssgQfxa?=
 =?us-ascii?Q?tazvXk8vCGS4qt0Vcp6CEGw96i4l/SNF6bcCEC+YC3xVKduKPNo6zvWAaHTt?=
 =?us-ascii?Q?Cmc7pEgDN8FUME3IU52AymOncq89vCWnunk3qyGILO7fWYZY4GoTsEBHz7En?=
 =?us-ascii?Q?L/NGv44rkYZ64Uvw1qMFnqpgIUiCevJW4b7RzKhJ46OcKpCQXPScBe9d9Cnx?=
 =?us-ascii?Q?17M6OAwfmqAg6qDN8Qdmh+jOF4BhgL77DYPAvSkdOIDWd+szh4Y8q1IlmPfc?=
 =?us-ascii?Q?qTKgOndbrOnn79p01AsX/maeWxTr5TNvff1n28GiISbotgqGFv/uFOtpudrr?=
 =?us-ascii?Q?YsC/NAh79a89ZCM2vRTyJuntnlSqsV+WSw/9MoWtNcvsTE/8DTgg8tJsXor/?=
 =?us-ascii?Q?m79pF97xTzUp9NONntWEiC/pmKWaqnr13t26Z6CUvIx4+OJgCbh7S0YmnEsJ?=
 =?us-ascii?Q?ZnnURli0nYJeza83o0CG195n57EeJZhMeNvJDq9MWqvZo9rV+HO2cMMzK4OD?=
 =?us-ascii?Q?m1FalHmUqqk/mNHXLJaUBc08owHs+OJK8ZeNGbLJ6S7Ge80=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ccYszQ+u9cY54G2ptaXD2rPdhYpd/TJthMNmsNEbclegOPY2RFvNyGcLy1U4?=
 =?us-ascii?Q?ivOk4/eAVq3XSL2L3ExU1LzoByoLfe4wB0G6fGsdo9AJBbmXU2n3UQC/jCn2?=
 =?us-ascii?Q?bGRQKfW9CzMdAfSemV+n7wt9S9ZgzQKuaUyRUg+k1PNgkEf+tLj0dhZys+Y4?=
 =?us-ascii?Q?dl7z0Rp94rV9NAEngWwaI2g6Pn4N/Yn5V5aDAG3YqbcEVn6QF2bHaVR+tB/7?=
 =?us-ascii?Q?lO+TrUZitE18pOhk3KIZEIrxU2x/ZoDqEZLS20Lia6/p1MtjA5El+8vAPJZZ?=
 =?us-ascii?Q?9JZx91tYZQwagM0Mk6z2EYc6L3Gstz9HkYsYv7wgdeA2lIwZRlDS4hSw1aHm?=
 =?us-ascii?Q?2dZe/E6muKEKq9zOqRNPh0JUDw8FXzRhn6fh76ZHoeMgYInGm5Qa4mai/Fu9?=
 =?us-ascii?Q?vjmVx3g6nSGvDSUuRdac7VD7RvcxcNN/eX30738/oEmblWhWDtKDBQ+85BVf?=
 =?us-ascii?Q?ha4KrUaQln6o8Oa/W+Uc7UPFU7gy2eiAGUQ7bupow7qR8OAD5Vb9ak7PvzPV?=
 =?us-ascii?Q?DLmlq95MRa07TcTtP+jbmrlw2k40KpihNvc7Tt0iCEMiD2fgm7gjMhj9aeuk?=
 =?us-ascii?Q?Hk+C4nvTo6y3BTyURgNhU0XQjUkixFPjTcbepax1QWX9dz2RFUPXAMc54JPk?=
 =?us-ascii?Q?/6pyjgawLImtH920REd43s1tMDkGIP6F9WO//7r+WNLynYCxM8BMYZhSjgy2?=
 =?us-ascii?Q?OjwLG7WbSPtt6fswchMEuF63+UdvUZKLSCT2wGT+iPOdvFSAze8OKj5rOTuj?=
 =?us-ascii?Q?BStIsnZ4q3eEaocd63l8QJPLPxDiBQAoqETSXLrQENpk6vZvvb+7+RScd6CA?=
 =?us-ascii?Q?UaVT0vSSXX7S3ba02SwPmY/bm4llLjhY3vZLWguVTcub8eWd5vVA/yJ9kLlM?=
 =?us-ascii?Q?mR0T1vEzVWCxNXRU9eql0cOHBupZ/FDKnWSEVimAKS1qs6NPIt78O978SUrS?=
 =?us-ascii?Q?0hBksTQ0jUaQW1rhqXRM9SXrJ4ctt8nKF23monR9tsIo+Nfk7PEECmEtcN1G?=
 =?us-ascii?Q?mWA/mJhaJvpjZGdPP0vjeJWBwyLWRVY3klrgAWThS5KhD6QQTitrhp063bf4?=
 =?us-ascii?Q?ugYuF5xMUaVFE9PjSO+vyZxqaCb+r/P4X3qSCmF5B5BjDUSXT7ar6EYRfZZi?=
 =?us-ascii?Q?qjGgem70GfgHf5Ht8wq5Y+jKDuajc79enJOqO6UYcG0k/bRu7TO+yOpJVSuW?=
 =?us-ascii?Q?jXO1OwqtLFG2Yvqzj5fpHFUidKyg2ieQP8pPtpANYXM+pwWOF7egaaI/J4+i?=
 =?us-ascii?Q?B6GGAX1IKMz9XYWl14KfltgvPqElNJJ8xgPeCKf8JZd0PjKI8vUEWhbVW3UG?=
 =?us-ascii?Q?MpRkSbpU1tDcy5j+qCFUshOR+ySwvgwrgxAwGAPXKt7YuoXtcOGYyspOH8/g?=
 =?us-ascii?Q?x/1x9yQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d68f2-8330-4403-c9be-08dee10576c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 17:37:51.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9758
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11965-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:from_mime,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCC7874E156

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, July 13, 2026 9=
:46 AM
>=20
> On Sat, Jul 11, 2026 at 06:31:15PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, July 10, 20=
26 12:34 AM

[snip]

> >
> > One new thought:  Have you considered the hibernate/resume
> > cycle? Does anything need to be done with the pvIOMMU to
> > make it functional again after resume? I see that the Intel and
> > AMD IOMMU drivers have suspend and resume functions. I
> > don't know enough about the Hyper-V pvIOMMU to know if it
> > might also need suspend and resume functions.
> >
>=20
> Thanks for raising this, Michael. We have not considered such support.
>=20
> My understanding is that the Intel and AMD drivers only disable the
> IOMMU translation, flush the IOTLB during the suspend and re-enable/
> reload the preserved root tables and other HW state during in the
> resueme.
>=20
> But for pvIOMMU, I guess such job shall be done by the hypervisor?
> For a device resumed on the same VM, its logical device ID should
> also remain unchanged?  And the corresponding Hyper-V domain objects,
> configuration, and device attachments shall be preserved and restored
> by hypervisor? I don't think the current Hyper-V ABI explicitly defines
> this. But maybe if we want such feature, it could be done by the
> hypervisor transparently?
>=20

I agree with your and Jacob's comments that the guest doesn't have
any responsibility for saving/restoring IOMMU hardware state, as the
Intel and AMD IOMMU drivers do.

But yes, I'm wondering about the Hyper-V domain objects and device
attachments. I doubt Hyper-V can do anything to save and restore
them. Hibernation is a Linux concept that the Hyper-V host doesn't
know anything about.

Hibernation is already complicated, and in a VM it is even worse. :-(
As a start, see Documentation/virt/hyperv/hibernation.rst, which I
wrote about 18 months ago. It provides some basics as well as outlines
the additional complexity in a Hyper-V guest VM. I'll also try to spend
some time thinking through the implications for a pvIOMMU, and let
you know if I have any more thoughts.

Michael

