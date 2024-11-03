Return-Path: <linux-hyperv+bounces-3247-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298029BA728
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B81C21027
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7641AB6ED;
	Sun,  3 Nov 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SyRnyZMY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853D19CC02;
	Sun,  3 Nov 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653489; cv=none; b=LeuKic6DVkcfaREC21J5lYKNCKb9DPt06M8Rb0s7affUDhdkJah8hkGfi82RSVABrE0NqBrxPo12lYwtGHB3uXGHZmNs9S1gazVVgl7OP0yLJDZ236vpJhLcVH03mosfsFdimKxIgc4SZDrRYLV2e/tm+X+aee2KRR2iHUqEQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653489; c=relaxed/simple;
	bh=GMdVqpFwoDETa/zGkV60zA/YyucohMN7ciiORB0dDFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqM1IKuO1od+FXY9l7RxefHyL4qSipFHlQ65C1VIKJvJTkBTIKRim+sYmJFBgL6a2yKE70v2k1M6SfZTI1MhDwIn0y0fX68i7rejtbKNEAZ0SIj0d4cFL5Z5Wyg2+f2ieFcbmAHebMNBPSwsMJkpZUqDvpp8QVMa5mOGNhGBloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SyRnyZMY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653481;
	bh=GMdVqpFwoDETa/zGkV60zA/YyucohMN7ciiORB0dDFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SyRnyZMYYiuvS05pAbdP2BNw8Ha3Wp0EjLxI/8VZebe+J32OJzQ0FfngSr11pbc3S
	 3hLaAVDffCbL3wYrk/f1ofcjd6D+cxYnSPaa7E742CRmKRTph9QuWBX2pSm+y7iW5V
	 1DVHDyNnW5ZmICuH8Tv9nJe+/D6n4jWkebWhVEBk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:37 +0000
Subject: [PATCH v2 08/10] sysfs: implement all BIN_ATTR_* macros in terms
 of __BIN_ATTR()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-8-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2547;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GMdVqpFwoDETa/zGkV60zA/YyucohMN7ciiORB0dDFM=;
 b=G1PulaFbJ1PZH7AnZk220ddkyci6/SVWNb+Rtvwc4kmmjYqzz3Epr6UCHfWP8qbRyhd/TurKs
 If4brtJxns8CxxC6suNmBgy57hhP6OtLmxJDPf6RSsE1N5AsLzcns6R
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The preparations for the upcoming constification of struct bin_attribute
requires some logic in the structure definition macros.
To avoid duplication of that logic in multiple macros, reimplement all
other macros in terms of __BIN_ATTR().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index cb2a5e277c2384f2e8add8fbf2907e8a819576ec..d17c473c1ef292875475bf3bdf62d07241c13882 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -333,17 +333,11 @@ struct bin_attribute {
 	.size	= _size,						\
 }
 
-#define __BIN_ATTR_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
-	.read	= _name##_read,						\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_RO(_name, _size)					\
+	__BIN_ATTR(_name, 0444, _name##_read, NULL, _size)
 
-#define __BIN_ATTR_WO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
-	.write	= _name##_write,					\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_WO(_name, _size)					\
+	__BIN_ATTR(_name, 0200, NULL, _name##_write, _size)
 
 #define __BIN_ATTR_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
@@ -364,11 +358,8 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
 
-#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
-	.read	= _name##_read,						\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_ADMIN_RO(_name, _size)				\
+	__BIN_ATTR(_name, 0400, _name##_read, NULL, _size)
 
 #define __BIN_ATTR_ADMIN_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
@@ -379,10 +370,8 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
 #define BIN_ATTR_ADMIN_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
 
-#define __BIN_ATTR_SIMPLE_RO(_name, _mode) {				\
-	.attr	= { .name = __stringify(_name), .mode = _mode },	\
-	.read	= sysfs_bin_attr_simple_read,				\
-}
+#define __BIN_ATTR_SIMPLE_RO(_name, _mode)				\
+	__BIN_ATTR(_name, _mode, sysfs_bin_attr_simple_read, NULL, 0)
 
 #define BIN_ATTR_SIMPLE_RO(_name)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_SIMPLE_RO(_name, 0444)

-- 
2.47.0


