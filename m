Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9376FACB
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjHDHKK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 03:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjHDHKH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 03:10:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D52F30C4;
        Fri,  4 Aug 2023 00:10:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28C88207F5BE;
        Fri,  4 Aug 2023 00:10:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28C88207F5BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691133000;
        bh=eXrRvT0/8si3mNUBNc/nZ2OsNSNamh0jMMAVHtD6iWY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LJwvTBlLq6A4PbXjtmGTk0qppNQjq1Gv5oZdCWzYcrWWNq72Ql81zGRWEUwUcmRPW
         ICb4pAbHtnjO5g8LRxA7FAUs7r3xQ/rVyPYJ9kuy3h6jIX846S2Zj9g060pKlvS8fr
         UaRRIg18rbSu0ei8wBKMY0PrgE2Xij62mPP7tkaM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] tools: hv: Add new fcopy application based on uio driver
Date:   Fri,  4 Aug 2023 00:09:56 -0700
Message-Id: <1691132996-11706-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement the file copy service for Linux guests on Hyper-V. This
permits the host to copy a file (over VMBus) into the guest. This
facility is part of "guest integration services" supported on the
Hyper-V platform.

Here is a link that provides additional details on this functionality:

http://technet.microsoft.com/en-us/library/dn464282.aspx

This new fcopy application uses uio_hv_vmbus_client driver which
makes the earlier hv_util based driver and application obsolete.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V4]
- Add error check for setting ring_size value in sysfs entry
- Add error handling in fcopy_get_instance_id for instance id not found case

[V3]
- Improve cover commit messages
- Improve debug prints
- Instead of hardcoded instance id, query from class id sysfs
- Set the ring_size value from application
- Update the application to mmap /dev/uio instead of sysfs
- new application compilation dependent on x86

[V2]
- simpler sysfs path

 tools/hv/Build                 |   1 +
 tools/hv/Makefile              |  10 +-
 tools/hv/hv_fcopy_uio_daemon.c | 587 +++++++++++++++++++++++++++++++++
 3 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c

diff --git a/tools/hv/Build b/tools/hv/Build
index 2a667d3d94cb..efcbb74a0d23 100644
--- a/tools/hv/Build
+++ b/tools/hv/Build
@@ -2,3 +2,4 @@ hv_kvp_daemon-y += hv_kvp_daemon.o
 hv_vss_daemon-y += hv_vss_daemon.o
 hv_fcopy_daemon-y += hv_fcopy_daemon.o
 vmbus_bufring-y += vmbus_bufring.o
+hv_fcopy_uio_daemon-y += hv_fcopy_uio_daemon.o
diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 33cf488fd20f..678c6c450a53 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -21,8 +21,10 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ifeq ($(SRCARCH),x86)
 ALL_LIBS := libvmbus_bufring.a
