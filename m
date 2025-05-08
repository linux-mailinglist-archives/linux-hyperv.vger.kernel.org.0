Return-Path: <linux-hyperv+bounces-5426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3CAAF1F0
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 06:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12211BC2ED2
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DB1FFC74;
	Thu,  8 May 2025 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qgeFT/Az"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010012.outbound.protection.outlook.com [52.103.20.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225D19BBA;
	Thu,  8 May 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677034; cv=fail; b=QZYWGknQYgj7EieL50KA2S1gkBuIcNIaeVgqECyJEOKN/AuOab1VGK1+o4jlVyom49v/TF4Mp8rOwa4FKCRpOO844Be9ra0IW28XhantFudwvKEMV8wNREZkUP34qibV9XjhfCPue266Qt41MZ674zN+EwehwKXkqDYQq39Ymyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677034; c=relaxed/simple;
	bh=FXoO5WowA+Hogc2B/xOsgGjf1AluNZKxK7TTuXNT9nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DOLd8WOrRiipvkgkq1p3at8SkfMkS70zAFNbBm+VoGegLXYKU2wALjyaIrjho9+dghpCyUPTDvL3gAaLNjG97TPTm/gHrN7oOT5iWuTbwBCve0lVbHpTIfex2TKGqq78RlhFcosuuh+suiHmLCoI8Kp9qx46pcPhPtXe/Ru28Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qgeFT/Az; arc=fail smtp.client-ip=52.103.20.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICaS/dnLIwNew2lEsQ2NK/jtzIqBHs3I1wZiZz2xlD/S7Ygvh5f/JJLSR4R05LVx9tOM2sDq/0p/QHeSuPK3PWVfmLS2HKPslivga4cVGCgg3Abo9aIbyC1amHob+RaVtK73C8uXOXutge7qUm6kP1MMKExh5HmFSnvijbaWzDQu0eY9OeqXOh6iOE6zUiIA1Liw/1HKa6kORm3hbjLPmvaQds40M4s+LSCeKKdA7NEeuqnKAD0xlF9nO27loxTiBtGWJujVcCsWdE3ijq0itiILgMh7tAUhpOrSrthPPh3037DekJYeu2zjIVxqR2/XvjxfcB+Wk0QY/Jj9qTeg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2FT14G5WUwrFyCJTZDjxJMM+Wvq0sUXZhyZGccRqXE=;
 b=mh1BezObKyIPXL9REWMEi6A+Z3leQeqdRIb7O4gvG1YjkWL09xYYkoD0zDxrVePd+RuLK85W5RAnwoRDXh3NDjiRMz5t89CLebCyZsyAsD7+uAGvH+m6DBr5DLXltc8GljE0eiTK/nfv/oa2ahD4c66UTSl2k4W2WI1+zVQ43r9Oc88vdR8PfOl3inR0rdHWgq/Lb3RIdXGAh+WH25kexvJnA1XOgypUvXp5aZvZJ31IT9YD4NY5Y6iWwNddM0vIiijG2wBJSc/DzF2apx9iRmzuRznIUqf2GkXwISLB6x89yWLsvqettV9p3lEztxZircllMHaJUMoIVqiqS4H/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2FT14G5WUwrFyCJTZDjxJMM+Wvq0sUXZhyZGccRqXE=;
 b=qgeFT/AzbT8DuZvRnkgLbz9p1eezbUXONqONw7Jn0wKy5gnmo4WYgt0fEmhUQyPBCCXEw5WDIMNCHr5JmDcJb1+2EmGZLDsU3Qymy6W3oB7CUKcNdsnu9AlcGnvtGe1KG89TCepKWmbAEk2CFeLe8iXsMUeF0Cpb0ziVTJLRhDC2I5rydIw54ZHHdhJsE2gqRNRTCEyH23G2MFszwUiCFcWFyVzCsLw3vDVdC4HhFIypf9oIgqHl6uYvjryV/rkFOlaP8HcESsGktuWmre4jil6as/JUUXwWyyvJoHBh/xoQ2oiH4w00Y4Y0gb2lDmfNoKB3xbjdIqLmgM6B1Oz3BA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7249.namprd02.prod.outlook.com (2603:10b6:303:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 04:03:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 04:03:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>, Naman Jain <namjain@linux.microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Anirudh Rayabharam <anrayabh@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPo2K73dQwbLkKS9L76qOPuv7PHI72AgABpswCAAI9hUA==
Date: Thu, 8 May 2025 04:03:49 +0000
Message-ID:
 <SN6PR02MB4157D124B1AF145E06431BD2D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
In-Reply-To: <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7249:EE_
x-ms-office365-filtering-correlation-id: 4cb44e9e-ac1c-41d0-ba24-08dd8de556ac
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|19110799006|8062599006|8060799009|15080799009|4302099013|3412199025|440099028|10035399007|12091999003|34005399003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9JQ5TttlW/zWAiCogJE7tVZNCKWpBS//m3ntmNd2bMIJ1l6UlHozvtf7K9ph?=
 =?us-ascii?Q?AH3vSGJ75vE4jkTMFfle8cijB/vJlwD6zJdLPXci3DwJWsZvyLCHVFxzwU1A?=
 =?us-ascii?Q?wwr8UxTTko98tsFgBPiqo99vIm02xREwYVJxXOBp9T4b/iUYEtfLUpxkZL3S?=
 =?us-ascii?Q?ZGeWpdFsrrvw/K+wxo6+jNqUQffGiy8pD+YK5hanUZgNNeNjYFvdI8yWvN1S?=
 =?us-ascii?Q?TeWX3NMc9Jh2VPyaG0N2GWX/yo5XM30eZXrtqqk+vDjlRQrIDd+6dVfHNxo7?=
 =?us-ascii?Q?ttHujE8/dzGhdxC6E0LXlfa+zz4xaLil5BsEpTszhumo65dqs1WAA1ImrIiL?=
 =?us-ascii?Q?SnjGXeDYeD4zbsg88F2FWHYrR8Ich8bOWC1O/+R1cHXsLUUQ7XQnM5jk+KrE?=
 =?us-ascii?Q?WsP6ZEJv/VfyRfeU9AkPbQLrxXap27cIrpQUFp6H7X74sCGhayD2MBPBYrHg?=
 =?us-ascii?Q?bOpTDSsmaHayv8TEOAXnW5eUB9ORBEtGO2M3ZN9ND3blAnVKK9zNbk9LCpRf?=
 =?us-ascii?Q?ZNyBoIez4S7iG6Fy4pJFBrisllVN1W2HGMQsco3fVgikNtZHt+wUeXJZsh8R?=
 =?us-ascii?Q?PQF33ZrP4KoEt1CmKyT8D720I0nL/vz5cs5uTPCf+cQUXd+PU8qoMbZ12bJ8?=
 =?us-ascii?Q?ByQNGRfpNIszksNkfpR7uQvf18n+ZvyxpBpu95KqcXR6oIsV75YXfvLelJ/o?=
 =?us-ascii?Q?JUWqimLol9GmST3Un6JsAYNtDl0yNJO64VtVq0339Nr42vKzkAv5ud/Vw52m?=
 =?us-ascii?Q?yr2K0pGiZ28gFyvA45w/CIWnn7KmAjDbCmkuSRwTvlb/XESO8Z9LwiO0aguV?=
 =?us-ascii?Q?5Lte3VCf2JMpw4fQHU8LJgfzxDk5f2Vn3CMVE3vIZv64t6bQajOJ5apA8ntp?=
 =?us-ascii?Q?E6oIu3+V7i+wkJp8sVQNHKZDiqQ/A0PqMStRYE3SBut6gNqAsUKGHe2Zdsed?=
 =?us-ascii?Q?Rf2oOGVaw6NurfabCyygE4sg6WLHdqV0+qBgHqndwBmYfMMAtpHNkxHa0H41?=
 =?us-ascii?Q?1q6NJS5otjCzuvr+ZrZn64HHMzVO+pZl+8lo1foMAhESNDJuOQD/dlkBI+Wk?=
 =?us-ascii?Q?IPvrgokN5pq947yJ9gISTFaqG7djsW+x04hqmkwZY548MccgMVrn4rwObVkd?=
 =?us-ascii?Q?mxzVthVxyI5rt9LZuLRGl9kmF6W71Uyf7Z8ph65ltTe0jMDc5ifdnzE+G5GL?=
 =?us-ascii?Q?F+Y8x1jsScO2h+GKgRD6hfmTyEHD3paewphrAj6+GSBy0tM5chzQVemr3Rwu?=
 =?us-ascii?Q?7UOfUkxH+bGqookfPGqKBVxlaqzS3CBFhai1XCsJF9xD+ZGyOv09kR0gclXz?=
 =?us-ascii?Q?8A4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l4xno8o5KUiQU6d+ueZ2vx3aIUdtuXEpVbyQsinFsNq9V6YyF88yaD9S51Ak?=
 =?us-ascii?Q?idO3b3Oc+WPLPUBv0n7JnQzMzZ/NZJ/RRXz1iaOq/R3iImhvuf8sgphgp4Sl?=
 =?us-ascii?Q?29/vZ7ZSlgvjPbXu9fd9jU5O45rFP1dJNEB/u6FYTx5d0Lv/fgDt4QrUAolb?=
 =?us-ascii?Q?FjCMkfQLQ7OY0oniCN+ZHUN03WA9AZEA3wXUWOXhJZSg73bB0sejAMbuYWSl?=
 =?us-ascii?Q?cvo00w2Cv4AFQ8A8YR7oS3Ap8gGcOqjldeJWsIpCld2WxeC7UDEDORVYCxOu?=
 =?us-ascii?Q?YnWRtkJWqAjSjkMJissG8FikEf+RrdzBEMMRROZai8sumKsLAKAk7XPnJmUn?=
 =?us-ascii?Q?H9DIwDey8NgPVZxnuLDEOfKvOCL/4aOPrpxim6/OPZSpRLLb9vLyBymCKxYE?=
 =?us-ascii?Q?nVW74BJHg4+P7e0vKZYntCaBLxcy5yG1P911dFJsdO+KEYkAP9PQGXrm6pJV?=
 =?us-ascii?Q?i4wcFaF3AVDTIbxK21BH/l9azYMWA5LQ4M2bm96pCqmgmAOdtv4uxpYwgVTe?=
 =?us-ascii?Q?3j4pievyMp+zvRNKb7JRcteL0dd4awYQoLgSw3TAzS2eQUQGM8D3cYAaVMit?=
 =?us-ascii?Q?E70gnXazxJ4GEoeY0SoLYcmaDmjBD6/Zrs6FrRflcfi4pVHszL44qlO9z4xm?=
 =?us-ascii?Q?b7wtE9/J8sS/5eyasQyNDVRSS28CeNtU8POFX3BRkxXlFfO21KjnmdQ7IpN/?=
 =?us-ascii?Q?DBZS6oc7tNLqYAYdWz7MaPFCn67Jf+Y3tZqoc8HF2kCNIQiNYCSRKOqW5uFx?=
 =?us-ascii?Q?nIPyesI7XRAOm3qT2ooUShflTXUxB7oYrKOIuIQ2yOxQDQVg3KyGfKB7sBsM?=
 =?us-ascii?Q?ee5g6k/KYNRBnBc/8zdTwgtKUM711sj6IAMV/v48oUKQnA6jsdTxvemSU2ww?=
 =?us-ascii?Q?7yWsegAqIN3Pc+y0D9+e+WJHi3vB1ZjqxqKwQYophWr1KD0iD88QzBMtRRfx?=
 =?us-ascii?Q?KSy5SBgiOvKAKxQiBUv2jTUJHOz23LkWag9RS8cyeyXJ6GDvTYMJPD6yuZeT?=
 =?us-ascii?Q?GcDlRFa3OptSNmHyeWG1WurfcpoqaxgTOkUGY9hOuSOed08uDkqh0EUBAQFP?=
 =?us-ascii?Q?3IpMdq908h+o6SeddePdL1Nux7zjEpufzyV+PZfJL6L/JfwUSuO+nfph8nfD?=
 =?us-ascii?Q?nz4RDB+eOCtvzvqvZIzkkgsCdRRG2Ol/vN9xkALix+JYwtpTRbJGOz9ky6ay?=
 =?us-ascii?Q?n2imVLB45WO4U2yi1deNpclASwP3ffxbJUq0o+g83yzWnxiYu1T0CtPWLbc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb44e9e-ac1c-41d0-ba24-08dd8de556ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 04:03:49.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7249

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, May 7, 2025=
 12:21 PM
>=20
> On 5/7/2025 6:02 AM, Saurabh Singh Sengar wrote:
> >
> [..]
>=20
> >> +	}
> >> +
> >> +	local_irq_save(flags);
> >> +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +	out =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >> +
> >> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
> >> hvcall.input_size)) {
> >
> > Here is an issue related to usage of user copy functions when interrupt=
 are disabled.
> > It was reported by Michael K here:
> >
> > https://github.com/microsoft/OHCL-Linux-Kernel/issues/33
>=20
>  From the practical point of view, that memory will be touched by the
> user mode by virtue of Rust requiring initialization so the a possible
> page fault would be resolved before the IOCTL. OpenHCL runs without swap
> so the the memory will not be paged out to require page faults to be
> brought in back.
>=20
> I do agree that might be turned into a footgun by the user land if
> they malloc a page w/o prefaulting (so it's just a VA range, not backed
> with the physical page), and then send its address straight over here
> right after w/o writing any data to it. Perhaps likelier with the output
> data. Anyway, yes, relying on the user land doing sane things isn't
> the best approach to the kernel programming.
>=20
> If we're inclined to fix this, I'd encourage to take an approach that
> works for the confidential VMs as well so we don't have to fix that
> again when start upstreaming what we have for SNP and TDX. The
> allocation *must* be visible to the hypervisor in the confidential
> scenarios.
>=20
> Or, maybe we could avoid the allocations by reading the first byte
> of the user land buffer to "pre-fault" the page outside of the
> scope that disables interrupts. Why allocate if we can avoid that?
> Could set up also the SMP remote calls to run this on the desired
> CPU.
>=20
> Summarizing for the case you want to change this:
>=20
> 1. Keep interrupts disabled when reading/writing to/from the Hyper-V
>     driver allocated input and output pages.
> 2. If you decide to allocate separate pages, make sure they are
>     visible to the hypervisor in the confidential scenarios. I know
>     we're not talking SNP and TDX here just yet but it would be
>     a waste of time imho to build something here and scrape that
>     later. The issues with allocations are:
>         a) If allocating on-demand, we might fail the hypercall
>            because of OOM. That's certainly bad as the whole VM
>            will break down.
>         b) If allocating for the whole lifetime of the VM,
>            let us remember that we avoid using hypercalls
>            due to their runtime cost. We'll be keeping around
>            2 pages per CPU for the few times we need them.
> 3. Consider reading a byte from the user land buffers to make the page
>     fault happen outside of disabling interrupts. There is no
>     outswap (maybe could have disabling swap in Kconfig) so the page
>     will stay in the memory.
>=20
> If you're not changing this, feel free to keep my "Reviewed-by".
>=20

Regardless of what might be done to prevent a page fault, I don't
see an option to not fix this. copy_from_user() contains a call to
might_fault(), which in turn calls might_sleep(). The intent of these
runtime "annotations" is precisely for the kernel to check for such
errors and complain about them. The complaining is suppressed unless
CONFIG_DEBUG_ATOMIC_SLEEP is set, but we want to be able to
set that option for debugging purposes and not have this code
generating complaints.

Michael

