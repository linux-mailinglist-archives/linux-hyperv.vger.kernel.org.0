Return-Path: <linux-hyperv+bounces-3008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DC9773A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D7A284D93
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC31C2DA4;
	Thu, 12 Sep 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QCL4+jgV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB31C245D;
	Thu, 12 Sep 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176505; cv=none; b=aG+VtTpV3vk+uhO+LqM/JCmf+3/XLdrOob+IFIffJUgncPmKB4kJXQoEoJymW0Jv8lrUVhNdlROfNYfb73Xzol06/MPRDHs5ViV3dDDnG5mPkJWsUSamlMhI29wyy6aqILxSoRZRRyYtnyNWrwaLF4lMEsdu6BuLq8xQB0YaMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176505; c=relaxed/simple;
	bh=R9Vt5l4uV759u50znu0Kwms3/gcQROrvQjc9nqgC+MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XOADJui5hC0LeEwUmmGxVRYWyTOcjXSm8AputnHoDwxZguMVQDB3QG7gsmONSdgv1lpk4KKWvOz4vZh211mF6Kp0HRzbLFiQ+3es3WMj/jH52BLHf0imOp9xHENMdaIdaLHRj/eHkC0n3BnLYZ+xzKQ/5LoGsEgnxSrE42ccwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QCL4+jgV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1E7A920B9D5D; Thu, 12 Sep 2024 14:28:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E7A920B9D5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726176504;
	bh=dH1jkguCL91E0buKYm/Y8WVgFu63aCaiAaKV6PxAw4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCL4+jgVlkG2/OJ/AQpQ2oZQA+6Mm423VCNLQuNrU88B12C+qgVqhBgl6Y++M5Hl2
	 SnEsT+83uy0YJm/tpivAA+XPFMjStHHppmeU9ITSwXolBeQTLVpBnj/e/xuETwL6vb
	 BHd4MP1z0zIbUfOu5+y73gZkUr1S11i20ASvxAqY=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH 3/3] Revert "HID: hyperv: register as a wakeup source"
Date: Thu, 12 Sep 2024 14:27:50 -0700
Message-Id: <1726176470-13133-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This reverts commit f1210455e78a610c7b316389b31c162c371d888c.

Remove mouse as wakeup source since Suspend-to-Idle feature
is disabled.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/hid/hid-hyperv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index f33485d83d24..b6d0f7db4c93 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -293,9 +293,6 @@ static void mousevsc_on_receive(struct hv_device *device,
 		memcpy(input_dev->input_buf, input_report->buffer, len);
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
-
-		pm_wakeup_hard_event(&input_dev->device->device);
-
 		break;
 	default:
 		pr_err("unsupported hid msg type - type %d len %d\n",
@@ -502,8 +499,6 @@ static int mousevsc_probe(struct hv_device *device,
 		goto probe_err2;
 	}
 
-	device_init_wakeup(&device->device, true);
-
 	input_dev->connected = true;
 	input_dev->init_complete = true;
 
@@ -526,7 +521,6 @@ static void mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
 
-	device_init_wakeup(&dev->device, false);
 	vmbus_close(dev->channel);
 	hid_hw_stop(input_dev->hid_device);
 	hid_destroy_device(input_dev->hid_device);
-- 
2.34.1


