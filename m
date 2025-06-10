Return-Path: <linux-hyperv+bounces-5829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88701AD3F19
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB411726C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1628024167A;
	Tue, 10 Jun 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="igEOPax8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424A239E66;
	Tue, 10 Jun 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573411; cv=none; b=tNHMFif9NZl0vzc0r25zwprUnv/T9uJW+gTndB30tIIpMDZYbzs+k3qgsUUZ7Vyuh6lL///t6RPJSiu+TP8WewQ+dqB1b9Ckpsm4OBBPV9/8RvJDBci7S15CItgUJtysGhzf5j8nRXBQRTQg1JEV5iokO72i2EB/7udHddzscNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573411; c=relaxed/simple;
	bh=2koO3b4bfhXKhsRl+EmAagbxaajqu6JzOnw0W016Kjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prkZ79WwGmjzc8GWRGJx9kUJ7AZARmQ8gI+aXv4h4mei75WC5C5J84PdH9naKc+/eUHghpJ9sCyTGPXrBLROjWOcVr9CAlMs32bjpST5fqeDqAfhnEVzcuFUj2lSiRRAQrbg/n/C/KENUGdHRdOaZn47q+AoWL+elaE0spB+Phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=igEOPax8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32B392114D87;
	Tue, 10 Jun 2025 09:36:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32B392114D87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749573409;
	bh=BKkeo+57HzITwASBg264hik1AJRnX11r4jDH2Ot6bOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igEOPax8Xj5Y8bZfRM8qy5YB224yUaCby1t9mu+nJp4CwRKNHtGoLIpqg0MnnhFcJ
	 jiq8JBnM8o1qXHBX749EiyNKTn63LHN1ySp5nEChFQLgFg6WgwaMD0maqv85u3fXPz
	 gJ7A7Y/1n1y9fDiBh6Nt7JeSepS0XO+hyJfp7UbA=
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
Date: Tue, 10 Jun 2025 09:36:47 -0700
Message-ID: <20250610163647.17887-1-romank@linux.microsoft.com>
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

>the VTL2 paravisor is supported only in Generation 2 VMs. But I'm not clear on
>what dependencies on EFI the VTL2 paravisor might have, if any. Roman -- are
>VTL2 paravisors built with CONFIG_EFI=n?

Thank you, Michael, for your help! We disable EFI:
* https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12/Microsoft/hcl-arm64.config
* https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12/Microsoft/hcl-x4.config

>
>> >>
>> >
>> > Hyper-V as of recent can boot off DeviceTree with the direct kernel  boot, no UEFI
>> > is required (examples would be OpenVMM and the OpenHCL paravisor on arm64).
>> 
>> I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
>> are orthogonal concepts, and I had expected that even the devicetree
>> based version would still get booted using a tiny UEFI implementation
>> even if the kernel doesn't need that. Do you know what type of bootloader
>> is actually used in the examples you mentioned? Does the hypervisor
>> just start the kernel at the native entry point without a bootloader
>> in this case?
>
>Need Roman to clarify this.
>

The kernel is started at the native entry point in "Image", and the address of
the DeviceTree blob is passed in X0.

There is a "virtual baremetal" bootloader [1] that prepares DeviceTree for the
kernel, sets some CPU registers and jumps to the Image's entry point yet that's
totally headless except for the optional serial output. No ACPI or UEFI is involved
at all. For all intents and purposes, that's the kernel direct boot :)

[1]
https://github.com/microsoft/openvmm/tree/main/openhcl/openhcl_boot


