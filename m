Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B04C94C4
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiCATrX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiCATrP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A2056CA6F;
        Tue,  1 Mar 2022 11:46:31 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id E24D620B83E4;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E24D620B83E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163991;
        bh=fmQ3XBJpaf7DICAHb/hnK2O+ZRI4zLXFjWmYVt34tCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrQUfYB5g/bx42TlApjOhhswlUYo2w7GDseiTl95JDROKWTnbFbg834Px8fNkUbJG
         +RZH8pVuyvBZuYKNkPk51PwbyuuM1i4DXIIysoTKsXOEk7zhsHKptT+yr0LzInFDe9
         rEErU9FhmOBpUhuLHB+mCUVLebt0F2l0PahHKiBE=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 05/30] drivers: hv: dxgkrnl: Opening of /dev/dxg device and dxgprocess creation
Date:   Tue,  1 Mar 2022 11:45:52 -0800
Message-Id: <419b863b2848b9e86382511a2f0f12cf91065578.1646163378.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- Implement opening of the device (/dev/dxg) file object and creation of
dxgprocess objects.

- Add VM bus messages to create and destroy the host side of a dxgprocess
object.

- Implement the handle manager, which manages d3dkmthandle handles
for the internal process objects. The handles are used by a user mode
client to reference dxgkrnl objects.

dxgprocess is created for each process, which opens /dev/dxg.
dxgprocess is ref counted, so the existing dxgprocess objects is used
for a process, which opens the device object multiple time.
dxgprocess is destroyed when the file object is released.

A corresponding dxgprocess object is created on the host for every
dxgprocess object in the guest.

When a dxgkrnl object is created, in most cases the corresponding
object is created in the host. The VM references the host objects by
handles (d3dkmthandle). d3dkmthandle values for a host object and
the corresponding VM object are the same. A host handle is allocated
first and its value is assigned to the guest object.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile     |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h    |  40 ++-
 drivers/hv/dxgkrnl/dxgmodule.c  |  67 +++-
 drivers/hv/dxgkrnl/dxgprocess.c |  97 ++++++
 drivers/hv/dxgkrnl/dxgvmbus.c   |  79 +++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  24 ++
 drivers/hv/dxgkrnl/hmgr.c       | 566 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/hmgr.h       | 112 +++++++
 drivers/hv/dxgkrnl/ioctl.c      |  70 ++++
 drivers/hv/dxgkrnl/misc.h       |   1 -
 include/uapi/misc/d3dkmthk.h    |   2 +
 11 files changed, 1056 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 2ed07d877c91..9d821e83448a 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o misc.o dxgadapter.o ioctl.o dxgvmbus.o
+dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index c0fd0bb267f2..61512463baa4 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -27,9 +27,11 @@
 #include <linux/pci.h>
 #include <linux/hyperv.h>
 
+struct dxgprocess;
 struct dxgadapter;
 
 #include "misc.h"
+#include "hmgr.h"
 #include <uapi/misc/d3dkmthk.h>
 
 struct dxgk_device_types {
@@ -137,10 +139,44 @@ struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
 int dxgglobal_acquire_channel_lock(void);
 void dxgglobal_release_channel_lock(void);
 
+/*
+ * The structure represents a process, which opened the /dev/dxg device.
+ * A corresponding object is created on the host.
+ */
 struct dxgprocess {
-	/* Placeholder */
+	/*
+	 * Process list entry in dxgglobal.
+	 * Protected by the dxgglobal->plistmutex.
+	 */
+	struct list_head	plistentry;
+	struct task_struct	*process;
+	pid_t			pid;
+	pid_t			tgid;
+	/* how many time the process was opened */
+	struct kref		process_kref;
+	/*
+	 * This handle table is used for all objects except dxgadapter
+	 * The handle table lock order is higher than the local_handle_table
+	 * lock
+	 */
+	struct hmgrtable	handle_table;
+	/*
+	 * This handle table is used for dxgadapter objects.
+	 * The handle table lock order is lowest.
+	 */
+	struct hmgrtable	local_handle_table;
+	/* Handle of the corresponding objec on the host */
+	struct d3dkmthandle	host_handle;
 };
 
+struct dxgprocess *dxgprocess_create(void);
+void dxgprocess_destroy(struct dxgprocess *process);
+void dxgprocess_release(struct kref *refcount);
+void dxgprocess_ht_lock_shared_down(struct dxgprocess *process);
+void dxgprocess_ht_lock_shared_up(struct dxgprocess *process);
+void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process);
+void dxgprocess_ht_lock_exclusive_up(struct dxgprocess *process);
+
 enum dxgadapter_state {
 	DXGADAPTER_STATE_ACTIVE		= 0,
 	DXGADAPTER_STATE_STOPPED	= 1,
@@ -210,6 +246,8 @@ static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 void dxgvmb_initialize(void);
 int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 				   struct vmbus_gpadl *shared_mem_gpadl);
+int dxgvmb_send_create_process(struct dxgprocess *process);
+int dxgvmb_send_destroy_process(struct d3dkmthandle process);
 int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 5ae57977731c..c79be67b8d56 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -204,17 +204,80 @@ static void dxgglobal_stop_adapters(void)
 	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
 }
 
