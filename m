Return-Path: <linux-hyperv+bounces-7993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14856CAD8E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C586C3010CFE
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F032797BE;
	Mon,  8 Dec 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tkRSL/BQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012060.outbound.protection.outlook.com [52.103.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2630231A55;
	Mon,  8 Dec 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207296; cv=fail; b=f4J33cTtOip4bKwBRiyFzb3OuFsbOrfOpevD7lLLoTf4pvpV8hYzttYL4v+YyJK6+QejovY5supMRvC6vxc9BifGZHy1+f/VzQ/ZUuPK8rytt0lfIZt69C6biG7g3IANx3lpLfoRNiMLM+DDGxUVdtlyos3idtGhT+89IOwgyo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207296; c=relaxed/simple;
	bh=JHr54SrsragYAN/SOV7KjJuyn3s0jv7dM9DA9WbprpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lN3beo+OnwMHNgDHBD1AoP4ZvQJd9i/DVI0fqVB9K/GgzXIhkapRzyOo0N1sCXHX2aKMjv0ujADNrqY5XMmyGM3z8nP3/UPBptH1pALNTBX1HzjxGlSb8j2vqSSkfY1CJA+OmvwhHse/FggsNuMBf/nKPTTIt/FzbUa8pJp1emc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tkRSL/BQ; arc=fail smtp.client-ip=52.103.2.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTCHtQ+LzyqZ5IxxvIBi2xuYNoJRC+0xy+wHpiV4XfwEnTyDrlcfP7poiAaZ6YoOkfFRt3d5mgEI2lGbjF8BcOOHm63Dsp+R99a+pp0FXpWKM5h50Bc2VbewiW7VOzHTwJB7h4S3EpdUmRvOVxN9hEC+HPCOSJwRD15/wrM+sHrQLu+2yudHVzlcQwwNdQHvQQUOt+hhrC/3WSr9rGHQPgKtfsx8hHeMpFYF8+CsfNAdxOFIQ2m5TreT7SEPtO6zN79uFKlem1W9M19IrVpKU4dmg2WWztyXNXGwK465dEunZvvWnFKPnCA+wzMPeLt9V0Oh++F29SjKYZBjC43dRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHjazcJyjkbz+ILB6d2obzJDmPNgyFJs3a0JENHMmzc=;
 b=j0ZfQwf7ZDcorgjuVuVijWihBhQ4H30UvPtID3FzUOXLxRCopd/MGqUuUB3tHiXhcOf5Ryfg2SA/O/xA8WL80eA9FpA6KmFHahP7LZTEzA0vfqLEVBhkpGGYMoGxaNKqs0htKIDsCOCFLc4GtM5oKpt+E25YfwnB5sA5O9oXxfQ9oUYqycxYRJ0V83H/MQHWNjBIWdnPreHoR6djRzLrp6dxIELq0qJLVoVvBUJhcgGRU04vUTPi46XWGuhbTuuhj5lYOWdZq3FAdLE0GeIpT+AduoA4XZeym4qkI76SV/7O0pkq9ImcpugzKoU4sDUxtWCwwb1WHiBpwUft12nO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHjazcJyjkbz+ILB6d2obzJDmPNgyFJs3a0JENHMmzc=;
 b=tkRSL/BQn0/qLeCkpX8OCWjtKxzYVE73ZUunwQiMXk6EpMzRS/vd+e+nb92xpX/+Whpoz212HDhHuLsWRCDdoFwiTCq8cZdF+WZ7NDLsCuNsqCxNnVVHrJ8nTPy2IBnK+YfW5j/cyu7oOHlWXlf2aD4ckUfIcuyMle4utzaGDUktU5ro20ESYQtXVrSQ7DaSG41boh98NYFHcq+BmDsmebmkPr+xWikXKt58OgYhzHENw24UjoxGnFXvakOvVecbv17WFYIQLJSxKdpU/iD5n0hXDFp0aox0pnH4NcldNzAiA/vqmGedKwMsAO6QeizgjZcbcBbt26ug1b9Mtx7LYA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8490.namprd02.prod.outlook.com (2603:10b6:303:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:21:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:21:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>, Jinank Jain <jinankjain@microsoft.com>
Subject: RE: [PATCH v2 3/3] mshv: Add debugfs to view hypervisor statistics
Thread-Topic: [PATCH v2 3/3] mshv: Add debugfs to view hypervisor statistics
Thread-Index: AQHcZhkxXqEVkR76PkyUq1ykbhoMv7UXPKsg
Date: Mon, 8 Dec 2025 15:21:27 +0000
Message-ID:
 <SN6PR02MB4157938404BC0D12978ACD9BD4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1764961122-31679-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8490:EE_
x-ms-office365-filtering-correlation-id: f3822e9e-c678-4b0d-4054-08de366d750e
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyO+K31TYcDJnS3Nb0QmDRHVtnCESXEAigOWUWRFvGf+LS16c7KWs9tCdXyKbgn6jDFCsJ6zQ3mkXr6SJuJAcXdY7f7hnX59wgMj3SWx9c1bkReVh4GyVJyNkrv4rJKnbT4ciGPSC3VGjoR0JBFR3ZCosF+44hoBl5KPE+D7LykrOtz5MlcsupdZoxFyfRjxEQ8rmn9hZd8icrwagS0Rzm/XE/0kuSiF9ikS9420X94ViPKKJNj3N4IM/wkaRIb8ILIDxhRS0YCfrCBSw5uhyS+EneTibBXiO82BhODnOv9Ev3xSo0ZsURY5uZmy+tgc5u1GXbLNhjPto2/QXGhywCN8wSMsxYCuG8u6adSXa+HY81prgnm1zErocT/ZlYjUYsJM7uRgM9beuZ5FB54u2AwBBqIblKXyGrHairGw7rXp6OJY5NFyOdEVrTCC2SN2fZLRMiDnj0hGxck4IJY9kqBIoqBriObwhYl+zjF/ldxL8WOhbRv//PR+Q4ojnywDaYfyzHNYAcVSjwD0GY8Mi3b216mhELV8yAvVBV48iL0b6yTc9GaZxGAjkZksqDT2TA9B1BE5P91HGRsUv0ltiQSUPHHG6UTFWueMRMari7OzCYEPG/A4uUNXDhcG8qgQyGOPLp69Ug/BgYYbORio3qeDxdhMr5PRyKIN95oAmrNE2i7Wf1D6naKAOqamJGyCIDQL1WgerBTd6JfPzg3lazF1pYZoxBMJxI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8060799015|8062599012|19110799012|41001999006|13091999003|12121999013|51005399006|461199028|31061999003|56899033|40105399003|440099028|3412199025|102099032|12091999003|18061999006;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Vt13UmHl4FVA3yqDAi5AUB+Jr8vLJsku94e9XwbNvx9XFATUvQPMq6msIgP3?=
 =?us-ascii?Q?o7b4I+s9lHFZqiTzB24KqID0/TUvDYatdqXF/xwRMuC+Zo8m2T9IKZ3ra2+O?=
 =?us-ascii?Q?n9YSfHVicHoz18tmvC3QMPiCrX8yyD5hEQfPnAg1YsZhugql+ogFSCvsbd7c?=
 =?us-ascii?Q?ZUy34riHYXVHFZPGgOv4DlwvBgfOBKVRqEDYUpopNYWpjpY6BkMlJAcngegN?=
 =?us-ascii?Q?boJkAUO7eFK+m/bVxOP7GGD7W+ynRrLR2UyuZ7VC4heqYDcBBVtXN9g51wB0?=
 =?us-ascii?Q?Cg4ICpWLHxWZRykry/6fhDvjxVQ8fpCuDBY3rcg/qVPhXSzqdaE23bga4wFA?=
 =?us-ascii?Q?+77zVVsKMUHkV01rmWHW55Owzhm5/MSna5GvKqpz4990wcr5zR2c+2h9tBoL?=
 =?us-ascii?Q?AnEFvWotQQqXWBG6YSiDrUTGgMae3oOjACU+8NnZ1ioiuRPtGV2876RkcHM0?=
 =?us-ascii?Q?Ha80Md/rlP4UbVAugsmczf5hy/s8uEv0qEv/zE62N+gDZlId2pMM1eQRjaTf?=
 =?us-ascii?Q?rD+7Kln1Py8+VT3Q8vRnPwpcU8xOKfg8ceYAnfHyFS4IrrYppOpmE5BZOaxv?=
 =?us-ascii?Q?oF85vsuVQyOvkgHK789oLXS1WaeKrl087aFTyMgzXu8bP8CyF9Vwz97BE4gw?=
 =?us-ascii?Q?LQmONqeAocO43zDFl/xkhgxnGJV+hjZ2g6IsioCItS6UjGv5aj8Q7D7sCJKJ?=
 =?us-ascii?Q?f6zqb6+SRwkym111WSir41xlrOwyNdjGuTUkBjL/Ge7i1g6f6tDdG5rqkO4T?=
 =?us-ascii?Q?gbB6JlsqARsrCGm20D2STZV14nHUSPUY5JwAb0CrLXHVxoFRazGH+o+Tac+W?=
 =?us-ascii?Q?fJ8dI7j//4/5Wh51nickRb7t0ax87ipChgAWJbI88HZMkqqHGXtmIlNweziO?=
 =?us-ascii?Q?kOBcBiPRmJZFAWCZtdxb5b25gz3aAzkGSqsZg4jpIMkxyK6/s5f7IuHfSmiw?=
 =?us-ascii?Q?LHQq9GkkXDQUxD7R116FurkzSYllA9q0KGkdpqKQCtWsAsF3AtytagSGj0qd?=
 =?us-ascii?Q?rNzaFSM0oH6/v83OD/2GkO3IESoNItFCvl+aMO1ygFBuHNauEPYSo2MhqXdq?=
 =?us-ascii?Q?6MGaruf9GnLSDTQmaumAkKw/wl0t5pnBARJx71lV7zBC8iV/chemZCVtUYbc?=
 =?us-ascii?Q?o0vA06g4MS0gjPzpk7VQQB+ZRtAVOFYrza7bsw619iIq8sYwb8tTZk2i7UOz?=
 =?us-ascii?Q?VGTadXEYVhgt7R4xFpophmnaAR8gsfRI/gNIdERaGY7muhMIvq0bc1Dj1Wcm?=
 =?us-ascii?Q?B+Jdm9ZfD68uZ6DmgnPb4co1+ALJRjqifcE3SQaqKS22mFWc6mjdYS63CXkW?=
 =?us-ascii?Q?GLIjsMNbv1NsJYAqxXGqZbteSgOD7jXkZ9HJxEFFkVjzNg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qHmczy5AkL+i4nsOtD6/TFlKx2sS8ihNuxdyfe4QE4QuEWnzDURNIowNh1Ly?=
 =?us-ascii?Q?wAcV7umwWsU1lKB6VZII6lR53iRLe+/IAQjt+OuauBdkZ2FX4I0NioTHnsGe?=
 =?us-ascii?Q?5Bwo6CdtVj2cFHnipMLpmxYjaa/i7RDcL+z+jjTy8/pqal+aN7H2KuqAlkoL?=
 =?us-ascii?Q?ZR5abWVcE1AfsfoeRcVpdEnKLDuyx0OissZGkneQZg5xj5ssbKYR2SnVBDdU?=
 =?us-ascii?Q?+72lP0mmb3mO2VbHkwaObpI5ibL8s2aHP+4r3UnwZld5Fc1ZA7Bn8FywEHaJ?=
 =?us-ascii?Q?VPwE6ZNT8WVJM7wBooUCvabq++IzHoTWlp3S3ObRKHH048KtXfhX1pbBVnNK?=
 =?us-ascii?Q?NmEb4lvtLanu0i9ltLbOVPE7aue4PpYPh8CsPfwHKzF+5rnMQFeoidILEj2F?=
 =?us-ascii?Q?umzBpRc0m4fRNdPUkki9HK1O2Kk2h/Bbj7M21/I2VktErNBGrpZjAX4qdEnR?=
 =?us-ascii?Q?l0uu/02cqp6y3vajP+zhCQHM0THm7zyUuSK2rxzes6JjD1xybwIqMnpM4XKF?=
 =?us-ascii?Q?X7HAhU9i8XQfX04wyhIrgJKoXO3f78UU2lJyCyh7Yh9LhI2lTDQqj3rnnQp9?=
 =?us-ascii?Q?Axms0EtxltIHvVVMd/eAN96t1ybVtqSVYLOAs2HUV1zxmKA+392sz40CvcjR?=
 =?us-ascii?Q?3nUdXS5emD2x+a6JALjyCIclxIseaiCFbRmZ+aI6qlUNVlH5HnB2VnsClZ5I?=
 =?us-ascii?Q?duhCR+RRuMMNrT9MCGbQAUQMi1fjHEswHqBGl3IdeGIHBwgW1WXe5uDUIjay?=
 =?us-ascii?Q?sgFq7Ovj75W432v474xOVT4DFlR8tfe/uuI+txnOa0A0i/bPcG1Tg3oryLeG?=
 =?us-ascii?Q?EJXLKqtK+ogoKwfQbz7sYadrVBzaE4jUuQtNETHExCDHWP2EeLbz2C+gNBej?=
 =?us-ascii?Q?UADXg1L0HKRE3VXcWJWHYGFAOSb5QMxD7fZiLkMDwzRxcshTs/hfwjbDAZbU?=
 =?us-ascii?Q?xGEjckz3JlHJdgPP2GT62joXziXnau4yBU2me+gCvlkUh7Y87WubQmb4XECL?=
 =?us-ascii?Q?chkHIvzmpU67oVHK1s5qwGnLJr+Eeaj585PddlQt9pdyHC9L3bsGVUrqf7pQ?=
 =?us-ascii?Q?RSoBiWBZ6rVTyuQ/aXBHl2j8R3bwJIN0nwwIRsrBvObk+PgwLqgka2TR1N2U?=
 =?us-ascii?Q?LnWL8Rl1RmgMmxiO7iSFgAzEbNxbVnuN1DeQ6nZMUeVKIyaJRZrZSnDAtHdm?=
 =?us-ascii?Q?goOSBKPYWrVRaAER/9Wj5dM3oHkWcDX4xxMOjXKCztZxoTDHaBLasei/zBg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3822e9e-c678-4b0d-4054-08de366d750e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 15:21:27.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Decem=
ber 5, 2025 10:59 AM
>=20
> Introduce a debugfs interface to expose root and child partition stats
> when running with mshv_root.
>=20
> Create a debugfs directory "mshv" containing 'stats' files organized by
> type and id. A stats file contains a number of counters depending on
> its type. e.g. an excerpt from a VP stats file:
>=20
> TotalRunTime                  : 1997602722
> HypervisorRunTime             : 649671371
> RemoteNodeRunTime             : 0
> NormalizedRunTime             : 1997602721
> IdealCpu                      : 0
> HypercallsCount               : 1708169
> HypercallsTime                : 111914774
> PageInvalidationsCount        : 0
> PageInvalidationsTime         : 0
>=20
> On a root partition with some active child partitions, the entire
> directory structure may look like:
>=20
> mshv/
>   stats             # hypervisor stats
>   lp/               # logical processors
>     0/              # LP id
>       stats         # LP 0 stats
>     1/
>     2/
>     3/
>   partition/        # partition stats
>     1/              # root partition id
>       stats         # root partition stats
>       vp/           # root virtual processors
>         0/          # root VP id
>           stats     # root VP 0 stats
>         1/
>         2/
>         3/
>     42/             # child partition id
>       stats         # child partition stats
>       vp/           # child VPs
>         0/          # child VP id
>           stats     # child VP 0 stats
>         1/
>     43/
>     55/
>=20

In the above directory tree, each of the "stats" files is in a directory
by itself, where the directory name is the number of whatever
entity the stats are for (lp, partition, or vp). Do you expect there to
be other files parallel to "stats" that will be added later? Otherwise
you could collapse one directory level. The "best" directory structure
is somewhat a matter of taste and judgment, so there's not a "right"
answer. I don't object if your preference is to keep the numbered
directories, even if they are likely to never contain more than the
"stats" file.

> On L1VH, some stats are not present as it does not own the hardware
> like the root partition does:
> - The hypervisor and lp stats are not present
> - L1VH's partition directory is named "self" because it can't get its
>   own id
> - Some of L1VH's partition and VP stats fields are not populated, because
>   it can't map its own HV_STATS_AREA_PARENT page.
>=20
> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Co-developed-by: Purna Pavan Chandra Aekkaladevi
> <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Makefile         |    1 +
>  drivers/hv/mshv_debugfs.c   | 1122 +++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h      |   34 ++
>  drivers/hv/mshv_root_main.c |   32 +-
>  4 files changed, 1185 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/hv/mshv_debugfs.c
>=20
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 58b8d07639f3..36278c936914 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y :=3D mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o=
 \
>  	       mshv_root_hv_call.o mshv_portid_table.o
> +mshv_root-$(CONFIG_DEBUG_FS) +=3D mshv_debugfs.o
>  mshv_vtl-y :=3D mshv_vtl_main.o
>=20
>  # Code that must be built-in
> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> new file mode 100644
> index 000000000000..581018690a27
> --- /dev/null
> +++ b/drivers/hv/mshv_debugfs.c
> @@ -0,0 +1,1122 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * The /sys/kernel/debug/mshv directory contents.
> + * Contains various statistics data, provided by the hypervisor.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/stringify.h>
> +#include <asm/mshyperv.h>
> +#include <linux/slab.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +#define U32_BUF_SZ 11
> +#define U64_BUF_SZ 21
> +
> +static struct dentry *mshv_debugfs;
> +static struct dentry *mshv_debugfs_partition;
> +static struct dentry *mshv_debugfs_lp;
> +
> +static u64 mshv_lps_count;
> +
> +static bool is_l1vh_parent(u64 partition_id)
> +{
> +	return hv_l1vh_partition() && (partition_id =3D=3D HV_PARTITION_ID_SELF=
);
> +}
> +
> +static int lp_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page *stats =3D m->private;
> +
> +#define LP_SEQ_PRINTF(cnt)		\
> +	seq_printf(m, "%-29s: %llu\n", __stringify(cnt), stats->lp_cntrs[Lp##cn=
t])
> +
> +	LP_SEQ_PRINTF(GlobalTime);
> +	LP_SEQ_PRINTF(TotalRunTime);
> +	LP_SEQ_PRINTF(HypervisorRunTime);
> +	LP_SEQ_PRINTF(HardwareInterrupts);
> +	LP_SEQ_PRINTF(ContextSwitches);
> +	LP_SEQ_PRINTF(InterProcessorInterrupts);
> +	LP_SEQ_PRINTF(SchedulerInterrupts);
> +	LP_SEQ_PRINTF(TimerInterrupts);
> +	LP_SEQ_PRINTF(InterProcessorInterruptsSent);
> +	LP_SEQ_PRINTF(ProcessorHalts);
> +	LP_SEQ_PRINTF(MonitorTransitionCost);
> +	LP_SEQ_PRINTF(ContextSwitchTime);
> +	LP_SEQ_PRINTF(C1TransitionsCount);
> +	LP_SEQ_PRINTF(C1RunTime);
> +	LP_SEQ_PRINTF(C2TransitionsCount);
> +	LP_SEQ_PRINTF(C2RunTime);
> +	LP_SEQ_PRINTF(C3TransitionsCount);
> +	LP_SEQ_PRINTF(C3RunTime);
> +	LP_SEQ_PRINTF(RootVpIndex);
> +	LP_SEQ_PRINTF(IdleSequenceNumber);
> +	LP_SEQ_PRINTF(GlobalTscCount);
> +	LP_SEQ_PRINTF(ActiveTscCount);
> +	LP_SEQ_PRINTF(IdleAccumulation);
> +	LP_SEQ_PRINTF(ReferenceCycleCount0);
> +	LP_SEQ_PRINTF(ActualCycleCount0);
> +	LP_SEQ_PRINTF(ReferenceCycleCount1);
> +	LP_SEQ_PRINTF(ActualCycleCount1);
> +	LP_SEQ_PRINTF(ProximityDomainId);
> +	LP_SEQ_PRINTF(PostedInterruptNotifications);
> +	LP_SEQ_PRINTF(BranchPredictorFlushes);
> +#if IS_ENABLED(CONFIG_X86_64)
> +	LP_SEQ_PRINTF(L1DataCacheFlushes);
> +	LP_SEQ_PRINTF(ImmediateL1DataCacheFlushes);
> +	LP_SEQ_PRINTF(MbFlushes);
> +	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
> +	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
> +	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
> +	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
> +	LP_SEQ_PRINTF(HwpRequestContextSwitches);
> +	LP_SEQ_PRINTF(Placeholder1);
> +	LP_SEQ_PRINTF(Placeholder2);
> +	LP_SEQ_PRINTF(Placeholder3);
> +	LP_SEQ_PRINTF(Placeholder4);
> +	LP_SEQ_PRINTF(Placeholder5);
> +	LP_SEQ_PRINTF(Placeholder6);
> +	LP_SEQ_PRINTF(Placeholder7);
> +	LP_SEQ_PRINTF(Placeholder8);
> +	LP_SEQ_PRINTF(Placeholder9);
> +	LP_SEQ_PRINTF(Placeholder10);
> +	LP_SEQ_PRINTF(ReserveGroupId);
> +	LP_SEQ_PRINTF(RunningPriority);
> +	LP_SEQ_PRINTF(PerfmonInterruptCount);
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
> +	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
> +	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
> +	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
> +	LP_SEQ_PRINTF(HwpRequestContextSwitches);
> +	LP_SEQ_PRINTF(Placeholder2);
> +	LP_SEQ_PRINTF(Placeholder3);
> +	LP_SEQ_PRINTF(Placeholder4);
> +	LP_SEQ_PRINTF(Placeholder5);
> +	LP_SEQ_PRINTF(Placeholder6);
> +	LP_SEQ_PRINTF(Placeholder7);
> +	LP_SEQ_PRINTF(Placeholder8);
> +	LP_SEQ_PRINTF(Placeholder9);
> +	LP_SEQ_PRINTF(SchLocalRunListSize);
> +	LP_SEQ_PRINTF(ReserveGroupId);
> +	LP_SEQ_PRINTF(RunningPriority);
> +#endif
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(lp_stats);
> +
> +static void mshv_lp_stats_unmap(u32 lp_index, void *stats_page_addr)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.lp.lp_index =3D lp_index,
> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
> +				  stats_page_addr, &identity);
> +	if (err)
> +		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
> +		       __func__, lp_index, err);
> +}
> +
> +static void __init *mshv_lp_stats_map(u32 lp_index)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.lp.lp_index =3D lp_index,
> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	void *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR, &identity,
> +				&stats);
> +	if (err) {
> +		pr_err("%s: failed to map logical processor %u stats, err: %d\n",
> +		       __func__, lp_index, err);
> +		return ERR_PTR(err);
> +	}
> +
> +	return stats;
> +}
> +
> +static void __init *lp_debugfs_stats_create(u32 lp_index, struct dentry =
*parent)
> +{
> +	struct dentry *dentry;
> +	void *stats;
> +
> +	stats =3D mshv_lp_stats_map(lp_index);
> +	if (IS_ERR(stats))
> +		return stats;
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     stats, &lp_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		mshv_lp_stats_unmap(lp_index, stats);
> +		return dentry;
> +	}
> +	return stats;
> +}
> +
> +static int __init lp_debugfs_create(u32 lp_index, struct dentry *parent)
> +{
> +	struct dentry *idx;
> +	char lp_idx_str[U32_BUF_SZ];
> +	void *stats;
> +	int err;
> +
> +	sprintf(lp_idx_str, "%u", lp_index);
> +
> +	idx =3D debugfs_create_dir(lp_idx_str, parent);
> +	if (IS_ERR(idx))
> +		return PTR_ERR(idx);
> +
> +	stats =3D lp_debugfs_stats_create(lp_index, idx);
> +	if (IS_ERR(stats)) {
> +		err =3D PTR_ERR(stats);
> +		goto remove_debugfs_lp_idx;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs_lp_idx:
> +	debugfs_remove_recursive(idx);
> +	return err;
> +}
> +
> +static void mshv_debugfs_lp_remove(void)
> +{
> +	int lp_index;
> +
> +	debugfs_remove_recursive(mshv_debugfs_lp);
> +
> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++)
> +		mshv_lp_stats_unmap(lp_index, NULL);

Passing NULL as the second argument here leaks the stats page
memory if Linux allocated the page as an overlay GPFN. But is that
considered OK because the debugfs entries for LPs are removed
only when the root partition is shutting down? That works as
long as hot-add/remove of CPUs isn't supported in the root
partition.

> +}
> +
> +static int __init mshv_debugfs_lp_create(struct dentry *parent)
> +{
> +	struct dentry *lp_dir;
> +	int err, lp_index;
> +
> +	lp_dir =3D debugfs_create_dir("lp", parent);
> +	if (IS_ERR(lp_dir))
> +		return PTR_ERR(lp_dir);
> +
> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++) {
> +		err =3D lp_debugfs_create(lp_index, lp_dir);
> +		if (err)
> +			goto remove_debugfs_lps;
> +	}
> +
> +	mshv_debugfs_lp =3D lp_dir;
> +
> +	return 0;
> +
> +remove_debugfs_lps:
> +	for (lp_index -=3D 1; lp_index >=3D 0; lp_index--)
> +		mshv_lp_stats_unmap(lp_index, NULL);
> +	debugfs_remove_recursive(lp_dir);
> +	return err;
> +}
> +
> +static int vp_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page **pstats =3D m->private;
> +
> +#define VP_SEQ_PRINTF(cnt)				 \
> +do {								 \
> +	if (pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]) \
> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> +			pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]); \
> +	else \
> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> +			pstats[HV_STATS_AREA_PARENT]->vp_cntrs[Vp##cnt]); \
> +} while (0)

