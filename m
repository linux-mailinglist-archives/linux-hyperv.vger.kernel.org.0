Return-Path: <linux-hyperv+bounces-11162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9ybvEH/oEGqmfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11162-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:36:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1605BB873
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AB193009B0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342F038D3F8;
	Fri, 22 May 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nuGsUF0A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09BE33F5A9;
	Fri, 22 May 2026 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492988; cv=none; b=TBWm6kSJzhABsInVMPmx7iV1uqswUgCy430gc/LFNf3mKL0Rbr3G5QKx0UKavTYNjLuN/veK5mBzmfpufprBCp/IH8zMho9lgnjWrw9BmHEI4UUjgffJN+LemH8GtpcgnBR4x93AVUlxBKw/t5vAua5/u4/opCGwwrJdGS+w57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492988; c=relaxed/simple;
	bh=/jgttpWCN0tgh/4c8aZqcVtsOjdx0JQvRJVQZT6nq28=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JdnaxhiducFV97q+ZQcklSM0DXxvB/lBrjzzY2pQlIlqYbG82vRl6bXmPyNqoe3TUVERg+GjPajiiTz2qkm95hu4pbxUG4gz3N+u5QHMPHkxN63mXKMeOE6bpAKqXigysp65IvtMa9F7bcfX/i07UCy3v+1sBW3x+dA+Sm4mY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nuGsUF0A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A500420B7167;
	Fri, 22 May 2026 16:36:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A500420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779492977;
	bh=xbYpCzgJzfzdNg3MGfAcTelwqBdFp1i4OWAH/4HYx/Y=;
	h=From:To:Subject:Date:From;
	b=nuGsUF0ADIfi1kKUPTNcwWSSyZvMLHOknCRs/6CokFmZAa2MZcQCR2+nDIBQqz14K
	 PlDUTpVn4dwvN/KO2UjHlrnpTNvT4A090iAgBqoCuNxlFYPK7Crxigq27FEupej1K5
	 05RqBhatEKw85+TZ0691dIcGMEr05JEfpTSsRFuo=
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
	yury.norov@gmail.com
Subject: [PATCH net v2 0/2] net: mana: Fix NULL dereferences during teardown after attach failure
Date: Fri, 22 May 2026 16:33:11 -0700
Message-ID: <20260522233555.1099342-1-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_FROM(0.00)[bounces-11162-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA1605BB873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When mana_attach() fails (e.g. during queue allocation), the error
cleanup frees apc->tx_qp and apc->rxqs and sets them to NULL. Multiple
subsequent teardown paths can then dereference these NULL pointers,
causing kernel panics.

Patch 1 adds NULL guards in the low-level teardown functions
(mana_fence_rqs, mana_destroy_vport, mana_dealloc_queues) so they are
safe to call regardless of queue initialization state. This covers all
callers: mana_remove(), mana_change_mtu() recovery, and internal error
paths in mana_alloc_queues().

Patch 2 adds an early exit in mana_detach() for already-detached ports,
making it safe for non-close callers. This allows the queue reset
handler to safely retry mana_attach() without redundant teardown.

Changes in v2:
  - Patch 2: moved netif_device_present() check into mana_detach() as
    an early exit instead of using goto in the work handler 

Dipayaan Roy (2):
  net: mana: Add NULL guards in teardown path to prevent panic on attach
    failure
  net: mana: Skip redundant detach on already-detached port

 drivers/net/ethernet/microsoft/mana/mana_en.c | 76 ++++++++++++-------
 1 file changed, 47 insertions(+), 29 deletions(-)

-- 
2.43.0


