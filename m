Return-Path: <linux-hyperv+bounces-5346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB42AA9406
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C51B18884AF
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E7256C6C;
	Mon,  5 May 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja9Hcmsy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B21F417E;
	Mon,  5 May 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450477; cv=none; b=QEGrGushqoTP+E64r7ZYb+IozyjtDB/m+/L7blcPGNaK/4UDbFCllgC+hVVCxEQBMPIraUJz1P4g7AZKbLOINADwOP76YMiU41H8Bb72sQagmSLMkhgp7IpksX8KFKuB3V7sJD8bKo91yEE9sv2zf6NFOwAlVjgq70es0WieF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450477; c=relaxed/simple;
	bh=Ja6gaduoMfpLfx53EIkIq4u5tNzA++ROap/e8Y99wWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwcMJjHLmUhdv4EulSzr/OsOBOdfqq+MY5/1YlKuGeotN5vTArSE8n5pf0nETOnxSuOaErjJ7YFC91BZWGBpMHBxzIJvNdeSTGXLHovb+GH4/6AjBNJphfE6fJgmRY0EzldXc/cKOTV2POMOkSyZq/B0CCje7k38X8io+n1p6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja9Hcmsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7897DC4CEE4;
	Mon,  5 May 2025 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746450475;
	bh=Ja6gaduoMfpLfx53EIkIq4u5tNzA++ROap/e8Y99wWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ja9HcmsyLfZ19y+WL2iW3vsZK1VE3PJIrJdBemBPgFEftVVt6nxhrg8Q4vTdXfxEZ
	 7A8iHImTQOsw2JOOZFN2si8oi9WK9ESrdzCTcfDFwa4EO9ZfwvVyISQucBknjXsInM
	 DLD0ao10+HgE1g3WY0bTr4pbFeCW2eBTsf071MO0+vH9BFyGPVSyDXTaKIKaHEKv7g
	 7XP4UdfhigzwjfV4+0wrULXeXD9sURFqfajnFS9kh8NlixABzgcegBIciibD4RQc7G
	 d7U0pnUvIIWEn27/HruVLiS9NUJTquctsBNPtbyW4XzGM+/mRqKZlsC4oEfc5if7/C
	 bqxMp086S26Vg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f8ae3ed8adso3168136b6e.3;
        Mon, 05 May 2025 06:07:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjBKcz39w/9S83wsG4U9Ta2D1GzGkkgxo/gbOhrkwFxbfAWBkYXWvu3cF0Y/ad93N1mrzkD1hrdP8ZPQ==@vger.kernel.org, AJvYcCUntqnj1wsBuZlR0fM8lQEkEvVJRZKhhgBqQ48eINCDef8aKxu6pbBWzMMHUyr1Llw0FlWih9uiGL9t@vger.kernel.org, AJvYcCUq+r5dI1hrW9ujOvzIVX7RqP9wbWGTz2aswSzX9vvlX6HnRgo8GFp9kIfPHQ18b0eOYrYrJUKp6mwMGbxn@vger.kernel.org, AJvYcCVrFO65ewQ9TnBBOI4YH0DqzttmpavraN0Xbdx8b+EkIsVsCZI2YFJMybv71GzQVw8j8GNIcxBltGYxwl/T@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiZtm1yA+89iUMXL9fc5gq3A7Pn4Fly6fOzuPD6CcofADQ5gL
	UI4W8vHgmQJUQ3Dg9OVmPNpHzTlnCviCtt4uRCxfLPk0RFcJAtzPrJ2Su70z6HVzHphbAsWcej3
	KI0jf2Zy8iyygectD1cY06rDwg0M=
X-Google-Smtp-Source: AGHT+IHafvTUmLP+318TJZovnwvkV7NxuJchj37bOS0+RlXAjCLDey4g2q/qRn3CyHFWlAdadNbnH6Ys4hKJ+xORPyo=
X-Received: by 2002:a05:6871:6a6:b0:2cc:3586:294f with SMTP id
 586e51a60fabf-2dab2fe1391mr7120194fac.9.1746450474755; Mon, 05 May 2025
 06:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com> <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 15:07:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j262Jorbb5--WY6KedR7CWvdTTYP10ZRZTqXhTNJ1GiA@mail.gmail.com>
