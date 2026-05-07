Return-Path: <linux-hyperv+bounces-10686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C2mBtCz/GnlSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10686-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:46:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E254EB501
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B96943046CEF
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17744B660;
	Thu,  7 May 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W23SOg2M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE43402B8B;
	Thu,  7 May 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168646; cv=none; b=ViKhBT/D7BQp8gPoazole7Nzm/mfVA990RqJLCmLWqykH7XfnIn9/X55M+2y3k95rzuv4PpITECiq/rZorKpu2eiPvj6J52Z7oAYtTdcHmQxtZLkaUUoG3tDGzCvsTA464EL8ERglN45t/6bsH/TvxTcWBDT9/Ow+taqarWwy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168646; c=relaxed/simple;
	bh=RCR9IKxxOXYK2yJM2g9xnfr0z4EcMC5nhtWAa+D5qZs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnEMQMLjHeKt2zl4wHli5T5pS5WxOlYK7sYIl1PxwyCnKiNvFRdWiOAAAlq3I5S7N3AtPpzWN+VP1e5OBEobi2M4ZLSRuZRMYP/+J+7nOBaUoyGHXJziRC2B1VCIxQZdbWjXWwm7/6w0ORvdHjkHlO26c5WSxCjWJK7RWoz6ofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W23SOg2M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AC6020B7165;
	Thu,  7 May 2026 08:44:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AC6020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168642;
	bh=VsFD7CS0vcU/q1DHP+/zJaQsZooW1lzrwi7Uhgzv3RI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W23SOg2Mwqp6B8R6kz3HtMy7xH+onCLLBx41Qy4paWaPAsbkw0bwvEb1BFGYWKw4t
	 ggSrZzg2/sQLfH5t3O/5xeChBzki9+B2bUTIy9JHAnRRvBuRuuxhIE/wSKoPYvDVBZ
	 GfFuZp0f+JKyxE1no0Q6dNRp6sS7U8Q8VBrP9XWw=
Subject: [PATCH v4 12/18] mshv: Use kfree_rcu in mshv_portid_free
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:05 +0000
Message-ID: 
 <177816864533.21765.15114003791446487007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E5E254EB501
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10686-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mshv_portid_free() uses synchronize_rcu() followed by kfree() to
reclaim port table entries. This blocks the caller until a full RCU
grace period elapses, which is unnecessary since the same module already
uses the non-blocking kfree_rcu() pattern in mshv_port_table_fini().

Replace with kfree_rcu() to avoid the blocking wait and keep the
reclamation strategy consistent across the file.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index d87a82e399e96..42d21b92b88fd 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -62,8 +62,7 @@ mshv_portid_free(int port_id)
 	WARN_ON(!info);
 	idr_unlock(&port_table_idr);
 
-	synchronize_rcu();
-	kfree(info);
+	kfree_rcu(info, portbl_rcu);
 }
 
 /*



