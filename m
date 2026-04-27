Return-Path: <linux-hyperv+bounces-10392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLkPGRx372nuBgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10392-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:47:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9786474A9B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF458301C5B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9B3A5E72;
	Mon, 27 Apr 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WO6F95wg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364803A0B01;
	Mon, 27 Apr 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301046; cv=none; b=qfMWolQaAuGIZzOlNNJ5UH1cskQ4rJOzI37fe1oPEQk78e1t1LyWU4SykbtPJY4eb8X08ng8rjq44Sthnp4C1meCoBOQxJaow1aNUdpIPcELc0fiLrZsAixQD3AucWKNRlhWb6Sn0MEa21mcuD5DjeldsKXQWDcaQOXpEuSN7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301046; c=relaxed/simple;
	bh=9n7ZiPKAVIAGk8oDDwHVFHz3W7/i7E23oQfB9W1zkzM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=BlYDrsD25Bn6KyIXwi1CVMRHOy20VD6/Bzihh/L5v7v3GRQIk+6oq9/hFTWezXLobZdJ7+ygBSuipW/PY1CZD2xI+vOdknArM0NPbJBlb8KoE3vVhHWf4Gop+8J9s25ppnKVzsXtOUhTmpQ40M/yNpd/oJqtaX4hIrDshDB5pRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WO6F95wg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6253520B716A;
	Mon, 27 Apr 2026 07:44:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6253520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777301044;
	bh=9YCzQCfX3xO+WwWoiUKCuNNQIYIYggXUwpprN+1bBCs=;
	h=Subject:From:To:Cc:Date:From;
	b=WO6F95wgATdmxJm2yDE7+b27h63v/vBkTXtDiJD1Iwuscpaa2k7qbmj9eOSV5nw9q
	 oCCRRQs0diFlMLG5gkyfvYlt1asH7vsL4o/JAPzaSq4URqPKa5zL72Nyt6YeHo3SzY
	 GmRzJyNyatUhOVm5xPckP/FXiGecMKxBwm4gZ4j4=
Subject: [PATCH v2] mshv: Fix large page unmap count in error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 14:44:03 +0000
Message-ID: 
 <177730103437.21611.9595619835481065448.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B9786474A9B
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
	TAGGED_FROM(0.00)[bounces-10392-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

When hv_do_map_pfns() fails after partially mapping large pages, the
unmap count passed to hv_call_unmap_pfns() is incorrect. The 'done'
variable tracks the number of large pages mapped, but the unmap
function expects the count in 4KB page units.

This causes incomplete cleanup on error, potentially leaving stale
mappings in the partition. Shift the count by large_shift to convert
from large page count to 4KB page count before calling the unmap
function.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 7f91096f95a8e..ab210a7fcb8c3 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -255,8 +255,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
-		if (flags & HV_MAP_GPA_LARGE_PAGE)
+		if (flags & HV_MAP_GPA_LARGE_PAGE) {
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+			done <<= large_shift;
+		}
 		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
 	}
 



