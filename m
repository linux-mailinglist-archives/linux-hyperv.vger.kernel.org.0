Return-Path: <linux-hyperv+bounces-6564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09695B2CA96
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Aug 2025 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B087B3A5F2B
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Aug 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9F30148D;
	Tue, 19 Aug 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LXJ3kJ/6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2037.outbound.protection.outlook.com [40.92.41.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0D1FBCB2;
	Tue, 19 Aug 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624662; cv=fail; b=JMFokLmJap3KJ28V3T0CeLS5MGTue3IV921jyVRqco09O46KwlfRO+j1tW0B332juKtuLxs+wZs3TJXh+Z4if4hdSVizBThU4fPr1+CvR19+QSrogv6ZNCV7f3k8F+d1jPmTm3ZOnX8xCrfvmkzbfkrN6JWAQaiEttE0d9fGfMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624662; c=relaxed/simple;
	bh=3b2fO/rIFX8IhCpAC2p7RhH/qgnpSBP3vjd12y2OtVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=id/ZCtmKhKcla4lqhHpPkvQPPeqYXgMdcZL432dqYdKQe00MssTJ1dCyFPpDhW/l1cjlqW4VQ0v27UGz0OVrstxt8VxDKsfIz8PFaqW4qViI4INRCLWG7OZzpHnXQ+98JcFShVVFsqh5rRMbvLfaBfPTFLn+NW45EvOy4GARhGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LXJ3kJ/6; arc=fail smtp.client-ip=40.92.41.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orc28LJ5PI5/5WMQ0ZyiNcv8y/l25HlV1rYGxuFSD10ORqAGlf9rZHoerMQUWCfL210j6U5Ts6thUE+tKD42VIikIewRm+aJQdZm/dHOJlT95+ZypIjzW5Tkva39TjAIWpCzFGnS2XocNilgeaPyQD/S07HHjldVOfG25SFtCsuCH5goT3AZM70zBXuiVcdTGMq18xh0F7V864rvAiyRq4LDBJIV8aIWmU1+J/1g+PQAbmZZt6UrH2Ag5QKaHMR+uh1pVStPPi3L8rNF9VFrHTXlje1O4ytXU8roj1hovcHKGgPPlAM3nYH/AviN+ZquwyO2SMDxA14pJjUCewBoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuDHuPhSyo4qrmW6npGq9wQUJRozyKfz0gsxW2VDIbs=;
 b=ElIze5V3e/tsLVw5i70ypkzgO/5+FJR5clTRmlW5YCzUC6zCXKngXNV4715fA+otH1vj9HpEcdAiFwJQzTdbI0p9yC0Ltt01XaPzNc9GqTd4oOxBAUeN8gNGZ1b92baZNRWZYfYcp9N0iOpWOts9/YGgZh/mL/ojfRLAsrmCwsWYDxjxQyHvbw09WTW6UShBjE+YmYDrD3nwcVh90Xpfc++ikCjFUojmyGstl7hYL2iIBf59Yk/hq0jyVOP4Jxel9qefSmZj3/lst8QGvitPW9cKu7fMNZy6moY2PUkLpkvPAJn/qhPfp3VHQGaRzLJvjjBpiKxfYZPDA+hl4pFhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuDHuPhSyo4qrmW6npGq9wQUJRozyKfz0gsxW2VDIbs=;
 b=LXJ3kJ/6zlEjQtXSEEq21CvJtZyIZOvdO7brMZc0PE2bLnEpSKALGrvYmFEl4x1pr0VQRAY/AmzkZsWYV34X8cLXKD7da63BLWGx61dqd25wBOFbU3BozV9xlLnJXKoAYfPAB7TS5qQbP7xJB0NheAVK6aL5aKY9tckD4ozhaWoqJOFv7Ul1uBh6DBly5hzBlyKkQQJtuScVLkzJOrlNapStKh+yEwqOng+Ne1BvF99rrl+Vh/m01JHORbTkZ511CWoxM+uWXlBOL5//pbYrIJwSgB3oMes4BhHWL8dV+LyQhVSy+8dX9iP0Hbar++TIQAX6irrEoqO+LP3U/fFNqw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7966.namprd02.prod.outlook.com (2603:10b6:408:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 17:30:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 17:30:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, Li Tian
	<litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Subject: RE: [PATCH v2] x86/hyperv: Fix kdump on Azure CVMs
Thread-Topic: [PATCH v2] x86/hyperv: Fix kdump on Azure CVMs
Thread-Index: AQHcECYPQKX4fiH3e0mckaF4ks/rN7RpR5Tw
Date: Tue, 19 Aug 2025 17:30:55 +0000
Message-ID:
 <SN6PR02MB415738B7E821D2EF6F19B4E1D430A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250818095400.1610209-1-vkuznets@redhat.com>
In-Reply-To: <20250818095400.1610209-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7966:EE_
x-ms-office365-filtering-correlation-id: b8d07caf-9c37-4267-509b-08dddf46277c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|41001999006|461199028|31061999003|8060799015|8062599012|19110799012|3412199025|440099028|51005399003|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+axI2W+Uty42k65lpjiyBUuyoOzcPUXm7VYT1s+GCP24AN01Mcf1nI1IeURf?=
 =?us-ascii?Q?4brh+vwCm1HocaR9M6Blbak0dumdPlgzEOjYjJnfijl/jq4Kb8PkDenLEhAy?=
 =?us-ascii?Q?Oh/zPjrGSAFegA5nr67r4h6d2tNu0Tl0ctZX9OcKjR22rAoNJ2hnBW5MAiuL?=
 =?us-ascii?Q?6w1Nfqz3bE/Hvph1VjeeiDISUJBg4u1f58ZEvX3PjgEHrDbLpw/2GeYpgGcD?=
 =?us-ascii?Q?eAq89X5YiEs9T5ys5AoqLzVNT4VWhP9iaGauQGQWUjojG78yk83ptZbfAq36?=
 =?us-ascii?Q?GoWObGMvgMzCedMAdirUJOeJlW5FNGYyN1efyLplzQFSr5i19Y4jbcOSnYj8?=
 =?us-ascii?Q?oxxcbLvXttrbqCe4mV3BUSfFCO/gaDh3ivYp2k/ZXXSCAM8DuQTWn5fTbjV2?=
 =?us-ascii?Q?fVNW3j3VjiT8ygdll20RhoJaWf75NQtM+bOGo/JHs7I13pG+Whu+JHmnCmdP?=
 =?us-ascii?Q?CuvhHSGwSbQuvySe1hve+uYmc7VerwS4yTLK83TpGW2GIQWcVwj5B2lz+mco?=
 =?us-ascii?Q?HSzOniB21WzuDgzL/RWd6ErGQOnB/6iKBin3xwkOgZUnYX1H4j0bhWXAv/7q?=
 =?us-ascii?Q?lrr1a+X0fsluTxlYq/P2Yw/wi+IxSV3G7nqURP2YFdHJPTiosf1KMawA70AA?=
 =?us-ascii?Q?c4aI8UVsfJ995eS0mVaJZknHD91FixQu/FGZfFWSeK6JCQRDI0G6yO9dd8Nf?=
 =?us-ascii?Q?zGg1Tqkf0PM5oX2VWYgiwM5eUzFN/ggj8eRd6HCnkJveUIBjmNwvpYun7Jv9?=
 =?us-ascii?Q?kwA3sZLHvSjpP0Vw10cARuc48NcfYndKF2AHKPECsQerIgL6ogSy4dUOJtmI?=
 =?us-ascii?Q?ZNxvcaohXRwjn0HbU6dyTpJLCTSr6jDxdtF9dc0hQriuhIYb6Pw7YEkVcMkQ?=
 =?us-ascii?Q?we5+FhHs8ly5X/eItmMRT9Z2lRIpEjUCgfe+ptC1K9YBpuotq9/IldgXAoZ+?=
 =?us-ascii?Q?+rSAnyXHENOmDjBJ/fOPL50Tv3CQMuB0HubWmpnabUgipTQGf/hj5JYsL3mB?=
 =?us-ascii?Q?+gexJeEMwYgJC0DgJZT6UkqzAYCwywLLxqK+JIetUqFPUytCSpBR0fQnOUn8?=
 =?us-ascii?Q?0IaK7tv78DHDD7DwYZytXC0HyV6+e16FcogHspa1RrzTt465ydPVtHV+MViG?=
 =?us-ascii?Q?ynLSIfFklAjJ4bhzhtDFy/MgEHCTq9ABKY/MccBRtkv/Z131dxsnwJdA9iyL?=
 =?us-ascii?Q?5YhCRhwGOV0gkm6WGFHCEo6xyqqn7AFY+Oa2WCfTGqwc3pLdTjLQWi9ypDJi?=
 =?us-ascii?Q?n79h/TiGAzC3myRzP62LRqxsslQxPaLpa0nqYkA7MA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o5lgfoOU5My0Pu9K27iKrdCUW+vW9dXeHWhJCLu1/CBlSgXgKQ9HFvx75W0J?=
 =?us-ascii?Q?gw6I0bHXEZIm3jY78uEZV6O87e7yr7XbiuqIH+Rb4VKgRUk3Bunnclq+SpjJ?=
 =?us-ascii?Q?ML6QXBJnscbbnqLJ1oDi1ziQxkT16WIGRruBfagKosq2fh1uKXVY0q1HtBUM?=
 =?us-ascii?Q?EggKa3E/ZGB9VYyS1QBOUyll9fDPOHfCGvqhm+R3jTE423ktNLgHMVjPyNvL?=
 =?us-ascii?Q?XfudI9FGeR4Qu1+twPElKMejYNICtcTwPRyBuejgyi+NfEi/6NsuYG7Lpkte?=
 =?us-ascii?Q?eP9ISLZBOiGxQn8qKJW/BUdWvy7kw7vzS/lANlhTeV1JQX9KrRnfGwgg5dy4?=
 =?us-ascii?Q?oBnuEXEsi0c7PiUcD2QPOzDfJifB+Orv4tHd//hNNEdAMHeanc+rhBC+7/wv?=
 =?us-ascii?Q?KDcrK1gUfePmrpcBAfQSE8indURW+pVMWUdaYpMVkJWOu5MLKF1bXVj4V5G0?=
 =?us-ascii?Q?rz9UH98Lus0Fvnzvz6z5ZsHqbe/g9KWQCEzfGSmMeTu7AnLqreaGG/mRNVoT?=
 =?us-ascii?Q?9J0P6nFYsGel158kZiMbjYwoXoERhRPVaiKJfY2FOV64DQhyLqVKFJtgRBTf?=
 =?us-ascii?Q?2sX/DUShNFVtLanx3YErU/cnzfH9YGAtGDhLnZCFxoAb2zQuAw/+XN4sfDRv?=
 =?us-ascii?Q?Wx+w9SG/VRMFy/7VK1jmQQYykOjzBiTqA4OLyBj2/dml+y2kk1PJ7X1CaVg6?=
 =?us-ascii?Q?xePTOPnYQFYoLx7jY8x7CYi93S+J1cRPhuDBmaYu06enYKDF3y5eSlo3Oa3d?=
 =?us-ascii?Q?/RXj95YZbtaCLtyJOem/5UC0eFnN3PFZxwgiXLnWYWXQlZBUW4zjylJjAxAn?=
 =?us-ascii?Q?vxu0+RY+XPFe87e25i1O9V3Fe7HOsqoj70frbtYy05Rp5m1ENGCvylAFzsBe?=
 =?us-ascii?Q?EK2TgOWkkjXuLcKM8AWxToxba4PwyryPMaoSKd8PoeolZUjYsAubWiHIaQXo?=
 =?us-ascii?Q?XIV4swTs0SS3ijGTTyrFidJbgDCqljktpU/qO48sHwNAATxF3WmlZgk73ufA?=
 =?us-ascii?Q?GJa2BUru7E0oTg2SbMgV/L8m+qFd5W3A+JUblSBYTV98vNgCg5nkLBgZxa7E?=
 =?us-ascii?Q?9dBSFZvk8K3oWG5LAU0J5b58fbNVxkmeVBHCnzuaoQ+TNh76SfNNZzr82GKn?=
 =?us-ascii?Q?+E6DotuGe0M3GzgZDRfV0zdZwJtVzOOVQ7JWTOffq/R/O18Rm0SE0nebQiKn?=
 =?us-ascii?Q?USkAUj6YwF7Pb89CKKAlkAgqy9vqVHTO4CsnWHrFQMb/kcdVBGcnMRiRBqg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d07caf-9c37-4267-509b-08dddf46277c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 17:30:55.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7966

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, August 18, 2025 =
2:54 AM
>=20
> Azure CVM instance types featuring a paravisor hang upon kdump. The
> investigation shows that makedumpfile causes a hang when it steps on a pa=
ge
> which was previously share with the host
> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> knowledge of these 'special' regions (which are Vmbus connection pages,
> GPADL buffers, ...). There are several ways to approach the issue:
> - Convey the knowledge about these regions to the new kernel somehow.
> - Unshare these regions before accessing in the new kernel (it is unclear
> if there's a way to query the status for a given GPA range).
> - Unshare these regions before jumping to the new kernel (which this patc=
h
> implements).
>=20
> To make the procedure as robust as possible, store PFN ranges of shared
> regions in a linked list instead of storing GVAs and re-using
> hv_vtom_set_host_visibility(). This also allows to avoid memory allocatio=
n
> on the kdump/kexec path.
>=20
> The patch skips implementing weird corner case in hv_list_enc_remove()
> when a PFN in the middle of a region is unshared. First, it is unlikely
> that such requests happen. Second, it is not a big problem if
> hv_list_enc_remove() doesn't actually remove some regions as this will
> only result in an extra hypercall doing nothing upon kexec/kdump; there's
> no need to be perfect.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
>  - fix build on ARM [kernel test robot]
> ---
>  arch/arm64/include/asm/mshyperv.h |   3 +
>  arch/x86/hyperv/ivm.c             | 153 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   2 +
>  drivers/hv/vmbus_drv.c            |   2 +
>  4 files changed, 160 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index b721d3134ab6..af11abf403b4 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -53,6 +53,9 @@ static inline u64 hv_get_non_nested_msr(unsigned int re=
g)
>  	return hv_get_msr(reg);
>  }
>=20
> +/* Isolated VMs are unsupported on ARM, no cleanup needed */
> +static inline void hv_ivm_clear_host_access(void) {}

Stubs such as this should be handled differently. We've instead
put __weak stubs in drivers/hv/hv_common.c, and let x86 code
override. That approach avoids needing to update arch/arm64
code and to get acks from arm64 maintainers for functionality that
is (currently) x86-only. arch/arm64/include/asm/mshyperv.h is
pretty small because of this approach.

For consistency, this stub should follow that existing pattern. See
hv_is_isolation_supported() as an example.

> +
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index ade6c665c97e..a6e614672836 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -462,6 +462,150 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
>  		hv_ghcb_msr_read(msr, value);
>  }
>=20
> +/*
> + * Keep track of the PFN regions which were shared with the host. The ac=
cess
> + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
> + */
> +struct hv_enc_pfn_region {
> +	struct list_head list;
> +	u64 pfn;
> +	int count;
> +};

