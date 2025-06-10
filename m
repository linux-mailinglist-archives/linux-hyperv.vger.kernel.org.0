Return-Path: <linux-hyperv+bounces-5828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA7AD3ECE
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4937A46E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEB2397BF;
	Tue, 10 Jun 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nrtC2IEY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6C235BE5;
	Tue, 10 Jun 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572810; cv=none; b=Uza69B87UQQdaUYXwQYxFCAcWhKiLHhXzny9NN7yDAPM9nQac2Z/PKnF4434C0MTLMGD3oCYArDo1h60YMuFIWxWXLC1z7eDsgysLCKr9sOYBwIRuP1OJDv3lucAp7pPrqjSczCDqEfmfhcbp2QIbHGwH9cRccpaHTjdVLgA/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572810; c=relaxed/simple;
	bh=mC9k0fdVG15ew46QW8+Slf9PIBIcE34tXUWoO9ub0rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTsrCyrZ+gI/2bztqd4qr6tVA+zouulmRK8OaAla46SbqOsCbzqYrV+Llk9tcafSfPCwh75m9kjHbxr03jNTSsW/jyFypLXj+ng+A1zrec4HmhROJ0O0FFqU9fyg8qKqDaY4bVyoqrjOKVKxEJKGWPsUGArAy6aZKXcrioBU7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nrtC2IEY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F5062027DFC;
	Tue, 10 Jun 2025 09:26:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F5062027DFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749572808;
	bh=fZsOQ9xkdUCNfFEMQvxKs+b33M0TwuoWd4G5YXW58m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrtC2IEY1KeGmulZSt4zgXDh0kKtjcT7SvNywOcN+nsUpn8S1DuWEFOW5ZuflmXWE
	 gcdSe+9KEIGk+2C0UesKrWYzEwnz9OojeOn5FpWX0Xlynj0qhzn0jlt/nKDCO/jt0q
	 JcfiFCOtgin5EIVI3kM67IjP3kmEBKhfwoKkYhfk=
From: Roman Kisel <romank@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: arnd@arndb.de,
	arnd@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nunodasneves@linux.microsoft.com,
	romank@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org
Subject: RE: [PATCH] hv: add CONFIG_EFI dependency
Date: Tue, 10 Jun 2025 09:26:46 -0700
Message-ID: <20250610162646.15865-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue, Jun 10, 2025, at 17:33, Roman Kisel wrote:
>>> Selecting SYSFB causes a link failure on arm64 kernels with EFI disabled:
>>>
>>> ld.lld-21: error: undefined symbol: screen_info
>>>>>> referenced by sysfb.c
>>>>>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in archive vmlinux.a
>>>>>> referenced by sysfb.c
>>>
>>> The problem is that sysfb works on the global 'screen_info' structure, which
>>> is provided by the firmware interface, either the generic EFI code or the
>>> x86 BIOS startup.
>>>
>>> Assuming that HV always boots Linux using UEFI, the dependency also makes
>>> logical sense, since otherwise it is impossible to boot a guest.
>>>
>>
>> Hyper-V as of recent can boot off DeviceTree with the direct kernel
>> boot, no UEFI
>> is required (examples would be OpenVMM and the OpenHCL paravisor on
>> arm64).
>
> I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
> are orthogonal concepts, and I had expected that even the devicetree
> based version would still get booted using a tiny UEFI implementation
> even if the kernel doesn't need that. Do you know what type of bootloader
> is actually used in the examples you mentioned? Does the hypervisor
> just start the kernel at the native entry point without a bootloader
> in this case?

The kernel is started at the native entry point in "Image", and the address of
the DeviceTree blob is passed in X0.

There is a "virtual baremetal" bootloader [1] that prepares DeviceTree for the
kernel, sets some CPU registers and jumps to the Image's entry point yet that's
totally headless except for the optional serial output. No ACPI or UEFI is involved
at all.

>
>> Being no expert in Kconfig unfortunately... If another solution is possible to
>> find given the timing constraints (link errors can't wait iiuc) that would be
>> great :)
>>
>> Could something like "select EFI if SYSFB" work?
>
> You probably mean the reverse here:
>
>       select SYSFB if EFI && !HYPERV_VTL_MODE
>

Right :)

> I think that should work, as long as the change from the 96959283a58d
> ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests") patch
> is not required in the cases where the guest has no bootloader.
>

That would be awesome!! I can't see the pro's and con's to arrive at the perfect
solution quickly enough and am mostly driven by the sense that unconditional
EFI seems superfluous. Again, I do understand that the build is broken, and
something that fixes it fast should be the best solution.

> Possibly this would also work
>
>      select SYSFB if X86 && !HYPERV_VTL_MODE
>
> in case only the x86 host requires the sysfb hack, but arm can
> rely on PCI device probing instead.
>
> Or perhaps this version
>
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -19,6 +19,7 @@ config HYPERV_VTL_MODE
>         bool "Enable Linux to boot in VTL context"
>         depends on (X86_64 || ARM64) && HYPERV
>         depends on SMP
> +       depends on !EFI
>         default n
>         help
>           Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
>
> if the VTL mode is never used with a boot loader in the guest.

The VTL mode uses the direct kernel boot and a DeviceTree blob, doesn't
need ACPI and UEFI.

[1]
https://github.com/microsoft/openvmm/tree/main/openhcl/openhcl_boot

>
>      Arnd

--
Thank you,
Roman