+/*
+ * Returns dxgprocess for the current executing process.
+ * Creates dxgprocess if it doesn't exist.
+ */
+static struct dxgprocess *dxgglobal_get_current_process(void)
+{
+	/*
+	 * Find the DXG process for the current process.
+	 * A new process is created if necessary.
+	 */
+	struct dxgprocess *process = NULL;
+	struct dxgprocess *entry = NULL;
+
+	mutex_lock(&dxgglobal->plistmutex);
+	list_for_each_entry(entry, &dxgglobal->plisthead, plistentry) {
+		/* All threads of a process have the same thread group ID */
+		if (entry->process->tgid == current->tgid) {
+			if (kref_get_unless_zero(&entry->process_kref)) {
+				process = entry;
+				pr_debug("found dxgprocess");
+			} else {
+				pr_debug("process is destroyed");
+			}
+			break;
+		}
+	}
+	mutex_unlock(&dxgglobal->plistmutex);
+
+	if (process == NULL)
+		process = dxgprocess_create();
+
+	return process;
+}
+
 /*
  * File operations for the /dev/dxg device
  */
 
 static int dxgk_open(struct inode *n, struct file *f)
 {
-	return 0;
+	int ret = 0;
+	struct dxgprocess *process;
+
+	pr_debug("%s %p %d %d",
+		     __func__, f, current->pid, current->tgid);
+
+
+	/* Find/create a dxgprocess structure for this process */
+	process = dxgglobal_get_current_process();
+
+	if (process) {
+		f->private_data = process;
+	} else {
+		pr_debug("cannot create dxgprocess for open\n");
+		ret = -EBADF;
+	}
+
+	pr_debug("%s end %x", __func__, ret);
+	return ret;
 }
 
 static int dxgk_release(struct inode *n, struct file *f)
 {
+	struct dxgprocess *process;
+
+	process = (struct dxgprocess *)f->private_data;
+	pr_debug("%s %p, %p", __func__, f, process);
+
+	if (process == NULL)
+		return -EINVAL;
+
+	kref_put(&process->process_kref, dxgprocess_release);
+
+	f->private_data = NULL;
 	return 0;
 }
 
@@ -236,6 +299,8 @@ const struct file_operations dxgk_fops = {
 	.owner = THIS_MODULE,
 	.open = dxgk_open,
 	.release = dxgk_release,
+	.compat_ioctl = dxgk_compat_ioctl,
+	.unlocked_ioctl = dxgk_unlocked_ioctl,
 	.write = dxgk_write,
 	.read = dxgk_read,
 };
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
new file mode 100644
index 000000000000..2a86ba1b4b1b
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * DXGPROCESS implementation
+ *
+ */
+
+#include "dxgkrnl.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+/*
+ * Creates a new dxgprocess object
+ * Must be called when dxgglobal->plistmutex is held
+ */
+struct dxgprocess *dxgprocess_create(void)
+{
+	struct dxgprocess *process;
+	int ret;
+
+	process = vzalloc(sizeof(struct dxgprocess));
+	if (process != NULL) {
+		pr_debug("new dxgprocess created\n");
+		process->process = current;
+		process->pid = current->pid;
+		process->tgid = current->tgid;
+		ret = dxgvmb_send_create_process(process);
+		if (ret < 0) {
+			pr_debug("send_create_process failed\n");
+			vfree(process);
+			process = NULL;
+		} else {
+			INIT_LIST_HEAD(&process->plistentry);
+			kref_init(&process->process_kref);
+
+			mutex_lock(&dxgglobal->plistmutex);
+			list_add_tail(&process->plistentry,
+				      &dxgglobal->plisthead);
+			mutex_unlock(&dxgglobal->plistmutex);
+
+			hmgrtable_init(&process->handle_table, process);
+			hmgrtable_init(&process->local_handle_table, process);
+		}
+	}
+	return process;
+}
+
+void dxgprocess_destroy(struct dxgprocess *process)
+{
+	hmgrtable_destroy(&process->handle_table);
+	hmgrtable_destroy(&process->local_handle_table);
+}
+
+void dxgprocess_release(struct kref *refcount)
+{
+	struct dxgprocess *process;
+
+	process = container_of(refcount, struct dxgprocess, process_kref);
+
+	mutex_lock(&dxgglobal->plistmutex);
+	list_del(&process->plistentry);
+	process->plistentry.next = NULL;
+	mutex_unlock(&dxgglobal->plistmutex);
+
+	dxgprocess_destroy(process);
+
+	if (process->host_handle.v)
+		dxgvmb_send_destroy_process(process->host_handle);
+	vfree(process);
+}
+
+void dxgprocess_ht_lock_shared_down(struct dxgprocess *process)
+{
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+}
+
+void dxgprocess_ht_lock_shared_up(struct dxgprocess *process)
+{
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+}
+
+void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process)
+{
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+}
+
+void dxgprocess_ht_lock_exclusive_up(struct dxgprocess *process)
+{
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 6b02932819c8..988372c5812e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -495,6 +495,85 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 	return ret;
 }
 