X-Gm-Features: ATxdqUHOe_bTrNgfNcYSdbpuewLh6hfF5OjL2949NofDe1GEt1BvWztbAYVUpwQ
Message-ID: <CAJZ5v0j262Jorbb5--WY6KedR7CWvdTTYP10ZRZTqXhTNJ1GiA@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 9:10=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Add DeviceTree bindings for the wakeup mailbox used on Intel processors.
>
> x86 platforms commonly boot secondary CPUs using an INIT assert, de-asser=
t
> followed by Start-Up IPI messages. The wakeup mailbox can be used when th=
is
> mechanism unavailable.
>
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of same wakeup vect=
or
> for all CPUs while maintaining control over which CPUs to boot and when.
> While it is possible to achieve the same level of control using a spin-
> table, it would require to specify a separate cpu-release-addr for each
> secondary CPU.
>
> Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
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
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/int=
el,wakeup-mailbox.yaml
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wake=
up-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,w=
akeup-mailbox.yaml
> new file mode 100644
> index 000000000000..d97755b4673d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mail=
box.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wakeup Mailbox for Intel processors
> +
> +description: |
> +  The Wakeup Mailbox provides a mechanism for the operating system to wa=
ke up
> +  secondary CPUs on Intel processors. It is an alternative to the INIT-!=
INIT-
> +  SIPI sequence used on most x86 systems.
> +
> +  Firmware must define the enable-method property in the CPU nodes as
> +  "intel,wakeup-mailbox" to use the mailbox.
> +
> +  Firmware implements the wakeup mailbox as a 4KB-aligned memory region =
of size
> +  of 4KB. It is memory that the firmware reserves so that each secondary=
 CPU can
> +  have the operating system send a single message to them. The firmware =
is
> +  responsible for putting the secondary CPUs in a state to check the mai=
lbox.
> +
> +  The structure of the mailbox is as follows:
> +
> +  Field           Byte   Byte  Description
> +                 Length Offset
> +  ----------------------------------------------------------------------=
--------
> +  Command          2      0    Command to wake up the secondary CPU:
> +                                        0: Noop
> +                                        1: Wakeup: Jump to the wakeup_ve=
ctor
> +                                        2-0xFFFF: Reserved:
> +  Reserved         2      2    Must be 0.
> +  APIC_ID          4      4    APIC ID of the secondary CPU to wake up.
> +  Wakeup_Vector    8      8    The wakeup address for the secondary CPU.
> +  ReservedForOs 2032     16    Reserved for OS use.
> +  ReservedForFW 2048   2048    Reserved for firmware use.
> +  ----------------------------------------------------------------------=
--------
> +
> +  To wake up a secondary CPU, the operating system 1) prepares the wakeu=
p
> +  routine; 2) populates the address of the wakeup routine address into t=
he
> +  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC ID o=
f the
> +  secondary CPU; 4) writes Wakeup in the Command field. Upon receiving t=
he
> +  Wakeup command, the secondary CPU acknowledges the command by writing =
Noop in
> +  the Command field and jumps to the Wakeup_Vector. The operating system=
 can
> +  send the next command only after the Command field is changed to Noop.
> +
> +  The secondary CPU will no longer check the mailbox after waking up. Th=
e
> +  secondary CPU must ignore the command if its APIC_ID written in the ma=
ilbox
> +  does not match its own.
> +
> +  When entering the Wakeup_Vector, interrupts must be disabled and 64-bi=
t
> +  addressing mode must be enabled. Paging mode must be enabled. The virt=
ual
> +  address of the Wakeup_Vector page must be equal to its physical addres=
s.
> +  Segment selectors are not used.

This interface is defined in the ACPI specification and all of the
above information is present there.

Why are you copying it without acknowledging the source of it instead
of just saying where this interface is defined and pointing to its
definition?

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
> +
> +  alignment:
> +    description: The mailbox must be 4KB-aligned.
> +    const: 0x1000
> +
> +required:
> +  - compatible
> +  - alignment

Why do you need the "alignment" property if the alignment is always the sam=
e?

> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <1>;
> +
> +        wakeup-mailbox@12340000 {
> +            compatible =3D "intel,wakeup-mailbox";
> +            alignment =3D <0x1000>;
> +            reg =3D <0x0 0x12340000 0x1000>;
> +        };
> +    };
> --

