Return-Path: <linux-hyperv+bounces-3221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E119F9B70E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 01:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF10B21696
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 00:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50B4A1E;
	Thu, 31 Oct 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f8pFWNUl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2093.outbound.protection.outlook.com [40.92.19.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBC139D;
	Thu, 31 Oct 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333515; cv=fail; b=LpPQphnaCyxvhOQMbKGH8ZYv3Pa7tnHF9bIbvUvhzGGBNTHQDJ+/Epc1ypYWexYi8kwjLrSGQ3c1mimTG7Wgi0pHe1rkyTqRnsJ5WDun1mh905T+fao9oNfsPxt0wravHnqqfDNYYSXytj2M2QII5Q6kQdtj04XNOsnGpyRjlaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333515; c=relaxed/simple;
	bh=L5IMuo4oB6g9BAuBNWualXF4QZws3F3mexz7u7ZRmFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0BguSk5Xxc+rVXG+Xk8y2Nt77y9VpAIVJ7pjf5vdd2k8h/I/isXF1CfktV59zx34aeNvdc84sTK8u6Cz+lVmK3NS7WV/qXYPZr0LV0PcftdXa5c3Hft5wOoL0XsmAt/7AqWG0+NHdlC8/bTQ9Y9+6JsDxjNxZyTvpklRAqzidQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f8pFWNUl; arc=fail smtp.client-ip=40.92.19.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPwQ5fxdi/b2PCZBCtKbRqbfh8oLzdjq0XR6ElGaKtlpjX6LejWjOF9ooKbE7bl3TrtNsJLaD3RcNmrL/sGiN4cQBsQ913Hv7k/UebK9AI6lkFDaTJCa22YMM22ldV0mmslzwRlvFAcZ6o6GMsdTHQ/Yz2SG+cPkuWjJaZNWOJlRtPNMXS+33zGZFe6pbY6LFyO+393n70h3rSnNzcVHZQA9fP2BbWVY6fUSofbKPvJTgWY20DV5Yg97nGo0F5nDOGEDYgvwUYfA/ZmEOoPdDFl1f+hp8IKTW9N/f6Zd6TIR/qPCDX4WddioW82+wxw4w3/Y7VUXaheR8cU39NytLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ff5MqwYZJLQlgo4kqoc1A5IX6hdgphga4IR4rClPw8=;
 b=V9Rm5N1ind8WxvdsDQF5aXxFpWvGymTygRxAp+NLhPOO+SJrCRODkCplNCMv18arr/lSRUuiMJgxXhQegfaSr4+dkUU8MxKd36BwxcM1xcX2z/px5np6lF+tbJyUPW+RZwnNLyGEbaWIstJgEvTvkpn1zaG+q1gCLWyom7Panu9p4MnyFZ2dAUHCJf5dsJEF4NMjwVgwBfe/GTEDbrPOB4ntCmTdbkzb+n6I6bkm3elfDAOwTc3KLEE2MVf7rmpNauZyHkMQTReog0wf1Zf+lcJzctUvzZTfW8IK6Y7pQpy6+FjtZqXUYj1Kz34VzQgpyE2FqjztlBMHLmh9adAmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ff5MqwYZJLQlgo4kqoc1A5IX6hdgphga4IR4rClPw8=;
 b=f8pFWNUlw//jW4RbrR1j2SYVK2efAeW+ECWDSkS2iiLUXYppBUcnGwbTNGRo69csqe+gXymhfYULLiIKz0W1kgBGO881f11hseMSBlaWtv0csxtVIN4+sCzvtQOHvV9tXUV2FJKi1lP1Ht9HBLv9U19R7o1zxfS3X4Czscv/25Y7g594XQhvwetrlQOkdMCwoRkZEKFHc9HnYA5+0hqKWAqP+xQ6Ozv3Vy4iom90cipqMW5bgDtpVABAZmsFITNGxCMSrmOhHLt//NbvVG+6+SjH/goN3wqy+fKtyrulNYpb6n29ew03h9zljMG+EHgP4JO/an4L7aiUTicwRBpu8w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7184.namprd02.prod.outlook.com (2603:10b6:a03:295::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 00:11:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 00:11:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index: AQHbAxLFR0Ovyi2Whk6CD70yxEN1m7KerxPQgAFHmYCAAFK20A==
Date: Thu, 31 Oct 2024 00:11:50 +0000
Message-ID:
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7184:EE_
x-ms-office365-filtering-correlation-id: 66603b8f-6b86-41b5-6973-08dcf9409e18
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|8060799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aJ683FOlfPxKCS7JdYAW4vyZVHLLnJJdbie1fWz23yD4szt9ycVDCpHaw3QQ?=
 =?us-ascii?Q?E5EO9LKCQvol8dmU3TyNFQY6muSbGyQWZwPZVBmNesJj/6HSKqbL9rSN2ULj?=
 =?us-ascii?Q?DPlyV0VGDJ+2Ul6xnqV0W4i+10zbn0NIMwXb9vxLaDVwE0pQ2iZwF6gtYpQd?=
 =?us-ascii?Q?fs9ESaHIoYMu1OpyNOgYXTic21O/bbw0ahapEAWku5vWnMe2hw/YLHR7pwEt?=
 =?us-ascii?Q?KjlGoJTZ76a6QLqNRzOkrcSuLjbffwfeaDADokfV8F1lEGmav8WOLd7rc49c?=
 =?us-ascii?Q?7CbHdKaz8+cA8tk21OjtHhIbWfGngg8K+O3FlX3v9+xDYHpT4zSTsMlw00gw?=
 =?us-ascii?Q?xylyBKhRr/0IppmzZGRKUr9tChRbCt4QXQo11DPbUhJXzmEizes0dzqcPez9?=
 =?us-ascii?Q?0MLsEw5KZPlKgMaO46ozMi7VKVyrA0GsE92Phqfxqlix836/O9INOVeFjr0p?=
 =?us-ascii?Q?VEhxeIvTwk0l4jAdKDUlemarVSxaSgpSkiJhGFJNiniAqnIN2YI4DFHdzL85?=
 =?us-ascii?Q?c7EwvfkOdxLa1K5p7R4CYG5R0SmvDB351KckpvJ8nY7uhNbLESi4FKdS0agd?=
 =?us-ascii?Q?QQTdRcAlGNvTVjkOYeJpzWKCweDzOKSsUkRaiqGMNTjfuNhDkJUaD45kqi7A?=
 =?us-ascii?Q?Rvz8qgmYNxUyO2kl0jvLWmqgxYkorSrz3CSHGYvXqSutJ/fHrfkXZjpOrOxT?=
 =?us-ascii?Q?sVJStDyANvd0f+J59sfat3cK3hQ7pM3/9lG8RAeymzgjyOUhxm0uVcSk8yGa?=
 =?us-ascii?Q?pe7x3HZyK9rKpdfVwL4dG2m3qooKLM3JP3keB6P3vzeFQN8FZEVTipCMBAuI?=
 =?us-ascii?Q?ZYcf27fvkStRTRI5WaNtebLkIorqtHI9WWaqRDTL2YUTsmE4w1VDJdL+x6vP?=
 =?us-ascii?Q?9QGZ/1kaBtox9O1fpEIgQorg4wAnMKQWayvAPCeH5o4t3rUATyhe42Zz1STt?=
 =?us-ascii?Q?s1oebVZz58TVc3G+IiUZsPv5rcwEfAm4085RZSkI7nO/gA8xuTHyY2JOKj9O?=
 =?us-ascii?Q?qlmaX6kQMjEvwXv6qMtfjvvTlQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RM7LW7julFeS7jAqFOyegE24YqguAnZoqDbaLHBrqN9JH78A3flQ7SHvrqaT?=
 =?us-ascii?Q?45qB9VuBRUlUM8l4HGI+hXUllRIGe6YHjLfE79uxclAE6VScNdsNclFugBEw?=
 =?us-ascii?Q?6id9y3W/SZYabJs0SXPpHAtVgqeHElhgMd9tRb66ZNeG0EysQCXPaEI5B4M9?=
 =?us-ascii?Q?q57oa1pMbfJ7zebCm6eX8+RTlpc7GZqgGdbOwDsjG72Tg40CWgmes5zUZWNF?=
 =?us-ascii?Q?KqPDi63lf/ld4tXs2wZTbYRSuyjQEkLPbC2g5tFFk/GXdZ3NwpdOyzKN8xNr?=
 =?us-ascii?Q?i4yKmZr7jb8PJF1T/xcVRsATEtnsSr/fz1vxsyedFgY6gTMtco2677Br51/w?=
 =?us-ascii?Q?JwstoNAv8mpS6vos39LkN/L6aDCTwCaZK1COccAi61P2kjWHzj9eicXFCe6X?=
 =?us-ascii?Q?GUv4l3VhAY9Jh3sYNRqUAAnfTviXgnp+XTJt/ZpR8sKUFgXy1j9bTn/spAaU?=
 =?us-ascii?Q?E46az1/HB1jqozFOgm7b1XwMi/cgak0NHTRmj5EFd6k30s3Z/GfZGGBtfLP4?=
 =?us-ascii?Q?xNAdphnShCcbVCmIcQkM9Yzwe3PIC2TKuZew2oxlK/sOqFGsJh/WKqhCbdd2?=
 =?us-ascii?Q?wNa2/D2sctV/rwjnC9pfrmkC7ltUKNa8nssrh9sr5tKAi4mAEOx+FWDpPGbf?=
 =?us-ascii?Q?NGLtNS7vDcrOwNav/3aWiEnWq9X1pKMamcavf1JuHYa8bZnFw6B6kMtpfHoT?=
 =?us-ascii?Q?qFond09BvSTOOCnxC5Met0BpZCx3mqLK+MYT+thvH7/HawXjQlcAvuIla/Wb?=
 =?us-ascii?Q?Xj5/vOY1syw9NX9VOBzQPwrfzagC7iKHX4RprwspgJpXy0yffRqnf81LWeGN?=
 =?us-ascii?Q?Q4MSosH6XGbdVq745hw/2M8+xOZ7hMdNL6om8c/5Tzs51PakOfarQmWU05rJ?=
 =?us-ascii?Q?u2DRKW8pcvZHLc7IQdojyknVkgIBjgGlagahtsw8LKaPgtpNqhfHcbXYjYet?=
 =?us-ascii?Q?wgTGCBWOD7P2pW3a/nXlz+hSQ/X18dYc7FraI6q5SnirkFzYLvtDZCLb01cb?=
 =?us-ascii?Q?iTeVBl+16HmsY7xFs+BLaAg4JX5/bzXcqiMBkaajffNUk0TvOTDAp9WEJEBJ?=
 =?us-ascii?Q?3hICVen46NsLZvFMqcb2wzJNMP0MVRj8I4h/uYK3K5DZgiFmaz2i0WFTELCW?=
 =?us-ascii?Q?GSBhhj06Gz/bpM3LTfgttj0mANxB0kQDG0gCywuhFJFHJkMQPD7n+RPRGYX5?=
 =?us-ascii?Q?TVqOU5u+xxxlPwreMCLLinHKKwEs7S+srzZKppCOdsMA4L1kKfpWSdUadis?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66603b8f-6b86-41b5-6973-08dcf9409e18
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 00:11:50.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7184

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, October 30, 2024 12=
:04 PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Tuesday, October 29, 2024 4:45 PM
> > [...]
> > An alternate approach occurs to me. util_probe() does these three
> > things in order:
> >
> > 1) Allocates the receive buffer
> > 2) Calls the util_init() function, which for KVP and VSS creates the ch=
ar dev
> > 3) Sets up the VMBus channel, including calling vmbus_open()
> >
> > What if the order of #2 and #3 were swapped in util_probe()? I
> > don't immediately see any interdependency between #2 and #3
> > for KVP and VSS, nor for Shutdown and Timesync. With the swap,
> > the VMBus channel would be fully open by the time the /dev entry
> > appears and the user space daemon can do anything.
> >
> > I haven't though too deeply about this, so maybe there's a problem
> > somewhere. But if not, it seems a lot cleaner.
> >
> > Michael
>=20
> I think #3 depends on #2, e.g. hv_kvp_init() sets the channel's
> preferred max_pkt_size, which is tested later in __vmbus_open().
>=20
> Another example of dependency is: hv_timesync_init() initializes
> host_ts.lock and adj_time_work, which are used by
> timesync_onchannelcallback() -> adj_guesttime().
> Note: the channel callback can be already running before
> vmbus_open() returns.
>=20

