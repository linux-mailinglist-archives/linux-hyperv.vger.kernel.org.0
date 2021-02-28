Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A223272C4
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhB1PGN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhB1PFg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 10:05:36 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FFC06178C;
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id l2so9756552pgb.1;
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
        b=M6yApM0RYY+6vKyqs5rGk4XoO5WfZilQksJCGjz7zTYmlxqaIQOs9xQsqJJhlPq1YM
         pxGchngpeYk2d3Q4I57ND726MeEL35jNEZTf2l2TdwpGnBciiNG4GcvwmCEB3mpNJ4Nq
         HFlKegnRidRGhrTNSsF7G8AaJ2O/g3zrQSycccIqPXcoY/khshfCVMePQW7lYEy5sdRT
         7vJw8XOtxdOLgu5ckj6lkaBbHN7IEM/UlHqZDhbK/GyvJfqrV10/iFFLQftnB+jbtpGJ
         sZYL2oKqQX2dqxN+OGTjYAgqmVXMVQi+9F9QqnV9dynkv0egVKz7MKyQ5VLbRjS+2Qzw
         XfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
        b=GyARbubJuI69cT38EM7jWtbkmSlrVvGwLrJ7nPix6yzC5+EXAQq8RkPlELuhWuhHG6
         Pud/llxPuJOuYjNy0r1h1EucMKBK+dYZZ9JU3m21i531MgedPg0QAcoqToj8BubKkwBB
         9bk0yUgzp0XHTs0s5bF/MwmbZaM9kV4K7BGNJ3gUi9nh6GXgLMECAkRqRK/vxKSNWj9a
         jg5Eid9wbKw0ySksGWBOcb+ghPJDo0lwhISU0SC/hVW7Qnq/7iFoK3Fu0MhVtkPwo5N3
         hmRiTu96DSx4JQ8i3lJG+cxN96a/zDI2H5nWK1qlgtA6EEukt9LsgW9SBlITZ9zYtq5K
         LKLQ==
X-Gm-Message-State: AOAM532buApjoBr3wFIh/wOWa84KF6DN86jR38vc0K49lHOX6k1lPK/X
        OgwweqKfVcBHwikRTL/UpDs=
X-Google-Smtp-Source: ABdhPJz0M2eG3YiIFqm9Rqp2DTIxGUr6KVib5DGW3AfT85mo7GestrdvERbaYx48eb2uN8SCnRIIDg==
X-Received: by 2002:a62:1650:0:b029:1ee:26a:4958 with SMTP id 77-20020a6216500000b02901ee026a4958mr11307341pfw.49.1614524656668;
        Sun, 28 Feb 2021 07:04:16 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:16 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC PATCH 6/12] HV/Vmbus: Add SNP support for VMbus channel initiate message
Date:   Sun, 28 Feb 2021 10:03:09 -0500
Message-Id: <20210228150315.2552437-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

The physical address of monitor pages in the CHANNELMSG_INITIATE_CONTACT
msg should be in the extra address space for SNP support and these
pages also should be accessed via the extra address space inside Linux
guest and remap the extra address by ioremap function.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/connection.c   | 62 +++++++++++++++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 79bca653dce9..a0be9c11d737 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -101,6 +101,12 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 
 	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
 	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
+
+	if (hv_isolation_type_snp()) {
+		msg->monitor_page1 += ms_hyperv.shared_gpa_boundary;
+		msg->monitor_page2 += ms_hyperv.shared_gpa_boundary;
+	}
+
 	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 
 	/*
@@ -145,6 +151,29 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		return -ECONNREFUSED;
 	}
 
+	if (hv_isolation_type_snp()) {
+		vmbus_connection.monitor_pages_va[0]
+			= vmbus_connection.monitor_pages[0];
+		vmbus_connection.monitor_pages[0]
+			= ioremap_cache(msg->monitor_page1, HV_HYP_PAGE_SIZE);
+		if (!vmbus_connection.monitor_pages[0])
+			return -ENOMEM;
+
+		vmbus_connection.monitor_pages_va[1]
+			= vmbus_connection.monitor_pages[1];
+		vmbus_connection.monitor_pages[1]
+			= ioremap_cache(msg->monitor_page2, HV_HYP_PAGE_SIZE);
+		if (!vmbus_connection.monitor_pages[1]) {
+			vunmap(vmbus_connection.monitor_pages[0]);
+			return -ENOMEM;
+		}
+
+		memset(vmbus_connection.monitor_pages[0], 0x00,
+		       HV_HYP_PAGE_SIZE);
+		memset(vmbus_connection.monitor_pages[1], 0x00,
+		       HV_HYP_PAGE_SIZE);
+	}
+
 	return ret;
 }
 
@@ -156,6 +185,7 @@ int vmbus_connect(void)
 	struct vmbus_channel_msginfo *msginfo = NULL;
 	int i, ret = 0;
 	__u32 version;
+	u64 pfn[2];
 
 	/* Initialize the vmbus connection */
 	vmbus_connection.conn_state = CONNECTING;
@@ -213,6 +243,16 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	if (hv_isolation_type_snp()) {
+		pfn[0] = virt_to_hvpfn(vmbus_connection.monitor_pages[0]);
+		pfn[1] = virt_to_hvpfn(vmbus_connection.monitor_pages[1]);
+		if (hv_mark_gpa_visibility(2, pfn,
+				VMBUS_PAGE_VISIBLE_READ_WRITE)) {
+			ret = -EFAULT;
+			goto cleanup;
+		}
+	}
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -279,6 +319,8 @@ int vmbus_connect(void)
 
 void vmbus_disconnect(void)
 {
+	u64 pfn[2];
+
 	/*
 	 * First send the unload request to the host.
 	 */
@@ -298,6 +340,26 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
+	if (hv_isolation_type_snp()) {
+		if (vmbus_connection.monitor_pages_va[0]) {
+			vunmap(vmbus_connection.monitor_pages[0]);
+			vmbus_connection.monitor_pages[0]
+				= vmbus_connection.monitor_pages_va[0];
+			vmbus_connection.monitor_pages_va[0] = NULL;
+		}
+
+		if (vmbus_connection.monitor_pages_va[1]) {
+			vunmap(vmbus_connection.monitor_pages[1]);
+			vmbus_connection.monitor_pages[1]
+				= vmbus_connection.monitor_pages_va[1];
+			vmbus_connection.monitor_pages_va[1] = NULL;
+		}
+
+		pfn[0] = virt_to_hvpfn(vmbus_connection.monitor_pages[0]);
+		pfn[1] = virt_to_hvpfn(vmbus_connection.monitor_pages[1]);
+		hv_mark_gpa_visibility(2, pfn, VMBUS_PAGE_NOT_VISIBLE);
+	}
+
 	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
 	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
 	vmbus_connection.monitor_pages[0] = NULL;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 9416e09ebd58..0778add21a9c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -240,6 +240,7 @@ struct vmbus_connection {
 	 * is child->parent notification
 	 */
 	struct hv_monitor_page *monitor_pages[2];
+	void *monitor_pages_va[2];
 	struct list_head chn_msg_list;
 	spinlock_t channelmsg_lock;
 
-- 
2.25.1

