Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512B730736
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jun 2023 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbjFNSPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbjFNSPV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 14:15:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39EAF2702;
        Wed, 14 Jun 2023 11:15:17 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BB73620FEB21;
        Wed, 14 Jun 2023 11:15:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB73620FEB21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686766516;
        bh=PXFIoG+nMGRU8BVdvMfua9+xN5p1PstUh7i6Mtnxwi0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aXtD476EwBMiWeRFuwpGw7l3+fkbGJL5A9gKqelERT2JsgvCMSzymH/Uk5Y3ogok9
         Z/cIILBfU4xh0cHKURL4liF9P9j4PMdgMZJaIVuqsBDF9bjE9opmmn/GTbfLFu8SJy
         s8gLvHc1WrLDJurSAjvJ/p6elJvn19pQa2Mb5Pe8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Date:   Wed, 14 Jun 2023 11:15:09 -0700
Message-Id: <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Common userspace interface for read/write from VMBus ringbuffer.
This implementation is open for use by any userspace driver or
application seeking direct control over VMBus ring buffers.
A significant  part of this code is borrowed from DPDK.
Link: https://github.com/DPDK/dpdk/

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]
- simpler sysfs path, less parsing

 tools/hv/vmbus_bufring.c | 322 +++++++++++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.h | 158 +++++++++++++++++++
 2 files changed, 480 insertions(+)
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
new file mode 100644
index 000000000000..d44a06d45b03
--- /dev/null
+++ b/tools/hv/vmbus_bufring.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
+ * Copyright (c) 2012 NetApp Inc.
+ * Copyright (c) 2012 Citrix Inc.
+ * All rights reserved.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <emmintrin.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/uio.h>
+#include <unistd.h>
+#include "vmbus_bufring.h"
+
+#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
+
+#define	rte_smp_rwmb()		({ asm volatile ("" : : : "memory"); })
+
+#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
+#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((align) - 1)))))
+
+void *vmbus_uio_map(char *sys_ring_buf_path, int size)
+{
+	void *map;
+	int fd;
+
+	fd = open(sys_ring_buf_path, O_RDWR);
+	if (fd < 0)
+		return NULL;
+
+	map = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	close(fd);
+	if (map == MAP_FAILED)
+		return NULL;
+
+	return map;
+}
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
+	br->dsize = blen - sizeof(struct vmbus_bufring);
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
+	uint8_t *br_data = tbr->vbr->data;
+	uint32_t br_dsize = tbr->dsize;
+	const uint8_t *src = src0;
+
+	/* XXX use double mapping like Linux kernel? */
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
+	rte_smp_rwmb();
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
+	pkt.hdr.xactid = VMBUS_RQST_ERROR;
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
+	const uint8_t *br_data = rbr->vbr->data;
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
index 000000000000..9c82822587a4
--- /dev/null
+++ b/tools/hv/vmbus_bufring.h
@@ -0,0 +1,158 @@
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
+	/* Pad it to rte_mem_page_size() so that data starts on page boundary */
+	uint8_t	reserved2[4028];
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
+void *vmbus_uio_map(char *sys_ring_buf_path, int size);
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

