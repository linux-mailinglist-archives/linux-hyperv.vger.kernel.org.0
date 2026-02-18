Return-Path: <linux-hyperv+bounces-8893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKFgBnvKlWlfUwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8893-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:19:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E715700B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248DC3016EE6
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE04330D36;
	Wed, 18 Feb 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LsUkIxIj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659E22D4DC;
	Wed, 18 Feb 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424376; cv=none; b=JMgv0F+WfyIi9wjhdCVNAtJN33vHm8jHFQTYRe4FzBw/5CYGJc7yxmkP7kvgsslq85qD/kxZARyH9LshYhtqt+IsJVt2qrkqFMdGBydI7F10vgVA1oYjHGyuRSsg8QZajDtptwMTciPLvmW2gxuMh3TTpEVxrYwxmaQrx1gZHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424376; c=relaxed/simple;
	bh=S6h2Z6sUOywlDn7IJuN9Y5s0WcCM6im/R9HDxeq7vqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qSYUuANIeHXpLqJUtILaSVxSTt8e+OmTeUMmHH0OBVjpISSCWUzTRlsmowLkFtTuP5j1vopGc03xbgjyURF7LJT9mEw7hBappwLgM9r7BrGCVtZ9xdpgOZj/ACyN96O7z2cu/eGkxZiL0iQGGnBXsDoFnTWFxcOJvxusP0irQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LsUkIxIj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06A4D20B6F00;
	Wed, 18 Feb 2026 06:19:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06A4D20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771424374;
	bh=EwcGjp87EUVkv+YxE50a+yvbnnXMcjBmV8/MsL4EDp8=;
	h=From:To:Cc:Subject:Date:From;
	b=LsUkIxIjqFbreiybDZRoPdcsgH2rXcD/431VVuZRKmlzKi3k9bpBuXg+BlItzA0T/
	 WrZsQvhY9KP+sKYBv+pEN+VDRj/gZD0onK5Fc4RnSuDaQV4NJLqi/+TKvzXqmlh2pG
	 jw8re7flIbmfMRoZ+5re+nx7w7GPzG2vye4uS3W8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: skinsburskii@linux.microsoft.com,
	magnuskulke@microsoft.com,
	linux-kernel@vger.kernel.org,
	Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] mshv: expose hv_call_scrub_partition
Date: Wed, 18 Feb 2026 15:19:11 +0100
Message-Id: <20260218141911.555592-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8893-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[magnuskulke@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 651E715700B
X-Rspamd-Action: no action

This hv call needs to be exposed for VMMs to be able to soft-reboot
guests. It will reset APIC and state of para-virtualized devices like
SynIC.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 1 +
 include/hyperv/hvgdk_mini.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cb2729f99e2c5..7c13d5f36437c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -143,6 +143,7 @@ static u16 mshv_passthru_hvcalls[] = {
 	HVCALL_READ_GPA,
 	HVCALL_WRITE_GPA,
 	HVCALL_CLEAR_VIRTUAL_INTERRUPT,
+	HVCALL_SCRUB_PARTITION,
 	HVCALL_REGISTER_INTERCEPT_RESULT,
 	HVCALL_ASSERT_VIRTUAL_INTERRUPT,
 	HVCALL_GET_GPA_PAGES_ACCESS_STATES,
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index f98eb41342d40..9120fcf0161a4 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -501,6 +501,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_ENTER_SLEEP_STATE			0x0084
 #define HVCALL_NOTIFY_PARTITION_EVENT			0x0087
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
+#define HVCALL_SCRUB_PARTITION				0x008d
 #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
 #define HVCALL_CREATE_PORT				0x0095
-- 
2.34.1