I'm wondering if there's an existing kernel data structure that would handl=
e
the requirements here. Did you look at using xarray()? It's probably not as
memory efficient since it presumably needs a separate entry for each PFN,
whereas your code below uses a single entry for a range of PFNs. But
maybe that's a worthwhile tradeoff to simplify the code and avoid some
of the messy issues I point out below.  Just a thought ....

> +
> +static LIST_HEAD(hv_list_enc);
> +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
> +
> +static int hv_list_enc_add(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	bool found =3D false;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		found =3D false;
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_for_each_entry(ent, &hv_list_enc, list) {
> +			if ((ent->pfn <=3D pfn) && (ent->pfn + ent->count - 1 >=3D pfn)) {
> +				/* Nothin to do - pfn is already in the list */

s/Nothin/Nothing/

> +				found =3D true;
> +			} else if (ent->pfn + ent->count =3D=3D pfn) {
> +				/* Grow existing region up */
> +				found =3D true;
> +				ent->count++;
> +			} else if (pfn + 1 =3D=3D ent->pfn) {
> +				/* Grow existing region down */
> +				found =3D true;
> +				ent->pfn--;
> +				ent->count++;
> +			}

Observations that might be worth a comment here in the code:
After a region is grown up or down, there's no check to see if the
region is now adjacent to an existing region. Additionally, if a PFN
that is already in some region is added, it might get appended to
some other adjacent region that occurs earlier in the list, rather than
being recognized as a duplicate. Hence the PFN could be included
in two different regions.

> +		};
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +
> +		if (found)
> +			continue;
> +
> +		/* No adajacent region found -- creating a new one */

s/adajacent/adjacent/

> +		ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
> +		if (!ent)
> +			return -ENOMEM;
> +
> +		ent->pfn =3D pfn;
> +		ent->count =3D 1;
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_add(&ent->list, &hv_list_enc);
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hv_list_enc_remove(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent, *t;
> +	unsigned long flags;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
> +			if (pfn =3D=3D ent->pfn + count - 1) {

This should be:
			if (pfn =3D=3D ent->pfn + ent->count - 1) {

> +				/* Removing tail pfn */
> +				ent->count--;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}
> +			} else if (pfn =3D=3D ent->pfn) {
> +				/* Removing head pfn */
> +				ent->count--;
> +				ent->pfn++;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}

Apropos my comment on hv_list_enc_add(), if a PFN does appear in
more than one region, this code removes it from all such regions.

> +			}
> +
> +			/*
> +			 * Removing PFNs in the middle of a region is not implemented; the
> +			 * list is currently only used for cleanup upon kexec and there's
> +			 * no harm done if we issue an extra unneeded hypercall making some
> +			 * region encrypted when it already is.
> +			 */

In working with Hyper-V CVMs, I have never been entirely clear on whether t=
he
HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY hypercall is idempotent.
Consequently, in other parts of the code, we've made sure not to re-encrypt
memory that is already encrypted. There may have been some issues back in t=
he
early days of CVMs that led to me think that it is not idempotent, but I do=
n't
remember for sure.

Do you have a particular basis for asserting that it is idempotent? I just =
ran an
experiment on a TDX and a SEV-SNP VM in Azure, and the behavior is idempote=
nt
in both cases, so that's good. But both are configurations with a paravisor=
, which
intercepts the hypercall and then makes its own decision about whether to i=
nvoke
the hypervisor. I don't have the ability to run configurations with no para=
visor, and
see whether the hypercall as implemented by the hypervisor is idempotent. A=
lso,
there's the new OpenHCL paravisor that similarly intercepts the hypercall, =
and=20
its behavior could be different.

Lacking a spec for any of this, it's hard to know what behavior can be depe=
nded
upon. Probably should get clarity from someone at Microsoft who can check.

> +		};
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +}
> +
> +void hv_ivm_clear_host_access(void)
> +{
> +	struct hv_gpa_range_for_visibility *input;
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	u64 hv_status;
> +	int cur, i;
> +
> +	if (!hv_is_isolation_supported())
> +		return;
> +
> +	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (!input)
> +		goto unlock;

The latest hyperv-next tree has code changes in how the
per-cpu hypercall input arg is handled. Check it for examples.

> +
> +	list_for_each_entry(ent, &hv_list_enc, list) {
> +		for (i =3D 0, cur =3D 0; i < ent->count; i++) {
> +			input->gpa_page_list[cur] =3D ent->pfn + i;
> +			cur++;
> +
> +			if (cur =3D=3D HV_MAX_MODIFY_GPA_REP_COUNT || i =3D=3D ent->count - 1=
) {
> +				input->partition_id =3D HV_PARTITION_ID_SELF;
> +				input->host_visibility =3D VMBUS_PAGE_NOT_VISIBLE;
> +				input->reserved0 =3D 0;
> +				input->reserved1 =3D 0;
> +				hv_status =3D hv_do_rep_hypercall(
> +					HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY,
> +					cur, 0, input, NULL);
> +				WARN_ON_ONCE(!hv_result_success(hv_status));
> +				cur =3D 0;
> +			}
> +		}
> +
> +	};
> +
> +unlock:
> +	raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(hv_ivm_clear_host_access);
> +
>  /*
>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>   *
> @@ -475,6 +619,7 @@ static int hv_mark_gpa_visibility(u16 count, const u6=
4 pfn[],
>  	struct hv_gpa_range_for_visibility *input;
>  	u64 hv_status;
>  	unsigned long flags;
> +	int ret;
>=20
>  	/* no-op if partition isolation is not enabled */
>  	if (!hv_is_isolation_supported())
> @@ -486,6 +631,14 @@ static int hv_mark_gpa_visibility(u16 count, const u=
64 pfn[],
>  		return -EINVAL;
>  	}
>=20
> +	if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE) {
> +		hv_list_enc_remove(pfn, count);
> +	} else {
> +		ret =3D hv_list_enc_add(pfn, count);
> +		if (ret)
> +			return ret;
> +	}

