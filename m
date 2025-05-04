Return-Path: <linux-hyperv+bounces-5341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E7AA8821
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 May 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9390D1896C4A
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 May 2025 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B21DDC21;
	Sun,  4 May 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R66C+6jW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01448849C;
	Sun,  4 May 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377163; cv=none; b=K4wx5jKlOirClFL1/c0lxixd8viKbD7ReC9A3gDOW9eoUgjG/ddq+EQhPsYY62myN3gKWbydIE2WLeKn4IvhDCDNxGqwgyxYZD88QY5V4Obegw5ALNnvZ0zXOd9TVOAd5J+ssFuI4EI+GalQ3mKvQFBLzUhkpfsi+SWnutjd5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377163; c=relaxed/simple;
	bh=FVPsGINmP1WQyRoUbUN8JBoNi/+iGAAHepfgidJ3Rac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRAcRjunm2caX+tuqxGNTAf5gBnr1UEdD0tu57rReDoXaFehBWTpGj3gyiYjDpbv06NsxhtE4djJNpm3uehKrUK70UJ3AdJ2WnCtyeAjdI7/T+XtkfIJ97N23qerAWBo3LAZRm6ThU7jOx1Zbzv/ks+6rwTvPHKp80Ei/IC+ZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R66C+6jW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85C2C4CEE7;
	Sun,  4 May 2025 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377162;
	bh=FVPsGINmP1WQyRoUbUN8JBoNi/+iGAAHepfgidJ3Rac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R66C+6jWolGajgXLLCKJNsKTuEzDRASNw0BKx8m4UdDLdhKrBMmgpTTeW0oZSjgyq
	 6Z9fK0pgUapkTId2Tm21z6igl6Xc9WakVKGsptUdyn50Asv8b5QH7JewCbpkkY44Gm
	 OxLrUqdqY56bNlAzqFiXsQEMk0Inw3sZJEmsOlRonwr3TK2arSdQAd+qg8Hr0V6Npa
	 eIArOya5F/gZ3QBxqcmmqp47YWudMsY/JX5d0JP+OnxCetoVIOmAbMWRgUoNVvXcUn
	 Cxsw7UcylwZtf7IkSrKnCdVB+yK4U7No3o7CJc7crm5gvrGD3B/fZhEBxLTTwhWRff
	 5Z1cxrLCu8HRw==
Date: Sun, 4 May 2025 18:45:59 +0200
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
Subject: Re: [PATCH v3 04/13] dt-bindings: x86: Add CPU bindings for x86
Message-ID: <20250504-happy-spoonbill-of-radiance-3b9fec@kuoka>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>

On Sat, May 03, 2025 at 12:15:06PM GMT, Ricardo Neri wrote:
> Add bindings for CPUs in x86 architecture. Start by defining the `reg` and

What for?

> `enable-method` properties and their relationship to x86 APIC ID and the
> available mechanisms to boot secondary CPUs.
> 
> Start defining bindings for Intel processors. Bindings for other vendors
> can be added later as needed.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---

Not really tested so only limited review follows.

>  .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/x86/cpus.yaml b/Documentation/devicetree/bindings/x86/cpus.yaml
> new file mode 100644
> index 000000000000..108b3ad64aea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/x86/cpus.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/x86/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: x86 CPUs
> +
> +maintainers:
> +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> +
> +description: |
> +  Description of x86 CPUs in a system through the "cpus" node.
> +
> +  Detailed information about the CPU architecture can be found in the Intel
> +  Software Developer's Manual:
> +    https://intel.com/sdm
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,x86

That's architecture, not a CPU. CPUs are like 80286, 80386, so that's
not even specific instruction set. I don't get what you need it for.

> +
> +  reg:

Missing constraints.

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Local APIC ID of the CPU. If the CPU has more than one execution thread,
> +      then the property is an array with one element per thread.
> +
> +  enable-method:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      The method used to wake up secondary CPUs. This property is not needed if
> +      the secondary processors are booted using INIT assert, de-assert followed
> +      by Start-Up IPI messages as described in the Volume 3, Section 11.4 of
> +      Intel Software Developer's Manual.
> +
> +      It is also optional for the bootstrap CPU.
> +
> +    oneOf:

I see only one entry, so didn't you want an enum?

> +      - items:

Not a list

> +          - const: intel,wakeup-mailbox

So every vendor is supposed to come with different name for the same
feature? Or is wakeup-mailnox really intel specific, but then specific
to which processors?


> +            description: |
> +              CPUs are woken up using the mailbox mechanism. The platform
> +              firmware boots the secondary CPUs and puts them in a state
> +              to check the mailbox for a wakeup command from the operating
> +              system.
> +
> +required:
> +  - reg
> +  - compatible
> +
> +unevaluatedProperties: false

Missing ref in top-level or this is supposed to be additionalProps. See
example-schema.

> +
> +examples:
> +  - |
> +    /*
> +     * A system with two CPUs. cpu@0 is the bootstrap CPU and its status is
> +     * "okay". It does not have the enable-method property. cpu@1 is a
> +     * secondary CPU. Its status is "disabled" and defines the enable-method
> +     * property.
> +     */
> +
> +    cpus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        reg = <0x0 0x1>;
> +        compatible = "intel,x86";
> +        status = "okay";

Drop

> +      };
> +
> +      cpu@1 {
> +        reg = <0x0 0x1>;
> +        compatible = "intel,x86";
> +        status = "disabled";

Why?

Best regards,
Krzysztof