I don't understand this logic. Like in mshv_vp_dispatch_thread_blocked(), i=
f
the SELF value is zero, then the PARENT value is used. The implication is t=
hat
you never want to display a SELF value of zero, which is a bit unexpected
since I could imagine zero being valid for some counters. But the overall r=
esult
is that the displayed values may be a mix of SELF and PARENT values.
And of course after Patch 1 of this series, if running on an older hypervis=
or
that doesn't provide PARENT, then SELF will be used anyway, which further
muddies what's going on here, at least for me. :-)

If this is the correct behavior, please add some code comments as to
why it makes sense, including in the case where PARENT isn't available.

> +
> +	VP_SEQ_PRINTF(TotalRunTime);
> +	VP_SEQ_PRINTF(HypervisorRunTime);
> +	VP_SEQ_PRINTF(RemoteNodeRunTime);
> +	VP_SEQ_PRINTF(NormalizedRunTime);
> +	VP_SEQ_PRINTF(IdealCpu);
> +	VP_SEQ_PRINTF(HypercallsCount);
> +	VP_SEQ_PRINTF(HypercallsTime);
> +#if IS_ENABLED(CONFIG_X86_64)
> +	VP_SEQ_PRINTF(PageInvalidationsCount);
> +	VP_SEQ_PRINTF(PageInvalidationsTime);
> +	VP_SEQ_PRINTF(ControlRegisterAccessesCount);
> +	VP_SEQ_PRINTF(ControlRegisterAccessesTime);
> +	VP_SEQ_PRINTF(IoInstructionsCount);
> +	VP_SEQ_PRINTF(IoInstructionsTime);
> +	VP_SEQ_PRINTF(HltInstructionsCount);
> +	VP_SEQ_PRINTF(HltInstructionsTime);
> +	VP_SEQ_PRINTF(MwaitInstructionsCount);
> +	VP_SEQ_PRINTF(MwaitInstructionsTime);
> +	VP_SEQ_PRINTF(CpuidInstructionsCount);
> +	VP_SEQ_PRINTF(CpuidInstructionsTime);
> +	VP_SEQ_PRINTF(MsrAccessesCount);
> +	VP_SEQ_PRINTF(MsrAccessesTime);
> +	VP_SEQ_PRINTF(OtherInterceptsCount);
> +	VP_SEQ_PRINTF(OtherInterceptsTime);
> +	VP_SEQ_PRINTF(ExternalInterruptsCount);
> +	VP_SEQ_PRINTF(ExternalInterruptsTime);
> +	VP_SEQ_PRINTF(PendingInterruptsCount);
> +	VP_SEQ_PRINTF(PendingInterruptsTime);
> +	VP_SEQ_PRINTF(EmulatedInstructionsCount);
> +	VP_SEQ_PRINTF(EmulatedInstructionsTime);
> +	VP_SEQ_PRINTF(DebugRegisterAccessesCount);
> +	VP_SEQ_PRINTF(DebugRegisterAccessesTime);
> +	VP_SEQ_PRINTF(PageFaultInterceptsCount);
> +	VP_SEQ_PRINTF(PageFaultInterceptsTime);
> +	VP_SEQ_PRINTF(GuestPageTableMaps);
> +	VP_SEQ_PRINTF(LargePageTlbFills);
> +	VP_SEQ_PRINTF(SmallPageTlbFills);
> +	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
> +	VP_SEQ_PRINTF(ApicMmioAccesses);
> +	VP_SEQ_PRINTF(IoInterceptMessages);
> +	VP_SEQ_PRINTF(MemoryInterceptMessages);
> +	VP_SEQ_PRINTF(ApicEoiAccesses);
> +	VP_SEQ_PRINTF(OtherMessages);
> +	VP_SEQ_PRINTF(PageTableAllocations);
> +	VP_SEQ_PRINTF(LogicalProcessorMigrations);
> +	VP_SEQ_PRINTF(AddressSpaceEvictions);
> +	VP_SEQ_PRINTF(AddressSpaceSwitches);
> +	VP_SEQ_PRINTF(AddressDomainFlushes);
> +	VP_SEQ_PRINTF(AddressSpaceFlushes);
> +	VP_SEQ_PRINTF(GlobalGvaRangeFlushes);
> +	VP_SEQ_PRINTF(LocalGvaRangeFlushes);
> +	VP_SEQ_PRINTF(PageTableEvictions);
> +	VP_SEQ_PRINTF(PageTableReclamations);
> +	VP_SEQ_PRINTF(PageTableResets);
> +	VP_SEQ_PRINTF(PageTableValidations);
> +	VP_SEQ_PRINTF(ApicTprAccesses);
> +	VP_SEQ_PRINTF(PageTableWriteIntercepts);
> +	VP_SEQ_PRINTF(SyntheticInterrupts);
> +	VP_SEQ_PRINTF(VirtualInterrupts);
> +	VP_SEQ_PRINTF(ApicIpisSent);
> +	VP_SEQ_PRINTF(ApicSelfIpisSent);
> +	VP_SEQ_PRINTF(GpaSpaceHypercalls);
> +	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
> +	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
> +	VP_SEQ_PRINTF(OtherHypercalls);
> +	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
> +	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
> +	VP_SEQ_PRINTF(VirtualMmuHypercalls);
> +	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
> +	VP_SEQ_PRINTF(HardwareInterrupts);
> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
> +	VP_SEQ_PRINTF(PageScans);
> +	VP_SEQ_PRINTF(LogicalProcessorDispatches);
> +	VP_SEQ_PRINTF(WaitingForCpuTime);
> +	VP_SEQ_PRINTF(ExtendedHypercalls);
> +	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
> +	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
> +	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
> +	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
> +	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
> +	VP_SEQ_PRINTF(LocalIoTlbFlushes);
> +	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
> +	VP_SEQ_PRINTF(HypercallsForwardedCount);
> +	VP_SEQ_PRINTF(HypercallsForwardingTime);
> +	VP_SEQ_PRINTF(PageInvalidationsForwardedCount);
> +	VP_SEQ_PRINTF(PageInvalidationsForwardingTime);
> +	VP_SEQ_PRINTF(ControlRegisterAccessesForwardedCount);
> +	VP_SEQ_PRINTF(ControlRegisterAccessesForwardingTime);
> +	VP_SEQ_PRINTF(IoInstructionsForwardedCount);
> +	VP_SEQ_PRINTF(IoInstructionsForwardingTime);
> +	VP_SEQ_PRINTF(HltInstructionsForwardedCount);
> +	VP_SEQ_PRINTF(HltInstructionsForwardingTime);
> +	VP_SEQ_PRINTF(MwaitInstructionsForwardedCount);
> +	VP_SEQ_PRINTF(MwaitInstructionsForwardingTime);
> +	VP_SEQ_PRINTF(CpuidInstructionsForwardedCount);
> +	VP_SEQ_PRINTF(CpuidInstructionsForwardingTime);
> +	VP_SEQ_PRINTF(MsrAccessesForwardedCount);
> +	VP_SEQ_PRINTF(MsrAccessesForwardingTime);
> +	VP_SEQ_PRINTF(OtherInterceptsForwardedCount);
> +	VP_SEQ_PRINTF(OtherInterceptsForwardingTime);
> +	VP_SEQ_PRINTF(ExternalInterruptsForwardedCount);
> +	VP_SEQ_PRINTF(ExternalInterruptsForwardingTime);
> +	VP_SEQ_PRINTF(PendingInterruptsForwardedCount);
> +	VP_SEQ_PRINTF(PendingInterruptsForwardingTime);
> +	VP_SEQ_PRINTF(EmulatedInstructionsForwardedCount);
> +	VP_SEQ_PRINTF(EmulatedInstructionsForwardingTime);
> +	VP_SEQ_PRINTF(DebugRegisterAccessesForwardedCount);
> +	VP_SEQ_PRINTF(DebugRegisterAccessesForwardingTime);
> +	VP_SEQ_PRINTF(PageFaultInterceptsForwardedCount);
> +	VP_SEQ_PRINTF(PageFaultInterceptsForwardingTime);
> +	VP_SEQ_PRINTF(VmclearEmulationCount);
> +	VP_SEQ_PRINTF(VmclearEmulationTime);
> +	VP_SEQ_PRINTF(VmptrldEmulationCount);
> +	VP_SEQ_PRINTF(VmptrldEmulationTime);
> +	VP_SEQ_PRINTF(VmptrstEmulationCount);
> +	VP_SEQ_PRINTF(VmptrstEmulationTime);
> +	VP_SEQ_PRINTF(VmreadEmulationCount);
> +	VP_SEQ_PRINTF(VmreadEmulationTime);
> +	VP_SEQ_PRINTF(VmwriteEmulationCount);
> +	VP_SEQ_PRINTF(VmwriteEmulationTime);
> +	VP_SEQ_PRINTF(VmxoffEmulationCount);
> +	VP_SEQ_PRINTF(VmxoffEmulationTime);
> +	VP_SEQ_PRINTF(VmxonEmulationCount);
> +	VP_SEQ_PRINTF(VmxonEmulationTime);
> +	VP_SEQ_PRINTF(NestedVMEntriesCount);
> +	VP_SEQ_PRINTF(NestedVMEntriesTime);
> +	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsCount);
> +	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsTime);
> +	VP_SEQ_PRINTF(NestedSLATHardPageFaultsCount);
> +	VP_SEQ_PRINTF(NestedSLATHardPageFaultsTime);
> +	VP_SEQ_PRINTF(InvEptAllContextEmulationCount);
> +	VP_SEQ_PRINTF(InvEptAllContextEmulationTime);
> +	VP_SEQ_PRINTF(InvEptSingleContextEmulationCount);
> +	VP_SEQ_PRINTF(InvEptSingleContextEmulationTime);
> +	VP_SEQ_PRINTF(InvVpidAllContextEmulationCount);
> +	VP_SEQ_PRINTF(InvVpidAllContextEmulationTime);
> +	VP_SEQ_PRINTF(InvVpidSingleContextEmulationCount);
> +	VP_SEQ_PRINTF(InvVpidSingleContextEmulationTime);
> +	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationCount);
> +	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationTime);
> +	VP_SEQ_PRINTF(NestedTlbPageTableReclamations);
> +	VP_SEQ_PRINTF(NestedTlbPageTableEvictions);
> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
> +	VP_SEQ_PRINTF(PostedInterruptNotifications);
> +	VP_SEQ_PRINTF(PostedInterruptScans);
> +	VP_SEQ_PRINTF(TotalCoreRunTime);
> +	VP_SEQ_PRINTF(MaximumRunTime);
> +	VP_SEQ_PRINTF(HwpRequestContextSwitches);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
> +	VP_SEQ_PRINTF(VmloadEmulationCount);
> +	VP_SEQ_PRINTF(VmloadEmulationTime);
> +	VP_SEQ_PRINTF(VmsaveEmulationCount);
> +	VP_SEQ_PRINTF(VmsaveEmulationTime);
> +	VP_SEQ_PRINTF(GifInstructionEmulationCount);
> +	VP_SEQ_PRINTF(GifInstructionEmulationTime);
> +	VP_SEQ_PRINTF(EmulatedErrataSvmInstructions);
> +	VP_SEQ_PRINTF(Placeholder1);
> +	VP_SEQ_PRINTF(Placeholder2);
> +	VP_SEQ_PRINTF(Placeholder3);
> +	VP_SEQ_PRINTF(Placeholder4);
> +	VP_SEQ_PRINTF(Placeholder5);
> +	VP_SEQ_PRINTF(Placeholder6);
> +	VP_SEQ_PRINTF(Placeholder7);
> +	VP_SEQ_PRINTF(Placeholder8);
> +	VP_SEQ_PRINTF(Placeholder9);
> +	VP_SEQ_PRINTF(Placeholder10);
> +	VP_SEQ_PRINTF(SchedulingPriority);
> +	VP_SEQ_PRINTF(RdpmcInstructionsCount);
> +	VP_SEQ_PRINTF(RdpmcInstructionsTime);
> +	VP_SEQ_PRINTF(PerfmonPmuMsrAccessesCount);
> +	VP_SEQ_PRINTF(PerfmonLbrMsrAccessesCount);
> +	VP_SEQ_PRINTF(PerfmonIptMsrAccessesCount);
> +	VP_SEQ_PRINTF(PerfmonInterruptCount);
> +	VP_SEQ_PRINTF(Vtl1DispatchCount);
> +	VP_SEQ_PRINTF(Vtl2DispatchCount);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
> +	VP_SEQ_PRINTF(Vtl1RunTime);
> +	VP_SEQ_PRINTF(Vtl2RunTime);
> +	VP_SEQ_PRINTF(IommuHypercalls);
> +	VP_SEQ_PRINTF(CpuGroupHypercalls);
> +	VP_SEQ_PRINTF(VsmHypercalls);
> +	VP_SEQ_PRINTF(EventLogHypercalls);
> +	VP_SEQ_PRINTF(DeviceDomainHypercalls);
> +	VP_SEQ_PRINTF(DepositHypercalls);
> +	VP_SEQ_PRINTF(SvmHypercalls);
> +	VP_SEQ_PRINTF(BusLockAcquisitionCount);

