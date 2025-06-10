Return-Path: <linux-hyperv+bounces-5823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB36AD3D8E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A423A9739
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042D1DF754;
	Tue, 10 Jun 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r22VQRuR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C517C21E;
	Tue, 10 Jun 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569638; cv=none; b=LS2N1p61em3hgsb5dwab1iG7JdS0y4i7GccsUdQPT7fFP+JGlWfqe1wVnHxli4dGgxVn0TnQ7lEp5FXNl2pBpi7w9Sbv0Df1Skmsd0dIL9qRNPIpMSj83UG9zrJZNY7kXPVbfAFj3OxG4PUODUp3lqC8Aef+aKQPHIKfv6W10vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569638; c=relaxed/simple;
	bh=Z0tZqVZm0c0pdMekdv7cs5FM5cbYEF/ngEMiVAIKcok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOhLwU38LY6q5YBW2zoghz1ZHql9jQ2Nwr9lvqzg+oyomHj9b1z7UbrGasCpfTy5w7FiyrDQ4EFI62xrM4IuwerUcEXVECSgsrM42AzVuxmXO9E5xiEVGuGO8PDgi6E3VHp/eJ6Hf3RV7bN0umyNGzhbhJ//QxZEUlE0TsuNzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r22VQRuR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 184C72113A7A;
	Tue, 10 Jun 2025 08:33:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 184C72113A7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749569636;
	bh=EXF5QOvj3gLvyZ3xIYnh29AFDo83SVY+Soxt4pZHHNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r22VQRuRofvzYBhMQxeZbt4tOnDGGJJjNls5cYs0WMTmVuha6Njl+ivrnjfGOidqb
	 LglGuAydHfvm88OFygB5nrlVYtVzDJkSCFCF296b15Sn2o7weVqv/Xn+ZA/v84gxmN
	 f+YjrFtQuscToufIVhPFlUSoXrlZuqR8128DNlrY=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@kernel.org
Cc: arnd@arndb.de,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	romank@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org
Subject: [PATCH] hv: add CONFIG_EFI dependency
Date: Tue, 10 Jun 2025 08:33:54 -0700
Message-ID: <20250610153354.2780-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610091810.2638058-1-arnd@kernel.org>
References: <20250610091810.2638058-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Selecting SYSFB causes a link failure on arm64 kernels with EFI disabled:
>
> ld.lld-21: error: undefined symbol: screen_info
> >>> referenced by sysfb.c
> >>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in archive vmlinux.a
> >>> referenced by sysfb.c
>
> The problem is that sysfb works on the global 'screen_info' structure, which
> is provided by the firmware interface, either the generic EFI code or the
> x86 BIOS startup.
>
> Assuming that HV always boots Linux using UEFI, the dependency also makes
> logical sense, since otherwise it is impossible to boot a guest.
>

Hyper-V as of recent can boot off DeviceTree with the direct kernel boot, no UEFI
is required (examples would be OpenVMM and the OpenHCL paravisor on arm64).

Being no expert in Kconfig unfortunately... If another solution is possible to
find given the timing constraints (link errors can't wait iiuc) that would be
great :)

Could something like "select EFI if SYSFB" work?

> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 8622d0733723..07db5e9a00f9 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -6,6 +6,7 @@ config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>  		|| (ARM64 && !CPU_BIG_ENDIAN && HAVE_ARM_SMCCC_DISCOVERY)
> +	depends on EFI
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> --
> 2.39.5

