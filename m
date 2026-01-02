Return-Path: <linux-hyperv+bounces-8117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F1CEEF7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1F430249C2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7B2BE7DB;
	Fri,  2 Jan 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OCB171R5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012018.outbound.protection.outlook.com [52.103.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62C2BE7DD;
	Fri,  2 Jan 2026 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371268; cv=fail; b=DZXD1Gmdu8Fcte4jfZjwwFOR6rEJrSl+Z0yK8ce9VndVTYSXi+9iQgshXX5t4B+GNCBlXeC0WtD5xIiXzr+NKLkConqOSLMLnKftvJh8Z0ih7HON15S0KowZBLLyWC1cBnzdwcTp0JYYwON1/QOopHnBIE1QoigIUUFtOAae87c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371268; c=relaxed/simple;
	bh=8vECDCSAlRcer9ni7DmBKCixqMFNKapj+foz4LS1Q4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCT2n2hmjXOXpGhRjhaBfAXmUyTCfsbk85Fz22Ga+N56NDcKRhjDsu+pYecVSTYKcDtH2nrxm1JZ1VE+KSTEizN+NCPbNhBEBMUySa0O0ZMT4QA8ql42IEF+hKWxdD2TkN9MRyL48VjBYiLbJ0XLC27pMW+w2xx+5xI7XGe0VcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OCB171R5; arc=fail smtp.client-ip=52.103.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdHb8g3MYRcYmB2qkDTZJmyKnyMfcwIix+M1WPj2i0g1sNSE6N089bUS599CPuaHx2EhwVNqHomeY/YmGh601lKJ9WR9tJG8Y81/lpQggwimhp0nvXeoAUb+WfZDatJJijiTkuyUfR3BJiTIBLPdIGGTyiha5objXMcLZuJnX96ilr0HaGNnLRF2J2dXXJEwWqpZx+LywKsPCU7oDEfC/vPoDLql4d3M0RVzZREIVbWgHs/W4s2gSgrMM4sw7vaYPf8IM+cw9z8mvY0Uzvx5quWqPBqF6/ltFTFkUzCZ/4jHyjwv8TGAErLF1/SVp35HKQIJGpTi12V9PNAkjpJTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaSA7FVLUOtgyCIbdKAqGthTdFuMb9nAdWGO5TILJHk=;
 b=KvxHpLx5JLxzTRAc455rcZO9VBsrk6cooDCVzQpfiACsvmqKqwiPGkKh1rXIbm0kpPnftfP0kLgbM7k/wRstv0OLOoBlMqpREqXjqzk43t00sp5weX7K+0f9RIfU3kOUXJOFL54ctyKVPdJQsgRDob7GklsFj2GpRO9T7j0WsRcRhjTAIIRwZT6/kQDfHtMYjH+ODjJAX5BULj6cHQ6VsDVIu0PblEiu6iQ5Q38+lK2lP4UIea+In1lb967O0pIse+5UxuWyIRu1dbqJTixZ6TdSXUT3yTPln+3MDbaLQtgXLn5CLMja33SSj/3bgYr1M3lulR1isAE58r3QqLv9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaSA7FVLUOtgyCIbdKAqGthTdFuMb9nAdWGO5TILJHk=;
 b=OCB171R5Gs1hCfuPlzn/Mrcq8NaVXTVFOfKo9VBUAwtfKRSDz0OHRYXzbyMTUUrvDGCGvU9OsFQSpZw3tQgjBGyPoJh9nQfu4bVG9vaNqRme0RXMxzDNcbgjO9ZdY5kW6SK+IPc/4KOpeW+yFdI+xKuQH+m7nekcc3fk/1WDkbl8NTs9cpSQgRvTt6Bff/FFJT7XkHXBAvkHPMIzQqMS8g6xyCprl0Mh8uXCHTRJEeb1fcKK+ShOBQHbXwIfvpmGmk4KxH3/HmVlgiMqyVsX/rvK+CJRY8pVHpIPSp92yyoKgXp21/1ZLFtJNu7KkUiDs/K3aOEqgUGcz0UAS/8Eaw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV9PR02MB10829.namprd02.prod.outlook.com (2603:10b6:408:2e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:27:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 16:27:43 +0000
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
Thread-Index: AQHcZhkxXqEVkR76PkyUq1ykbhoMv7UXPKsggCPPZgCABCpgUA==
Date: Fri, 2 Jan 2026 16:27:42 +0000
Message-ID:
 <SN6PR02MB415789DA6B19074B56CB5905D4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-4-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157938404BC0D12978ACD9BD4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff9aa617-3980-49bf-9311-282b70714280@linux.microsoft.com>
In-Reply-To: <ff9aa617-3980-49bf-9311-282b70714280@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV9PR02MB10829:EE_
x-ms-office365-filtering-correlation-id: 1461c203-f4cd-4784-0202-08de4a1bdadf
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|15080799012|19110799012|13091999003|31061999003|8060799015|8062599012|12121999013|440099028|3412199025|40105399003|30101999003|18061999006|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Jwa5Pp59SfrSFtyfcHkjRIXXIL4V7vu/ui/21tHkyxVUb85G9xrIQ0nOxKu0?=
 =?us-ascii?Q?VDU+pQA8UXWFeswUesAclscA+pM072/zQMIW+t3HHaYXaoPjy8+kqYfTBuRc?=
 =?us-ascii?Q?uQ9zrLMd48REu6g3plgVIQtSh+xWSQvYZLPao498AO50leJIuMCAlD8CfDuP?=
 =?us-ascii?Q?Kl27XYVqlMY72c9dGxaNXtHsVq1bphqXGJD44zSf30XRdsf8vMR0KLumzVKC?=
 =?us-ascii?Q?YQqSxYTSDmYcaKKxmwTZOCcpqkF/F7E59SqRGPSlOOkU3GOHpYiLN+f59Kuk?=
 =?us-ascii?Q?Pg13jpP7UNGJ3a6QfNnH5HcgEurciXUnnCAGiyTaj9Y8tobnQBIBjut1P2Ck?=
 =?us-ascii?Q?5e1PE1RtZNz+gabzA/WWDf0UYtKxfcUL9lay7P7gtWHp1u2kL00Ub3IjloQl?=
 =?us-ascii?Q?YTYvPv9zLB3cOEPihBlMIfaUd4mAGOoEI5Wimx9gv2hLjzoePqy/DzItOgmC?=
 =?us-ascii?Q?n/N9pTY5nXKb72uefZZ2oU2/6u9C1c9aJFdjvhY/8qg4wGRPKvfPVLoyRr09?=
 =?us-ascii?Q?A3m5125IEiY+FxwTGmc0rEZ0pOqjbiteZJRWFNDTbPn0EI55tPCsbDpH6JWy?=
 =?us-ascii?Q?mLXQHD/VajYKKTbGCbxQg1+oUrc0lwnZm8kMBBhRdMvjakiIPCMuYVCnLhaq?=
 =?us-ascii?Q?2P3Yk+WSaf8IYa/u6RioXyPpqmmOLOGDBb0xkECPlRTY3Toj5wUD4FMXU1Vr?=
 =?us-ascii?Q?3xMDreo5WQWMbPfxEzCQh0q/BUOGDWic0TUi3aqeB55TEA/XlsGGs8DKzPgl?=
 =?us-ascii?Q?1xlr2zXZS01r3PnkCLdbAJrFDSRrFsPYZJuMCEidd4vFdQFg+mYDloFtz1I8?=
 =?us-ascii?Q?1lv4l9y/rmPSKAR0igLmgVuV+lWgew9TejtTR/Ks2dQ/tM6nhD+rxZZ7TfA2?=
 =?us-ascii?Q?DNgMg9EOHi52I8Kl9DMnfjYasr3NtS8UY0qoBMAgWymMcDgUDPth56CD0AMc?=
 =?us-ascii?Q?ps6J8EuYrGN9YyDu+uh9FGfqoY9UOFCCVg8/49sGrXreggaWQ8WuoLDg+x2k?=
 =?us-ascii?Q?xOja4b17j5R5YNB9cSk0wRpam7sS3s2yK1WkOJclvW2CWww/XealvcfECBLh?=
 =?us-ascii?Q?LGga9K83MoFHRhOncBUKG0YflIvLuIs+rvuYvAs1oHxUFTcrk3GBe+1ouPKo?=
 =?us-ascii?Q?u71vsgwNiGNyGEX2wR/yj7hw0O69//ekW127dzcXFJomWppTk1SDJtYmeJJl?=
 =?us-ascii?Q?h8R9jej6CRmiDVw3yB0N8h1AKiGvGNEirrfTBStShTZ8PmWIAvtw6xz0X7Hp?=
 =?us-ascii?Q?b6/6Jq/1cgIhenxPGkO/aCOG3P0z2CtfUTHRt964nBtF2gG8AA3ZgQ6sBkZT?=
 =?us-ascii?Q?IjwnR7UPxh1UHKeY1KG2xo8n7jwPsw1ahXJPi8jhhvPtmmjHxCfvH1pP1wcS?=
 =?us-ascii?Q?fM+nSoPI766GoL59Jnf0zuf0n170?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X/EY8hAKUwLIAHT92mj1US+H159NBr0Hu5NXa+MEc8pzoPaEpDsPzvQoLbC+?=
 =?us-ascii?Q?5OCM79TN/zV3APhLiYIOfpsgmWUklgs7agf9+7h6S10EpmMV8MOMbEZ+am4I?=
 =?us-ascii?Q?3XgadXM8cL+sGcsRx8Xtvrb1vvIAAqxzrjszKxbji7JLY113wa6u7EJYvXaF?=
 =?us-ascii?Q?NI+FgeLhTQVuft/yZI9FyPorMDw84Gs3yQSlUQpVXqgO8Kl8YbC9nfYOJyvO?=
 =?us-ascii?Q?uQP1xBAAqML6ktdW4e3497N1CplysYfOfXHB3z6KFFwbtRHC4WNd9F3P8bZE?=
 =?us-ascii?Q?UI9m+qmlji9ztc7oMsRmHnOMTn3NjDaUqVgHBNUkqEcYX0UzUeL2zJuj62fS?=
 =?us-ascii?Q?DzJYJqECmiq27aZRLS69vzsjZocNZMYdQw37TG6/B4JocQO72sMzBDuLHSLr?=
 =?us-ascii?Q?fewYCoFlNbMZISZWsbaMPrYW2mOJ1pSfGzkdaDUsQnFe2xvVgSuDXpWdCjjj?=
 =?us-ascii?Q?W3rTvLU6V86i/geTAR8TkOMTywWcAgew9DQbae5mrYzToQX4wJY2w/ZHL7Lk?=
 =?us-ascii?Q?r+xLKUdDkeGRec2P5K0CTrwdwAjc9z8Ygkmj8OD34fk/Aoh6JKz+VfdJoDcO?=
 =?us-ascii?Q?n+ajRkuPN8ZcBzh6ytT76CiqaL00H4aujexjInxH9mIyfVNEOBB+EsBWM+aT?=
 =?us-ascii?Q?f5VJthDsMtL/NlGWHy8iJZj6u9pdl1sR1g6QNW/uVfkoLCvpgJpuCXRupCRr?=
 =?us-ascii?Q?Hgu3W44Hns0r/egMivZ/h8DL/7B+nL0czeE3Wsv+Co+SoUgE/EUzzEYD0c6i?=
 =?us-ascii?Q?iconrWTxJ1Ap8x1Uh83alc28TEeNuyZdXhvocyKlzozxgSXXOQIZfNpOv4Re?=
 =?us-ascii?Q?zXOOHHE88kykP4DhMaHEH05vvJEgR6ljRT9WBnbJizq+k+lP8iDMmYQ1RJ74?=
 =?us-ascii?Q?0+OTJltmdQMkq4Iea7FMqt2xsMHLx2WArURKgXMBn/qZnphoAXLdq293EbMQ?=
 =?us-ascii?Q?xGfX0ib97dKAB7f6h6zJZBE7Xv6GFL5+3UowKc37GbTPq1+HqoIQ1WopXE8F?=
 =?us-ascii?Q?/lTpvSwsI3X7rWVR6AvmwrPCtRX2AbqZ5Tk9GTnyxqpMWKbTMcAzhZCixa2v?=
 =?us-ascii?Q?tm4R3n2jYJ9w8m1yduGA7guETBxZlNO0LLcpVHtdKRUMUzVsXCpw50y+m1cq?=
 =?us-ascii?Q?nmCNtIP0pu3auXH9atHGWcgQnvHBAgitMkSMHdKQ5aSdo2aHawYMpSo1TYZS?=
 =?us-ascii?Q?G30Qmb+sTulAfdVqBDDYZwSVeQunqIuIWkbpRw7WzApI7hNV9oyGpPmGFqSQ?=
 =?us-ascii?Q?0HLZC1eAptoZiF654ngFY3776Mz2I70dFobd9RNNDu0N1tW64QYnD0MN+m2B?=
 =?us-ascii?Q?EsV6M20w6X7v97iXfRNk41JzXnJ9VvMJP0xRwNzX1s2m4yovBlEd8m0d7kPy?=
 =?us-ascii?Q?b0YBTr0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1461c203-f4cd-4784-0202-08de4a1bdadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 16:27:42.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB10829

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Dece=
mber 30, 2025 4:27 PM
>=20
> On 12/8/2025 7:21 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, D=
ecember 5, 2025 10:59 AM
> >>
> >> Introduce a debugfs interface to expose root and child partition stats
> >> when running with mshv_root.
> >>
> >> Create a debugfs directory "mshv" containing 'stats' files organized b=
y
> >> type and id. A stats file contains a number of counters depending on
> >> its type. e.g. an excerpt from a VP stats file:
> >>
> >> TotalRunTime                  : 1997602722
> >> HypervisorRunTime             : 649671371
> >> RemoteNodeRunTime             : 0
> >> NormalizedRunTime             : 1997602721
> >> IdealCpu                      : 0
> >> HypercallsCount               : 1708169
> >> HypercallsTime                : 111914774
> >> PageInvalidationsCount        : 0
> >> PageInvalidationsTime         : 0
> >>
> >> On a root partition with some active child partitions, the entire
> >> directory structure may look like:
> >>
> >> mshv/
> >>   stats             # hypervisor stats
> >>   lp/               # logical processors
> >>     0/              # LP id
> >>       stats         # LP 0 stats
> >>     1/
> >>     2/
> >>     3/
> >>   partition/        # partition stats
> >>     1/              # root partition id
> >>       stats         # root partition stats
> >>       vp/           # root virtual processors
> >>         0/          # root VP id
> >>           stats     # root VP 0 stats
> >>         1/
> >>         2/
> >>         3/
> >>     42/             # child partition id
> >>       stats         # child partition stats
> >>       vp/           # child VPs
> >>         0/          # child VP id
> >>           stats     # child VP 0 stats
> >>         1/
> >>     43/
> >>     55/
> >>
> >
> > In the above directory tree, each of the "stats" files is in a director=
y
> > by itself, where the directory name is the number of whatever
> > entity the stats are for (lp, partition, or vp). Do you expect there to
> > be other files parallel to "stats" that will be added later? Otherwise
> > you could collapse one directory level. The "best" directory structure
> > is somewhat a matter of taste and judgment, so there's not a "right"
> > answer. I don't object if your preference is to keep the numbered
> > directories, even if they are likely to never contain more than the
> > "stats" file.
> >
> Good question, I'm not aware of a plan to add additional parallel files
> in future, but even so, I think this structure is fine as-is.
>=20
> I see how the VPs and LPs directories could be collapsed, but partitions
> need to be directories to contain the VPs, so that would be an
> inconsistency (some "stats" files and some "$ID" files) which seems worse
> to me. e.g.., are you suggesting something like this?
>=20
> mshv/
>    stats             # hypervisor stats
>    lp/               # logical processors
>      0               # LP 0 stats
>      1               # LP 1 stats
>    partition/        # partition stats directory
>      1/              # root partition id
>        stats         # root partition stats
>        vp/           # root virtual processors
>          0           # root VP 0 stats
>          1           # root VP 1 stats
>      4/              # child partition id
>        stats         # child partition stats
>        vp/           # child virtual processors
>          0           # child VP 0 stats
>          1           # child VP 1 stats
>=20
> Unless I'm misunderstanding what you mean, I think the original is better=
,
> both because it's more consistent and does leave room for adding addition=
al
> files if we ever want to.

Fair enough. Just curious -- is there envisioned to be a user space program
written to read and display all these stats in some organized fashion? I'm
presuming the user space VMM should not have an operational dependency
on this data because it is debugfs.

>=20
> >> On L1VH, some stats are not present as it does not own the hardware
> >> like the root partition does:
> >> - The hypervisor and lp stats are not present
> >> - L1VH's partition directory is named "self" because it can't get its
> >>   own id
> >> - Some of L1VH's partition and VP stats fields are not populated, beca=
use
> >>   it can't map its own HV_STATS_AREA_PARENT page.
> >>
> >> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.c=
om>
> >> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com=
>
> >> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> >> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> >> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> Co-developed-by: Purna Pavan Chandra Aekkaladevi
> >> <paekkaladevi@linux.microsoft.com>
> >> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.mic=
rosoft.com>
> >> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> >> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> >> ---
> >>  drivers/hv/Makefile         |    1 +
> >>  drivers/hv/mshv_debugfs.c   | 1122 ++++++++++++++++++++++++++++++++++=
+
> >>  drivers/hv/mshv_root.h      |   34 ++
> >>  drivers/hv/mshv_root_main.c |   32 +-
> >>  4 files changed, 1185 insertions(+), 4 deletions(-)
> >>  create mode 100644 drivers/hv/mshv_debugfs.c
> >>
> >> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> >> index 58b8d07639f3..36278c936914 100644
> >> --- a/drivers/hv/Makefile
> >> +++ b/drivers/hv/Makefile
> >> @@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
> >>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> >>  mshv_root-y :=3D mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_ir=
q.o \
> >>  	       mshv_root_hv_call.o mshv_portid_table.o
> >> +mshv_root-$(CONFIG_DEBUG_FS) +=3D mshv_debugfs.o
> >>  mshv_vtl-y :=3D mshv_vtl_main.o
> >>
> >>  # Code that must be built-in
> >> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> >> new file mode 100644
> >> index 000000000000..581018690a27
> >> --- /dev/null
> >> +++ b/drivers/hv/mshv_debugfs.c
> >> @@ -0,0 +1,1122 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2025, Microsoft Corporation.
> >> + *
> >> + * The /sys/kernel/debug/mshv directory contents.
> >> + * Contains various statistics data, provided by the hypervisor.
> >> + *
> >> + * Authors: Microsoft Linux virtualization team
> >> + */
> >> +
> >> +#include <linux/debugfs.h>
> >> +#include <linux/stringify.h>
> >> +#include <asm/mshyperv.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "mshv.h"
> >> +#include "mshv_root.h"
> >> +
> >> +#define U32_BUF_SZ 11
> >> +#define U64_BUF_SZ 21
> >> +
> >> +static struct dentry *mshv_debugfs;
> >> +static struct dentry *mshv_debugfs_partition;
> >> +static struct dentry *mshv_debugfs_lp;
> >> +
> >> +static u64 mshv_lps_count;
> >> +
> >> +static bool is_l1vh_parent(u64 partition_id)
> >> +{
> >> +	return hv_l1vh_partition() && (partition_id =3D=3D HV_PARTITION_ID_S=
ELF);
> >> +}
> >> +
> >> +static int lp_stats_show(struct seq_file *m, void *v)
> >> +{
> >> +	const struct hv_stats_page *stats =3D m->private;
> >> +
> >> +#define LP_SEQ_PRINTF(cnt)		\
> >> +	seq_printf(m, "%-29s: %llu\n", __stringify(cnt), stats->lp_cntrs[Lp#=
#cnt])
> >> +
> >> +	LP_SEQ_PRINTF(GlobalTime);
> >> +	LP_SEQ_PRINTF(TotalRunTime);
> >> +	LP_SEQ_PRINTF(HypervisorRunTime);
> >> +	LP_SEQ_PRINTF(HardwareInterrupts);
> >> +	LP_SEQ_PRINTF(ContextSwitches);
> >> +	LP_SEQ_PRINTF(InterProcessorInterrupts);
> >> +	LP_SEQ_PRINTF(SchedulerInterrupts);
> >> +	LP_SEQ_PRINTF(TimerInterrupts);
> >> +	LP_SEQ_PRINTF(InterProcessorInterruptsSent);
> >> +	LP_SEQ_PRINTF(ProcessorHalts);
> >> +	LP_SEQ_PRINTF(MonitorTransitionCost);
> >> +	LP_SEQ_PRINTF(ContextSwitchTime);
> >> +	LP_SEQ_PRINTF(C1TransitionsCount);
> >> +	LP_SEQ_PRINTF(C1RunTime);
> >> +	LP_SEQ_PRINTF(C2TransitionsCount);
> >> +	LP_SEQ_PRINTF(C2RunTime);
> >> +	LP_SEQ_PRINTF(C3TransitionsCount);
> >> +	LP_SEQ_PRINTF(C3RunTime);
> >> +	LP_SEQ_PRINTF(RootVpIndex);
> >> +	LP_SEQ_PRINTF(IdleSequenceNumber);
> >> +	LP_SEQ_PRINTF(GlobalTscCount);
> >> +	LP_SEQ_PRINTF(ActiveTscCount);
> >> +	LP_SEQ_PRINTF(IdleAccumulation);
> >> +	LP_SEQ_PRINTF(ReferenceCycleCount0);
> >> +	LP_SEQ_PRINTF(ActualCycleCount0);
> >> +	LP_SEQ_PRINTF(ReferenceCycleCount1);
> >> +	LP_SEQ_PRINTF(ActualCycleCount1);
> >> +	LP_SEQ_PRINTF(ProximityDomainId);
> >> +	LP_SEQ_PRINTF(PostedInterruptNotifications);
> >> +	LP_SEQ_PRINTF(BranchPredictorFlushes);
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	LP_SEQ_PRINTF(L1DataCacheFlushes);
> >> +	LP_SEQ_PRINTF(ImmediateL1DataCacheFlushes);
> >> +	LP_SEQ_PRINTF(MbFlushes);
> >> +	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
> >> +	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
> >> +	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
> >> +	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
> >> +	LP_SEQ_PRINTF(HwpRequestContextSwitches);
> >> +	LP_SEQ_PRINTF(Placeholder1);
> >> +	LP_SEQ_PRINTF(Placeholder2);
> >> +	LP_SEQ_PRINTF(Placeholder3);
> >> +	LP_SEQ_PRINTF(Placeholder4);
> >> +	LP_SEQ_PRINTF(Placeholder5);
> >> +	LP_SEQ_PRINTF(Placeholder6);
> >> +	LP_SEQ_PRINTF(Placeholder7);
> >> +	LP_SEQ_PRINTF(Placeholder8);
> >> +	LP_SEQ_PRINTF(Placeholder9);
> >> +	LP_SEQ_PRINTF(Placeholder10);
> >> +	LP_SEQ_PRINTF(ReserveGroupId);
> >> +	LP_SEQ_PRINTF(RunningPriority);
> >> +	LP_SEQ_PRINTF(PerfmonInterruptCount);
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
> >> +	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
> >> +	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
> >> +	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
> >> +	LP_SEQ_PRINTF(HwpRequestContextSwitches);
> >> +	LP_SEQ_PRINTF(Placeholder2);
> >> +	LP_SEQ_PRINTF(Placeholder3);
> >> +	LP_SEQ_PRINTF(Placeholder4);
> >> +	LP_SEQ_PRINTF(Placeholder5);
> >> +	LP_SEQ_PRINTF(Placeholder6);
> >> +	LP_SEQ_PRINTF(Placeholder7);
> >> +	LP_SEQ_PRINTF(Placeholder8);
> >> +	LP_SEQ_PRINTF(Placeholder9);
> >> +	LP_SEQ_PRINTF(SchLocalRunListSize);
> >> +	LP_SEQ_PRINTF(ReserveGroupId);
> >> +	LP_SEQ_PRINTF(RunningPriority);
> >> +#endif
> >> +
> >> +	return 0;
> >> +}
> >> +DEFINE_SHOW_ATTRIBUTE(lp_stats);
> >> +
> >> +static void mshv_lp_stats_unmap(u32 lp_index, void *stats_page_addr)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.lp.lp_index =3D lp_index,
> >> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> >> +	};
> >> +	int err;
> >> +
> >> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
> >> +				  stats_page_addr, &identity);
> >> +	if (err)
> >> +		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
> >> +		       __func__, lp_index, err);
> >> +}
> >> +
> >> +static void __init *mshv_lp_stats_map(u32 lp_index)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.lp.lp_index =3D lp_index,
> >> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> >> +	};
> >> +	void *stats;
> >> +	int err;
> >> +
> >> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR, &identi=
ty,
> >> +				&stats);
> >> +	if (err) {
> >> +		pr_err("%s: failed to map logical processor %u stats, err: %d\n",
> >> +		       __func__, lp_index, err);
> >> +		return ERR_PTR(err);
> >> +	}
> >> +
> >> +	return stats;
> >> +}
> >> +
> >> +static void __init *lp_debugfs_stats_create(u32 lp_index, struct dent=
ry *parent)
> >> +{
> >> +	struct dentry *dentry;
> >> +	void *stats;
> >> +
> >> +	stats =3D mshv_lp_stats_map(lp_index);
> >> +	if (IS_ERR(stats))
> >> +		return stats;
> >> +
> >> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> >> +				     stats, &lp_stats_fops);
> >> +	if (IS_ERR(dentry)) {
> >> +		mshv_lp_stats_unmap(lp_index, stats);
> >> +		return dentry;
> >> +	}
> >> +	return stats;
> >> +}
> >> +
> >> +static int __init lp_debugfs_create(u32 lp_index, struct dentry *pare=
nt)
> >> +{
> >> +	struct dentry *idx;
> >> +	char lp_idx_str[U32_BUF_SZ];
> >> +	void *stats;
> >> +	int err;
> >> +
> >> +	sprintf(lp_idx_str, "%u", lp_index);
> >> +
> >> +	idx =3D debugfs_create_dir(lp_idx_str, parent);
> >> +	if (IS_ERR(idx))
> >> +		return PTR_ERR(idx);
> >> +
> >> +	stats =3D lp_debugfs_stats_create(lp_index, idx);
> >> +	if (IS_ERR(stats)) {
> >> +		err =3D PTR_ERR(stats);
> >> +		goto remove_debugfs_lp_idx;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +remove_debugfs_lp_idx:
> >> +	debugfs_remove_recursive(idx);
> >> +	return err;
> >> +}
> >> +
> >> +static void mshv_debugfs_lp_remove(void)
> >> +{
> >> +	int lp_index;
> >> +
> >> +	debugfs_remove_recursive(mshv_debugfs_lp);
> >> +
> >> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++)
> >> +		mshv_lp_stats_unmap(lp_index, NULL);
> >
> > Passing NULL as the second argument here leaks the stats page
> > memory if Linux allocated the page as an overlay GPFN. But is that
> > considered OK because the debugfs entries for LPs are removed
> > only when the root partition is shutting down? That works as
> > long as hot-add/remove of CPUs isn't supported in the root
> > partition.
> >
> Hmm, at the very least this appears to be a memory leak if the mshv
> driver is built as a module and removed + reinserted. The stats
> pages can be mapped multiple times so it will just allocate a page
> (on L1VH anyway) and remap it each time. I will check and fix it in
> this patch.

OK. I was thinking that removing and re-inserting the mshv driver
module isn't possible from any practical standpoint without doing
a shutdown, but maybe there is a way.

>=20
> >> +}
> >> +
> >> +static int __init mshv_debugfs_lp_create(struct dentry *parent)
> >> +{
> >> +	struct dentry *lp_dir;
> >> +	int err, lp_index;
> >> +
> >> +	lp_dir =3D debugfs_create_dir("lp", parent);
> >> +	if (IS_ERR(lp_dir))
> >> +		return PTR_ERR(lp_dir);
> >> +
> >> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++) {
> >> +		err =3D lp_debugfs_create(lp_index, lp_dir);
> >> +		if (err)
> >> +			goto remove_debugfs_lps;
> >> +	}
> >> +
> >> +	mshv_debugfs_lp =3D lp_dir;
> >> +
> >> +	return 0;
> >> +
> >> +remove_debugfs_lps:
> >> +	for (lp_index -=3D 1; lp_index >=3D 0; lp_index--)
> >> +		mshv_lp_stats_unmap(lp_index, NULL);
> >> +	debugfs_remove_recursive(lp_dir);
> >> +	return err;
> >> +}
> >> +
> >> +static int vp_stats_show(struct seq_file *m, void *v)
> >> +{
> >> +	const struct hv_stats_page **pstats =3D m->private;
> >> +
> >> +#define VP_SEQ_PRINTF(cnt)				 \
> >> +do {								 \
> >> +	if (pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]) \
> >> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> >> +			pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]); \
> >> +	else \
> >> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> >> +			pstats[HV_STATS_AREA_PARENT]->vp_cntrs[Vp##cnt]); \
> >> +} while (0)
> >
> > I don't understand this logic. Like in mshv_vp_dispatch_thread_blocked(=
), if
> > the SELF value is zero, then the PARENT value is used. The implication =
is that
> > you never want to display a SELF value of zero, which is a bit unexpect=
ed
> > since I could imagine zero being valid for some counters. But the overa=
ll result
> > is that the displayed values may be a mix of SELF and PARENT values.
>=20
> Yes, the basic idea is: Display a nonzero value, if there is one on eithe=
r SELF or
> PARENT pages. (I *think* the values will always be the same if they are n=
onzero.)
>=20
> I admit it's not an ideal design from my perspective. As far as I know, i=
t was
> done this way to retain backward compatibility with hypervisors that don'=
t support
> the concept of a PARENT stats area at all.
>=20
> > And of course after Patch 1 of this series, if running on an older hype=
rvisor
> > that doesn't provide PARENT, then SELF will be used anyway, which furth=
er
> > muddies what's going on here, at least for me. :-)
> >
>=20
> Yes, but in the end we need to check both pages, so there's no avoiding t=
his
> redundant check on old hypervisors without adding a separate code path ju=
st for
> that case, which doesn't seem worth it.
>=20
> > If this is the correct behavior, please add some code comments as to
> > why it makes sense, including in the case where PARENT isn't available.
> >
>=20
> Ok, will do.
>=20
> >> +
> >> +	VP_SEQ_PRINTF(TotalRunTime);
> >> +	VP_SEQ_PRINTF(HypervisorRunTime);
> >> +	VP_SEQ_PRINTF(RemoteNodeRunTime);
> >> +	VP_SEQ_PRINTF(NormalizedRunTime);
> >> +	VP_SEQ_PRINTF(IdealCpu);
> >> +	VP_SEQ_PRINTF(HypercallsCount);
> >> +	VP_SEQ_PRINTF(HypercallsTime);
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	VP_SEQ_PRINTF(PageInvalidationsCount);
> >> +	VP_SEQ_PRINTF(PageInvalidationsTime);
> >> +	VP_SEQ_PRINTF(ControlRegisterAccessesCount);
> >> +	VP_SEQ_PRINTF(ControlRegisterAccessesTime);
> >> +	VP_SEQ_PRINTF(IoInstructionsCount);
> >> +	VP_SEQ_PRINTF(IoInstructionsTime);
> >> +	VP_SEQ_PRINTF(HltInstructionsCount);
> >> +	VP_SEQ_PRINTF(HltInstructionsTime);
> >> +	VP_SEQ_PRINTF(MwaitInstructionsCount);
> >> +	VP_SEQ_PRINTF(MwaitInstructionsTime);
> >> +	VP_SEQ_PRINTF(CpuidInstructionsCount);
> >> +	VP_SEQ_PRINTF(CpuidInstructionsTime);
> >> +	VP_SEQ_PRINTF(MsrAccessesCount);
> >> +	VP_SEQ_PRINTF(MsrAccessesTime);
> >> +	VP_SEQ_PRINTF(OtherInterceptsCount);
> >> +	VP_SEQ_PRINTF(OtherInterceptsTime);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsCount);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsTime);
> >> +	VP_SEQ_PRINTF(PendingInterruptsCount);
> >> +	VP_SEQ_PRINTF(PendingInterruptsTime);
> >> +	VP_SEQ_PRINTF(EmulatedInstructionsCount);
> >> +	VP_SEQ_PRINTF(EmulatedInstructionsTime);
> >> +	VP_SEQ_PRINTF(DebugRegisterAccessesCount);
> >> +	VP_SEQ_PRINTF(DebugRegisterAccessesTime);
> >> +	VP_SEQ_PRINTF(PageFaultInterceptsCount);
> >> +	VP_SEQ_PRINTF(PageFaultInterceptsTime);
> >> +	VP_SEQ_PRINTF(GuestPageTableMaps);
> >> +	VP_SEQ_PRINTF(LargePageTlbFills);
> >> +	VP_SEQ_PRINTF(SmallPageTlbFills);
> >> +	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
> >> +	VP_SEQ_PRINTF(ApicMmioAccesses);
> >> +	VP_SEQ_PRINTF(IoInterceptMessages);
> >> +	VP_SEQ_PRINTF(MemoryInterceptMessages);
> >> +	VP_SEQ_PRINTF(ApicEoiAccesses);
> >> +	VP_SEQ_PRINTF(OtherMessages);
> >> +	VP_SEQ_PRINTF(PageTableAllocations);
> >> +	VP_SEQ_PRINTF(LogicalProcessorMigrations);
> >> +	VP_SEQ_PRINTF(AddressSpaceEvictions);
> >> +	VP_SEQ_PRINTF(AddressSpaceSwitches);
> >> +	VP_SEQ_PRINTF(AddressDomainFlushes);
> >> +	VP_SEQ_PRINTF(AddressSpaceFlushes);
> >> +	VP_SEQ_PRINTF(GlobalGvaRangeFlushes);
> >> +	VP_SEQ_PRINTF(LocalGvaRangeFlushes);
> >> +	VP_SEQ_PRINTF(PageTableEvictions);
> >> +	VP_SEQ_PRINTF(PageTableReclamations);
> >> +	VP_SEQ_PRINTF(PageTableResets);
> >> +	VP_SEQ_PRINTF(PageTableValidations);
> >> +	VP_SEQ_PRINTF(ApicTprAccesses);
> >> +	VP_SEQ_PRINTF(PageTableWriteIntercepts);
> >> +	VP_SEQ_PRINTF(SyntheticInterrupts);
> >> +	VP_SEQ_PRINTF(VirtualInterrupts);
> >> +	VP_SEQ_PRINTF(ApicIpisSent);
> >> +	VP_SEQ_PRINTF(ApicSelfIpisSent);
> >> +	VP_SEQ_PRINTF(GpaSpaceHypercalls);
> >> +	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
> >> +	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
> >> +	VP_SEQ_PRINTF(OtherHypercalls);
> >> +	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualMmuHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
> >> +	VP_SEQ_PRINTF(HardwareInterrupts);
> >> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
> >> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
> >> +	VP_SEQ_PRINTF(PageScans);
> >> +	VP_SEQ_PRINTF(LogicalProcessorDispatches);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTime);
> >> +	VP_SEQ_PRINTF(ExtendedHypercalls);
> >> +	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
> >> +	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
> >> +	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
> >> +	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
> >> +	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
> >> +	VP_SEQ_PRINTF(LocalIoTlbFlushes);
> >> +	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
> >> +	VP_SEQ_PRINTF(HypercallsForwardedCount);
> >> +	VP_SEQ_PRINTF(HypercallsForwardingTime);
> >> +	VP_SEQ_PRINTF(PageInvalidationsForwardedCount);
> >> +	VP_SEQ_PRINTF(PageInvalidationsForwardingTime);
> >> +	VP_SEQ_PRINTF(ControlRegisterAccessesForwardedCount);
> >> +	VP_SEQ_PRINTF(ControlRegisterAccessesForwardingTime);
> >> +	VP_SEQ_PRINTF(IoInstructionsForwardedCount);
> >> +	VP_SEQ_PRINTF(IoInstructionsForwardingTime);
> >> +	VP_SEQ_PRINTF(HltInstructionsForwardedCount);
> >> +	VP_SEQ_PRINTF(HltInstructionsForwardingTime);
> >> +	VP_SEQ_PRINTF(MwaitInstructionsForwardedCount);
> >> +	VP_SEQ_PRINTF(MwaitInstructionsForwardingTime);
> >> +	VP_SEQ_PRINTF(CpuidInstructionsForwardedCount);
> >> +	VP_SEQ_PRINTF(CpuidInstructionsForwardingTime);
> >> +	VP_SEQ_PRINTF(MsrAccessesForwardedCount);
> >> +	VP_SEQ_PRINTF(MsrAccessesForwardingTime);
> >> +	VP_SEQ_PRINTF(OtherInterceptsForwardedCount);
> >> +	VP_SEQ_PRINTF(OtherInterceptsForwardingTime);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsForwardedCount);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsForwardingTime);
> >> +	VP_SEQ_PRINTF(PendingInterruptsForwardedCount);
> >> +	VP_SEQ_PRINTF(PendingInterruptsForwardingTime);
> >> +	VP_SEQ_PRINTF(EmulatedInstructionsForwardedCount);
> >> +	VP_SEQ_PRINTF(EmulatedInstructionsForwardingTime);
> >> +	VP_SEQ_PRINTF(DebugRegisterAccessesForwardedCount);
> >> +	VP_SEQ_PRINTF(DebugRegisterAccessesForwardingTime);
> >> +	VP_SEQ_PRINTF(PageFaultInterceptsForwardedCount);
> >> +	VP_SEQ_PRINTF(PageFaultInterceptsForwardingTime);
> >> +	VP_SEQ_PRINTF(VmclearEmulationCount);
> >> +	VP_SEQ_PRINTF(VmclearEmulationTime);
> >> +	VP_SEQ_PRINTF(VmptrldEmulationCount);
> >> +	VP_SEQ_PRINTF(VmptrldEmulationTime);
> >> +	VP_SEQ_PRINTF(VmptrstEmulationCount);
> >> +	VP_SEQ_PRINTF(VmptrstEmulationTime);
> >> +	VP_SEQ_PRINTF(VmreadEmulationCount);
> >> +	VP_SEQ_PRINTF(VmreadEmulationTime);
> >> +	VP_SEQ_PRINTF(VmwriteEmulationCount);
> >> +	VP_SEQ_PRINTF(VmwriteEmulationTime);
> >> +	VP_SEQ_PRINTF(VmxoffEmulationCount);
> >> +	VP_SEQ_PRINTF(VmxoffEmulationTime);
> >> +	VP_SEQ_PRINTF(VmxonEmulationCount);
> >> +	VP_SEQ_PRINTF(VmxonEmulationTime);
> >> +	VP_SEQ_PRINTF(NestedVMEntriesCount);
> >> +	VP_SEQ_PRINTF(NestedVMEntriesTime);
> >> +	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsCount);
> >> +	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsTime);
> >> +	VP_SEQ_PRINTF(NestedSLATHardPageFaultsCount);
> >> +	VP_SEQ_PRINTF(NestedSLATHardPageFaultsTime);
> >> +	VP_SEQ_PRINTF(InvEptAllContextEmulationCount);
> >> +	VP_SEQ_PRINTF(InvEptAllContextEmulationTime);
> >> +	VP_SEQ_PRINTF(InvEptSingleContextEmulationCount);
> >> +	VP_SEQ_PRINTF(InvEptSingleContextEmulationTime);
> >> +	VP_SEQ_PRINTF(InvVpidAllContextEmulationCount);
> >> +	VP_SEQ_PRINTF(InvVpidAllContextEmulationTime);
> >> +	VP_SEQ_PRINTF(InvVpidSingleContextEmulationCount);
> >> +	VP_SEQ_PRINTF(InvVpidSingleContextEmulationTime);
> >> +	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationCount);
> >> +	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationTime);
> >> +	VP_SEQ_PRINTF(NestedTlbPageTableReclamations);
> >> +	VP_SEQ_PRINTF(NestedTlbPageTableEvictions);
> >> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
> >> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
> >> +	VP_SEQ_PRINTF(PostedInterruptNotifications);
> >> +	VP_SEQ_PRINTF(PostedInterruptScans);
> >> +	VP_SEQ_PRINTF(TotalCoreRunTime);
> >> +	VP_SEQ_PRINTF(MaximumRunTime);
> >> +	VP_SEQ_PRINTF(HwpRequestContextSwitches);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
> >> +	VP_SEQ_PRINTF(VmloadEmulationCount);
> >> +	VP_SEQ_PRINTF(VmloadEmulationTime);
> >> +	VP_SEQ_PRINTF(VmsaveEmulationCount);
> >> +	VP_SEQ_PRINTF(VmsaveEmulationTime);
> >> +	VP_SEQ_PRINTF(GifInstructionEmulationCount);
> >> +	VP_SEQ_PRINTF(GifInstructionEmulationTime);
> >> +	VP_SEQ_PRINTF(EmulatedErrataSvmInstructions);
> >> +	VP_SEQ_PRINTF(Placeholder1);
> >> +	VP_SEQ_PRINTF(Placeholder2);
> >> +	VP_SEQ_PRINTF(Placeholder3);
> >> +	VP_SEQ_PRINTF(Placeholder4);
> >> +	VP_SEQ_PRINTF(Placeholder5);
> >> +	VP_SEQ_PRINTF(Placeholder6);
> >> +	VP_SEQ_PRINTF(Placeholder7);
> >> +	VP_SEQ_PRINTF(Placeholder8);
> >> +	VP_SEQ_PRINTF(Placeholder9);
> >> +	VP_SEQ_PRINTF(Placeholder10);
> >> +	VP_SEQ_PRINTF(SchedulingPriority);
> >> +	VP_SEQ_PRINTF(RdpmcInstructionsCount);
> >> +	VP_SEQ_PRINTF(RdpmcInstructionsTime);
> >> +	VP_SEQ_PRINTF(PerfmonPmuMsrAccessesCount);
> >> +	VP_SEQ_PRINTF(PerfmonLbrMsrAccessesCount);
> >> +	VP_SEQ_PRINTF(PerfmonIptMsrAccessesCount);
> >> +	VP_SEQ_PRINTF(PerfmonInterruptCount);
> >> +	VP_SEQ_PRINTF(Vtl1DispatchCount);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchCount);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
> >> +	VP_SEQ_PRINTF(Vtl1RunTime);
> >> +	VP_SEQ_PRINTF(Vtl2RunTime);
> >> +	VP_SEQ_PRINTF(IommuHypercalls);
> >> +	VP_SEQ_PRINTF(CpuGroupHypercalls);
> >> +	VP_SEQ_PRINTF(VsmHypercalls);
> >> +	VP_SEQ_PRINTF(EventLogHypercalls);
> >> +	VP_SEQ_PRINTF(DeviceDomainHypercalls);
> >> +	VP_SEQ_PRINTF(DepositHypercalls);
> >> +	VP_SEQ_PRINTF(SvmHypercalls);
> >> +	VP_SEQ_PRINTF(BusLockAcquisitionCount);
> >
> > The x86 VpUnused counter is not shown. Any reason for that? All the
> > Placeholder counters *are* shown, so I'm just wondering what's
> > different.
> >
>=20
> Good question, I believe when this code was written VpUnused was
> actually undefined in our headers, because the value 201 was
> temporarily used for VpRootDispatchThreadBlocked before that was
> changed to 202 (the hypervisor version using 201 was never released
> publically so not considered a breaking change).
>=20
> Checking the code, 201 now refers to VpLoadAvg on x86 so I will
> update the definitions in patch #2 of this series to include that,
> and add it here in the debugfs code.
>=20
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	VP_SEQ_PRINTF(SysRegAccessesCount);
> >> +	VP_SEQ_PRINTF(SysRegAccessesTime);
> >> +	VP_SEQ_PRINTF(SmcInstructionsCount);
> >> +	VP_SEQ_PRINTF(SmcInstructionsTime);
> >> +	VP_SEQ_PRINTF(OtherInterceptsCount);
> >> +	VP_SEQ_PRINTF(OtherInterceptsTime);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsCount);
> >> +	VP_SEQ_PRINTF(ExternalInterruptsTime);
> >> +	VP_SEQ_PRINTF(PendingInterruptsCount);
> >> +	VP_SEQ_PRINTF(PendingInterruptsTime);
> >> +	VP_SEQ_PRINTF(GuestPageTableMaps);
> >> +	VP_SEQ_PRINTF(LargePageTlbFills);
> >> +	VP_SEQ_PRINTF(SmallPageTlbFills);
> >> +	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
> >> +	VP_SEQ_PRINTF(MemoryInterceptMessages);
> >> +	VP_SEQ_PRINTF(OtherMessages);
> >> +	VP_SEQ_PRINTF(LogicalProcessorMigrations);
> >> +	VP_SEQ_PRINTF(AddressDomainFlushes);
> >> +	VP_SEQ_PRINTF(AddressSpaceFlushes);
> >> +	VP_SEQ_PRINTF(SyntheticInterrupts);
> >> +	VP_SEQ_PRINTF(VirtualInterrupts);
> >> +	VP_SEQ_PRINTF(ApicSelfIpisSent);
> >> +	VP_SEQ_PRINTF(GpaSpaceHypercalls);
> >> +	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
> >> +	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
> >> +	VP_SEQ_PRINTF(OtherHypercalls);
> >> +	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualMmuHypercalls);
> >> +	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
> >> +	VP_SEQ_PRINTF(HardwareInterrupts);
> >> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
> >> +	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
> >> +	VP_SEQ_PRINTF(LogicalProcessorDispatches);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTime);
> >> +	VP_SEQ_PRINTF(ExtendedHypercalls);
> >> +	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
> >> +	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
> >> +	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
> >> +	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
> >> +	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
> >> +	VP_SEQ_PRINTF(LocalIoTlbFlushes);
> >> +	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
> >> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
> >> +	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
> >> +	VP_SEQ_PRINTF(PostedInterruptNotifications);
> >> +	VP_SEQ_PRINTF(PostedInterruptScans);
> >> +	VP_SEQ_PRINTF(TotalCoreRunTime);
> >> +	VP_SEQ_PRINTF(MaximumRunTime);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
> >> +	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
> >> +	VP_SEQ_PRINTF(HwpRequestContextSwitches);
> >> +	VP_SEQ_PRINTF(Placeholder2);
> >> +	VP_SEQ_PRINTF(Placeholder3);
> >> +	VP_SEQ_PRINTF(Placeholder4);
> >> +	VP_SEQ_PRINTF(Placeholder5);
> >> +	VP_SEQ_PRINTF(Placeholder6);
> >> +	VP_SEQ_PRINTF(Placeholder7);
> >> +	VP_SEQ_PRINTF(Placeholder8);
> >> +	VP_SEQ_PRINTF(ContentionTime);
> >> +	VP_SEQ_PRINTF(WakeUpTime);
> >> +	VP_SEQ_PRINTF(SchedulingPriority);
> >> +	VP_SEQ_PRINTF(Vtl1DispatchCount);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchCount);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
> >> +	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
> >> +	VP_SEQ_PRINTF(Vtl1RunTime);
> >> +	VP_SEQ_PRINTF(Vtl2RunTime);
> >> +	VP_SEQ_PRINTF(IommuHypercalls);
> >> +	VP_SEQ_PRINTF(CpuGroupHypercalls);
> >> +	VP_SEQ_PRINTF(VsmHypercalls);
> >> +	VP_SEQ_PRINTF(EventLogHypercalls);
> >> +	VP_SEQ_PRINTF(DeviceDomainHypercalls);
> >> +	VP_SEQ_PRINTF(DepositHypercalls);
> >> +	VP_SEQ_PRINTF(SvmHypercalls);
> >
> > The ARM64 VpLoadAvg counter is not shown?  Any reason why?
> >
>=20
> I'm not sure, but could be related to the reasoning in the above
> comment - likely VpLoadAvg didn't exist before. I will add it.
>=20
> >> +#endif
> >
> > The VpRootDispatchThreadBlocked counter is not shown for either
> > x86 or ARM64. Is that intentional, and if so, why? I know the counter
> > is used in mshv_vp_dispatch_thread_blocked(), but it's not clear why
> > that means it shouldn't be shown here.
> >
>=20
> VpRootDispatchThreadBlocked is not really a 'stat' that you might want
> to expose like the other values, it's really a boolean control value
> that was tacked onto the vp stats page to facilitate fast interrupt
> injection used by the root scheduler. As such it isn't of much value to
> userspace.

