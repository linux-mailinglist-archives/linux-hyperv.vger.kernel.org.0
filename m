Return-Path: <linux-hyperv+bounces-6751-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3EB45D33
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4407F3B0124
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE631D745;
	Fri,  5 Sep 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dzBL63tk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2070.outbound.protection.outlook.com [40.92.41.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B001096F;
	Fri,  5 Sep 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087828; cv=fail; b=FVQq8ufarVtYpds9ETTPD90mbcZc3t6YOlFP2tPGvS0gbgaAzWg4BPnXmp70UA6s6nnElVCcVXc4tAsNbcAbI8Ezl/Om90INjOVfJ8oVg36XjqaGWlnxXS16koaQ/KNsjlDvPur+N37Xx/WNvMZP0oKe+unkPmV2Ovd5+SBAmvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087828; c=relaxed/simple;
	bh=fkykHvMuX8ICPUxol8t8KE3iTUAak30/b5BCqJ/kNEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YxsIhjUVYyJp7f3h9vrUYFVhbgkwI4whYxx36clV8oIWYIYS4/DFWDkfsHRFn8zaGIDXKFTA86agFz1b/P0Neu3ZCsCuzsLBOSt/OgJNzQlSqKrY+l8TuLn/fb5vuhsVe3/aCiVPBUi8w6AJVD8XE7MoMSCgRsDmS3GlL2U/wbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dzBL63tk; arc=fail smtp.client-ip=40.92.41.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRilghfCW94UV6LEFIm+61uoL3uuBTnysClPwNVfRR0n75aruFhcvuoyXI3tfTybTiJ2mpNGxLRarudv+16fLC+1U2wLTPTxWYJpfpF6zbhIrCVtFicwSuNhMla+ApEfjsVwtKj0C3ve0OUQthHeRN/IDtVreLgG4jIgZo+YL/ndgyBMwR6hB9HlSyf1WFuIL2EGO3rrn/vo7Ydb1TPCOs0QqhctOCh+UUjJAYBI6DNlxkah+ao9xMLm61FKvbOYEovRac38AdxW0OZE02/FbsIYb/APTgmz1zX27+w6VYH8edcAkau7s4LVaC4wIH4Nwx3FlIkqtP+J8/MX6YhYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkykHvMuX8ICPUxol8t8KE3iTUAak30/b5BCqJ/kNEs=;
 b=IBM6JQHQMbvZR1GkP2+LLHDCBVF74eige6rLxxGolx5v4XS1T17L2tWtSCxpJOr0MaKcKdnkaYahYhoe+ekoCfCjH/ZJrhM79P0YbJu90tFIvw9QTOcvFJgb+7cOBG/tvL4ywuvhtZ/XzKRmkMnQPuJGZ46D7YyADsdaSkiX2zEhUMr5AtT0pF7vK1gvcrZKtU7WiQ+u87IZjWoKFKTE3VySFGDp5yXcSWrBZ8VmuBy2bNwX/s1/eDlrsNVOkqioUe/L3NBXUBLSAt6m2hv6UHW0XudXwkWlGeIg3NBYS/TC2xN2QCo8P0Atb2H49faRP5J44OX8V4Bcw4maA+OKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkykHvMuX8ICPUxol8t8KE3iTUAak30/b5BCqJ/kNEs=;
 b=dzBL63tkjg/syoEPoLz9aeD29A2PiBGG6nqMff/CkJM7ylJ4CNuY1NVp7aAzmZPqu1wml8NfXPa56HrQ561GZIWzCcrdSpxNbw610DNMsI/mA/XoBquDHJVeLcqmR7rPNcwXMcqkTlhbNDExKbfhsUc9OiQWqMByO0M5DVBah5ZCDakn8yLxNHSCW0+REG05qQXfdNvp+vHw1IDZyIYki2K8fmx4/z+pZX6TC3L/ypszkOPjCHF2PsmQftbmeV3pdWA4ZChsugkHJSlTthJu65I0O60Sv9rj9XjtfZ21j/d6M87atOqKFEHO0bqCk994gQ93aZfT/ByXicDw6aRkNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8001.namprd02.prod.outlook.com (2603:10b6:208:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 15:57:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Fri, 5 Sep 2025
 15:57:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, Li Tian
	<litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Subject: RE: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Thread-Topic: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Thread-Index: AQHcF/xzlhqdNasNOEyOxxs2ytrFh7SDtHSAgACOegCAAIexIA==
Date: Fri, 5 Sep 2025 15:57:03 +0000
Message-ID:
 <SN6PR02MB4157B42CCDC571AA07A34E82D403A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828091618.884950-1-vkuznets@redhat.com>
 <aLoeQXAo5PMDA5hn@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <87frd1figp.fsf@redhat.com>
In-Reply-To: <87frd1figp.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8001:EE_
x-ms-office365-filtering-correlation-id: e6fa3c7e-9540-43a0-b6e5-08ddec94dbc2
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnoyTIwSrGph0lItVprk4CpiJMu4VojU9OU9vqvKmVULsyka+0rXyRVFmAkiGmAwc4uPYXoLVzkz0L7LdEb3rDvZ61+krDCLSeR3LWBG+Kkm4s4CFwkr7+tn4so/hn1285wZxdocpgyAO0krcYchCl/oCtx4CiEZInGwbp5d/G+dr3F3E55G2SpcqLD0M+X7m0N5nlUS+RAYwONH2Ft3NUX2dIEbi/zobqfjMwlCqPx/u0waKfEfb30mRKbiCXC2kDnW52n9zeck0iJywU3uf5w+m9VpoNjekpWM46U7w6/XqjJDUpU2XgqTmxm8VheOJqxrDYcW9K4yPRVC6v+maEEBFQrXeZufEmufX4RNvt6j+BmWpVYfSkiT2Xy0v5YYwnv69kgiF554L4U87uhico3VuSPVDe9jSYd+N2qktOzmxioziyvJXvCsF6TP1tEEbZJZnJpabv5xWw1utgIacdU98JN2ekOkKX3Y9KLC1AekMwELGX+WAYkoum7ByIz957q+RBuJDBIl6WWKktvjq9X9nigf+vMIc2k+u8+k99yuGZcE3cxqnociYfYpjuhnITpnspVTGzT4akCkYdwr0p59edWOJmCm8xLiRgTVR5lXoXf/gxeAmWeRk0p18rwsBkhkVx4Y7BKiNiAKMWw/s2PMlL0fVaJjisNxWDb6/lRY0XdpqsX2ptB2cizeUx6Yl3fIl28j8kV6tGwUH3Q90TPd1PDi+SxfemOdqEq4w6gA5NNXXVrEBQh5VMNXjCQHO2E=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|41001999006|8060799015|461199028|31061999003|19110799012|8062599012|3412199025|440099028|40105399003|102099032|51005399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RZd6Vygg/W9BpYsSs3jbrrxKRuN9188M6ww3kNVOHUwpgsMQJEBsZHnP0qAY?=
 =?us-ascii?Q?lcdDiYqmJL/2hNQw+gVZ7S5T+ATtXdTb9WEVAIJbhTJuEScLR1ZgznzxfOy3?=
 =?us-ascii?Q?LAqEMrfg2ihG5z4V+AAS64VBfMqpxr5T22643seIuflBk2nEXZdYK/zrqRx5?=
 =?us-ascii?Q?/3SRtCXu8TCsq7/R/IsV8E0kuSh/NafC3w8AvK3qkizmYJQFcc4G6vn20qvr?=
 =?us-ascii?Q?5qZzwWCrc2+Tec1ECo0MfR0WBszTUtfwGyrIIwyYeIMMne4MSblEOVAe9YKo?=
 =?us-ascii?Q?cOM/k0jT0vMgPKWblDi5A2ZFCo1+5Ed/aCCHDFXDbEw9simxYrRoVcXmoeSy?=
 =?us-ascii?Q?QRrnR5jAcDVNHsw7Coc0v+dXutpJwmKrAbinwYCEIlgtK3t5R8eIS4xKORY6?=
 =?us-ascii?Q?02AuPiQ+mNiZUiScoRWqLLCcpEQ2+MQseUV0+SpFkPOMCyaBL5nL+C8Tkvb+?=
 =?us-ascii?Q?ZSfMzY+sROlDeQQEkxuZw4yTFZnB75uJ6wc7NijHygJvkC79XWNO1qX1oz+l?=
 =?us-ascii?Q?KUdULvvEChilAJX42580T0Ag7fyWy8PZ8Zhdi8kMKoL0YWKOQ/0/vElxo74z?=
 =?us-ascii?Q?HwxuzxFZy1CLo82qQy8tDulFC/5mFAVJiQkYTqHpiKt1cqlcdX6r+uwitXsd?=
 =?us-ascii?Q?YxSwHDrW/8qTznKVkC6m0FB4TUNCLu2m7ZAELSPSYttwNXk4p83lIau0VBkC?=
 =?us-ascii?Q?jaojV0NnlmtSopC4M6akAEU93crIOUKDhPFlJFIB9CbFHTzRnHf7BHefHams?=
 =?us-ascii?Q?DQAs4ZbKCl99ZWdadRHjx+PRm+UY8WyH/O7nG7VxNab+GcLVMMKGxzOQfkPk?=
 =?us-ascii?Q?dMdSTDUnMm4QnTe0UWGZsKo9E7aA/30z9wuycpJYPLmht+zCkyKYIXqps7kz?=
 =?us-ascii?Q?WO0HkwKw1MazkHe4XnmE+/IhjvmudhrFlVtVChzgZ+3EhROPDxUXcWwQQBGn?=
 =?us-ascii?Q?MVqinmy4Nn7WVSYKtMRwH40qHtO0D3W/emOyk6KM1kZ2kWECsqReZNUTomfE?=
 =?us-ascii?Q?e9RR/3PevS03P95eO35T1idQQlK3qqpw6CL+edcIXJjkdB9e1NGszLHRiQ7T?=
 =?us-ascii?Q?NI1trC+jsy68wMonhbpSU3xuNMSJLKgBtCrOlf2DNNJQ/39KBwosVOmLVVtA?=
 =?us-ascii?Q?CSQBzU6PzdVHUYrlmsTLY/+2POSBGcVQMmtf75PD6235eOdhlk41YAbvQMtG?=
 =?us-ascii?Q?szEnokIegWjjJzqsckZErWLAp6VVUi1bg9xP7rHJKkQX5+LjcyZpBn8aKKAS?=
 =?us-ascii?Q?vMHbgQIYP9/AITHIyV61?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MPHK7Qp7X/qXpDz6uavYi4glRMGCAiLT4qkM/CcedOKG+1XHBLGi7LuFpRva?=
 =?us-ascii?Q?PYqyYXDqq6+cocyf0T4lyUOeABT5Q8oDXnF60jz57invW/axA2yZNSYgrqcs?=
 =?us-ascii?Q?brvGEoGN3k11WU9JlLNZquT/K+phYzc5A1FLeHbNSyY3wy8BSp1myrMZncaq?=
 =?us-ascii?Q?FYL7X633dmv8qaBfHrgBMfeYtEp/jszgMmXdxbezD59raCwqNkuBGHICuULQ?=
 =?us-ascii?Q?SHwkSIIgANTE7o7Vm4Vi1eOTreFxtvyAVIDr+2OvDVmEQ6+p3uocH1SqNwa4?=
 =?us-ascii?Q?N3iJIc4uulfbDC8/dgZX2W3kdjAMTwUilHSUYIyM26LBCIGZqsj+2bClXunY?=
 =?us-ascii?Q?+MQHXw3/WxMDgmtACoXMt2N+CpcCHgulL+tnNWU13xFurcpw25x95VCC4r6Q?=
 =?us-ascii?Q?3/n8pzF4DWBrrSzEHUhMVTzVWq57QTF70F1MXBNcL9N/Duu5ITRrpqDbC6yY?=
 =?us-ascii?Q?DVnukXuKx+C3kU+1sZPeghpBSMlkrD8RfvqaqhvW+QA68iRp3IOdFjSpDeVB?=
 =?us-ascii?Q?3Uct2vRmBRmVA3edVWH4nC79uUxe7QoXvW9OU+1dlV87UmtTrZ6ENVI4eINY?=
 =?us-ascii?Q?QVTnCNQYOBddHNVZyUdeYS3Ofbmhu/HC02dBJZRUDv3tc/CUwbdZB9VmZDzj?=
 =?us-ascii?Q?c87KXM7B/6JZsK5S9W0Mlo26IIgmQ3eZUhCfDW4a2zdBz9FiW1hntIxwd+lB?=
 =?us-ascii?Q?ernFdhkgXcoDKCgprn+l9ae18SpwHUjnYX9mOrEitBBXGBdhNeThZTsrdAvi?=
 =?us-ascii?Q?fwCvRAQHO6C7xspOE/pFY+vYeA8UonP4GfJBAMBVHmXDXjmoiaStwgAxAq4T?=
 =?us-ascii?Q?9iNyeQCN8TD8nVlH7rJK+8cMgzCBbGW6AceL8cYIBKF5MiBxR3u1b3sh0Qj+?=
 =?us-ascii?Q?gFLGE2pJW3p98eqECv4bB2UmmkEKvJmc0olY17sj/2MpLaV21MH207/mX6YP?=
 =?us-ascii?Q?xvRtYNB71LB4HyUlijGZqsGFrPkzxe+byD908HJr5cMB6Cj1UVh+zcvNEmLR?=
 =?us-ascii?Q?/4oRHKceKHPiQIb0r0O4vUmTYgQcfW8JM1K0g6Y1eCoRdue+ADorkPKZWfMg?=
 =?us-ascii?Q?GK0FFbGQ9Wn9P6XpQfO/bw0w/6fx/KHpFQnqy0nqkLu1N2XHTzgUiNGzlNaE?=
 =?us-ascii?Q?YafVwaQ9aFWpSMKyCxYKr73aA8/DVWncicC8ZTim1ZmmuzpXabOxKWHVHgDX?=
 =?us-ascii?Q?BJI/q6o0VtRgD2a/DlgX1ArTkt8wS10K/ZG02C5fQWvhXHCGkcyAUkZj670?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fa3c7e-9540-43a0-b6e5-08ddec94dbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 15:57:04.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8001

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, September 5, 202=
5 12:48 AM
>=20
> Wei Liu <wei.liu@kernel.org> writes:
>=20
> > On Thu, Aug 28, 2025 at 12:16:18PM +0300, Vitaly Kuznetsov wrote:
> >> Azure CVM instance types featuring a paravisor hang upon kdump. The
> >> investigation shows that makedumpfile causes a hang when it steps on a=
 page
> >> which was previously share with the host
> >> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> >> knowledge of these 'special' regions (which are Vmbus connection pages=
,
> >> GPADL buffers, ...). There are several ways to approach the issue:
> >> - Convey the knowledge about these regions to the new kernel somehow.
> >> - Unshare these regions before accessing in the new kernel (it is uncl=
ear
> >> if there's a way to query the status for a given GPA range).
> >> - Unshare these regions before jumping to the new kernel (which this p=
atch
> >> implements).
> >>
> >> To make the procedure as robust as possible, store PFN ranges of share=
d
> >> regions in a linked list instead of storing GVAs and re-using
> >> hv_vtom_set_host_visibility(). This also allows to avoid memory alloca=
tion
> >> on the kdump/kexec path.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > No fixes tag for this one?
> >
>=20
> Personally, I don't see this as a 'bug', it's rather a missing
> feature. In theory, we can add something like
>=20
> Fixes: 810a52126502 ("x86/hyperv: Add new hvcall guest address host visib=
ility
> support")
>=20
> but I'm on the fence whether this is accurate or not.
>=20
> > Should it be marked as a stable backport?
>=20
> I think it may make sense even without an explicit 'Fixes:': kdump is the
> user's last resort when it comes to kernel crashes and doubly so on
> CVMs. Pure kexec may also come handy.
>=20

I agree -- think of this as adding a feature instead of fixing a bug. Prior
to now, there hasn't been any attempt to make kexec/kdump work
for Azure CVMs.

Instead of using the word "Fix", maybe the patch "Subject:" should be
changed to "x86/hyperv: Add kexec/kdump support on Azure CVMs".

Michael

