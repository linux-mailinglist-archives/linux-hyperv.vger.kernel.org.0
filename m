Return-Path: <linux-hyperv+bounces-11892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id znz5ADpZUGqZxAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11892-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:30:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84F736AC7
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PqTrvVUn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11892-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11892-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 365D5301D96D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B701FD4;
	Fri, 10 Jul 2026 02:29:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1529AB02
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 02:29:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650563; cv=none; b=nsnPClkIy2N8/BEnZgjNmxLrx82cSNIiTmRtiFphGGd5vly+hR3OpLiKR3QbBZQ4H5QHWlqXWEFPJda5elNs3ZGcnOUfEh1ccWPyiTqoCbFQ7gEV+ufGe1PtCK3i+sc8D3wyu3C9BwlWSlvy82COepqPzbk3AZ3wopDTGXu1DPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650563; c=relaxed/simple;
	bh=wsHM+8ZeYOqCJwA/6tpF0q5nafYPW3zlwHQ3/xAjE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1dHKRjuh3PblLhk1oPipW+r3nkwcqlHxlLeU/bMcBy5wUw/Hz2VXqi0LFzC37lPe2kEIcRyfDBhIC0N65oPZqYqI54scPOwp/LXTwTgAQqTBY8jmaqyJl619SMGjZOCoIUn5L/VxsIBlhr/HkegTfZY+xAieYChL02bAyDnGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqTrvVUn; arc=none smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5c9211d2so30585485a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Jul 2026 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650561; x=1784255361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VrbOIz5DjpeTHI1zJiQK8GMybM0cRVGEIt9+g4I/iE=;
        b=PqTrvVUnaBupsH9/QjAjP4yHzhxlVYCizcAWeVJiLKUwDa+QaHD0BZEI2Qj2Nv4yGT
         I13FnCkxM62jIQjX/afy9CVWI/6DfGcKmTTkFRGl3G31QaJiJPEbDnqSvZCRpEeq0sdc
         w32G2e+JKcK23ix6mszoA3P2TVXp/SmtOjMjW6nJqJvXz1aQVOQ4IrrA5WtUw+sGESnA
         gpbVTI6HSQ+/wT0iyl3SFl6CQG4ssvyepaZM9VLy2xwpdUkEKhnDl0fghcRQ7KYn1hNu
         pdC3RxvdM+6xk8xK0QYvp769oFrUfQvHE4YfNtNNyZYzukoomhZFnMTwQqt8SqjjpU4L
         Fb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650561; x=1784255361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VrbOIz5DjpeTHI1zJiQK8GMybM0cRVGEIt9+g4I/iE=;
        b=JpNc3Ag5ZiqLx5IoKQE1sNWUOWmLpACxtzc4BOhZ4iXKZYa8z8hea8YQFLU3u7YROU
         1kishMVV5SYTN7e5Ro+KWaRFE/dSsrOskxHR8tBAE2CORxRr1+uF9z9tkcTCLNhGikk8
         X7FukumbtIzIKMkRwJu/yCX8xu4xvDfj2VMOFa8s4shhXEb1yiDSAOXrWHtYR7WQyxEz
         nP5D40WadTbRa9bzXwTlpkT9AiLfJIE0vfYGjkTcoAnteLFG44BSPPIouxhSHdL8bk7F
         l6WuEW17TG3vw+PIs/gtfDTtq/QNJhUarjLOYd+Gejcbu5iVZRkG50vqAHkdYsTQVMcM
         K55A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0JAXLQd8pp5dvzE826FouTpG1WcMLlkfM2+3rBLoxU8odlQIIS6+uQDpJ5GP4qY1ZiHD/n/PhuJ5acbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzLDWZBXC0CJPAm+1Pu0AP37wmwitinI0aAXtCu/IVd47y1Jc
	FZFS+wsSOP5dJSkhOPnoxnovzk/SWB5ou77qyIY5K5uk47XKiESwHpWZ
