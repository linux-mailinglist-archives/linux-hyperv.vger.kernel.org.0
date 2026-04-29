Return-Path: <linux-hyperv+bounces-10487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLtrDDFM8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10487-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:21:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83435498ED3
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3337F312A5C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4F2F7AB0;
	Wed, 29 Apr 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yk7Leb/I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0A38C2C0;
	Wed, 29 Apr 2026 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486700; cv=none; b=ipH55VqLUsMYSvlVgg1H2cfcZox/68Pla1Or93/FloBU6HgkHEnp4dray0fe/6FXq6Qt7jkqoeFZfWQJQjiwHdLJ546VeMh/l45fUyS2IfPPeb0FOJTrbqcztiwhtDYIxZ2v5pBtfRlyYLLOZkd4IXRyzt/CF3PHAPMKR/XdByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486700; c=relaxed/simple;
	bh=B5BcviSkWxMJxsB/yXxPztpPzSuD5TeqcGUMVbQdrGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACE3DVBbyk5rTdiHTDsUrW+7aLjo1NEZmFnvgRs/VZgmD67KDTJf5YyHT8ob8ioNrqnIszErkhTW3Vs8j/nU6LeRLQ6V3kRCGg6uDkDZUV6xRoov8zydrBStLNkJiJaFJXlaYHiJWNv7LOZkTLtTc9pO55OXTwj8cDqaznvVvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yk7Leb/I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id C728E20B716C;
	Wed, 29 Apr 2026 11:18:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C728E20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486695;
	bh=sb9hrF+S0d+gt2J++FOGx9P56GAr3cUi3MdkyEEHB8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yk7Leb/IXVGjXxDFlFBoUPoaJSWoUNrAbb2i/0Y4G984h8Cjn/yclWkldrhwFXWx9
	 +39Qk2enILtVDXvKUn5/WUTrJwt3l/yZcHGcG4gS3iZ8MKpZKOEoSeSgv1ndDHc7Ra
	 R+clFbeUSu+GiKvaz6FZrLTKByx45essh7S19hvI=
Subject: [PATCH 07/10] mshv: Fix use-after-RCU in mshv_portid_lookup
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:18:15 +0000
Message-ID: 
 <177748669510.144491.4766566442031280249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83435498ED3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10487-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

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



