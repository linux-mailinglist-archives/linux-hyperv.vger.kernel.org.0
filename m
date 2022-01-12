Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AF48CC97
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbiALT4i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33328 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357562AbiALTzS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:18 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6056620B7189;
        Wed, 12 Jan 2022 11:55:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6056620B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017316;
        bh=MwbB/ddATcfa9BxPm51+g/+S83gW10pwATFsv44Bzpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKbATM5vIpa0SQ5rk88ik7J7X0J3KsPOPJACp+4K+obaTIWqqdjGCEHgZA+dCLWRq
         Alxc5+4sxmxukBYSHzEI1yH/gpfjNoAF0KgW8aP/8yO+tGUvDtYAZvJ0OXVUiFlGMr
         9rxMNweDRVP6s139VpcTpiQuRgazLjm2tEHqCT5w=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 6/9] drivers: hv: dxgkrnl: Seal the shared resource object when dxgk_share_objects is called.
Date:   Wed, 12 Jan 2022 11:55:11 -0800
Message-Id: <c761a0f7ee5ab2dc4147e975c378c19366e6cbf6.1641937420.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A dxgresource object is a collection of dxgallocation objects.
The WDDM API allows addition/removal allocations to a resource.
The WDDM API has limitations on addition/removal of allocations to
a shared resource. When a resource is "sealed", addition/removal of
allocations is not allowed.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/ioctl.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 2086f7347ba3..97f4d2471ca5 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2767,18 +2767,38 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	case HMGRENTRY_TYPE_DXGSYNCOBJECT:
 		ret = get_object_fd(DXG_SHARED_SYNCOBJECT, shared_syncobj,
 				    &object_fd);
-		if (ret >= 0)
-			ret =
-			    dxgsharedsyncobj_get_host_nt_handle(shared_syncobj,
-								process,
-								handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_object_fd failed for sync object",
+				__func__);
+			goto cleanup;
+		}
+		ret = dxgsharedsyncobj_get_host_nt_handle(shared_syncobj,
+							  process,
+							  handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_host_nt_handle failed", __func__);
+			goto cleanup;
+		}
 		break;
 	case HMGRENTRY_TYPE_DXGRESOURCE:
 		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
 				    &object_fd);
-		if (ret >= 0)
-			ret = dxgsharedresource_get_host_nt_handle(
-				shared_resource, process, handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_object_fd failed for resource",
+				__func__);
+			goto cleanup;
+		}
+		ret = dxgsharedresource_get_host_nt_handle(shared_resource,
+							   process, handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_host_res_nt_handle failed", __func__);
+			goto cleanup;
+		}
+		ret = dxgsharedresource_seal(shared_resource);
+		if (ret < 0) {
+			pr_err("%s dxgsharedresource_seal failed", __func__);
+			goto cleanup;
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.32.0

