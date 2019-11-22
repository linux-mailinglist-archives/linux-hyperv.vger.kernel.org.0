Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE510681D
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2019 09:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKVIY5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Nov 2019 03:24:57 -0500
Received: from mail-eopbgr720116.outbound.protection.outlook.com ([40.107.72.116]:15392
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfKVIYx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Nov 2019 03:24:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwXrUIYaoSpOVKUKkPMe4MUJLJxxMuG8jvWAT9fFoeL17SmLsoesmxR7PAKD5Qb7xflJ3BCkSuD8VMtV09eR1G+qOVnOC8cOHjwqywL+kSD6ZygkCs8bE1nSxd844d91q3riAwljkIjj3GR65yM81IyATr3b9p7AGHHCYdTKin4dJwDr62FEcX34Y/VoWGLWooB5+fh79BfqNnkYfmUvG1ZnXtI9r+uh0CAuS9UY/aqQE0euW+5VPiyr6gHCRRD8Nvg9hDg8Bnwt1v5zSWod3WyQQJHe4NBaoOayHUJypb1Uvt1wj9eGAc9RX/faxZPyO54IZo/H7PT3cM6kbvaX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XkyxbUNFMVr8OLWw+QBvJe5T0Xpw1K97dNA+kLAmHs=;
 b=kDmUl3hAK1iKX7bvNIxaF250LW/rQBOpK+DWAd6qmX9833oDRlQnlZCytt9tdnyntfKdIQ/3Lz66oTM4A0yB4e/VV0+qv0vUzsj0yQKCZF7e82zTRTBPYJ5zcxXediTtJ/HJ9YJDTZua6gk4bQMl7wLIxbwxCvlkpgKZ1NLVr8SqZ44hYppv7Sqm985FB2TNA4QjYjcYGM0wryuXSQ5c7D4PabHNtwYT3/vl/Etmw50tGlm5Ah9cL5hsYCokieiWqkn7AWS0ZSFt8XAbuo4DIU23MDh9EfuBX4RyeBo4jBAzVwcFh4lbt46d6KQmoaB5qh83PUQ7xkHQ2HWkviXuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XkyxbUNFMVr8OLWw+QBvJe5T0Xpw1K97dNA+kLAmHs=;
 b=HY/tE+XhbCawWgh6ZsrYF/AicfNAHzdELR+PFRAFUwCOwhYND+IbLAWGj7SDIHAR98jIqGL7SyhX7LXWcYCtjUjUhA4LUyyvOeWCfeGfe0z+W433qmHc3aVNaAusCymGDJshbUnTBRejVDuADxwWAURpcuP/c5MvrcHsgGwHKAw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
Received: from CH2PR21MB1447.namprd21.prod.outlook.com (20.180.11.151) by
 CH2PR21MB1461.namprd21.prod.outlook.com (20.180.9.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Fri, 22 Nov 2019 08:24:50 +0000
Received: from CH2PR21MB1447.namprd21.prod.outlook.com
 ([fe80::6c54:3203:ae0c:6f4]) by CH2PR21MB1447.namprd21.prod.outlook.com
 ([fe80::6c54:3203:ae0c:6f4%5]) with mapi id 15.20.2495.010; Fri, 22 Nov 2019
 08:24:49 +0000
From:   Wei Hu <weh@microsoft.com>
To:     b.zolnierkie@samsung.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, mchehab+samsung@kernel.org,
        sam@ravnborg.org, gregkh@linuxfoundation.org,
        alexandre.belloni@bootlin.com, info@metux.net, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Date:   Fri, 22 Nov 2019 16:24:08 +0800
Message-Id: <20191122082408.3210-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To CH2PR21MB1447.namprd21.prod.outlook.com
 (2603:10b6:610:8c::23)
MIME-Version: 1.0
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:3:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 22 Nov 2019 08:24:43 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 497ac35a-c01e-416e-c8a2-08d76f2570e8
X-MS-TrafficTypeDiagnostic: CH2PR21MB1461:|CH2PR21MB1461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR21MB14613DCE140FCCDE213E2712BB490@CH2PR21MB1461.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(14444005)(6636002)(2906002)(2870700001)(305945005)(7736002)(6116002)(6666004)(3450700001)(7416002)(22452003)(316002)(1511001)(43066004)(386003)(3846002)(51416003)(7696005)(52116002)(30864003)(48376002)(47776003)(1076003)(6486002)(5660300002)(66066001)(81166006)(50466002)(36756003)(6436002)(25786009)(478600001)(10290500003)(66946007)(8676002)(8936002)(2616005)(50226002)(186003)(86362001)(956004)(81156014)(26005)(66476007)(16526019)(107886003)(4326008)(1250700005)(10090500001)(66556008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR21MB1461;H:CH2PR21MB1447.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5rzk2ChX9QKkvup8ntMttAAoEVJtRH25cC0wfdO0aNhQsZlPiA7iX+ImOJa1W/IHSSwi8SYmwly4+M9LCGPsQbBPOt/vEHJYgBbm8fjA/8s8J44Wmn7n6njOiXkrmtEUxZGJDr5H8P4brtljNTcXXuTSlmEziecLQobJ9D/0QKDigHFHildRmwFh+AVvlRhiNNTXxy+ocDkiYPE+40jimpLX5+4qkL0tbBxruF7RN1jKdrWaAQgimdhVn5kW+r/jJGV/sVJzlG/3yN04SLKKa9O0YW2lBqVsXm641n/XpCbOIYEtcfdMZm+ZnDAIRZHWKWo2WaIZI2RJ5VCvnJGzcx0mxZW0XyydqsRQwVrKt1aSTG1OnrnPceu+6gz6pZZ/WYMYOjSXza94rjkBSzIpXp3dUUr6wj28idimB+wtJ9yWZ7NnpImOX8GXbzpBwF4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ac35a-c01e-416e-c8a2-08d76f2570e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 08:24:49.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98CgGTW24u4eEuFrmF5mrnyetsc9+whRDYTl2zRA04/Fg36v3LvRP7g6sGRFCuY/TznKVeVOqs8F0jalsVaWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1461
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
    cma=130m
This gives 130MB memory to CAM allocator that can be allocated to
framebuffer. If this fails, we fall back to the old way of using
mmio for framebuffer.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2: Incorporated review comments form hch@lst.de, Michael Kelley and
    Dexuan Cui
    - Use dma_alloc_coherent to allocate large contiguous memory
    - Use phys_addr_t for physical addresses
    - Corrected a few spelling errors and minor cleanups
    - Also tested on 32 bit Ubuntu guest 

 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 196 +++++++++++++++++++++++++-------
 2 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..87b82de4598d 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2215,6 +2215,7 @@ config FB_HYPERV
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_DEFERRED_IO
+	select DMA_CMA if HAVE_DMA_CONTIGUOUS
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 3f60b7bc8589..8ba96764c749 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -31,6 +31,16 @@
  * "set-vmvideo" command. For example
  *     set-vmvideo -vmname name -horizontalresolution:1920 \
  * -verticalresolution:1200 -resolutiontype single
+ *
+ * Gen 1 VMs also support direct using VM's physical memory for framebuffer.
+ * It could improve the efficiency and performance for framebuffer and VM.
+ * This requires to allocate contiguous physical memory from Linux kernel's
+ * CMA memory allocator. To enable this, supply a kernel parameter to give
+ * enough memory space to CMA allocator for framebuffer. For example:
+ *    cma=130m
+ * This gives 130MB memory to CMA allocator that can be allocated to
+ * framebuffer. For reference, 8K resolution (7680x4320) takes about
+ * 127MB memory.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -227,7 +237,6 @@ struct synthvid_msg {
 } __packed;
 
 
-
 /* FB driver definitions and structures */
 #define HVFB_WIDTH 1152 /* default screen width */
 #define HVFB_HEIGHT 864 /* default screen height */
@@ -256,12 +265,15 @@ struct hvfb_par {
 	/* If true, the VSC notifies the VSP on every framebuffer change */
 	bool synchronous_fb;
 
+	/* If true, need to copy from deferred IO mem to framebuffer mem */
+	bool need_docopy;
+
 	struct notifier_block hvfb_panic_nb;
 
 	/* Memory for deferred IO and frame buffer itself */
 	unsigned char *dio_vp;
 	unsigned char *mmio_vp;
-	unsigned long mmio_pp;
+	phys_addr_t mmio_pp;
 
 	/* Dirty rectangle, protected by delayed_refresh_lock */
 	int x1, y1, x2, y2;
@@ -432,7 +444,7 @@ static void synthvid_deferred_io(struct fb_info *p,
 		maxy = max_t(int, maxy, y2);
 
 		/* Copy from dio space to mmio address */
-		if (par->fb_ready)
+		if (par->fb_ready && par->need_docopy)
 			hvfb_docopy(par, start, PAGE_SIZE);
 	}
 
@@ -749,12 +761,12 @@ static void hvfb_update_work(struct work_struct *w)
 		return;
 
 	/* Copy the dirty rectangle to frame buffer memory */
-	for (j = y1; j < y2; j++) {
-		hvfb_docopy(par,
-			    j * info->fix.line_length +
-			    (x1 * screen_depth / 8),
-			    (x2 - x1) * screen_depth / 8);
-	}
+	if (par->need_docopy)
+		for (j = y1; j < y2; j++)
+			hvfb_docopy(par,
+				    j * info->fix.line_length +
+				    (x1 * screen_depth / 8),
+				    (x2 - x1) * screen_depth / 8);
 
 	/* Refresh */
 	if (par->fb_ready && par->update)
@@ -799,7 +811,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
 	par = container_of(nb, struct hvfb_par, hvfb_panic_nb);
 	par->synchronous_fb = true;
 	info = par->info;
-	hvfb_docopy(par, 0, dio_fb_size);
+	if (par->need_docopy)
+		hvfb_docopy(par, 0, dio_fb_size);
 	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
 
 	return NOTIFY_DONE;
@@ -938,6 +951,74 @@ static void hvfb_get_option(struct fb_info *info)
 	return;
 }
 
+/*
+ * Allocate enough contiguous physical memory.
+ * Return physical address if succeeded or -1 if failed.
+ */
+static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
+				   unsigned int request_size)
+{
+	struct page *page = NULL;
+	dma_addr_t dma_handle;
+	void *vmem;
+	unsigned int request_pages;
+	phys_addr_t paddr = 0;
+	unsigned int order = get_order(request_size);
+
+	if (request_size == 0)
+		return -1;
+
+	/* Try to call alloc_pages if the size is less than 2^MAX_ORDER */
+	if (order < MAX_ORDER) {
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (!page)
+			return -1;
+
+		paddr = (page_to_pfn(page) << PAGE_SHIFT);
+		request_pages = (1 << order);
+		goto get_phymem1;
+	}
+
+	/* Allocate from CMA */
+	if (hdev == NULL)
+		return -1;
+
+	hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
+
+	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
+
+	vmem = dma_alloc_coherent(&hdev->device,
+				 request_pages * PAGE_SIZE,
+				 &dma_handle,
+				 GFP_KERNEL | __GFP_NOWARN);
+
+	if (!vmem)
+		return -1;
+
+	paddr = virt_to_phys(vmem);
+
+get_phymem1:
+	pr_info("Allocated %d pages starts at physical addr 0x%llx\n",
+		request_pages, paddr);
+
+	return paddr;
+}
+
+/* Release contiguous physical memory */
+static void hvfb_release_phymem(struct hv_device *hdev,
+				phys_addr_t paddr, unsigned int size)
+{
+	unsigned int order = get_order(size);
+
+	if (order < MAX_ORDER)
+		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
+	else
+		dma_free_coherent(&hdev->device,
+				  round_up(size, PAGE_SIZE),
+				  phys_to_virt(paddr),
+				  paddr);
+}
+
 
 /* Get framebuffer memory from Hyper-V video pci space */
 static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
@@ -947,8 +1028,57 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
 	resource_size_t pot_start, pot_end;
+	phys_addr_t paddr;
 	int ret;
 
+	if (!gen2vm) {
+		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
+			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
+		if (!pdev) {
+			pr_err("Unable to find PCI Hyper-V video\n");
+			return -ENODEV;
+		}
+	}
+
+	info->apertures = alloc_apertures(1);
+	if (!info->apertures)
+		goto err1;
+
+	if (gen2vm) {
+		info->apertures->ranges[0].base = screen_info.lfb_base;
+		info->apertures->ranges[0].size = screen_info.lfb_size;
+	} else {
+		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
+		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
+	}
+
+	/*
+	 * For Gen 1 VM, we can directly use the contiguous memory
+	 * from VM. If we succeed, deferred IO happens directly
+	 * on this allocated framebuffer memory, avoiding extra
+	 * memory copy.
+	 */
+	if (!gen2vm) {
+		paddr = hvfb_get_phymem(hdev, screen_fb_size);
+		if (paddr != (phys_addr_t) -1) {
+			par->mmio_pp = paddr;
+			par->mmio_vp = par->dio_vp = __va(paddr);
+
+			info->fix.smem_start = paddr;
+			info->fix.smem_len = screen_fb_size;
+			info->screen_base = par->mmio_vp;
+			info->screen_size = screen_fb_size;
+
+			par->need_docopy = false;
+			goto getmem1;
+		}
+		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Use MMIO instead.\n");
+	}
+
+	/*
+	 * Cannot use the contiguous physical memory.
+	 * Allocate mmio space for framebuffer.
+	 */
 	dio_fb_size =
 		screen_width * screen_height * screen_depth / 8;
 
@@ -956,13 +1086,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 		pot_start = 0;
 		pot_end = -1;
 	} else {
-		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-		if (!pdev) {
-			pr_err("Unable to find PCI Hyper-V video\n");
-			return -ENODEV;
-		}
-
 		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
 		    pci_resource_len(pdev, 0) < screen_fb_size) {
 			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
@@ -991,20 +1114,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	if (par->dio_vp == NULL)
 		goto err3;
 
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures)
-		goto err4;
-
-	if (gen2vm) {
-		info->apertures->ranges[0].base = screen_info.lfb_base;
-		info->apertures->ranges[0].size = screen_info.lfb_size;
-		remove_conflicting_framebuffers(info->apertures,
-						KBUILD_MODNAME, false);
-	} else {
-		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
-		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
-	}
-
 	/* Physical address of FB device */
 	par->mmio_pp = par->mem->start;
 	/* Virtual address of FB device */
@@ -1015,13 +1124,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_base = par->dio_vp;
 	info->screen_size = dio_fb_size;
 
+getmem1:
+	remove_conflicting_framebuffers(info->apertures,
+					KBUILD_MODNAME, false);
+
 	if (!gen2vm)
 		pci_dev_put(pdev);
 
 	return 0;
 
-err4:
-	vfree(par->dio_vp);
 err3:
 	iounmap(fb_virt);
 err2:
@@ -1035,13 +1146,19 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 }
 
 /* Release the framebuffer */
-static void hvfb_putmem(struct fb_info *info)
+static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
-	vfree(par->dio_vp);
-	iounmap(info->screen_base);
-	vmbus_free_mmio(par->mem->start, screen_fb_size);
+	if (par->need_docopy) {
+		vfree(par->dio_vp);
+		iounmap(info->screen_base);
+		vmbus_free_mmio(par->mem->start, screen_fb_size);
+	} else {
+		hvfb_release_phymem(hdev, info->fix.smem_start,
+				    screen_fb_size);
+	}
+
 	par->mem = NULL;
 }
 
@@ -1060,6 +1177,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	par = info->par;
 	par->info = info;
 	par->fb_ready = false;
+	par->need_docopy = true;
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
 
@@ -1145,7 +1263,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1175,7 +1293,7 @@ static int hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.20.1

