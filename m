Return-Path: <linux-hyperv+bounces-11688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahw7Jk96PWoo3ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11688-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:58:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 069ED6C84C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:58:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=GOJoeHJh;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11688-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11688-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1F8300E26F
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F335332EC8;
	Thu, 25 Jun 2026 18:58:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012054.outbound.protection.outlook.com [52.103.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF167331222;
	Thu, 25 Jun 2026 18:58:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413900; cv=fail; b=bogG5O6aovN2Mz2vbfhGm7Vts4Saav2eqNnW2DmhqAsbE6CWhh8LWoYteHRKZtHZy0zwasQDVyv5ee/CQc2mQNZkWQe6VTLz3tyMcPvv28dPPD+YPQNy5yp7nGJ5hQPhUfRBD4F8wVZ4GUMfqPE9ecBoZYhLzQTMCgyZ1ABBve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413900; c=relaxed/simple;
	bh=ggleP9/r/bRAEWgIwGdKNKUN+8bPgLNhkc0TEKWDFvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H882XGO5zm1+SSlwBsQ4KIwp87Z10V22Amgv9a2C5gEUuUQhpE1iOepn5uOTmDzQ8xc8/h3KWv+S8ZxJM+lnBltDQRINd/DKOyiFDQoSG4KtRq1iTND+IZZ+0UL24NpZPcKUtLFHJ9DIYzp+MPsORc1R/UiuvQ819Sm51tyqWcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GOJoeHJh; arc=fail smtp.client-ip=52.103.20.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/RQvztpc/2D+PG4QjK5eGbQhRxCDHPbXNpNTQ7Jj3NhiCIQgIqBJsciGjpFAzmblJ6g7nLFyy4b2926bjnK0VsK1OyJ01j7NNoFPiShy45v9yLefopgZNE7UjkJ0j9FEU0EtUAEc7Lm19NwNADDzQo7pyTI1TiSZVwUu1XuGkjNuC5qwT+PpAXbO90y3EO6DdnvJs5o10nAqn5iCZC9Fl/21OQL1uVKjRlWxZVO5ZGsooLsODXkdzXU3KmAV7ETDRs53Vi2OzVCvG0bkKq1qvVDQvfZaLUR2tcCAsVFd/oBW36T4ebWDA5Nuqyg//0V581LHqINMdLcoZhQKe/6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZM9WkY2KHqaGXQATmZk0EOVpXhqPcnK1FqzyZATKC0=;
 b=AI/94v2qJ6EZQ4M3pHh2GeWxbxzHgwM2bg/04a7WMwPCE2SDRuxe6fumDgehqlc6jU9iNnRTmQu12g2qvkLQTXZxZ363P/RvVqORO+EeX837u83xpLgIcu986jM6e4T3dZRz9NQVTsm8/oD4OV2ZgsvM8dMSIMFmMf7TDfyyEcHG2IDjDFDzROQOqk0MjxmO+ahqmLqi4G3ZsFpH9E2Cjbw8wMU1URFEkwFpeEj/TQTfuC65Z6w4C79ptJVLnTW6t6XPALs1c2u9xPnCShe7AQf7bxwoJGl4Ngdo0ZjcqSZ6S2eAwdv0BeBEdmInj6W4u01l4NrxyYJ/24DoQO6fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZM9WkY2KHqaGXQATmZk0EOVpXhqPcnK1FqzyZATKC0=;
 b=GOJoeHJhGBPl6jFx00guadwfoO5fZtTZ6gqpgl+frHor646djpFVPzC2GqlY0jRNtRpiwPn7OpnKAxANRMJC+dKl3WVVaLimpTQ9gZH+jqk9P2otxG4HttW/cRXKHpkvokL0UGIbZItQRCmtZMVgaUnfu1XPP1BiUl85E9+EKDujVUiOWV5r0pPme/VNMqG3y/LO1DxaWelUowXwHPdXm9NAPLO0ErGBDY/YnxOohNF10ZOwWgM6/u+P+tVBVQXKryxnphBBOGkU9xW4KS5fI7HdzQ78lyBavyJtr/eakVtcI1KWOpRg7q0JeaTkTRUR8oI1iVK7NBeI91E2o3YjFg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV9PR02MB10808.namprd02.prod.outlook.com (2603:10b6:408:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:58:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 18:58:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v2 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Thread-Topic: [PATCH v2 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Thread-Index: AQHdBMj4HRUufFmw8UGpqHl8eYXAkrZPn5PA
Date: Thu, 25 Jun 2026 18:58:15 +0000
Message-ID:
 <SN6PR02MB4157D9A0C6527A896780EC63D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-4-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260625173500.1995481-4-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV9PR02MB10808:EE_
x-ms-office365-filtering-correlation-id: b710da2c-eb31-428e-f00c-08ded2ebb691
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AzK+WaIeeUeS+ykgs0qKzfWNg36GOH+OOsGwUKHZZ6McBqMe1gZk2uXCRm09cDei+EAMnCKoEin7D+D7klyqZCZxVIHphGAbAIT1cjA66NvvjYM9oxtLI6LIDNXT9n7l8/viyQICxwnfnWvRFRLVw+6Sfue1o6FwxamhgGnev6fJGrDywQUMbDgmI1V5xoQ+2ZuXdqLI2+LbBXetLEZAoATw0ir+p+u4RgWK70r7mVE92gPLmPgfnFyfHYUXTfnmYdIDvRRZ6fbN/LwDEwCAaipcMSr74uu9VkyMiHcdIPZgFfdr8/wvDZFcw4otopSjk/o3RbOP/fKyqxKRxy9h3OCTBPhKkfyD4TzMh9w8ak/TbKQa7BPtSwA4tsiY4/WcCV+QNxg21Cwwdu8kbo68rOmmcRhdTmpDCx3xzY8ANYr3/IQtwzjMNYqjNtAKruVk5pGpFujYDn+c7FzHkdKTPjEAw4vzU9796pvYf0j86qWTzAz+QgJwC/F4BuPf+rE8zkW1XPFT8zTkrMLvpsSkp51nLTVSmKLREoNZkw7xXkEWzqblHtbaw2xRIY6/M/6J866bAF6zeMAKS46zP5kHunzY4KOYOOhU+eYz9ddtW0EY9VOqtTgh3689trfKLsyP8/zurmXdqh/C65pD2cahqcfkhf9/prlWSvESbgKd1R+DhSqhQdsyPW/yKsEPGbv0Atxo9KN0hovuXlNOrqbS6sBsevOjFN3ojYpX0aFXtKB29qpBSwqPvOCA7/8+tRkPF
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|8062599012|19110799012|25010399006|41001999006|13091999003|51005399006|15080799012|19101099003|12121999013|37011999003|102099032|40105399003|3412199025|440099028|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M0X/14g61zI9eD+36GZ2GW+4SqvxohATpxAIA2F5wbC2svUq7R4FR7a2/aFu?=
 =?us-ascii?Q?RBQJPY6svhA0oTeG6Sa67TTwJ0edIp0r7WPNZ6X+orP1j+BmJwkZBKM3Josf?=
 =?us-ascii?Q?hFg7k4/QhvbQu+WQIuxxZSxsSycnftjsnUHT0b5qmA2yyxHo32cYOvh7EwKD?=
 =?us-ascii?Q?qVwLkP6mIVWkwpfNudrQkXbAUmEOsTUw0LVWvvx35/JoFK1ltnzFMld7K8bz?=
 =?us-ascii?Q?9S/Cz3qj+iqRiDSDXN/rMwcBKlBYTtEBZFh0IFcZmk7yBlrhSd4hZXqlIEAS?=
 =?us-ascii?Q?r8TLPB3sGq7q1TUcXF9v4YAhryFfJ2eYX15TxrrIby1N4ueoAdchcCNUO/t3?=
 =?us-ascii?Q?OlV6kQsoOQLNnRYabYAkQuWadNUoWss2U2HQMWbl2fcuNKrKEbdqIlF1v7c9?=
 =?us-ascii?Q?V28vvzuCeh+SZvAi4lmDF3LeG+KXKZU/VWYODdjcFOQPRF9ZW2LjVgMa18+m?=
 =?us-ascii?Q?OLVYXNwckIZQApTjVw/xtF4JpSggNCASHmGUGaqkqo9SZvYtjgBkunzH8qD0?=
 =?us-ascii?Q?8zOx2p7bBp5ZAuTqFc0kmZXz0k98v8zcqk37+5mTS6YmEXjfuUGdecq1SjCQ?=
 =?us-ascii?Q?DEYI5W7h6FXEGWkK7v7X1MhVt94YnOK8GF4YgPHkqyNXAEEl9swch1QNU2hW?=
 =?us-ascii?Q?8Ft0pvSvJF0peiZ+yDirRZ5TiR1Sp5GRR1D9yy/+s1ROYL9kKJPhxPBgutUm?=
 =?us-ascii?Q?rVDTe+C3/NBL4ezyYRO8AzKmJMhivMbo9611f9BInrVtivEk07oRayfq8jY1?=
 =?us-ascii?Q?8l+d00wZi+xTmipEkl1SXfD2HmH0yOJLqqrY7ZBGzkp3QVnJ4UfPlKa1Gl/4?=
 =?us-ascii?Q?3q3NfWN3X0zJE4txcCNIMynMfnYGVldMsHaG5yxeXszmKA3hPnjsA3PqBr9g?=
 =?us-ascii?Q?YSN9XpS38TrK+hN0SCZxkgkQA9aRfBQYpZjmv7DWe7LVULQRQYOfKua/Hz6P?=
 =?us-ascii?Q?Rw4LTGHKgrQbEuTnQl4E0056wprPPIi37Metyqjbl8PwrrZCQRhPymy2RDWn?=
 =?us-ascii?Q?z+5ksmf67jxB8ae01EkTgCXNvEuGUC82c095LEaWAv+drvjKLHtfg5V5PsEG?=
 =?us-ascii?Q?IV8JRDkKxzuQYuIqcPwUoAAVGkKvzKqsKQ6SX+ETr41NzwyJH9pzAU8zz47D?=
 =?us-ascii?Q?g+KQUN8lQD6L?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x77rZerZ5h4/VUKrCe3wbZ2a9C2oveAsh/xvYz8/UKe8A1cnU7COsBtHStlj?=
 =?us-ascii?Q?vaYYIGOeDnxYxtPWTZ/czmzEDAZuGQLm11ju7un/3OVi22hniDmfyx0yKMKl?=
 =?us-ascii?Q?AwWpWzPSMxyuiJ0qi1G7Y5SEtbZ9GJt5Gx2/NDl+1w2P8kT5DTZegGxYXfYO?=
 =?us-ascii?Q?pGk6Wq409AYUai8RB/JT3VMypW9m4qhDPUmzlrAY7KDC3CkMWJFjxaYfj5HH?=
 =?us-ascii?Q?wGH5AJKEoHX4fy+IGSUfJO7DfcqmnQ2S5I6IJkHGYjzUx9D0hlJDXBZd5FX4?=
 =?us-ascii?Q?QimddoUm3kptjlfJMYoRR+Pbydnsxl8xNlk0kqWINochn/7RXJNC3IzYMM0l?=
 =?us-ascii?Q?J/jocJZZzSmULwFistJJPLnT63DilEo13nLtGV+22yBOQUkrCoaP8QBQabGu?=
 =?us-ascii?Q?30UognkiagSr+wDd1+QInSQwrod/omLp51VUzqO0sMgW49rR08b0h/FQmWBn?=
 =?us-ascii?Q?Li/UZN41iifMtrB/FNr2asCDKHWdeF6BueZYgbiRV1MS7xYNWVJC1/wh0bs1?=
 =?us-ascii?Q?nSTAoN/LwLRu+eOrQmPRD7gEXx1mxMN8avA8e3AUjDT2BNxMEA+L4lj2WU67?=
 =?us-ascii?Q?Kmqkeg1nm02iPbhVaRtu1ktXvR3cwJHa37PSc7LMtqyuO5kmubzL5cdxp4u0?=
 =?us-ascii?Q?Na6rXN8mXlKzv46PMgSWyStu205lwqwEanqPk8/lb3zdy78dAYnnVh3epQJh?=
 =?us-ascii?Q?jH6ZOvisC1eeFEjmEJb/2DYXt7gCTxHwQVhSCMUfnvkR6jpsW8t6x7MC+vts?=
 =?us-ascii?Q?M65wImSpnYPylsHPb0OxqaYJCbINCHmTFoQJxI8s109/j6qeDq1Xix6WTy38?=
 =?us-ascii?Q?tFUHVfwPsucGaSqH7fsXqDSFsfmsH/faSD60azgOYs3/efPnq8rSBNWVwa2X?=
 =?us-ascii?Q?tFq7uNkqn1zaoKDFWxfZHod1idKpXJYmFQuNZahCVtHunuenuJ29c1M535k2?=
 =?us-ascii?Q?nuGTnpCwDtzmlM0xo7DgmT1/FRk8rqm/KzfG4BFrldvxaNTuYzDNrLmG7Nzv?=
 =?us-ascii?Q?RRoEbrZn7frokOQ9mZGlMCZZJub1FAZT9WuyIyH6/012iBxme1C3yEW9tTUr?=
 =?us-ascii?Q?hTJ5ZuQEMwmeHeLK5OtxFQCFOQQ2E0re5/JFh5dacKAJIYbjsW+1ap2qSpuc?=
 =?us-ascii?Q?OhVsyL3NECLt33Y+uvmuqa5bX0I23IZIGYRpWZND5XxOqklPycG+U6avpzdW?=
 =?us-ascii?Q?rl7jqdBG4/RTJF98eWNC2oyD4of/Ivyfzg+aAQUpbvJEIAhswsHAVKpm/NPx?=
 =?us-ascii?Q?ILlzvuk+DOuRNzvkOg5AC0rgYmUJT7gt9qTwhXpgTladFQl4DStcnsSzrAgb?=
 =?us-ascii?Q?rcAZNpQqDa/p7/wpNoqYiU/g4MHpJG9R1ZyF86f9e9egCUBcP9okQVhgfoe7?=
 =?us-ascii?Q?q5xkDag=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b710da2c-eb31-428e-f00c-08ded2ebb691
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 18:58:15.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB10808
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11688-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arndb.de:email,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 069ED6C84C0

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, June 2=
5, 2026 10:35 AM
> To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> decui@microsoft.com; longli@microsoft.com
> Cc: catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com;
> lpieralisi@kernel.org; sudeep.holla@kernel.org; arnd@arndb.de; thuth@redh=
at.com; linux-
> hyperv@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-arch@vger.kernel.org; mhklinux@outlook.com
> Subject: [PATCH v2 3/6] arm64: hyperv: Add per-CPU RSI host call infrastr=
ucture for CCA
> Realms
>=20
> Arm CCA Realms cannot issue Hyper-V hypercalls via HVC; the guest must
> route them through the RSI_HOST_CALL interface, which takes the IPA of a
> per-CPU rsi_host_call structure as its argument.
>=20
> Add hv_hostcall_array as a per-CPU struct array and allocate it during
> hyperv_init(). The allocation is gated on is_realm_world() so non-Realm
> arm64 Hyper-V guests pay no memory cost.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 32 ++++++++++++++++++++++++++++++-
>  arch/arm64/include/asm/mshyperv.h |  4 ++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..7d536d7fb557e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,10 +15,15 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/slab.h>
>  #include <asm/mshyperv.h>
> +#include <asm/rsi.h>
>=20
>  static bool hyperv_initialized;
>=20
> +struct rsi_host_call *hv_hostcall_array;
> +EXPORT_SYMBOL_GPL(hv_hostcall_array);
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> @@ -60,6 +65,12 @@ static bool __init hyperv_detect_via_acpi(void)
>=20
>  #endif
>=20
> +static void hv_hostcall_free(void)
> +{
> +	kfree(hv_hostcall_array);
> +	hv_hostcall_array =3D NULL;
> +}
> +
>  static bool __init hyperv_detect_via_smccc(void)
>  {
>  	uuid_t hyperv_uuid =3D UUID_INIT(
> @@ -85,6 +96,20 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>=20
> +	/*
> +	 * The RSI host-call buffers are only ever used when
> +	 * is_realm_world() is true. Skip the allocation on non-Realm
> +	 * guests. A single contiguous array of nr_cpu_ids entries is
> +	 * allocated; each CPU indexes into it by its processor ID.
> +	 */
> +	if (is_realm_world()) {
> +		hv_hostcall_array =3D kcalloc(nr_cpu_ids,
> +					    sizeof(struct rsi_host_call),
> +					    GFP_KERNEL);
> +		if (!hv_hostcall_array)
> +			return -ENOMEM;
> +	}
> +
>  	/* Setup the guest ID */
>  	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
> @@ -106,12 +131,13 @@ static int __init hyperv_init(void)
>=20
>  	ret =3D hv_common_init();
>  	if (ret)
> -		return ret;
> +		goto free_hostcall_mem;
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:on=
line",
>  				hv_common_cpu_init, hv_common_cpu_die);
>  	if (ret < 0) {
>  		hv_common_free();
> +		hv_hostcall_free();
>  		return ret;

Let me suggest a small additional simplification. For this error
path, call hv_common_free() as you have now, but then do
"goto free_hostcall_mem". At the free_hostcall_mem label, do

	kfree(hv_hostcall_array);
	hv_hostcall_array =3D NULL;

directly inline, and eliminate the hv_hostcall_free() helper
function. Saves about 5 lines of code overall and I think is a=20
bit simpler.

>  	}
>=20
> @@ -125,6 +151,10 @@ static int __init hyperv_init(void)
>=20
>  	hyperv_initialized =3D true;
>  	return 0;
> +
> +free_hostcall_mem:
> +	hv_hostcall_free();
> +	return ret;
>  }
>=20
>  early_initcall(hyperv_init);
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/m=
shyperv.h
> index b721d3134ab66..c207a3f79b99b 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -63,4 +63,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int re=
g)
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> +/* Per-CPU-indexed RSI host call structures for CCA Realms */
> +struct rsi_host_call;
> +extern struct rsi_host_call *hv_hostcall_array;
> +

The intent is that the #include of asm-generic/mshyperv.h should be
last in the arch-specific version of mshyperv.h. If there's a need to go
after the #include, that's a red flag to check if some restructuring of
the definitions would be appropriate.

Unless I'm missing something, I think these new definitions can go
above the #include.

Michael

>  #endif
> --
> 2.45.4
>=20


