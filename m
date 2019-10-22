Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAFE0285
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2019 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfJVLKo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Oct 2019 07:10:44 -0400
Received: from mail-eopbgr770131.outbound.protection.outlook.com ([40.107.77.131]:17378
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730450AbfJVLKo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Oct 2019 07:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktT+vw7f8VHyM1wxkVdy2M7xtKVcM+YfZraDChaCxEkyVug9hrOd+oRPAKfkvENAXpXmoRR5D1SkAqDfRxQghFE0FwBdL5TyG465lv/ccGYsdcXf/AQH1R/enqRwQJXRJ1qXOKdJUmRDyLr/am0po051M4wQA+5WqJNtpg4JuCVQ3trQjRKto+W/qJ8z9++ZpUUFUui62WujwXnTyiKMHYtfWqlgWmA53wOz8sR7n8e/pVNaWcW3/vfRq725279/Sufg7c4x5dYrys3I5kopvhZZDlbYNFLVidcKNGVyRcuiACp4sGClyYz4ukVLU13lWl5y68AnXjaOJl6gjHRO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHSUGl34pj1HHUokjc4arZOyEuhujugHBngBTztkMeI=;
 b=L2EtojoccouRpDp0Cx1acJwhD/YGlWafbGXd1jT7guZXGI6uI05uCMmk5et6b7eIpgRdPPalH65R4hUvXhciqmseDxCHakWGXvKCQZ3nWw7iTdxTcg+Osy16C53LpN7sX3Kpuj0NAdftSBy1ED7AAbRPEknU4/yY72+4NZ00VyXezx3fy4+wQUZ092dMcRW2o0xHMuynNQZuBaMtUHqSwetpQvBi2knp7ctZtahbSz03vysGv1ZXMWY+CnwkjN59S4o0pCWwzDoLXcO5hg0UAwDCZ97lg5yaMAGouE/ouniU63OD1XGDVWOy5iTEI6PVUAoFncGUNE/lhcvIyoOGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHSUGl34pj1HHUokjc4arZOyEuhujugHBngBTztkMeI=;
 b=E3qoSZTrypLrZRvMcCYGGsj3RF8BHYKP38mpJR+6Dt2/30cC9DvYCQjxKX94+raRln+ldyfwgvFe8zT/mbjNvzflkCeUfzgVJrXq60umdiy3tNq/+lLIbgbQX6ahglEmCRDao0x0jA2n8PwPsVH/IxaAN10QC37atyEx1RMKdtw=
Received: from DM6PR21MB1401.namprd21.prod.outlook.com (10.255.109.88) by
 DM6PR21MB1259.namprd21.prod.outlook.com (20.179.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 11:10:39 +0000
Received: from DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::f1f4:d235:9586:d22b]) by DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::f1f4:d235:9586:d22b%2]) with mapi id 15.20.2387.019; Tue, 22 Oct 2019
 11:10:39 +0000
From:   Wei Hu <weh@microsoft.com>
To:     "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dcui@microsoft.com" <dcui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>
Subject: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
 HyperV Gen 1 VMs.
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
 HyperV Gen 1 VMs.
