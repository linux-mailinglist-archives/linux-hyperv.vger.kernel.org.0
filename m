Return-Path: <linux-hyperv+bounces-7684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD10C6AA5F
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0AE492C5DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175836B054;
	Tue, 18 Nov 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JEfoxKR3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010001.outbound.protection.outlook.com [52.103.13.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A1355805;
	Tue, 18 Nov 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483401; cv=fail; b=QFDsrZvTTHpv/gg0etW9t/55mFxvt+QCJTeCWD4YZLsh/9lPo5PflIcSQ4pk0OGQmxQuWGL2+jPsD6tLe6/yiHEHCV9F59uaw6KTC+x3stb+RALKdR0qHwiyTEjIScRtOErQz7wP0ySMdEIKUxha82mfoGXL5jG1WWDYQlkC2yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483401; c=relaxed/simple;
	bh=9CePM6I3J6XjttA+4I7IGMj2MZYoz9k3Iwb2wq8LuTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWPJdaFZyN+fMMoD/sBTCYCo3ci6+TU+1WgZnfRMpn/EBIQvuCdZTA5prruOc68q+YPrpVFqmEtFt5to3ysw2qKLk2hw+hy9XVKHNDrPelotQoba8Hr4tpTlKzt4P7c7WLaNYBDH6GwUi/12urp727HxO/e3OGWvjfQ4OSELJXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JEfoxKR3; arc=fail smtp.client-ip=52.103.13.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtkD4GesQuCSeC15ii2lcTGheqyIJLUqYgmr54wnAFKk/1UHfySCi3bwuvWMQJzeH6216ds5tuMHbmnzgNFtO0EzcNRlIXEO0omyJhi48AE0B8DDs+f3Ty5MfyPYmsr0BwWSO2yd9V3j+wy4O16mqu67XOvcb9FWW8rHb2GOPDPpA+zVxk1K8Lj+KqijUHLOuQ4ntJdjnuMrbJF7LeKRjyytvBXJlDtV8GtiunrFPh0u6hnHYdRQ4ey9ENSqWhv3AC2dFpGVhNZqDAPal7D44lH/IGpNPmL7T70TTtg0CG3ZCwxWDXXUnBATtySuYwRcg35+QEoWkRGamC/Cyo7H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A7peLI3qGHRdXZvCmRV8GnktsFm1C9ZTNPtDBSvzh8=;
 b=nkNJb0BzONplkzj3Ngo55B28lIwNioxOFV7ytf9iwglhBXBZ8qKTUDwSj/rpy75YxQKpXWfB/Ip1ZkTiSMc6WViUvC26Vf/mIWlQdG62z1uNpIBYGqahewW6P8u9LH4HObDqVEf4ki1u7QtRa7lWQYe+bxsUNOI+p1Z/gkOlgyp5i2rg+1HsrqiBgF+gyqzpQuXfUHA+jyT5p6Ca+3rWuK/oafZZ8ufMhbUibxAvRuudY4ndB3e7HONXXip23epZbyQikSPOvZyMk3Btq85ThhUwf1r/+/jDpRePbaq7UDg81Gc2bUd0CJxWWTE89qiC7wA1hX6eGRpY5xrl3HddcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A7peLI3qGHRdXZvCmRV8GnktsFm1C9ZTNPtDBSvzh8=;
 b=JEfoxKR3aAfVtFxW2Zpm+16DLinCR+R10fDVzGxxwmqwTU+DKvbAUd4nE5+yVicR4Q8kjyJw1lOgG0EjFnUCL+RlVAIrO8TgYqzUMXD4sW43mpUj5Bbb3J76NgmIRraS8Xqjup7y90mwUV+knXqIuknFUWvlzEglOMXGa6TPPNrESC4yZTeQ9sFXIu5LzVndRNKtot8qLq7moDFP4DPMdW43/waa+wDUalvulBNNLtNFfl/eO+ofgfX7G8Gkukiptb1YAurHPoaLW7kwg4jjDHjOiAv7On6CcoFDN+Hqk0+SEwxqCi1rGqp37PeOb+7guU9pDM8jJy9t9WpX03pd2g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7848.namprd02.prod.outlook.com (2603:10b6:510:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 16:29:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:29:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Thread-Topic: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Thread-Index: AQHcV+Ql1XC2uTrlrUiBnqvdm0eRorT3Vb7w
Date: Tue, 18 Nov 2025 16:29:56 +0000
Message-ID:
 <SN6PR02MB4157DB4154734C44B5D85A88D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7848:EE_
x-ms-office365-filtering-correlation-id: 3f12d7a1-7cc5-4793-2779-08de26bfb59d
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc8PfaoaFMUNWZKRoZ+Te3Q/KnY5X9Sn3+17ISbP2Y08zW5JKwq1MG5PCNmsPpuZwdYXfW5olMtsAT0lDSXfcDjE2srMYgH7rPNMbhru0311+LuLnhqBt0oB37Mft2NgE/k8WgeeTxpuvUS9cb1u49CqMkEQ4Uvv3jE+JNB4ImnEQE3USB9+LPX/nTCsmaEs0LwZw7Io0zLMZTviUs8QGnbTFvdLz0L8nBfNVajCiSDRNni0zg5HrYNztc960byI7WfX4uWTaJCXTqOrkOgbhEuYPWkxHyArcdFZX979uL1SUdT/DHMtvOZPgGAoAwTVm4kNUJUPiQHl3/CSAMtuCZhMOsaD12QG3/i+rVyMbPjR79rxtN+nhnWRntrb/Lw92XW5wr588wUMZg3jhRVTdR4313kGulRXybewy9QepplvbsQymalbUasD3AvW4USy2fQhlV4jKUMhBmZBk3ggy8/Z+c7A79wLlpnBdt/FAASqPxfYhof5W3BJQ0j1V494ZCQ/cm3xl/jEcG3FZIOC01/QRcx3ZTWbI6z+tpKvZzGWTVWzpEJv9qasiW70MJW3Yth4z7NDE7nyePI74reA9F299a3Yin4nwQMgH0inOzsj+m00K31LXW5mTUgtfQD6NNoHfQj0nyg+JBCpX6AOW85cmbtQ+uCa+rXgc2orkZvvRmBta3EIMUBXLILudh2XW/tQazNJSOGa3YO9lQmkeEl7WINQRxLaMMmdBTSYunoTsjn3ovCa0Hm
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|8062599012|8060799015|13091999003|19110799012|15080799012|41001999006|461199028|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GnnSHefuprT1foc8xOGAAZhYK6g5IJEOLPiwYCVP6eGDjU4C65mKfdyGsL8v?=
 =?us-ascii?Q?t8x5ISnvCOoJzPy/418kEandSUnZP7PGBhpBEuY0rOcUktpb14aWbxHAiiI3?=
 =?us-ascii?Q?p0/BPPZ7qaJnUXww4E598U+t+XH7stW51mxZBfmFMGGUoFlxwAdA1ZeHs6JK?=
 =?us-ascii?Q?+qg1AlDOTNohFaVOIP0+IGChgs9pgqq4UT2wNS8C8O2hJKmjg5u9QWQcbYUp?=
 =?us-ascii?Q?HaV+conc9hiexQ27vvZIXuFsIdPJo5II1tO14O05I3maFQEmA7Pu/NX+wvcP?=
 =?us-ascii?Q?I/vpREYM2SymewVhztadaGxGpvUkuhb2o8Ffr4OVhXAoLv2EFeXgpR+9664h?=
 =?us-ascii?Q?wG2SXdakBrXKWwsnA3GAhtRl7MP6jqvHww5W43g9O7xy+WI2YKp04ctpRWpl?=
 =?us-ascii?Q?8rdxbTntbHeQn0frM9vC+1X1wM0zDIdTRlz+6UmssXZt6G6/dl+DIlX1+53v?=
 =?us-ascii?Q?JrJvownSA0SXZeshr34uKO1rZs3rG/wpRBkjVHuQ9iTvSyXs06OWo4rWaUG1?=
 =?us-ascii?Q?MFPAsqf8jNWHRDU7Nt8m6/gGZ5brm1nc1MhgszgEyIvixnZfsRXjXcs80WAg?=
 =?us-ascii?Q?cOTJx75Tpgjp/aG52jZwTLstkGmXgda+SPkQwD+vsxA+OvKxgbRTe2f22Mr0?=
 =?us-ascii?Q?sBn1pxkqt8QRrNYfdZCZX3/ULH6Zq6FwO1ocMlD8grrD8342E2F/A0qjvggv?=
 =?us-ascii?Q?TDAS39P6KP3rl5jXsWMMBEWuYEnCyZ05Phc0lumqnCZN//4M6XWZj2UGk20z?=
 =?us-ascii?Q?/zJlht9fyQyMdyoiSkAtRcX7vPYZfLbSXN6XBr4Pye4m8jg3iQnGIirrhKDg?=
 =?us-ascii?Q?RsjcMGApFTKdNblgAmVn9GJlK0AQSSm9y+cnlJ6azYuJ9jntFHxHCVkDVeX+?=
 =?us-ascii?Q?D/XNSXuqNkqjJcKrmF1V+6VBS2PsMab+1KgFmuJtt5FleO6/F1r3SWbURjww?=
 =?us-ascii?Q?4zYcKIQefSZ13xYbHqTS6ReSU6jW/uH3TaopzXIKAvgipvhP1e55xUyjNlXK?=
 =?us-ascii?Q?bhwJiNZDx48E6SFwx8dfGwEP7GirBHwptcAeZydF7ZGZ9h/QqLf8gWD34/Xu?=
 =?us-ascii?Q?i+nCCzcWQAYqQVP0Wo5IGerfI/1tYM07kHlLk4/p70p12AhXOZcl861rSQzu?=
 =?us-ascii?Q?R/hzctYXkvyhIuNRl/VRHNFTJhKEXM6tz5k+U6yUPH7nrJJSlX8+S/UYx2V7?=
 =?us-ascii?Q?N6qw0Olq+KTGHv/CF8l4WQW9AJWmSCAxlq9Ji4iFtTpEMsvQf0U26SnTXp1d?=
 =?us-ascii?Q?1Ju56TyjnZzRJrnr1QNf2p52PwitClEsF/OEXzN4hg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t/4NhCaTZWhy78SZaJW4zNLjUHgqrGyV4LFd8EX1nKzG6/PIXDihnKWMChNr?=
 =?us-ascii?Q?GCNdfrFCtDgH5ju7gR/p3Sxha44RYkpX0/f1vVY6OJDk/7QFFGCft43Zl1iT?=
 =?us-ascii?Q?HGdD8z7MSpuCTaeri9pQ7ofbwMriKlt72QFCoVS22t3M2tP8t9SRM1lD5iKs?=
 =?us-ascii?Q?n6gBexqrqyMrWWv7KCO+BrbzM+blsOSQ+fW/ZHSgYgrUvPZE+fzvJ03MPksH?=
 =?us-ascii?Q?fUJSv9uouVstv67l0r76AeSEDWtr/cGuAQi+brZMp8fchNQ5JBFVSI3S37X5?=
 =?us-ascii?Q?HlLWPLmg/nl5yJtWix7GSJgDKL/6MqDpjQN1Ujk5rqNz7syLiUO+JgijqnMI?=
 =?us-ascii?Q?STX3ACnMS1WeFrN7QPe4qmShuOw2SdG/nz/QsZh1DhjdpMcTSXu0ASbZlK16?=
 =?us-ascii?Q?kX24U5x5fLaDuDx1NYNk0/CcMhplyyd10Wg9DSOFVKl7U4EYAfIBYumiCq4c?=
 =?us-ascii?Q?3WJA6YWdWz2WGMLH2ghz702xqzN4gexPq1OU9gB+hLVRTliJ+gqcNAzo38M0?=
 =?us-ascii?Q?H1EPq/AQE6Gf18j4H8DIg/ZoSWO0wtWGZnTNEqOndjPmhfDn/eDfVPHeONYG?=
 =?us-ascii?Q?9SmBPMJf0AXfnIO4/za85WBX5GvT/zzJhEh8RrL93phFSGKmGx3c/OdFXlT3?=
 =?us-ascii?Q?+HOZzIc240ylvYNu4g0Aid2azi5h8Gh5+k7iLEDh6czSwtz6GgKlbLR2Oy0z?=
 =?us-ascii?Q?xywjbV2I1Ltk7XrSWaaf24iE0mZnV7DoojNZ2+MElqBOUD17fG14TyKNRD0z?=
 =?us-ascii?Q?59EBcurRBH9quvtWaJdHDglHoB97NbcenhS7SvlvhJX6lyru9yfTAONReMHU?=
 =?us-ascii?Q?Mzt2yTU4HPyeDbgW9zVtS60eL3cBusFW+c26HdlBK9deW8oqT3/qka31TnEL?=
 =?us-ascii?Q?wPWAe0TxC1HsWLHyYKjc4VpzR/9dHQmdFhUqjNZkrXjzRhdpy3eUa7mDI0g3?=
 =?us-ascii?Q?VNkWaEuLr8KH1YhGblW6YrXfsmnV0tJq1lva2hbU8KpO+555ipJOB5coGHaA?=
 =?us-ascii?Q?lB6ph1o4MJkRHfpFKkxu9ncZy2UE5MP7zJx8ybGK8MzHzMhRQrD2iSc4Grkz?=
 =?us-ascii?Q?lwiWKGpX77UmFT9lcrAbdvoWo4ukpECmIiwq3w040+n9OaLfbtjEmzK2/Yos?=
 =?us-ascii?Q?bXzQtUsiG3HZpwvZBY93zBnDcyby6COtmCOlHDKXc4Em6443rv0PogMPrg3v?=
 =?us-ascii?Q?zSUKXgHiCDUra+OQHtEcR33E3CJ1/MQECq5hArRv+BXn3ymwE4LosZo1XTA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f12d7a1-7cc5-4793-2779-08de26bfb59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 16:29:56.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7848

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, November 17, 2025 8:53 AM
>=20
> Introduce support for movable memory regions in the Hyper-V root partitio=
n
> driver, thus improving memory management flexibility and preparing the
> driver for advanced use cases such as dynamic memory remapping.
>=20
> Integrate mmu_interval_notifier for movable regions, implement functions =
to
> handle HMM faults and memory invalidation, and update memory region mappi=
ng
> logic to support movable regions.
>=20
> While MMU notifiers are commonly used in virtualization drivers, this
> implementation leverages HMM (Heterogeneous Memory Management) for its
> tailored functionality. HMM provides a ready-made framework for mirroring=
,
> invalidation, and fault handling, avoiding the need to reimplement these
> mechanisms for a single callback. Although MMU notifiers are more generic=
,
> using HMM reduces boilerplate and ensures maintainability by utilizing a
> mechanism specifically designed for such use cases.

I wasn't previously familiar with HMM when reviewing this code, so I had to
work through the details, and mentally build a high-level view of how this
case use maps to concepts in the Linux kernel documentation for HMM.
Here's my take:

In this use case, the goal is what HMM calls "address space mirroring"
between Linux in the root partition and a guest VM. Linux in the root
partition is the primary owner of the memory. Each guest VM is a
"device" from the HMM standpoint, and the device page tables are the
hypervisor's SLAT entries that are managed using hypercalls to map and
unmap memory. When a guest VM is using unpinned memory, the guest
VM faults and generates a VP intercept when it first touches a page in its
GFN space. MSHV is the device driver for the "device", and it handles the
VP intercept by calling hmm_range_fault() to populate the pages, and then
making hypercalls to set up the "device" page tables (i.e., the SLAT entrie=
s).
Linux in the root partition can reclaim ownership of a memory range via
the HMM "invalidate" callback, which MSHV handles by making hypercalls
to clear the SLAT entries. After such a invalidate, the guest VM will fault
again if it touches the memory range.

Is this a correct understanding?  If so, including such a summary in the
commit message or as a code comment would be helpful to people
in the future who are looking at the code.

>=20
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |    1
>  drivers/hv/mshv_root.h      |    8 +
>  drivers/hv/mshv_root_main.c |  328
> ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 327 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0b8c391a0342..5f1637cbb6e3 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -75,6 +75,7 @@ config MSHV_ROOT
>  	depends on PAGE_SIZE_4KB
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
> +	select HMM_MIRROR

Couldn't you also do "select MMU_NOTIFIER" to avoid the #ifdef's
and stubs for when it isn't selected? There are other Linux kernel
drivers that select it. Or is the intent to allow building an image that
doesn't support unpinned memory, and the #ifdef's save space?

>  	default n
>  	help
>  	  Select this option to enable support for booting and running as root
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 5eece7077f8b..117399dea780 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -15,6 +15,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/dev_printk.h>
>  #include <linux/build_bug.h>
> +#include <linux/mmu_notifier.h>
>  #include <uapi/linux/mshv.h>
>=20
>  /*
> @@ -81,9 +82,14 @@ struct mshv_mem_region {
>  	struct {
>  		u64 large_pages:  1; /* 2MiB */
>  		u64 range_pinned: 1;
> -		u64 reserved:	 62;
> +		u64 is_ram	: 1; /* mem region can be ram or mmio */

The combination of "range_pinned" and "is_ram" effectively define three
MSHV region types:

1) MMIO
2) Pinned RAM
3) Unpinned RAM