-endif
+ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon hv_fcopy_uio_daemon
+else
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
+endif
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst %,$(OUTPUT)%,$(ALL_LIBS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
@@ -56,6 +58,12 @@ $(HV_FCOPY_DAEMON_IN): FORCE
 $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
+HV_FCOPY_UIO_DAEMON_IN := $(OUTPUT)hv_fcopy_uio_daemon-in.o
+$(HV_FCOPY_UIO_DAEMON_IN): FORCE
+	$(Q)$(MAKE) $(build)=hv_fcopy_uio_daemon
+$(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN) libvmbus_bufring.a
+	$(QUIET_LINK)$(CC) -lm $< -L. -lvmbus_bufring -o $@
+
 clean:
 	rm -f $(ALL_PROGRAMS)
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
new file mode 100644
index 000000000000..b35737082c91
--- /dev/null
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * An implementation of host to guest copy functionality for Linux.
+ *
+ * Copyright (C) 2023, Microsoft, Inc.
+ *
+ * Author : K. Y. Srinivasan <kys@microsoft.com>
+ * Author : Saurabh Sengar <ssengar@microsoft.com>
+ *
+ */
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <locale.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <linux/hyperv.h>
+#include "vmbus_bufring.h"
+
+#define ICMSGTYPE_NEGOTIATE	0
+#define ICMSGTYPE_FCOPY		7
+
+#define WIN8_SRV_MAJOR		1
+#define WIN8_SRV_MINOR		1
+#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
+
+#define MAX_PATH_LEN		300
+#define MAX_LINE_LEN		40
+#define DEVICES_SYSFS		"/sys/bus/vmbus/devices"
+#define FCOPY_CLASS_ID		"34d14be3-dee4-41c8-9ae7-6b174977c192"
+
+#define FCOPY_VER_COUNT		1
+static const int fcopy_versions[] = {
+	WIN8_SRV_VERSION
+};
+
+#define FW_VER_COUNT		1
+static const int fw_versions[] = {
+	UTIL_FW_VERSION
+};
+
+#define HV_RING_SIZE		(4 * 4096)
+
+unsigned char desc[HV_RING_SIZE];
+
+static int target_fd;
+static char target_fname[PATH_MAX];
+static unsigned long long filesize;
+
+static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
+{
+	int error = HV_E_FAIL;
+	char *q, *p;
+
+	filesize = 0;
+	p = (char *)path_name;
+	snprintf(target_fname, sizeof(target_fname), "%s/%s",
+		 (char *)path_name, (char *)file_name);
+
+	/*
+	 * Check to see if the path is already in place; if not,
+	 * create if required.
+	 */
+	while ((q = strchr(p, '/')) != NULL) {
+		if (q == p) {
+			p++;
+			continue;
+		}
+		*q = '\0';
+		if (access(path_name, F_OK)) {
+			if (flags & CREATE_PATH) {
+				if (mkdir(path_name, 0755)) {
+					syslog(LOG_ERR, "Failed to create %s",
+					       path_name);
+					goto done;
+				}
+			} else {
+				syslog(LOG_ERR, "Invalid path: %s", path_name);
+				goto done;
+			}
+		}
+		p = q + 1;
+		*q = '/';
+	}
+
+	if (!access(target_fname, F_OK)) {
+		syslog(LOG_INFO, "File: %s exists", target_fname);
+		if (!(flags & OVER_WRITE)) {
+			error = HV_ERROR_ALREADY_EXISTS;
+			goto done;
+		}
+	}
+
+	target_fd = open(target_fname,
+			 O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0744);
+	if (target_fd == -1) {
+		syslog(LOG_INFO, "Open Failed: %s", strerror(errno));
+		goto done;
+	}
+
+	error = 0;
+done:
+	if (error)
+		target_fname[0] = '\0';
+	return error;
+}
+
+static int hv_copy_data(struct hv_do_fcopy *cpmsg)
+{
+	ssize_t bytes_written;
+	int ret = 0;
+
+	bytes_written = pwrite(target_fd, cpmsg->data, cpmsg->size,
+			       cpmsg->offset);
+
+	filesize += cpmsg->size;
+	if (bytes_written != cpmsg->size) {
+		switch (errno) {
+		case ENOSPC:
+			ret = HV_ERROR_DISK_FULL;
+			break;
+		default:
+			ret = HV_E_FAIL;
+			break;
+		}
+		syslog(LOG_ERR, "pwrite failed to write %llu bytes: %ld (%s)",
+		       filesize, (long)bytes_written, strerror(errno));
+	}
+
+	return ret;
+}
+
+/*
+ * Reset target_fname to "" in the two below functions for hibernation: if
+ * the fcopy operation is aborted by hibernation, the daemon should remove the
+ * partially-copied file; to achieve this, the hv_utils driver always fakes a
+ * CANCEL_FCOPY message upon suspend, and later when the VM resumes back,
+ * the daemon calls hv_copy_cancel() to remove the file; if a file is copied
+ * successfully before suspend, hv_copy_finished() must reset target_fname to
+ * avoid that the file can be incorrectly removed upon resume, since the faked
+ * CANCEL_FCOPY message is spurious in this case.
+ */
+static int hv_copy_finished(void)
+{
+	close(target_fd);
+	target_fname[0] = '\0';
+	return 0;
+}
+
+static void print_usage(char *argv[])
+{
+	fprintf(stderr, "Usage: %s [options]\n"
+		"Options are:\n"
+		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
+		"  -h, --help             print this help\n", argv[0]);
+}
+
+static bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, unsigned char *buf,
+				      unsigned int buflen, const int *fw_version, int fw_vercnt,
+				const int *srv_version, int srv_vercnt,
+				int *nego_fw_version, int *nego_srv_version)
+{
+	int icframe_major, icframe_minor;
+	int icmsg_major, icmsg_minor;
+	int fw_major, fw_minor;
+	int srv_major, srv_minor;
+	int i, j;
+	bool found_match = false;
+	struct icmsg_negotiate *negop;
+
+	/* Check that there's enough space for icframe_vercnt, icmsg_vercnt */
+	if (buflen < ICMSG_HDR + offsetof(struct icmsg_negotiate, reserved)) {
+		syslog(LOG_ERR, "Invalid icmsg negotiate");
+		return false;
+	}
+
+	icmsghdrp->icmsgsize = 0x10;
+	negop = (struct icmsg_negotiate *)&buf[ICMSG_HDR];
+
+	icframe_major = negop->icframe_vercnt;
+	icframe_minor = 0;
+
+	icmsg_major = negop->icmsg_vercnt;
+	icmsg_minor = 0;
+
+	/* Validate negop packet */
+	if (icframe_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    icmsg_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    ICMSG_NEGOTIATE_PKT_SIZE(icframe_major, icmsg_major) > buflen) {
+		syslog(LOG_ERR, "Invalid icmsg negotiate - icframe_major: %u, icmsg_major: %u\n",
+		       icframe_major, icmsg_major);
+		goto fw_error;
+	}
+
+	/*
+	 * Select the framework version number we will
+	 * support.
+	 */
+
+	for (i = 0; i < fw_vercnt; i++) {
+		fw_major = (fw_version[i] >> 16);
+		fw_minor = (fw_version[i] & 0xFFFF);
+
+		for (j = 0; j < negop->icframe_vercnt; j++) {
+			if (negop->icversion_data[j].major == fw_major &&
+			    negop->icversion_data[j].minor == fw_minor) {
+				icframe_major = negop->icversion_data[j].major;
+				icframe_minor = negop->icversion_data[j].minor;
+				found_match = true;
+				break;
+			}
+		}
+
+		if (found_match)
+			break;
+	}
+
+	if (!found_match)
+		goto fw_error;
+
+	found_match = false;
+
+	for (i = 0; i < srv_vercnt; i++) {
+		srv_major = (srv_version[i] >> 16);
+		srv_minor = (srv_version[i] & 0xFFFF);
+
+		for (j = negop->icframe_vercnt;
+			(j < negop->icframe_vercnt + negop->icmsg_vercnt);
+			j++) {
+			if (negop->icversion_data[j].major == srv_major &&
+			    negop->icversion_data[j].minor == srv_minor) {
+				icmsg_major = negop->icversion_data[j].major;
+				icmsg_minor = negop->icversion_data[j].minor;
+				found_match = true;
+				break;
+			}
+		}
+
+		if (found_match)
+			break;
+	}
+
+	/*
+	 * Respond with the framework and service
+	 * version numbers we can support.
+	 */
+fw_error:
+	if (!found_match) {
+		negop->icframe_vercnt = 0;
+		negop->icmsg_vercnt = 0;
+	} else {
+		negop->icframe_vercnt = 1;
+		negop->icmsg_vercnt = 1;
+	}
+
+	if (nego_fw_version)
+		*nego_fw_version = (icframe_major << 16) | icframe_minor;
+
+	if (nego_srv_version)
+		*nego_srv_version = (icmsg_major << 16) | icmsg_minor;
+
+	negop->icversion_data[0].major = icframe_major;
+	negop->icversion_data[0].minor = icframe_minor;
+	negop->icversion_data[1].major = icmsg_major;
+	negop->icversion_data[1].minor = icmsg_minor;
+
+	return found_match;
+}
+
+static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
+{
+	size_t len = 0;
+
+	while (len < dest_size) {
+		if (src[len] < 0x80)
+			dest[len++] = (char)(*src++);
+		else
+			dest[len++] = 'X';
+	}
+
+	dest[len] = '\0';
+}
+
+static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
+{
+	setlocale(LC_ALL, "en_US.utf8");
+	size_t file_size, path_size;
+	char *file_name, *path_name;
+	char *in_file_name = (char *)smsg_in->file_name;
+	char *in_path_name = (char *)smsg_in->path_name;
+
+	file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
+	path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
+
+	file_name = (char *)malloc(file_size * sizeof(char));
+	path_name = (char *)malloc(path_size * sizeof(char));
+
+	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
+	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
+
+	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
+}
+
+static int hv_fcopy_send_data(struct hv_fcopy_hdr *fcopy_msg, int recvlen)
+{
+	int operation = fcopy_msg->operation;
+
+	/*
+	 * The  strings sent from the host are encoded in
+	 * utf16; convert it to utf8 strings.
+	 * The host assures us that the utf16 strings will not exceed
+	 * the max lengths specified. We will however, reserve room
+	 * for the string terminating character - in the utf16s_utf8s()
+	 * function we limit the size of the buffer where the converted
+	 * string is placed to W_MAX_PATH -1 to guarantee
+	 * that the strings can be properly terminated!
+	 */
+
+	switch (operation) {
+	case START_FILE_COPY:
+		return hv_fcopy_start((struct hv_start_fcopy *)fcopy_msg);
+	case WRITE_TO_FILE:
+		return hv_copy_data((struct hv_do_fcopy *)fcopy_msg);
+	case COMPLETE_FCOPY:
+		return hv_copy_finished();
+	}
+
+	return HV_E_FAIL;
+}
+
+/* process the packet recv from host */
+static int fcopy_pkt_process(struct vmbus_br *txbr)
+{
+	int ret, offset, pktlen;
+	int fcopy_srv_version;
+	const struct vmbus_chanpkt_hdr *pkt;
+	struct hv_fcopy_hdr *fcopy_msg;
+	struct icmsg_hdr *icmsghdr;
+
+	pkt = (const struct vmbus_chanpkt_hdr *)desc;
+	offset = pkt->hlen << 3;
+	pktlen = (pkt->tlen << 3) - offset;
+	icmsghdr = (struct icmsg_hdr *)&desc[offset + sizeof(struct vmbuspipe_hdr)];
+	icmsghdr->status = HV_E_FAIL;
+
+	if (icmsghdr->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+		if (vmbus_prep_negotiate_resp(icmsghdr, desc + offset, pktlen, fw_versions,
+					      FW_VER_COUNT, fcopy_versions, FCOPY_VER_COUNT,
+					      NULL, &fcopy_srv_version)) {
+			syslog(LOG_INFO, "FCopy IC version %d.%d",
+			       fcopy_srv_version >> 16, fcopy_srv_version & 0xFFFF);
+			icmsghdr->status = 0;
+		}
+	} else if (icmsghdr->icmsgtype == ICMSGTYPE_FCOPY) {
+		/* Ensure recvlen is big enough to contain hv_fcopy_hdr */
+		if (pktlen < ICMSG_HDR + sizeof(struct hv_fcopy_hdr)) {
+			syslog(LOG_ERR, "Invalid Fcopy hdr. Packet length too small: %u",
+			       pktlen);
+			return -ENOBUFS;
+		}
+
+		fcopy_msg = (struct hv_fcopy_hdr *)&desc[offset + ICMSG_HDR];
+		icmsghdr->status = hv_fcopy_send_data(fcopy_msg, pktlen);
+	}
+
+	icmsghdr->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
+	ret = rte_vmbus_chan_send(txbr, 0x6, desc + offset, pktlen, 0);
+	if (ret) {
+		syslog(LOG_ERR, "Write to ringbuffer failed err: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void fcopy_get_first_folder(char *path, char *chan_no)
+{
+	DIR *dir = opendir(path);
+	struct dirent *entry;
+
+	if (!dir) {
+		syslog(LOG_ERR, "Failed to open directory (errno=%s).\n", strerror(errno));
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 &&
+		    strcmp(entry->d_name, "..") != 0) {
+			strcpy(chan_no, entry->d_name);
+			break;
+		}
+	}
+
+	closedir(dir);
+}
+
+static void fcopy_set_ring_size(char *path, char *inst, int size)
+{
+	char ring_size_path[MAX_PATH_LEN] = {0};
+	FILE *fd;
+
+	snprintf(ring_size_path, sizeof(ring_size_path), "%s/%s/%s", path, inst, "ring_size");
+	fd = fopen(ring_size_path, "w");
+	if (!fd) {
+		syslog(LOG_WARNING, "Failed to open ring_size file (errno=%s).\n", strerror(errno));
+		return;
+	}
+
+	setvbuf(fd, NULL, _IONBF, 0); /* don't allow buffering to catch sysfs store error */
+	if (fprintf(fd, "%d", size) < 0)
+		syslog(LOG_WARNING, "Failed to set %d as ring size (errno=%s).\n",
+		       size, strerror(errno));
+
+	fclose(fd);
+}
+
+static char *fcopy_read_sysfs(char *path, char *buf, int len)
+{
+	FILE *fd;
+	char *ret;
+
+	fd = fopen(path, "r");
+	if (!fd)
+		return NULL;
+
+	ret = fgets(buf, len, fd);
+	fclose(fd);
+
+	return ret;
+}
+
+static int fcopy_get_instance_id(char *path, char *class_id, char *inst)
+{
+	DIR *dir = opendir(path);
+	struct dirent *entry;
+	char tmp_path[MAX_PATH_LEN] = {0};
+	char line[MAX_LINE_LEN];
+	int ret = -EINVAL;
+
+	if (!dir) {
+		syslog(LOG_ERR, "Failed to open directory (errno=%s).", strerror(errno));
+		return ret;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_type == DT_LNK && strcmp(entry->d_name, ".") != 0 &&
+		    strcmp(entry->d_name, "..") != 0) {
+			/* search for the sysfs path with matching class_id */
+			snprintf(tmp_path, sizeof(tmp_path), "%s/%s/%s",
+				 path, entry->d_name, "class_id");
+			if (!fcopy_read_sysfs(tmp_path, line, MAX_LINE_LEN))
+				continue;
+
+			/* class id matches, now fetch the instance id from device_id */
+			if (strstr(line, class_id)) {
+				snprintf(tmp_path, sizeof(tmp_path), "%s/%s/%s",
+					 path, entry->d_name, "device_id");
+				if (!fcopy_read_sysfs(tmp_path, line, MAX_LINE_LEN))
+					continue;
+				/* remove braces */
+				strncpy(inst, line + 1, strlen(line) - 3);
+				ret = 0;
+				goto closedir;
+			}
+		}
+	}
+
+	syslog(LOG_ERR, "Failed to fetch instance id");
+closedir:
+	closedir(dir);
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	int fcopy_fd = -1, tmp = 1;
+	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
+	struct vmbus_br txbr, rxbr;
+	void *ring;
+	uint32_t len = HV_RING_SIZE;
+	char uio_name[10] = {0};
+	char uio_dev_path[15] = {0};
+	char uio_path[MAX_PATH_LEN] = {0};
+	char inst[MAX_LINE_LEN] = {0};
+
+	static struct option long_options[] = {
+		{"help",	no_argument,	   0,  'h' },
+		{"no-daemon",	no_argument,	   0,  'n' },
+		{0,		0,		   0,  0   }
+	};
+
+	while ((opt = getopt_long(argc, argv, "hn", long_options,
+				  &long_index)) != -1) {
+		switch (opt) {
+		case 'n':
+			daemonize = 0;
+			break;
+		case 'h':
+		default:
+			print_usage(argv);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (daemonize && daemon(1, 0)) {
+		syslog(LOG_ERR, "daemon() failed; error: %s", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	openlog("HV_UIO_FCOPY", 0, LOG_USER);
+	syslog(LOG_INFO, "starting; pid is:%d", getpid());
+
+	/* get instance id */
+	if (fcopy_get_instance_id(DEVICES_SYSFS, FCOPY_CLASS_ID, inst))
+		exit(EXIT_FAILURE);
+
+	/* set ring_size value */
+	fcopy_set_ring_size(DEVICES_SYSFS, inst, HV_RING_SIZE);
+
+	/* get /dev/uioX dev path and open it */
+	snprintf(uio_path, sizeof(uio_path), "%s/%s/%s", DEVICES_SYSFS, inst, "uio");
+	fcopy_get_first_folder(uio_path, uio_name);
+	snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
+	fcopy_fd = open(uio_dev_path, O_RDWR);
+
+	if (fcopy_fd < 0) {
+		syslog(LOG_ERR, "open %s failed; error: %d %s",
+		       uio_dev_path, errno, strerror(errno));
+		syslog(LOG_ERR, "Please make sure module uio_hv_vmbus_client is loaded and" \
+		       " device is not used by any other application\n");
+		ret = fcopy_fd;
+		exit(EXIT_FAILURE);
+	}
+
+	ring = mmap(NULL, 2 * HV_RING_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fcopy_fd, 0);
+	if (ring == MAP_FAILED) {
+		ret = errno;
+		syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret, strerror(ret));
+		goto close;
+	}
+	vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
+	vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
+
+	while (1) {
+		/*
+		 * In this loop we process fcopy messages after the
+		 * handshake is complete.
+		 */
+		ret = pread(fcopy_fd, &tmp, sizeof(int), 0);
+		if (ret < 0) {
+			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
+			continue;
+		}
+
+		len = HV_RING_SIZE;
+		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
+		if (unlikely(ret <= 0)) {
+			/* This indicates a failure to communicate (or worse) */
+			syslog(LOG_ERR, "VMBus channel recv error: %d", ret);
+		} else {
+			ret = fcopy_pkt_process(&txbr);
+			if (ret < 0)
+				goto close;
+
+			/* Signal host */
+			tmp = 1;
+			if ((write(fcopy_fd, &tmp, sizeof(int))) != sizeof(int)) {
+				ret = errno;
+				syslog(LOG_ERR, "Registration failed: %s\n", strerror(ret));
+				goto close;
+			}
+		}
+	}
+close:
+	close(fcopy_fd);
+	return ret;
+}
-- 
2.34.1

