Return-Path: <linux-hyperv+bounces-8642-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G9vKQnWgGmFBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8642-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:51:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48932CF2BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91CB03015D90
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62793806D5;
	Mon,  2 Feb 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFj+xBI2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA423806A9
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Feb 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051074; cv=none; b=UpdovE1eCiBnN5dEEJPnQlWKYmi/Kc+TG4qxQh3DwLFwrJpC62nKfObloKBRriCCVD+GPhN+6VtKIiukSBPFhy5CbMw9OdkNYI/+9rQUuuL4Nbk6n0DDdFrkUTPY5ZXJrut4t6+g/+MTWHorF4/pqy72vJCrFyEPGrpKE6cqFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051074; c=relaxed/simple;
	bh=2IG15X5CbThZwzL2MaRQjtbDbxt9buphp7mC7rJnX80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMICmyXmiOJ7Hor0Id0MD/i1dPv8j4QRNcjwqXa08LyiD1tLvUlh0WhQhq9dlR25YwzEGMRHkshchX2SKONrQ7BqPqekH4wfUEfRL4rCo0EdnDl77RAmnkbuDTwiGr7AQ+sNw+r6wvSykZvP9f8nIMAITtne0/DKlsSkvl3Rk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFj+xBI2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a8fba3f769so9148825ad.2
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Feb 2026 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051069; x=1770655869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbhWXNt6R+bbY45my7/0cdZ1hSkxZU69wC4//UhDbUI=;
        b=TFj+xBI2cDJIW6edY95W0sVUyBNIYoLGODn4OiAR3vuH/62y7OeL+tSO1oJPzHersE
         FkjQXIpJ9e5aGt5vvP92YHZGmyAsxRKy8DDsH1zHWi1hP4HPyc52BO0kU3n6HbDzHOm9
         oPe8J3T53gVUPMJg6zrLVR+rI2Qk5QxCjKCguUvIExiPw8JmMZFxBpQnk5g3B2D0Jomj
         Dh8h7liPzLtfVfavOWXkt0144gAdt5yaYnvNETEsgF/WqotmqpU/iN7xZwVK8UndyMAA
         hPxqr+lBtrujKR9JGKhSALnvZVsVrhRo4mZEHVQ28iSkL6XxMqEe7/AenRM0TAsh6Mps
         UGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051069; x=1770655869;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lbhWXNt6R+bbY45my7/0cdZ1hSkxZU69wC4//UhDbUI=;
        b=QIAjqh1gU8endeQ5SbEhrsy5oZ9DIoGXca3NL7WK5AKYBbdFph+6iiR9rqOEAEDsXT
         9+TFMF+0JOYDwcy2bKrnot3VHseIduQZwWj/CVOx5yyng7PfuXFG+ug+2tujCDISuhKE
         6bSqKtYukMWa5i2AkUiQDQMI0k/lPN4ybluIJUeYVUNKkxozdFzy5Aq1OcqNCGrPxXfT
         USdeq7briuz2YvsDEcFTY+aEyIxLur/ujriq0w4aXu+J9BmvOABgkHApuD9cc/Haiu43
         v5DDi1cQ67AMsFzWdKoZJTVrGn79VgQMfVzKOaP288v6DDfVEuxlmJRLoxJjJFRPOO7c
         6GVw==
X-Forwarded-Encrypted: i=1; AJvYcCWfCDOHezVtBa174oDh4Zd8u6mdhrYmaEkRiSnGKjo80al8hnSTzMwR52xr5KxwCnvIBhG+Rcw51QTMj8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHABoD6riSrlwh8snc24qvfvmTyCDM+1vNszBt2ajrUfno6V1y
	H46ScOXF8X9+lT65c8TlbTBqVcDhG24H8pudPQWrdx4bZcMZJu+NjKWa
X-Gm-Gg: AZuq6aIgV1kUVzC1QwV36TDQTL/lR4WICbVP8uG+2CftOqZOuyTGKll3j6rt08bU73m
	f5WYlrykerBOUPyBYFQQGVbgudIKwsVne6ommjsxBjijc+IDSqLGZWq1UFqzBMW4cfIDsTdNR0H
	Q49RnXbZh+ETzhImBL24lJcEp4BwiadbBRWLCPvaHnDhSYU7v9YhxNujqvBl9zpM0eUXe/EC6XB
	33NX0HrfweZ4HjhhC8vdNh7WqUGvucMcBkaN+HDQCzU3Uu1H1LhsZDbdFtbarj9lJzyzNgnpxPQ
	8ma9wM6HzcHhIfpOY5qyGQUsS+7xBzy9FkTV0+h3aUDWsPv5pYYcnvzX2H1X/fbUOSvbgJHvXpQ
	4Ww4HPcp7H6OStHjAf27mfb6LY7aISBsT/Sl4Fxj5Tz0WtsWYZMjUm7FH4dn4vQjpXUkxiVTC53
	eD+JOnBkRllvZEbZ4xNspCg3nF2mw/hBeQHtwi+LEVR1IWo/ALwrIPi6foxhiySsIYzwcKvaLnW
	1Kl
X-Received: by 2002:a17:903:388e:b0:2a1:3cd8:d2df with SMTP id d9443c01a7336-2a8d9a75e18mr124606865ad.54.1770051069259;
        Mon, 02 Feb 2026 08:51:09 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f9a42sm154742675ad.99.2026.02.02.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:51:08 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	skinsburskii@linux.microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mshv: Add comment about huge page mappings in guest physical address space
Date: Mon,  2 Feb 2026 08:51:01 -0800
Message-Id: <20260202165101.1750-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM_DOM(3.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8642-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhkelley58@gmail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:replyto,outlook.com:email,outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48932CF2BE
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

Huge page mappings in the guest physical address space depend on having
matching alignment of the userspace address in the parent partition and
of the guest physical address. Add a comment that captures this
information. See the link to the mailing list thread.

No code or functional change.

Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/mshv_root_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 681b58154d5e..bc738ff4508e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
 	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
 		return mshv_unmap_user_memory(partition, mem);
 
+	/*
+	 * If the userspace_addr and the guest physical address (as derived
+	 * from the guest_pfn) have the same alignment modulo PMD huge page
+	 * size, the MSHV driver can map any PMD huge pages to the guest
+	 * physical address space as PMD huge pages. If the alignments do
+	 * not match, PMD huge pages must be mapped as single pages in the
+	 * guest physical address space. The MSHV driver does not enforce
+	 * that the alignments match, and it invokes the hypervisor to set
+	 * up correct functional mappings either way. See mshv_chunk_stride().
+	 * The caller of the ioctl is responsible for providing userspace_addr
+	 * and guest_pfn values with matching alignments if it wants the guest
+	 * to get the performance benefits of PMD huge page mappings of its
+	 * physical address space to real system memory.
+	 */
 	return mshv_map_user_memory(partition, mem);
 }
 
-- 
2.25.1


