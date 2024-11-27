Return-Path: <linux-hyperv+bounces-3375-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3E9DAF40
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AC3166553
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56318C03E;
	Wed, 27 Nov 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nnMzM6j/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012051.outbound.protection.outlook.com [52.103.2.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B313BC35;
	Wed, 27 Nov 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747030; cv=fail; b=IU+OhvGJOWfNZkMF+R5wBZ+jvM4vAprI2ksxmIaztVE1/eFTGXc2S7IXAllNWVdSDLodz4bLJ04vuHdvW4m9aqkqUWJKTdGABEC+AWpdgVDYq/UZjIuBoOmhdilBUd+BoKoBRfob74e6mbLAod1UBfOksEDo1tE57d44VBsWOig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747030; c=relaxed/simple;
	bh=VQ5PIqd1VZQH8N4XyGZol6ngWoU7Or1fu4pCjiSY2mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYXKqf1j5zwRsrM+qx3mF/zGPOq8J93Rw+OgcHLqYf8Z1Sa6v9435oyx4Ii2FTjLBbwoa/33xCrGwTt2rs8jsxANw/XIOPE0LotAl8ViOxV6OhdKQsjONxjAjGFdNqTFDTwpR6BgOTVeee+e2Z06tcdFqwikL9Hq3fJTg2+TDD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nnMzM6j/; arc=fail smtp.client-ip=52.103.2.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lza9Wtvr5zXGrrrRmSDQPwPojYwubOd/gV2tCB5a8nLe1+e8WMXstK7K5DFZ1wap0SxCcl+zIDl7LkxFeiibtonhZZy0KanplXa6d0THmUydcqs0Njpe+s/vwKcl40k5rbiHhlaWsZ7NxfVSzzc8hP0AfQw0LKdjSYgYm9et/Rybgo0NSgk8k/e79Gi1z2I0RJPnnB8w2WgnDPMVo89lxX1bOZiWb1pCPbmP2hGoSi9dq+TwD5yZF/Me86y9I/tiTbcWpznyx/751ysFKVvw66TmuZLOQhnEEGIlim6UC2KvoPS4qxij8yDwvmkGTbt7+y1wNUfulOON0Xmrl4SK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSw02FFKNAOc7K6kJ61rZCoeVh9Kh6b7hmJUJYp+HCo=;
 b=qHKj/EeAjB2U/huPcFZqf4cZQkbKLELpXdcre+36VE1iFhtK+0D+0zf5KAa+zeK9NN6W0LDS0r5EMTpEhL0oYEYHHQtiaSzib6leW4t29uC817K4ChLMPQI92f2XRqaorSbD7Nu88ps4FRFreENERBfmDjG8kS/MU+H5UtWTR6CMMwxqdFNVeg/9dvEkdxomj3+8PV0TX2k21T7VknXLnCQd6ErSfLodxGUM2Ux/QXl6PW/PZkbH79w6FTeKfVB+K7ubmsj59Dx2caDnFCfWiiPscBLcvUvNAF9TZ4waJmKbeKR9n8iOy+32wTlH57GKbi1m56oGmjWTns6NAfkEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSw02FFKNAOc7K6kJ61rZCoeVh9Kh6b7hmJUJYp+HCo=;
 b=nnMzM6j/erbYrnhsW4VTr1ge7W0f21Xo+T7/hs9GzvxxQlqcbAt4TQdKCZc6f3iag4Wk+7Ic9xlXGoScfXTIaze49ri9keI/kVh2KONTOt3nruveKhnCLy2JDeiGz45dbW/eJIIXrbuSfpiuMfxB7H1HJBnWsfLzrrDQ9ve3sE+Iakh2t9PXDhfeV1uJKlU1S5yeDN41UYCyDu0bZ5jxbMNzDgyOyc7jNkCs0EKpSymDZjsrLEKxCg5mDqfoYlhWfIA9yMe5sPBqwgohQrBEWXpCOxA4nSH4gKg4IG1JWF+Bb12lVHPZ4PHPBZosug6ZL1FM3Zn6GRbyuq4bDsg5pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9570.namprd02.prod.outlook.com (2603:10b6:8:f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Wed, 27 Nov 2024 22:37:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 22:37:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Cathy Avery <cavery@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: "bhull@redhat.com" <bhull@redhat.com>, "emilne@redhat.com"
	<emilne@redhat.com>, "loberman@redhat.com" <loberman@redhat.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH v2] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
Thread-Topic: [PATCH v2] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
Thread-Index: AQHbQPgUa182hHqRi0C/I7R3exzABLLLttKQ
Date: Wed, 27 Nov 2024 22:37:04 +0000
Message-ID:
 <SN6PR02MB41578E632973F20E13989BFFD4282@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241127181324.3318443-1-cavery@redhat.com>
In-Reply-To: <20241127181324.3318443-1-cavery@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9570:EE_
x-ms-office365-filtering-correlation-id: a1846126-a378-4d6d-27ce-08dd0f3404df
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|8060799006|8062599003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pwGCXL9A+XwpzfGea4NMvI4Xa9aOHlrJSMqhOWwh0nrlu5/+HMzGd5krqLxH?=
 =?us-ascii?Q?ADTubr7eHiLFLlEyZYqzmIjX+rnldJi1ZFeh5HMuvRdbT+A2jDwp7OMqrPT3?=
 =?us-ascii?Q?9CiCeGFyGL3wn+wd1OebU2ijUx8qlq6QQBETl3m/aVVa9IcXrhBA5uEXTTmK?=
 =?us-ascii?Q?aAPxXvfC7vu/zDn6/Wjprv3qdTnHbKt3aDVXREe8L5yE+DNbYd04RiWCXaMJ?=
 =?us-ascii?Q?jSZ9Y3JfnMf6WPq1Lr0ceyvyjcJqRXvgTEGof/o0qexZJIimgRkssEpjEw+E?=
 =?us-ascii?Q?KX6fWhvqrZS/dEog8dU/md9qipGVq4HzQyT6uQHMQDPUeK6uWv9+Uqd4m/cp?=
 =?us-ascii?Q?FK2KTSRbwj4XMEbATFEocco+n+gDLm/vZXwPi7kIUshwrEXjAgpZteGSIAcT?=
 =?us-ascii?Q?Gu1/yFWoof8AAB+ipEPrOctW13W2WJZpjuXK8iDGhlTGGBvvjtypXsWzbA/B?=
 =?us-ascii?Q?ozwVr2fjCD1m9SBv05cTr5xyIO5toJAjUNlChUImFgtn3Xj8RMQdgy4uwxJt?=
 =?us-ascii?Q?zTySEKAmi+QSMkUCfSwheryGsgmYOxt6dEKaDS4/cudjdKl7tTFD7s22z21K?=
 =?us-ascii?Q?t67wVOKNI7uwi+DU18ur8Z+teVBGQuk+EU5/lfNlk4Y7RaJJuGAPmV2JuOY4?=
 =?us-ascii?Q?0MBhu6TfUvP/0oogcXUW22NNCBgjb0PsWF04o2WTx90Bkctsg0ZXZqEVWUM/?=
 =?us-ascii?Q?Q4dj+/p8sCpLVpfTlmJzGZjXac2uwNrZS06/u2MRRdeP0/Idu3UxE6sGksve?=
 =?us-ascii?Q?CdiQ2FHzH4m3WoquJPnCLKLig25YLa/Y+8vQ7z9JXJkwzFhieBAWRz4vHDWI?=
 =?us-ascii?Q?RQy0Fy4rxZ/7PQQ9ZtsLDmeuDz29+XoCs6MeYq9dhzxb/UOHCvdLltXD8zWO?=
 =?us-ascii?Q?iX/NYDaX7PUuGKmErPsipIJ9qKfi2uttbJOZtEfEvgHI6BGXOBfDrh3Cayjb?=
 =?us-ascii?Q?tQskz4GTCbnwmg/OlXdEv2dVE35T6Alm6eBI5yeIkSnSik8DGaqLxSwKIXMu?=
 =?us-ascii?Q?cEFFLtX618AJ8arm1bJx1PSWUg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RQBIu02Czqp0kzyVPWNAk0J8gfmG7M84Q9YqH+lswQLDWWG+mn35NTqWfGMF?=
 =?us-ascii?Q?V8qilrDxwc0+K/94GX4tjG5Q00LBf+4zv0ZcXR3J6SoHipc5N/Hcg5jhUUoA?=
 =?us-ascii?Q?sfJmBXSBtQeJ5g0w0UrNwnAPivo0NK1g1YHjWNGdGrNlOMdcgsKKttwNbKSH?=
 =?us-ascii?Q?KDvcd/T69+2mmrq3/2ZF4aE2/jiAjRDoWegHiRaCKKUUBcRsrMOpYYS2PFo9?=
 =?us-ascii?Q?44zVxzBH+m+jgQuf3T7uGG7a7ogTvZBHAioc9DaiUzCeDD0sK4AYI5Dd8L0r?=
 =?us-ascii?Q?OepzsgIaONxnvtAXWjMfedYC9z7hVbTLACrWOPrqu837o6+dHP2lOxfPumL4?=
 =?us-ascii?Q?BT3P3d+9hCxYq+FD+xCKtB4PFoB7mRrB4T1JMG8BldGzFgkoSHN7ZvQDnQwR?=
 =?us-ascii?Q?ffh3/882kEhcG+g6zZD0cgiUUVTlkHaKtaueYVa9HDuHTQmMjfx50sUl2BLM?=
 =?us-ascii?Q?iP/9PRdgznAnVs3sjBtB662Ktn4VmlUG2mBn4wP5sXRwdXVBXxaPsDgr/aSu?=
 =?us-ascii?Q?65AjB/RvjghdfhBnQ0hWhYy+jYMMGZh6w+Q1/Ww47VzlnP4Pbs+3M90Ur8rn?=
 =?us-ascii?Q?B4tViP133bsvI1SM9f5jvqz388cMAiqYnJE+SUIaEg2mVqO1RKas+PJKqg4I?=
 =?us-ascii?Q?c6Xqj30fQOAmVX1S/G/6TRAE9Hkc2IhLhCcLo5ZmaEGC2zjZ1UCckDqrvUsF?=
 =?us-ascii?Q?H71An6OG7R/9IGlMFG2WtWCsIQB8Y0EIxX+GnRLE82/0VDpS6WbWTtQCVOHp?=
 =?us-ascii?Q?X2aVCLZ9moENDbCYdovIjUSI/BkmTgyf/dZD1WV7tmyHpzJb8nvSdMifHVGI?=
 =?us-ascii?Q?lsy2UCPoiou+fpcq4AuJCuiWfvCw2QoGTxysIGNZnObHPw9daJ9TJWCmEaV1?=
 =?us-ascii?Q?CryRNJHWWwitjWeVuQJ4Lj2AhEqJT2XQSWvSbtBkdI6lcCh8jgHi5tUUwgvk?=
 =?us-ascii?Q?RIQ9oa/MoufNEUN9PXGYJK4pph/QQphaZUyX2OSedx0Foo4Z7d43e7XhcIKr?=
 =?us-ascii?Q?TNYpGf4ZDwXfI4ZuDSrNGv+dW0cUMTT0KfwD/anzneTZo1r4x+Jkg7P3yngm?=
 =?us-ascii?Q?enz5C4mopHNItucPfKNzAAshfnppSQWPvkqx3snn7LnDQt6F0ANrDxJ6dIVc?=
 =?us-ascii?Q?u6/gZiwI/szrQ3pQ4lzcdUccS7tQeammvpog5DMoh1hSWyuB36PJFgUituPG?=
 =?us-ascii?Q?dsbwq7ErGcS14ruqnGYraMrRgSUXBtZ8hIxQ+U0wK9aXAcvKE82HgdvRnCo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1846126-a378-4d6d-27ce-08dd0f3404df
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 22:37:05.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9570

From: Cathy Avery <cavery@redhat.com> Sent: Wednesday, November 27, 2024 10=
:13 AM
>=20
> This patch partially reverts
>=20
> 	commit 812fe6420a6e789db68f18cdb25c5c89f4561334
> 	Author: Michael Kelley <mikelley@microsoft.com>
> 	Date:   Fri Aug 25 10:21:24 2023 -0700
>=20
> 	scsi: storvsc: Handle additional SRB status values
>=20
> HyperV does not support MAINTENANCE_IN resulting in FC passthrough
> returning the SRB_STATUS_DATA_OVERRUN value. Now that
> SRB_STATUS_DATA_OVERRUN
> is treated as an error multipath ALUA paths go into a faulty state as mul=
tipath
> ALUA submits RTPG commands via MAINTENANCE_IN.
>=20
> [    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
> tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
> [    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752
>=20
> MAINTENANCE_IN now returns success to avoid the error path as
> is currently done with INQUIRY and MODE_SENSE.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
> Changes since v1:
> - Handle error and logging by returning success as previously
>   done with INQUIRY and MODE_SENSE [Michael Kelley].
> ---
>  drivers/scsi/storvsc_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..d0b55c1fa908 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
>  */
>  static int vmstor_proto_version;
>=20
> +static bool hv_dev_is_fc(struct hv_device *hv_dev);
> +
>  #define STORVSC_LOGGING_NONE	0
>  #define STORVSC_LOGGING_ERROR	1
>  #define STORVSC_LOGGING_WARN	2
> @@ -1138,6 +1140,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device
> *stor_device,
>  	 * not correctly handle:
>  	 * INQUIRY command with page code parameter set to 0x80
>  	 * MODE_SENSE command with cmd[2] =3D=3D 0x1c
> +	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
>  	 *
>  	 * Setup srb and scsi status so this won't be fatal.
>  	 * We do this so we can distinguish truly fatal failues
> @@ -1145,7 +1148,9 @@ static void storvsc_on_io_completion(struct storvsc=
_device
> *stor_device,
>  	 */
>=20
>  	if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> -	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE)) {
> +	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> +	   (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> +	   hv_dev_is_fc(device))) {
>  		vstor_packet->vm_srb.scsi_status =3D 0;
>  		vstor_packet->vm_srb.srb_status =3D SRB_STATUS_SUCCESS;
>  	}
> --
> 2.42.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

