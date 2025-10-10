Return-Path: <linux-hyperv+bounces-7180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B5BCEA4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5334E106E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390F303C8F;
	Fri, 10 Oct 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h9u6tM4l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD58263F5F;
	Fri, 10 Oct 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133355; cv=none; b=fMVaEFkE5eYrxUuXS1HLYkBNueS2xT4Vfk+ZpTYYTcK6sY1cA3O71LepTPL4xrkn4c83CLi0ajGQnGdS/+qTHRdErvWfFCZATLMkMaBW8UFSdA6Et9e8Px93Aw1P0n2SbDnkTh4RUECts3WulNRqU1dgj9doYvtqzzd/yxbh+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133355; c=relaxed/simple;
	bh=5AC20Bjxz1v3crm1w1XHlypDtTmuWyQ6XqabcFF1ZJs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Mokni+w7oPiawsdJsRNdMf6tGAkbjZAFHUENP7jmrsxC9w0/LYzmW3UvoSArW0/SurUiBgi7CwMnXNOoq6WMKOswdINzUWCJEoAHWO2QBDa4KLssvJ+fMYCte1RjESfS1zu0xFtosmPOetZAb9mQUHry8zYqxT+RxHGDdSUpnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h9u6tM4l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id E1BED2038B64; Fri, 10 Oct 2025 14:55:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1BED2038B64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760133353;
	bh=o8kpEu2efKVIZLiRBqy6vLQxFhgI/J5FpYYsj9/woTs=;
	h=From:To:Cc:Subject:Date:From;
	b=h9u6tM4lmZ5A6ZeAMQTAqqJH+HF7DgwvFF2SzMmW7BUk395CnFk7rM+oAqi36hCpj
	 cvpFo8KYRjTcK5xom10RZU0YYz8D5Fs6I1b2HMFsUGD8EUF8hKkHtDIraycm+CsxT5
	 +7O5tAY4zrUKF1MPBaKI41NBJOPutVbKYnoJTU7E=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v5 0/5] mshv: Fixes for stats and vp state page mappings
Date: Fri, 10 Oct 2025 14:55:46 -0700
Message-Id: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

There are some differences in how L1VH partitions must map stats and vp
state pages, some of which are due to differences across hypervisor
versions. Detect and handle these cases.

Patch 1:
Fix for the logic of when to map the vp stats page for the root scheduler.

Patch 2-3:
Add HVCALL_GET_PARTITION_PROPERTY_EX and use it to query "vmm capabilities" on
module init.

Patches 4-5:
Check a feature bit in vmm capabilities, to take a new code path for mapping
stats and vp state pages. In this case, the stats and vp state pages must be
allocated by Linux, and a new hypercall HVCALL_MAP_VP_STATS_PAGE2 must be used
to map the stats page.

---
v5:
- Fix an uninitialized reserved field in hypercall input [Michael]
- Minor improvements to performance and robustness [Michael]

v4:
- Fixed some __packed attributes on unions [Stanislav]
- Cleaned up mshv_init_vmm_caps() [Stanislav]
- Cleaned up loop in hv_call_map_stats_page2() [Stanislav]

v3:
https://lore.kernel.org/linux-hyperv/1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
- Fix bug in patch 4, in mshv_partition_ioctl_create_vp() cleanup path
  [kernel test robot]
- Make hv_unmap_vp_state_page() use struct page to match hv_map_vp_state_page()
- Remove SELF == PARENT check which doesn't belong in patch 5 [Easwar]

v2:
https://lore.kernel.org/linux-hyperv/1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
- Remove patch falling back to SELF page if PARENT mapping fails [Easwar]
  (To be included in a future series)
- Fix formatting of function definitions [Easwar]
  - Fix some wording in commit messages [Praveen]
    - Proceed with driver init even if getting vmm capabilities fails [Anirudh]

v1:
https://lore.kernel.org/linux-hyperv/1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t

---
Jinank Jain (2):
  mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
  mshv: Introduce new hypercall to map stats page for L1VH partitions

Nuno Das Neves (1):
  mshv: Only map vp->vp_stats_pages if on root scheduler

Purna Pavan Chandra Aekkaladevi (2):
  mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
  mshv: Get the vmm capabilities offered by the hypervisor

 drivers/hv/mshv_root.h         |  24 +++--
 drivers/hv/mshv_root_hv_call.c | 190 +++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_main.c    | 128 +++++++++++++---------
 include/hyperv/hvgdk_mini.h    |   2 +
 include/hyperv/hvhdk.h         |  40 +++++++
 include/hyperv/hvhdk_mini.h    |  33 ++++++
 6 files changed, 343 insertions(+), 74 deletions(-)

-- 
2.34.1


