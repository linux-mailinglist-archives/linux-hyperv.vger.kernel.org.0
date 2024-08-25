Return-Path: <linux-hyperv+bounces-2860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F019C95E253
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 09:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2D328272D
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0B4F20E;
	Sun, 25 Aug 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9vyTaN8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67710E6;
	Sun, 25 Aug 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569806; cv=none; b=MjMX5WS7OEYqdKT1zLd09lvlLpTjshY4G0C2BgwzpRtsckoY0bIxiPGrhKfXU0bi5/0HIv8f3iao3rmIMM+6kbmd7GgNyXblRvxZsim0m/dHLAbnKxEI4AEqHlcPlDZuu3yPwEtovun0JiPwEECNlQIoCJ5blKw30fdzU7WsswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569806; c=relaxed/simple;
	bh=U/Oq2er/y7XgBVRnIf3CZHOyXgN+R1fGm+JuTjj/FG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apW4r6HnFZTv8MDNX+00sw5i7BXuoU80pMVtqw/rP1TDCDNCXYBjBzHYyAIZwnPKIaBks6GvUWV30udyljqwn44tRqjHhneuG5zKG9QtrTN20rC/kc0aMw7tRzvBqocscPBf3XgKHjZ8usD9OA3AYFJa0XXk9tt4qqxt/oAyhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9vyTaN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB87DC32782;
	Sun, 25 Aug 2024 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724569805;
	bh=U/Oq2er/y7XgBVRnIf3CZHOyXgN+R1fGm+JuTjj/FG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9vyTaN829lJaSdkU2m9TPa1dfiS0mEDAUOwvkkyFh38keko/Rf6lV7UaTWZ761nf
	 8BYRP41HOB71UNXocqw9lEVU0O5Qu6obqz5E0Dx7i6W4+tVBfvQVTtsAczw+Zzq4Ag
	 CeaBkK3gS/G3PRwchprIhaCXhY48sfN7ew66HdIPTQEBxmXhtyjyTGKhaD0DKAZWVT
	 4L//pWNUZrmVe8+VODPW3VuOLNrRqNB+u4D0MpEYh4sVF+a5sccfq4r49EiJdBJoqr
	 DCDN6NAeB3ECM6jB9vXqgDDrS501jUv+ZRffLHIPX2GxOMe1CYOHQJVpO2MOnuFksk
	 IMp+Fe1UvXk9w==
Date: Sun, 25 Aug 2024 09:10:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org, lenb@kernel.org, 
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
Message-ID: <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>

On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
> Add the binding to use mailbox wakeup mechanism to bringup APs.
> 
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> 
> diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
> new file mode 100644
> index 000000000000..cb84e2756bca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: x86 mailbox wakeup
> +maintainers:
> +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
> +
> +description: |
> +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
> +  processor (BSP) to wake up application processors (APs) through a wakeup
> +  mailbox.
> +
> +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
> +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
> +  memory.
> +
> +  The wakeup mailbox structure is defined as follows.
> +
> +    uint16_t command;
> +    uint16_t reserved;
> +    uint32_t apic_id;
> +    uint64_t wakeup_vector;
> +    uint8_t  reservedForOs[2032];
> +
> +  The memory after reservedForOs field is reserved and OS should not touch it.
> +
> +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
> +  routine's address into the wakeup_vector field, fill the apic_id field with
> +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
> +  wakeup command, the target AP will jump to the wakeup routine.
> +
> +  For each AP, the mailbox can be used only once for the wakeup command. After
> +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
> +  this AP.
> +
> +  The wakeup mailbox structure and the wakeup process is the same as
> +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
> +  section 5.2.12.19 [1].
> +
> +  References:
> +
> +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
> +
> +select: false

This schema is still a no-op because of this false.

What is the point of defining one property if it is not placed anywhere?
Every device node can have it? Seems wrong...

You need to come with proper schema. Lack of an example is another thing
- this cannot be even validated by the tools. 

Best regards,
Krzysztof


