Return-Path: <linux-hyperv+bounces-10554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB1nHUx99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10554-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:27:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3744B0D5C
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4841130269FF
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23428F949;
	Sat,  2 May 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kvXW4RcE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAFB263C7F;
	Sat,  2 May 2026 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696044; cv=none; b=oc8P8TsmUgbOMnJ22SoqPodTTR54FbXhCUfv3Mn5+TzopB82XS5KgvYAriFv/Pi/dcKfFJ2ZJB8AdlU9ES1KFJkKcrgYbX7i2wYlUZxAAnU9TZQgb7qruOK27iTUbPkLiTCBwt3PB38TOXRn25PvAyjTODFu2Z+abwF8ETWQ1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696044; c=relaxed/simple;
	bh=pTT6Hswg7L3inYnv97QRqYWAPiZYEb3wMOjLKxxbICI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYFAxeAtgVBasVz8eayWekDiB+ah/XGelaVHxK2vJ6rqSmW6+Z6EGghrC6fwOaDffC6EyEuUvAl4m/JJR/rrBq3Yxqc19Lqoi+NZD3ANip3N9ziTwkzpiOKYSuROz4e/s8lPreYMMnGAS339O02HqaqBh96ZTATxpIbT7BpCPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kvXW4RcE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16FA320B716C;
	Fri,  1 May 2026 21:27:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16FA320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696043;
	bh=Uk8wk6XlWEHWPtWm07hcZvv/blXW1ZRa96uVpenLlnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kvXW4RcEI7nQnasaCVUELrFBd7TgAR+4+GUUGEEmBZqj0RQPZk+JgpNAIG8ZRRUQ3
	 aJP0YkBA+PkfO1iOyMos3YouMVNlyjUSAZOWbmUiBZzrjCbTwXkgZNgyKDAfrV8i3x
	 pVXiSicd4e7eqHeoapIH66NFenoUNy4chxFQ1h/I=
Subject: [PATCH v2 02/18] mshv: Fix potential integer overflow in
 mshv_region_create
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:23 +0000
Message-ID: 
 <177769604310.222166.17549719374764470757.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: ED3744B0D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10554-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

The allocation size is computed as:

  sizeof(*region) + sizeof(struct page *) * nr_pages

where nr_pages is a u64 originating from userspace. A sufficiently
large nr_pages can overflow the multiplication, resulting in a small
allocation followed by out-of-bounds writes when populating mreg_pages.

Use struct_size() which returns SIZE_MAX on overflow, causing vzalloc
to safely return NULL — caught by the existing error check.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6f..1d04a97980b8b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -177,7 +177,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 {
 	struct mshv_mem_region *region;
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	region = vzalloc(struct_size(region, mreg_pages, nr_pages));
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 



