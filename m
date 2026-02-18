Return-Path: <linux-hyperv+bounces-8895-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGGGASzRlWlEVAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8895-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5ED157258
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 225CB300372B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019F330670;
	Wed, 18 Feb 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nJqpyCrY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFC331A55
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426084; cv=none; b=esBkf8Mva/Vuc+rvx3F4gyv9S252NrpkTFpxrlvk03dt/bc08NJQfYITeMtnKVtNPwOELMvMyBIkFkXRuiZNFSalHV6dPJ/6mNZ+OBVJs+yjxGZuLkhWnDqbWeI85mIUGq7edEkLA0FNV8LRKlprR0gSY/q1MAe0jGBAXpEG0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426084; c=relaxed/simple;
	bh=Yn+dMIbKtc2eHpVtUIVkux94KFyhM5ZkbfuuXSW8cpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncTY6A79WgeZrDoNpmFV5qW9Bv8RbwMUvCeVOkD+Xl1RVylX307q1Z0tfC1vjmBSrm6dFD3dDNpHXSlG8fbrJjbBB20sDzDM+LYh5bkvUjEwjz7TOcimuCmL49uIGSp47gon4BFGXK7WL7dWjEfK9+3+6AolV/2gD5tpGNXDqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nJqpyCrY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from anbelski-virt-work-5.irsgb21fvobu5fvmalxug44hib.xx.internal.cloudapp.net (unknown [172.171.99.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id 490A020B6F02;
	Wed, 18 Feb 2026 06:48:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 490A020B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771426083;
	bh=oSEw+26ckgOKEmCFRgv0iAhym7148MErJuBtrl8aB9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJqpyCrYzgpMXfFygsHcCSn2M4WhqVeCGC/3ryEmjMzI1h95s+LkHObtAl1HI7u7J
	 LsToha/FlNRgr+1sG2ZD5KLbU5ZWeK1cqODiAN9HhhZ0KgTBGAXiMSk4BkTUt8fwKc
	 N9Q0cxsM7XNV8xLAeGNTEdzUYMSa44vS6bgs/6jw=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org,
	muislam@microsoft.com
Subject: [PATCH 2/4] hyperv: uapi: Add bit for nested virtualization
Date: Wed, 18 Feb 2026 14:48:00 +0000
Message-Id: <20260218144802.1962513-2-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
References: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8895-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[anbelski@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 4B5ED157258
X-Rspamd-Action: no action

From: Muminul Islam <muislam@microsoft.com>

Add a new bit for nested virtualization creation flag.
This is exposed to user-space API to enable during partition
creation.

Signed-off-by: Muminul Islam <muislam@microsoft.com>
---
 include/uapi/linux/mshv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index dee3ece28ce5..7ef5dd67a232 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -27,6 +27,7 @@ enum {
 	MSHV_PT_BIT_X2APIC,
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
 	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
+	MSHV_PT_BIT_NESTED_VIRTUALIZATION,
 	MSHV_PT_BIT_COUNT,
 };
 
-- 
2.34.1


