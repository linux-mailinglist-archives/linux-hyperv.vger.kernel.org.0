Return-Path: <linux-hyperv+bounces-10607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IASfLY7v+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10607-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:12:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C0D4C307C
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1C05301C8BA
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670A3F0A83;
	Mon,  4 May 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j0uBb2kt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B93EFD2E;
	Mon,  4 May 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921800; cv=none; b=oHeTus3/s974icZ4sJ/qOD8FH0u+ljCR4BbootDMiAwFCi62+0Pd7Q9M+BLCXIMBglIizC6ZxcujF55gIzahWLfO8IjTEosMkNkMGne9qqCeDu5HCne7dept0JyyQfq1Y05CmconHkHHuHhjvy55KIM6DxLr6g3UWqbTfH0j3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921800; c=relaxed/simple;
	bh=B5BcviSkWxMJxsB/yXxPztpPzSuD5TeqcGUMVbQdrGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oh/RV80UYOUwR54NbPY5T5+vDX48bt5DH0IKgpxud7cyeh4WZGALnE2OIqDJYMrS5V+Lyvi0eOG+QvDVDxXU+2rqCOdTdbkwKAS6GM8Qg5JId77c9COm78oEd9GKGS6jIJKseFW7k8GvOEG/Iik8vZxDPXdJNz/VIUOE+9h3A3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j0uBb2kt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCA3720B7168;
	Mon,  4 May 2026 12:09:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCA3720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921797;
	bh=sb9hrF+S0d+gt2J++FOGx9P56GAr3cUi3MdkyEEHB8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j0uBb2ktaDY/+VTP1Gh3pat75Q91BmS8ezKRpzhYgkOG96lSH/llHimhonUd7ffby
	 lPWjzo0n0IHMYJFW9vOGx2r3tJ3mVnjYWWjUHl+XnBh250CkUM8M77S9bvfcY6UKts
	 N6oH6T0GGHq4vAtVv7pRjHqfA2tgI2MYSZRVG2hU=
Subject: [PATCH v3 12/18] mshv: Fix use-after-RCU in mshv_portid_lookup
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:59 +0000
Message-ID: 
 <177792179921.90827.5509490158610270158.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02C0D4C307C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10607-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

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



