Return-Path: <linux-hyperv+bounces-1794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEAF880FDB
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 11:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B43285217
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6B41C86;
	Wed, 20 Mar 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lbArSbCF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2093D566;
	Wed, 20 Mar 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930590; cv=none; b=OtYKWbXDSi+G3f5SksbooaZDMn0SUAPRzyJmvJCu6KW4mSh6tDgK0YrwqPPeK2weuiSupgSY0wCob03Sze8oemPRvDZOh82M0+mOi7rCuB/VhNxSSpZGJqMS8M+l23E7vuZBdieIp3OvTAK0m0iSvajvL3/2uoTi32ITL3W8V0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930590; c=relaxed/simple;
	bh=30W57Q+L+Chd0BNd+6ikkPUXa+EpVPPH/Y2emP0OEHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W31AdbbfPk0Uqv4xxxUxBbXnzhGTE1n61WM10kFsPWHrh3p4rTKKHJ3FI4+ZgS/hHfBGmnl0yfMlc1g3VBCYxeucRoEVsz2f5keqtXuuFmVxX2/ENWY/S3g1Ww7WTPjzUu+KTgqAFWxS1of4oLVFaqg50dZ1n2BVbEEJ6xckaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lbArSbCF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57CF820B74C4;
	Wed, 20 Mar 2024 03:29:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57CF820B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710930588;
	bh=WSXodZ857+ELOMvwRqg0aiApsFMLBcapSBEd144DiBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbArSbCFz0JNvUKA1ZhUW28YsXYce8Xn5lys9Lm/7+0FJ++U2QmPYlhRMSWru3jbz
	 aO85qMdA6sWLPxC6oDxT1wZhiUcQiwgDbPxeVwC/tzOvch2s+msgeesioPKg+cTODF
	 v5PijYW0Gh+IQK/f2gIrGEHhGlYzgI0PYcg387AM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: longli@microsoft.com,
	ssengar@microsoft.com
Subject: [PATCH v2 4/7] tools: hv: Add vmbus_bufring
Date: Wed, 20 Mar 2024 03:29:41 -0700
Message-Id: <1710930584-31180-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Common userspace interface for read/write from VMBus ringbuffer.
This implementation is open for use by any userspace driver or
application seeking direct control over VMBus ring buffers.
A significant  part of this code is borrowed from DPDK.
Link: https://github.com/DPDK/dpdk/

Signed-off-by: Mary Hardy <maryhardy@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
[V2]
- Removed need_sign arg from vmbus_txbr_write
- Removed rte_smp_rwmb as its duplicate of rte_compiler_barrier
- Added more comment for rte_compiler_barrierx
- Added Reviewed-by form Long Li

 tools/hv/vmbus_bufring.c | 318 +++++++++++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.h | 158 +++++++++++++++++++
 2 files changed, 476 insertions(+)
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
new file mode 100644
index 000000000000..bac32c1109df
--- /dev/null
+++ b/tools/hv/vmbus_bufring.c
@@ -0,0 +1,318 @@
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
+/**
+ * Compiler barrier.
+ *
+ * Guarantees that operation reordering does not occur at compile time
+ * for operations directly before and after the barrier.
+ */
+#define	rte_compiler_barrier()		({ asm volatile ("" : : : "memory"); })
+
+#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
+#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((align) - 1)))))
+
+void *vmbus_uio_map(int *fd, int size)
+{
+	void *map;
+
+	map = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE, MAP_SHARED, *fd, 0);
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
+vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen)
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
+	error = vmbus_txbr_write(txbr, iov, 3);
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
index 000000000000..6e7caacfff57
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
+void *vmbus_uio_map(int *fd, int size);
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


