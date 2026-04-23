Return-Path: <linux-hyperv+bounces-10346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJWAIXBW6mkhxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10346-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:27:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B14557CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03913300BC90
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268403A7859;
	Thu, 23 Apr 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5mEC6gB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411D3A75A2;
	Thu, 23 Apr 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965218; cv=none; b=jA2ut32fVzr6jDIq8zDNHbCdkj43r37lCgL9erJx0BDdGwofIXoURaxZS2TA3lXBMNpc2Yg1mVIdCg0187DTeqP3usvm8z24/2saQJWMqiefPQbUArYpd7nw0GvouNTwEQKjlPBWXIA5vyXN7S3dXdsm7p59tamepoQlP0w7g0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965218; c=relaxed/simple;
	bh=4+ZpLISoNIRbHqDjv0MBVGx4X0awsHsYwas0EO6i6VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OhnsbgZtjJDS1j8G5MyKyejVHMNyRHYCefm7ctoBbUvrySQbxKHBzAsky+oGWMxM8Y9+8cufFm08QdLl0ByKTl+t/W5UxuyG55JdZSOYFX0vV1Kkp/NlFHEUdXwPHkEf+X36XPYZavSQRIcKTFcfpCIC24Nh7SXuZqOm8Qr84wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5mEC6gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1E5C2BCAF;
	Thu, 23 Apr 2026 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965218;
	bh=4+ZpLISoNIRbHqDjv0MBVGx4X0awsHsYwas0EO6i6VM=;
	h=From:To:Cc:Subject:Date:From;
	b=Q5mEC6gBa70Isfvqtz1qcTZOvq6kqHsLgruTkEsJDH9NIzgVuotgTyq09m5a62bYt
	 ExCI9GA5IMg1FJTOt1GS16k7FADizKpecoicfbdHJ50ix7rB5xf6WaxP4iHjTJNKgn
	 qxwdGKZTm+ryVmcDxRaRCY9294F0VJDwF5IBnibBYunVFteyDmTewb8bhMPSBU5Mgy
	 38HSLNnBZyA+1AkkmYvL56Iue2PJSEvebD83MBKKSrgXt8BMAkxjy9N4y9mrR+GiNi
	 jKN8qvs4722IpQJeU/GpSVCNfupMcVPVSxGv86O+UGH4YIwLWWzn/Nq+0NXTLqFSQM
	 +0iT2UxKB4sow==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	=?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mshv: add a missing padding field
Date: Thu, 23 Apr 2026 17:26:26 +0000
Message-ID: <20260423172625.1189669-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10346-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,microsoft.com,outlook.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F18B14557CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Liu <wei.liu@kernel.org>

That was missed when importing the header.

Reported-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reported-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
Cc: stable@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/hyperv/hvhdk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 5e83d3714966..ff7ca9ee1bd4 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -79,6 +79,7 @@ struct hv_vp_register_page {
 
 		u64 registers[18];
 	};
+	__u8 reserved[8];
 	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
 	union {
 		struct {
-- 
2.43.0


