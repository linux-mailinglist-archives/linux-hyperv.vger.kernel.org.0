Return-Path: <linux-hyperv+bounces-3531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804159FCE08
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FF91883380
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEE1BDA89;
	Thu, 26 Dec 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cg6DA7V7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F61B21B7;
	Thu, 26 Dec 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248676; cv=none; b=mMpGyx+D8BbOSpwlgdBfacRakPYOMDB01qQHb2t4sgZybPGv+flGpJXvMCMn96DwWOxOwPu+Ge7lcDxaXENdItG3D/6CRCHPFzKTu5EyVdKhDfZ6kSxcuNjvC4bHHHon2S0lpEzretHyVBfHlO8FkH5CZ+XK9zu3RwL9RCtjtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248676; c=relaxed/simple;
	bh=ZkGeGz02JwKVdH+eTEJhF2x4i4dlGF1Fw4okzydrmuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrXBK0Ti90nws+K0/VnnhbmjfxkCLp6EKx5V1CM9z/mNGAlLuNNfhYNr+2lvtPH/ISOBVptW6OQ83vvvBFSkR7DJs0Gesgc4z7PLP4pAHfLuLUyWQpK2x6BStrSfeujytl+NWdq3nJB+r7ZNsTW2csnY0ASFp4lTvirlAoJ+rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cg6DA7V7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 37623203EC29;
	Thu, 26 Dec 2024 13:31:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37623203EC29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735248673;
	bh=XPqSsjJyd0TXcrSTZNSxY+Z9BhscJIkfl20tJAgG8gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cg6DA7V7TN21ZRCRngJic2eSTDxQ9tqziu3YSST/OIVDH7opuV8gLmne4cYPjTjVK
	 sWb3shstJKjZrKar0Oz+Z9BFhok91fTvCSKhAAahY9M8bt1xM7TIyfKn7MCs7wvgsE
	 SkwPXOj+8gZZC58EvCYZkdqvJTeoC7T7+anQZ9dM=
From: Roman Kisel <romank@linux.microsoft.com>
To: hpa@zytor.com,
	kys@microsoft.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 5/5] hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
Date: Thu, 26 Dec 2024 13:31:10 -0800
Message-Id: <20241226213110.899497-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226213110.899497-1-romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
hv_vtl_apicid_to_vp_id() overlaps them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..ec5716960162 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = (u32 *)input;
+	output = (u32*)*this_cpu_ptr(hyperv_pcpu_output_arg);
 
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
-- 
2.34.1


