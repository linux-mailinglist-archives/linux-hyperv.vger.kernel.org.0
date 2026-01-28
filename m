Return-Path: <linux-hyperv+bounces-8567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLKUIMVTemnk5AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8567-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 19:21:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CBA7B58
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAB33007C97
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EC330641;
	Wed, 28 Jan 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jbBpzHuC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BA212F98;
	Wed, 28 Jan 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623909; cv=none; b=mBpqVwB511mMB1CuOXKaaJbJV58LHDBN/e4GcRzU9K77lhVvCDm1X/vhmiALQmt0TSz86bRRPeaL/kcnzI7ysKaI2aqOVnqhtWo1pgDtCNWTCVM+ZVlSsY39akYiBDdO1JwR9/s5tCmgMHPzLH8imWZ787zXiSoGNGaDEH+hAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623909; c=relaxed/simple;
	bh=Ammg5xkt22af/IRdK1mTCbt+YsCki8ypDeFLlhDxRXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ym4+eheL+vqXrY7XDCj28EEwl9xbKakcCk9K2mcCVOOkdjB0ByFb5xdTRi4Zi91wEdLm9HXhb+vDxdxOWEuUMc7c3/j1G7njM/+5uX4ZlpWLk2u7lgT+MQkz+Ha+Bd1ee3h6+b9aVRVwiHFd2wW5XgU0f1ZtGY43earh8MQSM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jbBpzHuC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id D086620B7165; Wed, 28 Jan 2026 10:11:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D086620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769623907;
	bh=1UyaT1G76cRZkQR0hLY9kvb5qfe9T2OJS3VOkTL96N8=;
	h=From:To:Cc:Subject:Date:From;
	b=jbBpzHuCsk0CN22Z9lWfJoNVaT+0s4gp5qSgCYHkXi5Dz37QnswZyFMdUnn7vWXGf
	 Sz4lwxzspHlbYPGsw8QeEMShwSLyDVm/9jFJ5Vu3z07ZokDGjGLVMTlSscXioRe78U
	 Zpa/3htwnK9A9ULKlzIuVxikUVQ65JjtU5C8+ZS8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v6 0/7] mshv: Debugfs interface for mshv_root
Date: Wed, 28 Jan 2026 10:11:39 -0800
Message-ID: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8567-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E49CBA7B58
X-Rspamd-Action: no action

Expose hypervisor, logical processor, partition, and virtual processor
statistics via debugfs. These are provided by mapping 'stats' pages via
hypercall.

Patch #1: Update hv_call_map_stats_page() to return success when
          HV_STATS_AREA_PARENT is unavailable, which is the case on some
          hypervisor versions, where it can fall back to HV_STATS_AREA_SELF
Patch #2: Use struct hv_stats_page pointers instead of void *
Patch #3: Make mshv_vp_stats_map/unmap() more flexible to use with debugfs
          code
Patch #4: Always map vp stats page regardless of scheduler, to reuse in
          debugfs
Patch #5: Change to hv_stats_page definition and
          VpRootDispatchThreadBlocked
Patch #6: Introduce the definitions needed for the various stats pages
Patch #7: Add mshv_debugfs.c, and integrate it with the mshv_root driver to
          expose the partition and VP stats.

---
Changes in v6:
- Fix whitespace and other checkpatch issues [Michael]

Changes in v5:
- Rename hv_counters.c to mshv_debugfs_counters.c [Michael]
- Clarify unusual inclusion of mshv_debugfs_counters.c with comment. After
  discussion it is still included directly to keep things simple. Including
  arrays with unspecified size via a header means sizeof() cannot be used on
  the array.
- Error if mshv_debugfs_counters.c is included elsewhere than mshv_debugfs.c
- Use array index as stats page index to save space [Stanislav]
- Enforce HV_STATS_AREA_PARENT and SELF fit in NUM_STATS_AREAS with
  static_assert and clarify with comment [Michael]
- Return to using lp count from hv stats page for mshv_lps_count [Michael]
- Use nr_cpu_ids instead of num_possible_cpus() [Michael]
- Set mshv_lps_stats[idx] and the array itself to NULL on unmap and cleanup
  [Michael]
- Rename HvLogicalProcessors and VpRootDispatchThreadBlocked to Linux style
- Translate Linux cpu index to vp index via hv_vp_index on partition destroy
  [Michael]
- Minor formatting cleanups [Michael]

Changes in v4:
- Put the counters definitions in static arrays in hv_counters.c, instead of
  as enums in hvhdk.h [Michael]
- Due to the above, add an additional patch (#5) to simplify hv_stats_page,
  and retain the enum definition at the top of mshv_root_main.c for use with
  VpRootDispatchThreadBlocked. That is the only remaining use of the counter
  enum.
- Due to the above, use num_present_cpus() as the number of LPs to map stats
  pages for - this number shouldn't change at runtime because the hypervisor
  doesn't support hotplug for root partition.

Changes in v3:
- Add 3 small refactor/cleanup patches (patches 2,3,4) from Stanislav. These
  simplify some of the debugfs code, and fix issues with mapping VP stats on
  L1VH.
- Fix cleanup of parent stats dentries on module removal (via squashing some
  internal patches into patch #6) [Praveen]
- Remove unused goto label [Stanislav, kernel bot]
- Use struct hv_stats_page * instead of void * in mshv_debugfs.c [Stanislav]
- Remove some redundant variables [Stanislav]
- Rename debugfs dentry fields for brevity [Stanislav]
- Use ERR_CAST() for the dentry error pointer returned from
  lp_debugfs_stats_create() [Stanislav]
- Fix leak of pages allocated for lp stats mappings by storing them in an array
  [Michael]
- Add comments to clarify PARENT vs SELF usage and edge cases [Michael]
- Add VpLoadAvg for x86 and print the stat [Michael]
- Add NUM_STATS_AREAS for array sizing in mshv_debugfs.c [Michael]

Changes in v2:
- Remove unnecessary pr_debug_once() in patch 1 [Stanislav Kinsburskii]
- CONFIG_X86 -> CONFIG_X86_64 in patch 2 [Stanislav Kinsburskii]

---
Nuno Das Neves (3):
  mshv: Update hv_stats_page definitions
  mshv: Add data for printing stats page counters
  mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
  mshv: Ignore second stats page map result failure

Stanislav Kinsburskii (3):
  mshv: Use typed hv_stats_page pointers
  mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
  mshv: Always map child vp stats pages regardless of scheduler type

 drivers/hv/Makefile                |   1 +
 drivers/hv/mshv_debugfs.c          | 726 +++++++++++++++++++++++++++++
 drivers/hv/mshv_debugfs_counters.c | 490 +++++++++++++++++++
 drivers/hv/mshv_root.h             |  49 +-
 drivers/hv/mshv_root_hv_call.c     |  64 ++-
 drivers/hv/mshv_root_main.c        | 140 +++---
 include/hyperv/hvhdk.h             |   7 +
 7 files changed, 1412 insertions(+), 65 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c
 create mode 100644 drivers/hv/mshv_debugfs_counters.c

-- 
2.34.1


