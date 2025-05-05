Return-Path: <linux-hyperv+bounces-5352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C9AAB700
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9638501E32
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52024467E;
	Tue,  6 May 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swhuWzAO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479322DA19;
	Mon,  5 May 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486339; cv=none; b=E5YpuCgVm0ObSu+y69McP1d5U5fOQODTZ8N7ViAzdJTUb1BmFX1zoiWYTtDSf6f4gt2tEhFZqQKXInSbbEK2QFImk3pYjGkPwmD1tGlRHN1TBt56jwjuQifIV0CelPS9tGnAqz7hbh/mGQgcA6w66zzL8hI5Kz6L9EnInMnxpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486339; c=relaxed/simple;
	bh=2u6Eh01D/YCrOniXldfPNcHZoJwjvrn7z0cgzVPU55s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7KQcF0TtSUNr7zak3P9SjX2nWTk4wAn4bbYMf59PES9VkvTP1tbvwcvT1fPx6+M2WPyb/VzBQOmHWW29Gpqk97GbqL5w9GOHR1bd+ERwFBra2jQ9S/11l9so09BykvNowlpMSR+KSXbEkJSHdeJpR3jgN7Oj5IcI3c5PPyKsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swhuWzAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A7C4CEE4;
	Mon,  5 May 2025 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486339;
	bh=2u6Eh01D/YCrOniXldfPNcHZoJwjvrn7z0cgzVPU55s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swhuWzAODz8/zkePAJ0cIGhU85Ogf3zrKzbRL98vI5KMmWyYJOByqFlsOia+GmheT
	 759VDM2Ys/mct6ej7bw/bTCWlBufl1SGr9Bqum6BCThWjxufnyWCZvFH+Srky42kZK
	 D5rVN3BnVCLyTRXsHJU6czuTrtSAN7gYogl/oY8PeqLJeXM1WEXoBdEKduRr1Pg1eo
	 Ki9FzeSzYSoB7K/sAIu/HC/Wno6L6pTQzI2//lR3LNtf/cxTHoMosD5nAP1v319PYn
	 ux1u1IKLCzqYzMQrrx/oKMtMKqZ2zFh9IitXDrPQU2uCeh/JOXFdy/p8s5h32S7PwF
	 twYo6dwc3H5Yw==
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
Subject: [PATCH AUTOSEL 6.6 267/294] net/mana: fix warning in the writer of client oob
Date: Mon,  5 May 2025 18:56:07 -0400
Message-Id: <20250505225634.2688578-267-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index ae014e21eb605..9ed965d61e355 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1036,7 +1036,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
-- 
2.39.5


