Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F535E2AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346636AbhDMPXB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346626AbhDMPXA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B9C06138C;
        Tue, 13 Apr 2021 08:22:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso3843904pjg.2;
        Tue, 13 Apr 2021 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
        b=IorVha2fAs30YZN37FaV6uAQyxzqaHjSRfcunab87zeSZVY8fZFYEyu8OcVg14LhZn
         b7xfbtxGH0ydZwOVvVMvpruybX7g5jst63ifHz1X0WIDsSGV1JmjUAxwOgsrPHquiJqR
         DCJqC4kDdfTY2ISZi9UeDSWLxVGVdroIB3rKqmKgeX7xbcjc/L2IhWZY8kLnNhRgToj1
         5ftFz87idRzDFEurQm2AVDwsKZnRUyfktSU3CJ/RwI32bR+dLkdxZNFaM2EJv7eL2tYA
         pwyBHnHlg5YBZMqt9sKpTow1IKmu2gobmTGmmyoF1F1CGsiFGsTEthwzyZoSgojSHTBj
         4jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
        b=X2TDIgB28a/0rdipAaL45R3pOsS3iw0F4sRNCUNhFphTwvIvI264SxW0f4GAZ6QT5m
         4kNy8JlwU/dqIYilT/jxZrJeI52i5QuZNVeUX9WE56eNo2m/YAlzjb2AlHv9+0H7AVTR
         Po/K8/laFAZlAOZzAPRQSBLDxeBCnuME0uOVcXoHaYwQwqGxz8prmIi/300DTUkwyQjb
         W5OyqkeIDP0Kcndj8xTMIVRj7Nn9lTFwmjiD3eLBu+hhsmdWGMJNxA+6LYdolPTqdQwu
         zNRnz7bdarGkXKLJi0MFFdQm5b+BdAyy9yl5kZ1TDZeYTX9k+730nyhV2OdD+5N5G4zg
         GxlA==
X-Gm-Message-State: AOAM530J3TQo80u/7011UEaDrqdKlfRiuHdtESUvK6GVVxZCBqMgZTSX
        NAeMH4aG2sv2JV1RQnhGExI=
X-Google-Smtp-Source: ABdhPJxxIfKAERJLDA4HlDzx+GqfEOCgEJK8jSf67l6KS3hJVyLrTuI7Q1aPiqMmEAsqC1e97/PxAw==
X-Received: by 2002:a17:90a:3b4c:: with SMTP id t12mr608975pjf.142.1618327359114;
        Tue, 13 Apr 2021 08:22:39 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:38 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC V2 PATCH 6/12] HV/Vmbus: Add SNP support for VMbus channel initiate message
Date:   Tue, 13 Apr 2021 11:22:11 -0400
Message-Id: <20210413152217.3386288-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
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

