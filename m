Return-Path: <linux-hyperv+bounces-10489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oENJI25M8mkFpgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10489-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:22:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE947498F34
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93FA3145C8B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674538C2C0;
	Wed, 29 Apr 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bcAh/zJL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDC229B38;
	Wed, 29 Apr 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486707; cv=none; b=COmvNt1PAa2Vvf3XbnFB2pI7jIzF6BWlNKwWLzMBEHaWapNmerX6QaQaBWLMtZtrIRdgWS+Qm/z4JY7Rw8f00f7PBn40urfr1d2P4023kDWVEujuFKYHC6e/DMX6GOxTwD4j0AmdsKzCNmbqZ/Dv2VVRFXT4c3BafJBd2I5N6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486707; c=relaxed/simple;
	bh=4CEmuNWfSqAId4qwaBWpq7UGwto9b5+jVHli6OgfbvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKdhtFOnyeU3u/bvOcWQaOplF1bq0ctqq993DLzYQLEjpDe/NGm9BnezGay3wiEJdInFGlnff6B7Na73uMwZZid5mbXYjvdWv3Lwrb38603Vqea7AdJrmfs82PxDi1yjub26JsQmDq0xgfWtidx9zlkMXj+HxnRF47479IQVN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bcAh/zJL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 807C820B716C;
	Wed, 29 Apr 2026 11:18:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 807C820B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486706;
	bh=g3EmDuejSmywJNXMETdUC704OXedhEAB60BbPKI2eMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bcAh/zJL/85sPC/AdqxXZFzDLfbEZ1t5Jg5WHu6R1FBSun/65FR419ZBtChJbOq5d
	 uNqgLD9/IfATr8PWa3u0reAP7thISn5fsbaZFsEpbykT8Ia2DwTTHtJwrQHK40KdOI
	 fewfHRNOIMDVRyEGcm6x1debzs1vo0EPvJrIT6A8=
Subject: [PATCH 09/10] mshv: Add missing vp_index bounds check in intercept
 ISR
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:18:25 +0000
Message-ID: 
 <177748670580.144491.17502765337985039307.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE947498F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10489-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]

mshv_intercept_isr() reads vp_index from the intercept message payload
and uses it directly to index into partition->pt_vp_array without
validating it against MSHV_MAX_VPS. A malformed or corrupted hypervisor
message with a vp_index beyond the array bounds would cause an
out-of-bounds memory access in interrupt context, likely crashing the
host.

Both handle_bitset_message() and handle_pair_message() already validate
vp_index before use. Add the same check to mshv_intercept_isr() for
consistency.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d34..5bceb81229817 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -384,6 +384,10 @@ mshv_intercept_isr(struct hv_message *msg)
 	 */
 	vp_index =
 	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+		pr_debug("VP index %u out of bounds\n", vp_index);
+		goto unlock_out;
+	}
 	vp = partition->pt_vp_array[vp_index];
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);



