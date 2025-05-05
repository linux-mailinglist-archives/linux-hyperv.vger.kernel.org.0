Return-Path: <linux-hyperv+bounces-5353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE78AAB4A3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F81BA2856
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 05:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C338A9A6;
	Tue,  6 May 2025 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8zV5/bc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A62F1CC0;
	Mon,  5 May 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486775; cv=none; b=FUFKGGIu+V7MtieOnuCxeGj061qF/7iZZsGVh15np/aCre4UEfaKrJsZruEZXbVuxm00FNdoOWyHm3lLMspxp5zl2/QKe4WrucGp3jWybNCv1sMCO2JO3oegIPtFpMji3kmdAlJ/WvlD28Z8MILgfZx23+RbjQDAMj/tpxr9yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486775; c=relaxed/simple;
	bh=mJNYIOLRP6hvW0SxNCmdphAtmZ6oNfD/R+SEJP65BXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GowCCKy2/K8s8jvp05oN8gso1kyiU+tVpNjL7oyJCUjN71nNZ2qyOtVTMSXHg+WxSjq/1BsC57TBpZKEgPwM/5uC3R2xgYjnd8+tr+VHy6usTBNddfk3iUYI5wb+uzE1unEe8/ddobby8w1Ttu6X4g3RsxBxvQpB7rV9n8ZKg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8zV5/bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99115C4CEE4;
	Mon,  5 May 2025 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486773;
	bh=mJNYIOLRP6hvW0SxNCmdphAtmZ6oNfD/R+SEJP65BXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8zV5/bc3qKoPowCIYtYiDz1vWSXl+nITNUTADvpYVyA6jE53viL9xT8U/1EZcLCa
	 7DKajy+zrmTaUpvUzmHBEuwTqA+vaz0iJP6BmAKBZvaRJ6t9Bl3WSB4lujrDSp85Zj
	 kDoQ3tHST7m/OecJRo59e3HaD84DSNoas80AzHvzjy0PHwwrdidDesga+yC5SeOckB
	 8Gsv+TftOaT0ANqh0q7m4jEivl5dI8RpKvxn3GUAkMeBdysoVHwrzEHxmQGLaXQgtP
	 +9xpuYYjlvrw97MxvtUT7O5bvdo5jgSxlKn11c/W/bLBA74MJ6Fhcych0M+qsVA8Az
	 GpOEoLxhMgN4w==
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
	ernis@linux.microsoft.com,
	peterz@infradead.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 195/212] net/mana: fix warning in the writer of client oob
Date: Mon,  5 May 2025 19:06:07 -0400
Message-Id: <20250505230624.2692522-195-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index d674ebda2053d..9e55679796d93 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -995,7 +995,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
-- 
2.39.5