The x86 VpUnused counter is not shown. Any reason for that? All the
Placeholder counters *are* shown, so I'm just wondering what's
different.

> +#elif IS_ENABLED(CONFIG_ARM64)
> +	VP_SEQ_PRINTF(SysRegAccessesCount);
> +	VP_SEQ_PRINTF(SysRegAccessesTime);
> +	VP_SEQ_PRINTF(SmcInstructionsCount);
> +	VP_SEQ_PRINTF(SmcInstructionsTime);
> +	VP_SEQ_PRINTF(OtherInterceptsCount);
> +	VP_SEQ_PRINTF(OtherInterceptsTime);
> +	VP_SEQ_PRINTF(ExternalInterruptsCount);
> +	VP_SEQ_PRINTF(ExternalInterruptsTime);
> +	VP_SEQ_PRINTF(PendingInterruptsCount);
> +	VP_SEQ_PRINTF(PendingInterruptsTime);
> +	VP_SEQ_PRINTF(GuestPageTableMaps);
> +	VP_SEQ_PRINTF(LargePageTlbFills);
> +	VP_SEQ_PRINTF(SmallPageTlbFills);
> +	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
> +	VP_SEQ_PRINTF(MemoryInterceptMessages);
> +	VP_SEQ_PRINTF(OtherMessages);
> +	VP_SEQ_PRINTF(LogicalProcessorMigrations);
> +	VP_SEQ_PRINTF(AddressDomainFlushes);
> +	VP_SEQ_PRINTF(AddressSpaceFlushes);
> +	VP_SEQ_PRINTF(SyntheticInterrupts);
> +	VP_SEQ_PRINTF(VirtualInterrupts);
> +	VP_SEQ_PRINTF(ApicSelfIpisSent);
> +	VP_SEQ_PRINTF(GpaSpaceHypercalls);
> +	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
> +	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
> +	VP_SEQ_PRINTF(OtherHypercalls);
> +	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
> +	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
> +	VP_SEQ_PRINTF(VirtualMmuHypercalls);
> +	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
> +	VP_SEQ_PRINTF(HardwareInterrupts);
> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
> +	VP_SEQ_PRINTF(LogicalProcessorDispatches);
> +	VP_SEQ_PRINTF(WaitingForCpuTime);
> +	VP_SEQ_PRINTF(ExtendedHypercalls);
> +	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
> +	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
> +	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
> +	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
> +	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
> +	VP_SEQ_PRINTF(LocalIoTlbFlushes);
> +	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
> +	VP_SEQ_PRINTF(PostedInterruptNotifications);
> +	VP_SEQ_PRINTF(PostedInterruptScans);
> +	VP_SEQ_PRINTF(TotalCoreRunTime);
> +	VP_SEQ_PRINTF(MaximumRunTime);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
> +	VP_SEQ_PRINTF(HwpRequestContextSwitches);
> +	VP_SEQ_PRINTF(Placeholder2);
> +	VP_SEQ_PRINTF(Placeholder3);
> +	VP_SEQ_PRINTF(Placeholder4);
> +	VP_SEQ_PRINTF(Placeholder5);
> +	VP_SEQ_PRINTF(Placeholder6);
> +	VP_SEQ_PRINTF(Placeholder7);
> +	VP_SEQ_PRINTF(Placeholder8);
> +	VP_SEQ_PRINTF(ContentionTime);
> +	VP_SEQ_PRINTF(WakeUpTime);
> +	VP_SEQ_PRINTF(SchedulingPriority);
> +	VP_SEQ_PRINTF(Vtl1DispatchCount);
> +	VP_SEQ_PRINTF(Vtl2DispatchCount);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
> +	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
> +	VP_SEQ_PRINTF(Vtl1RunTime);
> +	VP_SEQ_PRINTF(Vtl2RunTime);
> +	VP_SEQ_PRINTF(IommuHypercalls);
> +	VP_SEQ_PRINTF(CpuGroupHypercalls);
> +	VP_SEQ_PRINTF(VsmHypercalls);
> +	VP_SEQ_PRINTF(EventLogHypercalls);
> +	VP_SEQ_PRINTF(DeviceDomainHypercalls);
> +	VP_SEQ_PRINTF(DepositHypercalls);
> +	VP_SEQ_PRINTF(SvmHypercalls);