I'd probably show it just for completeness and consistency, but I
don't have strong views on the topic.

>=20
> >> +
> >> +	return 0;
> >> +}
> >
> > This function, vp_stats_show(), seems like a candidate for redoing base=
d on a
> > static table that lists the counter names and index. Then the code just=
 loops
> > through the table. On x86 each VP_SEQ_PRINTF() generates 42 bytes of co=
de,
> > and there are 199 entries, so 8358 bytes. The table entries would proba=
bly
> > be 16 bytes each (a 64-bit pointer to the string constant, a 32-bit ind=
ex value,
> > and 4 bytes of padding so each entry is 8-byte aligned). The actual spa=
ce
> > saving isn't that large, but the code would be a lot more compact. The
> > other *_stats_shows() functions could do the same.
> >
> > It's distasteful to me to see 420 lines of enum entries in Patch 2 of t=
his series,
> > then followed by another 420 lines of matching *_SEQ_PRINTF entries. Bu=
t I
> > realize that the goal of the enum entries is to match the Windows code,=
 so I
> > guess it is what it is. But there's an argument for ditching the enum e=
ntries
> > entirely, and using the putative static table to capture the informatio=
n. It
> > doesn't seem like matching the Windows code is saving much sync effort
> > since any additions/ subtractions to the enum entries need to be matche=
d
> > with changes in the *_stats_show() functions, or in my putative static =
table.
> > But I guess if Windows changed only the value for an enum entry without
> > additions/subtractions, that would sync more easily.
> >
>=20
> Keeping the definitions as close to Windows code as possible is a high pr=
iority,
> for consistency and hopefully partially automating that process in future=
. So,
> I'm against throwing away the enum values. The downside of having to upda=
te
> two code locations when adding a new enum member is fine by me.
>=20
> I'm not against replacing this sequence of macros with a loop over a tabl=
e like
> the one you propose (in addition to keeping the enum values). That would =
save
> some space as you point out above, but the impact is fairly minimal.
>=20
> In terms of aesthetics the definition for a table will look very very sim=
ilar to
> the list of VP_SEQ_PRINTF() that are currently here. So all in all, I don=
't see
> a strong reason to switch to a table, unless the space issue is more impo=
rtant
> that I realize.
>=20
> > I'm just throwing this out as a thought. You may prefer to keep everyth=
ing
> > "as is", in which case ignore my comment and I won't raise it again.
> >
>=20
> Thanks, feel free to follow up if you have further thoughts on this part,=
 I'm
