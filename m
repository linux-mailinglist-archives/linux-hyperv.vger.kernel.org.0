Return-Path: <linux-hyperv+bounces-10289-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNotF/7752mADwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10289-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 00:36:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEF440317
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7D53011BC7
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1FB351C3F;
	Tue, 21 Apr 2026 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cvnNL3kg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19028643A;
	Tue, 21 Apr 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811003; cv=none; b=OEsPxbWGt4ZwLhNpLPmbkISDbLrdqOvRBPNIuUYriCm1qsV8ctMO8xe/jrbC+UsUdUdIPjh/7JmMzSuz8tlabckzwX0Z6eBbOJ5NWsg6FRUpx4qF7fC4NNnpfmnqBLneH/np6cS97uWTCaQ4VPxJjwJo2fok7A9OEQCAJOiJoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811003; c=relaxed/simple;
	bh=h7NgLtfH14YGrs6CfH9ffrIEWNZLwNfmS7G29rdSwp4=;
	h=Subject:From:Cc:Date:Message-ID:MIME-Version:Content-Type; b=jGlEhcH+b+d7TUQdbulzAnvTp/JTVaIxrGnL4VvXQrJcS1J7QKNLn9D5lDx6mQjFaMd/nIPrPX/l2nPZXT5V70+UJIUaKRL2rqEYwrJFI8RLjtKAiHnf46X9FSIpd4c73yGcRg6AaNGojDrpEVhTy4EZDy5KficVcc+lVMcZAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cvnNL3kg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20C8D20B6F01;
	Tue, 21 Apr 2026 15:36:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20C8D20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776811002;
	bh=tcV2MMTLsPOUHSOYf5S2EqyAmNNuSM1djX5xBbkafKU=;
	h=Subject:From:Cc:Date:From;
	b=cvnNL3kg/3jeakf9IkhyeXg5YlIWKlA6D3KPEsDq5H7b7YczFblICywycSW3lLGjT
	 gE2C+82OVbnQM+IEk9AVsxnpdVXmOqE1k6TRrJhDelMeSwCuzb3bSNKpNQW5DY3I+e
	 5HDoej1UzCra556L+h9uT0dEBI+iJWY1UaFByyCI=
Subject: [PATCH
 --to=kys@microsoft.com,haiyangz@microsoft.com,wei.liu@kernel.org,decui@microsoft.com,longli@microsoft.com]
 mshv: Fix interrupt state corruption in hv_do_map_pfns error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 22:36:41 +0000
Message-ID: 
 <177681100155.270589.16151793616470732178.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10289-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 95BEF440317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Restore interrupt state before breaking out of the loop on error.

The irq_flags are saved before entering the loop, but the early exit
path on error fails to restore them. This leaves interrupts in an
inconsistent state and can lead to lockdep warnings or other
interrupt-related issues.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 7ed623668c8e..6381f949d9d9 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -237,8 +237,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
 			} else {
 				pfnlist[i] = mmio_spa + done + i;
 			}
-		if (ret)
+		if (ret) {
+			local_irq_restore(irq_flags);
 			break;
+		}
 
 		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
 					     input_page, NULL);



