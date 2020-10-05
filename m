Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6612842FF
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Oct 2020 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgJEXht (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 19:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgJEXhs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 19:37:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E87207F7;
        Mon,  5 Oct 2020 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601941068;
        bh=alrgM9k5I/Vja+EvD0IFWV5aNvNpxkYLyuOosw+D8lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7LFgZOAJZXvemvuVWXt5lzsQGq0KkehpvyMyywyGdpacT3Qjwv07d5BZt6TrCWqb
         D0OixPmuBn2E3hBVOZNWpUjzBHuFt92DXJwV8/VZGtXiQv6Xkj/QHqxUC3g8XxGE13
         unW0g97/L5j8V1JR6YVrV3P/M4s0+JijSbhIPjbk=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 2/2] x86/hyperv: add a bounds check to hv_cpu_number_to_vp_number()
Date:   Mon,  5 Oct 2020 19:37:39 -0400
Message-Id: <20201005233739.2560641-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005233739.2560641-1-sashal@kernel.org>
References: <20201005233739.2560641-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We have code that calls into hv_cpu_number_to_vp_number() without
checking that the cpu number is valid, which would cause
hv_cpu_number_to_vp_number() to dereference invalid memory.

Instead, have hv_cpu_number_to_vp_number() fail gracefully and add a
warning to make sure we catch these issues quickly.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/mshyperv.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c5edc5e08b94f..c7d22cb8340ff 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -125,6 +125,9 @@ extern u32 hv_max_vp_index;
  */
 static inline int hv_cpu_number_to_vp_number(int cpu_number)
 {
+	if (WARN_ON_ONCE(cpu_number < 0 || cpu_number >= num_possible_cpus()))
+		return VP_INVAL;
+
 	return hv_vp_index[cpu_number];
 }
 
-- 
2.25.1