> open to changing it if there's a reason. Right now it feels like mainly a=
n
> aesthetics/cleanliness argument and I'm not sure it's worth the effort.

No further thoughts. I wanted to broach the idea, but I'm fine with
your judgment.

>=20
> >> +DEFINE_SHOW_ATTRIBUTE(vp_stats);
> >> +
> >> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index, void =
*stats_page_addr,
> >> +				enum hv_stats_area_type stats_area_type)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.vp.partition_id =3D partition_id,
> >> +		.vp.vp_index =3D vp_index,
> >> +		.vp.stats_area_type =3D stats_area_type,
> >> +	};
> >> +	int err;
> >> +
> >> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_VP, stats_page_addr, &id=
entity);
> >> +	if (err)
> >> +		pr_err("%s: failed to unmap partition %llu vp %u %s stats, err: %d\=
n",
> >> +		       __func__, partition_id, vp_index,
> >> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "pare=
nt",
> >> +		       err);
> >> +}
> >> +
> >> +static void *mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> >> +			       enum hv_stats_area_type stats_area_type)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.vp.partition_id =3D partition_id,
> >> +		.vp.vp_index =3D vp_index,
> >> +		.vp.stats_area_type =3D stats_area_type,
> >> +	};
> >> +	void *stats;
> >> +	int err;
> >> +
> >> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity, &stats);
> >> +	if (err) {
> >> +		pr_err("%s: failed to map partition %llu vp %u %s stats, err: %d\n"=
,
> >> +		       __func__, partition_id, vp_index,
> >> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "pare=
nt",
> >> +		       err);
> >> +		return ERR_PTR(err);
> >> +	}
> >> +	return stats;
> >> +}
> >
> > Presumably you've noticed that the functions mshv_vp_stats_map() and
> > mshv_vp_stats_unmap() also exist in mshv_root_main.c.  They are static
> > functions in both places, so the compiler & linker do the right thing, =
but
> > it sure does make things a bit more complex for human readers. The vers=
ions
> > here follow a consistent pattern for (lp, vp, hv, partition), so maybe =
the ones
> > in mshv_root_main.c could be renamed to avoid confusion?
> >
>=20
> Good point - this is being addressed in our internal tree but hasn't made=
 it into
