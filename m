Return-Path: <linux-hyperv+bounces-2828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D108895D7ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5671F22D0C
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB61C6F77;
	Fri, 23 Aug 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lXsGzNMi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011037.outbound.protection.outlook.com [52.103.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99A1957E4;
	Fri, 23 Aug 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445747; cv=fail; b=sE6DdC5gFQUUL2qB/GLkA1/C+WUmBflowPBMv4Qnqn7TfyWzGvqn3t+vxN2m5+8tWXsbFHFlpcZZu9zvmMm9VeBVQuGor4HE6nRG9aw271w5+t/GW71Ly6T7GDO0eGSL/sFFhRWCKYWhf4Z+ZuasMOm7UErDwWX00dwYM125jc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445747; c=relaxed/simple;
	bh=NRWP+t9ThFWW/HJSLEc9xMiNTytDWdQnalcUM6z/Hes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyhioT8O0FD3rMUhsWlhRCs+4En4tfUV/6Q0p1luuMI63LAP4SIG/w0kYIxgpU30D3GCNeNld7/KZKzRKiltY8oM8GPi4XxdmLlRPR3VBu9zr06wEymKgfXSdG2nWH0wknUk5c7YR+mmoS2JRwMfodQSOG8X+1rZ95Pq/tsbhu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lXsGzNMi; arc=fail smtp.client-ip=52.103.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urbIaEoPCihOwYFEcMqzSfEynmml3WvVyFnf+pqGAC5SRn7tlutAZcBOInj1eE/k6YHFkO3d6Ujog/i0jMgz7K1HSzb1iQ0DHH5JjvLLvnGee6M8Imp/2bZuNHEpnt+RfWKCwfXB/fkxzvWDq3OYxIQk5oCK6RK5MD9r5WNwTgfw59YpWlX3XvM2UdzFWJk9jjKF26QqNaHqaLQcYw1MlIqNm8D+14JTamGqdybzrOUvhkEfdXBYpuUa0NJAbJIQ4ZRD3PEhK95Bu2wyyKBeEY7btZq5DiruCdvvP0eJqdFeQBbokzFrzstQynzv1uqiEnv9xwlZfVFjU6pCkhVtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFIX6pB3w/4OGDJNh/1Z6sD/CVs4htzkBA0YRKpRTZE=;
 b=dfx1CBTRIKsH4oFyJsNzCItZW8yBE+/TjwQw46Kp4wp4FsauddBHnyV4NdGlutx536BRPyGlL9uAChcnYA8QRUzuBkLzoisoDNWEgrPE5IUsVEZYt+QfxYTQyg0NyI341WrzeaS2DYe64NP5K7YteIUyWU6oeu7F85XSLQGIbLJt7v7+a32ewCb9ZPdlT/P2cglDEebV1VIh0PaoCn+jgDwcOqGelYyllHXCgQmIwNF3tSNkKIacB3o2P0CY+TgPQVBeVFSPVG6GOPrCenQU8DXTLCcI7/O5wmLvK2dFG5ldwO4bwfXZq2y05G3H3k1yBnipdSvuK5VxyrkrjUefQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFIX6pB3w/4OGDJNh/1Z6sD/CVs4htzkBA0YRKpRTZE=;
 b=lXsGzNMir3oewPYiuPgAOzSGILrUpHXPMLF5KQzVoqdPKvYkXaLJgrBbGI24ZtK2SH2SnB5/2b6rNxP5dlf8u0o3xTf8y01g1c0ySha2fOsQ2WIF08dYDOyJqt8DBXkmSI4bE7cRsbnDQtu9X6hG5F8i5Ky/OV1Q6gJhp9ratlndPp6k29HSldeCI+6S3DPhOZo7jr/PVG4bsfZrhdUhAC81dy57LorRGYVzvXQHWnKQgOazANVIGwi+pUhwZFwADIEOHBL/655MgJGjL3YPz1PzceCQSpskVDg0CAn1GA45R6qiP19YVe12sUmMlCtvnNwSXWy82jctUb4hg5njhw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6962.namprd02.prod.outlook.com (2603:10b6:a03:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Fri, 23 Aug
 2024 20:42:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 20:42:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
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
Subject: RE: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Thread-Topic: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Thread-Index: AQHa9MKd0/ezVkaXP0KX0eR0wB+/l7I0gPeAgAC/ZdA=
Date: Fri, 23 Aug 2024 20:42:20 +0000
Message-ID:
 <SN6PR02MB4157992C946E098413EA5D62D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-6-mhklinux@outlook.com>
 <20240823101959.1dfe251e@meshulam.tesarici.cz>
In-Reply-To: <20240823101959.1dfe251e@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fBKLKD3DKrg8us6rbyjEnIK/hdETv60G]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6962:EE_
x-ms-office365-filtering-correlation-id: 5280e0d8-7987-4b27-1de4-08dcc3b415c2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 w9ZUV0jErhZRbd9CmF0VycLimMRkjE7j8HOtKphYkYB0/UHk93jOREyeKdPy8cyYj/nB8VPKARRdNu2s3ijiw09UbMhgNVZUz2MU7yhBpqY9oFAIUXKcK+Kv54oaZoQWBYFaM+4Ke2zlRJQISa+xUtE0Mf8Hk1kvU3Vro+iWbTBl4KUSKjqsDLZDfPOTTFIdQfg8mTscqMDADW9CaRh/cU5vdG+aasliHkwemrEKrgyyqvLe9CwAmJN1gtyXV7K0PdCcPpxSTgdAaQjp54MOk6Suavhz+K27lyAb1wwXfG75Dcbj5GPBEjej3lMYh09m/pOBLH0aBthNhixEyoIgEBkZcJQSv3wNEvav+F0zp5QkX4vh9aHgp4xd9DFsxy25BVvPuwU4ZAa0RqvDNEt8Y0nvDhmoNQ9cKJAvg0jqoKZ5vGIkjUj3sbEUTr8Qgj4xixinidCJcWsaGqssLFHEIFA29qZnC0g7sOpVBiQ3CulsAJkWvtBGNb9BhuEIs+mxCC3GrLQ6+pLCVEvgMAfxbkOeS2mUzvTGJoQIpgCQFMn/xCHKHzIhjVAM8i5Im494GZZEChD2hVZfNnvaYWWtElw6bFZQ0xQDw1omwrqSaGTORCO6ihj2TjX50OkEaZQcKS1EhGXcXDJOmEQdHnfXtgm2qsUFGwDsue8vB/kdyAzCFjJI9UpZBdiT5OHliV/2
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?zvUzcD/FjVKF9W+Sp9dZO7C9cB7y88MV1OpWFq/25yDiFu+k9toTYJVuO8?=
 =?iso-8859-2?Q?aTlKxscZaxIRHrmeD5iV5kxaj8BiyP7PiJHlstfF0UDWUcKIYYjZ3NuVGP?=
 =?iso-8859-2?Q?8qM/tuEEwjV3b0pMVG8DzdQD9lKzjHmcD9Yvnkjcm0uNDYmZy9DIZAfb9T?=
 =?iso-8859-2?Q?Qjy1fXi44kG6YaJwawOTU9j0bM88z6YCGatbuLkYCMjkr8XdGHchrMB3yX?=
 =?iso-8859-2?Q?rsXozW2CLVWOnuJi2m1iCES3FKHplKbHTSojQwccBEykj69I+5Hhq6bk+m?=
 =?iso-8859-2?Q?oPTfL/V8XMr4Y80R/8VfLTuyzE8jIs8PA3nd0i1GzuIp3MMYH6nOhyp1bZ?=
 =?iso-8859-2?Q?e7QmwO+r1YEuTpTvYsiLipQv2VrVkOvaOCUQIs7qsGLR2tnDhSmz0u0cbH?=
 =?iso-8859-2?Q?ycSP/KqqOCu7wTn/dlY2RauHBdqB80toM28WA4Nt1UgucDwcURLE47EN7D?=
 =?iso-8859-2?Q?qWMRDomiBaBOvSypWbWlCj53W5/CWBraQIPB8wjbOW7wzBfNswoSWibQh7?=
 =?iso-8859-2?Q?Ra4UcYkJdiIgq9daW8G4CUiZ0PSvZD+FOcOwyvu0o32ydDwenFEb6Ac4bF?=
 =?iso-8859-2?Q?kHnl1UxZWuS8JO38Xw2xxaoMaT3I6bqKWbxlpEhQ3xmsRppcIc3LjWfHCt?=
 =?iso-8859-2?Q?BBZjh1R52QsxO+5XJ0h/v+UlxLob49kVlnhzU/KdHzf/KexUN64mPRyfvz?=
 =?iso-8859-2?Q?5q/kgVkqfxB/RyAitwG8klK+BxjBS77xWtiuVhYCtpUqdRCN+C2M+EaCYx?=
 =?iso-8859-2?Q?6UQxl7z0VxsDxqpbvrlToZU1WUOMSPepe6UaFrf2IEWQX5iCV54ZI3/mkq?=
 =?iso-8859-2?Q?Tb93SpUtJTlqMdNKwxiZEczBKk8eouXlOP87KU/dUWh3zpDilSrqqh8+rs?=
 =?iso-8859-2?Q?W1qmsfcRsz/sqgP+yGcsREGVB07OoUKBk03fGyf7UC3C0EXwL/p6bN9+qi?=
 =?iso-8859-2?Q?6raLVmyT216yVVke3Hy70vuYkyFShP+Jd2mvIV3yK+V5NsbBO5aauQgGlY?=
 =?iso-8859-2?Q?vsXuKdXXR8pK6lDWNJeRGMDVuCgixxfAiF8Bj2+WWp9Pn+3fHn219HBXhL?=
 =?iso-8859-2?Q?alJVMuuZP5DcdbwoInJkuqeMhuG+U0+gAr3mZmCWX5S4fRKcC+Dx+6B1Da?=
 =?iso-8859-2?Q?3aETfB/GOO7YiD1OeURG2f9PjfwxzBfweUmgMMdf65a1tM6RnX0KC6fHXS?=
 =?iso-8859-2?Q?FcM9c0s5LUVio5cz5XMjwiQRcVjy0gUIR6vbtZacJN5e7w/Qvu9BQ9qA07?=
 =?iso-8859-2?Q?HkzIhed780fz2QIVzzU6FgL+IpyIB03S5z1h5LVMM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5280e0d8-7987-4b27-1de4-08dcc3b415c2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 20:42:20.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6962

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, August 23, 2024 1:2=
0 AM
>=20
> On Thu, 22 Aug 2024 11:37:16 -0700
> mhkelley58@gmail.com wrote:
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
> > because DMA cannot be done to private (encrypted) portions of VM
> > memory. The bounce buffer memory is marked shared (decrypted) at
> > boot time, so I/O is done to/from the bounce buffer memory and then
> > copied by the CPU to/from the final target memory (i.e, "bounced").
> > Storage devices can be large consumers of bounce buffer memory because =
it
> > is possible to have large numbers of I/Os in flight across multiple
> > devices. Bounce buffer memory must be pre-allocated at boot time, and
> > it is difficult to know how much memory to allocate to handle peak
> > storage I/O loads. Consequently, bounce buffer memory is typically
> > over-provisioned, which wastes memory, and may still not avoid a peak
> > that exhausts bounce buffer memory and cause storage I/O errors.
> >
> > To solve this problem for Coco VMs running on Hyper-V, update the
> > storvsc driver to permit bounce buffer throttling. First, use
> > scsi_dma_map_attrs() instead of scsi_dma_map(). Then gate the
> > throttling behavior on a DMA layer check indicating that throttling is
> > useful, so that no change occurs in a non-CoCo VM. If throttling is
> > useful, pass the DMA_ATTR_MAY_BLOCK attribute, and set the block queue
> > flag indicating that the I/O request submission path may sleep, which
> > could happen when throttling. With these options in place, DMA map
> > requests are pended when necessary to reduce the likelihood of usage
> > peaks caused by storvsc that could exhaust bounce buffer memory and
> > generate errors.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>=20
> LGTM, but I'm not familiar with this driver or the SCSI layer. In
> particular, I don't know if it's OK to change the value of
> host->queuecommand_may_block after scsi_host_alloc() initialized it
> from a scsi host template, although it seems to be fine.
>=20
> Petr T

Yes, it's OK to change the value after scsi_host_alloc().
The flag isn't consumed until scsi_add_host() is called
later in storvsc_probe().

Note this maps to BLK_MQ_F_BLOCKING, which you can see in
/sys/kernel/debug/block/<device>/hctx0/flags. Same for NVMe
devices with my Patches 6 and 7. When debugging, I've been
checking that /sys entry to make sure the behavior is as expected. :-)