Would it make sense to have an enum instead of 2 booleans? It seems
like that would simplify the code a bit in a couple places. For example,
mshv_handle_gpa_intercept() could just do one WARN_ON() instead of two.
Also you would not need mshv_partition_destroy_region() testing "is_ram",
and then mshv_region_movable_fini() testing "range_pinned". A single test
could cover both.

Just a suggestion. Ignore my comment if you prefer the 2 booleans.

> +		u64 reserved:	 61;
>  	} flags;
>  	struct mshv_partition *partition;
> +#if defined(CONFIG_MMU_NOTIFIER)
> +	struct mmu_interval_notifier mni;
> +	struct mutex mutex;	/* protects region pages remapping */
> +#endif
>  	struct page *pages[];
>  };
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 73aaa149c14c..fe0c5eaa1248 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -29,6 +29,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/vmalloc.h>
> +#include <linux/hmm.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
> @@ -36,6 +37,8 @@
>=20
>  #define VALUE_PMD_ALIGNED(c)			(!((c) & (PTRS_PER_PMD - 1)))
>=20
> +#define MSHV_MAP_FAULT_IN_PAGES			HPAGE_PMD_NR
> +
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/=
mshv");
> @@ -76,6 +79,11 @@ static int mshv_vp_mmap(struct file *file, struct vm_a=
rea_struct *vma);
>  static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
>  static int mshv_init_async_handler(struct mshv_partition *partition);
>  static void mshv_async_hvcall_handler(void *data, u64 *status);
> +static struct mshv_mem_region
> +	*mshv_partition_region_by_gfn(struct mshv_partition *pt, u64 gfn);
> +static int mshv_region_remap_pages(struct mshv_mem_region *region,
> +				   u32 map_flags, u64 page_offset,
> +				   u64 page_count);
>=20
>  static const union hv_input_vtl input_vtl_zero;
>  static const union hv_input_vtl input_vtl_normal =3D {
> @@ -602,14 +610,197 @@ static long mshv_run_vp_with_root_scheduler(struct=
 mshv_vp *vp)
>  static_assert(sizeof(struct hv_message) <=3D MSHV_RUN_VP_BUF_SZ,
>  	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
>=20
> +#ifdef CONFIG_X86_64
> +
> +#if defined(CONFIG_MMU_NOTIFIER)
> +/**
> + * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memor=
y region
> + * @region: Pointer to the memory region structure
> + * @range: Pointer to the HMM range structure
> + *
> + * This function performs the following steps:
> + * 1. Reads the notifier sequence for the HMM range.
> + * 2. Acquires a read lock on the memory map.
> + * 3. Handles HMM faults for the specified range.
> + * 4. Releases the read lock on the memory map.
> + * 5. If successful, locks the memory region mutex.
> + * 6. Verifies if the notifier sequence has changed during the operation=
.
> + *    If it has, releases the mutex and returns -EBUSY to match with
> + *    hmm_range_fault() return code for repeating.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region=
,
> +					  struct hmm_range *range)
> +{
> +	int ret;
> +
> +	range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
> +	mmap_read_lock(region->mni.mm);
> +	ret =3D hmm_range_fault(range);
> +	mmap_read_unlock(region->mni.mm);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&region->mutex);
> +
> +	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
> +		mutex_unlock(&region->mutex);
> +		cond_resched();
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * mshv_region_range_fault - Handle memory range faults for a given regi=
on.
> + * @region: Pointer to the memory region structure.
> + * @page_offset: Offset of the page within the region.
> + * @page_count: Number of pages to handle.
> + *
> + * This function resolves memory faults for a specified range of pages
> + * within a memory region. It uses HMM (Heterogeneous Memory Management)
> + * to fault in the required pages and updates the region's page array.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int mshv_region_range_fault(struct mshv_mem_region *region,
> +				   u64 page_offset, u64 page_count)
> +{
> +	struct hmm_range range =3D {
> +		.notifier =3D &region->mni,
> +		.default_flags =3D HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> +	};
> +	unsigned long *pfns;
> +	int ret;
> +	u64 i;
> +
> +	pfns =3D kmalloc_array(page_count, sizeof(unsigned long), GFP_KERNEL);
> +	if (!pfns)
> +		return -ENOMEM;
> +
> +	range.hmm_pfns =3D pfns;
> +	range.start =3D region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> +	range.end =3D range.start + page_count * HV_HYP_PAGE_SIZE;
> +
> +	do {
> +		ret =3D mshv_region_hmm_fault_and_lock(region, &range);
> +	} while (ret =3D=3D -EBUSY);

I expected the looping on -EBUSY to be in mshv_region_hmm_fault_and_lock(),
but I guess it really doesn't matter.

> +
> +	if (ret)
> +		goto out;
> +
> +	for (i =3D 0; i < page_count; i++)
> +		region->pages[page_offset + i] =3D hmm_pfn_to_page(pfns[i]);

The comment with hmm_pfn_to_page() says that the caller is assumed to
have tested the pfn for HMM_PFN_VALID, which I don't see done anywhere.
Is there a reason it's not necessary to test?

> +
> +	if (PageHuge(region->pages[page_offset]))
> +		region->flags.large_pages =3D true;

See comment below in mshv_region_handle_gfn_fault().

> +
> +	ret =3D mshv_region_remap_pages(region, region->hv_map_flags,
> +				      page_offset, page_count);
> +
> +	mutex_unlock(&region->mutex);
> +out:
> +	kfree(pfns);
> +	return ret;
> +}
> +#else /* CONFIG_MMU_NOTIFIER */
> +static int mshv_region_range_fault(struct mshv_mem_region *region,
> +				   u64 page_offset, u64 page_count)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_MMU_NOTIFIER */
> +
> +static bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region,=
 u64 gfn)
> +{
> +	u64 page_offset, page_count;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(region->flags.range_pinned))
> +		return false;
> +
> +	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
> +	page_offset =3D ALIGN_DOWN(gfn - region->start_gfn,
> +				 MSHV_MAP_FAULT_IN_PAGES);
> +
> +	/* Map more pages than requested to reduce the number of faults. */
> +	page_count =3D min(region->nr_pages - page_offset,
> +			 MSHV_MAP_FAULT_IN_PAGES);

These computations make the range defined by page_offset and page_count
start on a 512 page boundary relative to start_gfn, and have a size that is=
 a
multiple of 512 pages. But they don't ensure that the range aligns to a lar=
ge page
boundary within gfn space since region->start_gfn may not be a multiple of
512. Then mshv_region_range_fault() tests the first page of the range for
being a large page, and if so, sets region->large_pages. This doesn't make
sense to me if the range doesn't align to a large page boundary.

Does this code need to make sure that the range is aligned to a large
page boundary in gfn space? Or am I misunderstanding what the
region->large_pages flag means? Given the fixes in this v6 of the
patch set, I was thinking that region->large_pages means that every
large page aligned area within the region is a large page. If region->
start_gfn and region->nr_pages aren't multiples of 512, then there
may be an initial range and a final range that aren't large pages,
but everything in between is. If that's not a correct understanding,
could you clarify the exact meaning of the region->large_pages
flag?

> +
> +	ret =3D mshv_region_range_fault(region, page_offset, page_count);
> +
> +	WARN_ONCE(ret,
> +		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_of=
fset %llu, page_count %llu\n",
> +		  region->partition->pt_id, region->start_uaddr,
> +		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> +		  gfn, page_offset, page_count);
> +
> +	return !ret;
> +}
> +
> +/**
> + * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) inter=
cepts.
> + * @vp: Pointer to the virtual processor structure.
> + *
> + * This function processes GPA intercepts by identifying the memory regi=
on
> + * corresponding to the intercepted GPA, aligning the page offset, and
> + * mapping the required pages. It ensures that the region is valid and
> + * handles faults efficiently by mapping multiple pages at once.
> + *
> + * Return: true if the intercept was handled successfully, false otherwi=
se.
> + */
> +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> +{
> +	struct mshv_partition *p =3D vp->vp_partition;
> +	struct mshv_mem_region *region;
> +	struct hv_x64_memory_intercept_message *msg;
> +	u64 gfn;
> +
> +	msg =3D (struct hv_x64_memory_intercept_message *)
> +		vp->vp_intercept_msg_page->u.payload;
> +
> +	gfn =3D HVPFN_DOWN(msg->guest_physical_address);
> +
> +	region =3D mshv_partition_region_by_gfn(p, gfn);
> +	if (!region)
> +		return false;

Does it ever happen that the gfn is legitimately not found in any
region, perhaps due to a race? I think the vp_mutex is held here,
so maybe that protects the region layout for the VP and "not found"
should never occur. If so, should there be a WARN_ON here?

If "gfn not found" can be legitimate, perhaps a comment to
explain the circumstances would be helpful.

> +
> +	if (WARN_ON_ONCE(!region->flags.is_ram))
> +		return false;
> +
> +	if (WARN_ON_ONCE(region->flags.range_pinned))
> +		return false;
> +
> +	return mshv_region_handle_gfn_fault(region, gfn);
> +}
> +
> +#else	/* CONFIG_X86_64 */
> +
> +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false=
; }
> +
> +#endif	/* CONFIG_X86_64 */
> +
> +static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> +{
> +	switch (vp->vp_intercept_msg_page->header.message_type) {
> +	case HVMSG_GPA_INTERCEPT:
> +		return mshv_handle_gpa_intercept(vp);
> +	}
> +	return false;
> +}
> +
>  static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_ms=
g)
>  {
>  	long rc;
>=20
> -	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> -		rc =3D mshv_run_vp_with_root_scheduler(vp);
> -	else
> -		rc =3D mshv_run_vp_with_hyp_scheduler(vp);
> +	do {
> +		if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> +			rc =3D mshv_run_vp_with_root_scheduler(vp);
> +		else
> +			rc =3D mshv_run_vp_with_hyp_scheduler(vp);
> +	} while (rc =3D=3D 0 && mshv_vp_handle_intercept(vp));
>=20
>  	if (rc)
>  		return rc;
> @@ -1194,6 +1385,110 @@ mshv_partition_region_by_gfn(struct mshv_partitio=
n *partition, u64 gfn)
>  	return NULL;
>  }
>=20
> +#if defined(CONFIG_MMU_NOTIFIER)
> +static void mshv_region_movable_fini(struct mshv_mem_region *region)
> +{
> +	if (region->flags.range_pinned)
> +		return;
> +
> +	mmu_interval_notifier_remove(&region->mni);
> +}
> +
> +/**
> + * mshv_region_interval_invalidate - Invalidate a range of memory region
> + * @mni: Pointer to the mmu_interval_notifier structure
> + * @range: Pointer to the mmu_notifier_range structure
> + * @cur_seq: Current sequence number for the interval notifier
> + *
> + * This function invalidates a memory region by remapping its pages with
> + * no access permissions. It locks the region's mutex to ensure thread s=
afety
> + * and updates the sequence number for the interval notifier. If the ran=
ge
> + * is blockable, it uses a blocking lock; otherwise, it attempts a non-b=
locking
> + * lock and returns false if unsuccessful.
> + *
> + * NOTE: Failure to invalidate a region is a serious error, as the pages=
 will
> + * be considered freed while they are still mapped by the hypervisor.
> + * Any attempt to access such pages will likely crash the system.
> + *
> + * Return: true if the region was successfully invalidated, false otherw=
ise.
> + */
> +static bool
> +mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
> +				const struct mmu_notifier_range *range,
> +				unsigned long cur_seq)
> +{
> +	struct mshv_mem_region *region =3D container_of(mni,
> +						struct mshv_mem_region,
> +						mni);
> +	u64 page_offset, page_count;
> +	unsigned long mstart, mend;
> +	int ret =3D -EPERM;
> +
> +	if (mmu_notifier_range_blockable(range))
> +		mutex_lock(&region->mutex);
> +	else if (!mutex_trylock(&region->mutex))
> +		goto out_fail;
> +
> +	mmu_interval_set_seq(mni, cur_seq);
> +
> +	mstart =3D max(range->start, region->start_uaddr);
> +	mend =3D min(range->end, region->start_uaddr +
> +		   (region->nr_pages << HV_HYP_PAGE_SHIFT));

I'm pretty sure region->start_uaddr is always page aligned. But what
about range->start and range->end?  The code here and below assumes
they are page aligned. It also assumes that range->end is greater than
range->start so the computation of page_count doesn't wrap and so
page_count is >=3D 1. I don't know whether checks for these assumptions
are appropriate.

> +
> +	page_offset =3D HVPFN_DOWN(mstart - region->start_uaddr);
> +	page_count =3D HVPFN_DOWN(mend - mstart);
> +
> +	ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> +				      page_offset, page_count);
> +	if (ret)
> +		goto out_fail;
> +
> +	mshv_region_invalidate_pages(region, page_offset, page_count);
> +
> +	mutex_unlock(&region->mutex);
> +
> +	return true;
> +
> +out_fail:
> +	WARN_ONCE(ret,
> +		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u=
, pages %#llx-%#llx, mm: %#llx): %d\n",
> +		  region->start_uaddr,
> +		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> +		  range->start, range->end, range->event,
> +		  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
> +	return false;
> +}
> +
> +static const struct mmu_interval_notifier_ops mshv_region_mni_ops =3D {
> +	.invalidate =3D mshv_region_interval_invalidate,
> +};
> +
> +static bool mshv_region_movable_init(struct mshv_mem_region *region)
> +{
> +	int ret;
> +
> +	ret =3D mmu_interval_notifier_insert(&region->mni, current->mm,
> +					   region->start_uaddr,
> +					   region->nr_pages << HV_HYP_PAGE_SHIFT,
> +					   &mshv_region_mni_ops);
> +	if (ret)
> +		return false;
> +
> +	mutex_init(&region->mutex);
> +
> +	return true;
> +}
> +#else
> +static inline void mshv_region_movable_fini(struct mshv_mem_region *regi=
on)
> +{
> +}
> +
> +static inline bool mshv_region_movable_init(struct mshv_mem_region *regi=
on)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * NB: caller checks and makes sure mem->size is page aligned
>   * Returns: 0 with regionpp updated on success, or -errno
> @@ -1228,9 +1523,14 @@ static int mshv_partition_create_region(struct msh=
v_partition *partition,
>  	if (mem->flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
>  		region->hv_map_flags |=3D HV_MAP_GPA_EXECUTABLE;
>=20
> -	/* Note: large_pages flag populated when we pin the pages */
> -	if (!is_mmio)
> -		region->flags.range_pinned =3D true;
> +	/* Note: large_pages flag populated when pages are allocated. */
> +	if (!is_mmio) {
> +		region->flags.is_ram =3D true;
> +
> +		if (mshv_partition_encrypted(partition) ||
> +		    !mshv_region_movable_init(region))
> +			region->flags.range_pinned =3D true;
> +	}
>=20
>  	region->partition =3D partition;
>=20
> @@ -1350,9 +1650,16 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  	if (is_mmio)
>  		ret =3D hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
>  					     mmio_pfn, HVPFN_DOWN(mem.size));
> -	else
> +	else if (region->flags.range_pinned)
>  		ret =3D mshv_prepare_pinned_region(region);
> -
> +	else
> +		/*
> +		 * For non-pinned regions, remap with no access to let the
> +		 * hypervisor track dirty pages, enabling pre-copy live
> +		 * migration.
> +		 */
> +		ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> +					      0, region->nr_pages);
>  	if (ret)
>  		goto errout;
>=20
> @@ -1374,6 +1681,9 @@ static void mshv_partition_destroy_region(struct ms=
hv_mem_region *region)
>=20
>  	hlist_del(&region->hnode);
>=20
> +	if (region->flags.is_ram)
> +		mshv_region_movable_fini(region);
> +
>  	if (mshv_partition_encrypted(partition)) {
>  		ret =3D mshv_partition_region_share(region);
>  		if (ret) {
>=20
>=20


