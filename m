Return-Path: <linux-hyperv+bounces-2773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55395265C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5BC1F21980
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2024 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF014B976;
	Wed, 14 Aug 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NPpE7be0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2054.outbound.protection.outlook.com [40.92.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60839FE5;
	Wed, 14 Aug 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679832; cv=fail; b=ADs+QdSMec/Gjoh018NIOvtzSkoAM1Ro28BUrY2ot/MedHZXhU+1GUGDdauZU9vbfEu22L6E1n089zpLHuLd+FapNp8NvexEoJn5PlhE3nfBGjsne2kYQX93Ekfa1/GqcCce4S5H+DG9W/ddfaMUve3PMLZ70rbqM/mTdoUZpGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679832; c=relaxed/simple;
	bh=hFu7bIUm5KXpUtlqIFq6XbW3C2XZETPO/Nv8ulpH0Ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zx/YsNlJoj22HVkQuTeu9QQ7dvcVOtr2BvnZ5iRt1FPklC19T+pAy/o9x/f3oF5eE5CtgEFwfLR5lFwHOVPuZB97CRdxWNCUcJvX3fdJ8qVkNBwXmpvRupH8AbNIQRtWofKyGH1kUUo3eEBVP+G7JsBVEPS+j/qag3H2oXttQJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NPpE7be0; arc=fail smtp.client-ip=40.92.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2QmxD4CB6UuZ6DTizWw6ZE7QJKvYVVDeAHgnKEk4/o0nkLluU/hbDpRSMnDVCmm1YVFrdrOalnwhqPRyjcBVxivkxdbeL83X6QrGwD65eEOJG6Jrziqi3sPGziVMMkGjVNVqN7KF7S5SF2mcuoLERxCrovX6P81Drca8hq+9AuvtpUku7DL2FwJqGumV5sYTiPwpoX8psyiQnxagwHAuPnCE/p7rEc9bqo1xHaI45nRidomT7C10lgZ45Oa+cZGhg655n3aCFNRq/Lw0FxRApRbDf+Tcb1riB0PhhNbbaS7hyB3szKp90i/Mwtwpt996/CaslvP/LJtAkoLqzgm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0bxjjdjaZW+x3wGlCC3Dlde+V/r1A/YrT99HoZbFlk=;
 b=FlZvU1fkUGGpVYK/eEg9gYNk5DuFh2Ra0JbrpLqdnd3iXDMSCJZhFGyPtVdlCv+tmsLtljJ54h26C+HFdF8Er2SMbmTsdDDLvTKEO9TubSHHoh++7KBFYK/siA2YrGJ34nICvl59nM3mcP8NjRaPjpgKM+Pqi/C0vE97IBumA3heyaSUHCf/8rEmkd1XOoLOTtFewmilf35r3MytauEnW2Fk7e+IijtD8kFj/jnjy3Fe5wgsjF2ORDL8e2cK/RoB+F9e/Sh6X5F6pbu17zz441lh8sNErF4rxDCJLZHHXF2A02Fj7VmgQhc5dkl7C0gvWfRo0t+Org6aysk8waZ/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0bxjjdjaZW+x3wGlCC3Dlde+V/r1A/YrT99HoZbFlk=;
 b=NPpE7be0vnP8Lfz0oQPVx31sBCFNMknKQ4WgpWnvWvTmcd6HteSNdyTVUSUKsdPEOV2J0ihK1RnXim7gp2TY6LHJEOP9eVb40w6zYNZPuQron6n8HnEa4I+I/YmWq7VeHzePoEGHwZeGOsthPC2DmTk6X18CfEalITs1gUXraCquZw6HkIeY1DLc2bDJKm7q+EouOY1HHTRaIvgv1iSPIWKlCfWV1f1hquYiBbBXKd0lyTBRSGdtE7I/z9Dsmq4Z8JXALpi1gEdj9hlcg7cAn8eDcicsS7raIdqihRhjX+4wxjZJWlCTy1gi+SLtipcezxxAlmnqPeaDr9v4MF971A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6809.namprd02.prod.outlook.com (2603:10b6:5:218::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 23:57:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 23:57:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ernis@microsoft.com" <ernis@microsoft.com>
Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Index: AQHa7mtihlctUjAqEkyZ5zpnW8ltobInaf0A
Date: Wed, 14 Aug 2024 23:57:07 +0000
Message-ID:
 <SN6PR02MB4157330500B79F4E728DFF7FD4872@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [s+QGmKsdXT8sQhy65HLMtdmDdXU4oPmm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6809:EE_
x-ms-office365-filtering-correlation-id: 102b9317-ae4e-4ef4-b3f2-08dcbcbccde3
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799003|19110799003|8060799006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 XjPrM6M7YPRS0uNuUt3ZFE+OKCQ6mSbjXINRwN+Iu+0hv5EK6ku4UwZcXuT8xd/U52j44fn2u5JdBBGq3R4YxQVYHACIVa4Gu/1vZK0gq9vHlZm/QkHCK1mQMLYNI+uZyD0UkepJtqNz0ayrJ9nygBZgZ3fyXrGetoOrcwh0NyuYPKfhxm/W2I6y4Bkq0Efff4b4p6KsB5MwHQwy4kHUsCIgg5V7W7ji58Pv9dgtoxfZgkLvivqnm/LdEDHlJwZAvNBzMmDi6UVLoEp/S3vloFL/2eW0uV3//WnGjMFDM/6hnxW7yY42u6hRLLIlTGmkWSpRHioi63ZMuPvyVlV38Xe/45+uJqgg3/8Rl49DGUyR5Wfti5BEMOYY8V4FnzpNlHO4bBIs67TJxTAFyTNfYhBgEHPsY6PUJTc8ajA5jBQ0YPFqrEBk0dY62jOJiSboFP3XVFtmXFvyNIkgwjzruOYMvB6r3ZXkNwTX4/IazIGIsyVi/fVMQrHl1ShxVONf9rNmHhovSC/RwzhCtzH1DPyMtXEhc6XCqyHIhfM03l1RlbT7cBMklPbkRGdqhE0Lndb4h5qvI9OqVMb2DQpYsDRXxHqOIBDLkO3uPx9Y5oPBgHzYL+cozSkt0BkW6CvTuErKnw8331gcyZzST4gJZhBTMBIDXRpGZApmc7uupYMHiqCwyIwAigMtHBOh/Agv
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r+APi7rHDS6jcfcjtEcLN7IC4Edt/WcKXmA1NZeXu9kQgSBqmhZ2Yw1Lytjz?=
 =?us-ascii?Q?oKuiwFH8Nr36JQCFbXWSvenrqcSSRF2P5f6vH1xsweVedwdJjlp7OhzJzSp3?=
 =?us-ascii?Q?iJdFUSvLl9N1gs5wZgjc9OQNTwsEvlCM/4Qfb6YFJ3v1RE8/IpX5J1/Ca9RU?=
 =?us-ascii?Q?A/2BuuqMDDVYkyW2P15JwtP5ILgRB8ew/VqcLGEmRgYNbzEdV0JQWsnmv5+q?=
 =?us-ascii?Q?Exa2+WRINtfB0Z8pCCEHaiQ/hsAaW6GfNtOugRJdd9j4BtOQrD/18yxTqXcs?=
 =?us-ascii?Q?e9uI04B2d27HPoz5YkR90GAzlZ0Vox9qZbLg8E7f8La2eeVsOeLbhVEZjEQS?=
 =?us-ascii?Q?BmGoQ/3nSv1X1qbou653I/UV5zjmwxrvOYHfwrImtyGLXliOLTJ6669MK96O?=
 =?us-ascii?Q?YJIfEZ3M4vK+TeAu/u4Z7KN89Q9VzPUnayPDQvGGe4J7cLVbK7JrqeRz5+Wq?=
 =?us-ascii?Q?Nm18rN462dUn4eDjyotaGUZPHqlgo6S3ehykuxEd2wGgFtof5m6YqfneDI00?=
 =?us-ascii?Q?7kSerpdA8BXpDfH06PSL0SCbP7Y9NI7Af2dSSk2qh9HfD/EyX72R1m36rfAV?=
 =?us-ascii?Q?j0C7u+18Zw0yu2s7avPc7SIEmlwf3oY4SKgCgJx4x7EOkksj4WReHetsqev3?=
 =?us-ascii?Q?8+X5qvaM4mQpHSs4YaUsEpjiNxALFxofG0L7iuBaLuTUtaqNIWNISZazvot7?=
 =?us-ascii?Q?qDgIRKYLGAH4tJKrPOOi6b+SK9jJjqSNPQUvz3bbjHcyvrNOE5jSDGwVd7sl?=
 =?us-ascii?Q?P6XGffquayMeWuUsvOaLkN3CxRY6w38cLULk8ZMdgiDZoL6GHvF07BFK0Bvx?=
 =?us-ascii?Q?F0PK3h2wm6FxtQoS3J6aVcErU0sPwPxYW8FDutc74JzRqJ2/X3l9uBdE7vcD?=
 =?us-ascii?Q?Eh/eutS9o4kcpvvn9WwRpBy0zB08sB4+88CohbJ37hK1czISuHzILOgKw+1F?=
 =?us-ascii?Q?F9OcPgoRhkEtSLJlAIoYCBuADFcocPgqM9yQsgtbUz915OqXhJzZc3q6IN9I?=
 =?us-ascii?Q?h/2o2xJlvH7sIKldX9vTZkuNTZIHEyk7rU24z+ughaCeM9e0yUUQ9nVqAilf?=
 =?us-ascii?Q?IIC3G+F+7Mu8CkdIx0v3R9Alju/ajQJ3DQKbH4bZ4hryRDdw7AUn0r27KrO8?=
 =?us-ascii?Q?1umnAhwtr70GttLiTAprxj197XmEP0lpuOMy4dUXtq2lkqbhjiR9uPuM4fuk?=
 =?us-ascii?Q?6xNCs+efpWJlZpZzStUu2CWLZyiRez059gH4qLqVkqn5swZci1iRG8auhTs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b9317-ae4e-4ef4-b3f2-08dcbcbccde3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 23:57:07.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6809

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Wednesday, A=
ugust 14, 2024 9:59 AM
>=20
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
>=20
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. Between 16 to 32 vCPUs, the channels
> default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> set the channels to number of physical cores / 2 as a way
> to optimize CPU resource utilization and scale for high-end
> processors with many cores.
> Maximum number of channels are by default set to 64.

Where in the code is this enforced? It's not part of this patch. It
might be in rndis_set_subchannel(), where a value larger than
64 could be sent to the Hyper-V host, expecting that the Hyper-V
host will limit it to 64. But netvsc driver code is declaring an array
of size VRSS_CHANNEL_MAX, and there's nothing that guarantees
that Hyper-V will always limit the channel count to 64. But maybe
the netvsc driver enforces the limit of VRSS_CHANNEL_MAX in a
place that I didn't immediately see in a quick look at the code.

>=20
> Based on this change the subchannel creation would change as follows:
>=20
> -------------------------------------------------------------
> |No. of vCPU	|dev_info->num_chn	|subchannel created |
> -------------------------------------------------------------
> |  0-16		|	16		|	vCPU	    |
> | >16 & <=3D32	|	16		|	16          |
> | >32 & <=3D128	|	vCPU/2		|	vCPU/2      |
> | >128		|	vCPU/2		|	64          |
> -------------------------------------------------------------

The terminology here is slightly wrong. A VMBus device has one
primary channel plus zero or more subchannels. The chart
above is specifying the total number of channels (primary plus
subchannels), not the number of subchannels.

Michael

>=20
> Performance tests showed significant improvement in throughput:
> - 0.54% for 16 vCPUs
> - 0.83% for 32 vCPUs
> - 1.76% for 48 vCPUs
> - 10.35% for 64 vCPUs
> - 13.47% for 96 vCPUs
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v2:
> * Set dev_info->num_chn based on vCPU count
> ---
>  drivers/net/hyperv/hyperv_net.h | 2 +-
>  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index 810977952f95..e690b95b1bbb 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -882,7 +882,7 @@ struct nvsp_message {
>=20
>  #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
>  #define VRSS_CHANNEL_MAX 64
> -#define VRSS_CHANNEL_DEFAULT 8
> +#define VRSS_CHANNEL_DEFAULT 16
>=20
>  #define RNDIS_MAX_PKT_DEFAULT 8
>  #define RNDIS_PKT_ALIGN_DEFAULT 8
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 44142245343d..e32eb2997bf7 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -27,6 +27,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/netpoll.h>
>  #include <linux/bpf.h>
> +#include <linux/cpumask.h>
>=20
>  #include <net/arp.h>
>  #include <net/route.h>
> @@ -987,7 +988,9 @@ struct netvsc_device_info *netvsc_devinfo_get(struct
> netvsc_device *nvdev)
>  			dev_info->bprog =3D prog;
>  		}
>  	} else {
> -		dev_info->num_chn =3D VRSS_CHANNEL_DEFAULT;
> +		int count =3D num_online_cpus();
> +
> +		dev_info->num_chn =3D (count < 32) ? VRSS_CHANNEL_DEFAULT : DIV_ROUND_=
UP(count, 2);
>  		dev_info->send_sections =3D NETVSC_DEFAULT_TX;
>  		dev_info->send_section_size =3D NETVSC_SEND_SECTION_SIZE;
>  		dev_info->recv_sections =3D NETVSC_DEFAULT_RX;
> --
> 2.34.1
>=20

