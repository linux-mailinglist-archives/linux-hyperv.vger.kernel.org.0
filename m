Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127B47537FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jul 2023 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjGNKZ4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jul 2023 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjGNKZz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jul 2023 06:25:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 893BF273B;
        Fri, 14 Jul 2023 03:25:52 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1421621C467D;
        Fri, 14 Jul 2023 03:25:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1421621C467D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689330352;
        bh=t3GtJjcOIBfxDE+W651xwxvQJl6oxFvMK7Bv6EPFN2s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dB9VBUs9v9snk8cw3PiXzilkvTEEclrP3E5dbkCxT+F7kzc72nAj8hnAX01QSYfsa
         9FiCkL2DqjXcUsDXpHKlSdoP+PH3urRFvu2beubmX57iS9tUAYQLpp1NO/tjKscAD6
         3Pfgq7GGEArz+U20ncNdA8OxAebpfTD+ZeOgur5s=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
Date:   Fri, 14 Jul 2023 03:25:45 -0700
Message-Id: <1689330346-5374-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Provide a userspace interface for userspace drivers or applications to
read/write a VMBus ringbuffer. A significant part of this code is
borrowed from DPDK[1]. Current library is supported exclusively for
the x86 architecture.

To build this library:
make -C tools/hv libvmbus_bufring.a

Applications using this library can include the vmbus_bufring.h header
file and libvmbus_bufring.a statically.

[1] https://github.com/DPDK/dpdk/

Signed-off-by: Mary Hardy <maryhardy@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V3]
- Made ring buffer data offset depend on page size
- remove rte_smp_rwmb macro and reused rte_compiler_barrier instead
- Added legal counsel sign-off
- Removed "Link:" tag 
- Improve commit messages
- new library compilation dependent on x86
- simplify mmap

[V2]
- simpler sysfs path, less parsing

 tools/hv/Build           |   1 +
 tools/hv/Makefile        |  13 +-
 tools/hv/vmbus_bufring.c | 297 +++++++++++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.h | 154 ++++++++++++++++++++
 4 files changed, 464 insertions(+), 1 deletion(-)
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

diff --git a/tools/hv/Build b/tools/hv/Build
index 6cf51fa4b306..2a667d3d94cb 100644
--- a/tools/hv/Build
+++ b/tools/hv/Build
@@ -1,3 +1,4 @@
 hv_kvp_daemon-y += hv_kvp_daemon.o
 hv_vss_daemon-y += hv_vss_daemon.o
 hv_fcopy_daemon-y += hv_fcopy_daemon.o
