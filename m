Return-Path: <linux-hyperv+bounces-9154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHJVBcbdqWm4GgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9154-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:47:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA10217BBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E32302E436
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962DD3BD63C;
	Thu,  5 Mar 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uSBDp0gQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012045.outbound.protection.outlook.com [52.103.23.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFD30FC1E;
	Thu,  5 Mar 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739873; cv=fail; b=Rx3srM/px2gSe6RjgZ/ZqIsqvSAqQwyJVeLivuQAKoKPKiMsgKosjm5h6HHFARe9VD2oocIBsjbq9Hv0tPeQ2OCf/5j/esmHmNzglQa0vTVg+jx1PM0m+BF0rHHx9RG1KoNxsAKPJrQWL30u4OGecBGoDQ5mrs66FjZfEarcnHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739873; c=relaxed/simple;
	bh=DI6JltT+8FTR8MjcDYoegMFAkwaDlLboguWueZKFfkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YThZ/UoiUte5lQkPIQDdLUfPTc/eBjHhWES1QZddA5UjrTBycpAydnnz091VZcTRuw49jZtzTtnBPgjrBRB87j/bhgeC4z7w14g7bn2xg2MbkI5F9fA/K0tYdk0xFnNYYq3zjhcv/H0IakL0WBRxb8Nf3e5+ZkM3CRV7NdBFPbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uSBDp0gQ; arc=fail smtp.client-ip=52.103.23.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji/9H/P4NxYBejzi3erJ26kgoJtGDzuQcjC38oH30x2ai7i0xvr/noJSgIu9WifCxjTpNzn/Le9ylDvQTAl7Zg4ZRS7g696nnPVMTij4MimPk3xOOL/9x9k4/QsuewibUKeVZBL55T3ZDw1VvyQFov/KSy7WRukmTW1ty46qVzUyQdgD/fj75d00RIHq00bupxAopn45UXDGzDGTIUgZX311HP6lcyRJEGJoBoQlg6dJes8TVMsWOosSGxwfxRZZUZcBIyb3ZUW/4EGJnujENZyBA5X6AvmzV3xNt6qLV57GMaRaKYOaysKNfA2TjwXNs3yNhpp0qIo1JWpIq/V3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOVyOCkfgHrHnwLvWVksKiX/0pZ+d1AhEN4YrSqQeRQ=;
 b=qYKq8DEHHNZ6/5jNXN4xFDsNoOsHi7lDYB4vpZ8say8gzrPoypgFRQa86kNmfj1zKK4ElfmZLJc2Bhxnf6R6tBoHrhbyLzpw4P2jb2d1eiAWMfmlshOmK55LG5NnlI7gnfeGv2QZeWnpOsL0HcDWFsXmMhWXzAp7ySp5nEeH85tJy/S7sYkTUmtTVFTIn922MA8jkhxKSptwej9uD9aARaIPZBYc0ZeBFUUkwH7WHJvJf1B4ZrzJp2dquK6AhA5ELOeTRoP53dguwwp8RY8eaIEdm9WVN9Wx+CmKq9XA9/OJ8HL1o+FCSFjJlZGQq+KK8RvvxiHIpChMBziSm0YTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOVyOCkfgHrHnwLvWVksKiX/0pZ+d1AhEN4YrSqQeRQ=;
 b=uSBDp0gQNcpppZSS0Pozpxk17qywWn+HUphBCciHZgWNPEv/4j/LX+KX/t41ZLFr8vN3/rCnGzB6FKzkChDgbHaXy2XWowlKGpWHtQBGu3A9Vfk3Kug2bz0pNvOo+hZ+1rN/uyWaANV9euYf6bH+FLNJGDM8xGnXvEL07RaxZQ0SiQPWDdU7+kIfqZLSNtnGx8frq5LoYEL4N1A3DLbZKjd+z3QNfIFgZojlEzNHk7Xm6VNqtA1Rrq5oOr/yzzgy1+eFNKS/A+PO0c9t1C75dn3+jfrdttMshTjER/V9pa7tKtPVfxta70nFWOH6iUY40n2J4rGKiG27XUqA0C+ToQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8726.namprd02.prod.outlook.com (2603:10b6:806:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 19:44:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:44:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] mshv: Pre-deposit pages for SLAT creation
Thread-Topic: [PATCH 4/4] mshv: Pre-deposit pages for SLAT creation
Thread-Index: AQGf/CXhq+vihj2DXZ0/OE6Cmc0kFAJtpOXptgZDS3A=
Date: Thu, 5 Mar 2026 19:44:30 +0000
Message-ID:
 <SN6PR02MB4157C408547E59A469C5CE08D47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8726:EE_
x-ms-office365-filtering-correlation-id: 9a3ecfac-8058-4ab8-a178-08de7aef9e40
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|13091999003|12121999013|15080799012|8062599012|19110799012|37011999003|11091999009|31061999003|8060799015|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EKgbIU8CmG4eXZGYC35PBfhE6LakZq2Me57wQ8KBtgJD1XhuyFkw33yX53oE?=
 =?us-ascii?Q?F0i6XfjDCJuJkDGCHsCrC/TntFhSbn4KaoavO08F94ohReAufppFwdMeQbI6?=
 =?us-ascii?Q?qFSTItWqgSixmBFdwmuoW20n1Wz9Q9hya4Les8ii5fCidKyeuJ3DCGRbbqPR?=
 =?us-ascii?Q?tUv74sSzrnQ4i4DpDRRhAp5z8bhuSgDGTqU9WWctuIbYWD6gXtjl6i96UCmc?=
 =?us-ascii?Q?0Nxk24POGffDXQx08NB2iyLeM6eHB1a5nxlZV3isRnneCE0WR8+YQFrfNkkJ?=
 =?us-ascii?Q?Kjn+8db3+8hQFULEfunbOy9U6vW/+8TV09QN1mb24gFSxsC9MJC15b2Vb3ZB?=
 =?us-ascii?Q?JXK8waVFEC+NKT0HmJbUXVoxQPzh7kvD/dWF1DtSPjSePhQRgQ5Sh7TpV3T0?=
 =?us-ascii?Q?GMNA7SzTtUzVLQce57mFTysBEO4CYh1rVTc9ljV4PtvHHPj4qSaz2hmOQI9i?=
 =?us-ascii?Q?Cahkk90Ra3hEooijORoF5zxTM6d1Q6Rjhx84L4vpMwoS71ewJLlYTVsxi80C?=
 =?us-ascii?Q?n8zWfB/EiqDDl5M2/DFdLbXiMLX4gYYFEDyXGLLLvtw//PYREUYmSU3K0Eqt?=
 =?us-ascii?Q?PycfiBkzG9wWn3JMbbgnsyz0muR0xzPoUGb3d+cupq84hfNAUmfLxVEKll/l?=
 =?us-ascii?Q?ccsiRDRj8kCievljoHzqjupRj1Dgr0izHNZuT8zoqIz3j+u4a9VB8lEpVc1i?=
 =?us-ascii?Q?mWYGRJO3GT6mq+fAGbI5u7e1xI3xS4wAAWZf9f9HbOSqSQHOIdG5ZSG1MhQz?=
 =?us-ascii?Q?4sNEwTqEKjTExaHERJtumHJZ21Ie3UBpvB96zxMJl/CiB/OQWKsWW7Fr5TJk?=
 =?us-ascii?Q?DGCNm0rCx18OPfWPwLBHfutd6a32JNJb9B+8NzzqSQ355vpny6DZmPVdX5M0?=
 =?us-ascii?Q?8Fe9Q92tVPETUnyGmCEB91AucIQWRE2fdK0/+On2I9xr7oeo34xOy4vm/qgs?=
 =?us-ascii?Q?Y1GbS1a3Gh9HUsGhwokFX/MK0CI1ms7auNd0PXnpqFHgfYTiog3M8IdLHZxH?=
 =?us-ascii?Q?p4Qd1WDKGSmvXig89LSJH33a5soNurcNbZ1pJJGDsnS7nhHycWupKlQBnQKY?=
 =?us-ascii?Q?JBOBwrV7lnnRkSa6X55hdZ+u0FIxEi9aB6gNlxIZt6Lcj30Tdx8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/pZRlV5Z32YEtfKI9irZgCfpBspgSp4IiSBFT2ybo6xRJ57loWF59GgHY9gm?=
 =?us-ascii?Q?jd2SvX/7D/3HeV+nzo3UgrsD3bh7Iupa/bZf+RUhV4xwO0BfrAFVIt+4L+3M?=
 =?us-ascii?Q?14/2FrPnJz9lmM+DEDY6IPYqfoxif14OiItr588hOHnCPw5f1Flo5sASfnQk?=
 =?us-ascii?Q?qf3FW4LmMnKZJJbtGvuVS2kIFwXHxgF/qG84rIzJ9T3/MinQ0qtDnbZrDNbM?=
 =?us-ascii?Q?uGMFK47NH/UiXu5yP+1IDJ2uGBnitu95h8aQoSIdJ6F5LWQz1wWUFPuPJJbx?=
 =?us-ascii?Q?AiULvCsLNl3wtAYTL9NiBGSjxKSsRMa/QfRiukCGa9PcdH9Wt1PsT96kF81s?=
 =?us-ascii?Q?B6+aT5MuEVGmMtD5gOjm98/+lHVNUEsGS9o9L7mjWNp8XSWSge5mbGlzJ16w?=
 =?us-ascii?Q?gwIcb/aLuo5DL90egvbtthIPbhxjgcNbkIZgwj0Q8meD8/BVQc8BIE35axu4?=
 =?us-ascii?Q?pzHvhNBvPVmyIGRaaidl048ONjrmP3XAL3KMOI+8JUkKTwZwEExRwSuXrlng?=
 =?us-ascii?Q?6v/wmTumRw9rzc9nT7kdyKdXTSxH34a1/QOUK7OONIsH+cYxXBj7xTLeyiPG?=
 =?us-ascii?Q?IaWFULlJQrVXg46/5oLWgjxZKEU2x9mupqorBtNlqhrnEJfnGLYZ0/HUhCn2?=
 =?us-ascii?Q?PwptBsRv6TU8p48u8ve7//ylnrSUpYcMJhS6hedyoUPCCxkM+bMMfxGxe+TL?=
 =?us-ascii?Q?qpAyWVwMqIct26BeDaQ33ECntWN9seVjzLZiNd5M95XBXY2w/BbMb0GD7ttK?=
 =?us-ascii?Q?2qd34a9WdPb79hh4+XHGXHkmH34+t/b3iBaYna+t16X1LRFqQlBt0TBGiTTH?=
 =?us-ascii?Q?EDLn3sQ6zlsoCDKNCFip446lEQnNUuzi12V2cx8pg3Hv0tin/TOtKfaNHHk4?=
 =?us-ascii?Q?IVbc36Ql99CLwHHjTo2qx2N6rT0qRhmW508YyXURci0WLKcDxlwUr/HQ/++i?=
 =?us-ascii?Q?POA6EGlDgBkoorj8vI+d01J6vIZQdeSxse3OJuketHmVOhR3vxC369cRo9vw?=
 =?us-ascii?Q?CmySp7Kvkr7q4Otz64xuN/zNoJu9gIgZYvHfgepZPWQ8DkZB5z09JZnhwxmc?=
 =?us-ascii?Q?ZAUVMTYDEuUBLwWTlfRGPl3mqD0SAnVhvRhfBNVa4NT5UN4syDFrMBuUNzUu?=
 =?us-ascii?Q?KVuJB1POD4nA3yqjxIe9l1MfD/3g6jfMNl/LAteZowRofybya6BGHxnXqWuS?=
 =?us-ascii?Q?EMiYwKqXix+IHweWQZdXQKlc0xmS874nd9ne+0c+214V6Yc+1tqPJsR2XF7U?=
 =?us-ascii?Q?TYT21SFyk3aTmC0Mza4UdvOUZz2lUinKWZVDzeK6+iWe0pUDagQfJQqb4MGl?=
 =?us-ascii?Q?eulkPRZbyP0L4vOAQ+oVBNZDtY6NR9gUXh/Wk0spQWbl3y5LXRoZEvog6Oqg?=
 =?us-ascii?Q?ayROyIw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ecfac-8058-4ab8-a178-08de7aef9e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 19:44:30.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8726
X-Rspamd-Queue-Id: 6FA10217BBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9154-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesda=
y, March 3, 2026 4:24 PM
>=20
> Deposit enough pages up front to avoid guest address space region creatio=
n
> failures due to low memory. This also speeds up guest creation.
>=20
> Calculate the required number of pages based on the guest's physical
> address space size, rounded up to 1 GB chunks. Even the smallest guests a=
re
> assumed to need at least 1 GB worth of deposits. This is because every
> guest requires tens of megabytes of deposited pages for hypervisor
> overhead, making smaller deposits impractical.
>=20
> Estimating in 1 GB chunks prevents over-depositing for larger guests whil=
e
> accepting some over-deposit for smaller ones. This trade-off keeps the
> estimate close to actual needs for larger guests.
>=20
> Also withdraw the deposited pages if address space region creation fails.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 48c842b6938d..cb5b4505f8eb 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -39,6 +39,7 @@
>  #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
>  #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
>  #define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)
> +#define MSHV_1G_DEPOSIT_PAGES			(6 * SZ_1M >> PAGE_SHIFT)
>=20
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
> @@ -1324,6 +1325,18 @@ static int mshv_prepare_pinned_region(struct mshv_=
mem_region *region)
>  	return ret;
>  }
>=20
> +static u64
> +mshv_region_deposit_slat_pages(struct mshv_mem_region *region)

