Return-Path: <linux-hyperv+bounces-8094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F3CE9E53
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12AE33009FE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E822538F;
	Tue, 30 Dec 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="n9VLlv3U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA822FE0E;
	Tue, 30 Dec 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104062; cv=none; b=AsEoCM5qWhtl1AzzPEa4UGGkPy0iQjVcgGEsGxCiGGGw8SLPRAl7v1ZKUYc49ZAtMe40YIh4yxHvz3OqL10QsZ2bMAicwTkYLFhsRlGF7kuPr5wghoNuAK6i2Y+AhRwRi3cEPi/Y2JNYIXbdhzf6PX85yP4Xgl7iwH7xP4s8kR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104062; c=relaxed/simple;
	bh=+cEEOAXRjOmNZmO7VULWEL9nH1JBi+aRzQ/Qf3M0eEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVefWlaOOtCjSDKnSdBwVr+k5kC5fN33o2wACaGNOJvznj3O7C/tNj+AieVKK/Okw4DBJbFULDsA7EUbTSU3nNXavwNFY9fyB21zNuDpxYLVoq7SfVKVkOkW2ongs4hpSFlUIHtZ8HcMK+eKAbS/dwKW/DtGiIs/fUGzVzYkjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=n9VLlv3U; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=113Mno4uvni3seLeOhzXAjiZ5m50yHh5BXE9+PltM6o=;
  b=n9VLlv3Ug/g4cfgNlP/bCb1vsv1mpDbjReUiRSLNr3N/TkG1c5Dewvzk
   00TgJffWqwzes4ZvomlZJ+mlSQbVt7F+nH0wB0FeJGHSlhPfmcNSRdU6K
   4aSbWJZI58rLN4EVucKMADBkCiWo5u87tqhgMScH44lPFYqkNq08V8AzD
   M=;
X-CSE-ConnectionGUID: y1wU/6RgSSeX9B4wOhJCIQ==
X-CSE-MsgGUID: GGFoPO59S72fYilLv+Hsvg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="256348276"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 15:14:19 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: fix typo in function name reference
Date: Tue, 30 Dec 2025 15:14:14 +0100
Message-Id: <20251230141414.94472-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace cmxchg by cmpxchg.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/hv/hyperv_vmbus.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b2862e0a317a..cdbc5f5c3215 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -375,7 +375,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		return;
 
 	/*
-	 * The cmxchg() above does an implicit memory barrier to
+	 * The cmpxchg() above does an implicit memory barrier to
 	 * ensure the write to MessageType (ie set to
 	 * HVMSG_NONE) happens before we read the
 	 * MessagePending and EOMing. Otherwise, the EOMing


