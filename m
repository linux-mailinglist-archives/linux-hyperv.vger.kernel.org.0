Return-Path: <linux-hyperv+bounces-9875-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJVZE55PzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9875-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:02:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DC37E550
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DD130EB19D
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4540FD8F;
	Wed,  1 Apr 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S4EJdkJR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010018.outbound.protection.outlook.com [52.103.2.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BE3AEF5C;
	Wed,  1 Apr 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062622; cv=fail; b=YDb3xdGMm3vArT8oVOsVtt4VvOCbYG4C/yQBvzhOvKo8GM2wQOf4bXaCe3q8LqbJ4pclG+sfPeejuGoDLPwO+0AmtSfi6SkCMciyC6FtApb2WBbVYxMzPhWP9K5g+XFOYuLco7r4apURO12kJ/fxbNZEjz3uVOVjMjJx4GjNpzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062622; c=relaxed/simple;
	bh=1BD0sl0pBK0rM+Zx09yEwjMOm6fYqKA+e2yURGQ9x0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCvIxV37W5yb0+cvoBCukuStvxuugRj4hBkkgNar6lPfGLguXgYMdta/e7f/QYqmf6OajoxI9z3aFuru912PefIs014ey0rVulOOglMMfAStAl0D0RARHwQrrinMgOWjeCAlEVdYY7gdFVB6lZ/PFCVbzY6neW53x6H1SCpsUG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S4EJdkJR; arc=fail smtp.client-ip=52.103.2.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDGprBLYo5xZIFjpfBlWBD5f0ZrG13OG0wOrN5Z58nqHAfTGl/Of5M93FZiDYYAJS2dP5p+ZCZYX1HZG/y4TqbrdiZgef/6vSvqMbO1nIt48hV0lsADoSsZQtofL7p80M+Pl8T6x8ErKfEJFdbmQGeidKW1X+M5JuvLtHYYuujplLx+wLYZgPmHPaU9x5/DoblSyLK0AvIm4K4UAmYBIe9lgxCKRga3KfsMnp1gUfYrNy1R60WRmYsDHJS9EISgq3P6rLI69+xRJpdi1+TwBRD3F2K/MY2qm4Z31peLNlx5rQKcxV6M6UH6AorRRnLlyuOl0NdU8ZFmXwlyQ6rWuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghbt2VdipRb8TFXGc6+GiKsJdIAO++j4XglnEhSRYYo=;
 b=UVI1uzM3Meu5cFjhOQG9+zvm27M+IogDGoaG3/Puo4FxSGOUms/9+WaEJNS5fAJo3PL5dRB1T+hOhQ4BbRRaEKIdRrmQZHWT5AmaChsXN2p4D2puTNDo+YN8Fej7R4B5CrA9tTI7M1VEHFEJ8C66xZIvIiohdM70hV0YlzxIctC+UE0Ep8q4Sb46SWRdZYBb8vjiiviRX1dCxELd2XpdJlQ/MTnP/rq8iXZyxc8wucmTP6VSgu4hWKhQ9Zmi6+aynBWa42tOuzIiifjBQA3kYERkHKfm9dJ5WNw74fag//D2S+vltEe7gooRQLA2Wl7oShv8m8eNcDTEjkT4O3ietw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghbt2VdipRb8TFXGc6+GiKsJdIAO++j4XglnEhSRYYo=;
 b=S4EJdkJRbEib0022KGt8Fk0DC3Qmv0DERIS1F637bVy3EHpcvzTCsXDcdYgZjslQj0XKolgyIlHVyvZjnLmNVvGCMAdfFQhOdtlB9W5LxlsjZAi2PWgRO3LcsmaWwbu4usRMeggCftCO9/DlUhmuH79AD1/s4eD8XGKC50mRtRgP7m3DvNBKYf1eBehbb+3yXtY+sLmOMwxTxtfARxpe+TmfKsacw91WQMm0j9guoo5swW4FTlSXG2NSSATQEKIsbzCNUVWrm23AKK3WCzAfes2tUH6fUTwn50aNUnb8Yjz2X7UDaIN3FC3XVc+oB9hZpSGSuRvBWCQE5Yfv5xPRcA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:56:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:56:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 05/11] drivers: hv: Export vmbus_interrupt for mshv_vtl
 module
Thread-Topic: [PATCH 05/11] drivers: hv: Export vmbus_interrupt for mshv_vtl
 module