Thread-Index: AQHViMlWrXYtpApox02C+wFzOSr7Mg==
Date:   Tue, 22 Oct 2019 11:10:39 +0000
Message-ID: <20191022110905.4032-1-weh@microsoft.com>
Reply-To: Wei Hu <weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0130.apcprd04.prod.outlook.com
 (2603:1096:3:16::14) To DM6PR21MB1401.namprd21.prod.outlook.com
 (2603:10b6:5:22d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [167.220.255.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a1af491-9518-4244-7875-08d756e078c8
x-ms-traffictypediagnostic: DM6PR21MB1259:|DM6PR21MB1259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB12599C11A66D7F3BF1734BD4BB680@DM6PR21MB1259.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(81166006)(81156014)(4326008)(102836004)(66066001)(386003)(478600001)(6506007)(5660300002)(10290500003)(8676002)(25786009)(26005)(1511001)(86362001)(52116002)(50226002)(1250700005)(186003)(14454004)(2906002)(486006)(66946007)(66476007)(66556008)(64756008)(66446008)(2616005)(6512007)(2501003)(3450700001)(476003)(10090500001)(3846002)(71200400001)(6116002)(7736002)(6436002)(43066004)(305945005)(36756003)(1076003)(6486002)(71190400001)(22452003)(316002)(8936002)(107886003)(110136005)(6636002)(7416002)(2201001)(256004)(99286004)(14444005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1259;H:DM6PR21MB1401.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQU+7VaUvGj1mqm91W0omWbc87ppLVYaJwOdYTLlr5kFwcP200ZLc6a3+p+7vj7CwE3t+WnjpXGUpvRozZlAEeVDKNZsMYus4WFJ/d3XD04y03WQzxstUt4x1B9qzs4p+MWgmYzCRJnsA2JzU8PHMcLmPgR115fgiQsx0Cr42iweTeBoJF+SisF1Sg+Lqu4lwMT4Omor3UCONal9q6xfiwHDptBLpQa83iXWI/oEoVEGGd2mRcfufzNPYMUxj0N9DenxQYRDX49Y3nlZKy2o0DYO5FNA525kXJe0C8h6ogKz5xR0MWzD67AQQky182j4w6mONQ7f8S/EnZwNT4iDUpTpuRuVBkYPy/9IC/5Vk/4v8cftFuvTxtfXby8rdH8J1mleZloj7tc4+EJy6dgo8TawTlVv3XEkHwv7NxePf7T0RhxO46y6+l9h4/0JzYWQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1af491-9518-4244-7875-08d756e078c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 11:10:39.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ra9Ep++yvm7iQqxw4kL7JFE6dMDwH0cJJxogZMyhTOwMlD+Fkt0EgPUcXBX5L7w4lmgOAG51qoZMhAzmi/+RIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Hyper-V, Generation 1 VMs can directly use VM's physical memory for
their framebuffers. This can improve the efficiency of framebuffer and
overall performence for VM. The physical memory assigned to framebuffer
must be contiguous. We use CMA allocator to get contiguouse physicial
memory when the framebuffer size is greater than 4MB. For size under
4MB, we use alloc_pages to achieve this.

To enable framebuffer memory allocation from CMA, supply a kernel
parameter to give enough space to CMA allocator at boot time. For
example:
    cma=3D130m
This gives 130MB memory to CAM allocator that can be allocated to
framebuffer. If this fails, we fall back to the old way of using
mmio for framebuffer.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 179 +++++++++++++++++++++++++-------
 kernel/dma/contiguous.c         |   2 +
 3 files changed, 147 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..f534059461ee 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2215,6 +2215,7 @@ config FB_HYPERV
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_DEFERRED_IO
+	select DMA_CMA
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
=20
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 3f60b7bc8589..ea2fd3481225 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -31,6 +31,16 @@
  * "set-vmvideo" command. For example
  *     set-vmvideo -vmname name -horizontalresolution:1920 \
  * -verticalresolution:1200 -resolutiontype single
+ *
+ * Gen 1 VMs also support directly using VM's phyiscal memory for framebuf=
fer.
+ * It could improve the efficiency and performance for framebuffer and VM.
+ * This requires to allocate contiguous physical memory from Linux kernel'=
s
+ * CMA memory allocator. To enable this, supply a kernel parameter to give
+ * enough memory space to CMA allocator for framebuffer. For example:
+ *    cma=3D130m
+ * This gives 130MB memory to CMA allocator that can be allocated to
+ * framebuffer. For reference, 8K resolution (7680x4320) takes about
+ * 127MB memory.
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -42,6 +52,7 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/efi.h>
+#include <linux/dma-contiguous.h>
=20
 #include <linux/hyperv.h>
=20
@@ -227,7 +238,6 @@ struct synthvid_msg {
 } __packed;
=20
=20
-
 /* FB driver definitions and structures */
 #define HVFB_WIDTH 1152 /* default screen width */
 #define HVFB_HEIGHT 864 /* default screen height */
@@ -256,6 +266,9 @@ struct hvfb_par {
 	/* If true, the VSC notifies the VSP on every framebuffer change */
 	bool synchronous_fb;
=20
+	/* If true, need to copy from deferred IO mem to framebuffer mem */
+	bool need_docopy;
+
 	struct notifier_block hvfb_panic_nb;
=20
 	/* Memory for deferred IO and frame buffer itself */
@@ -432,7 +445,7 @@ static void synthvid_deferred_io(struct fb_info *p,
 		maxy =3D max_t(int, maxy, y2);
=20
 		/* Copy from dio space to mmio address */
-		if (par->fb_ready)
+		if (par->fb_ready && par->need_docopy)
 			hvfb_docopy(par, start, PAGE_SIZE);
 	}
=20
@@ -749,12 +762,12 @@ static void hvfb_update_work(struct work_struct *w)
 		return;
=20
 	/* Copy the dirty rectangle to frame buffer memory */
-	for (j =3D y1; j < y2; j++) {
-		hvfb_docopy(par,
-			    j * info->fix.line_length +
-			    (x1 * screen_depth / 8),
-			    (x2 - x1) * screen_depth / 8);
-	}
+	if (par->need_docopy)
+		for (j =3D y1; j < y2; j++)
+			hvfb_docopy(par,
+				    j * info->fix.line_length +
+				    (x1 * screen_depth / 8),
+				    (x2 - x1) * screen_depth / 8);
=20
 	/* Refresh */
 	if (par->fb_ready && par->update)
@@ -799,7 +812,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
 	par =3D container_of(nb, struct hvfb_par, hvfb_panic_nb);
 	par->synchronous_fb =3D true;
 	info =3D par->info;
-	hvfb_docopy(par, 0, dio_fb_size);
+	if (par->need_docopy)
+		hvfb_docopy(par, 0, dio_fb_size);
 	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
=20
 	return NOTIFY_DONE;
@@ -938,6 +952,62 @@ static void hvfb_get_option(struct fb_info *info)
 	return;
 }
=20
+/*
+ * Allocate enough contiguous physical memory.
+ * Return physical address if succeeded or -1 if failed.
+ */
+static unsigned long hvfb_get_phymem(unsigned int request_size)
+{
+	struct page *page =3D NULL;
+	unsigned int request_pages;
+	unsigned long paddr =3D 0;
+	unsigned int order =3D get_order(request_size);
+
+	if (request_size =3D=3D 0)
+		return -1;
+
+	/* Try call alloc_pages if the size is less than 2^MAX_ORDER */
+	if (order < MAX_ORDER) {
+		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (!page)
+			return -1;
+
+		request_pages =3D (1 << order);
+		goto get_phymem1;
+	}
+
+	/* Allocate from CMA */
+	// request_pages =3D (request_size >> PAGE_SHIFT) + 1;
+	request_pages =3D (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
+	page =3D dma_alloc_from_contiguous(NULL, request_pages, 0, false);
+
+	if (page =3D=3D NULL)
+		return -1;
+
+get_phymem1:
+	paddr =3D (page_to_pfn(page) << PAGE_SHIFT);
+
+	pr_info("Allocated %d pages starts at physical addr 0x%lx\n",
+		request_pages, paddr);
+
+	return paddr;
+}
+
+/* Release contiguous physical memory */
+static void hvfb_release_phymem(unsigned long paddr, unsigned int size)
+{
+	unsigned int order =3D get_order(size);
+
+	if (order < MAX_ORDER)
+		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
+	else
+		dma_release_from_contiguous(NULL,
+					    pfn_to_page(paddr >> PAGE_SHIFT),
+					    (round_up(size, PAGE_SIZE) >>
+					     PAGE_SHIFT));
+					    // (size >> PAGE_SHIFT) + 1);
+}
+
=20
 /* Get framebuffer memory from Hyper-V video pci space */
 static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
@@ -947,8 +1017,58 @@ static int hvfb_getmem(struct hv_device *hdev, struct=
 fb_info *info)
 	void __iomem *fb_virt;
 	int gen2vm =3D efi_enabled(EFI_BOOT);
 	resource_size_t pot_start, pot_end;
+	unsigned long paddr;
 	int ret;
=20
+	if (!gen2vm) {
+		pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
+			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
+		if (!pdev) {
+			pr_err("Unable to find PCI Hyper-V video\n");
+			return -ENODEV;
+		}
+	}
+
+	info->apertures =3D alloc_apertures(1);
+	if (!info->apertures)
+		goto err1;
+
+	if (gen2vm) {
+		info->apertures->ranges[0].base =3D screen_info.lfb_base;
+		info->apertures->ranges[0].size =3D screen_info.lfb_size;
+	} else {
+		info->apertures->ranges[0].base =3D pci_resource_start(pdev, 0);
+		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
+	}
+
+	/*
+	 * For Gen 1 VM, we can directly use the contiguous memory
+	 * from VM. If we success, deferred IO happens directly
+	 * on this allocated framebuffer memory, avoiding extra
+	 * memory copy.
+	 */
+	if (!gen2vm) {
+		paddr =3D hvfb_get_phymem(screen_fb_size);
+		if (paddr !=3D (unsigned long) -1) {
+			par->mmio_pp =3D paddr;
+			par->mmio_vp =3D par->dio_vp =3D __va(paddr);
+
+			info->fix.smem_start =3D paddr;
+			info->fix.smem_len =3D screen_fb_size;
+			info->screen_base =3D par->mmio_vp;
+			info->screen_size =3D screen_fb_size;
+
+			par->need_docopy =3D false;
+			goto getmem1;
+		} else {
+			pr_info("Unable to allocate enough contiguous physical memory on Gen 1 =
VM. Use MMIO instead.\n");
+		}
+	}
+
+	/*
+	 * Cannot use the contiguous physical memory.
+	 * Allocate mmio space for framebuffer.
+	 */
 	dio_fb_size =3D
 		screen_width * screen_height * screen_depth / 8;
=20
@@ -956,13 +1076,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct=
 fb_info *info)
 		pot_start =3D 0;
 		pot_end =3D -1;
 	} else {
-		pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-		if (!pdev) {
-			pr_err("Unable to find PCI Hyper-V video\n");
-			return -ENODEV;
-		}
-
 		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
 		    pci_resource_len(pdev, 0) < screen_fb_size) {
 			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
@@ -991,20 +1104,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct=
 fb_info *info)
 	if (par->dio_vp =3D=3D NULL)
 		goto err3;
=20
-	info->apertures =3D alloc_apertures(1);
-	if (!info->apertures)
-		goto err4;
-
-	if (gen2vm) {
-		info->apertures->ranges[0].base =3D screen_info.lfb_base;
-		info->apertures->ranges[0].size =3D screen_info.lfb_size;
-		remove_conflicting_framebuffers(info->apertures,
-						KBUILD_MODNAME, false);
-	} else {
-		info->apertures->ranges[0].base =3D pci_resource_start(pdev, 0);
-		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
-	}
-
 	/* Physical address of FB device */
 	par->mmio_pp =3D par->mem->start;
 	/* Virtual address of FB device */
@@ -1015,13 +1114,17 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info *info)
 	info->screen_base =3D par->dio_vp;
 	info->screen_size =3D dio_fb_size;
=20
+	par->need_docopy =3D true;
+
+getmem1:
+	remove_conflicting_framebuffers(info->apertures,
+					KBUILD_MODNAME, false);
+
 	if (!gen2vm)
 		pci_dev_put(pdev);
=20
 	return 0;
=20
-err4:
-	vfree(par->dio_vp);
 err3:
 	iounmap(fb_virt);
 err2:
@@ -1039,9 +1142,14 @@ static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par =3D info->par;
=20
-	vfree(par->dio_vp);
-	iounmap(info->screen_base);
-	vmbus_free_mmio(par->mem->start, screen_fb_size);
+	if (par->need_docopy) {
+		vfree(par->dio_vp);
+		iounmap(info->screen_base);
+		vmbus_free_mmio(par->mem->start, screen_fb_size);
+	} else {
+		hvfb_release_phymem(info->fix.smem_start, screen_fb_size);
+	}
+
 	par->mem =3D NULL;
 }
=20
@@ -1060,6 +1168,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	par =3D info->par;
 	par->info =3D info;
 	par->fb_ready =3D false;
+	par->need_docopy =3D false;
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
=20
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..4553f4cca80e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *d=
ev, size_t count,
=20
 	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
+EXPORT_SYMBOL(dma_alloc_from_contiguous);
=20
 /**
  * dma_release_from_contiguous() - release allocated pages
@@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, st=
ruct page *pages,
 {
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
+EXPORT_SYMBOL(dma_release_from_contiguous);
=20
 /**
  * dma_alloc_contiguous() - allocate contiguous pages
--=20
2.20.1

