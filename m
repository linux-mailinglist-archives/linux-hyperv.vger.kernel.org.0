Return-Path: <linux-hyperv+bounces-3245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01029BA720
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B29CB21A02
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727D01AAE02;
	Sun,  3 Nov 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="V5VfZeBh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18319939D;
	Sun,  3 Nov 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653489; cv=none; b=GwoiXdsapCIVV/XhPQP22sq/5E3c+iE5HShfkhjslqEnaDEpftOUDHAbXQM/98CuHIQCU+3GgML4TPuOWAllOe+BHGE3Cu/NekwV1QKLYUk0ZJfO0BwNO9Vw6b+cvgzmey+Yd1lKWM4xQPDsw2a5yKCseQYe5of9VgI14yT93fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653489; c=relaxed/simple;
	bh=8oN+tVBMjVju8UGiuvmEhTX5MjVK0/eJhQB1Q2KrGWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz8rkwGsLofc//Llcn/5zU/XpiSjo8yqqPpN6UyaUZGGu5v7Vy8D+n6UacgUBCylaRBx9UkeqR67faWTJrsesA6cfwpca3fejB1CzK9jQSy8SZ8MpmjQ3ouUVqu7A8lDD+f4JsvkgttnFGG5XTtMFqUKsFBoG0zqBXAJpDCdRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=V5VfZeBh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653481;
	bh=8oN+tVBMjVju8UGiuvmEhTX5MjVK0/eJhQB1Q2KrGWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V5VfZeBhkpEc+BJr7U99hw+VXSO0/H281e2i3OYqzSsy0SGGDBKgbIYwAQQopjk5p
	 I7JCsIntvCcuTbL2t6kOL8I3VTTsft0tPJFg0d7SRbJHJj1BfvHU9DrPRIY2+deo0n
	 668eR2kfbt5yn/SgMliSXeyVZwt9yiewus2l4ruQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:35 +0000
Subject: [PATCH v2 06/10] sysfs: treewide: constify attribute callback of
 bin_attribute::mmap()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-6-71110628844c@weissschuh.net>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org, 
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=7091;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8oN+tVBMjVju8UGiuvmEhTX5MjVK0/eJhQB1Q2KrGWg=;
 b=R3n6q+Dv0Ia776qfgM6mO9COiJ/hbKbbIydIDRQ3XaMKG9aRvi7HhpKHS1X+wwbHJsRL7kye+
 ekmDB9xxV8TBGzZeTtNVftVmS4rbHM4mxGMeptcYkAQpdQnmMEfZR2L
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The mmap() callbacks should not modify the struct
bin_attribute passed as argument.
Enforce this by marking the argument as const.

As there are not many callback implementers perform this change
throughout the tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/alpha/kernel/pci-sysfs.c          |  6 +++---
 drivers/misc/ocxl/sysfs.c              |  2 +-
 drivers/pci/p2pdma.c                   |  2 +-
 drivers/pci/pci-sysfs.c                | 10 +++++-----
 drivers/platform/x86/intel/pmt/class.c |  2 +-
 drivers/uio/uio_hv_generic.c           |  2 +-
 include/linux/sysfs.h                  |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 5808a66e2a81f7eba9a245fd6a343406a1ade87d..3048758304b57afa01ddeb6558c39bdb48c9a3f6 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -64,7 +64,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int num,
  * Return: %0 on success, negative error code otherwise
  */
 static int pci_mmap_resource(struct kobject *kobj,
-			     struct bin_attribute *attr,
+			     const struct bin_attribute *attr,
 			     struct vm_area_struct *vma, int sparse)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -93,14 +93,14 @@ static int pci_mmap_resource(struct kobject *kobj,
 }
 
 static int pci_mmap_resource_sparse(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 1);
 }
 
 static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr,
+				   const struct bin_attribute *attr,
 				   struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 0);
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index 405180d47d9bff0aaa7a736bb3fecfbe318db961..07520d6e6dc55702696b8656440914c379e6e27a 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -125,7 +125,7 @@ static const struct vm_operations_struct global_mmio_vmops = {
 };
 
 static int global_mmio_mmap(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr,
+			const struct bin_attribute *bin_attr,
 			struct vm_area_struct *vma)
 {
 	struct ocxl_afu *afu = to_afu(kobj_to_dev(kobj));
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500ff5339cde426b6ccb020fcd74ae7..7abd4f546d3c071f31e622d881f5c5ac3e4de55e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -90,7 +90,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(published);
 
 static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, struct vm_area_struct *vma)
+		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	size_t len = vma->vm_end - vma->vm_start;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 13912940ed2bb66c0086e5bea9a3cb6417ac14dd..0ad3427228b12aa95325c6fc00e9686740559238 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -910,7 +910,7 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
  * memory space.
  */
 static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *attr,
+			       const struct bin_attribute *attr,
 			       struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
@@ -930,7 +930,7 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
  * memory space. Returns -ENOSYS if the operation isn't supported
  */
 static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *attr,
+			      const struct bin_attribute *attr,
 			      struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
@@ -1034,7 +1034,7 @@ void pci_remove_legacy_files(struct pci_bus *b)
  *
  * Use the regular PCI mapping routines to map a PCI resource into userspace.
  */
-static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
+static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *attr,
 			     struct vm_area_struct *vma, int write_combine)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1059,14 +1059,14 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
 static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 1);
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index c04bb7f97a4db13268fc5697887951cf8f0f5a25..f9afa23e754b8b68bd59b72d6a72d26503a21f31 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -103,7 +103,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 
 static int
 intel_pmt_mmap(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, struct vm_area_struct *vma)
+		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
 	struct intel_pmt_entry *entry = container_of(attr,
 						     struct intel_pmt_entry,
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 8704095994118c2660f345c504b5ea466d053efb..3976360d0096d6681faf88815cc6277fb76a1d9f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -135,7 +135,7 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
 static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *attr,
+			    const struct bin_attribute *attr,
 			    struct vm_area_struct *vma)
 {
 	struct vmbus_channel *channel
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d1b22d56198b55ee39fe4c4fc994f5b753641992..9fcdc8cd3118f359742bfd8b708d5c3eff511042 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -309,7 +309,7 @@ struct bin_attribute {
 			 char *, loff_t, size_t);
 	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
 			 loff_t, int);
-	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
+	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };
 

-- 
2.47.0


