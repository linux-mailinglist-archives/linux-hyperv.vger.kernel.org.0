Return-Path: <linux-hyperv+bounces-11634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xlLHGIBxM2qBBgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11634-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:18:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F369D7A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:18:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=azwx9mDq;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11634-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11634-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85A8A300C0F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF337702E;
	Thu, 18 Jun 2026 04:18:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B378D70
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Jun 2026 04:18:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756285; cv=none; b=RoSoFBDjUxScxRs9pZo91l+nbhGwNSMYSuJcOOBQFSyLdHcSVF6fenFGHmkB4BZjJS5zs3HT/y0486pXQGLCEd0eQhVvBgR0gHsE/+3/klNFK7HJYAbLRqqtH5Ia6DcHZAGZ9wjsPgKFNhMSHaeOF3ZuEkyunqdsiZTiHNYXpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756285; c=relaxed/simple;
	bh=YZVjxHytK6JV04yDSOVmcLzWgf6HDh5iivbaDRspdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiBLk2Qy/v2+QEbNbpGaRtenkkW7m4d/xfgjJzrGrb70tG1USIE8YspAnVnj/XtMMO65z6iYsWWRx22gctzgFrMobWmc+vIZjOEQZ3EvHQ16VJaiaqUayvU9if9biXqPDlBq3ywUyHCxTaenzzcEKvpjDSQM+MPn4up7RWcyq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azwx9mDq; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6fcfcdb2bso318475ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Jun 2026 21:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781756282; x=1782361082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHvs7Qp7jp88X6reSVKZtHJFIAjpU0BO9YqmUs6J9W0=;
        b=azwx9mDqjiOab8zfLW0HwwvRh6J0ltQ3z1PWSlzm5srJNsRuf1qI6Z7a2/4euq2H9O
         XzsgQC5VZUM/1WdBjbcfDJ3ruk2STuMFQE0LnxNgxQmTaMqtM1xtd+xUhWDTQcYyHYEc
         ntFRRHm2/4U3vD1MwSdkyKnmsPIoZCeB/vpX4Rt37rALoTXvKlH1NinM6NyLy6/XQc96
         NUmWg2xxvPFIrweYu877pz/N0ztWsD3M7dYbkB6Fdu6yAAObnLkoDuHs8eNbA3j1CQ5U
         oLA0ImRvpq5YlG9D7sk89x06HxTiF/WN9bIrm68hnCMKhid50/aLcxyscq0qaL5E8Ewa
         8uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781756282; x=1782361082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHvs7Qp7jp88X6reSVKZtHJFIAjpU0BO9YqmUs6J9W0=;
        b=aYgqycxM5hDjQvdwz334cypEBtG4yxP0AMKMUPU4v61x/pvPf1xfOJmux5fC5LQsI0
         KDgTZxeUr4DVLhhYJDaUgldn7KCGYYujUpZweW7NXFGfEYceyyEHyPOh+4oK3WpzZLFg
         xFfy76LaMO47ENPSI/opBfruopUzb6sJd4PgU2MtovBcC3ymn6gF4YA59uOPzr4uGqK+
         VptdvoI2D+YDQ4wMTm671s+/b01GRl3peRKmewYIjEJSVUSlpA6oIKY0eWdnjYw8wuTk
         2Jm3zyB7G+CSyZYWpOz5jlfbbdbRPyCkW/q9AneXZdA+L+oNpiHkCkuTyV5r5Rf2WlqV
         O52g==
X-Forwarded-Encrypted: i=1; AFNElJ85yBW93v5qiUckPwJANovDFpE9BpplZlmw5xgPXi4jKCLi6M1SsPtjTBNrYyHxSqhkhBQAXAYoKFlhWd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhFQN5Z96+XCOXJsDE5jz+IsbZTcZrax6siiXMtKdA/nFyYbv
	M6tTdxY5mdzgBpA+yJZCQL+KmuuyLb7OpWR8ph96/n4aX6ss/fc4DVlF
X-Gm-Gg: AfdE7cnN6DM8e8fVTVJqS5TjMRsmk4aO8fktIeXzS8Ccv0eOz7w2Ktpbq4XQClxK0n8
	p2D6mbizeu/J1QSUXRvhex5b0mGilCX4USwBUegRZjuwWFZPK6nnawxtherJLolpcIpmSho7ZbN
	zlesBOFTuXFrqAM70XOXpDbfJomPZ0CSK8XXSy1XJi8H5ipYqQooAMjZ4e1Bvt2l+Hp6SHHIETM
	zTdKHmT/3lBK9C/3Gu9M/RYEyJSSCEVpGNxCRvL/jaD9nW4wr0fvkusalM8rI71v9jNkI5B66yD
	Xv6z+f9lXqyl6/Zi6FWJDSMWAiMfsxC1bw0z6PviHrZZ/Gfn83JeEh2i9L4lokW1U9sQ0XYZBNY
	ul3OJrRiggbR0/B0YuVtE1fIXmC9weVCvr03cynTcs9R+NUVeje2sCxt4tdtfOLiOztzc7p+g1G
	JkpS6QKyrhaF1rvZPDFSx8xUulp3eCAG9s
X-Received: by 2002:a17:902:d2cc:b0:2c6:8eeb:a7c5 with SMTP id d9443c01a7336-2c6bc252f5fmr69903275ad.34.1781756282242;
        Wed, 17 Jun 2026 21:18:02 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:c19d:3f9a:e9ce:93d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6c4689ccfsm34516645ad.66.2026.06.17.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:18:01 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2 2/2] RDMA/mana_ib: initialize err for empty send WR lists
Date: Thu, 18 Jun 2026 12:17:52 +0800
Message-ID: <20260618041752.481193-2-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618041752.481193-1-ruoyuw560@gmail.com>
References: <20260618041752.481193-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,microsoft.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11634-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 021F369D7A1

mana_ib_post_send() returns err after walking the send work request list.
If the caller passes an empty list, the loop is skipped and err is not
assigned.

Initialize err to 0 so an empty send work request list returns success
instead of stack data.

Fixes: c8017f5b4856 ("RDMA/mana_ib: UD/GSI work requests")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Split the erdma and mana_ib changes into separate patches.
- Add a driver-specific Fixes tag.

 drivers/infiniband/hw/mana/wr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/wr.c b/drivers/infiniband/hw/mana/wr.c
index 1813567d3b16c..36a1d506f08f6 100644
--- a/drivers/infiniband/hw/mana/wr.c
+++ b/drivers/infiniband/hw/mana/wr.c
@@ -144,7 +144,7 @@ static int mana_ib_post_send_ud(struct mana_ib_qp *qp, const struct ib_ud_wr *wr
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr)
 {
-	int err;
+	int err = 0;
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 
 	for (; wr; wr = wr->next) {
-- 
2.51.0

