Return-Path: <linux-hyperv+bounces-3089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF5989C5B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 10:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867152818A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D9185B44;
	Mon, 30 Sep 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Luh721dP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85781185937;
	Mon, 30 Sep 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683956; cv=none; b=c+5arLzQBmVQWpUIVhqdm8Ku9UfLcWIxqVW0MTrLQGZkqGX+je53Rsqnj7XsINmZWvNnGGSC5GQXCUFcNDUAqyq82H1orZZ3AeTHhaOeDWKDuJx65oGJA8wi28xqRyPQ5ZRS8dTfpWUwdrU1VcgmKjAze9DETCounhJ5rkBR5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683956; c=relaxed/simple;
	bh=kk/hgYJKzfrSyEZ63RX3OFjZ+ojTIwIQixIFkUGn+HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fJcgI9w+cAkze0OW0tBVHvnwihBXxGSyuedMfkN8s0Ot4T5fvJAVDAaJQP02rpSVeZ40AKDuXJIbv9YjTgbH0fCsIUQLVS3FAMSA+ENz+bk9xpfeMchcGYMVP7yvDIC7AdmCZavgEMHYELw/WjCzJrmC9pKWQg2xXkkrS8OoF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Luh721dP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3A45220C8C63; Mon, 30 Sep 2024 01:12:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A45220C8C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727683955;
	bh=6uy2HCfWrjzOK/GPEwENb235RVQzwbIIz+wXrMpaUeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Luh721dPCXQ/jnoJhJ72hu8j4/zuMHI7ttozso439aRvt/DTDOtQiaP5ErPh6qfXT
	 xqghT9v/lv5eaIofpc+zViPt8KXBQxxMzbsBDC5s5Aq/gATvGyLkCc/MA2I1sFcBYd
	 XNfHH0iFUPZVU6fY1Gn5yLN2eKZ2gh+k94geNMb0=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v2 3/3] Revert "HID: hyperv: register as a wakeup source"
Date: Mon, 30 Sep 2024 01:11:57 -0700
Message-Id: <1727683917-31485-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727683917-31485-1-git-send-email-ernis@linux.microsoft.com>
References: <1727683917-31485-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This reverts commit f1210455e78a610c7b316389b31c162c371d888c.

Remove mouse as wakeup source since Suspend-To-Idle feature
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