The ARM64 VpLoadAvg counter is not shown?  Any reason why?

> +#endif

The VpRootDispatchThreadBlocked counter is not shown for either
x86 or ARM64. Is that intentional, and if so, why? I know the counter
is used in mshv_vp_dispatch_thread_blocked(), but it's not clear why
that means it shouldn't be shown here.

> +
> +	return 0;
> +}

This function, vp_stats_show(), seems like a candidate for redoing based on=
 a
static table that lists the counter names and index. Then the code just loo=
ps
through the table. On x86 each VP_SEQ_PRINTF() generates 42 bytes of code,
and there are 199 entries, so 8358 bytes. The table entries would probably
be 16 bytes each (a 64-bit pointer to the string constant, a 32-bit index v=
alue,
and 4 bytes of padding so each entry is 8-byte aligned). The actual space
saving isn't that large, but the code would be a lot more compact. The
other *_stats_shows() functions could do the same.

It's distasteful to me to see 420 lines of enum entries in Patch 2 of this =
series,
then followed by another 420 lines of matching *_SEQ_PRINTF entries. But I
realize that the goal of the enum entries is to match the Windows code, so =
I
guess it is what it is. But there's an argument for ditching the enum entri=
es
entirely, and using the putative static table to capture the information. I=
t
doesn't seem like matching the Windows code is saving much sync effort
since any additions/ subtractions to the enum entries need to be matched
with changes in the *_stats_show() functions, or in my putative static tabl=
e.
But I guess if Windows changed only the value for an enum entry without
additions/subtractions, that would sync more easily.