Same nit about the function name. This one seems like it will "deposit slat=
 pages".

> +{
> +	u64 region_in_gbs, slat_pages;
> +
> +	/* SLAT needs 6 MB per 1 GB of address space. */
> +	region_in_gbs =3D DIV_ROUND_UP(region->nr_pages << HV_HYP_PAGE_SHIFT, S=
Z_1G);

This local variable "region_in_gbs" is computed in units of bytes.

> +	slat_pages =3D region_in_gbs * MSHV_1G_DEPOSIT_PAGES;

But here region_in_gbs is used as if it were in units of Gbytes.  So the
slat_pages return value is much larger than intended.

> +
> +	return slat_pages;
> +}
> +
>  /*
>   * This maps two things: guest RAM and for pci passthru mmio space.
>   *
> @@ -1364,6 +1377,11 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> +				    mshv_region_deposit_slat_pages(region));
> +	if (ret)
> +		goto free_region;
> +
>  	switch (region->mreg_type) {
>  	case MSHV_REGION_TYPE_MEM_PINNED:
>  		ret =3D mshv_prepare_pinned_region(region);
> @@ -1392,7 +1410,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  				   region->hv_map_flags, ret);
>=20
>  	if (ret)
> -		goto errout;
> +		goto withdraw_memory;
>=20
>  	spin_lock(&partition->pt_mem_regions_lock);
>  	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> @@ -1400,7 +1418,10 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>=20
>  	return 0;
>=20
> -errout:
> +withdraw_memory:
> +	hv_call_withdraw_memory(mshv_region_deposit_slat_pages(region),
> +				NUMA_NO_NODE, partition->pt_id);

Again, for an L1VH partition, the actual number of pages deposited would
be 2x what mshv_region_deposit_slat_pages() returns.

> +free_region:
>  	vfree(region);
>  	return ret;
>  }
>=20
>=20


