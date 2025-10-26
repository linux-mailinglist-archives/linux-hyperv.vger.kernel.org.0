Return-Path: <linux-hyperv+bounces-7331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568EC0AB09
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Oct 2025 15:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2924C4E9EEE
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Oct 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35E2EA14D;
	Sun, 26 Oct 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IisAOiVo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B722E9EDF;
	Sun, 26 Oct 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490213; cv=none; b=Q+ExCnFmkyi9IQw5a92cfMAbrDJRoT55N3OGE6Xv9Ja+z4kjGGcqc/8nUfN/5Gnf7k3rEwN8/IR2SOspv/W+orTObOl462OazeszApzt7BwuQoqvk1ziZezKbq5EHfwEQ2Esh40aUwSGg/STx9Jhbw3P/HHeTMNMOy74iTIH4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490213; c=relaxed/simple;
	bh=ojPfbBo/Lc6hYZIEwbwJYWRM8SKQMjVIno53UELYJ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6wvCrwYixQKo9g3H6Y2uA27kfxxn/SW8QDZGkkQgTfPSLLEZolswacVIr6lTPoP3Ye0n4wpoZLXOD0XivoEycs5cWoxX9eRREO2sRGwdmT0Vz45kmCkAtPPAYnB3wA0gt0oPGnGWCip8XuC9V0vKgdprovIGdqKXepbfbygUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IisAOiVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1CEC4CEF1;
	Sun, 26 Oct 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490212;
	bh=ojPfbBo/Lc6hYZIEwbwJYWRM8SKQMjVIno53UELYJ4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IisAOiVo65sa09KFdempEd/g529KhcQW8Hl2iXQg6INAgLoHE8t2e65an6JL/MHgk
	 wdy/3nfPphKA55FQETF9I8Iokr9gHooQD7XIZ5Z+dMvMay3EGFO9XA4TqohwMJ+MOX
	 Hqg5/1f4ayD382YfTQM1ZFnIUERadb+JppQuKq3DMzWK0KbJWAeX8+gD3+8pwz9z5f
	 hCyq42ozcbJNNYac8uanP753GDK2+I5RDuLhgH+CSw1TLVAnJqc4XrHp9312BXIFFK
	 FLy6tmRjrv02NpThyHG4F+N5O67tOa9WeQWqdvde8/IUXEywZnjAl17HBzFn6JHBNy
	 jmhqtgGiw1BBQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] hyperv: Add missing field to hv_output_map_device_interrupt
Date: Sun, 26 Oct 2025 10:48:46 -0400
Message-ID: <20251026144958.26750-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026144958.26750-1-sashal@kernel.org>
References: <20251026144958.26750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nuno Das Neves <nunodasneves@linux.microsoft.com>

[ Upstream commit 4cd661c248b6671914ad59e16760bb6d908dfc61 ]

This field is unused, but the correct structure size is needed
when computing the amount of space for the output argument to
reside, so that it does not cross a page boundary.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES — The change is a low-risk ABI fix that prevents a real functional
hazard for the new Hyper-V root-partition path.

- `include/hyperv/hvhdk_mini.h:302-305` now models `struct
  hv_output_map_device_interrupt` with the host-defined
  `ext_status_deprecated[5]` trailer. Without those 40 bytes we under-
  represent what the hypervisor actually writes back for
  `HVCALL_MAP_DEVICE_INTERRUPT`, so callers reserve too little space for
  the result.
- `arch/x86/hyperv/irqdomain.c:21-64` takes the shared per-CPU hypercall
  output page (`*this_cpu_ptr(hyperv_pcpu_output_arg)`) and hands it
  straight to the hypervisor expecting exactly `sizeof(struct
  hv_output_map_device_interrupt)` bytes of room. With the old, shorter
  definition the host still stores the extra status words, which can
  spill past the area the kernel thinks is free and into whatever other
  data has been staged in that page, triggering hypercall failures or
  corrupting later outputs.
- The shared-page allocation in `drivers/hv/hv_common.c:470-498` makes
  this especially risky: every root-partition hypercall in the kernel
  reuses the very same page, and several (`hv_call_get_vp_registers()`,
  `hv_call_get_partition_property()`, etc.) rely on the struct
  definitions to know how much of that page is safe to use. On big
  systems where the IPI/vpset variable header already consumes most of
  the page, the missing 40 bytes are enough to push the returned
  interrupt descriptor over a page boundary, at which point Hyper-V
  rejects the call with `HV_STATUS_INVALID_PARAMETER` and MSI setup in
  the nested root partition fails outright.

Given that the regression was introduced with the new root-partition
headers (commit 0bd921a4b4d9c) and the fix is confined to restoring the
correct ABI layout, this should go to stable kernels that carry the
root-partition support. After backporting, run the Hyper-V root-
partition interrupt mapping or nested MSI smoke tests if available.

 include/hyperv/hvhdk_mini.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 42e7876455b5b..858f6a3925b30 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
 /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
 struct hv_output_map_device_interrupt {
 	struct hv_interrupt_entry interrupt_entry;
+	u64 ext_status_deprecated[5];
 } __packed;
 
 /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
-- 
2.51.0


