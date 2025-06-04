Return-Path: <linux-hyperv+bounces-5756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A62ACD511
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A81BA08E9
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2F35975;
	Wed,  4 Jun 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpdN6K3q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4D17F7;
	Wed,  4 Jun 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000705; cv=none; b=tBOxo3+0HUDOju95j+b1reNlFJuY4ncfpNWhEkKNRWyDh1uslH1lwBK+NURCCSQCN6lIOgfewVzGNrMoitxvvVxOTzhl0karc1j9hhQIo+i7l7/sW5IvhMWjcJ9si6TAW1bHKXl7fJPfbBCds4Ldpyxrt/XFe7fI4k5vmMST4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000705; c=relaxed/simple;
	bh=wBpHwHC/yiEzi+aiWB3oS6cN1vItlh5c+B/X2waVchg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HpI84t/HbJqK+N8Ky7LcMp2JIwiSwLDt3zaUQi0cnDG//zDzpCdjzjQeMSJu47XPRHv4vSX+zIc9tGKtf8hKaFdsZ5hat0U5PMYei64yW+0kk6GNEIOjdHkVGK0bjhA81OWavRG8HITnQe4iOTudaap8W6pvPG8uKgvQ/1OGL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpdN6K3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D594C4CEED;
	Wed,  4 Jun 2025 01:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749000704;
	bh=wBpHwHC/yiEzi+aiWB3oS6cN1vItlh5c+B/X2waVchg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kpdN6K3qjsBQnVYnYuGdosYN/m3LBW77x/c8cYu7kZiVS9dbYPnkhrPy82Qe0qx3j
	 2CAOF95Q95IdA23b6EFT1gCrE+wzqpUGpmq0XLTOAqyfPpD9XESh7MZnebGfGWgzB6
	 VBVaMvHH7qjdXY7lqcicyW+Ci1nWIof1ubd4z2Lqncy1fqbCDk57S20cdbGBnW8oUS
	 1U6/HRbPCSWaip8t7VmiwpDtnwMbyMlyJybWR6SyPyRy3CTrr1mh4KJcAyS/SX7qH7
	 ADjt39R7AYOeP7N81CCPb3+j/XvAHG4cyydPak5TI5hKZZs3ZrmamI+2Xx4DaXNpXx
	 yEcfo/+eXTyXA==
Date: Tue, 03 Jun 2025 20:31:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-acpi@vger.kernel.org, 
 Wei Liu <wei.liu@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Chris Oo <cho@microsoft.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, linux-hyperv@vger.kernel.org, 
 Haiyang Zhang <haiyangz@microsoft.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
 <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
Message-Id: <174900070284.2624702.4580450009482590306.robh@kernel.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors


On Tue, 03 Jun 2025 17:15:15 -0700, Ricardo Neri wrote:
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
>  .../reserved-memory/intel,wakeup-mailbox.yaml      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml:20:111: [warning] line too long (113 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