I'm just throwing this out as a thought. You may prefer to keep everything
"as is", in which case ignore my comment and I won't raise it again.

> +DEFINE_SHOW_ATTRIBUTE(vp_stats);
> +
> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index, void *st=
ats_page_addr,
> +				enum hv_stats_area_type stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.vp.partition_id =3D partition_id,
> +		.vp.vp_index =3D vp_index,
> +		.vp.stats_area_type =3D stats_area_type,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_VP, stats_page_addr, &ident=
ity);
> +	if (err)
> +		pr_err("%s: failed to unmap partition %llu vp %u %s stats, err: %d\n",
> +		       __func__, partition_id, vp_index,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +}
> +
> +static void *mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> +			       enum hv_stats_area_type stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.vp.partition_id =3D partition_id,
> +		.vp.vp_index =3D vp_index,
> +		.vp.stats_area_type =3D stats_area_type,
> +	};
> +	void *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity, &stats);
> +	if (err) {
> +		pr_err("%s: failed to map partition %llu vp %u %s stats, err: %d\n",
> +		       __func__, partition_id, vp_index,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +		return ERR_PTR(err);
> +	}
> +	return stats;
> +}

Presumably you've noticed that the functions mshv_vp_stats_map() and
mshv_vp_stats_unmap() also exist in mshv_root_main.c.  They are static
functions in both places, so the compiler & linker do the right thing, but
it sure does make things a bit more complex for human readers. The versions
here follow a consistent pattern for (lp, vp, hv, partition), so maybe the =
ones
in mshv_root_main.c could be renamed to avoid confusion?