+int dxgvmb_send_create_process(struct dxgprocess *process)
+{
+	int ret;
+	struct dxgkvmb_command_createprocess *command;
+	struct dxgkvmb_command_createprocess_return result = { 0 };
+	struct dxgvmbusmsg msg;
+	char s[WIN_MAX_PATH];
+	int i;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CREATEPROCESS);
+	command->process = process;
+	command->process_id = process->process->pid;
+	command->linux_process = 1;
+	s[0] = 0;
+	__get_task_comm(s, WIN_MAX_PATH, process->process);
+	for (i = 0; i < WIN_MAX_PATH; i++) {
+		command->process_name[i] = s[i];
+		if (s[i] == 0)
+			break;
+	}
+
+	ret = dxgvmb_send_sync_msg(&dxgglobal->channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("create_process failed %d", ret);
+	} else if (result.hprocess.v == 0) {
+		pr_err("create_process returned 0 handle");
+		ret = -ENOTRECOVERABLE;
+	} else {
+		process->host_handle = result.hprocess;
+		pr_debug("create_process returned %x",
+			    process->host_handle.v);
+	}
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_process(struct d3dkmthandle process)
+{
+	int ret;
+	struct dxgkvmb_command_destroyprocess *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+	command_vm_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_DESTROYPROCESS,
+				 process);
+	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel,
+					    msg.hdr, msg.size);
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index eda259324588..ddd7b6bf9964 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -14,7 +14,11 @@
 #ifndef _DXGVMBUS_H
 #define _DXGVMBUS_H
 
+struct dxgprocess;
+struct dxgadapter;
+
 #define DXG_MAX_VM_BUS_PACKET_SIZE	(1024 * 128)
