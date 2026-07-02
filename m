Return-Path: <linux-hyperv+bounces-11795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4R/MEV7lRWq/GQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11795-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:13:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D66F3624
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:13:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11795-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11795-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE293012D1A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092834F498;
	Thu,  2 Jul 2026 04:13:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C22E0901;
	Thu,  2 Jul 2026 04:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965595; cv=none; b=SJv4yN0Fw8xIIJ66uHxA1zjkzwpLbpr11Ejz3EeT9uZBO+qrt/5Ql7FbRwTezXCRfIaTgmexRK0gXjb6qJk9RnllN1IIUoAEzrKvB8JDV8lJtzKYn4uhtcZ7+zDLEmUYHH9gg/kv5Ya7CjwHUiwbMWUTXMw9R/bpIKWRaIIxZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965595; c=relaxed/simple;
	bh=gZPjvKr3IxnQ6hiSUc3ilImgoP+GuC2xkdc+CgjbSWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFnk5cW6ouFj6lBWVq4CSffzb2BaLnpLxa2XS5/aOCJDmQ5NVV4RV52I/bh+Fb3czZncd0SM+1svtUAkZShzoLir9dMPuhMIwVlzvAYw6+RGbE9oIvAuYqyjcO60vrKcqGVi6Rs7MV5vbhZz6c9KRbJtvP7rDVoigxXg8jgFCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id ED9F320B7169; Wed,  1 Jul 2026 21:13:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED9F320B7169
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kees@kernel.org,
	jacob.e.keller@intel.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net v3 0/2] Fix MANA RX with bounce buffering
Date: Wed,  1 Jul 2026 21:12:35 -0700
Message-ID: <20260702041237.617719-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11795-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888D66F3624

With swiotlb=force, the MANA NIC fails to work properly due to commit
730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead
of full pages to improve memory efficiency.").

This happens because, with the standard MTU=1500, the aforementioned
commit uses page pool frags with PP_FLAG_DMA_MAP, but fails to call
page_pool_dma_sync_for_cpu() to sync the received packet for CPU acces
before handing the RX buffer to the stack.

Here patch #2 adds the required page_pool_dma_sync_for_cpu().

Patch #1 validates the packet length reported by the NIC. With patch #2,
page_pool_dma_sync_for_cpu() uses the packet length, so we don't want
to blindly trust the packet length, just in case.

There is no change between v2 and v3.
v3 just swaps the order of the 2 patches in v2, as suggested by Simon [3].

Please review.

Thanks,
Dexuan

References:
[1] v1: https://lore.kernel.org/netdev/20260618035029.249361-1-decui@microsoft.com/
[2] v2: https://lore.kernel.org/netdev/20260624222605.1794719-1-decui@microsoft.com/
[3] https://lore.kernel.org/netdev/20260626145048.GB1310988@horms.kernel.org/

Dexuan Cui (2):
  net: mana: Validate the packet length reported by the NIC
  net: mana: Sync page pool RX frags for CPU

 drivers/net/ethernet/microsoft/mana/mana_en.c | 61 +++++++++++++++----
 include/net/mana/mana.h                       |  8 +++
 2 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.34.1