Indeed, you are right. I should have looked a little more closely. :-(

What do you think about this (compile tested only), which splits the
"init" function into two parts for devices that have char devs? I'm
trying to avoid adding yet another synchronization point by just
doing the init operations in the right order -- i.e., don't create the
user space /dev entry until the VMBus channel is ready.

Michael

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..77017d951826 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -767,6 +767,12 @@ hv_kvp_init(struct hv_util_service *srv)
 	 */
 	kvp_transaction.state =3D HVUTIL_DEVICE_INIT;
=20
+	return 0;
+}
+
+int
+hv_kvp_init_transport(void)
+{
 	hvt =3D hvutil_transport_init(kvp_devname, CN_KVP_IDX, CN_KVP_VAL,
 				    kvp_on_msg, kvp_on_reset);
 	if (!hvt)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..397f4c8fa46c 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -388,6 +388,12 @@ hv_vss_init(struct hv_util_service *srv)
 	 */
 	vss_transaction.state =3D HVUTIL_DEVICE_INIT;
=20
+	return 0;
+}
+
+int
+hv_vss_init_transport(void)
+{
 	hvt =3D hvutil_transport_init(vss_devname, CN_VSS_IDX, CN_VSS_VAL,
 				    vss_on_msg, vss_on_reset);
 	if (!hvt) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index c4f525325790..025d9b9e509b 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -141,6 +141,7 @@ static struct hv_util_service util_heartbeat =3D {
 static struct hv_util_service util_kvp =3D {
 	.util_cb =3D hv_kvp_onchannelcallback,
 	.util_init =3D hv_kvp_init,
+	.util_init_transport =3D hv_kvp_init_transport,
 	.util_pre_suspend =3D hv_kvp_pre_suspend,
 	.util_pre_resume =3D hv_kvp_pre_resume,
 	.util_deinit =3D hv_kvp_deinit,
@@ -149,6 +150,7 @@ static struct hv_util_service util_kvp =3D {
 static struct hv_util_service util_vss =3D {
 	.util_cb =3D hv_vss_onchannelcallback,
 	.util_init =3D hv_vss_init,
+	.util_init_transport =3D hv_vss_init_transport,
 	.util_pre_suspend =3D hv_vss_pre_suspend,
 	.util_pre_resume =3D hv_vss_pre_resume,
 	.util_deinit =3D hv_vss_deinit,
@@ -613,8 +615,18 @@ static int util_probe(struct hv_device *dev,
 	if (ret)
 		goto error;
=20
+	if (srv->util_init_transport) {
+		ret =3D srv->util_init_transport();
+		if (ret) {
+			ret =3D -ENODEV;
+			goto error2;
+		}
+	}
 	return 0;
=20
+error2:
+	vmbus_close(dev->channel);
+
 error:
 	if (srv->util_deinit)
 		srv->util_deinit();
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d2856023d53c..52cb744b4d7f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -370,12 +370,14 @@ void vmbus_on_event(unsigned long data);
 void vmbus_on_msg_dpc(unsigned long data);
=20
 int hv_kvp_init(struct hv_util_service *srv);
+int hv_kvp_init_transport(void);
 void hv_kvp_deinit(void);
 int hv_kvp_pre_suspend(void);
 int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
=20
 int hv_vss_init(struct hv_util_service *srv);
+int hv_vss_init_transport(void);
 void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..02a226bcf0ed 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1559,6 +1559,7 @@ struct hv_util_service {
 	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
+	int (*util_init_transport)(void);
 	void (*util_deinit)(void);
 	int (*util_pre_suspend)(void);
 	int (*util_pre_resume)(void);



