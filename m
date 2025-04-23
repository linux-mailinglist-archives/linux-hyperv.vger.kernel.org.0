Return-Path: <linux-hyperv+bounces-5073-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C8A9992A
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 22:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02287A6630
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA6268685;
	Wed, 23 Apr 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ScQ1/l8k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2053.outbound.protection.outlook.com [40.92.40.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7352F88;
	Wed, 23 Apr 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438830; cv=fail; b=i4Otx3/DWhNEL/hHA1DY2eBr/xo/rVPPzCWGoJzQgfNlUSqS8AiArxAgml6syjCZcLdf9nScpqEpLCAmf7FTMyeVdJJUO6T7MuAdRHxww3FSBMilRoHgOPXMT42aOzTtXU5/wSsfd694puXeXRx0a+HeOUY6ayXS4NDM1+Ji7cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438830; c=relaxed/simple;
	bh=Rj/FOJ+7XFfDdvUqKh8Dszl7BspnUS/RAVzBQPJ1s3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2PaVPC/i4J5J9RU6/xyUjkXRHy/i7OhNzZzkTTSgEJUGPizJ5W9YNQ3vRnURZ7pBPOTxkmSVKdSxV1FG9zypXfd4SZWM5DwTKzbBgQaagAmX9nqqcG4WGFvKZdr73c2nzufshqrwQ0fRgEdI1uWfYeh8dt3BeCPSxzJnadUo/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ScQ1/l8k; arc=fail smtp.client-ip=40.92.40.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKK7fUgnnjHafZPbCp8Jo9H+xBVcXiUyW3Ioyc9lQ32/aPppgx78DtWNNq5j75JzWL+5RPxckU8z++oT33EKlwfkBg/YptITnMbJkT/SD4xNmhUdq6b5Q6W9NwOx8jhOhRvyLdZybuhRaHtE4eCXxCSm1RBXYOsoPEpCMs0hRf4BNZho8etlcuXLmU0gs3Siu2B8cYAYgg7vDjuQhnTfTs3fLei2qlyEX/J0T+k/eW4PScEXM/XSg//OESD6mmAThNfgt40paMkEtaTyIiZCDIjbl1BNQeU6wgVwJ5k3w18E362XhqbxKWXT32XqlF/nNXD0cHqEqGtL4H3slTM6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj/FOJ+7XFfDdvUqKh8Dszl7BspnUS/RAVzBQPJ1s3Y=;
 b=kyvpXy89Y9mc2InR/RbNySSSRkUOoPzXae/JlLXef5/JXXAnZeVqKdusuTdr6r6YTwF3uwIbS/UM/DTayaYNJhWZqY1zJhSpJAcNL7YSKcdw1kBG9hzMELVPIlb+7gmteV5TA8l79SGTa0lY6zAxvSM+H5cjeXVmVEyCdlk7N7hT7cvQ9R8hvYNE+Y0g+0De89qSWBVOYRV9HMbaupkOJ1HvlazbTTQS7vdiGdIYOtmb0r8KJRlLaiOSK/XK7BoZsocJCMvHyDNdLRsiX1qTGJQfrUYUAzh4FSFKHppbk5KxShWNziKK8YKcBxoWWLSeiZw586eq6KViA3+k0vqIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj/FOJ+7XFfDdvUqKh8Dszl7BspnUS/RAVzBQPJ1s3Y=;
 b=ScQ1/l8kxfSdPIOmvzxB56NUjaArR7GymAwWGDZkKP+iPhdsVA1LXp1VQR+rSK+mfhj3WEK3Ww9Ou0DrDwd+B++EogQdcTbLfZebYqSjmxl1h/ZkHl+1BsaTmK24GH/XN/L3rZclviC+uuwRF3ivRHn0B2Ko/+heFU8cOHamVpDe1Qnq6/oZxV/s+Ufhnr1c34q1gJj1zh8sA4tlvZQM7FYYYjELkqAdvWBkAcUBpeLv381EekHFxSXgvhFCqZ4HgM/ML9DY7CxK/zVzvgaIT31Btgob1UVZG/VQfKM53ua9JptOZZB95Bn8GkAfqHeKNHViNEUpv0cB018gyiwSmA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BL3PR02MB8052.namprd02.prod.outlook.com (2603:10b6:208:35b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 20:07:06 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 20:07:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Topic: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Index: AQHbr/r088rxYljrdES9WGx3Hu6yf7OspApggAT8xwCAABPdYA==
Date: Wed, 23 Apr 2025 20:07:05 +0000
Message-ID:
 <BN7PR02MB414865017BF8B21B20908559D4BA2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-3-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41484C3B916A6D1DA7297277D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SA6PR21MB42310EAD1D095D16A6198467CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB42310EAD1D095D16A6198467CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fecdb32a-b7c6-4ead-b81a-11d46ae77304;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T18:40:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BL3PR02MB8052:EE_
x-ms-office365-filtering-correlation-id: cf494f34-176b-45f8-58e5-08dd82a26b97
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYP3ZsEZeVw/Dz2GWODY+Bii+aTMGYDpQWUTfJeZSSz11NbCsm+3m8vWtTshwbElDerGpPbbbPgNRrFjp89TmeglhrBcv95Ju0J8r63m2L1E4F7QoZDq5D4FsLtNycJRwfelQZlGfsLHyp94yo/yQbzr4l3j73Zxu7UcLmjcBFAPB49ys7BBO6DIniK/1PUHsEggvw7lwfgFKtGU1gdTgZW+ZB9H08b/87VF+2B4QegMXhcEN7Y2ao9PWd6fE1Q+s6wmuTsPp3Bp2bEY7bsr/VDJTz0E/8/rSknxuiCjrO4mBWrp2r0lp2owxXYx9oDBL7FhPHIytxltGLBG+8OWVeT7WyQn1hTbmjotv9pos7eqNn2eqHuwY3YKMCZQFYoG1vdjGglgfhtumhNVTlIB0xTOT+mZKpdVZfjo1pzeM/8HXz3d5ltIh+DsqenkGZWDTbOZY61bLPns1yybm8ooRlwQKMdT9qygC7rlfmGaqnQhKPY98104sKVA0ee4X8s/KlRFgVLcdhIFbt5cJL4sjGvLYyU2/kWnKreIfD0d5sYh3fW6/k9U/iR9rVGeuBx+bnB5h8ghUnaIujW2PNZdt3KqyeyC0ltWBUrL37BbGTRb/c9DKnLr8uRBbqU6WoMWgtYSLytiCNk0EQSg9oFH5+pahJ0O68gn6qBmzJHtovugrOZ4t0DB3pEMB5XHPbl6MA8fbjxyGak1gE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?myFxXJIxj1omzhYG9UXf2wQNqAxXdilEyJPyg7C9Q05FigIncBQb+wzljfqQ?=
 =?us-ascii?Q?9MPDmByIgcV845cc8pBIK8oYNMyIXaDLhZFar3Q0fJ1j1rxr0v64voF+UtLO?=
 =?us-ascii?Q?o7m4+vB3nEeE389Zgc371T3BfeAQek0C4qV3d9Jz6VM9WaC7gDSpBMiei57U?=
 =?us-ascii?Q?TWCsUU0Gc6HbrBM4H3IwcpDrvm3BI9YGRl5wO+GLvQwUX5IXHWihn0hNo3I4?=
 =?us-ascii?Q?bbQaoYKRR/Zgj3RNEBbolIZ9QfzvqL39MEnSl4FDRt5+3BrgcdjfoxEzJgYf?=
 =?us-ascii?Q?StbThkwJMNg9qATkvIaXiH5iYphPT7QKPWQvawfSg/FU7fbnGkMSPnBxiWON?=
 =?us-ascii?Q?JtuYPjjJAn7YWTnByoPoYm57je54b0RREFck/9sCF2nEuNsBr0anPsQPcdSp?=
 =?us-ascii?Q?Q+Dy4fM311z0NbhE296DCuMlVa2BedMdLvAXs8usJnQE2O/m0kMFr20Yzg0l?=
 =?us-ascii?Q?bqmX8nL5V5slmxruhyhBfAG/tIOfIaGaAWXWAObHw8RnqcrPviME4zTawzvY?=
 =?us-ascii?Q?uAKSdQRSvHNVfAEPngBNCWXPx8x96QcqkfFqlLfCCZZa0/bT2dtZByd3NvTv?=
 =?us-ascii?Q?3TfAbaI9skOeACIfrItkO+VZlVGebcj2Jf8zxhzJaVSP0Wg2ruqFW7U1uFd+?=
 =?us-ascii?Q?AyX+zyf5j/olEMByIVxQVJy1ZeL6U8afcf5eCpR+cTrE9TCizawNAHmGx/ni?=
 =?us-ascii?Q?8TmN6jBUuxifpugGhBQV9kY9/nCvroHKri4fhc6ICoQsfGkUiBjKzm57JI4H?=
 =?us-ascii?Q?vXGJ3Kwfycx93eCSkZYCwyvx8ICoECceGtniYtu4wDxfH4fvIIx7ZJRWkEbq?=
 =?us-ascii?Q?abOOJtbohIjp6Tvs/xwCOeoaSzkOI9oqx73wlkacdMalxOGb4+naX+nex4mb?=
 =?us-ascii?Q?ASsfjnLpyOfq9o+8H7QjEZlH2bhPQdbU/jeei/Ti7ZsdKztztykH5c+A0bnr?=
 =?us-ascii?Q?xOPdxZhDIrAMdHKAcxEM6MqgW7Bvmliez9Gfa8drN4DfmFhP5bdeG9IY8OYN?=
 =?us-ascii?Q?tgZI5OuiDOaPgRysouv+2nQDhkJeZzr4UTmeJ5tFn3SM90lIFq7yxqvJ+uiM?=
 =?us-ascii?Q?A1LH3secqDV7G0TIUGSgxStTZfRinA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sfZESfyCzcOkYxUvTEhu7S5Pk3KXT6IRe4T7S+k5OI+7oF8hzsaoTr/ZE75o?=
 =?us-ascii?Q?wYNKcX3LC8A4/Cg248G1D66cc2O+SiD2rZ8AZ3hlZqn2QBNMLZCbY7myDqKW?=
 =?us-ascii?Q?Z7VVVPxqxcwywycnerLqDLHLUzNH3xltuvsFZhyV14t8al9GHZdCa92a2GwP?=
 =?us-ascii?Q?nC5UqS+42PFMBVrK/25kpRnE9KWRGRWc0N9M2qDNUtfsGGZC4qY+x9mF+jBo?=
 =?us-ascii?Q?TO3+QE0eJVYXVlpdgnKqznof8S0rmN3Hp14U5N293jF8bzuOK52T/etM4CRz?=
 =?us-ascii?Q?VP08EQgJdtRuJlPAUuP5MF22DgAZ9oGTkbFtdz14K459Ns5i45AXac5KblGX?=
 =?us-ascii?Q?h6tt2aQ3EHqAZEy1WgrkusbMde5a6WqM/ELnT5LUo19LE4gxa4a569h9ibDg?=
 =?us-ascii?Q?GgcBbKr5coM1T1EaANXsJVPKv6wqPYsTMEhQ4R1uVuqBi1Scup57xLQJrGnj?=
 =?us-ascii?Q?oF4JQWtRzdJD6qtGzBouIHXJB/sK8FtmRp8ja8lJcAOFsXzOQYgRYkGymmVR?=
 =?us-ascii?Q?tuZKW1zbwWjoW1YFxYyElm3lOXfkhk+5rteKl52CFHTaXcFv4pX6bIs1T3hl?=
 =?us-ascii?Q?Sy7TPO2k0YhiAqEmDI5NAOqER+DIT3v56IuGvnVe9BDSzms1Zz0xpx4abSK2?=
 =?us-ascii?Q?GTbrawkmthK5mTH138LIPkf00/gpkSVD/qhGG5cG1v3RQzkn/7sHb6VLOIQy?=
 =?us-ascii?Q?d/vDxcPHadL9jBMSDic+fIXsYl1O/TMz1QmB+gxJxvUvBHNLapBxJqanXYQ5?=
 =?us-ascii?Q?yZae5bWSgt+Sze7Zm0q3KH0IPYp++6pC/MmwBrcnoquAJYb9eFcdIa9mr9vH?=
 =?us-ascii?Q?dP/EPI6T4+Kh6jyVULs8z2V27dzc8qozchLyYuFeWRJ/8uWQouZfzVjtpyBJ?=
 =?us-ascii?Q?UD2OyWhM3m0sNptwW6dwuuC5R991LEuHeY0DMqi9sDGQkkZzG/NHR8sZ4AjQ?=
 =?us-ascii?Q?CXrFv6pZV/fMqSG7rKwrFLdkVWr1HB/OVqa0PEwkQsgZ5hmdP2vn4IWgPR18?=
 =?us-ascii?Q?7adnr0acAQ2d3D7q5fhkxnzjb+x+b8ZnX+tyIBESPmpXof9sto1wDTB6nkFQ?=
 =?us-ascii?Q?MP5s2le4CAYUuaGGKdFgSeKTaTJag6WJubfxfcliNL+aKT+wyd+2/6QNQM9M?=
 =?us-ascii?Q?/+XBHq+UqYPB61hWFbqVsa29Ncgn1L72Bgc1Ne/89F5JBjHF3P1fWJDVX24W?=
 =?us-ascii?Q?cmj8WiUFDTWCLFQjHnwZHbLj5+QWo5A+aW0Eg04Pys8+XXqSrNuYZqrGUf0?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cf494f34-176b-45f8-58e5-08dd82a26b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 20:07:05.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8052

From: Long Li <longli@microsoft.com> Sent: Wednesday, April 23, 2025 11:49 =
AM
> > >
> > > Interrupt and monitor pages should be in Hyper-V page size (4k bytes)=
.
> > > This can be different to the system page size.
> >
> > I'm curious about this change. Since Patch 1 of the series changes the =
allocations
> > to be the full PAGE_SIZE, what does it mean to set the mapping size to =
less than a
> > full page (in the case PAGE_SIZE > HV_HYP_PAGE_SIZE)? mmap can only map=
 full
> > PAGE_SIZE pages, so uio_mmap() rounds up the INT_PAGE_MAP and
> > MON_PAGE_MAP sizes to PAGE_SIZE when checking the validity of the mmap
> > parameters.
> >
> > The changes in this patch do ensure that the INT_PAGE_MAP and
> > MON_PAGE_MAP "maps" entries in sysfs always show the size as
> > 4096 even if the full PAGE_SIZE is actually mapped, but I'm not sure if=
 that
> > difference is good or bad.
>=20
> Kernel needs to tell the user-mode the correct length of the map. In this=
 case, 4096
> bytes are usable data regardless of what is actual mapped as long as it's=
 >4096.
>=20
> The DPDK vmbus driver uses this length to setup checks for accessing the =
page.

OK, so the "maps" entry needs to show a size of 4096 so the DPDK VMBus
driver does the right thing.

At a minimum, mention in the commit message that the reason for the change
is to always show 4096 as the size of the "maps" entries, even if PAGE_SIZE
and the actual mapped area is larger. Perhaps also mention that the DPDK
VMBus driver is one known consumer of that detail.

Michael