Michael

>=20
> > ---
> >  drivers/scsi/storvsc_drv.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 7ceb982040a5..7bedd5502d07 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -457,6 +457,7 @@ struct hv_host_device {
> >  	struct workqueue_struct *handle_error_wq;
> >  	struct work_struct host_scan_work;
> >  	struct Scsi_Host *host;
> > +	unsigned long dma_attrs;
> >  };
> >
> >  struct storvsc_scan_work {
> > @@ -1810,7 +1811,7 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host,
> struct scsi_cmnd *scmnd)
> >  		payload->range.len =3D length;
> >  		payload->range.offset =3D offset_in_hvpg;
> >
> > -		sg_count =3D scsi_dma_map(scmnd);
> > +		sg_count =3D scsi_dma_map_attrs(scmnd, host_dev->dma_attrs);
> >  		if (sg_count < 0) {
> >  			ret =3D SCSI_MLQUEUE_DEVICE_BUSY;
> >  			goto err_free_payload;
> > @@ -2030,6 +2031,12 @@ static int storvsc_probe(struct hv_device *devic=
e,
> >  	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
> >  	 */
> >  	host->sg_tablesize =3D (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
> > +
> > +	if (dma_recommend_may_block(&device->device)) {
> > +		host->queuecommand_may_block =3D true;
> > +		host_dev->dma_attrs =3D DMA_ATTR_MAY_BLOCK;
> > +	}
> > +
> >  	/*
> >  	 * For non-IDE disks, the host supports multiple channels.
> >  	 * Set the number of HW queues we are supporting.


