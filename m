Return-Path: <linux-hyperv+bounces-11937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2fyyIDbDUWqeIQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11937-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:14:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EC740410
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:14:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=IMFui4qN;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11937-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11937-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45F1301BF58
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB52798EA;
	Sat, 11 Jul 2026 04:14:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3472D0C89;
	Sat, 11 Jul 2026 04:14:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743283; cv=none; b=qk+qq55XOkfhSTxobobOx3sV0fQSMEVy9qxpuW9I4KVI1jEpAVW4+R73Xgx0k6pTWSnF50fxWL9smjkbDdc2GyUI7SHftLADCcwEs1ymgJ5+/C9Fc6F5c7l13y/+XkddgwZXq935okSVZegNkrR+Nzry7ENWATWLchmrMEdNsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743283; c=relaxed/simple;
	bh=an9xkeuT4N4k301iR3nhL/8C4OiSpyPgbZmbQfUebno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gpD8nAq/YgU22PskalCQ8p/2i3XxXRFkSDkg2WdOkImASwicaL0InlwQ65MhoayN1poD3X1YbTKLJFaVhb/K2PXbtAbi3Y9upLcYvfegrDmRICtJfuN+H9YizMvKVWl85n2ej7ljx7TB5m6304uuqY8oQ948Fif0CdMsGHkCxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IMFui4qN; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E4FC20B7169;
	Fri, 10 Jul 2026 21:14:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E4FC20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783743272;
	bh=kHpLmZ//rsWAkpJYMVDT1zWDarg+LT6a1vs+4pt/K7k=;
	h=From:To:Subject:Date:From;
	b=IMFui4qN4+42C56HpZHh8qh6XL8grsTrv2+v52JLmbVZ4KjOt0Bq/+AWmhyaN8+T/
	 Zc/ypGFZpOw7pOqj0naWYLcHKenh3LYwIfM8TSY2/atXU/w3S+7byLolY8uiNRTKcN
	 aaEN/Nkrl7B0EFnvgkn3bcdC5+r8iBuO9xzIiiUo=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com,
	pavan.chebbi@broadcom.com,
	schakrabarti@linux.microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next v12 0/4] net: mana: add ethtool private flag for full-page RX buffers
Date: Fri, 10 Jul 2026 21:10:20 -0700
Message-ID: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11937-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:schakrabarti@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB8EC740410

On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool
fragments for allocation in the RX refill path (~2kB buffer per fragment)
causes 15-20% throughput regression under high connection counts
(>16 TCP streams at 180+ Gbps). Using full-page buffers on these
platforms shows no regression and restores line-rate performance.

This behavior is observed on a single platform; other platforms
perform better with page_pool fragments, indicating this is not a
page_pool issue but platform-specific.

This series adds an ethtool private flag "full-page-rx" to let the
user opt in to one RX buffer per page:

  ethtool --set-priv-flags eth0 full-page-rx on

There is no behavioral change by default. The flag can be persisted
via udev rule for affected platforms.

Patches 2 and 4 harden the detach/attach path so that ethtool
operations (ring size, channel count, priv-flags) can recover the
port via the queue_reset_work handler when mana_attach() fails,
instead of leaving the port permanently dead.

This series depends on the following fixes now merged in net-next:
  commit 17bfe0a8c014 ("net: mana: Add NULL guards in teardown path to prevent panic on attach failure")
  commit 5b05aa36ee24 ("net: mana: Skip redundant detach on already-detached port")

Changes in v12:
  - Added patch 2 to ensure mana_detach() always completes its full
    teardown even if mana_dealloc_queues() fails, keeping port state
    consistent for recovery.
  - Added patch 4 to schedule queue_reset_work when mana_attach()
    fails during ethtool ring size or channel count changes, with
    fallback values that maximize recovery chances.
Changes in v11:
  - Rebased on net-next
Changes in v10:
  - Rebased on net-next which now includes the prerequisite fixes.
  - Recovery logic in mana_set_priv_flags() leverages the idempotent
    mana_detach() from the merged fixes.
Changes in v9:
  - Added correct tree.
Changes in v8:
  - Fixed queue_reset_work recovery by restoring port_is_up before
    scheduling reset so the handler can properly re-attach.
  - Simplified "err && schedule_port_reset" to "schedule_port_reset".
Changes in v7:
  - Rebased onto net-next.
  - Retained private flag approach after David Wei's testing on
    Grace (ARM64) confirmed that fragment mode outperforms
    full-page mode on other platforms, validating this is a
    single-platform workaround rather than a generic issue.
Changes in v6:
  - Added missed maintainers.
Changes in v5:
  - Split prep refactor into separate patch (patch 1/2)
Changes in v4:
  - Dropping the smbios string parsing and add ethtool priv flag
    to reconfigure the queues with full page rx buffers.
Changes in v3:
  - changed u8* to char*
Changes in v2:
  - separate reading string index and the string, remove inline.

Dipayaan Roy (4):
  net: mana: refactor mana_get_strings() and mana_get_sset_count() to
    use switch
  net: mana: do not bail out of mana_detach on dealloc failure
  net: mana: force full-page RX buffers via ethtool private flag
  net: mana: recover port on attach failure in ethtool operations

 drivers/net/ethernet/microsoft/mana/mana_en.c |  26 +-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 223 +++++++++++++++---
 include/net/mana/mana.h                       |   8 +
 3 files changed, 220 insertions(+), 37 deletions(-)

-- 
2.43.0


