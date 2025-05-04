Return-Path: <linux-hyperv+bounces-5342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC4AA882C
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 May 2025 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6D3A88E7
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 May 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD11E0DEB;
	Sun,  4 May 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3FvpBgr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30898F7D;
	Sun,  4 May 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377481; cv=none; b=E5eji6FffB2rapJGB6qtjEZDdypnEI3UqyYkdtTRgCO4x0pwhdTJC/6MsNaMcD+v0a/aG+RuM5OOxjj+VEas1jFEdKef41Cavcl8cXxQ2kyPVGWiqeDhCFDj9XMefqmWqVB8iMGOcr2NvYMLoMCWW3zNEbTnbT0Ae9IZccP3rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377481; c=relaxed/simple;
	bh=FfI67clrDMM6vJK1nPJDHSlAfbAytNInYJ7Hncm2h8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPmW69E+l0trRG4ggKv/G5JX9YKblv0GXBX7obsxQpttzIPr9OmUzKZ+7WV40Y0smWYH6JBl1MrzsyybHkFMe7hIbLviun67dhCPhqY5jrXNPKUAxQIuatZiDjtV2fWocbOb6Kphm55nR50XE6MtZRCeIP3eXimJJcgFKN87Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3FvpBgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CFDC4CEE7;
	Sun,  4 May 2025 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377480;
	bh=FfI67clrDMM6vJK1nPJDHSlAfbAytNInYJ7Hncm2h8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3FvpBgriybQjof8V/lp9U3jvYWDWK5VqapmPaG9MQwRWhswui6sLKi2vm9VY5hLZ
	 6mBwAGh/akIo4KLxZUYQCV+WGzG2z/Vj0EJ+uMZv6BhXzvbOUe4GHKh0dwDaC9KAHL
	 tX1/YxxfBMsWCcETis936jzM3r+BeyaArKf+Vs+VcfL6BoLeDFHUg0q8/8/IsMK1O5
	 lpbV/FId7YqXnEcBwhcSmVUYVHM7r3OvrY2D7cDqFx4G54bYMnoTpebe5wttje2R5h
	 yoT3eAk/vRuuMzfaq/o6t6Tp+iUyuaL89XBoXzFWFa7o1JBZEf/9WG1M8cGF8B3bEw
	 O9pWO4mAf/+iw==
Date: Sun, 4 May 2025 18:51:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250504-original-leopard-of-vigor-5702ef@kuoka>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>

On Sat, May 03, 2025 at 12:15:08PM GMT, Ricardo Neri wrote:
> Add DeviceTree bindings for the wakeup mailbox used on Intel processors.
> 

Start using b4, so your cover letter will have proper lore links to
previous versions.

> x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> mechanism unavailable.
> 
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> for all CPUs while maintaining control over which CPUs to boot and when.
> While it is possible to achieve the same level of control using a spin-
> table, it would require to specify a separate cpu-release-addr for each
> secondary CPU.
> 
> Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>

What does this tag mean? Why you cannot use standard tags - SoB and
co-developed?

> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
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
>  .../reserved-memory/intel,wakeup-mailbox.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> new file mode 100644
> index 000000000000..d97755b4673d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wakeup Mailbox for Intel processors
> +
> +description: |
> +  The Wakeup Mailbox provides a mechanism for the operating system to wake up
> +  secondary CPUs on Intel processors. It is an alternative to the INIT-!INIT-
> +  SIPI sequence used on most x86 systems.
> +
> +  Firmware must define the enable-method property in the CPU nodes as
> +  "intel,wakeup-mailbox" to use the mailbox.
> +
> +  Firmware implements the wakeup mailbox as a 4KB-aligned memory region of size
> +  of 4KB. It is memory that the firmware reserves so that each secondary CPU can
> +  have the operating system send a single message to them. The firmware is
> +  responsible for putting the secondary CPUs in a state to check the mailbox.
> +
> +  The structure of the mailbox is as follows:
> +
> +  Field           Byte   Byte  Description
> +                 Length Offset
> +  ------------------------------------------------------------------------------
> +  Command          2      0    Command to wake up the secondary CPU:
> +                                        0: Noop
> +                                        1: Wakeup: Jump to the wakeup_vector
> +                                        2-0xFFFF: Reserved:
> +  Reserved         2      2    Must be 0.
> +  APIC_ID          4      4    APIC ID of the secondary CPU to wake up.
> +  Wakeup_Vector    8      8    The wakeup address for the secondary CPU.
> +  ReservedForOs 2032     16    Reserved for OS use.
> +  ReservedForFW 2048   2048    Reserved for firmware use.
> +  ------------------------------------------------------------------------------
> +
> +  To wake up a secondary CPU, the operating system 1) prepares the wakeup
> +  routine; 2) populates the address of the wakeup routine address into the
> +  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC ID of the
> +  secondary CPU; 4) writes Wakeup in the Command field. Upon receiving the
> +  Wakeup command, the secondary CPU acknowledges the command by writing Noop in
> +  the Command field and jumps to the Wakeup_Vector. The operating system can
> +  send the next command only after the Command field is changed to Noop.
> +
> +  The secondary CPU will no longer check the mailbox after waking up. The
> +  secondary CPU must ignore the command if its APIC_ID written in the mailbox
> +  does not match its own.
> +
> +  When entering the Wakeup_Vector, interrupts must be disabled and 64-bit
> +  addressing mode must be enabled. Paging mode must be enabled. The virtual
> +  address of the Wakeup_Vector page must be equal to its physical address.
> +  Segment selectors are not used.
> +
> +maintainers:
> +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    const: intel,wakeup-mailbox

If this is a device, then compatibles specific to devices. You do not
get different rules than all other bindings... or this does not have to
be binding at all. Why standard reserved-memory does not work for here?

Why do you need compatible in the first place?


> +
> +  alignment:
> +    description: The mailbox must be 4KB-aligned.

Then drop it because it is implied by compatible.

> +    const: 0x1000
> +
> +required:
> +  - compatible
> +  - alignment
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +
> +        wakeup-mailbox@12340000 {

Please use real addresses from real DT.

> +            compatible = "intel,wakeup-mailbox";
> +            alignment = <0x1000>;
> +            reg = <0x0 0x12340000 0x1000>;

reg is always the second property. See DTS coding style.

Best regards,
Krzysztof


