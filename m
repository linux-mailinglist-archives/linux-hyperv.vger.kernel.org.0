Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B30399167
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFBRW5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51164 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 831D120B8016;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 831D120B8016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=LqIAPp9b4xr0FaDrJqaVWN3iMnfFRXlJZFkyUUKF0Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KD89Y0w11I4iJpq6aXWTI6oDHT/ce5KxcTlggBvbLRf9TFe9WNwY8/vonxvJZcIyH
         Ovl26R8Zs6LI2IhX/hCJtJnbY8WIk54VUDbjiFqy6mmHSdiUPBY8VNC5tEsWFayszD
         XUeGE2IL29wdb9UmGCDAeW1yZtF4jGyHLBv62/yA=
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
Subject: [PATCH 08/17] mshv: Port id management
Date:   Wed,  2 Jun 2021 17:20:53 +0000
Message-Id: <ddd9f9295e8dbd8aad81bf7e02a4a8076e04654a.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Each port in the partition should be uniquely identified by an id.
Partition is responsible for managing the port id.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/Makefile          |  2 +-
 drivers/hv/hv_portid_table.c | 83 ++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv.h            | 35 +++++++++++++++
 drivers/hv/mshv_main.c       |  2 +
 4 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/hv_portid_table.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a2b698661b5e..455a2c01f52c 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,4 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
-mshv-y                          += mshv_main.o hv_call.o hv_synic.o
+mshv-y                          += mshv_main.o hv_call.o hv_synic.o hv_portid_table.o
diff --git a/drivers/hv/hv_portid_table.c b/drivers/hv/hv_portid_table.c
new file mode 100644
index 000000000000..3e8feefc3fc9
--- /dev/null
+++ b/drivers/hv/hv_portid_table.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+
+/*
+ * Ports and connections are hypervisor struct used for inter-partition
+ * communication. Port represents the source and connection represents
+ * the destination. Partitions are responsible for managing the port and
+ * connection ids.
+ *
+ */
+
+#define PORTID_MIN	1
+#define PORTID_MAX	INT_MAX
+
+static DEFINE_IDR(port_table_idr);
+
+void
+hv_port_table_fini(void)
+{
+	struct port_table_info *port_info;
+	unsigned long i, tmp;
+
+	idr_lock(&port_table_idr);
+	if (!idr_is_empty(&port_table_idr)) {
+		idr_for_each_entry_ul(&port_table_idr, port_info, tmp, i) {
+			port_info = idr_remove(&port_table_idr, i);
+			kfree_rcu(port_info, rcu);
+		}
+	}
+	idr_unlock(&port_table_idr);
+}
+
+int
+hv_portid_alloc(struct port_table_info *info)
+{
+	int ret = 0;
+
+	idr_lock(&port_table_idr);
+	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
+			PORTID_MAX, GFP_KERNEL);
+	idr_unlock(&port_table_idr);
+
+	return ret;
+}
+
+void
+hv_portid_free(int port_id)
+{
+	struct port_table_info *info;
+
+	idr_lock(&port_table_idr);
+	info = idr_remove(&port_table_idr, port_id);
+	WARN_ON(!info);
+	idr_unlock(&port_table_idr);
+
+	synchronize_rcu();
+	kfree(info);
+}
+
+int
+hv_portid_lookup(int port_id, struct port_table_info *info)
+{
+	struct port_table_info *_info;
+	int ret = -ENOENT;
+
+	rcu_read_lock();
+	_info = idr_find(&port_table_idr, port_id);
+	rcu_read_unlock();
+
+	if (_info) {
+		*info = *_info;
+		ret = 0;
+	}
+
+	return ret;
+}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index e16818e977b9..ff5dc02cd8b6 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -39,6 +39,41 @@ void mshv_isr(void);
 int mshv_synic_init(unsigned int cpu);
 int mshv_synic_cleanup(unsigned int cpu);
 
+/*
+ * Callback for doorbell events.
+ * NOTE: This is called in interrupt context. Callback
+ * should defer slow and sleeping logic to later.
+ */
+typedef void (*doorbell_cb_t) (void *);
+
+/*
+ * port table information
+ */
+struct port_table_info {
+	struct rcu_head rcu;
+	enum hv_port_type port_type;
+	union {
+		struct {
+			u64 reserved[2];
+		} port_message;
+		struct {
+			u64 reserved[2];
+		} port_event;
+		struct {
+			u64 reserved[2];
+		} port_monitor;
+		struct {
+			doorbell_cb_t doorbell_cb;
+			void *data;
+		} port_doorbell;
+	};
+};
+
+void hv_port_table_fini(void);
+int hv_portid_alloc(struct port_table_info *info);
+int hv_portid_lookup(int port_id, struct port_table_info *info);
+void hv_portid_free(int port_id);
+
 /*
  * Hyper-V hypercalls
  */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 2adae676dba5..ccf0971d0d39 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -1146,6 +1146,8 @@ __exit mshv_exit(void)
 	cpuhp_remove_state(mshv_cpuhp_online);
 	free_percpu(mshv.synic_pages);
 
+	hv_port_table_fini();
+
 	misc_deregister(&mshv_dev);
 }
 
-- 
2.25.1

