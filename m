Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D24115D7D
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2019 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLGQ2f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Dec 2019 11:28:35 -0500
Received: from mail-eopbgr760112.outbound.protection.outlook.com ([40.107.76.112]:31149
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbfLGQ2f (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Dec 2019 11:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2eaV/dIXNq2Jt78SxRzb5cQ1jIhEmirTZ57xzsOj3ZvflXBRU3PtY394aTUIJ+LCvhVEU2nOkAWfqU61dj+3HaqXXZ8SxqBNaUEIPF7VHPhStz7CCDh7ZMTYMpNe6Lby/qz4iHSynKWxXHnVO130kMowPUEgbKvEuxvDmPd4oq7e9s94Xv8zH47AeTZCkTlS69SfQtHTKWjXcpwBbAqWz+5h89VtfK44HMrSMhXRR7CvXVDJBIXpcSi/j5uVclp1v1CM52bIi/NuTXpUBkjVCsYMM7hnbSNNxgr1HsaQ7mO28MO0elu7Emtj3nd+J9VCkc5Jn029EH11VwsNdhBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDU1HHm83zVOITBPaC2iqmu/hy2Td4uNl0fWfJaBY28=;
 b=BBPT9f9ck6Gxd+rV2yHR7kVUVfW0HKVlbOCS3i/MTDQ45Vxx3fYCV3SLC/sO9sc0inftS47Ps1EbF8lCG7keMUtg9KoZNVHroTbGCNRO1s8mbdktZKmHRh58+ggzTjj3dQNBilZr8cqFhABFI8oeCm22JkN3PrurwUVaVM96fPE5TDO4KAPAC7oFrMAB6btJsJlQ3V/NXs0sbPHNwCynx4SBxl2ezt8pr4UI5beVZRqRO51n8M34F2mJe1tnzNQnWJitObMioLcAQzDl2BCZZ/RuLH6kR+NrCMUj0cbJjBZJlxfFjF3unJ5xOo2I6cgGkdwELVotT+t5xdgYyUM1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDU1HHm83zVOITBPaC2iqmu/hy2Td4uNl0fWfJaBY28=;
 b=OxQPxA9brOxD7qpl3/ibBaDFP97rGQn7jKH5YFYlKZjX/0ak4ow3vfWxLt45TFfoPYpg92aRj2kgyGsLQHk7ViSS5W+dZx9RJSkApBP8ZGq9LDp3pkYZ8wnXXpspw6fukIonVmP6P6kHoMM6Fj7gmpgfwpVMhl+3e5EdswZMZd4=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0152.namprd21.prod.outlook.com (10.173.189.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.1; Sat, 7 Dec 2019 16:28:28 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Sat, 7 Dec 2019
 16:28:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     kbuild test robot <lkp@intel.com>
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Topic: [PATCH v3] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Index: AQHVrCj6DBOdT46Ti02yKFHky2sSFKeu2nXg
Date:   Sat, 7 Dec 2019 16:28:28 +0000
Message-ID: <CY4PR21MB0629C3DA1201A3FB51A7F486D75E0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <20191206113220.1849-1-weh@microsoft.com>
In-Reply-To: <20191206113220.1849-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-07T16:28:26.6621293Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0161c020-b57f-47ae-89d9-4ca338008b7a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b53482a8-21e6-42fc-22fe-08d77b327e07
x-ms-traffictypediagnostic: CY4PR21MB0152:|CY4PR21MB0152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB015299340C8D27D5DCBC9D9DD75E0@CY4PR21MB0152.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0244637DEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(6636002)(186003)(71200400001)(5660300002)(10090500001)(6506007)(66476007)(66556008)(9686003)(64756008)(110136005)(71190400001)(316002)(52536014)(86362001)(26005)(74316002)(10290500003)(8990500004)(2906002)(7416002)(8936002)(102836004)(229853002)(7696005)(33656002)(8676002)(1250700005)(66946007)(99286004)(4326008)(81156014)(55016002)(76176011)(478600001)(81166006)(66446008)(76116006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0152;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5gHl9OrTfyDJ+7d5eD9EaVMrFBA/J4mZCYjR9oia5/XLUWR5YXA3kcMO46PZK4soqj70FGxwsDgqxTDz0T2DqqqIkRVlgdSv4bOmEqmojE8cfBgIJAQV24aNypLXbMBlN5+loy4TSK64EEdOh8WuUK7V3LZnjdnf8lUNDFZFQXLisQTNVZG+FazgXr8SVBtwqgIw1TqaRF5Mi7PiXrP3aDwUDGGJfv55bhqyhGWGZeaGRfelFhWviOGwGYJxR0WJfohK5RDuXOAWpLaokyjFB5LgGixOCBkwQQEoz3ZFdUbWlX6cbykAwq0DAl6oiZBkvbKLnrksyit9aTQ4lgiGX9hCGUnLJq2W4rBaKClIHt0ca7VVwjZzlDNmsw+cENjSoOqXNShA8yu8oa19tbncU+pM4HBuz1Tn6uFVFvcOLOl/0x93ksHH2uCCd7iolpR9016VytMLFswFPLYwZtOOkERMO/sfp2F9k5vP3luwManJZ2tDiYmur96XYTJ7xUs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53482a8-21e6-42fc-22fe-08d77b327e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2019 16:28:28.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCs/WruEtQ+V+D/dnhQHW3EpsD5tjUOuu41ySIYNz10nMtx8cSFSayGB4u0v4lrgGRGAHAhedb0HcAK5CHqxoqEoPDF2IrVSY1i9xctRZqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0152
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Friday, December 6, 2019 3:32 AM
>=20
> On Hyper-V, Generation 1 VMs can directly use VM's physical memory for
> their framebuffers. This can improve the efficiency of framebuffer and
> overall performence for VM. The physical memory assigned to framebuffer
> must be contiguous. We use CMA allocator to get contiguouse physicial
> memory when the framebuffer size is greater than 4MB. For size under
> 4MB, we use alloc_pages to achieve this.
>=20
> To enable framebuffer memory allocation from CMA, supply a kernel
> parameter to give enough space to CMA allocator at boot time. For
> example:
>     cma=3D130m
> This gives 130MB memory to CAM allocator that can be allocated to
> framebuffer. If this fails, we fall back to the old way of using
> mmio for framebuffer.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

[snip]

> +/*
> + * Allocate enough contiguous physical memory.
> + * Return physical address if succeeded or -1 if failed.
> + */
> +static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
> +				   unsigned int request_size)
> +{
> +	struct page *page =3D NULL;
> +	dma_addr_t dma_handle;
> +	void *vmem;
> +	unsigned int request_pages;
> +	phys_addr_t paddr =3D 0;
> +	unsigned int order =3D get_order(request_size);
> +
> +	if (request_size =3D=3D 0)
> +		return -1;
> +
> +	if (order < MAX_ORDER) {
> +		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
> +		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		paddr =3D (page_to_pfn(page) << PAGE_SHIFT);
> +		request_pages =3D (1 << order);

The above line is no longer needed.  request_pages was previously an
argument to a pr_info() statement, but that statement has appropriately
been removed.

> +	} else {
> +		/* Allocate from CMA */
> +		hdev->device.coherent_dma_mask =3D DMA_BIT_MASK(64);
> +
> +		request_pages =3D (round_up(request_size, PAGE_SIZE) >>
> +				 PAGE_SHIFT);
> +
> +		vmem =3D dma_alloc_coherent(&hdev->device,
> +					  request_pages * PAGE_SIZE,
> +					  &dma_handle,
> +					  GFP_KERNEL | __GFP_NOWARN);

With the request_pages value no longer being needed, there's wasted motion
in doing a PAGE_SHIFT shift to calculate request_pages, and then multiplyin=
g by
PAGE_SIZE.  The second argument above could just be
round_up(request_size, PAGE_SIZE).   Then it would be exactly parallel to
the second argument to dma_free_coherent() below in hvfb_release_phymem().
The request_pages variable can be eliminated entirely.

> +
> +		if (!vmem)
> +			return -1;
> +
> +		paddr =3D virt_to_phys(vmem);
> +	}
> +
> +	return paddr;
> +}
> +
> +/* Release contiguous physical memory */
> +static void hvfb_release_phymem(struct hv_device *hdev,
> +				phys_addr_t paddr, unsigned int size)
> +{
> +	unsigned int order =3D get_order(size);
> +
> +	if (order < MAX_ORDER)
> +		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
> +	else
> +		dma_free_coherent(&hdev->device,
> +				  round_up(size, PAGE_SIZE),
> +				  phys_to_virt(paddr),
> +				  paddr);
> +}
> +
>=20

Everything else looks good.  The most recent changes to hvfb_getmem() worke=
d
out very nicely.

Michael

