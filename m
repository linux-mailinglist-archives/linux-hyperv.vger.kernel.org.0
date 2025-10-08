Return-Path: <linux-hyperv+bounces-7143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06CBC6468
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6E694E1468
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4A2BE7A3;
	Wed,  8 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kEJQE/dK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013046.outbound.protection.outlook.com [52.103.14.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43B283C9E;
	Wed,  8 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947879; cv=fail; b=On9yeVCa3XB1vez+rTeZJPucSlBftFzeWtenMqTQiERfV7Z17z9xyPQ3d2eijKcHlPxEz+fC/dPkkn9kTkuphGzINEAc7e5uJ8203WJwqlTAFBT8jIdIRzeltaEhONC84JxjMgAatoMO1bnt8+4yQytPD0jqQZ0S93O4Wnmo8jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947879; c=relaxed/simple;
	bh=nLVKss+IBrVL3vIJREmeCsoMhAWC3qVWD9Sk9kuKBOY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hBAwCxNxFVkvokVkRhW0Q6FcGwbBZoTB5eTnhvsq3oiwbLwVNJ09YXFzceuxMBdgRykIdO39CQmBfkr8TWL61ahBijjiMvN99ASVTrmn69tduJ0SJZkT77RkA1UXDnTuec98YkGgsvqA8AWWT3D6igB/J7dVIO4wMrKq6pVFYdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kEJQE/dK; arc=fail smtp.client-ip=52.103.14.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnNRgn0D+S6Ie5zdSBQGzfwbyBnH8QdHK6ypStmnB0TNc1cGsz43tN9vH7Nfvwu1t4ks67Gaz0EXqaXBZgyPhnrLOvsGhjndjBSzFoOx5HjhkLw6mX5mCBynp0NSCfResqvKf7uYIguOY8gcf9oAann3yR5bvQsYuMXvtFi1t0v7PMfPx4Inqf/WRZX5guZnt+fMrSgr351CDvKOTE/KqzIMmPpC+8uYVEaOpysbjw6nmClRBv373Nj1JxavwVbaovhFDbfKXGh9LIqxea35SjwGRQjqosttLoIBsx90r9Ud/qJ4fXGSPxsi3+XkeB9+7gkyxAtIVAq6yY0OGOWY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwcUbCFtdNGx072Ki42JyHBjeQJLf7HyrnASSpqTa0o=;
 b=MbHz7PVUyY+pC4VcRrDU7U3RHZVPO/41l2Xfgc1nESBa4x14dcNEMpQS2jmJJQA/o3BHzJrOF4Bs55Cuvg2dVyGelv5TJnRpNQ7UXmLDn4WRHfg2Hm8eeSXtUVnD3wOsZQXOEHLB82mlmGcjySXXySZbCLXKMrLechjuoZRMircNsieFosI8AGK8ETKUPFZztAFkKLopmCFLzTpLIqNRfJ0qrmqdbnR3W0cTztIfYT/Nrk9HyAV98nUXNK3AWSHY/RGC75aVImyChuNBPa1D7HEUVSdAODqrpYnT4tAtzSthGytIHWRFKepY7pxec32lKFi9bwHUzd5Xutj8n+bwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwcUbCFtdNGx072Ki42JyHBjeQJLf7HyrnASSpqTa0o=;
 b=kEJQE/dKxMiyJHKGPORQdjwRe3clms4lIWw7UdypYQVZ0jxUQP/o3DmhUN8uf8gHXRkB/75hf3zxT5KPs7JzlCJW3pi3AJOjPpIH5lV96201Fuj6rWDTHGCl6rAKHmKxs7eVYALaN9V1cv0C7Uhd2bHJ9bm0LDHSH46hARORjj8XZSLfPuGdPW18AuTgm+c2K6hyTEYOyEXw2uWnA/x2XjSZNhIVi5gBauNym0HVuoDGWUzVCeLNZ1PNz4g4Fq1tT6c23TDT8jpQVCHp1i3OPQPtbdabZhan4Ou0UQ2SgY/cPync96IJizKbDqrY5AxLW9zgU+9fG5bKOTwaLdqqKQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10479.namprd02.prod.outlook.com (2603:10b6:806:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:24:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 18:24:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU
 as on the I/O issuing CPU
Thread-Topic: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
Thread-Index: AQHcM1o80XmWhpePUEiNmnbV/dytobS20liAgACjkICAAO2BEIAAJZEAgAAQ7FA=
Date: Wed, 8 Oct 2025 18:24:34 +0000
Message-ID:
 <SN6PR02MB41579818278E2548450A37DAD4E1A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS3PR21MB573566DF7A81D555552DE8A7CEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
 <SN6PR02MB4157F816858A01D480FB203ED4E1A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS3PR21MB573597BFA650534306FCA5CACEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
In-Reply-To:
 <DS3PR21MB573597BFA650534306FCA5CACEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1cf71a9b-5da0-4d36-8afb-a428d2ab4a7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-07T23:58:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10479:EE_
x-ms-office365-filtering-correlation-id: c4d64d5a-f2ab-465c-731b-08de0697ee5a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|8062599012|13091999003|31061999003|461199028|12121999013|41001999006|15080799012|40105399003|440099028|3412199025|13041999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YrpHR+p/CBt807+E5tJgdfE5XNNX80ZsDS8dzeI7mOyEHSVy7RNug33gyERw?=
 =?us-ascii?Q?tRexTqOEFRBFj93UoAYBpht9qbhw9bXPRFJiaYtjHtaI0N3I7iqQ7IskA5pj?=
 =?us-ascii?Q?DGk7wKouOshKglE7xfME73k+nVkLfbPhIVjKZzEEzp75bhsm08oakSAM0ikx?=
 =?us-ascii?Q?cBarV3iLwMxIjaQPraPAUjaHFSS3eQheLan5xd3u81uY02VNkTiPgj7ZB+yY?=
 =?us-ascii?Q?QLabhKbD+hqT12Ud4sx4wrVWMpvYXNUI9HU00xRIULrZixIbR/9/j76GAYJk?=
 =?us-ascii?Q?bbgpFpZrRj9+K1/zeIJjvcjYB6L5mh5fOUYkDE+pQujHrXZbWL4vGX5ZDIKw?=
 =?us-ascii?Q?Lv64l6tfja8fVkwT75A8Rs8FqzAKDaEr8uCf2a8Llw+vNEre8yixRWfVvGkX?=
 =?us-ascii?Q?E9CpFWdDzI3xlVhzOmGueEZNTK8N1nbXcU6oxkB2SqAGnud32lKHN8/TKXmZ?=
 =?us-ascii?Q?yvBCle3y3hd199iljMFHxVlxY5VoVdg4SAwCiA7AI38lpNzQxgoo4KeOZKZr?=
 =?us-ascii?Q?HrZp9mHzv57Z58S2l2apafVLb7ftbJsejMNB4oMLbpwRdzlHNw+kSxf3Bihv?=
 =?us-ascii?Q?9gjbjAhWkyAHvkLTg6fFdZsMe2sbbEFB90roAnBNVcZWCYot6+lpYGhVr7k9?=
 =?us-ascii?Q?JV1zz1RGzitXhqFeP85SfHMY0Hr7ICGniuJJRj5QnWK+xpgQykW1paxFt2zP?=
 =?us-ascii?Q?gjMvgh4oD5dm0mWkIdFxpXJTXY0gzC9uliAeG+yQt3xR23Gngu9/Rcgb0KUK?=
 =?us-ascii?Q?6U2/i6IUONpnXg6z83oB4y2hUrUhB+Jm2LreFcC/pTpPx6VVW92WcWFJ7D7i?=
 =?us-ascii?Q?U7p6rHdVOUyampHzWm3uT/FhXdJU+nEKvuDivrJdr+Fy4TzhNh/JlwuS4cKN?=
 =?us-ascii?Q?fxhpk/C7hnsmP0Vj7zvCpyCwccznE/IAqjEgD3AySi3PpoXN43bXZVwv5iWn?=
 =?us-ascii?Q?gZCzt55ZWDhDSpyJWC2jB7ibvEewwWJ6d2HzwmDKciCz3BWYyQ2CzRG2zfrl?=
 =?us-ascii?Q?4CW/JPew+i3mvCqlmOI7LJhVsBlPU8ZQSfuem3eyf+Pkviog6KpniKN0e3Jr?=
 =?us-ascii?Q?TQEY9kdF35FD6n7AocoR4ZhM404QGYoHim3TtEpRH1Ol8yArHu0/LOUPOawu?=
 =?us-ascii?Q?TFLgUQ7Nq4tO6206rIm8+VdVi+neyGFhh1JOCCyQSLxc1dJYu6u4PXpYIRRt?=
 =?us-ascii?Q?uc+GKnrn311gj2+7IMtipd0Mx4w74TSqzp5/CmG67vXeGJUvJl0vQDfZViBQ?=
 =?us-ascii?Q?nF+AfOWSmZfiPG0qYKMHhv+VLO6hroHIeB5eLuxmNg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g+aa5JMC3jkad5CC7HVB7z6nS7RktqTKt9Ddu9j9utlkRqUzuCjnS1CweIyN?=
 =?us-ascii?Q?CVwzMDRPziO2hFvjwvNgraNzcM/IU4Zfe6gcIaC6KzmjLoKTWQIbZmT30l75?=
 =?us-ascii?Q?xflqeE/M+Qo3izmyAt70cuhtsF1HdMAmQ9qNXozXQD3N27P3j4H9xk3AE3EK?=
 =?us-ascii?Q?aXGgqYjHX7xCg9/v09a/HqCdIbfXq5tydkHeMyJHDMoDGvqLvht/aRJn2/a1?=
 =?us-ascii?Q?ZqTPxe48NmXcOMq1rc8xuf4m9qDGGrf8bxMFipqu2+8FkGY7A5RLXQm+bMOO?=
 =?us-ascii?Q?YR6/hm6i+kxNYF/6oWB1Ds3sxyKiVdmTB+RF3WU87PVU2pzSOth9wuwsj74v?=
 =?us-ascii?Q?Opt159M+D4B7VclWvoumV2/C7Q4Lye49fu5Tx1wfHTRSIEuyI9pwuPQOp3Jj?=
 =?us-ascii?Q?4al+ZKaeqsGFihyO/VN2pPe6N/hY5l/AoXjNg4AaMJVVRW8/KZwGzMjN2Olm?=
 =?us-ascii?Q?gkOJj+ScdMqoXzKwP+VMVoSY1ff+OE+IwLvyaBry/bMEUP7+RhhxFAVbn2D/?=
 =?us-ascii?Q?uabn5d32JG468Ty/islmyM0eF2+ocL38T75btiCpyV6dW27lDsWZcH7aHmEG?=
 =?us-ascii?Q?1Kue07HFM2+seVDApwAqWu/WS8plVEHmNXjxrmSeWVk5ZS2pOegbLwYuomC1?=
 =?us-ascii?Q?BH3KFue2bT3z6TDaj97ykkIp0WN6llSdYQbCNWQrdQvHRJQLGeXGUfE38nsz?=
 =?us-ascii?Q?bZXSL3BuvhwA/4OquWpK3EXknvyt9ch3ttKUUDoF39u7BvE2I89bImrgf5HT?=
 =?us-ascii?Q?9Qc0XONX8cJXuSG1Kw1TvsufPnecbo7S4NXarbxqtHPyXDce0aGAQRWFmng6?=
 =?us-ascii?Q?dTCy3MW5m14++M10M0hhR5NwmBzyaxvSwZJoR6ipD/E2xhc+2aEtMK56e1/B?=
 =?us-ascii?Q?LN22A1Un2HVKAjJPPtKjJPFpq9kbvpukGrRGl/u4byPg9eH3p2aETQEGtNvC?=
 =?us-ascii?Q?kWQAgO+b3kbDPnZmNk4VS7NcdvNknVJKPxbf5uZ4wan/SFpxULmKnqsQdGB1?=
 =?us-ascii?Q?RuRcfeF7NFiDlz0U10P8crNd2CUFW3PcNqqIdTp3a6Go6G6MqolT11AY66hu?=
 =?us-ascii?Q?/41N5BJZv6oAFICu2OitIWS5njAu9PuLxUJoUtF0IhTUZI65jdpVF2QXhy/0?=
 =?us-ascii?Q?HmOZTQIOsVf0eNoxSi6R2CsU35lQmq8+PH2hTrmOZTQcAjKbupbXDH9IrXXe?=
 =?us-ascii?Q?IWZW2PwtsJUX4cbaTxy8tFjgU8sp7OYJhnPcb6BsFFC2uhZ7sj693SsPfZU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d64d5a-f2ab-465c-731b-08de0697ee5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 18:24:34.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10479

From: Long Li <longli@microsoft.com> Sent: Wednesday, October 8, 2025 10:20=
 AM
>=20
> > Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning channel=
 with the
> > same CPU as on the I/O issuing CPU
> >
> > From: Long Li <longli@microsoft.com> Sent: Tuesday, October 7, 2025 5:5=
6 PM
> > >
> > > > -----Original Message-----
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > Sent: Tuesday, October 7, 2025 8:42 AM
> > > > To: longli@linux.microsoft.com; KY Srinivasan <kys@microsoft.com>;
> > > > Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> > > > <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; James E.J.
> > > > Bottomley <James.Bottomley@HansenPartnership.com>; Martin K.
> > > > Petersen <martin.petersen@oracle.com>; James Bottomley
> > > > <JBottomley@Odin.com>; linux-hyperv@vger.kernel.org;
> > > > linux-scsi@vger.kernel.org; linux- kernel@vger.kernel.org
> > > > Cc: Long Li <longli@microsoft.com>
> > > > Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning
> > > > channel with the same CPU as on the I/O issuing CPU
> > > >
> > > > From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent:
> > > > Wednesday, October 1, 2025 10:06 PM
> > > > >
> > > > > When selecting an outgoing channel for I/O, storvsc tries to
> > > > > select a channel with a returning CPU that is not the same as
> > > > > issuing CPU. This worked well in the past, however it doesn't wor=
k
> > > > > well when the Hyper-V exposes a large number of channels (up to
> > > > > the number of all CPUs). Use a different CPU for returning channe=
l is not efficient on Hyper-V.
> > > > >
> > > > > Change this behavior by preferring to the channel with the same
> > > > > CPU as the current I/O issuing CPU whenever possible.
> > > > >
> > > > > Tests have shown improvements in newer Hyper-V/Azure environment,
> > > > > and no regression with older Hyper-V/Azure environments.
> > > > >
> > > > > Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
> > > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > > ---
> > > > >  drivers/scsi/storvsc_drv.c | 96
> > > > > ++++++++++++++++++--------------------
> > > > >  1 file changed, 45 insertions(+), 51 deletions(-)
> > > > >
> > > > > diff --git a/drivers/scsi/storvsc_drv.c
> > > > > b/drivers/scsi/storvsc_drv.c index d9e59204a9c3..092939791ea0
> > > > > 100644
> > > > > --- a/drivers/scsi/storvsc_drv.c
> > > > > +++ b/drivers/scsi/storvsc_drv.c
> > > > > @@ -1406,14 +1406,19 @@ static struct vmbus_channel *get_og_chn(s=
truct storvsc_device *stor_device,
> > > > >  	}
> > > > >
> > > > >  	/*
> > > > > -	 * Our channel array is sparsley populated and we
> > > > > +	 * Our channel array could be sparsley populated and we
> > > > >  	 * initiated I/O on a processor/hw-q that does not
> > > > >  	 * currently have a designated channel. Fix this.
> > > > >  	 * The strategy is simple:
> > > > > -	 * I. Ensure NUMA locality
> > > > > -	 * II. Distribute evenly (best effort)
> > > > > +	 * I. Prefer the channel associated with the current CPU
> > > > > +	 * II. Ensure NUMA locality
> > > > > +	 * III. Distribute evenly (best effort)
> > > > >  	 */
> > > > >
> > > > > +	/* Prefer the channel on the I/O issuing processor/hw-q */
> > > > > +	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
> > > > > +		return stor_device->stor_chns[q_num];
> > > > > +
> > > >
> > > > Hmmm. When get_og_chn() is called, we know that stor_device-
> > > > >stor_chns[q_num] is NULL since storvsc_do_io() has already handled
> > > > >the non-
> > > > NULL case. And the checks are all done with stor_device->lock held,
> > > > so the stor_chns array can't change.
> > > > Hence the above code will return NULL, which will cause a NULL
> > > > reference when
> > > > storvsc_do_io() sends out the VMBus packet.
> > > >
> > > > My recollection is that get_og_chan() is called when there is no
> > > > channel that interrupts the current CPU (that's what it means for
> > > > stor_device-
> > > > >stor_chns[<current CPU>] to be NULL). So the algorithm must pick a
> > > > >channel
> > > > that interrupts some other CPU, preferably a CPU in the current NUM=
A node.
> > > > Adding code to prefer the channel associated with the current CPU
> > > > doesn't make sense in get_og_chn(), as get_og_chn() is only called
> > > > when it is already known that there is no such channel.
> > >
> > > The initial values for stor_chns[] and alloced_cpus are set in
> > > storvsc_channel_init() (for primary channel) and handle_sc_creation()=
 (for
> > subchannels).
> >
> > OK, I agree that if the CPU bit in alloced_cpus is set, then the corres=
ponding entry
> > in stor_chns[] will not be NULL.  And if the entry in stor_chns[] is NU=
LL, the CPU
> > bit in alloced_cpus is *not* set. All the places that manipulate these =
fields update
> > both so they are in sync with each other.  Hence I'll agree the code yo=
u've added
> > in get_og_chn() will never return a NULL value.
> >
> > (However, FWIW the reverse is not true:  If the entry in stor_chns[] is=
 not NULL,
> > the corresponding CPU bit in alloced_cpus may or may not be set.)
> >
> > >
> > > As a result, the check for cpumask_test_cpu(q_num,
> > > &stor_device->alloced_cpus) will guarantee we are getting a channel.
> > > If the check fails, the code follows the old behavior to find a chann=
el.
> > >
> > > This check is needed because storvsc supports
> > > change_target_cpu_callback() callback via vmbus.
> >
> > But look at the code in storvsc_do_io() where get_og_chn() is called. I=
've copied
> > the code here for discussion purposes. This is the only place that get_=
og_chn() is
> > called:
> >
> >                 spin_lock_irqsave(&stor_device->lock, flags);
> >                 outgoing_channel =3D stor_device->stor_chns[q_num];
> >                 if (outgoing_channel !=3D NULL) {
> >                         spin_unlock_irqrestore(&stor_device->lock, flag=
s);
> >                         goto found_channel;
> >                 }
> >                 outgoing_channel =3D get_og_chn(stor_device, q_num);
> >                 spin_unlock_irqrestore(&stor_device->lock, flags);
> >
> > The code gets the spin lock, then reads the stor_chns[] entry. If the e=
ntry is non-
> > NULL, then we've found a suitable channel and get_og_chn() is *not* cal=
led. The
> > only time get_og_chan() is called is when the stor_chn[] entry
> > *is* NULL, which also means that the CPU bit in alloced_cpus is *not* s=
et.
> > So the check you've added in get_og_chn() can never be true and the che=
ck is not
> > needed. You said the check is needed because of change_target_cpu_callb=
ack(),
> > which will invoke storvsc_change_target_cpu(). But I don't see how that=
 matters
> > given the checks done before get_og_chn() is called. The spin lock sync=
hronizes
> > with any changes made by storvsc_change_target_cpu().
>=20
> I agree this check may not be necessary. Given the current patch is corre=
ct, how about I
> submit another patch to remove this check after more testing are done?

That's OK with me.

>=20
> >
> > Related, there are a couple of occurrences of code like this:
> >
> >                 for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
> >                                   q_num + 1) {
> >                         channel =3D READ_ONCE(stor_device->stor_chns[tg=
t_cpu]);
> >                         if (!channel)
> >                                 continue;
> >
> > Given your point that the alloced_cpus and stor_chns[] entries are alwa=
ys in sync
> > with each other, the check for channel being NULL is not necessary.
>=20
> I don't' agree with removing the check for NULL. This code follows the ex=
isting storvsc behavior
> on checking allocated CPUs. Looking at storvsc_change_target_cpu(), it ch=
anges stor_chns
> before changing alloced_cpus. It can run at the same time as this code. I=
 think we may need
> to add some memory barriers in storvsc_change_target_cpu(), but that is f=
or another topic.

Yes, you are right. The spin lock isn't held in these cases, so the checks =
for NULL
should stay.

Michael