Thread-Index: AQHctT5mUv6AM/ETtUiLCr1EkP66FLXKhpww
Date: Wed, 1 Apr 2026 16:56:58 +0000
Message-ID:
 <SN6PR02MB4157F1DAEF3BC14A67D59FB8D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-6-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-6-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: a508b18e-3ab1-4898-1e1c-08de900fb01c
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SUba4mmvjuVNbpPRxAAKFvTnIYe6zqalYW6bjVnsiXvFUlRT1pbo1HaRpvlm2AKlviLCAFeIX7FzZZgnMBWDrHLl5s0NhWvKoJdDvytvaEwKdFb1YWpEmblM851yTfErkyN8eNcxfV45XxvgU8c0QXx3BWsgDrlDi0k7ZUt+FoeEBrFUxbIZanWWdxeYMa0/xwgPEu6F7cmtLZhZtn2cr3ucsJi+WuJ5meihL3QuWD8m/EsG/ubOfWQjvpPKhzcKhoUkctinSXan4wQQO0azmICqbE6lzvLC6+z8uIhupwPyhNPgEIR7l0vAMFAh4MVYr4ysgRKUKpJ0UxWnaII91I4B9VwXOCyAMJlvG3g/McQS+G+kVF+8oOO8eHAASnechSdOWPGit2aVzKUMUBYaeZRn3DIB9tPn/iksbzhD2hizGa8u/lW3sgBHWpe5z+GsCMRpyW4roswwzge7kfDT+lGZc/UxYuHJb/C9cBAVFYmHztT6udl1f/mQR2/1sfWobt2b8H5tScX5VIjGr6H+ciwi65mSNQ3hqe53ETuRsGvSeT7F/RFufy+I7WJIONXyWs0M8ekt0M6bL8VxZyJZAmWpLANNpfptei5DPma4ITMGlmiXvI2DZNMB4O7lNSO8IlP6MKWl4/ju1F1+LFgCgvUUUuvistUeDQI65LEntzeYRYOD2E+sFTp91jyp7OmaJg+7MOWU1PCGpX0oZkBR2NMuiIjyNQ398/iV0oMdfabg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|12121999013|37011999003|31061999003|461199028|51005399006|15080799012|13091999003|440099028|3412199025|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6RNA41ZjYrN0Ub2NLjMfEkTfbUZShT5xcgvvcfobv+tuZbavQ9KxiXQnttx5?=
 =?us-ascii?Q?2M5gejviFbG5Djl7U8pbpkppb49M6T5CW9zdDg96O3gc6lYVq+j3OALmy3Ym?=
 =?us-ascii?Q?UXgz9ljLEDfOvop1xymEd2YHhP8QsubyQoWh+5H+h7bozcg1OaYlxE7P0tiC?=
 =?us-ascii?Q?wzjX2DhoKqa72/5HTCnBlcAryOWMiFVsBbGjFKyqM0DTwb0QAkRfn9OumdXX?=
 =?us-ascii?Q?BWb06nz2tkrrFI9R/+uAH565zH0ZOBQL1wRJNVbLLgpuyMvD03FxesfsedR8?=
 =?us-ascii?Q?pFx3B5WgoQf54TaL7X6rCzeULgkjzb0jZ0X+fGhRAreT3bemj8WmsBd/2reZ?=
 =?us-ascii?Q?USbE06COZGjQ4HOt0uVr+VnTA8BVaMRbo3Z/0gfjQOB5r4kbhoA0o8mzvqCo?=
 =?us-ascii?Q?sHnzvInS+dxdktKbwXIInMmJfAawwURmlfyceGcCbh8qw1UAx9YkVy8jjztz?=
 =?us-ascii?Q?kfdJt0qmi4SBxWvZNyQqPsvn1RyZmRfbQW2pxQef2+8Jumke9cLry0t+49FS?=
 =?us-ascii?Q?LUBst7jHiPtZbwB+JEdsRngQtt2cWmHoF6C8GSBO2PJQJxsi99kYpDGfdN9g?=
 =?us-ascii?Q?uBd0Z5IzyF5yfP0BYQrzFP5k4ChJfRGfDqU6pOTLqPT36InNerUqwSbsj1v4?=
 =?us-ascii?Q?6XVdhBUNa/FRhcU6u6LLEVPP5LceNlY+B5HvcUgqyHUwHX5xnXEDN1Q1Hslg?=
 =?us-ascii?Q?uODDKldDZKBUkzMPtfKTV2IXzAg517m37lA4OCDSb/0NvS29XzTHdPIL0V5k?=
 =?us-ascii?Q?xrQDUMvxRmpgNNSHNAPVwGUEYDCqEubBP1+b2BwAwqV1mLiyHoZ0wPwI6nAt?=
 =?us-ascii?Q?DNMVvRnWwuXMD4EdLcoIy1Wcsguz2vwz+OZltlaIekyDOkkbCtPpbGiSet3j?=
 =?us-ascii?Q?Yv254FuHmBXd2x8Z+yHFMq/K/DzANhkWEPsp3bejX0Ak9hUvHS8QsMIyOagK?=
 =?us-ascii?Q?uzqhFWmc4e5CiQhQaHTrXkUgYqLCxVTMi0s79GstMrcnzVcDk8YrI14uhpQj?=
 =?us-ascii?Q?x6zcvVRVbGYbdS6f0PkepHrceG/zVKKrBvWK7dMz9yfB/pSaX+jwjPBytcxN?=
 =?us-ascii?Q?zNPT9C98?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6E4AZHnwGlpzNaUJfG2lME7ia+kQukF+2wW4CyNWKd5A4XbmBiPj/NFZeUvr?=
 =?us-ascii?Q?VR+whJaBaYG7bDZruJmVPC4DKQzHk/KR9MtbRhhubTKBHCTg1FLNy0vxjATm?=
 =?us-ascii?Q?lmNDj8ryEK4664oShgNxNrPtlJ/PriZUyxnjsnFH+CHibKgd0MkseR71vru7?=
 =?us-ascii?Q?dwBtKngbzRofwGIlIfewZOE6UiVkaO8opejTmXgHnwzdidxAGizxmNudSX8Y?=
 =?us-ascii?Q?F0kqX8ZubcvayenRWUZwXSp4TBKWCJCminx82caOOkJdNaoEIGIk8fBPXH8q?=
 =?us-ascii?Q?8Hq9lbEJUsvMwbcU30qaZKzINCMrMF7WdLEjYRRGM+KzjHGgllDLvuco9ouE?=
 =?us-ascii?Q?xkxu3wOpBYNEwyL/FhZCy61wMe6n8sX3VZ4M3rly0ArGQ0k3SktvzAhCmC+h?=
 =?us-ascii?Q?urRpnMsd5P/XuGs4yILe1h6AreOaz3xTG5rMe7zAntYi1U/eb4fivi3uUe3o?=
 =?us-ascii?Q?ponrjlyoeNB1Na8zqqA++ykui9Bp8FxZZyw1mQewBmDM7tRgPDT/XZZOcOIU?=
 =?us-ascii?Q?4gpWzg3zSDleG9LfRr6mo0YXcDgCVHClW9Ee8qgZ1dhC04tCzfaRIHvHUtY9?=
 =?us-ascii?Q?dyN8QVAG0ajwP2/Ll9zBaW8zB4irsg8wUZDSa6rjHX8MI1yXwFEmQoQkBTeb?=
 =?us-ascii?Q?OoEYg/KDxt4qNQ87vBUIGFpBKlil1tIEQk4OjxGCvvvocyXL+/PqOOv86a1z?=
 =?us-ascii?Q?atYOtaitn+a81brZf2F6cMj1Yb0Vu8A5QKGcnz/fgBJkrv9/G06q0GzRDAUh?=
 =?us-ascii?Q?fE+/6xb1EWHuzrQR4+4VzGt5VesGjFw1mck4WSbKY5Gs3fUfwAHl/8lABk4K?=
 =?us-ascii?Q?U5UE8/3w9a6CWkq8O0D/jMxLuJPWBCgJCqg5iYzJHn67q48atKBgjt8eQc6A?=
 =?us-ascii?Q?abLYS6F4ypROu3jjSHi2PWxYc4DbA0JDrW3B6F1Tyw1HhQJLeBXyOhrbv3Hr?=
 =?us-ascii?Q?dwT8B2U11bz2rcv2PKRtr8B1zjc55iigtWnq6g0zOLFa3HGDelWzf8F4Kp8j?=
 =?us-ascii?Q?3b+4WzXIeAlu6iIEOKsmLeXTPCjHiO1Zaj2Sdp8SMnwnpQYm48JsYPw+5QID?=
 =?us-ascii?Q?72eJ7gzDetZCI311CNsP8eHiCnOu8CCH5SJt5KNUCfPUfRoYWduwunPPamSa?=
 =?us-ascii?Q?b1lJGzQQkiVxTGfSCxRt7m874lVdLmWYtK+8rAuKAlfCTFtkdFkwk32cZUW1?=
 =?us-ascii?Q?Po61jPN0dRdSUKIQS4e0WFWQT31xyCF3hi+KXDIAMUvXsYPZY45NyBpYe2gp?=
 =?us-ascii?Q?bh0bus9OfDdABMy8peuqeO7XpmKgFGq0G2mAFB+3GddOs3+RtANkYAENPIWz?=
 =?us-ascii?Q?QAUCi8TD706tHG29ulgava2NT+NOZ6htZi61GNan9Ie7XFIpfFjMtuM/OguT?=
 =?us-ascii?Q?tQpbyiU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a508b18e-3ab1-4898-1e1c-08de900fb01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:56:58.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9875-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A73DC37E550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20

Nit:  For the patch Subject, capitalize "Drivers:" in the prefix.

> vmbus_interrupt is used in mshv_vtl_main.c to set the SINT vector.
> When CONFIG_MSHV_VTL=3Dm and CONFIG_HYPERV_VMBUS=3Dy (built-in), the modu=
le
> cannot access vmbus_interrupt at load time since it is not exported.
>=20
> Export it using EXPORT_SYMBOL_FOR_MODULES consistent with the existing
> pattern used for vmbus_isr.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index f99d4f2d3862..de191799a8f6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -57,6 +57,7 @@ static DEFINE_PER_CPU(long, vmbus_evt);
>  /* Values parsed from ACPI DSDT */
>  int vmbus_irq;
>  int vmbus_interrupt;
> +EXPORT_SYMBOL_FOR_MODULES(vmbus_interrupt, "mshv_vtl");
>=20
>  /*
>   * If the Confidential VMBus is used, the data on the "wire" is not
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


