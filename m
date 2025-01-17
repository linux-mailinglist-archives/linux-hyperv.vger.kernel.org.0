Return-Path: <linux-hyperv+bounces-3710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B1A1552C
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA50169D24
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E419CCEC;
	Fri, 17 Jan 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HS4WmeOg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441925A636;
	Fri, 17 Jan 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133308; cv=none; b=XbvmIu6vMXAlkLx+MvAOyVv/QJjIY72t3uQRg399m874JXmo8giYonWuozWGtdNtzGfNp8FBAXOOZYTEKaNQHNjvokTBmUd7JiGVn9VpqwQXaLSADGd/V6AzKXYZkEJCk+WU/cMgbibDbNJaFXHHEcQlcmBAMQrBNG/yy7kvLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133308; c=relaxed/simple;
	bh=0L/L+VwLhP+2Nz4Sawes6nA9aPBfVtIcEpeDR3mt4zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWFaWVeJCRD/TRfgzy9RPazmKEukZswD7cS9bjHlHWDDSm+B/bLOrRKD+uFTtWrSGCsneEGqxogBoTgpQoBvSWj1iOqQ9yUHxMYkvde1Fm7P+GQrZ8jeHsU4uptFCvETt+rM57/RYOF+G+XKkSmqlDUdUyXvdLSBBMkQidSdMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HS4WmeOg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11C7820BEBE1;
	Fri, 17 Jan 2025 09:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11C7820BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737133304;
	bh=gSmaDm3F5c/wG4BQ++dl12j488dT0JYhFCB3CqlNhg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HS4WmeOgnXuDYcJVkdO+Cau47LBdiWPRTYuWGWzHEfkXDleKE09vZg9dx0ZI/ry8E
	 gxXP83hYcUsv2Km55FsdW+P2QlIICSYllQpe0YXGgpji50L+GgiM3mEL0ZcAhO38fh
	 sc3v99rK9cVktCa/ZdF1aVyQglLLMp0sM/9QBgIQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: namjain@linux.microsoft.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org
Subject: [PATCH] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Date: Fri, 17 Jan 2025 09:01:41 -0800
Message-Id: <20250117170141.1351283-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116061224.1701-1-namjain@linux.microsoft.com>
References: <20250116061224.1701-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For Linux, running in Hyper-V VTL (Virtual Trust Level), kernel in VTL2
> tries to access VTL0 low memory in probe_roms. This memory is not
> described in the e820 map. Initialize probe_roms call to no-ops
> during boot for VTL2 kernel to avoid this. The issue got identified
> in OpenVMM which detects invalid accesses initiated from kernel running
> in VTL2.
> 
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 4e1b1e3b5658..3f4e20d7b724 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
>	x86_platform.realmode_init = x86_init_noop;
>	x86_init.irqs.pre_vector_init = x86_init_noop;
>	x86_init.timers.timer_init = x86_init_noop;
> +	x86_init.resources.probe_roms = x86_init_noop;
>  
>	/* Avoid searching for BIOS MP tables */
>	x86_init.mpparse.find_mptable = x86_init_noop;
> 
> base-commit: 37136bf5c3a6f6b686d74f41837a6406bec6b7bc
> -- 
> 2.43.0

Thanks, Naman!

Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