X-Gm-Gg: AfdE7cmatrKHTaM59WlfLXQQvb6EH891ZjUqzuy/+WJ2pLvpIYq/5zbuMMiV1SeTPi2
	cAM32OGcnH0r1A4h5hOXzfqt+nPnYs7n+kgXgRnb3No5QGBCDT6YroSEo2PBd7LPQnklIPuKScx
	qSs/zfLMruxAkNx4LH02jJyXIPsxNI8KSt7FL+x6j3e3xncJesyBzJ+MklN4j9w3MWe73DV6xsQ
	9mOoxkgsccImoE8NydP3lDk2GmF25tvDYvcut6Zzhm8UFlXdYq9erMkwyf/SYYewbY9eTp0Q6pa
	ai19ewSIohXRQBvszL1LFxrglGAPLbokBwZpt/0paB5UVu2yYvwcU+m5jAqpZbVXKZnU4L321Me
	0QtXr3FcNbzWbA/NvRbrbqbqX7uxprrTSc476MEi/TCjfm8raV7slaZUtpW+QRaLfISztPVZ3Ij
	KNtTSmasBDRdxRwuHV9Ua8lBFWthUGEaI9sDENhg7pBvXNUQHUck6NOM/6G+IvL2+rb5dar97i/
	mAishKzbfe4y8g95pnb+epOsEcOvCFb
X-Received: by 2002:a05:620a:170e:b0:92e:5a74:962e with SMTP id af79cd13be357-92ecf8f520bmr1013173385a.62.1783650560868;
        Thu, 09 Jul 2026 19:29:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61fb9sm86411685a.41.2026.07.09.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hv: hv_balloon: validate unballoon range count
Date: Thu,  9 Jul 2026 22:29:14 -0400
Message-ID: <20260710022914.3740453-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11892-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:gregkh@linuxfoundation.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E84F736AC7

The Hyper-V dynamic memory host supplies DM_UNBALLOON_REQUEST messages
with a header size and a range_count field. balloon_down() trusts
range_count and walks req->range_array without checking that the received
message contains that many ranges.

A malformed host or backend message can therefore make the guest read
past the received VMBus packet while freeing balloon ranges. Validate the
received message size and reject range_count values that exceed the
present range array before walking it.

Impact: A malicious Hyper-V host or backend can crash a guest by sending
a short unballoon request with an oversized range_count.

Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hv/hv_balloon.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index a848400a59a2d..f5bc8c9fea7b9 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1337,8 +1337,23 @@ static void balloon_up(struct work_struct *dummy)
 	}
 }
 
+static bool unballoon_request_valid(struct dm_unballoon_request *req,
+				    u32 msg_size)
+{
+	u32 max_ranges;
+
+	if (msg_size < sizeof(*req) || req->hdr.size < sizeof(*req) ||
+	    req->hdr.size > msg_size)
+		return false;
+
+	max_ranges = (req->hdr.size - sizeof(*req)) /
+		     sizeof(req->range_array[0]);
+
+	return req->range_count <= max_ranges;
+}
+
 static void balloon_down(struct hv_dynmem_device *dm,
-			 struct dm_unballoon_request *req)
+			 struct dm_unballoon_request *req, u32 msg_size)
 {
 	union dm_mem_page_range *range_array = req->range_array;
 	int range_count = req->range_count;
@@ -1346,6 +1361,12 @@ static void balloon_down(struct hv_dynmem_device *dm,
 	int i;
 	unsigned int prev_pages_ballooned = dm->num_pages_ballooned;
 
+	if (!unballoon_request_valid(req, msg_size)) {
+		pr_warn_ratelimited("Invalid unballoon request: size %u, header size %u, range count %u\n",
+				    msg_size, req->hdr.size, req->range_count);
+		return;
+	}
+
 	for (i = 0; i < range_count; i++) {
 		free_balloon_pages(dm, &range_array[i]);
 		complete(&dm_device.config_event);
@@ -1527,7 +1548,8 @@ static void balloon_onchannelcallback(void *context)
 
 			dm->state = DM_BALLOON_DOWN;
 			balloon_down(dm,
-				     (struct dm_unballoon_request *)recv_buffer);
+				     (struct dm_unballoon_request *)recv_buffer,
+				     recvlen);
 			break;
 
 		case DM_MEM_HOT_ADD_REQUEST:
-- 
2.53.0

