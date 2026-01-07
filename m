Return-Path: <linux-hyperv+bounces-8187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F4D00632
	for <lists+linux-hyperv@lfdr.de>; Thu, 08 Jan 2026 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32B13015129
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68C2EDD76;
	Wed,  7 Jan 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frEZaBmQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FF2E7F11;
	Wed,  7 Jan 2026 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828233; cv=none; b=Z9D4ZaRPncGhmSMyWfGqs/btlAvdhg1PfG63I8CjlVyXXWRgX6nixU1Oude/aN/CB8ZVGXmInkBn4caAR7hWXUn1xhsnzIWaZWuWfyO5eIhoyoc3KdraLhnMWKSkjpezaEolPC1BBUVvipLNe4yZnR0FPQFCi4BFXF1aS4ZyxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828233; c=relaxed/simple;
	bh=e+qQukv/lAvUpGwmiJMqXp++Wy0mRudPO4bMP1qNW88=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=I/gB8OPNj5I9gdE1rlkI/tofSyOsbUL+UMuMImZvOnAh7LHWmSZoxCTbyTOEs5hZ84WQ/ZwRObvNTpAH/G+Np00lk5zl3hwBNQlmaGlxY4R9BHRzLZ+V6GzPpdC8QgRLmFCNOK2j+gdKlletUtdRhs1jfitEnXXug1UANjn6y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frEZaBmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A03C4CEF1;
	Wed,  7 Jan 2026 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767828232;
	bh=e+qQukv/lAvUpGwmiJMqXp++Wy0mRudPO4bMP1qNW88=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=frEZaBmQWGuwQ7NS+fZqDpBDfYmu20axZpIOnogQGbZnJ6lGMWj7n4KrWQqy5q3bm
	 //tIghs/jyeTVJC8ra8iZEBlbdWxPK8446YqkI51b9vBpzTo2kOjZpcoLpoMG+a/w8
	 uT1Q9zdgnqvjShmXqvxOD+AUGUF1FpzLCnYnCZHR1/MsdXQLHa5Cx9hYAPtVBOiwJA
	 eTPvvDjCvzhiRma1VM7AunUhn1hB9x7tCaXVzamrD1RD8ZmTbo0w4s74GsSX6C8/lc
	 mtG5NBn/4iDeRSMW8GRVW2uK6Pu7yr5Ld5np1Z4iLvLN04jFYwYu4lFPSO40R2iGIo
	 mC4Kv5aJi+5aA==
Date: Wed, 07 Jan 2026 17:23:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-acpi@vger.kernel.org, Chris Oo <cho@microsoft.com>, 
 Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, Wei Liu <wei.liu@kernel.org>, 
 "Kirill A. Shutemov" <kas@kernel.org>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 "Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-hyperv@vger.kernel.org, 
 x86@kernel.org, linux-kernel@vger.kernel.org
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-3-2f5b6785f2f5@linux.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
 <20260107-rneri-wakeup-mailbox-v8-3-2f5b6785f2f5@linux.intel.com>
Message-Id: <176782823140.2300431.3081932954431387872.robh@kernel.org>
Subject: Re: [PATCH v8 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors


On Wed, 07 Jan 2026 13:44:39 -0800, Ricardo Neri wrote:
> Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> firmware for Intel processors.
> 
> x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> mechanism is unavailable.
> 
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of the same wakeup
> vector for all CPUs while maintaining control over which CPUs to boot and
> when. While it is possible to achieve the same level of control using a
> spin-table, it would require specifying a separate `cpu-release-addr` for
> each secondary CPU.
> 
> The operation and structure of the mailbox are described in the
> Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> that this structure does not specify how to publish the mailbox to the
> operating system (ACPI-based platform firmware uses a separate table). No
> ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.
> 
> Nodes that want to refer to the reserved memory usually define
> a `memory-region` property. /cpus/cpu* nodes would want to refer to the
> mailbox, but they do not have such property defined in the DeviceTree
> specification. Moreover, it would imply that there is a memory region per
> CPU. Instead, add a `compatible` property that the operating system can use
> to discover the mailbox.
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes in v8:
>  - None
> 
> Changes in v7:
>  - Fixed Acked-by tag from Rafael to include the "(Intel)" suffix.
> 
> Changes in v6:
>  - Reworded the changelog for clarity.
>  - Added Acked-by tag from Rafael. Thanks!
>  - Added Reviewed-by tag from Rob. Thanks!
>  - Added Reviewed-by tag from Dexuan. Thanks!
> 
> Changes in v5:
>  - Specified the version and section of the ACPI spec in which the
>    wakeup mailbox is defined. (Rafael)
>  - Fixed a warning from yamllint about line lengths of URLs.
> 
> Changes in v4:
>  - Removed redefinitions of the mailbox and instead referred to ACPI
>    specification as per discussion on LKML.
>  - Clarified that DeviceTree-based firmware do not require the use of
>    ACPI tables to enumerate the mailbox. (Rob)
>  - Described the need of using a `compatible` property.
>  - Dropped the `alignment` property. (Krzysztof, Rafael)
>  - Used a real address for the mailbox node. (Krzysztof)
> 
> Changes in v3:
>  - Implemented the mailbox as a reserved-memory node. Add to it a
>    `compatible` property. (Krzysztof)
>  - Explained the relationship between the mailbox and the `enable-mehod`
>    property of the CPU nodes.
>  - Expanded the documentation of the binding.
> 
> Changes in v2:
>  - Added more details to the description of the binding.
>  - Added requirement a new requirement for cpu@N nodes to add an
>    `enable-method`.
> ---
>  .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml:23:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260107-rneri-wakeup-mailbox-v8-3-2f5b6785f2f5@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


