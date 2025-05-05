Return-Path: <linux-hyperv+bounces-5350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C2AABA5F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CE51889D81
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C72D548E;
	Mon,  5 May 2025 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIGfPcbl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BC2D5489;
	Mon,  5 May 2025 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484617; cv=none; b=mY4grY4eKNCIcRSFWRFQM4JFRGjmYe/ETmgcQI8mdltuShjIdpSXdB0nDnqCXzSkR8WrPQqYZWRrNrWbvgZzZjeb/4oHeSrz0cyMFk+r6GLSfZdmQa0Ta+efn/20k03OXG+vk7+h9fBYc+2LlPYJKzOVzKIsI2iL3o2XPX3wBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484617; c=relaxed/simple;
	bh=4z5bQ9xiMoopi0CZXN8uUN7kEuCig4/cpWfz7ZNYzzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qauRDpFZrbvccXktYKDN26SGS42LzenlTMASj3rS3BadFV3Uwj7zbYNbomCFkcZ8vCOhydoZJ4288jFztjSo8d7ptlE3SxQatWQIR8CxreDW6aFNqQHxpMVqKG2ofvL+Wcq086BpMHSbOuOP2mS+9qDjZAAf2zOiJn+5ND1J2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIGfPcbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EACCC4CEE4;
	Mon,  5 May 2025 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484616;
	bh=4z5bQ9xiMoopi0CZXN8uUN7kEuCig4/cpWfz7ZNYzzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIGfPcbltl0MtJVA/ACrAng2p9XTN0GwvX3RoxUC6f+mCMJdYWV/NVMMpGRVPIoP9
	 3N7PLhMyYzZMcS2qXLPqpveihD1hLl8FH30KMi551sp/VIZlDgPWwYJWXXhxvZUURr
	 8goclU0+D8hzPTG17koJDwiUzx8sCrZ/8bHJ3gN04/r+btQ3pSC+D63x7OO/MShc8p
	 DSz+vg+8rJdlGeRTdhE11iSuM8oV998ENTvhPsri0ljhhTKsAr5NG6B1g/YboHEdO6
	 LsM1C4tFyQaUHuEmZ7iPSGZirnPw8F0qXsqAKi7n3Sm2LYBqOgdcKZ01s3EBDrhMQl
	 q9+OrzA269IOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	mlevitsk@redhat.com,
	peterz@infradead.org,
	ernis@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 563/642] net/mana: fix warning in the writer of client oob
Date: Mon,  5 May 2025 18:12:59 -0400
Message-Id: <20250505221419.2672473-563-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 5ec7e1c86c441c46a374577bccd9488abea30037 ]

Do not warn on missing pad_data when oob is in sgl.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://patch.msgid.link/1737394039-28772-9-git-send-email-kotaranov@linux.microsoft.com
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 638ef64d639f3..f412e17b0d505 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1047,7 +1047,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
-- 
2.39.5


