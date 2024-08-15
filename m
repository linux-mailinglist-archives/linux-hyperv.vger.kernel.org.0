Return-Path: <linux-hyperv+bounces-2776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10A9538F8
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FF1B226C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B182A1B3F2F;
	Thu, 15 Aug 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gudjo731"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2026.outbound.protection.outlook.com [40.92.41.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E07DA73;
	Thu, 15 Aug 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742753; cv=fail; b=Cib0UB3jpc6McC6y/HuStgQe4CR5XVyR/XNoneb0XGcrOXgW6mwHVWDeJve4Y6aVxejexTUKXnTP0EqjUjXCZ0GTHG1aKzCxr8lSMJ7Sbh3h8/q/TrEpOpLOFvGacTCrziXg4v6tgAC4rXsQCLAh0IUb/RLLdQoPTOZL1IU0luk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742753; c=relaxed/simple;
	bh=NeUIByaRs2YeFExklF3PXTI6CQiUh5s5i5wgVTR37q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ognpZSaWjmJlFLZUdWVlNyQb74tMf6GECixJ08Ix/2u8X9Q/tWiubVHsPSHMaPk2LCSRMdlC0y4OnoiV+ZWY+fGwUljQxHxmnBvN7GVNvDhaU7zxRbekSEwt/A46YxiC5LcsoPLXnkAohJvkvveZuPOGU+kUR1nt0HNiI2NQd/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gudjo731; arc=fail smtp.client-ip=40.92.41.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd+Yfxjm/R/LDbLwYM6QkeD0Q97J1uZEm0I1q8X5qePFDI3E25R8VNWUAZu3lamY9JqRkFK/OpdnR6XA6qHfjmiEIuq/hMtMyQjIO2C4A/M3mWn44i+Sx1d4f/Yxlx1zNw6wSQIKtE+SvYJ0lPBbKayp37p42FHhFN/oIDhXJJyZUOmiRf39MYkfpqmLOWWL1bACww3zDIHGESqm2zQtLtiPkxoCJqKVwZbZoq1afOh3VGgDHpbUUlExNO1lFLKvXCypxa0HSULZdzsShDRq+wMvkgTCwyLBkOR9Z5+Koj1VFHlwBmuzL9TjKsvAPInvDzJl8upvOBcJxvhhDVtoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAAuhl8FVkmFHYYpjPWHt22Yhdyc27vM80CJ0YlkyqU=;
 b=ZQ3aGGWUAKrBbbtAbRKi0zMrTa/m1vmTC+FAspHuxSo+hVvseI5jfKr2pLXzFjvmWoiG9R6FuSS7qB6LGc5PrkgWIJUcKknpCQf1mx5/5+9EAcADkeZjOjk9YZqL4AopGNAMwbKEAA8ZcASmD0VA1Wk2tQe4R282Bt9g60ErfiorXL6pEWVFPeknBRTRaGnrpVrBAJJKXAcoBFxDPkKmTXYeuX0G6mbALTbH5WoxKfSFykML3Jt9aEfwKqGuTr11Qj+xKivbxw4nUBomWWFE2LJdAQ2/qz2byUwxfp+il4OsrJ2U67v+DoEjbitD2szUFVRQuVhuCqKmBeUpNMhgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAAuhl8FVkmFHYYpjPWHt22Yhdyc27vM80CJ0YlkyqU=;
 b=gudjo731zLMtmVhKbotyFvfck8FdfxqrZwwuXLitBRgNRcmS3sVlFo8vG6sbN8FAee/1KR9QLGe4hc7Xio+JolEY1KkRQgPN/UeAz5zBofYViXicMbhPr6SfstfEQRhA60/MoB62VZtruB2cMfcMTLjAW7FIMQwiALUT/WQbHxBzmGZb2DXDvVKmrT2px4TJW7QQtF8u3+WXHTjaLy4bMrzT81VwgsBZTa7t/irlsEFziywLLfTKVzn0APcOjjVMX9AL59HMvq5PrWu5vOd15ONBUXO9si1SlBnsc6R+vy9aH5l7p0VXXXCQkmq0CeshtqOsFIgH+XrG8kX+mAV4dw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8395.namprd02.prod.outlook.com (2603:10b6:303:153::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Thu, 15 Aug
 2024 17:25:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 17:25:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Erni Sri Satya Vennela <ernis@microsoft.com>
Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Index: AQHa7mtihlctUjAqEkyZ5zpnW8ltobInaf0AgAD+PwCAACXyIA==
Date: Thu, 15 Aug 2024 17:25:49 +0000
Message-ID:
 <SN6PR02MB41577BCBF1D0DE9A526F66B0D4802@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
 <SN6PR02MB4157330500B79F4E728DFF7FD4872@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CH2PPF910B3338D030358D7ED43B94F261ECA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
In-Reply-To:
 <CH2PPF910B3338D030358D7ED43B94F261ECA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c17a7c17-b30d-4d78-ab50-db073c498fcb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-15T14:47:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-tmn: [d6LOAI1NGhs1Q6aOMAx3npuywJ28LfZ4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8395:EE_
x-ms-office365-filtering-correlation-id: 7dec5273-c635-4125-1914-08dcbd4f4e3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 xUa+gB9EJP5syAZ3N21WIUNSPjCj8IS/INNSaxSPTd5e1qJ2ewsa7/upBEbPfE5JqlyclLvDcUbVQqwNaLInm0e1DD8/AlOPVw7uoffPHlbFLmjvCgXkYnfX7GK/7ak/hpF25Urh6JdyvVTjdOYeQKUE4qPU94CqNhFmctJjnis/ExYq47EEvjZXz+Iib2JmLvxdSQv77zIiq9VF9I37RFyOzQ8tJiyJQsiegZNfIUXREN5Jh6Urp6AyogXCfiwQMznXFckxmPnr8N5xXL6Yc4+zR0gLGzNFBcefo1PACGGwJ/ePJ1m1KZ77fOoQgNE3g9BeHn+/g198WfHSRegVxJt35OEuax23IV4X/2FZZwz87Coz/PpMUzFBHKGHaZLCr6hqV11UeOtAQJ5P7AaiakeUXgG/bQL0rAIA1OuMWVTMX4kFyqeUtKI0QMDbWhSYOH7uil4ZtoQN2+Ot/g5JFBM9kczRMJUezRyfQV77P1VgO2hl3Nrx9HgvqfjEHYFGFKlCWfz3hDQdR3ubglf8BVQtWe7pG4wLRn2+kp1ih9s0p9DAgmTa8erAwKGzNWD6Tzj0/k8s22VgGeIc6GGW+sWtGWyP6uW/0sItgOhks0yrGUljjos3Me+iMKEKaJnN8ZDdZzXUVonNY/9aESCkXe4x5+KWfZR55K+SfrmQlNU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WkmqYnzO/pUsJYOkZFOSz2kgI+zo8SuhSYrVDggBrSqB6tOgfr6pQxIbex1I?=
 =?us-ascii?Q?LK27YZMJZX/H0r7DMTvJhJZm0zzkZXgTBKPWp2ZGSFecdO/T0gA/CR224M9F?=
 =?us-ascii?Q?lqhAl8iAY95W7IjOv+BR+Nlgzick82l8w4qCcPml3Tc2WL/lgvujRDMtvjX3?=
 =?us-ascii?Q?VsoW+4hqXRS2nI6WcUTzt9XP3ECli+H5mdUXdDaiWe5Gdn9ABaY1bW+OMNU+?=
 =?us-ascii?Q?bSfheSO4oNhX4FfE9r7RxkPoMiHp6Nux2SneEIdwasM3t2OhEGdTAtVDKqxy?=
 =?us-ascii?Q?xFTixX6MooM2HjM4EJl59cuabQ9zS02L75g/pcMYbqhC7S8aGj98DV8i5xCM?=
 =?us-ascii?Q?8W4QsoDDotxV/V7d3g9mr9WL4Az1q6GWaBmXHUIf6tsX167XvupxfBundjOb?=
 =?us-ascii?Q?SigRiF7cuT4/S+PooxUPrmoK7yN4fy38e9pfFAxMiKoyvk9YokNdOwKYi/Bc?=
 =?us-ascii?Q?PLrFLxEjgy+Usv9bKQHqwjqrHmnHowFF9T1c6TlTGNeCjKWD7KJ4lsfWZ+dQ?=
 =?us-ascii?Q?/1AA1Nu28RO8VB4MHq0gNdX3mycuZVmv0kwWbcPz9jc8uVv3dxRlXko14Eeh?=
 =?us-ascii?Q?Wc1/Nc5X3yIfY5EX+1jSy8O948NIr954z28tPQq2SXjyf50l7+f/GfnWeWZ+?=
 =?us-ascii?Q?2zkRIIEFVx37cbCTpVimvepXl8fAOocVUF6vjcvnyHDEX26gq45z1LRWVips?=
 =?us-ascii?Q?HosGzjXCmJZ7L9Wy23lObuutzyl/trvDLw3Ap+WzrfpUij37GTGihjN0SQ7f?=
 =?us-ascii?Q?E2w5tEOpM/eYCz+h984SiIgOKOYaqK9tlpdTS5M/bNq9kv4QCM27ZWq/IhrV?=
 =?us-ascii?Q?rtHGfiKoctuhhXGtdMhuVVAMgz9wOHKkgf5PudPcwYleEjmy6SDQzDGvLVSA?=
 =?us-ascii?Q?mFFI5xktEVQZT+9pn/lPmWbgwaGQQKdCGFhNBVtx3q/PY9uL+mIwLWBt4dkn?=
 =?us-ascii?Q?+tfglUdARDTDnF+61baoihNwlDTw5FzoSYT3AUUGMn9YG+lB9Ppa67CEI+WX?=
 =?us-ascii?Q?8VaZtMD2JYcIn279WFQAsw8V5iLQazzIi/QHcGMC627sU0f8uxfHT2O0iMxH?=
 =?us-ascii?Q?5iHd9Cb26C3syC8kVGXLTo7Yhak/l0IrPcOiQVI/fyfE3r2xZvkeduDALwn5?=
 =?us-ascii?Q?V4kdplnhwHNEQajLB0Gc8jBESSJStgEJtMuLKXwhYRoWOm7oY4b5rH0otP/c?=
 =?us-ascii?Q?UCk7c0ENiwkpiAO4d7rs4Gf24QeUTU74QFocg/odhSoGfct809A6oXvO6V8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dec5273-c635-4125-1914-08dcbd4f4e3e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 17:25:49.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8395

From: Haiyang Zhang <haiyangz@microsoft.com> Sent: Thursday, August 15, 202=
4 7:51 AM
>=20
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, August 14,=
 2024 7:57 PM
> >
> > From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Wednesda=
y, August 14, 2024 9:59 AM
> > >
> > > Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> > > Linux netvsc from 8 to 16 to align with Azure Windows VM
> > > and improve networking throughput.
> > >
> > > For VMs having less than 16 vCPUS, the channels depend
> > > on number of vCPUs. Between 16 to 32 vCPUs, the channels
> > > default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> > > set the channels to number of physical cores / 2 as a way
> > > to optimize CPU resource utilization and scale for high-end
> > > processors with many cores.
> > > Maximum number of channels are by default set to 64.
> >
> > Where in the code is this enforced? It's not part of this patch. It
> > might be in rndis_set_subchannel(), where a value larger than
> > 64 could be sent to the Hyper-V host, expecting that the Hyper-V
> > host will limit it to 64. But netvsc driver code is declaring an array
> > of size VRSS_CHANNEL_MAX, and there's nothing that guarantees
> > that Hyper-V will always limit the channel count to 64. But maybe
> > the netvsc driver enforces the limit of VRSS_CHANNEL_MAX in a
> > place that I didn't immediately see in a quick look at the code.
>=20
> Yes, netvsc driver limits the num_chn to be <=3D64:
>=20
> #define VRSS_CHANNEL_MAX 64
>=20
>         /* This guarantees that num_possible_rss_qs <=3D num_online_cpus =
*/
>         num_possible_rss_qs =3D min_t(u32, num_online_cpus(),
>                                     rsscap.num_recv_que);
>=20
>         net_device->max_chn =3D min_t(u32, VRSS_CHANNEL_MAX, num_possible=
_rss_qs);
>=20
>         /* We will use the given number of channels if available. */
>         net_device->num_chn =3D min(net_device->max_chn, device_info->num=
_chn);
>=20

OK, right.  Thanks for the identifying the code for me. :-)

Michael

