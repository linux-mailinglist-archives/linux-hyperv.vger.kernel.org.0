Return-Path: <linux-hyperv+bounces-2825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0195D7E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541DC1F22A58
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC781957E4;
	Fri, 23 Aug 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nn1UnoUB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010009.outbound.protection.outlook.com [52.103.12.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59401925B9;
	Fri, 23 Aug 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445625; cv=fail; b=NNq+ZIxubHfqT49RCkyMOCx0ZO5yqHq8VR8R6EKb0U/iJMum+yXfzvXGNJF4+chPHmn+f7BBpH79nTF412zDFmeUzxGhkHnltuGSSLz68c/U9Ao04Oqjg81jjMZ+GzE4vOFSPYmOOcKjBkRwvXzkMjhB+HkP0eme9M13exaMUOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445625; c=relaxed/simple;
	bh=CkOKarMjvBlBvwdab9f3F5nmKyweiSwxEXkOF48Xtn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXrzG0zr1THnNuTHG1qiBWNzxK01qVoCLAYjkeiABTfvFK5HybivaSzhgoSms1FB2oTmPPtJq/P9XYHDC4cwoVC9d8scjb3d3vLsf1pkVgLyYMDeCnNRswJmvhtx1dYcJ7k3kvDyfNZ7BshpTNQhxPAI3qR/pVup+XshUVmajrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nn1UnoUB; arc=fail smtp.client-ip=52.103.12.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwODwUV1dKJ0RvNyWqRoNjV+DhL2tj/oOFAbp1cPjKOBLeNKcY73vBXeo2baQvIxQRrq6VqTIqtQzJ1cuxsCva3mUES9nkmC4OSk6l2LaG2NI2uxtZi8oA5ab3c/gQx9uVjdNcuhxbr26aMC8G/OnpzhiV/p2oym+eNYyTu51JYDtz/KWXx6n+0Lg7vSXS39OfZQlvYWmRbYZ8X3TUAdFNx9mXvpWUg3vliY0diqCTuJD0qIzkuhsj+bxfZrVzrlOaxKlBXZ6BV3Ol97NBxLaATUTJHkiflz8miKw3u5+oKQ148EZb9qlCtsavSYV+ncXwEtx8BxVTl/8yiBHdgY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTeRk3boFcaxCGWHlJ4tNzptrSiHl9sJwQxI4pNCfsM=;
 b=Vh7jP409Xe1cSVqjYv/mi+zuc2RobZMTw0amvv3JY91wKrWMV7wzoITNDHLEh1gFXikJ+STXfh9g2vqmuBdIcrmcIoCnxGEbo0Se/+/BhVeimRkeehfhgU9orPKFeEG4zUbVuXUvSHPlpHus8n3Hb/2Ki5msBMYzqaIKplwGVKeQ+pCZj3IXYy5D4q/QiDIvQDONT6a1Yq9MyGuiiBLkTNsdUdx3RFAdXiVGqBvqFiHDgWo7QnkQ51OAYAwqyKBR9jO1Xg6EgtJH5eUx+nJUYQlBvVIs31Ol/Y3Z/pgggxjuj/yj+3YL6Lt4fSmnDF+Tsu3vHQj7z4b1v+lloTJlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTeRk3boFcaxCGWHlJ4tNzptrSiHl9sJwQxI4pNCfsM=;
 b=nn1UnoUBeenzxCDH1F8r1g4bWuEk5mQQ2x9ngfoDunN05IuAPDhNRszIoLrH3gkwQMqcCl1/gVmlQ5rcEaiv5ECD+Zu+GEnfEHaUzDcvIYBTFLlYO7vrd24faENEH8TwYrrjGT7jHwwPjPKyH7JDIfHmwaIKWIkORzZxv0CS8RyaOzWLa74/waAKdhFaeZnOK6Iks5Sgh2/Zgr7e5/gmDShqVuVx6KkUwe1sJZ/p4TDrwLDUMQPCmHxlwMEGJWLhbRDwX1qpsvz3sDhn4L+tzbLunQhjSyC5TwTAjZiRHNNtrolk/gGGnX5X1IDHxRMYB6bEBTLkeKuWhsMMGsJZcg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6962.namprd02.prod.outlook.com (2603:10b6:a03:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Fri, 23 Aug
 2024 20:40:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 20:40:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, Michael Kelley
	<mhklinux@outlook.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 0/7] Introduce swiotlb throttling
Thread-Topic: [RFC 0/7] Introduce swiotlb throttling
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI0ZmsAgADTyNA=
Date: Fri, 23 Aug 2024 20:40:16 +0000
Message-ID:
 <SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
 <20240823084458.4394b401@meshulam.tesarici.cz>
In-Reply-To: <20240823084458.4394b401@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [QPfqj8FxiyL0u3GI73Q55BNGYt0TcTqM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6962:EE_
x-ms-office365-filtering-correlation-id: 0771684e-c18d-4833-ad8d-08dcc3b3cbe2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799003|461199028|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 sP4q++1BbrH7t9wY1WSe2aWaBPg3EF2LxRCaAul9rS8X2M5hSCVpPSuJdADf0olm4fAhYRnWpMLsh/kh6VlyR7kFl7BOBCVYb/s93L0cBPyvBvcJmirPKN4NhgoBXsdZ7KHahKT5KVLSrBSi6aQlzlpBVaampvGvJWroutGtW1oYAmQ1ulXr+fBN5d4dIEhM4XTEG2CzvUaxCs9cZAxTRHU9UhJ5tpv0Pxxed0xurH9ZNVV5OTVrOFbQMAVLNSTf/VZ+NcxnzknDSwwbuSJDJ9j/JF1X0cppjnBCAyNm4KQGpdcUViv+nfqHfb6TFJfNff1kTjTTg4/n00FGdoumiGiLE+l4O4H9olcXipiByKDm0zcbyTwLfbo7AmzPdIqKFo8nhDPHwmx7evfbsIoWwhZ7+UjWMvJtgqwV6pwH0qI5pH1LvMb1JPNYB+Jij0MoaCWtwIHIKBkbHCSpaueiExEjMPyzRqZovcTC8fo4ag3tYCEn00AM+qWFMMubZRLNiu3TwrckVV2mTf3WkGXtK6yzgbRUMzv4v719SIxrtCMzC01xsRSCMaQG25+vZCiBbLIidptlBdge314g9bA+Xaw13NF+aUu/ymXFFDQY4TPYKdRpFzPkt7M+Cf4fJ6Y672Hlx7aBqGtrJ2Vqfk+S4HiDEB/xnMNSKFsNcF3V15bty2DMo6U91wMx46VWgWC+9QmF044Kzpq97ey/goHapA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Ssjr3dZ4TlMe1r2Rd6KZamfyuGaOKzBiVypbl7UinoRhM1XON5bR1EmxgJ?=
 =?iso-8859-2?Q?xHe+Uu8SNCe8yw7qBgfKy2NF6ITL30xltd5sHXyPoNgKIpM1+IKAGkzKLO?=
 =?iso-8859-2?Q?vpEF+FWo49eak9IXyDUmbjrApW4p0FG/mOUCpgEaHWA8VDL1d8FxrO24cv?=
 =?iso-8859-2?Q?pWZVG6IIFYaf/AcSxVLKbGR4XP4K7qBeihOnTd+HureMZsZbw5FCK5Akdr?=
 =?iso-8859-2?Q?B6eeyxUPmlvJ40d1F65j1H17Skpw+dSFzsp+HA6RX8uZai7NG1tezRymAe?=
 =?iso-8859-2?Q?HxHyF5VKSmkc4eGmbcYAhOTdDdqJolPehUalqpKAbsd6xoaScMcxPeXQ7t?=
 =?iso-8859-2?Q?QBJ84i+3ZLanWBGkf3LJVQIGsPx6Ob7F/KJyr+DJaBXav0/TF9Cb3XU91O?=
 =?iso-8859-2?Q?m7lvdSaCKKXqEu5vV5hSWGC/J14x82mt6CxWm9ekzMX0vTfCFmGbCUmIod?=
 =?iso-8859-2?Q?jBRBqSeN9woxI+0MU8KEU9xjty60SD7fIHkMNGanE3Y067xm5CHNt9vDRH?=
 =?iso-8859-2?Q?p/bh6JyGeYZuTb64lQvmUz00S1omElk1Ylt9POsx41Ne+GqzmPHeqF7OpZ?=
 =?iso-8859-2?Q?KNQx+xmlVcIaY7O8/Fky3PEoe/LzEEmNWvv/BtbHX7gLP4Ct2Mb2+lTTsL?=
 =?iso-8859-2?Q?GmtikenybLx0+3dKQO+EI/dasi5W4E6CMa0pmdWfGxrWBjki+IjytEr2aU?=
 =?iso-8859-2?Q?+i3Wy/YzvZlV0B7eieVYhyD781kYc3lyb55C55uF2UZV+L/lVLF7+m0uuO?=
 =?iso-8859-2?Q?qTLjd8RvJCDzQw8RGEkMeDjl8bAhU4UGUWb5BuAVgFXXAXaBiKLpVo1Z8O?=
 =?iso-8859-2?Q?1WI6BBs6PjcbMU44SuMvwWdiVXF8ptJhnxNvDnu7BEKfxsC+juKv4Gx3Hj?=
 =?iso-8859-2?Q?2tEYEN+k3LmGEetuP0SdVfRXiGurt8DpesbPm0GvIBEqW8iDvYwwlYL925?=
 =?iso-8859-2?Q?V2cRYnQg0pdBqXvFQiTr3ltYEndqyQZOpqkGtrnctmOMZpjK+ky05UHmii?=
 =?iso-8859-2?Q?52WA9N2N1XQCt2RkHswbOUSirabFuuzKq5vTqz46UD6ShDRuxc4qHYzEiN?=
 =?iso-8859-2?Q?jbjvZELW9d9DhjueV4GkWd5f4/DsNgopND3wLOPSSCibEQAr+5MCEwKyDH?=
 =?iso-8859-2?Q?0+jRqL7NnuGOg8MNxWq3Zxhi9Xg/RZzcK9nwtcbStRz2Yjc+78Uy98vlpT?=
 =?iso-8859-2?Q?Iwe/CHH5Um09ERGkMMt/vGHSsj/FMjSlE/rxy+8F/diXeaBvnpI2kk/Ivh?=
 =?iso-8859-2?Q?fbKZ+Wygf0XFfukNIsV6nnpw0bvh2EUYC8IuaqGfE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0771684e-c18d-4833-ad8d-08dcc3b3cbe2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 20:40:16.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6962

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Thursday, August 22, 2024 1=
1:45 PM
>=20
> Hi all,
>=20
> upfront, I've had more time to consider this idea, because Michael
> kindly shared it with me back in February.
>=20
> On Thu, 22 Aug 2024 11:37:11 -0700
> mhkelley58@gmail.com wrote:
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Linux device drivers may make DMA map/unmap calls in contexts that
> > cannot block, such as in an interrupt handler. Consequently, when a
> > DMA map call must use a bounce buffer, the allocation of swiotlb
> > memory must always succeed immediately. If swiotlb memory is
> > exhausted, the DMA map call cannot wait for memory to be released. The
> > call fails, which usually results in an I/O error.
>=20
> FTR most I/O errors are recoverable, but the recovery usually takes
> a lot of time. Plus the errors are logged and usually treated as
> important by monitoring software. In short, I agree it's a poor choice.
>=20
> > Bounce buffers are usually used infrequently for a few corner cases,
> > so the default swiotlb memory allocation of 64 MiB is more than
> > sufficient to avoid running out and causing errors. However, recently
> > introduced Confidential Computing (CoCo) VMs must use bounce buffers
> > for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> > a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> > swiotlb memory. This large allocation reduces the likelihood of a
> > spike in usage causing DMA map failures. Unfortunately for most
> > workloads, this insurance against spikes comes at the cost of
> > potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
> > memory can't be used for other purposes.
>=20
> It may be worth mentioning that page encryption state can be changed by
> a hypercall, but that's a costly (and non-atomic) operation. It's much
> faster to copy the data to a page which is already unencrypted (a
> bounce buffer).
>=20
> > Approach
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > The goal is to significantly reduce the amount of memory reserved as
> > swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> > DMA map failures due to memory exhaustion.
> >
> > To reach this goal, this patch set introduces the concept of swiotlb
> > throttling, which can delay swiotlb allocation requests when swiotlb
> > memory usage is high. This approach depends on the fact that some
> > DMA map requests are made from contexts where it's OK to block.
> > Throttling such requests is acceptable to spread out a spike in usage.
> >
> > Because it's not possible to detect at runtime whether a DMA map call
> > is made in a context that can block, the calls in key device drivers
> > must be updated with a MAY_BLOCK attribute, if appropriate.
>=20
> Before somebody asks, the general agreement for decades has been that
> there should be no global state indicating whether the kernel is in
> atomic context. Instead, if a function needs to know, it should take an
> explicit parameter.
>=20
> IOW this MAY_BLOCK attribute follows an unquestioned kernel design
> pattern.
>=20
> > When this
> > attribute is set and swiotlb memory usage is above a threshold, the
> > swiotlb allocation code can serialize swiotlb memory usage to help
> > ensure that it is not exhausted.
> >
> > In general, storage device drivers can take advantage of the MAY_BLOCK
> > option, while network device drivers cannot. The Linux block layer
> > already allows storage requests to block when the BLK_MQ_F_BLOCKING
> > flag is present on the request queue. In a CoCo VM environment,
> > relatively few device types are used for storage devices, and updating
> > these drivers is feasible. This patch set updates the NVMe driver and
> > the Hyper-V storvsc synthetic storage driver. A few other drivers
> > might also need to be updated to handle the key CoCo VM storage
> > devices.
> >
> > Because network drivers generally cannot use swiotlb throttling, it is
> > still possible for swiotlb memory to become exhausted. But blunting
> > the maximum swiotlb memory used by storage devices can significantly
> > reduce the peak usage, and a smaller amount of swiotlb memory can be
> > allocated in a CoCo VM. Also, usage by storage drivers is likely to
> > overall be larger than for network drivers, especially when large
> > numbers of disk devices are in use, each with many I/O requests in-
> > flight.
>=20
> The system can also handle network packet loss much better than I/O
> errors, mainly because lost packets have always been part of normal
> operation, unlike I/O errors. After all, that's why we unmount all
> filesystems on removable media before physically unplugging (or
> ejecting) them.
>=20
> > swiotlb throttling does not affect the context requirements of DMA
> > unmap calls. These always complete without blocking, even if the
> > corresponding DMA map call was throttled.
> >
> > Patches
> > =3D=3D=3D=3D=3D=3D=3D
> > Patches 1 and 2 implement the core of swiotlb throttling. They define
> > DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
> > indicate that a DMA map call is allowed to block, and therefore can be
> > throttled. They update swiotlb_tbl_map_single() to detect this flag and
> > implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
> > updated to handle a previously throttled request that has now freed
> > its swiotlb memory.
> >
> > Patch 3 adds the dma_recommend_may_block() call that device drivers
> > can use to know if there's benefit in using the MAY_BLOCK option on
> > DMA map calls. If not in a CoCo VM, this call returns "false" because
> > swiotlb is not being used for all DMA I/O. This allows the driver to
> > set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
> > there is benefit.
> >
> > Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
> > variant to allow passing the MAY_BLOCK attribute.
> >
> > Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
> > is used for storage in CoCo VMs in the Azure public cloud.
> >
> > Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.
> >
> > Discussion
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > * Since swiotlb isn't visible to device drivers, I've specifically
> > named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
> > something swiotlb specific. While this patch set consumes MAY_BLOCK
> > only on the DMA direct path to do throttling in the swiotlb code,
> > there might be other uses in the future outside of CoCo VMs, or
> > perhaps on the IOMMU path.
>=20
> I once introduced a similar flag and called it MAY_SLEEP. I chose
> MAY_SLEEP, because there is already a might_sleep() annotation, but I
> don't have a strong opinion unless your semantics is supposed to be
> different from might_sleep(). If it is, then I strongly prefer
> MAY_BLOCK to prevent confusing the two.

My intent is that the semantics are the same as might_sleep(). I
vacillated between MAY_SLEEP and MAY_BLOCK. The kernel seems
to treat "sleep" and "block" as equivalent, because blk-mq has
the BLK_MQ_F_BLOCKING flag, and SCSI has the=20
queuecommand_may_block flag that is translated to
BLK_MQ_F_BLOCKING. So I settled on MAY_BLOCK, but as you
point out, that's inconsistent with might_sleep(). Either way will
be inconsistent somewhere, and I don't have a preference.

>=20
> > * The swiotlb throttling code in this patch set throttles by
> > serializing the use of swiotlb memory when usage is above a designated
> > threshold: i.e., only one new swiotlb request is allowed to proceed at
> > a time. When the corresponding unmap is done to release its swiotlb
> > memory, the next request is allowed to proceed. This serialization is
> > global and without knowledge of swiotlb areas. From a storage I/O
> > performance standpoint, the serialization is a bit restrictive, but
> > the code isn't trying to optimize for being above the threshold. If a
> > workload regularly runs above the threshold, the size of the swiotlb
> > memory should be increased.
>=20
> With CONFIG_SWIOTLB_DYNAMIC, this could happen automatically in the
> future. But let's get the basic functionality first.
>=20
> > * Except for knowing how much swiotlb memory is currently allocated,
> > throttle accounting is done without locking or atomic operations. For
> > example, multiple requests could proceed in parallel when usage is
> > just under the threshold, putting usage above the threshold by the
> > aggregate size of the parallel requests. The threshold must already be
> > set relatively conservatively because of drivers that can't enable
> > throttling, so this slop in the accounting shouldn't be a problem.
> > It's better than the potential bottleneck of a globally synchronized
> > reservation mechanism.
>=20
> Agreed.
>=20
> > * In a CoCo VM, mapping a scatter/gather list makes an independent
> > swiotlb request for each entry. Throttling each independent request
> > wouldn't really work, so the code throttles only the first SGL entry.
> > Once that entry passes any throttle, subsequent entries in the SGL
> > proceed without throttling. When the SGL is unmapped, entries 1 thru
> > N-1 are unmapped first, then entry 0 is unmapped, allowing the next
> > serialized request to proceed.
> >
> > Open Topics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. swiotlb allocations from Xen and the IOMMU code don't make use of
> > throttling. This could be added if beneficial.
> >
> > 2. The throttling values are currently exposed and adjustable in
> > /sys/kernel/debug/swiotlb. Should any of this be moved so it is
> > visible even without CONFIG_DEBUG_FS?
>=20
> Yes. It should be possible to control the thresholds through sysctl.

Good point.  I was thinking about creating /sys/kernel/swiotlb, but
sysctl is better.

Michael

>=20
> > 3. I have not changed the current heuristic for the swiotlb memory
> > size in CoCo VMs. It's not clear to me how to link this to whether the
> > key storage drivers have been updated to allow throttling. For now,
> > the benefit of reduced swiotlb memory size must be realized using the
> > swiotlb=3D kernel boot line option.
>=20
> This sounds fine for now.
>=20
> > 4. I need to update the swiotlb documentation to describe throttling.
> >
> > This patch set is built against linux-next-20240816.
>=20
> OK, I'm going try it out.
>=20
> Thank you for making this happen!
>=20
> Petr T

