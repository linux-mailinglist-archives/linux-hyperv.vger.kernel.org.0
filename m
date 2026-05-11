Return-Path: <linux-hyperv+bounces-10759-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK+wDYYKAmqknQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10759-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 18:57:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9014512CD0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E74931CF160
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB243636F;
	Mon, 11 May 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rRaMCxER"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B242DFEA;
	Mon, 11 May 2026 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516679; cv=none; b=SbXSi+sf9YhxfWO8VaQPs0YayLEUdMquPf+WX6Fp1m47dZwUJwiHYcC05rUDSgxiTWNDLJlqoQVCcJB38XLz6oVLfsPGWPD3o4a55L23S6GCL+lspnukBTdxDx4lq20mTKIZG4TsxJ2/y5v76ZInS2igTsSlqcFuiLcHQTqXDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516679; c=relaxed/simple;
	bh=G80ldcDStJWyidKCH3MjV5K4lu3Wp/Q7JaaBMXNCWZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPwAF3qu2XdqU/d7dZ3fhgvZrgsqE8e2CpfS0G8ckT58kkQetRvYhs+OZD4YKPo5jMd4sLAfgNjvOebEJN/6/h/2LkBNSzddIS/MD2vdlnwRD5EmlczBk4zhOfa6LmlUu3iF18LjVjBxUH0gWew8nnzX9fKX52f0MpzSkjxHfOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rRaMCxER; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7582120B7166;
	Mon, 11 May 2026 09:24:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7582120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778516675;
	bh=HFzTSaQ70veIfvuNDaz8Hy1Vs/v2M6n0NU+oyEGbXT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRaMCxERGgqBHv0De4Z7eVTwbUpQznx8jHtzbE0N9WBswZhY3kjMDitss9lksuUba
	 Ut0ciGpYy1kPhET2vuz7gBS1upW0sExBRaPfQ6q89e1kn0zCR/3Tug+vrPHzFTxTSK
	 unVbiLewWGHRuzRu5T/eMAkBLO6YmKhfqOqBxVWk=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com
Subject: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush support
Date: Tue, 12 May 2026 00:24:08 +0800
Message-ID: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9014512CD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-10759-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
This hypercall accepts a list of (page_number, page_mask_shift) entries,
enabling finer-grained IOTLB invalidation compared to the domain-wide
HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().

hv_iommu_fill_iova_list() decomposes a contiguous IOVA range into a
minimal set of aligned power-of-two regions that fit in a single
hypercall input page. When the range exceeds the page capacity, the
code falls back to a full domain flush automatically.

Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 drivers/iommu/hyperv/iommu.c | 91 +++++++++++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h  |  1 +
 include/hyperv/hvhdk_mini.h  | 17 +++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
index e5fc625314b5..3bca362b7815 100644
--- a/drivers/iommu/hyperv/iommu.c
+++ b/drivers/iommu/hyperv/iommu.c
@@ -486,10 +486,98 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	hv_flush_device_domain(to_hv_iommu_domain(domain));
 }
 
+/* Max number of iova_list entries in a single hypercall input page. */
+#define HV_IOMMU_MAX_FLUSH_VA_COUNT \
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_flush_device_domain_list)) / \
+	 sizeof(union hv_iommu_flush_va))
+
+/* Returned by hv_iommu_fill_iova_list() when the range exceeds the capacity */
+#define HV_IOMMU_FLUSH_VA_OVERFLOW	U16_MAX
+
+static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
+					  unsigned long start,
+					  unsigned long end)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
+	unsigned long nr_pages = end_pfn - start_pfn;
+	u16 count = 0;
+
+	while (nr_pages > 0) {
+		unsigned long flush_pages;
+		int order;
+		unsigned long pfn_align;
+		unsigned long size_align;
+
+		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
+			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
+			break;
+		}
+
+		if (start_pfn)
+			pfn_align = __ffs(start_pfn);
+		else
+			pfn_align = BITS_PER_LONG - 1;
+
+		size_align = __fls(nr_pages);
+		order = min(pfn_align, size_align);
+		iova_list[count].page_mask_shift = order;
+		iova_list[count].page_number = start_pfn;
+
+		flush_pages = 1UL << order;
+		start_pfn += flush_pages;
+		nr_pages -= flush_pages;
+		count++;
+	}
+
+	return count;
+}
+
+static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domain,
+					struct iommu_iotlb_gather *iotlb_gather)
+{
+	u64 status;
+	u16 count;
+	unsigned long flags;
+	struct hv_input_flush_device_domain_list *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = hv_domain->device_domain;
+	input->flags |= HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
+	count = hv_iommu_fill_iova_list(input->iova_list,
+					iotlb_gather->start,
+					iotlb_gather->end);
+	if (count == HV_IOMMU_FLUSH_VA_OVERFLOW) {
+		/*
+		 * Range exceeds hypercall page capacity. Fall back to a full
+		 * domain flush.
+		 */
+		struct hv_input_flush_device_domain *flush_all = (void *)input;
+
+		memset(flush_all, 0, sizeof(*flush_all));
+		flush_all->device_domain = hv_domain->device_domain;
+		status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
+					flush_all, NULL);
+	} else {
+		status = hv_do_rep_hypercall(
+				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
+				count, 0, input, NULL);
+	}
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", status);
+}
+
 static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *iotlb_gather)
 {
-	hv_flush_device_domain(to_hv_iommu_domain(domain));
+	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
 
 	iommu_put_pages_list(&iotlb_gather->freelist);
 }
@@ -543,6 +631,7 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 
 	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
 
 	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 5bdbb44da112..eaaf87171478 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -496,6 +496,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
 #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
 #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
+#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 493608e791b4..f51d5d9467f1 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -671,4 +671,21 @@ struct hv_input_flush_device_domain {
 	u32 reserved;
 } __packed;
 
+union hv_iommu_flush_va {
+	u64 iova;
+	struct {
+		u64 page_mask_shift : 12;
+		u64 page_number : 52;
+	};
+} __packed;
+
+
+struct hv_input_flush_device_domain_list {
+	struct hv_input_device_domain device_domain;
+#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT (1 << 0)
+	u32 flags;
+	u32 reserved;
+	union hv_iommu_flush_va iova_list[];
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.52.0


