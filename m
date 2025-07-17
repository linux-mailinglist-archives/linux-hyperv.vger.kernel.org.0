Return-Path: <linux-hyperv+bounces-6279-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4607B09328
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D0B16CDF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8861F1537;
	Thu, 17 Jul 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W+8Mcg/C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2086.outbound.protection.outlook.com [40.92.18.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068F2FD88F;
	Thu, 17 Jul 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773158; cv=fail; b=VDsOuekyZ6sMVhJbGUWE+6Vlhi8zpr+JMzVO1lL5QBl4B/DM0I/N8I7YE0PukhUySz2FsKkE7cd69ylVJ2v9aVpIClrJn4paPz4doElxZoRKB2sw3ashQMnt416cDL2AXYvo+1HHd830vT7oPlB3va+yHslkBoBiBjl3Mk9Gv+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773158; c=relaxed/simple;
	bh=cawZroI35VryFDTsagb7WOsVgWH5Qt+PM0GB0tFSAcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4rBndecNZuExOBQ8Q7t0xxa94+pJqnC+I5HO22pn744KDZanJUSRjLx2PX+oGiOTja6mljm9Bl6jGabXcc0ic+vsZV19cWWRX5LQMEx7i63cR3vfwuXJ/uYo8yF+PWeBCrm9xo19jmH0zKjRtw1w9RwEQw216BsuJsXbB0ff6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W+8Mcg/C; arc=fail smtp.client-ip=40.92.18.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6uGa+V/uHIomEGcmpKS7o1J3Lu4hWD2tB9GiqgRHoNo4lXBfSoQKLyrzu880aez0clvI3HPIBJH1izLgXecwkJlyHO3/DoRCyjKoDp9iUYQx2N2S+/fwhAYy68UJ6smEW8RE0LfPeiPT4JXb0WB+33WJIjcl0IDbnhKlpX9t+Xb7/m/W8WJR2BgkQsG9pGo7V/ce42uyMTpxkGJ1pRgYvl5PfZpw9cJ1ko/NSVJZBykB1c+2+lKt65UadnYlJygP1dhZnQK4bSf3qqnttBazd6G67dZUhrwhfveD0f+TzOfqm6dEdvUedYJZdQYQ4r/fD+O7BhxkByQbEgNywylUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkkHxTnSIlYXfp6lm1e6u61uOexX+TJfTlCHnhQG2sc=;
 b=EEM+ZCaxjs088iFKVqaGe3MBZ/QDlkmNz2ZZw88HAdsQL9LEJ5c7adGPhcfKVzq/PWH6Py4+ozUz/MaL+qC7LNiBdflq7+9PKU+uZBqeS2jmbtg/Az6MI2f6Ly1IqeR+3huy8HFt/dKlwMbkMZWIKsY77qNoX4oiiyvuZpuPLdE39ukkQSkaI/TzxbN0/BdbIKoqrxXnv40+UVDSh881XbLpeZ5xsJSZdCAPKEEW8nLuKrLh77o2ejHUeU5ajLk+xHQFvodvEWhBOp9/LBsKl1pmAeoqUNOLVn/zn1Bxf6wsJO2Bow0icLd+ujK8Brk5EtVEgvoGeVc+GO34K19OrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkkHxTnSIlYXfp6lm1e6u61uOexX+TJfTlCHnhQG2sc=;
 b=W+8Mcg/C//mDvFmIeJ/WQVyQ5Zd11CHjoYOe60B7uYgQnzE3GolbKxzYGVMnAWzey8dBnLX3P4NheAuaPdUG46Ty79TuupY1ukp+qSUkcGo5FSAcDe2B63TMSM17nWJS7575diQHVhcoKKF2Az+YnbUipI+KyFB5Mix57UIPk9okoagQyCv6HdtFUC8acAp9xEowDOoxeOakAbKTlzI8VjsZV4IvR2+dDuh57HlHnR2xUu2rIabHtz4Ey6lNPUFQwFb+pZeaoE7TILEe8nFPRQSRcNHz0jqbgF9SjJEv/IHGbIzCy1XtGgbwTqFZhFkz7XCGaqLoVwtX3NQx9ZAAdQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6998.namprd02.prod.outlook.com (2603:10b6:610:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 17:25:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Thu, 17 Jul 2025
 17:25:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dan Williams <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Topic: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Index: AQHb9mxHNLZ4mIcOKESVNMsMHoF1RbQ2iGhg
Date: Thu, 17 Jul 2025 17:25:54 +0000
Message-ID:
 <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
 <20250716160835.680486-3-dan.j.williams@intel.com>
In-Reply-To: <20250716160835.680486-3-dan.j.williams@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6998:EE_
x-ms-office365-filtering-correlation-id: 2c35839a-b4bd-4392-6163-08ddc556fc61
x-ms-exchange-slblob-mailprops:
 RlF2DIMZ1qX8TwvzfVmGBboO1FSL+3kOiZbMLKWUZxa8QwYHuHlp8TW7c05aw6aRuCWll4GBJFTbJ2pBlPWOxexCH6Em+MjZVDrbkhL2OleowWMCRs0ciXFZtyIpYzbA2qjPzYFgaexJgaNfjywOY8TGkFtiE9hzUXl8jJrJr40VwrkOk5CsKWg3I0lVcZz+4QYN2bndCU81vll+mMQli+8IheG2B0z5WLRWTWQ9kRTV7kRL5Npnang/aACcfC4T0lcQQCxZXEKPRG4pqR+Vu9JdU4kLrm2+EJrJtrF7fM2Tty18HxasUckWWq1vsglsdzdU8Ydo2+5bDZseM6cmb/k21aAqBDB8JDY6WOdkR0Cs7I9KMuLT71Lpxk+wMf4JQTq5efV98EmRDvT67xmvBBC0jGP2arjXrLCGPy+qnXk8vJmBKseoyaV9CnEI3IVqq8JmzVuZ1BqSX+cSfkycDMNpFonQ+BEhHXijhS2pByvDJKcFdfUGzk2vd+65RgWPwBfBQR7U8jeAtHTkXFMQavwauZPnkRZIHpT5JhXkjytadLB3/QImTElN0No+++7H1rF6krApnrfk/2twOSNBGonO0+sI+2RM+Nj1SNNu1DDqfTbZiesZp8bD3C0/GLPypuVAPTyGNV42RxmQF2FNdXkHnMrbDABd7mYbCVzJ4vojZjEbwEVozsZxjjlV6fpUEasrKBU8IvY0LOy+sqTKLqm3B1FlOvsbc/fjFKgUmcNx1MXTa2OQerI7B54vGmHbI49YVhQv8JlTprPJXNyRrQAXy1CSHaZdx/27Z8IBi31v93mQzpCAjkKHe3UA/f8hikk0sYpdtHWdv8q0lG7oiPAHu1/z0T6Q
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|461199028|1602099012|40105399003|3412199025|440099028|52005399003|4302099013|10035399007|102099032|12091999003|30101999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xN4lfMGnhyYflLE9yZUxX0MEcBH0k0mRXE74HGwsXKfQ4fTUdMt02qPFHKDB?=
 =?us-ascii?Q?c3oi3t2JjdYky/2CUOqKSEKqWnzPNgKgk7Oaj8jqhACW1KWC7srnWPVwOwag?=
 =?us-ascii?Q?iMbKJTbuiXrx24fwE77AtCmS+A3uclKCN3aIelOWe21kUgtVN67aMpiOTPQm?=
 =?us-ascii?Q?5rV+82zyccyQQmFbgLzwQA7XQVuHbi0nY5p3lqBUCorNqQAJG/A7MupW7dj8?=
 =?us-ascii?Q?AA7OfDOD53Bg5m0VRdPtDWtSBbZ2UNYvb4x+kc63zIstkbpwzVZ3LQGw+9xg?=
 =?us-ascii?Q?BJ+nOBUj/AjMz5kDTUIiCySxx+xDTQ8mqAv73cXJXXFwfR1FlAXNoF01THiF?=
 =?us-ascii?Q?21+dsZnAFJOPBpRWGPDiPKCG0nfwwNcRJkcPPiIZvdoU122LsgoZbtf4+bZG?=
 =?us-ascii?Q?0ieraucAfz2Sp72pBBUd/EPrtGbxxwW0t/wsggzBqig8KonpBeKj9yqDAHtD?=
 =?us-ascii?Q?QJUAl2LvEdaP4kIr3exooBMFmhFebP32g6gxHDOOECHZDH/2WpKDHfRzob/f?=
 =?us-ascii?Q?Koz9Em9fBcD/3NoMQwqVx9dRmpsr3O638ESDmb9SRiELUUfLl0WyHSrvwpHM?=
 =?us-ascii?Q?0CdzB4hRRn1pYkCaw3hP3LSjGfDvby4YNxEi8Xg4PnJ8Yx9Cy35y8DzCh7xA?=
 =?us-ascii?Q?VlGxN1oF6FuEE7kdqHg/4p4B/125yjbSEHsiaOue15Tu4+PjZ7U9sheGjwGk?=
 =?us-ascii?Q?AxqvPmfCw+NJYU+rUWCJbxzngktOnvDgrn7+E6oJqmlxzQl1mc72D28k7klB?=
 =?us-ascii?Q?nugV7ySyjHr/+OojmObHN6MRcPkK5bi7JhjIsSxSFz51k1OQzjqVfVLoBbGw?=
 =?us-ascii?Q?H6iAzzsnv5FB7Q/syEO70L/vIhqxabR6HJW7nnsg1r0CEDoyn+KRIWkQPOVa?=
 =?us-ascii?Q?lj9HeQQzwTsHHvVR4gSbv13tsVIRhVYUyyxdOOygAUaMIpjn+PZulwnBcQyG?=
 =?us-ascii?Q?H+W89LXyAtm3NGruA/e7VhJJeqbfE7zUjkOBbVhOhZSSMDf3SoOrYRBHvQln?=
 =?us-ascii?Q?wcsayxt2pVkyey144aFrnSnDa4h3cj3oiFnPntHBVcUJHsHJ6aMvp+I64Qpb?=
 =?us-ascii?Q?Y3ROB4ZUDsla6s0c/PYOnKcQEj/Jqpd30fzw654GJBPxt///xXqRPtt3m0Ts?=
 =?us-ascii?Q?XdXhxc6xfg55zJP6lSpuuh0iagliFX0P63fxrf+qyNwMAldbsw5ZiGZELdZz?=
 =?us-ascii?Q?jKeJXMQk2ZfAM5FZ+NhZRpnP7QcOvZOhGyFiqmCvIvHc822oWzCmgOEJsPiZ?=
 =?us-ascii?Q?Uxntv1AgEDskwh3bgkt7uKGaSKU0P9fS3J2nGzzArL/eVyn2PVWlGY7sF6jm?=
 =?us-ascii?Q?Bus=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tHURlpJja6GXBDUk1dmTkyE8pS5uM65pRMB1+7TniPSykk4sUGfxHzgaRM0M?=
 =?us-ascii?Q?/1gYCu/d+/9EALQMGSyiMqc7fNRlG5B6HfX0HEhi+0c8tl/X7t8oTszCfXy6?=
 =?us-ascii?Q?TOdNhOJ+2+5WWfbMJVq1YxRFtYXI3+5SLBLjGFLw3Ya3PCTVvhyXsMYKx2I6?=
 =?us-ascii?Q?D4/E8hSvxYSV9kEl2CPBn3+LH1tNF9biLEhpgZDz4BbKCrckt46b97O3Y0pe?=
 =?us-ascii?Q?j1VJsUjuNiyOmGj+ZG5Ujk4Ibjup/GG6aCejjB5rcO8qlGFHJlxY1IwRjVfW?=
 =?us-ascii?Q?EUPvnzD1wqNJF1s2+Nww0c4xX5wdH4PI6R6FdXCAVF2UtwAJAXOgTuwWfxZG?=
 =?us-ascii?Q?WbZ96wrFlvcNicnGJhgmNMgI04mQGlkk5NXfpsg/u0g6y7D6RduLAOuDGE9e?=
 =?us-ascii?Q?baFR8gXPCIK/R0aGNMDOrDe1z5lTPCU7o2eaf1b6UeuYGDNP/Q3QP1hE0wJX?=
 =?us-ascii?Q?OtjSSJ8g/81QaiponLz/bzZ8PSbh19JGVT2UOzByIC7GKLOEE1NPQWF131t2?=
 =?us-ascii?Q?oKkXwRRyP3pWOoqEh0774UKULWG1v4AtjGL6DK6+l8yJ82wVKm4TLm6keGEs?=
 =?us-ascii?Q?DthKAdadDorZojeXeKJIRtBHYEeLyGTkFV478B569uoGwjp44DnDTMYegPnf?=
 =?us-ascii?Q?2ZlTjPsE2fPmMFekf7JkrhDaCj0GODXvkyJ2wJcxR+cZCV/SjlfWKrkB+7k1?=
 =?us-ascii?Q?SkCM7UN/8OTuL7ugMFoqjpYpbusKku1akEqhPGsQdAMM0h4p8Fon3DteZ1s/?=
 =?us-ascii?Q?ujeatqXDJFsyfdYDRt3oLyFu5F0j/kTIqw4Ebw4RnVkSiPm+Dz0InXTTeRab?=
 =?us-ascii?Q?nnPMFx39ridZbQy+GiN25LYtbURb3ACj2qj54uldA067StUSW7kXXuARAa4Q?=
 =?us-ascii?Q?cJcdYf+jlNue871lPwaF8j+cLkz7IX3OofL9qPCzFK68NK3hWvi70CS4wkOH?=
 =?us-ascii?Q?9yvfb0E/U89oY/9S5WFAGrAHj7ipHWOC//LCgEOvNHFYJ6Qy48EzgpnTbrkQ?=
 =?us-ascii?Q?2cLgkuszXklG2FNH97RKil4DqJTetLDoQ5QejHi9oURSqgbcQuhgmpyLsPey?=
 =?us-ascii?Q?9rt+o3Qpl9OXxQYi0HEeK8/Ou5Rqq3Jq/El/B/S1LCADBnu31hltYjQO/rxM?=
 =?us-ascii?Q?OOzB9PKmfu8kyjKMQzPmiJsVucVkwZRToYyB+/qh08pyAYMjvHdeAhW21U2S?=
 =?us-ascii?Q?2ZzhP2nO/Pqr8pWaeqXRm8/pGKqW9OpPrHiJhpYGEGH0Ftvab4XhLppfpSg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c35839a-b4bd-4392-6163-08ddc556fc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 17:25:54.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6998

From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, July 16, 202=
5 9:09 AM
>=20
> The ability to emulate a host bridge is useful not only for hardware PCI
> controllers like CONFIG_VMD, or virtual PCI controllers like
> CONFIG_PCI_HYPERV, but also for test and development scenarios like
> CONFIG_SAMPLES_DEVSEC [1].
>=20
> One stumbling block for defining CONFIG_SAMPLES_DEVSEC, a sample
> implementation of a platform TSM for PCI Device Security, is the need to
> accommodate PCI_DOMAINS_GENERIC architectures alongside x86 [2].
>=20
> In support of supplementing the existing CONFIG_PCI_BRIDGE_EMUL
> infrastructure for host bridges:
>=20
> * Introduce pci_bus_find_emul_domain_nr() as a common way to find a free
>   PCI domain number whether that is to reuse the existing dynamic
>   allocation code in the !ACPI case, or to assign an unused domain above
>   the last ACPI segment.
>=20
> * Convert pci-hyperv to the new allocator so that the PCI core can
>   unconditionally assume that bridge->domain_nr !=3D PCI_DOMAIN_NR_NOT_SE=
T
>   is the dynamically allocated case.
>=20
> A follow on patch can also convert vmd to the new scheme. Currently vmd
> is limited to CONFIG_PCI_DOMAINS_GENERIC=3Dn (x86) so, unlike pci-hyperv,
> it does not immediately conflict with this new
> pci_bus_find_emul_domain_nr() mechanism.
>=20
> Link: https://lore.kernel.org/all/174107249038.1288555.123621005021094984=
55.stgit@dwillia2-xfh.jf.intel.com/ [1]
> Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Closes: https://lore.kernel.org/all/20250311144601.145736-3-suzuki.poulos=
e@arm.com/=20
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 53 ++---------------------------
>  drivers/pci/pci.c                   | 43 ++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  8 ++++-
>  include/linux/pci.h                 |  4 +++
>  4 files changed, 56 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ef5d655a0052..cfe9806bdbe4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3630,48 +3630,6 @@ static int hv_send_resources_released(struct hv_de=
vice *hdev)
>  	return 0;
>  }
>=20
> -#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> -static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> -
> -/*
> - * PCI domain number 0 is used by emulated devices on Gen1 VMs, so defin=
e 0
> - * as invalid for passthrough PCI devices of this driver.
> - */
> -#define HVPCI_DOM_INVALID 0
> -
> -/**
> - * hv_get_dom_num() - Get a valid PCI domain number
> - * Check if the PCI domain number is in use, and return another number i=
f
> - * it is in use.
> - *
> - * @dom: Requested domain number
> - *
> - * return: domain number on success, HVPCI_DOM_INVALID on failure
> - */
> -static u16 hv_get_dom_num(u16 dom)
> -{
> -	unsigned int i;
> -
> -	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
> -		return dom;
> -
> -	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> -		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
> -			return i;
> -	}
> -
> -	return HVPCI_DOM_INVALID;
> -}
> -
> -/**
> - * hv_put_dom_num() - Mark the PCI domain number as free
> - * @dom: Domain number to be freed
> - */
> -static void hv_put_dom_num(u16 dom)
> -{
> -	clear_bit(dom, hvpci_dom_map);
> -}
> -
>  /**
>   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -3715,9 +3673,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * collisions) in the same VM.
>  	 */
>  	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> -	dom =3D hv_get_dom_num(dom_req);
> +	dom =3D pci_bus_find_emul_domain_nr(dom_req);
>=20
> -	if (dom =3D=3D HVPCI_DOM_INVALID) {
> +	if (dom < 0) {
>  		dev_err(&hdev->device,
>  			"Unable to use dom# 0x%x or other numbers", dom_req);
>  		ret =3D -EINVAL;
> @@ -3851,7 +3809,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
>  free_dom:
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> +	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
>  free_bus:
>  	kfree(hbus);
>  	return ret;
> @@ -3976,8 +3934,6 @@ static void hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_remove(hbus->irq_domain);
>  	irq_domain_free_fwnode(hbus->fwnode);
>=20
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> -
>  	kfree(hbus);
>  }
>=20
> @@ -4148,9 +4104,6 @@ static int __init init_hv_pci_drv(void)
>  	if (ret)
>  		return ret;
>=20
> -	/* Set the invalid domain number's bit, so it will not be used */
> -	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> -
>  	/* Initialize PCI block r/w interface */
>  	hvpci_block_ops.read_block =3D hv_read_config_block;
>  	hvpci_block_ops.write_block =3D hv_write_config_block;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..833ebf2d5213 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6692,9 +6692,50 @@ static void pci_no_domains(void)
>  #endif
>  }
>=20
> +#ifdef CONFIG_PCI_DOMAINS
> +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> +
> +/*
> + * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida o=
r
> + * fallback to the first free domain number above the last ACPI segment =
number.
> + * Caller may have a specific domain number in mind, in which case try t=
o
> + * reserve it.
> + *
> + * Note that this allocation is freed by pci_release_host_bridge_dev().
> + */
> +int pci_bus_find_emul_domain_nr(int hint)
> +{
> +	if (hint >=3D 0) {
> +		hint =3D ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> +				       GFP_KERNEL);

This almost preserves the existing functionality in pci-hyperv.c. But if th=
e
"hint" passed in is zero, current code in pci-hyperv.c treats that as a
collision and allocates some other value. The special treatment of zero is
necessary per the comment with the definition of HVPCI_DOM_INVALID.

I don't have an opinion on whether the code here should treat a "hint"
of zero as invalid, or whether that should be handled in pci-hyperv.c.

> +
> +		if (hint >=3D 0)
> +			return hint;
> +	}
> +
> +	if (acpi_disabled)
> +		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> +
> +	/*
> +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> +	 * Other bits are currently reserved.
> +	 */