+#define DXG_VM_PROCESS_NAME_LENGTH	260
 
 enum dxgkvmb_commandchanneltype {
 	DXGKVMB_VGPU_TO_HOST,
@@ -169,6 +173,26 @@ struct dxgkvmb_command_setiospaceregion {
 	u32				shared_page_gpadl;
 };
 
+struct dxgkvmb_command_createprocess {
+	struct dxgkvmb_command_vm_to_host hdr;
+	void			*process;
+	u64			process_id;
+	u16			process_name[DXG_VM_PROCESS_NAME_LENGTH + 1];
+	u8			csrss_process:1;
+	u8			dwm_process:1;
+	u8			wow64_process:1;
+	u8			linux_process:1;
+};
+
+struct dxgkvmb_command_createprocess_return {
+	struct d3dkmthandle	hprocess;
+};
+
+// The command returns ntstatus
+struct dxgkvmb_command_destroyprocess {
+	struct dxgkvmb_command_vm_to_host hdr;
+};
+
 struct dxgkvmb_command_openadapter {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	u32				vmbus_interface_version;
diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
new file mode 100644
index 000000000000..4c012046dcaf
--- /dev/null
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Handle manager implementation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+
+#include "misc.h"
+#include "dxgkrnl.h"
+#include "hmgr.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+const struct d3dkmthandle zerohandle;
+
+/*
+ * Handle parameters
+ */
+#define HMGRHANDLE_INSTANCE_BITS	6
+#define HMGRHANDLE_INDEX_BITS		24
+#define HMGRHANDLE_UNIQUE_BITS		2
+
+#define HMGRHANDLE_INSTANCE_SHIFT	0
+#define HMGRHANDLE_INDEX_SHIFT	\
+	(HMGRHANDLE_INSTANCE_BITS + HMGRHANDLE_INSTANCE_SHIFT)
+#define HMGRHANDLE_UNIQUE_SHIFT	\
+	(HMGRHANDLE_INDEX_BITS + HMGRHANDLE_INDEX_SHIFT)
+
+#define HMGRHANDLE_INSTANCE_MASK \
+	(((1 << HMGRHANDLE_INSTANCE_BITS) - 1) << HMGRHANDLE_INSTANCE_SHIFT)
+#define HMGRHANDLE_INDEX_MASK      \
+	(((1 << HMGRHANDLE_INDEX_BITS)    - 1) << HMGRHANDLE_INDEX_SHIFT)
+#define HMGRHANDLE_UNIQUE_MASK     \
+	(((1 << HMGRHANDLE_UNIQUE_BITS)   - 1) << HMGRHANDLE_UNIQUE_SHIFT)
+
+#define HMGRHANDLE_INSTANCE_MAX	((1 << HMGRHANDLE_INSTANCE_BITS) - 1)
+#define HMGRHANDLE_INDEX_MAX	((1 << HMGRHANDLE_INDEX_BITS) - 1)
+#define HMGRHANDLE_UNIQUE_MAX	((1 << HMGRHANDLE_UNIQUE_BITS) - 1)
+
+/*
+ * Handle entry
+ */
+struct hmgrentry {
+	union {
+		void *object;
+		struct {
+			u32 prev_free_index;
+			u32 next_free_index;
+		};
+	};
+	u32 type:HMGRENTRY_TYPE_BITS + 1;
+	u32 unique:HMGRHANDLE_UNIQUE_BITS;
+	u32 instance:HMGRHANDLE_INSTANCE_BITS;
+	u32 destroyed:1;
+};
+
+#define HMGRTABLE_SIZE_INCREMENT	1024
+#define HMGRTABLE_MIN_FREE_ENTRIES 128
+#define HMGRTABLE_INVALID_INDEX (~((1 << HMGRHANDLE_INDEX_BITS) - 1))
+#define HMGRTABLE_SIZE_MAX		0xFFFFFFF
+
+static u32 table_size_increment = HMGRTABLE_SIZE_INCREMENT;
+
+static u32 get_unique(struct d3dkmthandle h)
+{
+	return (h.v & HMGRHANDLE_UNIQUE_MASK) >> HMGRHANDLE_UNIQUE_SHIFT;
+}
+
+static u32 get_index(struct d3dkmthandle h)
+{
+	return (h.v & HMGRHANDLE_INDEX_MASK) >> HMGRHANDLE_INDEX_SHIFT;
+}
+
+static bool is_handle_valid(struct hmgrtable *table, struct d3dkmthandle h,
+			    bool ignore_destroyed, enum hmgrentry_type t)
+{
+	u32 index = get_index(h);
+	u32 unique = get_unique(h);
+	struct hmgrentry *entry;
+
+	if (index >= table->table_size) {
+		pr_err("%s Invalid index %x %d\n", __func__, h.v, index);
+		return false;
+	}
+
+	entry = &table->entry_table[index];
+	if (unique != entry->unique) {
+		pr_err("%s Invalid unique %x %d %d %d %p",
+			   __func__, h.v, unique, entry->unique,
+			   index, entry->object);
+		return false;
+	}
+
+	if (entry->destroyed && !ignore_destroyed) {
+		pr_err("%s Invalid destroyed", __func__);
+		return false;
+	}
+
+	if (entry->type == HMGRENTRY_TYPE_FREE) {
+		pr_err("%s Entry is freed %x %d", __func__, h.v, index);
+		return false;
+	}
+
+	if (t != HMGRENTRY_TYPE_FREE && t != entry->type) {
+		pr_err("%s type mismatch %x %d %d", __func__, h.v,
+			   t, entry->type);
+		return false;
+	}
+
+	return true;
+}
+
+static struct d3dkmthandle build_handle(u32 index, u32 unique, u32 instance)
+{
+	struct d3dkmthandle handle;
+
+	handle.v = (index << HMGRHANDLE_INDEX_SHIFT) & HMGRHANDLE_INDEX_MASK;
+	handle.v |= (unique << HMGRHANDLE_UNIQUE_SHIFT) &
+	    HMGRHANDLE_UNIQUE_MASK;
+	handle.v |= (instance << HMGRHANDLE_INSTANCE_SHIFT) &
+	    HMGRHANDLE_INSTANCE_MASK;
+
+	return handle;
+}
+
+inline u32 hmgrtable_get_used_entry_count(struct hmgrtable *table)
+{
+	DXGKRNL_ASSERT(table->table_size >= table->free_count);
+	return (table->table_size - table->free_count);
+}
+
+bool hmgrtable_mark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return false;
+
+	table->entry_table[get_index(h)].destroyed = true;
+	return true;
+}
+
+bool hmgrtable_unmark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, true, HMGRENTRY_TYPE_FREE))
+		return true;
+
+	DXGKRNL_ASSERT(table->entry_table[get_index(h)].destroyed);
+	table->entry_table[get_index(h)].destroyed = 0;
+	return true;
+}
+
+static bool expand_table(struct hmgrtable *table, u32 NumEntries)
+{
+	u32 new_table_size;
+	struct hmgrentry *new_entry;
+	u32 table_index;
+	u32 new_free_count;
+	u32 prev_free_index;
+	u32 tail_index = table->free_handle_list_tail;
+
+	/* The tail should point to the last free element in the list */
+	if (table->free_count != 0) {
+		if (tail_index >= table->table_size ||
+		    table->entry_table[tail_index].next_free_index !=
+		    HMGRTABLE_INVALID_INDEX) {
+			pr_err("%s:corruption\n", __func__);
+			pr_err("tail_index: %x", tail_index);
+			pr_err("table size: %x", table->table_size);
+			pr_err("free_count: %d", table->free_count);
+			pr_err("NumEntries: %x", NumEntries);
+			return false;
+		}
+	}
+
+	new_free_count = table_size_increment + table->free_count;
+	new_table_size = table->table_size + table_size_increment;
+	if (new_table_size < NumEntries) {
+		new_free_count += NumEntries - new_table_size;
+		new_table_size = NumEntries;
+	}
+
+	if (new_table_size > HMGRHANDLE_INDEX_MAX) {
+		pr_err("%s:corruption\n", __func__);
+		return false;
+	}
+
+	new_entry = (struct hmgrentry *)
+	    vzalloc(new_table_size * sizeof(struct hmgrentry));
+	if (new_entry == NULL) {
+		pr_err("%s:allocation failed\n", __func__);
+		return false;
+	}
+
+	if (table->entry_table) {
+		memcpy(new_entry, table->entry_table,
+		       table->table_size * sizeof(struct hmgrentry));
+		vfree(table->entry_table);
+	} else {
+		table->free_handle_list_head = 0;
+	}
+
+	table->entry_table = new_entry;
+
+	/* Initialize new table entries and add to the free list */
+	table_index = table->table_size;
+
+	prev_free_index = table->free_handle_list_tail;
+
+	while (table_index < new_table_size) {
+		struct hmgrentry *entry = &table->entry_table[table_index];
+
+		entry->prev_free_index = prev_free_index;
+		entry->next_free_index = table_index + 1;
+		entry->type = HMGRENTRY_TYPE_FREE;
+		entry->unique = 1;
+		entry->instance = 0;
+		prev_free_index = table_index;
+
+		table_index++;
+	}
+
+	table->entry_table[table_index - 1].next_free_index =
+	    (u32) HMGRTABLE_INVALID_INDEX;
+
+	if (table->free_count != 0) {
+		/* Link the current free list with the new entries */
+		struct hmgrentry *entry;
+
+		entry = &table->entry_table[table->free_handle_list_tail];
+		entry->next_free_index = table->table_size;
+	}
+	table->free_handle_list_tail = new_table_size - 1;
+	if (table->free_handle_list_head == HMGRTABLE_INVALID_INDEX)
+		table->free_handle_list_head = table->table_size;
+
+	table->table_size = new_table_size;
+	table->free_count = new_free_count;
+
+	return true;
+}
+
+void hmgrtable_init(struct hmgrtable *table, struct dxgprocess *process)
+{
+	table->process = process;
+	table->entry_table = NULL;
+	table->table_size = 0;
+	table->free_handle_list_head = HMGRTABLE_INVALID_INDEX;
+	table->free_handle_list_tail = HMGRTABLE_INVALID_INDEX;
+	table->free_count = 0;
+	init_rwsem(&table->table_lock);
+}
+
+void hmgrtable_destroy(struct hmgrtable *table)
+{
+	if (table->entry_table) {
+		vfree(table->entry_table);
+		table->entry_table = NULL;
+	}
+}
+
+void hmgrtable_lock(struct hmgrtable *table, enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		down_write(&table->table_lock);
+	else
+		down_read(&table->table_lock);
+}
+
+void hmgrtable_unlock(struct hmgrtable *table, enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		up_write(&table->table_lock);
+	else
+		up_read(&table->table_lock);
+}
+
+struct d3dkmthandle hmgrtable_alloc_handle(struct hmgrtable *table,
+					   void *object,
+					   enum hmgrentry_type type,
+					   bool make_valid)
+{
+	u32 index;
+	struct hmgrentry *entry;
+	u32 unique;
+
+	DXGKRNL_ASSERT(type <= HMGRENTRY_TYPE_LIMIT);
+	DXGKRNL_ASSERT(type > HMGRENTRY_TYPE_FREE);
+
+	if (table->free_count <= HMGRTABLE_MIN_FREE_ENTRIES) {
+		if (!expand_table(table, 0)) {
+			pr_err("hmgrtable expand_table failed\n");
+			return zerohandle;
+		}
+	}
+
+	if (table->free_handle_list_head >= table->table_size) {
+		pr_err("hmgrtable corrupted handle table head\n");
+		return zerohandle;
+	}
+
+	index = table->free_handle_list_head;
+	entry = &table->entry_table[index];
+
+	if (entry->type != HMGRENTRY_TYPE_FREE) {
+		pr_err("hmgrtable expected free handle\n");
+		return zerohandle;
+	}
+
+	table->free_handle_list_head = entry->next_free_index;
+
+	if (entry->next_free_index != table->free_handle_list_tail) {
+		if (entry->next_free_index >= table->table_size) {
+			pr_err("hmgrtable invalid next free index\n");
+			return zerohandle;
+		}
+		table->entry_table[entry->next_free_index].prev_free_index =
+		    HMGRTABLE_INVALID_INDEX;
+	}
+
+	unique = table->entry_table[index].unique;
+
+	table->entry_table[index].object = object;
+	table->entry_table[index].type = type;
+	table->entry_table[index].instance = 0;
+	table->entry_table[index].destroyed = !make_valid;
+	table->free_count--;
+	DXGKRNL_ASSERT(table->free_count <= table->table_size);
+
+	return build_handle(index, unique, table->entry_table[index].instance);
+}
+
+int hmgrtable_assign_handle_safe(struct hmgrtable *table,
+				 void *object,
+				 enum hmgrentry_type type,
+				 struct d3dkmthandle h)
+{
+	int ret;
+
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(table, object, type, h);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+	return ret;
+}
+
+int hmgrtable_assign_handle(struct hmgrtable *table, void *object,
+			    enum hmgrentry_type type, struct d3dkmthandle h)
+{
+	u32 index = get_index(h);
+	u32 unique = get_unique(h);
+	struct hmgrentry *entry = NULL;
+
+	pr_debug("%s %x, %d %p, %p\n",
+		    __func__, h.v, index, object, table);
+
+	if (index >= HMGRHANDLE_INDEX_MAX) {
+		pr_err("handle index is too big: %x %d", h.v, index);
+		return -EINVAL;
+	}
+
+	if (index >= table->table_size) {
+		u32 new_size = index + table_size_increment;
+
+		if (new_size > HMGRHANDLE_INDEX_MAX)
+			new_size = HMGRHANDLE_INDEX_MAX;
+		if (!expand_table(table, new_size)) {
+			pr_err("failed to expand handle table %d", new_size);
+			return -ENOMEM;
+		}
+	}
+
+	entry = &table->entry_table[index];
+
+	if (entry->type != HMGRENTRY_TYPE_FREE) {
+		pr_err("the entry is already busy: %d %x",
+			   entry->type,
+			   hmgrtable_build_entry_handle(table, index).v);
+		return -EINVAL;
+	}
+
+	if (index != table->free_handle_list_tail) {
+		if (entry->next_free_index >= table->table_size) {
+			pr_err("hmgr: invalid next free index %d\n",
+				   entry->next_free_index);
+			return -EINVAL;
+		}
+		table->entry_table[entry->next_free_index].prev_free_index =
+		    entry->prev_free_index;
+	} else {
+		table->free_handle_list_tail = entry->prev_free_index;
+	}
+
+	if (index != table->free_handle_list_head) {
+		if (entry->prev_free_index >= table->table_size) {
+			pr_err("hmgr: invalid next prev index %d\n",
+				   entry->prev_free_index);
+			return -EINVAL;
+		}
+		table->entry_table[entry->prev_free_index].next_free_index =
+		    entry->next_free_index;
+	} else {
+		table->free_handle_list_head = entry->next_free_index;
+	}
+
+	entry->prev_free_index = HMGRTABLE_INVALID_INDEX;
+	entry->next_free_index = HMGRTABLE_INVALID_INDEX;
+	entry->object = object;
+	entry->type = type;
+	entry->instance = 0;
+	entry->unique = unique;
+	entry->destroyed = false;
+
+	table->free_count--;
+	DXGKRNL_ASSERT(table->free_count <= table->table_size);
+	return 0;
+}
+
+struct d3dkmthandle hmgrtable_alloc_handle_safe(struct hmgrtable *table,
+						void *obj,
+						enum hmgrentry_type type,
+						bool make_valid)
+{
+	struct d3dkmthandle h;
+
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	h = hmgrtable_alloc_handle(table, obj, type, make_valid);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+	return h;
+}
+
+void hmgrtable_free_handle(struct hmgrtable *table, enum hmgrentry_type t,
+			   struct d3dkmthandle h)
+{
+	struct hmgrentry *entry;
+	u32 i = get_index(h);
+
+	pr_debug("%s: %p %x\n", __func__, table, h.v);
+
+	/* Ignore the destroyed flag when checking the handle */
+	if (is_handle_valid(table, h, true, t)) {
+		DXGKRNL_ASSERT(table->free_count < table->table_size);
+		entry = &table->entry_table[i];
+		entry->unique = 1;
+		entry->type = HMGRENTRY_TYPE_FREE;
+		entry->destroyed = 0;
+		if (entry->unique != HMGRHANDLE_UNIQUE_MAX)
+			entry->unique += 1;
+		else
+			entry->unique = 1;
+
+		table->free_count++;
+		DXGKRNL_ASSERT(table->free_count <= table->table_size);
+
+		/*
+		 * Insert the index to the free list at the tail.
+		 */
+		entry->next_free_index = HMGRTABLE_INVALID_INDEX;
+		entry->prev_free_index = table->free_handle_list_tail;
+		entry = &table->entry_table[table->free_handle_list_tail];
+		entry->next_free_index = i;
+		table->free_handle_list_tail = i;
+	} else {
+		pr_err("%s:error: %d %x\n", __func__, i, h.v);
+	}
+}
+
+void hmgrtable_free_handle_safe(struct hmgrtable *table, enum hmgrentry_type t,
+				struct d3dkmthandle h)
+{
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	hmgrtable_free_handle(table, t, h);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+}
+
+struct d3dkmthandle hmgrtable_build_entry_handle(struct hmgrtable *table,
+						 u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+
+	return build_handle(index, table->entry_table[index].unique,
+			    table->entry_table[index].instance);
+}
+
+void *hmgrtable_get_object(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return NULL;
+
+	return table->entry_table[get_index(h)].object;
+}
+
+void *hmgrtable_get_object_by_type(struct hmgrtable *table,
+				   enum hmgrentry_type type,
+				   struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, type)) {
+		pr_err("%s invalid handle %x\n", __func__, h.v);
+		return NULL;
+	}
+	return table->entry_table[get_index(h)].object;
+}
+
+void *hmgrtable_get_entry_object(struct hmgrtable *table, u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+	DXGKRNL_ASSERT(table->entry_table[index].type != HMGRENTRY_TYPE_FREE);
+
+	return table->entry_table[index].object;
+}
+
+static enum hmgrentry_type hmgrtable_get_entry_type(struct hmgrtable *table,
+						    u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+	return (enum hmgrentry_type)table->entry_table[index].type;
+}
+
+enum hmgrentry_type hmgrtable_get_object_type(struct hmgrtable *table,
+					      struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return HMGRENTRY_TYPE_FREE;
+
+	return hmgrtable_get_entry_type(table, get_index(h));
+}
+
+void *hmgrtable_get_object_ignore_destroyed(struct hmgrtable *table,
+					    struct d3dkmthandle h,
+					    enum hmgrentry_type type)
+{
+	if (!is_handle_valid(table, h, true, type))
+		return NULL;
+	return table->entry_table[get_index(h)].object;
+}
+
+bool hmgrtable_next_entry(struct hmgrtable *tbl,
+			  u32 *index,
+			  enum hmgrentry_type *type,
+			  struct d3dkmthandle *handle,
+			  void **object)
+{
+	u32 i;
+	struct hmgrentry *entry;
+
+	for (i = *index; i < tbl->table_size; i++) {
+		entry = &tbl->entry_table[i];
+		if (entry->type != HMGRENTRY_TYPE_FREE) {
+			*index = i + 1;
+			*object = entry->object;
+			*handle = build_handle(i, entry->unique,
+					       entry->instance);
+			*type = entry->type;
+			return true;
+		}
+	}
+	return false;
+}
diff --git a/drivers/hv/dxgkrnl/hmgr.h b/drivers/hv/dxgkrnl/hmgr.h
new file mode 100644
index 000000000000..9ce4f536bf29
--- /dev/null
+++ b/drivers/hv/dxgkrnl/hmgr.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Handle manager definitions
+ *
+ */
+
+#ifndef _HMGR_H_
+#define _HMGR_H_
+
+#include "misc.h"
+
+struct hmgrentry;
+
+/*
+ * Handle manager table.
+ *
+ * Implementation notes:
+ *   A list of free handles is built on top of the array of table entries.
+ *   free_handle_list_head is the index of the first entry in the list.
+ *   m_FreeHandleListTail is the index of an entry in the list, which is
+ *   HMGRTABLE_MIN_FREE_ENTRIES from the head. It means that when a handle is
+ *   freed, the next time the handle can be re-used is after allocating
+ *   HMGRTABLE_MIN_FREE_ENTRIES number of handles.
+ *   Handles are allocated from the start of the list and free handles are
+ *   inserted after the tail of the list.
+ *
+ */
+struct hmgrtable {
+	struct dxgprocess	*process;
+	struct hmgrentry	*entry_table;
+	u32			free_handle_list_head;
+	u32			free_handle_list_tail;
+	u32			table_size;
+	u32			free_count;
+	struct rw_semaphore	table_lock;
+};
+
+/*
+ * Handle entry data types.
+ */
+#define HMGRENTRY_TYPE_BITS 5
+
+enum hmgrentry_type {
+	HMGRENTRY_TYPE_FREE				= 0,
+	HMGRENTRY_TYPE_DXGADAPTER			= 1,
+	HMGRENTRY_TYPE_DXGSHAREDRESOURCE		= 2,
+	HMGRENTRY_TYPE_DXGDEVICE			= 3,
+	HMGRENTRY_TYPE_DXGRESOURCE			= 4,
+	HMGRENTRY_TYPE_DXGALLOCATION			= 5,
+	HMGRENTRY_TYPE_DXGOVERLAY			= 6,
+	HMGRENTRY_TYPE_DXGCONTEXT			= 7,
+	HMGRENTRY_TYPE_DXGSYNCOBJECT			= 8,
+	HMGRENTRY_TYPE_DXGKEYEDMUTEX			= 9,
+	HMGRENTRY_TYPE_DXGPAGINGQUEUE			= 10,
+	HMGRENTRY_TYPE_DXGDEVICESYNCOBJECT		= 11,
+	HMGRENTRY_TYPE_DXGPROCESS			= 12,
+	HMGRENTRY_TYPE_DXGSHAREDVMOBJECT		= 13,
+	HMGRENTRY_TYPE_DXGPROTECTEDSESSION		= 14,
+	HMGRENTRY_TYPE_DXGHWQUEUE			= 15,
+	HMGRENTRY_TYPE_DXGREMOTEBUNDLEOBJECT		= 16,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEOBJECT	= 17,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEPROXY	= 18,
+	HMGRENTRY_TYPE_DXGTRACKEDWORKLOAD		= 19,
+	HMGRENTRY_TYPE_LIMIT		= ((1 << HMGRENTRY_TYPE_BITS) - 1),
+	HMGRENTRY_TYPE_MONITOREDFENCE	= HMGRENTRY_TYPE_LIMIT + 1,
+};
+
+void hmgrtable_init(struct hmgrtable *tbl, struct dxgprocess *process);
+void hmgrtable_destroy(struct hmgrtable *tbl);
+void hmgrtable_lock(struct hmgrtable *tbl, enum dxglockstate state);
+void hmgrtable_unlock(struct hmgrtable *tbl, enum dxglockstate state);
+struct d3dkmthandle hmgrtable_alloc_handle(struct hmgrtable *tbl, void *object,
+				     enum hmgrentry_type t, bool make_valid);
+struct d3dkmthandle hmgrtable_alloc_handle_safe(struct hmgrtable *tbl,
+						void *obj,
+						enum hmgrentry_type t,
+						bool reserve);
+int hmgrtable_assign_handle(struct hmgrtable *tbl, void *obj,
+			    enum hmgrentry_type, struct d3dkmthandle h);
+int hmgrtable_assign_handle_safe(struct hmgrtable *tbl, void *obj,
+				 enum hmgrentry_type t, struct d3dkmthandle h);
+void hmgrtable_free_handle(struct hmgrtable *tbl, enum hmgrentry_type t,
+			   struct d3dkmthandle h);
+void hmgrtable_free_handle_safe(struct hmgrtable *tbl, enum hmgrentry_type t,
+				struct d3dkmthandle h);
+struct d3dkmthandle hmgrtable_build_entry_handle(struct hmgrtable *tbl,
+						 u32 index);
+enum hmgrentry_type hmgrtable_get_object_type(struct hmgrtable *tbl,
+					      struct d3dkmthandle h);
+void *hmgrtable_get_object(struct hmgrtable *tbl, struct d3dkmthandle h);
+void *hmgrtable_get_object_by_type(struct hmgrtable *tbl, enum hmgrentry_type t,
+				   struct d3dkmthandle h);
+void *hmgrtable_get_object_ignore_destroyed(struct hmgrtable *tbl,
+					    struct d3dkmthandle h,
+					    enum hmgrentry_type t);
+bool hmgrtable_mark_destroyed(struct hmgrtable *tbl, struct d3dkmthandle h);
+bool hmgrtable_unmark_destroyed(struct hmgrtable *tbl, struct d3dkmthandle h);
+void *hmgrtable_get_entry_object(struct hmgrtable *tbl, u32 index);
+bool hmgrtable_next_entry(struct hmgrtable *tbl,
+			  u32 *start_index,
+			  enum hmgrentry_type *type,
+			  struct d3dkmthandle *handle,
+			  void **object);
+
+#endif
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 277e25e5d8c6..fa7fc321addb 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -22,3 +22,73 @@
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"dxgk: " fmt
+
+struct ioctl_desc {
+	int (*ioctl_callback)(struct dxgprocess *p, void __user *arg);
+	u32 ioctl;
+	u32 arg_size;
+};
+static struct ioctl_desc ioctls[LX_IO_MAX + 1];
+
+static char *errorstr(int ret)
+{
+	return ret < 0 ? "err" : "";
+}
+
+/*
+ * IOCTL processing
+ * The driver IOCTLs return
+ * - 0 in case of success
+ * - positive values, which are Windows NTSTATUS (for example, STATUS_PENDING).
+ *   Positive values are success codes.
+ * - Linux negative error codes
+ */
+static int dxgk_ioctl(struct file *f, unsigned int p1, unsigned long p2)
+{
+	int code = _IOC_NR(p1);
+	int status;
+	struct dxgprocess *process;
+
+	if (code < 1 || code > LX_IO_MAX) {
+		pr_err("bad ioctl %x %x %x %x",
+			   code, _IOC_TYPE(p1), _IOC_SIZE(p1), _IOC_DIR(p1));
+		return -ENOTTY;
+	}
+	if (ioctls[code].ioctl_callback == NULL) {
+		pr_err("ioctl callback is NULL %x", code);
+		return -ENOTTY;
+	}
+	if (ioctls[code].ioctl != p1) {
+		pr_err("ioctl mismatch. Code: %x User: %x Kernel: %x",
+			   code, p1, ioctls[code].ioctl);
+		return -ENOTTY;
+	}
+	process = (struct dxgprocess *)f->private_data;
+	if (process->tgid != current->tgid) {
+		pr_err("Call from a wrong process: %d %d",
+			   process->tgid, current->tgid);
+		return -ENOTTY;
+	}
+	status = ioctls[code].ioctl_callback(process, (void *__user)p2);
+	return status;
+}
+
+long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2)
+{
+	pr_debug("  compat ioctl %x", p1);
+	return dxgk_ioctl(f, p1, p2);
+}
+
+long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2)
+{
+	pr_debug("   unlocked ioctl %x Code:%d", p1, _IOC_NR(p1));
+	return dxgk_ioctl(f, p1, p2);
+}
+
+#define SET_IOCTL(callback, v)				\
+	ioctls[_IOC_NR(v)].ioctl_callback = callback;	\
+	ioctls[_IOC_NR(v)].ioctl = v
+
+void init_ioctls(void)
+{
+}
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 1ff0c0e28332..433b59d3eb23 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -31,7 +31,6 @@ extern const struct d3dkmthandle zerohandle;
  * table_lock
  * core_lock
  * device_lock
- * process->process_mutex
  * adapter_list_lock
  * device_mutex
  */
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 2b9ed954a520..7e2c520abf5f 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -54,4 +54,6 @@ struct winluid {
 	__u32 b;
 };
 
+#define LX_IO_MAX 0x45
+
 #endif /* _D3DKMTHK_H */
-- 
2.35.1

