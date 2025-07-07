Return-Path: <linux-hyperv+bounces-6131-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB5AFBA40
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D439D1893939
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B12253340;
	Mon,  7 Jul 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Juecdsl1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751222DFA7;
	Mon,  7 Jul 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911196; cv=none; b=NryLfRp60hLi27+Q0GxQ2oIXEkoeXMFi1vILR9Ml/ixszMFXr5EOlZv/2cPD5wRdfqzUFGdw+Tfj+34phAM43VAV4jqE8KEBoHK6qbSltjMj4k38RiKzoJOO8Iw+UEJloma68B2cSz/THVmTnjYuPqTyYu7S22QHSaLqZX85dI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911196; c=relaxed/simple;
	bh=h9zvtpIR/kBrqJ1m+JHFjDXxih1BE7QfRuvA9R9sl6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImjG0hW5NjEa/3qpsFr3GXoWehyJQ77OBRWr+3GY/nF3hSssaw841oRVf6iA09ALcC1inlV5J2Z2NDzcFBhJ9MK5HhOKSnBwdzbv0TsAJVBFt3LglWtGWMbi+nKPHUa2gmSwymCJg5D8AipydFZlZhhfvNkn26VlZ3LxfAGVf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Juecdsl1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D1D5F2054680;
	Mon,  7 Jul 2025 10:59:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1D5F2054680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751911194;
	bh=zeLAABhUJntnMN2QCq43FYeskbX+YlDSGreNuuisNvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Juecdsl1txvCzZfEQkRt9uMv4iD/sqsTLX/Z4Zocf1oI/sEohn9j7DO2um+iuzkVW
	 u6o7vh5phHfXHeLAu1JA5p4xqBQ8r6rK2WAyhR11fjtzCU88jBJ9K9s5Gm6zuD52yL
	 kedkEmAL/LQxnsCX/alPbUhYJmbfZssgoP6GfWiY=
Message-ID: <adbceaa3-d5c2-4878-ad75-dab230bd8b8d@linux.microsoft.com>
Date: Mon, 7 Jul 2025 10:59:54 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is
 enabled
To: mhklinux@outlook.com
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, deller@gmx.de, javierm@redhat.com,
 arnd@arndb.de
References: <20250613230059.380483-1-mhklinux@outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250613230059.380483-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/2025 4:00 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Commit 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB
> for Hyper-V guests") selects CONFIG_SYSFB for Hyper-V guests
> so that screen_info is available to the VMBus driver to get
> the location of the framebuffer in Generation 2 VMs. However,
> if CONFIG_HYPERV is enabled but CONFIG_EFI is not, a kernel
> link error results in ARM64 builds because screen_info is
> provided by the EFI firmware interface. While configuring
> an ARM64 Hyper-V guest without EFI isn't useful since EFI is
> required to boot, the configuration is still possible and
> the link error should be prevented.
> 
> Fix this by making the selection of CONFIG_SYSFB conditional
> on CONFIG_EFI being defined. For Generation 1 VMs on x86/x64,
> which don't use EFI, the additional condition is OK because
> such VMs get the framebuffer information via a mechanism
> that doesn't use screen_info.
> 

[...]

LGTM.
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


