Return-Path: <linux-hyperv+bounces-3242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2502B9BA714
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C261C218E7
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FF1A01B9;
	Sun,  3 Nov 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FKhFlW+f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17D198A0E;
	Sun,  3 Nov 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653488; cv=none; b=MPY0UG7ns3iQl0xTBmd5VponzDAcezsR3dITUJytMX9K6ftxZrP3ICQ3MPTcdIb71+5ugCZNWr60j8zFw2N2KA+RvAFlCZqJK7K6d3R+FfF3JcMta8Qm67AyaZs/6klGdz7xrLH2WSq2bp24Aaxp2EW0Pl+V/WViNBNgCWNdkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653488; c=relaxed/simple;
	bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPDqD9yLgTfwBeAoAGE9kZKlsBz2BWZgUZImoCXvro2YjEQH3htWy4qk9/IzylJOdAdGcW2eFQcQ3YD5L9BATKz2LOkqp+88fCxejIgPJBGszhUGFzovRRWBW+qw/r7193EvoEcKs8fYb8MVO1kfvCKzUDbjPpB5BMBdeJhFqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FKhFlW+f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653481;
	bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKhFlW+fXVU9iiG5WHWrfxqIg2MK5RN4rmEJ6qMm9w3609SWSEqzIiyskpf0F3SE/
	 5Hue+UAKF4NoE2Q53mkBkJ7j/9iT4JRSPm/DM+o1r+XqpuQf548H1TiWzMDARBYT4p
	 NmQ6pgjd99tSp5B6B0CVtWY1Wv6AMrStXbMf+hV8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:39 +0000
Subject: [PATCH v2 10/10] driver core: Constify attribute arguments of
 binary attributes
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-10-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2330;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
 b=wjQlo57jq0Wj7AlLBOYWjC3NLTcXdQ4S/vHvyo3etlKonEvBK3xDMeXVEI2nFeo1fRBiMSJWq
 8Dy1FhYi+4pDACqaxOlIcEPw5eL4UaDS9rJJgllbu0x7Wp3mt9dGtys
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As preparation for the constification of struct bin_attribute,
constify the arguments of the read and write callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/node.c     | 4 ++--
 drivers/base/topology.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e62727e5b2198a6451cf9c2533225a..3e761633ac75826bedb5dd30b879f7cc1af95ec3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,7 +27,7 @@ static const struct bus_type node_subsys = {
 };
 
 static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
-				  struct bin_attribute *attr, char *buf,
+				  const struct bin_attribute *attr, char *buf,
 				  loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -48,7 +48,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9915b2974e184bf89c4c25c183095..1090751d7f458ce8d2a50e82d65b8ce31e938f15 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -23,7 +23,7 @@ static ssize_t name##_show(struct device *dev,				\
 
 #define define_siblings_read_func(name, mask)					\
 static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
-			   struct bin_attribute *attr, char *buf,		\
+			   const struct bin_attribute *attr, char *buf,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
@@ -33,7 +33,7 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
-				struct bin_attribute *attr, char *buf,		\
+				const struct bin_attribute *attr, char *buf,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\

-- 
2.47.0


