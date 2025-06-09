Return-Path: <linux-hyperv+bounces-5804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF661AD1C36
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA42C188C2D8
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7A2512C8;
	Mon,  9 Jun 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kdBSCz2f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70E1C8604;
	Mon,  9 Jun 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467152; cv=none; b=NFlvBycFAsiAQYXYY5ezqEmhq+tVcG5CZLXP+LkCMyElm8ygNtCWUsAWDqJB1IKm0Aw+kPUwUy8449dy+qjXB1yp31xqweuHYcx3xu51Xhe5gO5DHk0viguD8O/GZpNZiXRF1j0ldOZOF2Ga+CoxDYToMGJPuNKxKZnpJeNHSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467152; c=relaxed/simple;
	bh=GAw/vyy6tmYVRUj5Ewz5RGBDb3kVxsqpj8DAUb1n9II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L2Es/CJwEQfdXVCUnqv5CABIt5sKQ3WNjXXViKXOvUJSoST5SumJv+y1tCb5T4FVzFT+fYhb5BTp5/NDvvt0t/1CnXIgxqqwSY7ce3+PG/BizqV8AeBS9RSnjqHPreelPNoiiQihTqkh8GVRIhQijJUFbkzO5bRMvgSKoiT+fuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kdBSCz2f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749467148;
	bh=GAw/vyy6tmYVRUj5Ewz5RGBDb3kVxsqpj8DAUb1n9II=;
	h=From:Date:Subject:To:Cc:From;
	b=kdBSCz2fwmBYsttja+tL2e9qVtdVahZD+SelUCfLiRlM7nEA6th7Jdb4VW/bOICqi
	 rjBrRu1UhLqiZ36aT+65gqHRRcAKFWdvLxftJXKzOrNmXY5naeDOg+2Ed0eqdZE/bg
	 bJ0vtoHTspnWpGe+Fhz4cXKEcYc8ASpTaAcyZ10g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 13:05:44 +0200
Subject: [PATCH] drivers: hv: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-sysfs-const-bin_attr-hv-v1-1-bfed20083800@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAfARmgC/x3MQQqAIBBA0avErBswxcCuEhFlY83GwpEoorsnL
 d/i/weEEpNAVz2Q6GThPRY0dQV+m+JKyEsxaKWtapVDuSUI+j1KxpnjOOWccDuxMdY7smY22kK
 pj0SBr//cD+/7ARn8imRpAAAA
X-Change-ID: 20250609-sysfs-const-bin_attr-hv-135c9e53b325
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749467147; l=1324;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GAw/vyy6tmYVRUj5Ewz5RGBDb3kVxsqpj8DAUb1n9II=;
 b=h9Q8P+QzMrI3N1HXb16zz2VzCoPQcbReCSM6BR3HF8IaaOFbKiwokI8NnKt46ihgMTWk+ZKVu
 ySGjS4bwSNsBwq5JhPtyxhOOfxUF2TthDHUvawBvxFPpN/R/EfsYh48
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 33b524b4eb5ef89d0111442a34d39874f02f0b70..38d2775dbe8730fd223d21188519b5f2b72e0804 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1845,7 +1845,7 @@ static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
 	return channel->mmap_ring_buffer(channel, vma);
 }
 
-static struct bin_attribute chan_attr_ring_buffer = {
+static const struct bin_attribute chan_attr_ring_buffer = {
 	.attr = {
 		.name = "ring",
 		.mode = 0600,
@@ -1871,7 +1871,7 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
-static const struct bin_attribute *vmbus_chan_bin_attrs[] = {
+static const struct bin_attribute *const vmbus_chan_bin_attrs[] = {
 	&chan_attr_ring_buffer,
 	NULL
 };

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250609-sysfs-const-bin_attr-hv-135c9e53b325

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