What's the strategy if there's a failure from the hypercall
further down in this function? The list could then be out-of-sync
with what the paravisor/hypervisor thinks.

> +
>  	local_irq_save(flags);
>  	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index abc4659f5809..6a988001e46f 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -263,10 +263,12 @@ static inline int hv_snp_boot_ap(u32 apic_id, unsig=
ned long
> start_ip,
>  void hv_vtom_init(void);
>  void hv_ivm_msr_write(u64 msr, u64 value);
>  void hv_ivm_msr_read(u64 msr, u64 *value);
> +void hv_ivm_clear_host_access(void);
>  #else
>  static inline void hv_vtom_init(void) {}
>  static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
> +static inline void hv_ivm_clear_host_access(void) {}
>  #endif
>=20
>  static inline bool hv_is_synic_msr(unsigned int reg)
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2ed5a1e89d69..2e891e108218 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2784,6 +2784,7 @@ static void hv_kexec_handler(void)
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>  	mb();
>  	cpuhp_remove_state(hyperv_cpuhp_online);

At this point, all vCPUs are still running. Changing the state of decrypted=
 pages
to encrypted has the potential to upset code running on those other vCPUs.
They might try to access a page that has become encrypted using a PTE that
indicates decrypted. And changing a page from decrypted to encrypted change=
s
the memory contents of the page that would be seen by the other vCPU.
Either situation could cause a panic, and ruin the kexec().

It seems to me that it would be safer to do hv_ivm_clear_host_access()
at the beginning of hyperv_cleanup(), before clearing the guest OS ID
and the hypercall page. But maybe there's a reason that doesn't work
that I'm missing.

> +	hv_ivm_clear_host_access();
>  };
>=20
>  static void hv_crash_handler(struct pt_regs *regs)
> @@ -2799,6 +2800,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	cpu =3D smp_processor_id();
>  	hv_stimer_cleanup(cpu);
>  	hv_synic_disable_regs(cpu);

Same here about waiting until only one vCPU is running.

> +	hv_ivm_clear_host_access();
>  };
>=20
>  static int hv_synic_suspend(void)
> --
> 2.50.0


