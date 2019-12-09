Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4241167D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2019 08:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLIH62 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Dec 2019 02:58:28 -0500
Received: from mail-dm6nam11on2122.outbound.protection.outlook.com ([40.107.223.122]:39873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfLIH62 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Dec 2019 02:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRjxIcvyJRBy+GBf7lRBh+9UfEaY0djRYX9dpzb1UtzbIBCgWAjdd9s72bYVX8jVect4Esyefn8/RAXKAS33jMenzEGeKE8nzmb+rujk3MLMzfZ0O7xULGl9OG0TzsQ8znvStvnaGChhemS7aFaMfy603dQL86hchm1mLC0wKIbEEVEPYpFY8QH11fPUnKNQ/wqrBGq33WLNXe8tdVQkG9E8SiQDAwniJLK2hrZVGZruhfdez3fPv1nlSBhzsjCuYcVrq4I8GUJ85gpRSf6yplPg2vitW9lqdeSGVAqJA2EQxjwT+Bmb8wg3C1tT5dClynem4xTq0GdSYt9Ub6+VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BkJSX1bBr/crL0DNKoOlEz0PTUDpNlHg4lLKcu/MoE=;
 b=Evnjo8PJvTN6xY6OysyPX5wxLA4stlFoBnuJk1sIxLApPLlwz7f2qfZZd+kZE7I+LlkBL3LglIZtRS/Et7eFHmIH1n2E5JYZ0QO9UbGGQCQiWsc2Q7vV+NkFRRKk9NVNnDQpvCvatqgbgHQ7OxnqNYBEVcm9FJFskKAX6pg7jo1dwZ0GGebGfQdWmENK3L8XnRaD21zwRD9czwXmemGMfGS8JBQl1U0vbTGCaUKwPrIr+mgpU6JsiYdpmMRzV0lZB9Fe/zdz6AnKvypXvsKjJZcxIlKU/NsOsd4AFbWW7G9VVwW/LIdX0+j6w/Qzw7K0FuHwZe3p3cNL73/0WSCyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BkJSX1bBr/crL0DNKoOlEz0PTUDpNlHg4lLKcu/MoE=;
 b=JT6q1BrLi74Zd9HE2uGb+9E+ZbuF8KyuOsJk5MOtUPaLja2z4hqXzXi4ks5fzNg8JqDRHPUdMzgeGH0tiaHZrJgPjaGI4yJ0Ctpp5Ou3f1Cx7snZbWQdEJfCyfb0T4a5offVxpeEF2E7d9ZYhcNVTKejA/2hScMNSK09RjONYfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
Received: from BYAPR21MB1285.namprd21.prod.outlook.com (20.179.58.22) by
 BYAPR21MB1208.namprd21.prod.outlook.com (20.179.57.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.6; Mon, 9 Dec 2019 07:58:23 +0000
Received: from BYAPR21MB1285.namprd21.prod.outlook.com
 ([fe80::2937:4548:f0b3:fe32]) by BYAPR21MB1285.namprd21.prod.outlook.com
 ([fe80::2937:4548:f0b3:fe32%10]) with mapi id 15.20.2538.000; Mon, 9 Dec 2019
 07:58:22 +0000
From:   Wei Hu <weh@microsoft.com>
To:     b.zolnierkie@samsung.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, mchehab+samsung@kernel.org,
        sam@ravnborg.org, gregkh@linuxfoundation.org,
        alexandre.belloni@bootlin.com, info@metux.net, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH v4] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Date:   Mon,  9 Dec 2019 15:57:49 +0800
Message-Id: <20191209075749.3804-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To BYAPR21MB1285.namprd21.prod.outlook.com
 (2603:10b6:a03:10a::22)
MIME-Version: 1.0
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.49) by SG2PR01CA0164.apcprd01.prod.exchangelabs.com (2603:1096:4:28::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 9 Dec 2019 07:58:16 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e86cf3e3-68db-467c-e3ea-08d77c7d8f84
X-MS-TrafficTypeDiagnostic: BYAPR21MB1208:|BYAPR21MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB12082932B1BEF70DEB6C272CBB580@BYAPR21MB1208.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(50226002)(8936002)(52116002)(7416002)(51416003)(7696005)(10090500001)(10290500003)(2870700001)(50466002)(48376002)(66556008)(66476007)(54906003)(66946007)(6486002)(5660300002)(305945005)(956004)(8676002)(36756003)(2616005)(81166006)(81156014)(26005)(316002)(478600001)(3450700001)(2906002)(4326008)(1250700005)(43066004)(16526019)(6636002)(186003)(6666004)(86362001)(1076003)(30864003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1208;H:BYAPR21MB1285.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bulZ602dnbSz2fhSdCOKVFtGgzCiVthwmNhNmHfk3VvGZpJD3fFRZumslGARrB5LFL1IS9y9fzOpvHwZ3KPYnW+YFHL8BY4kY5tj48TNIaKQQzAyKaYB6tMWmpdl5qSqs9LQUn0+4zGcoPsTLrUg5/U0PrpHFR+64m7XGck/o3nMtsiyPQ0LzgxjFQk0Pwolup/dYpvPBrWo54sZThMplAyCa8JTd745q9QXjq/x1nNa6wdu+Xmv4qXeKZ1L8v+BnYQItfdBbf6MOChbfwixR3V0O1t2UKwMDL5OPnPVOxK5j7/Imt2YpY2E7jD2YadV5W4KUDDT5yDYrXeZpqdILICgYS7hJnnTANwMn1IxMgdrKr1hWlfbjgAS3ZRMfIX3ISLEOQMc6xOry+dnAPY/eLp7gO00BbHcMuXXr6pFIn1JKn7Ky3tXMBrmkJMhAHoqzXR12TTdlBGyftXFgHOuOuG/ooqjEOD/bU48/wwkA9rA+m3S4qzTLp3nx2Vv3c1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86cf3e3-68db-467c-e3ea-08d77c7d8f84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 07:58:22.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m2Q/LaU/FigEv0g2My+rOjLr/KELgHAPkgVGpyC51ItfBMA9i1V44hkOGiv8ySJUM4S/mYb/hjj+ZJIbS1X1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1208
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

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2: Incorporated review comments form hch@lst.de, Michael Kelley and
    Dexuan Cui
    - Use dma_alloc_coherent to allocate large contiguous memory
    - Use phys_addr_t for physical addresses
    - Corrected a few spelling errors and minor cleanups
    - Also tested on 32 bit Ubuntu guest
    v3: Fixed a build issue reported by kbuild test robot and incorported
    some review comments from Michael Kelley
    - Add CMA check to avoid link failure
    - Fixed small memory leak introduced by alloc_apertures
    - Cleaned up so code
    v4: Removed request_pages variable as it is no longer needed

 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 182 +++++++++++++++++++++++++-------
 2 files changed, 144 insertions(+), 39 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..f65991a67af2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2215,6 +2215,7 @@ config FB_HYPERV
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_DEFERRED_IO
+	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 3f60b7bc8589..c15ce2a00886 100644
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
@@ -938,6 +951,62 @@ static void hvfb_get_option(struct fb_info *info)
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
+	phys_addr_t paddr = 0;
+	unsigned int order = get_order(request_size);
+
+	if (request_size == 0)
+		return -1;
+
+	if (order < MAX_ORDER) {
+		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (!page)
+			return -1;
+
+		paddr = (page_to_pfn(page) << PAGE_SHIFT);
+	} else {
+		/* Allocate from CMA */
+		hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
+
+		vmem = dma_alloc_coherent(&hdev->device,
+					  round_up(request_size, PAGE_SIZE),
+					  &dma_handle,
+					  GFP_KERNEL | __GFP_NOWARN);
+
+		if (!vmem)
+			return -1;
+
+		paddr = virt_to_phys(vmem);
+	}
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
@@ -947,22 +1016,61 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
 	resource_size_t pot_start, pot_end;
+	phys_addr_t paddr;
 	int ret;
 
-	dio_fb_size =
-		screen_width * screen_height * screen_depth / 8;
+	info->apertures = alloc_apertures(1);
+	if (!info->apertures)
+		return -ENOMEM;
 
-	if (gen2vm) {
-		pot_start = 0;
-		pot_end = -1;
-	} else {
+	if (!gen2vm) {
 		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
+			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
 		if (!pdev) {
 			pr_err("Unable to find PCI Hyper-V video\n");
+			kfree(info->apertures);
 			return -ENODEV;
 		}
 
+		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
+		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
+
+		/*
+		 * For Gen 1 VM, we can directly use the contiguous memory
+		 * from VM. If we succeed, deferred IO happens directly
+		 * on this allocated framebuffer memory, avoiding extra
+		 * memory copy.
+		 */
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
+			goto getmem_done;
+		}
+		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
+	} else {
+		info->apertures->ranges[0].base = screen_info.lfb_base;
+		info->apertures->ranges[0].size = screen_info.lfb_size;
+	}
+
+	/*
+	 * Cannot use the contiguous physical memory.
+	 * Allocate mmio space for framebuffer.
+	 */
+	dio_fb_size =
+		screen_width * screen_height * screen_depth / 8;
+
+	if (gen2vm) {
+		pot_start = 0;
+		pot_end = -1;
+	} else {
 		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
 		    pci_resource_len(pdev, 0) < screen_fb_size) {
 			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
@@ -991,20 +1099,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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
@@ -1015,13 +1109,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_base = par->dio_vp;
 	info->screen_size = dio_fb_size;
 
+getmem_done:
+	remove_conflicting_framebuffers(info->apertures,
+					KBUILD_MODNAME, false);
 	if (!gen2vm)
 		pci_dev_put(pdev);
+	kfree(info->apertures);
 
 	return 0;
 
-err4:
-	vfree(par->dio_vp);
 err3:
 	iounmap(fb_virt);
 err2:
@@ -1030,18 +1126,25 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 err1:
 	if (!gen2vm)
 		pci_dev_put(pdev);
+	kfree(info->apertures);
 
 	return -ENOMEM;
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
 
@@ -1060,6 +1163,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	par = info->par;
 	par->info = info;
 	par->fb_ready = false;
+	par->need_docopy = true;
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
 
@@ -1145,7 +1249,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1175,7 +1279,7 @@ static int hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.20.1

