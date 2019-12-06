Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2495114FCA
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Dec 2019 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFLdc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Dec 2019 06:33:32 -0500
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:39809
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfLFLdb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Dec 2019 06:33:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPrSzPwXiyEeNZaZTJ24wrEInMCtEqHrGOfEdpQqpLTUzLLkuYiYcSkZXnDJ0K9wIU8vw/562FxCTXMmiGc4XdfgazEDarV0PmxHXWiObBKyn05LNP26BO3rL6BNUfh4ZRifbIVrSu+rerCnx/9wrNecTRO+BRMWgGVV3MMK0keXeS1KPFvq1DSPzanKW32VUDlhhOIRhvq3wQJf6mWP4SBPohUrUbNEpzjHeKiBvHvtVYckn9wA7dEogUe92WekE0/QIHCY6upG4nwKpLU6jCG0SDq0/XaioiIjXzPfqpQ2X8GofLAZCx1ceJrBj74RPBNEScbUzQz5QG0n+KERgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVBxUvKYpmg+Cp7rFHpJJHvaJNKpSzy0jIKkCnqYXdA=;
 b=W3N3IpG6lsm2pMJZsj+jXOi2gH6mMLbxtaFMbfKdYL41CQreBSZzqnF6FlH9Y0WufPBGf0VQ4IrRa5ImQqLxk+qIiZu1dzJDd93PB9QrxmKAktM9LGeDRHujU7jdsnGgAu8LR+eH3JakVI6vnMANB4uBNne2v2BH+GDWMrMFW+YwNis+SFNk9Ymsi2E1XOW1l3HkZNKExeqtWSqfXnW1Q0cq/muFOtQflU4P/Fm5vz6ayJN9Wt9JsB1lab9kVIehEpwUNgJp7bOtwYoRgIe8ydOtp8yHVkfQutIUoagwZxsEgCSuQPuXWOxBtdvPEL4dmHQK2HTsmxVsWslofwNCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVBxUvKYpmg+Cp7rFHpJJHvaJNKpSzy0jIKkCnqYXdA=;
 b=EZV9uh+fu0zoZv4zRk9SQL7kr9g9cDxMYmHKYC1WNREqAbGfikbB3ghQP5H4nNmT+dUm+4AYkJtkzmfFPoQBOS9x64NdTFBJjP+usxuuWZG6YvxxI1oMZhpsxmLFtFr27aP1GQ4gxCrsna4fp4uUYyOVWY9p5aUw7NLweol4QJ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
Received: from BN8PR21MB1284.namprd21.prod.outlook.com (20.179.74.150) by
 BN8PR21MB1234.namprd21.prod.outlook.com (20.179.73.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.1; Fri, 6 Dec 2019 11:33:27 +0000
Received: from BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::6138:f167:f1e4:fd6e]) by BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::6138:f167:f1e4:fd6e%3]) with mapi id 15.20.2538.005; Fri, 6 Dec 2019
 11:33:26 +0000
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
Subject: [PATCH v3] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Date:   Fri,  6 Dec 2019 19:32:20 +0800
Message-Id: <20191206113220.1849-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0103.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::29) To BN8PR21MB1284.namprd21.prod.outlook.com
 (2603:10b6:408:a2::22)
MIME-Version: 1.0
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.49) by SG2PR01CA0103.apcprd01.prod.exchangelabs.com (2603:1096:3:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 6 Dec 2019 11:33:19 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9721ed2a-1c83-4e9f-15a9-08d77a401be4
X-MS-TrafficTypeDiagnostic: BN8PR21MB1234:|BN8PR21MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1234A25D8633C1A55769F466BB5F0@BN8PR21MB1234.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(51416003)(52116002)(186003)(26005)(25786009)(956004)(2616005)(16526019)(7696005)(50226002)(10090500001)(10290500003)(22452003)(66946007)(66476007)(66556008)(478600001)(305945005)(5660300002)(316002)(6636002)(7416002)(86362001)(3450700001)(2906002)(22746008)(30864003)(14444005)(6486002)(2870700001)(48376002)(50466002)(8936002)(81166006)(81156014)(1250700005)(8676002)(36756003)(54906003)(6666004)(4326008)(1076003)(43066004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1234;H:BN8PR21MB1284.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNNdb/GF5Etn3c1UNJxnpLtps9VXKd+4O7CkjIQQTwggvmmiKnFPgA0UdMCu1ZliMrx07HLIEhHSmn3oM64ImzsyvTh24lowYuK5v7ACgIB6uXbhtXwM3J7fKyls6ZRM7xBvblG5fD8qHLKmPVxxqJA0H26bIiuqCi081PKzznJsTpvYvicbdoa2df5NSgLzdIoTUnCka4ocFWVNDrC4l0PIMxBXIkrBTxATzU/8mPRLY6F/zzA6pLpr9fTN+a1S8phJgBd9C1xXA4PYoG12TRT7OCMfP6jOTN6AiDi6C3Mk/geS3xdMXQFPpDWbihXW6AqFe00cFmJr4pxRaBoNCKtjTQ5Qixt8xwwvoMyEhU/r12UPV70kL94XX9HeJ/PaHIzTNAtcTbi/JNVcdKjF5DsMCsLOqQ4If+NdHVd1zq5E15J8bs9n1sQYktM8xgoA+95249kePEMjtloWHGRHBeDMzw8YtQFhwq1obdBUMYPL7ftxMpp5/e+sHhvIVAqv
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9721ed2a-1c83-4e9f-15a9-08d77a401be4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 11:33:26.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7V5197AMqNMOMxyaLclrVeeE4mkFgQOepg45VCNAYDW99EyYlniI8R9uTO1heeeL4ehxgrO4IFQNk3U5POBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1234
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

 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 187 +++++++++++++++++++++++++-------
 2 files changed, 149 insertions(+), 39 deletions(-)

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
index 3f60b7bc8589..7dff82c77551 100644
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
@@ -938,6 +951,67 @@ static void hvfb_get_option(struct fb_info *info)
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
+	if (order < MAX_ORDER) {
+		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (!page)
+			return -1;
+
+		paddr = (page_to_pfn(page) << PAGE_SHIFT);
+		request_pages = (1 << order);
+	} else {
+		/* Allocate from CMA */
+		hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
+
+		request_pages = (round_up(request_size, PAGE_SIZE) >>
+				 PAGE_SHIFT);
+
+		vmem = dma_alloc_coherent(&hdev->device,
+					  request_pages * PAGE_SIZE,
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
@@ -947,22 +1021,61 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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
@@ -991,20 +1104,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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
@@ -1015,13 +1114,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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
@@ -1030,18 +1131,25 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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
 
@@ -1060,6 +1168,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	par = info->par;
 	par->info = info;
 	par->fb_ready = false;
+	par->need_docopy = true;
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
 
@@ -1145,7 +1254,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1175,7 +1284,7 @@ static int hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(info);
+	hvfb_putmem(hdev, info);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.20.1

