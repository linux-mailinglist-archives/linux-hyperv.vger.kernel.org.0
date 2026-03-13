Return-Path: <linux-hyperv+bounces-9396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VLBdJ+WQs2njYAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9396-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 05:21:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3147D27D3F4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 05:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6214302CB24
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 04:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D95215055;
	Fri, 13 Mar 2026 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SrPt3O6w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028C35950;
	Fri, 13 Mar 2026 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375715; cv=none; b=mVODbmcf9gP7hVFaiF/9tjDSzVsbdu6c02Wi12oEKuK9hVUkDtNjOy8AIJzxh997FFET9v4EcYCNU6uWh7b2Hz1COVhHye6Dyh/UyjMjXCH7SgYmQa2++xYdvwcx7VGFZkHcdfDI6C07P/udVIO2qKFQ2ZEFrPOQVNsOMhHR+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375715; c=relaxed/simple;
	bh=RM3HWXgP8Vktft7nmaTrywkjY6TVm792Aa5At6RjEoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdh8PBXA3Sz8aZHh492ZCSZqOkRI6BSi9z0OiXe2jHAe7VYqxTX61q3dGNVdBawSe/HDL7I7NZebDGaplNIFP+124IcqvLtjrYOX4wYL/h2lCPFNt5lN1nOPrSlWfviONyELNrlS5LkAH2Ixgizr8yaGk8Dtd/19BmYeFVlvgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SrPt3O6w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 16DBC20B710C; Thu, 12 Mar 2026 21:21:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16DBC20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773375714;
	bh=53qJE10V2BT1nBEU8dQubnM6LNzIvuL1t0FoK/jeXC4=;
	h=From:To:Cc:Subject:Date:From;
	b=SrPt3O6ws+yNe7Oz6MLJYPf7YkEXRa1rdtmtk1l2hHOKgqWLzVC8quXsXIqr4TmO5
	 7i3TT16rRTGVSu4Bz++E3hM5R1wfVHYYZM0xQuqMB7Qms2n084pALLsGU8NIjoY5Rt
	 hV1vfs32RD1amJCHetNPSLBT7KyMBf55vt0eTmiU=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	wei.liu@kernel.org
Cc: decui@microsoft.com,
	longli@microsoft.com,
	drawat.floss@gmail.com,
	ssengar@microsoft.com,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH] MAINTAINERS: Update maintainers for Hyper-V DRM driver
Date: Thu, 12 Mar 2026 21:21:48 -0700
Message-ID: <20260313042148.1021099-1-ssengar@linux.microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,gmail.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9396-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 3147D27D3F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add myself, Dexuana, and Long as maintainers. Deepak is stepping down
from these responsibilities.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6358dd7f1632..d67afcb0acc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8028,7 +8028,9 @@ F:	Documentation/devicetree/bindings/display/himax,hx8357.yaml
 F:	drivers/gpu/drm/tiny/hx8357d.c
 
 DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
-M:	Deepak Rawat <drawat.floss@gmail.com>
+M:	Dexuan Cui <decui@microsoft.com>
+M:	Long Li <longli@microsoft.com>
+M:	Saurabh Sengar <ssengar@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-- 
2.43.0


