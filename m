Return-Path: <linux-hyperv+bounces-6153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35795AFCA9E
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016D37A933C
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8F2DC34C;
	Tue,  8 Jul 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYR1MVp2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF412DBF46;
	Tue,  8 Jul 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978494; cv=none; b=XzFsqmgHwbO1G8ubcwxe04XbwUxqSrSuVZjJ1nEXfHJpenW2ipKT+qOh44Z7908qv+r0/w1it7eIk1IqUPmOTwWCogrYB811g7OCanU+3P/i3yRHJmkgtoItmswDEi6YOkLDTLqJEOF5A2c6bQqACbICQ81RddcDt4cGHfEuDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978494; c=relaxed/simple;
	bh=ig4Ya6yOKltTKYiC8Pv2VErte3GbJVlzc3MNaT1fhaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8KsBytmAkSo2yIga7soDEgCbTUnBeVLXmXSRY+kNxdzkhBr/HSr3jQZjlrl1VFKwwPbMwVTihZ2ruxCxFyrDpcq3pTfFkXVd2axE4+bKXTRHcY4rr9zYGu3Nz/coY6x1HZVvtxBB15/OJnQL56V2hqrdgjAoErcqTEXCSPMRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYR1MVp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F57DC4CEED;
	Tue,  8 Jul 2025 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978494;
	bh=ig4Ya6yOKltTKYiC8Pv2VErte3GbJVlzc3MNaT1fhaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYR1MVp2kV0BanibXcBlMRcZPSI01/2KxgjrggqCJG7VRBMgqL+FqUCr4X6+bY/6K
	 pO626tYlLC25NdxTP4Gx+eetdxsV/SNki4HbjceBHVpvUmVS1qEZO5203RZ/4rUedk
	 2y6NbD0kz/ceA277YHLIB3Q/B8CP6YTvLScJrqOOguZTEPDNBR+6Zthl8l7fMYrM/F
	 WhwIuyGh9+eIa6zGysAf2n9fvyzTOoJ0KIBfsyhjcX9bDBpfWclzgPXum67e63NlaO
	 2sNhVnHruWnifWmQ4w6JquQX3tiFWEvi5Y3W9o7KOfch+gpSdOtrKvKTIalL1mNlo6
	 2oPiuC0iMylpw==
Date: Tue, 8 Jul 2025 07:41:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <175197849289.389672.9119321529069936382.robh@kernel.org>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>


On Fri, 27 Jun 2025 20:35:09 -0700, Ricardo Neri wrote:
> Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> firmware for Intel processors.
> 
> x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> mechanism is unavailable.
> 
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> for all CPUs while maintaining control over which CPUs to boot and when.
> While it is possible to achieve the same level of control using a spin-
> table, it would require to specify a separate `cpu-release-addr` for each
> secondary CPU.
> 
> The operation and structure of the mailbox is described in the
> Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> that this structure does not specify how to publish the mailbox to the
> operating system (ACPI-based platform firmware uses a separate table). No
> ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.
> 
> Add a `compatible` property that the operating system can use to discover
> the mailbox. Nodes wanting to refer to the reserved memory usually define a
> `memory-region` property. /cpus/cpu* nodes would want to refer to the
> mailbox, but they do not have such property defined in the DeviceTree
> specification. Moreover, it would imply that there is a memory region per
> CPU.
> 
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v4:
>  - Specified the version and section of the ACPI spec in which the
>    wakeup mailbox is defined. (Rafael)
>  - Fixed a warning from yamllint about line lengths of URLs.
> 
> Changes since v3:
>  - Removed redefinitions of the mailbox and instead referred to ACPI
>    specification as per discussion on LKML.
>  - Clarified that DeviceTree-based firmware do not require the use of
>    ACPI tables to enumerate the mailbox. (Rob)
>  - Described the need of using a `compatible` property.
>  - Dropped the `alignment` property. (Krzysztof, Rafael)
>  - Used a real address for the mailbox node. (Krzysztof)
> 
> Changes since v2:
>  - Implemented the mailbox as a reserved-memory node. Add to it a
>    `compatible` property. (Krzysztof)
>  - Explained the relationship between the mailbox and the `enable-mehod`
>    property of the CPU nodes.
>  - Expanded the documentation of the binding.
> 
> Changes since v1:
>  - Added more details to the description of the binding.
>  - Added requirement a new requirement for cpu@N nodes to add an
>    `enable-method`.
> ---
>  .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