> this patch set. I will consider squashing that into a later version of th=
is set,
> but for now I'm treating it as a future cleanup patch to send later.

OK

>=20
> >> +
> >> +static int vp_debugfs_stats_create(u64 partition_id, u32 vp_index,
> >> +				   struct dentry **vp_stats_ptr,
> >> +				   struct dentry *parent)
> >> +{
> >> +	struct dentry *dentry;
> >> +	struct hv_stats_page **pstats;
> >> +	int err;
> >> +
> >> +	pstats =3D kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACC=
OUNT);
> >
> > Open coding "2" as the first parameter makes assumptions about the valu=
es of
> > HV_STATS_AREA_SELF and HV_STATS_AREA_PARENT.  Should use
> > HV_STATS_AREA_COUNT instead of "2" so that indexing into the array is c=
ertain
> > to work.
> >
>=20
> Thanks, I'll chang it to use HV_STATS_AREA_COUNT.
>=20
> >> +	if (!pstats)
> >> +		return -ENOMEM;
> >> +
> >> +	pstats[HV_STATS_AREA_SELF] =3D mshv_vp_stats_map(partition_id, vp_in=
dex,
> >> +						       HV_STATS_AREA_SELF);
> >> +	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
> >> +		err =3D PTR_ERR(pstats[HV_STATS_AREA_SELF]);
> >> +		goto cleanup;
> >> +	}
> >> +
> >> +	/*
> >> +	 * L1VH partition cannot access its vp stats in parent area.
> >> +	 */
> >> +	if (is_l1vh_parent(partition_id)) {
> >> +		pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> >> +	} else {
> >> +		pstats[HV_STATS_AREA_PARENT] =3D mshv_vp_stats_map(
> >> +			partition_id, vp_index, HV_STATS_AREA_PARENT);
> >> +		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
> >> +			err =3D PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
> >> +			goto unmap_self;
> >> +		}
> >> +		if (!pstats[HV_STATS_AREA_PARENT])
> >> +			pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> >> +	}
> >> +
> >> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> >> +				     pstats, &vp_stats_fops);
> >> +	if (IS_ERR(dentry)) {
> >> +		err =3D PTR_ERR(dentry);
> >> +		goto unmap_vp_stats;
> >> +	}
> >> +
> >> +	*vp_stats_ptr =3D dentry;
> >> +	return 0;
> >> +
> >> +unmap_vp_stats:
> >> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF])
> >> +		mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_PA=
RENT],
> >> +				    HV_STATS_AREA_PARENT);
> >> +unmap_self:
> >> +	mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_SEL=
F],
> >> +			    HV_STATS_AREA_SELF);
> >> +cleanup:
> >> +	kfree(pstats);
> >> +	return err;
> >> +}
> >> +
> >> +static void vp_debugfs_remove(u64 partition_id, u32 vp_index,
> >> +			      struct dentry *vp_stats)
> >> +{
> >> +	struct hv_stats_page **pstats =3D NULL;
> >> +	void *stats;
> >> +
> >> +	pstats =3D vp_stats->d_inode->i_private;
> >> +	debugfs_remove_recursive(vp_stats->d_parent);
> >> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF]) {
> >> +		stats =3D pstats[HV_STATS_AREA_PARENT];
> >> +		mshv_vp_stats_unmap(partition_id, vp_index, stats,
> >> +				    HV_STATS_AREA_PARENT);
> >> +	}
> >> +
> >> +	stats =3D pstats[HV_STATS_AREA_SELF];
> >> +	mshv_vp_stats_unmap(partition_id, vp_index, stats, HV_STATS_AREA_SEL=
F);
> >> +
> >> +	kfree(pstats);
> >> +}
> >> +
> >> +static int vp_debugfs_create(u64 partition_id, u32 vp_index,
> >> +			     struct dentry **vp_stats_ptr,
> >> +			     struct dentry *parent)
> >> +{
> >> +	struct dentry *vp_idx_dir;
> >> +	char vp_idx_str[U32_BUF_SZ];
> >> +	int err;
> >> +
> >> +	sprintf(vp_idx_str, "%u", vp_index);
> >> +
> >> +	vp_idx_dir =3D debugfs_create_dir(vp_idx_str, parent);
> >> +	if (IS_ERR(vp_idx_dir))
> >> +		return PTR_ERR(vp_idx_dir);
> >> +
> >> +	err =3D vp_debugfs_stats_create(partition_id, vp_index, vp_stats_ptr=
,
> >> +				      vp_idx_dir);
> >> +	if (err)
> >> +		goto remove_debugfs_vp_idx;
> >> +
> >> +	return 0;
> >> +
> >> +remove_debugfs_vp_idx:
> >> +	debugfs_remove_recursive(vp_idx_dir);
> >> +	return err;
> >> +}
> >> +
> >> +static int partition_stats_show(struct seq_file *m, void *v)
> >> +{
> >> +	const struct hv_stats_page **pstats =3D m->private;
> >> +
> >> +#define PARTITION_SEQ_PRINTF(cnt)				 \
> >> +do {								 \
> >> +	if (pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]) \
> >> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> >> +			pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]); \
> >> +	else \
> >> +		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
> >> +			pstats[HV_STATS_AREA_PARENT]->pt_cntrs[Partition##cnt]); \
> >> +} while (0)
> >
> > Same comment as for VP_SEQ_PRINTF.
> >
> Ack
>=20
> >> +
> >> +	PARTITION_SEQ_PRINTF(VirtualProcessors);
> >> +	PARTITION_SEQ_PRINTF(TlbSize);
> >> +	PARTITION_SEQ_PRINTF(AddressSpaces);
> >> +	PARTITION_SEQ_PRINTF(DepositedPages);
> >> +	PARTITION_SEQ_PRINTF(GpaPages);
> >> +	PARTITION_SEQ_PRINTF(GpaSpaceModifications);
> >> +	PARTITION_SEQ_PRINTF(VirtualTlbFlushEntires);
> >> +	PARTITION_SEQ_PRINTF(RecommendedTlbSize);
> >> +	PARTITION_SEQ_PRINTF(GpaPages4K);
> >> +	PARTITION_SEQ_PRINTF(GpaPages2M);
> >> +	PARTITION_SEQ_PRINTF(GpaPages1G);
> >> +	PARTITION_SEQ_PRINTF(GpaPages512G);
> >> +	PARTITION_SEQ_PRINTF(DevicePages4K);
> >> +	PARTITION_SEQ_PRINTF(DevicePages2M);
> >> +	PARTITION_SEQ_PRINTF(DevicePages1G);
> >> +	PARTITION_SEQ_PRINTF(DevicePages512G);
> >> +	PARTITION_SEQ_PRINTF(AttachedDevices);
> >> +	PARTITION_SEQ_PRINTF(DeviceInterruptMappings);
> >> +	PARTITION_SEQ_PRINTF(IoTlbFlushes);
> >> +	PARTITION_SEQ_PRINTF(IoTlbFlushCost);
> >> +	PARTITION_SEQ_PRINTF(DeviceInterruptErrors);
> >> +	PARTITION_SEQ_PRINTF(DeviceDmaErrors);
> >> +	PARTITION_SEQ_PRINTF(DeviceInterruptThrottleEvents);
> >> +	PARTITION_SEQ_PRINTF(SkippedTimerTicks);
> >> +	PARTITION_SEQ_PRINTF(PartitionId);
> >> +#if IS_ENABLED(CONFIG_X86_64)
> >> +	PARTITION_SEQ_PRINTF(NestedTlbSize);
> >> +	PARTITION_SEQ_PRINTF(RecommendedNestedTlbSize);
> >> +	PARTITION_SEQ_PRINTF(NestedTlbFreeListSize);
> >> +	PARTITION_SEQ_PRINTF(NestedTlbTrimmedPages);
> >> +	PARTITION_SEQ_PRINTF(PagesShattered);
> >> +	PARTITION_SEQ_PRINTF(PagesRecombined);
> >> +	PARTITION_SEQ_PRINTF(HwpRequestValue);
> >> +#elif IS_ENABLED(CONFIG_ARM64)
> >> +	PARTITION_SEQ_PRINTF(HwpRequestValue);
> >> +#endif
> >> +
> >> +	return 0;
> >> +}
> >> +DEFINE_SHOW_ATTRIBUTE(partition_stats);
> >> +
> >> +static void mshv_partition_stats_unmap(u64 partition_id, void *stats_=
page_addr,
> >> +				       enum hv_stats_area_type stats_area_type)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.partition.partition_id =3D partition_id,
> >> +		.partition.stats_area_type =3D stats_area_type,
> >> +	};
> >> +	int err;
> >> +
> >> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_PARTITION, stats_page_ad=
dr,
> >> +				  &identity);
> >> +	if (err) {
> >> +		pr_err("%s: failed to unmap partition %lld %s stats, err: %d\n",
> >> +		       __func__, partition_id,
> >> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "pare=
nt",
> >> +		       err);
> >> +	}
> >> +}
> >> +
> >> +static void *mshv_partition_stats_map(u64 partition_id,
> >> +				      enum hv_stats_area_type stats_area_type)
> >> +{
> >> +	union hv_stats_object_identity identity =3D {
> >> +		.partition.partition_id =3D partition_id,
> >> +		.partition.stats_area_type =3D stats_area_type,
> >> +	};
> >> +	void *stats;
> >> +	int err;
> >> +
> >> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_PARTITION, &identity, &sta=
ts);
> >> +	if (err) {
> >> +		pr_err("%s: failed to map partition %lld %s stats, err: %d\n",
> >> +		       __func__, partition_id,
> >> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "pare=
nt",
> >> +		       err);
> >> +		return ERR_PTR(err);
> >> +	}
> >> +	return stats;
> >> +}
> >> +
> >> +static int mshv_debugfs_partition_stats_create(u64 partition_id,
> >> +					    struct dentry **partition_stats_ptr,
> >> +					    struct dentry *parent)
> >> +{
> >> +	struct dentry *dentry;
> >> +	struct hv_stats_page **pstats;
> >> +	int err;
> >> +
> >> +	pstats =3D kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACC=
OUNT);
> >
> > Same comment here about the use of "2" as the first parameter.
> >
> Ack.
>=20
> >> +	if (!pstats)
> >> +		return -ENOMEM;
>=20
> <snip>
> Thanks for the comments, I appreciate the review!
>=20
> Nuno