Back in 2018 and 2019, the Microsoft Linux team encountered problems with
PCI domain IDs that exceeded 0xFFFF. User space code, such as the Xorg X se=
rver,
assumed PCI domain IDs were at most 16 bits, and retained only the low 16 b=
its
if the value was larger. My memory of the details is vague, but I believe s=
ome
or all of this behavior was tied to libpciaccess. As a result of these user=
 space
limitations, the pci-hyperv.c code made sure to not create any domain IDs
larger than 0xFFFF. The problem was not just theoretical -- Microsoft had
customers reporting issues due to the "32-bit domain ID problem" and the
pci-hyperv.c code was updated to avoid it.

I don't have information on whether user space code has been fixed, or
the extent to which such a fix has propagated into distro versions. At the
least, a VM with old user space code might break if the kernel is upgraded
to one with this patch. How do people see the risks now that it is 6 years
later? I don't have enough data to make an assessment.

Michael

> +	return ida_alloc_range(&pci_domain_nr_dynamic_ida, 0x10000, INT_MAX,
> +			       GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
> +
> +void pci_bus_release_emul_domain_nr(int domain_nr)
> +{
> +	ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_release_emul_domain_nr);
> +#endif
> +
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static DEFINE_IDA(pci_domain_nr_static_ida);
> -static DEFINE_IDA(pci_domain_nr_dynamic_ida);
>=20
>  static void of_pci_reserve_static_domain_nr(void)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..e94978c3be3d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -632,6 +632,11 @@ static void pci_release_host_bridge_dev(struct devic=
e *dev)
>=20
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> +
> +	/* Host bridges only have domain_nr set in the emulation case */
> +	if (bridge->domain_nr !=3D PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_emul_domain_nr(bridge->domain_nr);
> +
>  	kfree(bridge);
>  }
>=20
> @@ -1112,7 +1117,8 @@ static int pci_register_host_bridge(struct pci_host=
_bridge *bridge)
>  	device_del(&bridge->dev);
>  free:
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	pci_bus_release_domain_nr(parent, bus->domain_nr);
> +	if (bridge->domain_nr =3D=3D PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_domain_nr(parent, bus->domain_nr);
>  #endif
>  	if (bus_registered)
>  		put_device(&bus->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..f6a713da5c49 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1934,10 +1934,14 @@ DEFINE_GUARD(pci_dev, struct pci_dev *,
> pci_dev_lock(_T), pci_dev_unlock(_T))
>   */
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
> +int pci_bus_find_emul_domain_nr(int hint);
> +void pci_bus_release_emul_domain_nr(int domain_nr);
>  #else
>  enum { pci_domains_supported =3D 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> +static inline int pci_bus_find_emul_domain_nr(int hint) { return 0; }
> +static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
>  #endif /* CONFIG_PCI_DOMAINS */
>=20
>  /*
> --
> 2.50.1
>=20


