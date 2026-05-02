Return-Path: <linux-hyperv+bounces-10564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGa3MhF+9WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10564-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:31:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E64B0E26
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6240C306227A
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FD2D5C83;
	Sat,  2 May 2026 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tgp0mheq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402028DB49;
	Sat,  2 May 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696099; cv=none; b=fQfDrliwKOjnzN3AOCvopTUOu+pY5MOQzXb5K6p7/vl8XdqHDfxNV/99TTJPrRJEC4uG+xhCtat0msDRKFvPkdOrD3wBbpv7wwBY6eFoI+eCMwFOaEPoN0ld6dqbeAQtzThzDe/xhdJRaaSFzHiymTehl79Cey6mT7EiQjjq5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696099; c=relaxed/simple;
	bh=B5BcviSkWxMJxsB/yXxPztpPzSuD5TeqcGUMVbQdrGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9MQWmtJFgGmjzbrmAxn0eMwivY4YRvFnbOTvvR6h3NwX1MvMEKL50ht8zU6P9nXiUGyEzniPq675e7UR09jIBQLL1F8p0g8zo9YdcJ+7FuXdXJpsjQFyjh+CJmt6Rg/1i96SO24mRuSgd1yIb7pUFEmMIZwAqY1liRZNiLuAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tgp0mheq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4C1420B7168;
	Fri,  1 May 2026 21:28:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4C1420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696097;
	bh=sb9hrF+S0d+gt2J++FOGx9P56GAr3cUi3MdkyEEHB8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Tgp0mheqrxzl3IQgfVzFeuO3nuq6mNsl/Fqek/mLhiw+QIasC4DFAA3xFp/l434S5
	 P0iDTLhvVSJScebiTFc7v2k3BTxMVstF9zaPTxEOtf6+Fg4c0mT5JSIamM+fgrC9mE
	 EHSZYHD+NfJpLSMut9memPk9cBX+UIUe3J090J9I=
Subject: [PATCH v2 12/18] mshv: Fix use-after-RCU in mshv_portid_lookup
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:17 +0000
Message-ID: 
 <177769609771.222166.4928884649239916644.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 608E64B0E26
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10564-lists,linux-hyperv=lfdr.de];
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

mshv_portid_lookup() drops the RCU read lock before copying the
port_table_info struct found by idr_find(). If mshv_portid_free() runs
concurrently on another CPU, it can remove the entry and free it (via
synchronize_rcu + kfree) before the copy at line *info = *_info
completes — resulting in a use-after-free.

Move rcu_read_unlock() after the struct copy so the object remains
protected for the entire duration of the read-side access.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index c349af1f0aaac..f1aaef69eb9b7 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -72,12 +72,11 @@ mshv_portid_lookup(int port_id, struct port_table_info *info)
 
 	rcu_read_lock();
 	_info = idr_find(&port_table_idr, port_id);
-	rcu_read_unlock();
-
 	if (_info) {
 		*info = *_info;
 		ret = 0;
 	}
+	rcu_read_unlock();
 
 	return ret;
 }