> +
> +static int vp_debugfs_stats_create(u64 partition_id, u32 vp_index,
> +				   struct dentry **vp_stats_ptr,
> +				   struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	struct hv_stats_page **pstats;
> +	int err;
> +
> +	pstats =3D kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUN=
T);

Open coding "2" as the first parameter makes assumptions about the values o=
f
HV_STATS_AREA_SELF and HV_STATS_AREA_PARENT.  Should use
HV_STATS_AREA_COUNT instead of "2" so that indexing into the array is certa=
in
to work.

> +	if (!pstats)
> +		return -ENOMEM;
> +
> +	pstats[HV_STATS_AREA_SELF] =3D mshv_vp_stats_map(partition_id, vp_index=
,
> +						       HV_STATS_AREA_SELF);
> +	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
> +		err =3D PTR_ERR(pstats[HV_STATS_AREA_SELF]);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * L1VH partition cannot access its vp stats in parent area.
> +	 */
> +	if (is_l1vh_parent(partition_id)) {
> +		pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	} else {
> +		pstats[HV_STATS_AREA_PARENT] =3D mshv_vp_stats_map(
> +			partition_id, vp_index, HV_STATS_AREA_PARENT);
> +		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
> +			err =3D PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
> +			goto unmap_self;
> +		}
> +		if (!pstats[HV_STATS_AREA_PARENT])
> +			pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	}
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     pstats, &vp_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		goto unmap_vp_stats;
> +	}
> +
> +	*vp_stats_ptr =3D dentry;
> +	return 0;
> +
> +unmap_vp_stats:
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF])
> +		mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_PAREN=
T],
> +				    HV_STATS_AREA_PARENT);
> +unmap_self:
> +	mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_SELF],
> +			    HV_STATS_AREA_SELF);
> +cleanup:
> +	kfree(pstats);
> +	return err;
> +}
> +
> +static void vp_debugfs_remove(u64 partition_id, u32 vp_index,
> +			      struct dentry *vp_stats)
> +{
> +	struct hv_stats_page **pstats =3D NULL;
> +	void *stats;
> +
> +	pstats =3D vp_stats->d_inode->i_private;
> +	debugfs_remove_recursive(vp_stats->d_parent);
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF]) {
> +		stats =3D pstats[HV_STATS_AREA_PARENT];
> +		mshv_vp_stats_unmap(partition_id, vp_index, stats,
> +				    HV_STATS_AREA_PARENT);
> +	}
> +
> +	stats =3D pstats[HV_STATS_AREA_SELF];
> +	mshv_vp_stats_unmap(partition_id, vp_index, stats, HV_STATS_AREA_SELF);
> +
> +	kfree(pstats);
> +}
> +
> +static int vp_debugfs_create(u64 partition_id, u32 vp_index,
> +			     struct dentry **vp_stats_ptr,
> +			     struct dentry *parent)
> +{
> +	struct dentry *vp_idx_dir;
> +	char vp_idx_str[U32_BUF_SZ];
> +	int err;
> +
> +	sprintf(vp_idx_str, "%u", vp_index);
> +
> +	vp_idx_dir =3D debugfs_create_dir(vp_idx_str, parent);
> +	if (IS_ERR(vp_idx_dir))
> +		return PTR_ERR(vp_idx_dir);
> +
> +	err =3D vp_debugfs_stats_create(partition_id, vp_index, vp_stats_ptr,
> +				      vp_idx_dir);
> +	if (err)
> +		goto remove_debugfs_vp_idx;
> +
> +	return 0;
> +
> +remove_debugfs_vp_idx:
> +	debugfs_remove_recursive(vp_idx_dir);
> +	return err;
> +}
> +
> +static int partition_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page **pstats =3D m->private;
> +
> +#define PARTITION_SEQ_PRINTF(cnt)				 \
> +do {								 \
> +	if (pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]) \
> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> +			pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]); \
> +	else \
> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> +			pstats[HV_STATS_AREA_PARENT]->pt_cntrs[Partition##cnt]); \
> +} while (0)

Same comment as for VP_SEQ_PRINTF.

> +
> +	PARTITION_SEQ_PRINTF(VirtualProcessors);
> +	PARTITION_SEQ_PRINTF(TlbSize);
> +	PARTITION_SEQ_PRINTF(AddressSpaces);
> +	PARTITION_SEQ_PRINTF(DepositedPages);
> +	PARTITION_SEQ_PRINTF(GpaPages);
> +	PARTITION_SEQ_PRINTF(GpaSpaceModifications);
> +	PARTITION_SEQ_PRINTF(VirtualTlbFlushEntires);
> +	PARTITION_SEQ_PRINTF(RecommendedTlbSize);
> +	PARTITION_SEQ_PRINTF(GpaPages4K);
> +	PARTITION_SEQ_PRINTF(GpaPages2M);
> +	PARTITION_SEQ_PRINTF(GpaPages1G);
> +	PARTITION_SEQ_PRINTF(GpaPages512G);
> +	PARTITION_SEQ_PRINTF(DevicePages4K);
> +	PARTITION_SEQ_PRINTF(DevicePages2M);
> +	PARTITION_SEQ_PRINTF(DevicePages1G);
> +	PARTITION_SEQ_PRINTF(DevicePages512G);
> +	PARTITION_SEQ_PRINTF(AttachedDevices);
> +	PARTITION_SEQ_PRINTF(DeviceInterruptMappings);
> +	PARTITION_SEQ_PRINTF(IoTlbFlushes);
> +	PARTITION_SEQ_PRINTF(IoTlbFlushCost);
> +	PARTITION_SEQ_PRINTF(DeviceInterruptErrors);
> +	PARTITION_SEQ_PRINTF(DeviceDmaErrors);
> +	PARTITION_SEQ_PRINTF(DeviceInterruptThrottleEvents);
> +	PARTITION_SEQ_PRINTF(SkippedTimerTicks);
> +	PARTITION_SEQ_PRINTF(PartitionId);
> +#if IS_ENABLED(CONFIG_X86_64)
> +	PARTITION_SEQ_PRINTF(NestedTlbSize);
> +	PARTITION_SEQ_PRINTF(RecommendedNestedTlbSize);
> +	PARTITION_SEQ_PRINTF(NestedTlbFreeListSize);
> +	PARTITION_SEQ_PRINTF(NestedTlbTrimmedPages);
> +	PARTITION_SEQ_PRINTF(PagesShattered);
> +	PARTITION_SEQ_PRINTF(PagesRecombined);
> +	PARTITION_SEQ_PRINTF(HwpRequestValue);
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	PARTITION_SEQ_PRINTF(HwpRequestValue);
> +#endif
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(partition_stats);
> +
> +static void mshv_partition_stats_unmap(u64 partition_id, void *stats_pag=
e_addr,
> +				       enum hv_stats_area_type stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.partition.partition_id =3D partition_id,
> +		.partition.stats_area_type =3D stats_area_type,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_PARTITION, stats_page_addr,
> +				  &identity);
> +	if (err) {
> +		pr_err("%s: failed to unmap partition %lld %s stats, err: %d\n",
> +		       __func__, partition_id,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +	}
> +}
> +
> +static void *mshv_partition_stats_map(u64 partition_id,
> +				      enum hv_stats_area_type stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.partition.partition_id =3D partition_id,
> +		.partition.stats_area_type =3D stats_area_type,
> +	};
> +	void *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_PARTITION, &identity, &stats)=
;
> +	if (err) {
> +		pr_err("%s: failed to map partition %lld %s stats, err: %d\n",
> +		       __func__, partition_id,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +		return ERR_PTR(err);
> +	}
> +	return stats;
> +}
> +
> +static int mshv_debugfs_partition_stats_create(u64 partition_id,
> +					    struct dentry **partition_stats_ptr,
> +					    struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	struct hv_stats_page **pstats;
> +	int err;
> +
> +	pstats =3D kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUN=
T);

