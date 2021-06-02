Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F739916A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFBRW6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51186 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id B1E8020B801C;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1E8020B801C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=OJ9pPwP8H50eEvzj/RL3PydJAKG9PhqRRXT3CuRFK7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3VdqdvKeuGxGAPK9mpFPWh4ZCffwf8JRQX7RdFN3ZZfjZguCYOJAiyJf1HAkHWtL
         wqqUAYr/cuhnXAi4oH2U/KilP6AdHZH5ldGnRIIf1XnA1WuSV1+X8PN68+aVy+cL+0
         PdJai2C3KB+Enjd3G/daA3y4GLgfSvOTpdgeo+eo=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 10/17] mshv: Doorbell register/unregister API
Date:   Wed,  2 Jun 2021 17:20:55 +0000
Message-Id: <1a1e91505da1548664060f9e8a73f81423dff100.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Doorbell is a  mechanism by which a parent partition can register for
notification if a specified mmio address is touched by a child partition.
Parent partition can setup the notification by specifying mmio address,
size of the data written(1/2/4/8 bytes) and optionally the data as well.

APIs for registering and unregistering doorbell notification.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_synic.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv.h     |  4 +++
 2 files changed, 85 insertions(+)

diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index e3262f6d3daa..af6653967209 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/random.h>
@@ -389,3 +390,83 @@ int mshv_synic_cleanup(unsigned int cpu)
 
 	return 0;
 }
+
+int
+hv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb, void *data,
+		     u64 gpa, u64 val, u64 flags)
+{
+	struct hv_connection_info connection_info = { 0 };
+	union hv_connection_id connection_id = { 0 };
+	struct port_table_info *port_table_info;
+	struct hv_port_info port_info = { 0 };
+	union hv_port_id port_id = { 0 };
+	int ret;
+
+	port_table_info = kmalloc(sizeof(struct port_table_info),
+				  GFP_KERNEL);
+	if (!port_table_info)
+		return -ENOMEM;
+
+	port_table_info->port_type = HV_PORT_TYPE_DOORBELL;
+	port_table_info->port_doorbell.doorbell_cb = doorbell_cb;
+	port_table_info->port_doorbell.data = data;
+	ret = hv_portid_alloc(port_table_info);
+	if (ret < 0) {
+		pr_err("Failed to create the doorbell port!\n");
+		kfree(port_table_info);
+		return ret;
+	}
+
+	port_id.u.id = ret;
+	port_info.port_type = HV_PORT_TYPE_DOORBELL;
+	port_info.doorbell_port_info.target_sint = HV_SYNIC_DOORBELL_SINT_INDEX;
+	port_info.doorbell_port_info.target_vp = HV_ANY_VP;
+	ret = hv_call_create_port(hv_current_partition_id, port_id, partition_id,
+				  &port_info,
+				  0, 0, NUMA_NO_NODE);
+
+	if (ret < 0) {
+		pr_err("Failed to create the port!\n");
+		hv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	connection_id.u.id = port_id.u.id;
+	connection_info.port_type = HV_PORT_TYPE_DOORBELL;
+	connection_info.doorbell_connection_info.gpa = gpa;
+	connection_info.doorbell_connection_info.trigger_value = val;
+	connection_info.doorbell_connection_info.flags = flags;
+
+	ret = hv_call_connect_port(hv_current_partition_id, port_id, partition_id,
+				   connection_id, &connection_info, 0, NUMA_NO_NODE);
+	if (ret < 0) {
+		hv_call_delete_port(hv_current_partition_id, port_id);
+		hv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	// lets use the port_id as the doorbell_id
+	return port_id.u.id;
+}
+
+int
+hv_unregister_doorbell(u64 partition_id, int doorbell_portid)
+{
+	int ret = 0;
+	union hv_port_id port_id = { 0 };
+	union hv_connection_id connection_id = { 0 };
+
+	connection_id.u.id = doorbell_portid;
+	ret = hv_call_disconnect_port(partition_id, connection_id);
+	if (ret < 0)
+		pr_err("Failed to disconnect the doorbell connection!\n");
+
+	port_id.u.id = doorbell_portid;
+	ret = hv_call_delete_port(hv_current_partition_id, port_id);
+	if (ret < 0)
+		pr_err("Failed to disconnect the doorbell connection!\n");
+
+	hv_portid_free(doorbell_portid);
+
+	return ret;
+}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 07b0e7865a4c..76cd00fd4b3f 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -74,6 +74,10 @@ int hv_portid_alloc(struct port_table_info *info);
 int hv_portid_lookup(int port_id, struct port_table_info *info);
 void hv_portid_free(int port_id);
 
+int hv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
+			 void *data, u64 gpa, u64 val, u64 flags);
+int hv_unregister_doorbell(u64 partition_id, int doorbell_portid);
+
 /*
  * Hyper-V hypercalls
  */
-- 
2.25.1

