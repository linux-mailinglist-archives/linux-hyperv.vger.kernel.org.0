Return-Path: <linux-hyperv+bounces-2270-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A48D6DE2
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Jun 2024 06:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84641C21176
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Jun 2024 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92658F6D;
	Sat,  1 Jun 2024 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B1KRpG1Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2071.outbound.protection.outlook.com [40.92.19.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195076FC5;
	Sat,  1 Jun 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717215096; cv=fail; b=FpBs/d+u4vDbQbitCuutYZFdTkVC7NLLSJi+h2RbecqMwFfUJB/LqeFupVzz/Xph/Fzapudinn66NkmCR15Qv81kWbtWLx6e0vPQX4ckcO6TqZwNj83qU6OXi3pqmfqhjRx8z2tOHIfB7HbDHrjWsxivssZ0V18TJx3vlRKkvxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717215096; c=relaxed/simple;
	bh=S2avg4JdnbP2RtIBiWcCtr2hlTYIuZCso5qLYEsLFJ0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EtD6jYOqlr8IWRatLC8hvfJX5SvIGqW6urJ80s/F3MeXnCsKqgnDhKw8MHD7MqcdumoCstnatwzyPmoMZdqoQYPfQvr7NhkhPiaRq0C3T9NkTSbliNq3oFbyCg0M0EVFfFsXY597qfjrXioXCPDZyQW1IwBsGgevfddqJgcbg48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B1KRpG1Y; arc=fail smtp.client-ip=40.92.19.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5B1fyuqdj2dJLv0Rxg4Rqht5JDB+GXco9IM0F9pAfWP47L7Ybj42SkTsjqyp2eQrKVGyDtyPbNp9AdXRhcCZKXoAUFkbUs5Fg9kP+rLJxOlUns7sKMizqvGsne6wpXNPF7h+cuCbWT9QIYbFTQ961Ac3N3kRyDgXm/Hxth+uI/5zf0oVdCsY0pYGe3FBnNjl+bkHpEdXU+VgWnfbo6JCZHdoOJ73NOXf6xvr5/F8ojrCyRD8aLCo3lHEuw4g4uCvKVMOuvrwmmQqDnQBJd2VFo7SUBrhqIlmBX5zj/FYRNCIbwW3+RnCJAHQMUdyLc+qDwVlLDkZKZ76XH/X+0zUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW7tiaD0y4pYaDVUQXEtQQRF+sSKFCiyXrrbZundQww=;
 b=jepI35W+VN2JMAnsjlWxm8kSWp69dvebeRf2qgM7jlQatYMmFLcj4hz93QMPYxjzx80+Nn2/PbKGfdPgGSNezJwho1bbznizMTBvMa734yY6hyx1MOSwKYG7XF3UAHU5DCychBcMlltwzPUOWZBpWBtbOuyAd7paydccLueTYo1pQb//swdTzn+rsGRAdgB4OO8GyYrs4KiEgPB+juebP3xubfVOf1BnKh5vTl3pRiVCYjSPqIey3C+yAEpa7I+vKFcsPQ2+pBekpcMz3P4HVRf1T4MGXH4PJ8yRtAOrmC2ijROGFTnl2h3d3fE+stuNCzyV/FAT3gwRca2qx/ZCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW7tiaD0y4pYaDVUQXEtQQRF+sSKFCiyXrrbZundQww=;
 b=B1KRpG1YcTD/ez6yem2Fm6UicoZYBh5YfHBIkFNL2o3eloJh+b1779p0aIIJ9TGR4Q6ApMw0/n61mGN2dDgWPgUCCKm8i82Wg19b5C4TBhfPfu2ae8XL2Y/13evYgJCmEnoA0PLB5wGzLIZ1yqC4ZhiJ4GrdY+SQFHb20aFxoa5tHxruaAE00FYwX8IAQcGbKyVxjRMhCM5vQ+Sw3ISZy8VK4fr3axRniBu3rMoNSqAB+e5Mokw+mjo/zgwY1iUM/nYR65Y0XW6FNaSVuT90mnpYK2X0cEi5lFy0UrMNW4Z/AKzl9mSn4LrD7ftUbOD0GQQkJgeBzG4uG/XhF+kbqw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7128.namprd02.prod.outlook.com (2603:10b6:510:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sat, 1 Jun
 2024 04:11:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 04:11:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>,
	"adityanagesh@microsoft.com" <adityanagesh@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Thread-Topic: [PATCH v6] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Thread-Index: AQHas0gsvrmYkFixO0mlB9EuyMIH4rGyTKVw
Date: Sat, 1 Jun 2024 04:11:32 +0000
Message-ID:
 <SN6PR02MB4157D719EE0D5BAC19FFA449D4FD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1717152521-6439-1-git-send-email-adityanagesh@linux.microsoft.com>
In-Reply-To:
 <1717152521-6439-1-git-send-email-adityanagesh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/HF6HqotktzCIIP1F9Gu+TAdfryRoin3]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7128:EE_
x-ms-office365-filtering-correlation-id: 5ee9959c-379e-46ba-d8e3-08dc81f0ebf1
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 PpeQ1NTzVZQUxoF0AtFzvboBTOtA+1Q+m5VHwWr2wZgtKj6opQiNaJvafmW94bxz2+dBgM7RsWgDx15muAiL8w2xEYsvt2Tg5NQpEoUnKygjCdyzUv0vR3w0iuyf2+rkz5JYvOr8QBDVx8aRPJv16H4FUEUn0mdCzsOl9G4zM9c7eXgiu4NILv+X7A9M8z/yQCVogbv2Qc87v+6n5qXb4BMTB05cmJ3C18KYNFYBpSiItchMnLWzAP6awm7fnt8uYSkKdw8hv1Z63HmYAMZtLRN65+geF7IPObw+uVTvVSEnpXtp79Q8iyIk74kuw0QnDGq+Cbh/je40dovFGSD50W4Bo8Bg8UmbALwQn/Sl9/NwUywbuKt6vQmrgawl7qgfyhQWNaKl9F69EskHWXtRKYlvSuhK0X1K8cyNMcHvz/hKo0YOpwvq6maDxmQOrivecGJlANKkGri9GpTs76F5mkGtK6QZnAJY4kGniAS4HW4yjyFjm41pL1gLHVUtZQXJo1IQFCVJVl/0UVpt4XUQv9bbe+zp1+yJS3KlnnsxidN8nuHPxmWh9FELyxwO2Ps6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XdEEE9oIqiWS3HKf3kizLiEUYfxVKtuNjhHVYt+HAReIidsZGTLjAoLTjksW?=
 =?us-ascii?Q?z0b1bZ/Bp63fiXefb4M3V3lkR2+SRQjsAcgorICSEjfxaWvLMBRnoRZpMk8d?=
 =?us-ascii?Q?NO0oq/15VkpTKyH6iHFrhC+/xRCTms35X56RW4fJLHndjzGCgd1EvDCQ5m32?=
 =?us-ascii?Q?DtsGCFYnb9EsQCg8EXQcCTmaSPG9krkL2n7jPb1sXi90PT4q0P5PQJxcocu/?=
 =?us-ascii?Q?0G+Mg4u+RyBnb2YBU5UiKw8h6jwF4yanzNKxTiOLSWbNO+FevlSCknq9SCgj?=
 =?us-ascii?Q?3ehimbaPiXI8yDcOdmT/Kvs5TxbZ/eLhT4QBPbjVavM7XocYtc7Zgt9nfU1d?=
 =?us-ascii?Q?FRHOWEeVsESHfd4lCiEksu+SKPGZ41TKm37xMmuZFaAj6OnDNpEzpEXvkaBY?=
 =?us-ascii?Q?xiroHcysc1EYppCWyFNgwiwDD1BKNK+JtEZQS0oa60BwgtLfMFNz6/ux9yVM?=
 =?us-ascii?Q?TrculpE2GGC5aOPf7smo1flzn75mUhCKGBJyhbxOxxDr0zKFnAnogmHM0uxR?=
 =?us-ascii?Q?A8Vp0pfBF+A+t+4Pb6zi/LdpX3m9B3Tj2QzwYBKiHISUx9c9oJSa+WNX5dBD?=
 =?us-ascii?Q?/X4PeHNFI2LKDd30qYSFAZ+OSynSnvITD9NgmNl6jBYwH02UDcH4GwyiKd1v?=
 =?us-ascii?Q?b2Tpm5qDdom+FC6ksIx2XUOEKdZ2qUeW9IzGQyb17ffuZ85hmBK57D1e0nod?=
 =?us-ascii?Q?3AGIUvuQnoCwv3tTFQyMH91i7KiZ3G0c8w7U6IRbmMeo18vG6oVZRKVyj8RL?=
 =?us-ascii?Q?xFgQsx0eKIkBoLDusLza12jKyI7iJBlDK1VEuRlpQ+CnlSC5sIsAHGXwe+EU?=
 =?us-ascii?Q?Uj+zl0ShKZxdhcIuCxQdNEp9gpcV4nQD7vfY4eeC0jHWBfjndVMR0nUIf0pA?=
 =?us-ascii?Q?GEx2rKNpPV+MXYptP0XzEUWio+EK2UaTK60pZKJaaGOt+we7/MQVA94pKLrm?=
 =?us-ascii?Q?KvUe96DQ9wBAvayzdNcO45QYAM2k7ScxbB4we59NKigcB9vXL/QMWzdYzm54?=
 =?us-ascii?Q?s2mHCPSeHAMfW8G+2jATJfqze/lHeG5ygsyS+CLZpDYdIdJIsZhio8zVL0e6?=
 =?us-ascii?Q?OqgdN9q1F21mMrxtjrZ+w6O/odwI/E7fZMM3LskwOpdtwpX5u5zmxZzhNT7w?=
 =?us-ascii?Q?CX4Raq1lDp7XaKX4UcaxK4TuwVSxFavisTqvEX5iQ0lf5L/NQD703WXOP+3z?=
 =?us-ascii?Q?L5MpokClLsfV05uI3yVS/ew7FY+OqMRgbzK/5sRZJyEgkEb/jQHOrpueqtg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee9959c-379e-46ba-d8e3-08dc81f0ebf1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2024 04:11:33.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7128

From: Aditya Nagesh <adityanagesh@linux.microsoft.com> Sent: Friday, May 31=
, 2024 3:49 AM
>=20
> Fix issues reported by checkpatch.pl script in hv.c and
> balloon.c
>  - Remove unnecessary parentheses
>  - Remove extra newlines
>  - Remove extra spaces
>  - Add spaces between comparison operators
>  - Remove comparison with NULL in if statements
>=20
> No functional changes intended
>=20
> Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V6]
> Fix build failure and unintended change after rebase
>=20
> [V5]
> Rebase to hyperv-fixes
>=20
> [V4]
> Fix Alignment issue and revert a line since 100 characters are allowed in=
 a line
>=20
> [V3]
> Fix alignment issues in multiline function parameters.
>=20
> [V2]
> Change Subject from "Drivers: hv: Fix Issues reported by checkpatch.pl sc=
ript"
>  drivers/hv/hv.c         | 37 ++++++++--------
>  drivers/hv/hv_balloon.c | 98 +++++++++++++++--------------------------
>  2 files changed, 53 insertions(+), 82 deletions(-)

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

