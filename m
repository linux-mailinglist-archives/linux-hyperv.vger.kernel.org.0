Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F254E10B56A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2019 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0SSO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Nov 2019 13:18:14 -0500
Received: from mail-eopbgr790107.outbound.protection.outlook.com ([40.107.79.107]:35936
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfK0SSN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Nov 2019 13:18:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9d1hlQehm4jYyq8NYRpDQhKXiGQGeFwyWbeLhZ88J2upobTOzPLjCMFkrCrLmiYPm8o3rGMiUAvgTu1zhzNZ6vwkUVSSOIf+pO4T92IdSU5t2A2jwOEYrTgM/v5uTAfFA4cRvD22xjZ6YKifCjAGGiY9gq18B16VEqeBvk/OhB/1+q/uVwzWzt14au55D6m3RNQCk9lkfjsHXZGT8RrbZQQlq7a/+7+5Wjz97p8T0eCOm8eD0GK+dsVwtapXMDnPFT0QodM5EOOawp2fMFEoa/Yl9ORqOrWhiOMZTfp86pu/anXKN5Ls+38ERWqU6ixkOLlO9usogoxliXbZlyn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ82oGZkvsuzeyy8JrOoAgoW7LqvlgXKurMEpl44H54=;
 b=b8BIjxHkZlmUEnaKCLzTAwHWOiMeeDhivViJj+vn4icQIaSFONQcGJflC8fzbVylKbJZ+RzNB53VpDyct3RcXJ+fy4t80g1OM6u7Qx0QBn/P/2xxqYJMeUo00j0zM+NaYnuf+swe8y0b5ausuB59BHdqfa4sZrD3Pm8xd+9LerbKvVld3qjgA3fAc8Zs4HD6nbOoZfON2TbQuF5SRudGoYDb+jO8BAizCiyLlgypO0auvcReDyiXR5KCTwkEMtQk5MKzd5Uspm2CgNWchUe4s//2f5JS8BMSSY7QUlJmFWPhXtEtpFCNgfcOyQBXQOkpB+RuyIh1otAisS7o8DAy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ82oGZkvsuzeyy8JrOoAgoW7LqvlgXKurMEpl44H54=;
 b=X3Rx7XqZuTpziChpitr2kEOQ86WFpkuYAVFig3z2tRoOKP3K+lMW9QS1FbqJuuCzIRqzQyZ0wtynMWA8SA9ZAwA1GM9WM/rFXO0bVLcebpNc0e43IQC/S7FlYEME5tfotbBp3meYCGgNwxa8/QCrPlpskLI5t5zAs1RgGvqL7ls=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.4; Wed, 27 Nov 2019 18:14:22 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Wed, 27 Nov 2019
 18:14:22 +0000
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
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Topic: [PATCH v2] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Index: AQHVoQ5PjN4EbiSJUU6r31f3vjqbG6efUlHw
Date:   Wed, 27 Nov 2019 18:14:22 +0000
Message-ID: <CY4PR21MB0629A6D880A94949B98A3725D7440@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <20191122082408.3210-1-weh@microsoft.com>
In-Reply-To: <20191122082408.3210-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-27T18:14:20.7689160Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d63d08d-8989-4e45-9821-76f933e75210;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ec69b60-0fbd-4e86-2166-08d77365a109
x-ms-traffictypediagnostic: CY4PR21MB0149:|CY4PR21MB0149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0149D37AD592B940244C4586D7440@CY4PR21MB0149.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(54094003)(1250700005)(7736002)(110136005)(86362001)(14444005)(2201001)(256004)(71190400001)(3846002)(74316002)(66476007)(66066001)(22452003)(64756008)(66446008)(66556008)(305945005)(71200400001)(2906002)(8676002)(25786009)(6116002)(8990500004)(81166006)(8936002)(76116006)(81156014)(99286004)(52536014)(10290500003)(9686003)(14454004)(498600001)(446003)(11346002)(55016002)(5660300002)(33656002)(1511001)(66946007)(229853002)(2501003)(6246003)(6636002)(26005)(186003)(7416002)(6506007)(10090500001)(7696005)(6436002)(76176011)(102836004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:3;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3ft0+imYvk7HzFAXIJSEjt1ZKqFiooaIjTWlx+v7hMWH7Ps2vv9y9h20Oxl5eP8Rm7g7fk9urI2yvjuzXQXQuiXjhpbd/3IoStHCiAyN41jqzgLHpEXIJDmYrEenBEVfELcSme6lAEyXD2JS+ql7dFYDEARlxLinZdHdVU9Hb44hBJWT+yEQj9xBjHIBFyRBcqIgRhmjG+izszBnuTU3vUxATgbK3tZAIJpgtj9OBJonRWeP5EFFDD9UzT7xHLijG/Zr4jDHEuj/soiaG8Wg0I0ahWJlIwm2MLDcl3agKle9KSn4h/amRtdC+pYKBoKPGDspK9jO+7HrN50twn4eHcqnYWnBuSB+bvDtYB5chn6wapy3jQ9gXrrU9B3JCUMgaY2jzDYo4veXuRruc9ukzIfcKqM8OGWLaHlJfcNVphBit4d9+6Sv/TRNXrbx4lr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec69b60-0fbd-4e86-2166-08d77365a109
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 18:14:22.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwMfejRQP/yCWYPMNaC4zcBDWPvDJjUbrXAQ06j8BN2YjqnSxoPEoLp2Mu9JW33/AI3qjGtZi+IrqlMzZkwAVYxNaE3DPKcCDD8bFliqFZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Friday, November 22, 2019 12:24 AM
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
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporated review comments form hch@lst.de, Michael Kelley and
>     Dexuan Cui
>     - Use dma_alloc_coherent to allocate large contiguous memory
>     - Use phys_addr_t for physical addresses
>     - Corrected a few spelling errors and minor cleanups
>     - Also tested on 32 bit Ubuntu guest
>=20
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 196 +++++++++++++++++++++++++-------
>  2 files changed, 158 insertions(+), 39 deletions(-)
>=20

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
> +	/* Try to call alloc_pages if the size is less than 2^MAX_ORDER */
> +	if (order < MAX_ORDER) {
> +		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		paddr =3D (page_to_pfn(page) << PAGE_SHIFT);
> +		request_pages =3D (1 << order);
> +		goto get_phymem1;
> +	}

Could you use an 'else' clause here and eliminate the above
'goto' statement?  I know that makes the below code be indented
one level deeper, but that doesn't seem particularly problematic
here.  The reason we have 'else' clauses is to avoid 'goto's and
labels.  :-)

> +
> +	/* Allocate from CMA */
> +	if (hdev =3D=3D NULL)
> +		return -1;

The above test seems unnecessary.  A lot of things would have
broken before getting to this function if hdev was NULL.

> +
> +	hdev->device.coherent_dma_mask =3D DMA_BIT_MASK(64);
> +
> +	request_pages =3D (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +
> +	vmem =3D dma_alloc_coherent(&hdev->device,
> +				 request_pages * PAGE_SIZE,
> +				 &dma_handle,
> +				 GFP_KERNEL | __GFP_NOWARN);
> +
> +	if (!vmem)
> +		return -1;
> +
> +	paddr =3D virt_to_phys(vmem);
> +
> +get_phymem1:
> +	pr_info("Allocated %d pages starts at physical addr 0x%llx\n",
> +		request_pages, paddr);

I wonder if we want to show the physical address here.  The Linux kernel
definitely does not show kernel virtual addresses due to security
concerns, and I'm wondering if the same applies to physical addresses.
What's the benefit to showing the physical address?

And in the message "starts" should be "starting".

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
>  /* Get framebuffer memory from Hyper-V video pci space */
>  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
> @@ -947,8 +1028,57 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info
> *info)
>  	void __iomem *fb_virt;
>  	int gen2vm =3D efi_enabled(EFI_BOOT);
>  	resource_size_t pot_start, pot_end;
> +	phys_addr_t paddr;
>  	int ret;
>=20
> +	if (!gen2vm) {
> +		pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	info->apertures =3D alloc_apertures(1);
> +	if (!info->apertures)
> +		goto err1;

There's a small memory leak here.  The apertures are never freed in any
of the error cases in this function, or in hvfb_putmem().  This is not a bu=
g you
introduced -- the original code had the same leak.

> +
> +	if (gen2vm) {
> +		info->apertures->ranges[0].base =3D screen_info.lfb_base;
> +		info->apertures->ranges[0].size =3D screen_info.lfb_size;
> +	} else {
> +		info->apertures->ranges[0].base =3D pci_resource_start(pdev, 0);
> +		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
> +	}
> +
> +	/*
> +	 * For Gen 1 VM, we can directly use the contiguous memory
> +	 * from VM. If we succeed, deferred IO happens directly
> +	 * on this allocated framebuffer memory, avoiding extra
> +	 * memory copy.
> +	 */
> +	if (!gen2vm) {
> +		paddr =3D hvfb_get_phymem(hdev, screen_fb_size);
> +		if (paddr !=3D (phys_addr_t) -1) {
> +			par->mmio_pp =3D paddr;
> +			par->mmio_vp =3D par->dio_vp =3D __va(paddr);
> +
> +			info->fix.smem_start =3D paddr;
> +			info->fix.smem_len =3D screen_fb_size;
> +			info->screen_base =3D par->mmio_vp;
> +			info->screen_size =3D screen_fb_size;
> +
> +			par->need_docopy =3D false;
> +			goto getmem1;

Maybe change the 'getmem1' label to 'done' or something similarly
indicative having successfully completed everything that needs to be
done?

> +		}
> +		pr_info("Unable to allocate enough contiguous physical memory on Gen 1
> VM. Use MMIO instead.\n");

I'd suggest changing the message to say "Using MMIO instead".  This is just=
 an
informative message indicating what the driver is doing.  "Use MMIO instead=
"
sounds like a directive to the user to do something different, like change =
his
kernel configuration, and that's not the intent.

> +	}

In the above code, there are three, almost consecutive, tests of the "gen2v=
m"
variable.  It seems like the apertures could be allocated first, and then t=
he three
tests combined into one test.  Then you have one range of code for Gen 1 an=
d
another range for Gen 2 and fewer lines 'if' statements, 'else' statements,=
 and
curly braces.

> +
> +	/*
> +	 * Cannot use the contiguous physical memory.
> +	 * Allocate mmio space for framebuffer.
> +	 */
>  	dio_fb_size =3D
>  		screen_width * screen_height * screen_depth / 8;
>=20
> @@ -956,13 +1086,6 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info
> *info)
>  		pot_start =3D 0;
>  		pot_end =3D -1;
>  	} else {
> -		pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> -			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -		if (!pdev) {
> -			pr_err("Unable to find PCI Hyper-V video\n");
> -			return -ENODEV;
> -		}
> -
>  		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
>  		    pci_resource_len(pdev, 0) < screen_fb_size) {
>  			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> @@ -991,20 +1114,6 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info
> *info)
>  	if (par->dio_vp =3D=3D NULL)
>  		goto err3;
>=20
> -	info->apertures =3D alloc_apertures(1);
> -	if (!info->apertures)
> -		goto err4;
> -
> -	if (gen2vm) {
> -		info->apertures->ranges[0].base =3D screen_info.lfb_base;
> -		info->apertures->ranges[0].size =3D screen_info.lfb_size;
> -		remove_conflicting_framebuffers(info->apertures,
> -						KBUILD_MODNAME, false);
> -	} else {
> -		info->apertures->ranges[0].base =3D pci_resource_start(pdev, 0);
> -		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
> -	}
> -
>  	/* Physical address of FB device */
>  	par->mmio_pp =3D par->mem->start;
>  	/* Virtual address of FB device */
> @@ -1015,13 +1124,15 @@ static int hvfb_getmem(struct hv_device *hdev, st=
ruct fb_info
> *info)
>  	info->screen_base =3D par->dio_vp;
>  	info->screen_size =3D dio_fb_size;
>=20
> +getmem1:
> +	remove_conflicting_framebuffers(info->apertures,
> +					KBUILD_MODNAME, false);

With your change, remove_conflicting_framebuffers() is called for both
Gen 1 and Gen 2 VMs.  In the old code, it was called only for Gen 2 VMs.
Is this change intentional?  If so, why?  I haven't delved into the details
of what remove_conflicting_framebuffers() does, so my question is=20
more of a double-check rather than my definitely thinking something
is wrong.

> +
>  	if (!gen2vm)
>  		pci_dev_put(pdev);
>=20
>  	return 0;
>=20
> -err4:
> -	vfree(par->dio_vp);
>  err3:
>  	iounmap(fb_virt);
>  err2:
> @@ -1035,13 +1146,19 @@ static int hvfb_getmem(struct hv_device *hdev, st=
ruct fb_info
> *info)
>  }
>=20
>  /* Release the framebuffer */
> -static void hvfb_putmem(struct fb_info *info)
> +static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
>  {
>  	struct hvfb_par *par =3D info->par;
>=20
> -	vfree(par->dio_vp);
> -	iounmap(info->screen_base);
> -	vmbus_free_mmio(par->mem->start, screen_fb_size);
> +	if (par->need_docopy) {
> +		vfree(par->dio_vp);
> +		iounmap(info->screen_base);
> +		vmbus_free_mmio(par->mem->start, screen_fb_size);
> +	} else {
> +		hvfb_release_phymem(hdev, info->fix.smem_start,
> +				    screen_fb_size);
> +	}
> +
>  	par->mem =3D NULL;

There's a small memory leak in the above statement.  The data
structure pointed to by "mem" is not freed.   The same problem
occurs in hvfb_getmem() in the "err2" path.   This bug existed in
the old code as well, so it was not introduced by your changes.

Michael