Same comment here about the use of "2" as the first parameter.

> +	if (!pstats)
> +		return -ENOMEM;
> +
> +	pstats[HV_STATS_AREA_SELF] =3D mshv_partition_stats_map(partition_id,
> +							      HV_STATS_AREA_SELF);
> +	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
> +		err =3D PTR_ERR(pstats[HV_STATS_AREA_SELF]);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * L1VH partition cannot access its partition stats in parent area.
> +	 */
> +	if (is_l1vh_parent(partition_id)) {
> +		pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	} else {
> +		pstats[HV_STATS_AREA_PARENT] =3D mshv_partition_stats_map(partition_id=
,
> +								HV_STATS_AREA_PARENT);
> +		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
> +			err =3D PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
> +			goto unmap_self;
> +		}
> +		if (!pstats[HV_STATS_AREA_PARENT])
> +			pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	}
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     pstats, &partition_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		goto unmap_partition_stats;
> +	}
> +
> +	*partition_stats_ptr =3D dentry;
> +	return 0;
> +
> +unmap_partition_stats:
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF])
> +		mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_PARENT],
> +					   HV_STATS_AREA_PARENT);
> +unmap_self:
> +	mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_SELF],
> +				   HV_STATS_AREA_SELF);
> +cleanup:
> +	kfree(pstats);
> +	return err;
> +}
> +
> +static void partition_debugfs_remove(u64 partition_id, struct dentry *de=
ntry)
> +{
> +	struct hv_stats_page **pstats =3D NULL;
> +	void *stats;
> +
> +	pstats =3D dentry->d_inode->i_private;
> +
> +	debugfs_remove_recursive(dentry->d_parent);
> +
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF]) {
> +		stats =3D pstats[HV_STATS_AREA_PARENT];
> +		mshv_partition_stats_unmap(partition_id, stats, HV_STATS_AREA_PARENT);
> +	}
> +
> +	stats =3D pstats[HV_STATS_AREA_SELF];
> +	mshv_partition_stats_unmap(partition_id, stats, HV_STATS_AREA_SELF);
> +
> +	kfree(pstats);
> +}
> +
> +static int partition_debugfs_create(u64 partition_id,
> +				    struct dentry **vp_dir_ptr,
> +				    struct dentry **partition_stats_ptr,
> +				    struct dentry *parent)
> +{
> +	char part_id_str[U64_BUF_SZ];
> +	struct dentry *part_id_dir, *vp_dir;
> +	int err;
> +
> +	if (is_l1vh_parent(partition_id))
> +		sprintf(part_id_str, "self");
> +	else
> +		sprintf(part_id_str, "%llu", partition_id);
> +
> +	part_id_dir =3D debugfs_create_dir(part_id_str, parent);
> +	if (IS_ERR(part_id_dir))
> +		return PTR_ERR(part_id_dir);
> +
> +	vp_dir =3D debugfs_create_dir("vp", part_id_dir);
> +	if (IS_ERR(vp_dir)) {
> +		err =3D PTR_ERR(vp_dir);
> +		goto remove_debugfs_partition_id;
> +	}
> +
> +	err =3D mshv_debugfs_partition_stats_create(partition_id,
> +						  partition_stats_ptr,
> +						  part_id_dir);
> +	if (err)
> +		goto remove_debugfs_partition_id;
> +
> +	*vp_dir_ptr =3D vp_dir;
> +
> +	return 0;
> +
> +remove_debugfs_partition_id:
> +	debugfs_remove_recursive(part_id_dir);
> +	return err;
> +}
> +
> +static void mshv_debugfs_parent_partition_remove(void)
> +{
> +	int idx;
> +
> +	for_each_online_cpu(idx)
> +		vp_debugfs_remove(hv_current_partition_id, idx, NULL);
> +
> +	partition_debugfs_remove(hv_current_partition_id, NULL);
> +}
> +
> +static int __init mshv_debugfs_parent_partition_create(void)
> +{
> +	struct dentry *partition_stats, *vp_dir;
> +	int err, idx, i;
> +
> +	mshv_debugfs_partition =3D debugfs_create_dir("partition",
> +						     mshv_debugfs);
> +	if (IS_ERR(mshv_debugfs_partition))
> +		return PTR_ERR(mshv_debugfs_partition);
> +
> +	err =3D partition_debugfs_create(hv_current_partition_id,
> +				       &vp_dir,
> +				       &partition_stats,
> +				       mshv_debugfs_partition);
> +	if (err)
> +		goto remove_debugfs_partition;
> +
> +	for_each_online_cpu(idx) {
> +		struct dentry *vp_stats;
> +
> +		err =3D vp_debugfs_create(hv_current_partition_id,
> +					hv_vp_index[idx],
> +					&vp_stats,
> +					vp_dir);
> +		if (err)
> +			goto remove_debugfs_partition_vp;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs_partition_vp:
> +	for_each_online_cpu(i) {
> +		if (i >=3D idx)
> +			break;
> +		vp_debugfs_remove(hv_current_partition_id, i, NULL);
> +	}
> +	partition_debugfs_remove(hv_current_partition_id, NULL);
> +remove_debugfs_partition:
> +	debugfs_remove_recursive(mshv_debugfs_partition);
> +	return err;
> +}
> +
> +static int hv_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page *stats =3D m->private;
> +
> +#define HV_SEQ_PRINTF(cnt)		\
> +	seq_printf(m, "%-25s: %llu\n", __stringify(cnt), stats->hv_cntrs[Hv##cn=
t])
> +
> +	HV_SEQ_PRINTF(LogicalProcessors);
> +	HV_SEQ_PRINTF(Partitions);
> +	HV_SEQ_PRINTF(TotalPages);
> +	HV_SEQ_PRINTF(VirtualProcessors);
> +	HV_SEQ_PRINTF(MonitoredNotifications);
> +	HV_SEQ_PRINTF(ModernStandbyEntries);
> +	HV_SEQ_PRINTF(PlatformIdleTransitions);
> +	HV_SEQ_PRINTF(HypervisorStartupCost);
> +	HV_SEQ_PRINTF(IOSpacePages);
> +	HV_SEQ_PRINTF(NonEssentialPagesForDump);
> +	HV_SEQ_PRINTF(SubsumedPages);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(hv_stats);
> +
> +static void mshv_hv_stats_unmap(void)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.hv.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_HYPERVISOR, NULL, &identity=
);
> +	if (err)
> +		pr_err("%s: failed to unmap hypervisor stats: %d\n",
> +		       __func__, err);
> +}
> +
> +static void * __init mshv_hv_stats_map(void)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.hv.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	void *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_HYPERVISOR, &identity, &stats=
);
> +	if (err) {
> +		pr_err("%s: failed to map hypervisor stats: %d\n",
> +		       __func__, err);
> +		return ERR_PTR(err);
> +	}
> +	return stats;
> +}
> +
> +static int __init mshv_debugfs_hv_stats_create(struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	u64 *stats;
> +	int err;
> +
> +	stats =3D mshv_hv_stats_map();
> +	if (IS_ERR(stats))
> +		return PTR_ERR(stats);
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     stats, &hv_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		pr_err("%s: failed to create hypervisor stats dentry: %d\n",
> +		       __func__, err);
> +		goto unmap_hv_stats;
> +	}
> +
> +	mshv_lps_count =3D stats[HvLogicalProcessors];
> +
> +	return 0;
> +
> +unmap_hv_stats:
> +	mshv_hv_stats_unmap();
> +	return err;
> +}
> +
> +int mshv_debugfs_vp_create(struct mshv_vp *vp)
> +{
> +	struct mshv_partition *p =3D vp->vp_partition;
> +	int err;
> +
> +	if (!mshv_debugfs)
> +		return 0;
> +
> +	err =3D vp_debugfs_create(p->pt_id, vp->vp_index,
> +				&vp->vp_debugfs_stats_dentry,
> +				p->pt_debugfs_vp_dentry);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +void mshv_debugfs_vp_remove(struct mshv_vp *vp)
> +{
> +	if (!mshv_debugfs)
> +		return;
> +
> +	vp_debugfs_remove(vp->vp_partition->pt_id, vp->vp_index,
> +			  vp->vp_debugfs_stats_dentry);
> +}
> +
> +int mshv_debugfs_partition_create(struct mshv_partition *partition)
> +{
> +	int err;
> +
> +	if (!mshv_debugfs)
> +		return 0;
> +
> +	err =3D partition_debugfs_create(partition->pt_id,
> +				       &partition->pt_debugfs_vp_dentry,
> +				       &partition->pt_debugfs_stats_dentry,
> +				       mshv_debugfs_partition);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +void mshv_debugfs_partition_remove(struct mshv_partition *partition)
> +{
> +	if (!mshv_debugfs)
> +		return;
> +
> +	partition_debugfs_remove(partition->pt_id,
> +				 partition->pt_debugfs_stats_dentry);
> +}
> +
> +int __init mshv_debugfs_init(void)
> +{
> +	int err;
> +
> +	mshv_debugfs =3D debugfs_create_dir("mshv", NULL);
> +	if (IS_ERR(mshv_debugfs)) {
> +		pr_err("%s: failed to create debugfs directory\n", __func__);
> +		return PTR_ERR(mshv_debugfs);
> +	}
> +
> +	if (hv_root_partition()) {
> +		err =3D mshv_debugfs_hv_stats_create(mshv_debugfs);
> +		if (err)
> +			goto remove_mshv_dir;
> +
> +		err =3D mshv_debugfs_lp_create(mshv_debugfs);
> +		if (err)
> +			goto unmap_hv_stats;
> +	}
> +
> +	err =3D mshv_debugfs_parent_partition_create();
> +	if (err)
> +		goto unmap_lp_stats;
> +
> +	return 0;
> +
> +unmap_lp_stats:
> +	if (hv_root_partition())
> +		mshv_debugfs_lp_remove();
> +unmap_hv_stats:
> +	if (hv_root_partition())
> +		mshv_hv_stats_unmap();
> +remove_mshv_dir:
> +	debugfs_remove_recursive(mshv_debugfs);
> +	return err;
> +}
> +
> +void mshv_debugfs_exit(void)
> +{
> +	mshv_debugfs_parent_partition_remove();
> +
> +	if (hv_root_partition()) {
> +		mshv_debugfs_lp_remove();
> +		mshv_hv_stats_unmap();
> +	}
> +
> +	debugfs_remove_recursive(mshv_debugfs);
> +}
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3eb815011b46..1f1b1984449b 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -51,6 +51,9 @@ struct mshv_vp {
>  		unsigned int kicked_by_hv;
>  		wait_queue_head_t vp_suspend_queue;
>  	} run;
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct dentry *vp_debugfs_stats_dentry;
> +#endif
>  };
>=20
>  #define vp_fmt(fmt) "p%lluvp%u: " fmt
> @@ -128,6 +131,10 @@ struct mshv_partition {
>  	u64 isolation_type;
>  	bool import_completed;
>  	bool pt_initialized;
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct dentry *pt_debugfs_stats_dentry;
> +	struct dentry *pt_debugfs_vp_dentry;
> +#endif
>  };
>=20
>  #define pt_fmt(fmt) "p%llu: " fmt
> @@ -308,6 +315,33 @@ int hv_call_modify_spa_host_access(u64 partition_id,=
 struct page **pages,
>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e, u64 arg,
>  				      void *property_value, size_t property_value_sz);
>=20
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +int __init mshv_debugfs_init(void);
> +void mshv_debugfs_exit(void);
> +
> +int mshv_debugfs_partition_create(struct mshv_partition *partition);
> +void mshv_debugfs_partition_remove(struct mshv_partition *partition);
> +int mshv_debugfs_vp_create(struct mshv_vp *vp);
> +void mshv_debugfs_vp_remove(struct mshv_vp *vp);
> +#else
> +static inline int __init mshv_debugfs_init(void)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_exit(void) { }
> +
> +static inline int mshv_debugfs_partition_create(struct mshv_partition *p=
artition)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_partition_remove(struct mshv_partition *=
partition) { }
> +static inline int mshv_debugfs_vp_create(struct mshv_vp *vp)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_vp_remove(struct mshv_vp *vp) { }
> +#endif
> +
>  extern struct mshv_root mshv_root;
>  extern enum hv_scheduler_type hv_scheduler_type;
>  extern u8 * __percpu *hv_synic_eventring_tail;
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 19006b788e85..152fcd9b45e6 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -982,6 +982,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition=
 *partition,
>  	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>  		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
>=20
> +	ret =3D mshv_debugfs_vp_create(vp);
> +	if (ret)
> +		goto put_partition;
> +
>  	/*
>  	 * Keep anon_inode_getfd last: it installs fd in the file struct and
>  	 * thus makes the state accessible in user space.
> @@ -989,7 +993,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition =
*partition,
>  	ret =3D anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
>  			       O_RDWR | O_CLOEXEC);
>  	if (ret < 0)
> -		goto put_partition;
> +		goto remove_debugfs_vp;
>=20
>  	/* already exclusive with the partition mutex for all ioctls */
>  	partition->pt_vp_count++;
> @@ -997,6 +1001,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition=
 *partition,
>=20
>  	return ret;
>=20
> +remove_debugfs_vp:
> +	mshv_debugfs_vp_remove(vp);
>  put_partition:
>  	mshv_partition_put(partition);
>  free_vp:
> @@ -1556,13 +1562,18 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
>=20
>  	ret =3D hv_call_initialize_partition(partition->pt_id);
>  	if (ret)
> -		goto withdraw_mem;
> +		return ret;
> +
> +	ret =3D mshv_debugfs_partition_create(partition);
> +	if (ret)
> +		goto finalize_partition;
>=20
>  	partition->pt_initialized =3D true;
>=20
>  	return 0;
>=20
> -withdraw_mem:
> +finalize_partition:
> +	hv_call_finalize_partition(partition->pt_id);
>  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
>=20
>  	return ret;
> @@ -1741,6 +1752,8 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  			if (!vp)
>  				continue;
>=20
> +			mshv_debugfs_vp_remove(vp);
> +
>  			if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
>  						    (void **)vp->vp_stats_pages);
> @@ -1775,6 +1788,8 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  			partition->pt_vp_array[i] =3D NULL;
>  		}
>=20
> +		mshv_debugfs_partition_remove(partition);
> +
>  		/* Deallocates and unmaps everything including vcpus, GPA mappings etc=
 */
