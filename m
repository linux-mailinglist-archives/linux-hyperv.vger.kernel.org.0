Return-Path: <linux-hyperv+bounces-8440-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIyFG91UcWkNEwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8440-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:36:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01B5EE3F
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762284FCEA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA83A7DE9;
	Wed, 21 Jan 2026 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jr/fTc+E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA4421F05;
	Wed, 21 Jan 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034956; cv=none; b=jkZti9mpk+QhIrNiHd2ZMXzpAvwPG+ut0NwLrqij93NugxFfgAhYGrEfYQQEKZtMty4eceOV46La9Xu4Ld/XLS8H+m6t9ITMouScLWLGvMUJr2FYCUjYvl2x5Rk17yo3mcNx/qrJqJW4wycEwxNCkckaaXyFBWkdlm2uBprh9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034956; c=relaxed/simple;
	bh=xzg+wWpeslx7cmSf3+9oCHglph+ucNBV7vA7snnS3vQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB3rcxBhWQ9XA/c0Zi4gJ0/ZtTJYydAcAkB6f1fQHk77HJc67J8Nm2dEXNdjtxiOXqOZqhvZyubY0veZQyNSKVachyAZ0XyAsVwQb4YnEdmctL6Rya2GK4sqp0R9We3vWJ1EIZFks1iRcyMQZRcguZW3L0XOYbKBAwQTYQEvNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jr/fTc+E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46FBC20B7167;
	Wed, 21 Jan 2026 14:35:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46FBC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769034954;
	bh=qVZNQJTar5ROG4ASJsek+RWuoUtiqtq+N+dHoONkc9c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jr/fTc+EAAoohhzwGvY2TB5uszipsw4MSWwOwI5QJy+0vz+ecqa4+1PHzvojbYVcD
	 W6zgOfm/GRss/k3JpSgpGjPspHptmp/eh1vCsYTMbM7/CbIfxZyx7a2aVpQJkzkBk6
	 AG01AD+hbBnF3myf/w5IapBpEHVKDAPJ99RS40Rw=
Subject: [PATCH 1/2] hyperv: Sync guest VMM capabilities structure with
 Microsoft Hypervisor ABI
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Jan 2026 22:35:54 +0000
Message-ID: 
 <176903495416.166619.16629695002971245203.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8440-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[142.0.200.124:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[4.155.116.186:received,13.77.154.182:received,52.25.139.140:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: EE01B5EE3F
X-Rspamd-Action: no action

From: Andreea Pintilie <anpintil@microsoft.com>

Update the partition VMM capability structure to match the hypervisor
representation to bring it to the up to date state. A precursor patch for
Root-on-Core scheduler feature support.

Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/hyperv/hvhdk_mini.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 41a29bf8ec14..aa03616f965b 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -102,7 +102,7 @@ enum hv_partition_property_code {
 };
 
 #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
-#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
+#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	58
 
 struct hv_partition_property_vmm_capabilities {
 	u16 bank_count;
@@ -119,6 +119,7 @@ struct hv_partition_property_vmm_capabilities {
 			u64 reservedbit3: 1;
 #endif
 			u64 assignable_synthetic_proc_features: 1;
+			u64 tag_hv_message_from_child: 1;
 			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
 		} __packed;
 	};



