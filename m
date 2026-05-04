Return-Path: <linux-hyperv+bounces-10609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIbDCmbw+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10609-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:15:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2B4C31A2
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F66E30A045C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07953F23AD;
	Mon,  4 May 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bYA239Ck"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DC3F210E;
	Mon,  4 May 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921811; cv=none; b=HslwkhH8zUo8YD2eVSFBLcRQEzVm6L8x7LTxwKqkUZ5jIiNPGUko0Jogl5hMpCu2BOSyxfhrPbvsFcnS7r/IRyvHu/4/+ZLrSx9E+2Yu8605sJxIvmAmvXNfUW04/LFD0AzVPl5Nqe/QOnp0mO0o7qy8LxCN56Hw52xg8j/DcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921811; c=relaxed/simple;
	bh=yR05Ym1AK0Jl++YS+XctaZlcklI0mvQLkQoc5tcqI+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQAmOVJeTwcjKqBPSs9Px3QR/FqMfmyKgnazU5cJr31dW8b/9zOO8AijK4LMnKvTKAbYXTnhTgn6q0I/klcy/F1KAPtKMuY9S1cmNnJ+uCUxiXxpxDRbAwmC6+y0cLl0xQK5eg6KpnLpKobbSy/H33HJf+5q1BJ2M0v/l500kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bYA239Ck; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A28520B7168;
	Mon,  4 May 2026 12:10:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A28520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921808;
	bh=87tNYX28578TbQ/WZVTI1fpmbD937uZ8WwF9qck16Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bYA239Ckv0+3vOjYbyqe1BPHq8jk9kqXF9inOJvjLSxoquIkSBNS/24czEMMqkwEJ
	 DwxFGbTRcnqHyZn5uQ+lpibxsh4PU/RpjduzkSXr9yVUjr2hMCpOHsZSWGOIWiCa6g
	 8ujMAtvSiHo9gOi6i1WH91Xf6hHnqf4rfuJqQjTY=
Subject: [PATCH v3 14/18] mshv: Use kfree_rcu in mshv_portid_free
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:09 +0000
Message-ID: 
 <177792180986.90827.4866317696948380714.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DDB2B4C31A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10609-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

mshv_portid_free() uses synchronize_rcu() followed by kfree() to
reclaim port table entries. This blocks the caller until a full RCU
grace period elapses, which is unnecessary since the same module already
uses the non-blocking kfree_rcu() pattern in mshv_port_table_fini().

Replace with kfree_rcu() to avoid the blocking wait and keep the
reclamation strategy consistent across the file.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index d6884c601b298..1ccbafe7aa596 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -62,8 +62,7 @@ mshv_portid_free(int port_id)
 	WARN_ON(!info);
 	idr_unlock(&port_table_idr);
 
-	synchronize_rcu();
-	kfree(info);
+	kfree_rcu(info, portbl_rcu);
 }
 
 int