>  		hv_call_finalize_partition(partition->pt_id);
>=20
> @@ -2351,10 +2366,14 @@ static int __init mshv_parent_partition_init(void=
)
>=20
>  	mshv_init_vmm_caps(dev);
>=20
> -	ret =3D mshv_irqfd_wq_init();
> +	ret =3D mshv_debugfs_init();
>  	if (ret)
>  		goto exit_partition;
>=20
> +	ret =3D mshv_irqfd_wq_init();
> +	if (ret)
> +		goto exit_debugfs;
> +
>  	spin_lock_init(&mshv_root.pt_ht_lock);
>  	hash_init(mshv_root.pt_htable);
>=20
> @@ -2362,6 +2381,10 @@ static int __init mshv_parent_partition_init(void)
>=20
>  	return 0;
>=20
> +destroy_irqds_wq:
> +	mshv_irqfd_wq_cleanup();
> +exit_debugfs:
> +	mshv_debugfs_exit();
>  exit_partition:
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> @@ -2378,6 +2401,7 @@ static void __exit mshv_parent_partition_exit(void)
>  {
>  	hv_setup_mshv_handler(NULL);
>  	mshv_port_table_fini();
> +	mshv_debugfs_exit();
>  	misc_deregister(&mshv_dev);
>  	mshv_irqfd_wq_cleanup();
>  	if (hv_root_partition())
> --
> 2.34.1