+vmbus_bufring-y += vmbus_bufring.o
diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index fe770e679ae8..33cf488fd20f 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -11,14 +11,19 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
+include $(srctree)/tools/scripts/Makefile.arch
+
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
+ifeq ($(SRCARCH),x86)
+ALL_LIBS := libvmbus_bufring.a
+endif
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
-ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst %,$(OUTPUT)%,$(ALL_LIBS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
 
@@ -27,6 +32,12 @@ all: $(ALL_PROGRAMS)
 export srctree OUTPUT CC LD CFLAGS
 include $(srctree)/tools/build/Makefile.include
 
+HV_VMBUS_BUFRING_IN := $(OUTPUT)vmbus_bufring.o
+$(HV_VMBUS_BUFRING_IN): FORCE
+	$(Q)$(MAKE) $(build)=vmbus_bufring
+$(OUTPUT)libvmbus_bufring.a : vmbus_bufring.o
+	$(AR) rcs $@ $^
+
 HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
 $(HV_KVP_DAEMON_IN): FORCE
 	$(Q)$(MAKE) $(build)=hv_kvp_daemon
diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
new file mode 100644
index 000000000000..fb1f0489c625
--- /dev/null
+++ b/tools/hv/vmbus_bufring.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
+ * Copyright (c) 2012 NetApp Inc.
+ * Copyright (c) 2012 Citrix Inc.
+ * All rights reserved.
+ */
+
+#include <errno.h>
+#include <emmintrin.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/uio.h>
+#include "vmbus_bufring.h"
+
+#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
+#define RINGDATA_START_OFFSET	(getpagesize())
+#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
+#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((align) - 1)))))
+
+/* Increase bufring index by inc with wraparound */
+static inline uint32_t vmbus_br_idxinc(uint32_t idx, uint32_t inc, uint32_t sz)
+{
+	idx += inc;
+	if (idx >= sz)
+		idx -= sz;
+
+	return idx;
+}
+
+void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
+{
+	br->vbr = buf;
+	br->windex = br->vbr->windex;
+	br->dsize = blen - RINGDATA_START_OFFSET;
+}
+
+static inline __always_inline void
+rte_smp_mb(void)
+{
+	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
+}
+
+static inline int
+rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
+{
+	uint8_t res;
+
+	asm volatile("lock ; "
+		     "cmpxchgl %[src], %[dst];"
+		     "sete %[res];"
+		     : [res] "=a" (res),     /* output */
+		     [dst] "=m" (*dst)
+		     : [src] "r" (src),      /* input */
+		     "a" (exp),
+		     "m" (*dst)
+		     : "memory");            /* no-clobber list */
+	return res;
+}
+
+static inline uint32_t
+vmbus_txbr_copyto(const struct vmbus_br *tbr, uint32_t windex,
+		  const void *src0, uint32_t cplen)
+{
+	uint8_t *br_data = (uint8_t *)tbr->vbr + RINGDATA_START_OFFSET;
+	uint32_t br_dsize = tbr->dsize;
+	const uint8_t *src = src0;
+
+	if (cplen > br_dsize - windex) {
+		uint32_t fraglen = br_dsize - windex;
+
+		/* Wrap-around detected */
+		memcpy(br_data + windex, src, fraglen);
+		memcpy(br_data, src + fraglen, cplen - fraglen);
+	} else {
+		memcpy(br_data + windex, src, cplen);
+	}
+
+	return vmbus_br_idxinc(windex, cplen, br_dsize);
+}
+
+/*
+ * Write scattered channel packet to TX bufring.
+ *
+ * The offset of this channel packet is written as a 64bits value
+ * immediately after this channel packet.
+ *
+ * The write goes through three stages:
+ *  1. Reserve space in ring buffer for the new data.
+ *     Writer atomically moves priv_write_index.
+ *  2. Copy the new data into the ring.
+ *  3. Update the tail of the ring (visible to host) that indicates
+ *     next read location. Writer updates write_index
+ */
+static int
+vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
+		 bool *need_sig)
+{
+	struct vmbus_bufring *vbr = tbr->vbr;
+	uint32_t ring_size = tbr->dsize;
+	uint32_t old_windex, next_windex, windex, total;
+	uint64_t save_windex;
+	int i;
+
+	total = 0;
+	for (i = 0; i < iovlen; i++)
+		total += iov[i].iov_len;
+	total += sizeof(save_windex);
+
+	/* Reserve space in ring */
+	do {
+		uint32_t avail;
+
+		/* Get current free location */
+		old_windex = tbr->windex;
+
+		/* Prevent compiler reordering this with calculation */
+		rte_compiler_barrier();
+
+		avail = vmbus_br_availwrite(tbr, old_windex);
+
+		/* If not enough space in ring, then tell caller. */
+		if (avail <= total)
+			return -EAGAIN;
+
+		next_windex = vmbus_br_idxinc(old_windex, total, ring_size);
+
+		/* Atomic update of next write_index for other threads */
+	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex, next_windex));
+
+	/* Space from old..new is now reserved */
+	windex = old_windex;
+	for (i = 0; i < iovlen; i++)
+		windex = vmbus_txbr_copyto(tbr, windex, iov[i].iov_base, iov[i].iov_len);
+
+	/* Set the offset of the current channel packet. */
+	save_windex = ((uint64_t)old_windex) << 32;
+	windex = vmbus_txbr_copyto(tbr, windex, &save_windex,
+				   sizeof(save_windex));
+
+	/* The region reserved should match region used */
+	if (windex != next_windex)
+		return -EINVAL;
+
+	/* Ensure that data is available before updating host index */
+	rte_compiler_barrier();
+
+	/* Checkin for our reservation. wait for our turn to update host */
+	while (!rte_atomic32_cmpset(&vbr->windex, old_windex, next_windex))
+		_mm_pause();
+
+	return 0;
+}
+
+int rte_vmbus_chan_send(struct vmbus_br *txbr, uint16_t type, void *data,
+			uint32_t dlen, uint32_t flags)
+{
+	struct vmbus_chanpkt pkt;
+	unsigned int pktlen, pad_pktlen;
+	const uint32_t hlen = sizeof(pkt);
+	bool send_evt = false;
+	uint64_t pad = 0;
+	struct iovec iov[3];
+	int error;
+
+	pktlen = hlen + dlen;
+	pad_pktlen = ALIGN(pktlen, sizeof(uint64_t));
+
+	pkt.hdr.type = type;
+	pkt.hdr.flags = flags;
+	pkt.hdr.hlen = hlen >> VMBUS_CHANPKT_SIZE_SHIFT;
+	pkt.hdr.tlen = pad_pktlen >> VMBUS_CHANPKT_SIZE_SHIFT;
+	pkt.hdr.xactid = VMBUS_RQST_ERROR; /* doesn't support multiple requests at same time */
+
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = hlen;
+	iov[1].iov_base = data;
+	iov[1].iov_len = dlen;
+	iov[2].iov_base = &pad;
+	iov[2].iov_len = pad_pktlen - pktlen;
+
+	error = vmbus_txbr_write(txbr, iov, 3, &send_evt);
+
+	return error;
+}
+
+static inline uint32_t
+vmbus_rxbr_copyfrom(const struct vmbus_br *rbr, uint32_t rindex,
+		    void *dst0, size_t cplen)
+{
+	const uint8_t *br_data = (uint8_t *)rbr->vbr + RINGDATA_START_OFFSET;
+	uint32_t br_dsize = rbr->dsize;
+	uint8_t *dst = dst0;
+
+	if (cplen > br_dsize - rindex) {
+		uint32_t fraglen = br_dsize - rindex;
+
+		/* Wrap-around detected. */
+		memcpy(dst, br_data + rindex, fraglen);
+		memcpy(dst + fraglen, br_data, cplen - fraglen);
+	} else {
+		memcpy(dst, br_data + rindex, cplen);
+	}
+
+	return vmbus_br_idxinc(rindex, cplen, br_dsize);
+}
+
+/* Copy data from receive ring but don't change index */
+static int
+vmbus_rxbr_peek(const struct vmbus_br *rbr, void *data, size_t dlen)
+{
+	uint32_t avail;
+
+	/*
+	 * The requested data and the 64bits channel packet
+	 * offset should be there at least.
+	 */
+	avail = vmbus_br_availread(rbr);
+	if (avail < dlen + sizeof(uint64_t))
+		return -EAGAIN;
+
+	vmbus_rxbr_copyfrom(rbr, rbr->vbr->rindex, data, dlen);
+	return 0;
+}
+
+/*
+ * Copy data from receive ring and change index
+ * NOTE:
+ * We assume (dlen + skip) == sizeof(channel packet).
+ */
+static int
+vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t skip)
+{
+	struct vmbus_bufring *vbr = rbr->vbr;
+	uint32_t br_dsize = rbr->dsize;
+	uint32_t rindex;
+
+	if (vmbus_br_availread(rbr) < dlen + skip + sizeof(uint64_t))
+		return -EAGAIN;
+
+	/* Record where host was when we started read (for debug) */
+	rbr->windex = rbr->vbr->windex;
+
+	/*
+	 * Copy channel packet from RX bufring.
+	 */
+	rindex = vmbus_br_idxinc(rbr->vbr->rindex, skip, br_dsize);
+	rindex = vmbus_rxbr_copyfrom(rbr, rindex, data, dlen);
+
+	/*
+	 * Discard this channel packet's 64bits offset, which is useless to us.
+	 */
+	rindex = vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
+
+	/* Update the read index _after_ the channel packet is fetched.	 */
+	rte_compiler_barrier();
+
+	vbr->rindex = rindex;
+
+	return 0;
+}
+
+int rte_vmbus_chan_recv_raw(struct vmbus_br *rxbr,
+			    void *data, uint32_t *len)
+{
+	struct vmbus_chanpkt_hdr pkt;
+	uint32_t dlen, bufferlen = *len;
+	int error;
+
+	error = vmbus_rxbr_peek(rxbr, &pkt, sizeof(pkt));
+	if (error)
+		return error;
+
+	if (unlikely(pkt.hlen < VMBUS_CHANPKT_HLEN_MIN))
+		/* XXX this channel is dead actually. */
+		return -EIO;
+
+	if (unlikely(pkt.hlen > pkt.tlen))
+		return -EIO;
+
+	/* Length are in quad words */
+	dlen = pkt.tlen << VMBUS_CHANPKT_SIZE_SHIFT;
+	*len = dlen;
+
+	/* If caller buffer is not large enough */
+	if (unlikely(dlen > bufferlen))
+		return -ENOBUFS;
+
+	/* Read data and skip packet header */
+	error = vmbus_rxbr_read(rxbr, data, dlen, 0);
+	if (error)
+		return error;
+
+	/* Return the number of bytes read */
+	return dlen + sizeof(uint64_t);
+}
diff --git a/tools/hv/vmbus_bufring.h b/tools/hv/vmbus_bufring.h
new file mode 100644
index 000000000000..45ecc48e517f
--- /dev/null
+++ b/tools/hv/vmbus_bufring.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+
+#ifndef _VMBUS_BUF_H_
+#define _VMBUS_BUF_H_
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#define __packed   __attribute__((__packed__))
+#define unlikely(x)	__builtin_expect(!!(x), 0)
+
+#define ICMSGHDRFLAG_TRANSACTION	1
+#define ICMSGHDRFLAG_REQUEST		2
+#define ICMSGHDRFLAG_RESPONSE		4
+
+#define IC_VERSION_NEGOTIATION_MAX_VER_COUNT 100
+#define ICMSG_HDR (sizeof(struct vmbuspipe_hdr) + sizeof(struct icmsg_hdr))
+#define ICMSG_NEGOTIATE_PKT_SIZE(icframe_vercnt, icmsg_vercnt) \
+	(ICMSG_HDR + sizeof(struct icmsg_negotiate) + \
+	 (((icframe_vercnt) + (icmsg_vercnt)) * sizeof(struct ic_version)))
+
+/*
+ * Channel packets
+ */
+
+/* Channel packet flags */
+#define VMBUS_CHANPKT_TYPE_INBAND	0x0006
+#define VMBUS_CHANPKT_TYPE_RXBUF	0x0007
+#define VMBUS_CHANPKT_TYPE_GPA		0x0009
+#define VMBUS_CHANPKT_TYPE_COMP		0x000b
+
+#define VMBUS_CHANPKT_FLAG_NONE		0
+#define VMBUS_CHANPKT_FLAG_RC		0x0001  /* report completion */
+
+#define VMBUS_CHANPKT_SIZE_SHIFT	3
+#define VMBUS_CHANPKT_SIZE_ALIGN	BIT(VMBUS_CHANPKT_SIZE_SHIFT)
+#define VMBUS_CHANPKT_HLEN_MIN		\
+	(sizeof(struct vmbus_chanpkt_hdr) >> VMBUS_CHANPKT_SIZE_SHIFT)
+
+/*
+ * Buffer ring
+ */
+struct vmbus_bufring {
+	volatile uint32_t windex;
+	volatile uint32_t rindex;
+
+	/*
+	 * Interrupt mask {0,1}
+	 *
+	 * For TX bufring, host set this to 1, when it is processing
+	 * the TX bufring, so that we can safely skip the TX event
+	 * notification to host.
+	 *
+	 * For RX bufring, once this is set to 1 by us, host will not
+	 * further dispatch interrupts to us, even if there are data
+	 * pending on the RX bufring.  This effectively disables the
+	 * interrupt of the channel to which this RX bufring is attached.
+	 */
+	volatile uint32_t imask;
+
+	/*
+	 * Win8 uses some of the reserved bits to implement
+	 * interrupt driven flow management. On the send side
+	 * we can request that the receiver interrupt the sender
+	 * when the ring transitions from being full to being able
+	 * to handle a message of size "pending_send_sz".
+	 *
+	 * Add necessary state for this enhancement.
+	 */
+	volatile uint32_t pending_send;
+	uint32_t reserved1[12];
+
+	union {
+		struct {
+			uint32_t feat_pending_send_sz:1;
+		};
+		uint32_t value;
+	} feature_bits;
+
+	/*
+	 * Ring data starts here + RingDataStartOffset
+	 * !!! DO NOT place any fields below this !!!
+	 */
+	uint8_t data[];
+} __packed;
+
+struct vmbus_br {
+	struct vmbus_bufring *vbr;
+	uint32_t	dsize;
+	uint32_t	windex; /* next available location */
+};
+
+struct vmbus_chanpkt_hdr {
+	uint16_t	type;	/* VMBUS_CHANPKT_TYPE_ */
+	uint16_t	hlen;	/* header len, in 8 bytes */
+	uint16_t	tlen;	/* total len, in 8 bytes */
+	uint16_t	flags;	/* VMBUS_CHANPKT_FLAG_ */
+	uint64_t	xactid;
+} __packed;
+
+struct vmbus_chanpkt {
+	struct vmbus_chanpkt_hdr hdr;
+} __packed;
+
+struct vmbuspipe_hdr {
+	unsigned int flags;
+	unsigned int msgsize;
+} __packed;
+
+struct ic_version {
+	unsigned short major;
+	unsigned short minor;
+} __packed;
+
+struct icmsg_negotiate {
+	unsigned short icframe_vercnt;
+	unsigned short icmsg_vercnt;
+	unsigned int reserved;
+	struct ic_version icversion_data[]; /* any size array */
+} __packed;
+
+struct icmsg_hdr {
+	struct ic_version icverframe;
+	unsigned short icmsgtype;
+	struct ic_version icvermsg;
+	unsigned short icmsgsize;
+	unsigned int status;
+	unsigned char ictransaction_id;
+	unsigned char icflags;
+	unsigned char reserved[2];
+} __packed;
+
+int rte_vmbus_chan_recv_raw(struct vmbus_br *rxbr, void *data, uint32_t *len);
+int rte_vmbus_chan_send(struct vmbus_br *txbr, uint16_t type, void *data,
+			uint32_t dlen, uint32_t flags);
+void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen);
+
+/* Amount of space available for write */
+static inline uint32_t vmbus_br_availwrite(const struct vmbus_br *br, uint32_t windex)
+{
+	uint32_t rindex = br->vbr->rindex;
+
+	if (windex >= rindex)
+		return br->dsize - (windex - rindex);
+	else
+		return rindex - windex;
+}
+
+static inline uint32_t vmbus_br_availread(const struct vmbus_br *br)
+{
+	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
+}
+
+#endif	/* !_VMBUS_BUF_H_ */
-- 
2.34.1

