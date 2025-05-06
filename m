Return-Path: <linux-hyperv+bounces-5388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13DAAC74B
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF3E7B2BAD
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FC280319;
	Tue,  6 May 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9jTlZin"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449027BF8D;
	Tue,  6 May 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540089; cv=none; b=iRZ5Ro4fG3hRgAMN0nLIfkOeB0pkMWtAqQr5sMyxXLy/u2c4dZsmx2G2rorrJsFAzJZdxPWqWFCyp21cfHFSbq5OkgAtEEwzf/DR4EYlQMBnc0xYFFXQ1cCsW5Cr1KgFPr11Aj6BhUDGbnNVkNW11CZGFxcOtqphwlhJc+4qxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540089; c=relaxed/simple;
	bh=Tyk81MBG5nXw08NMTkKPJq1sku3qX3311I7l2V8JHwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9lwNZmYgtqbH9lcjTjuA3XYn1SZIRymc9DB++hP5opGKSSDx6j0G3g5ejV6D334iLGvzyetrvUiOWE5auDMCpFEGEg4o2g74vj0qhrdNdWVeuUI8W26kula9cA0O/OUmT1LwV/gO+Ymn5TdN43tGhPdfQ1pskcN++mvBLkkNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9jTlZin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE2FC4CEEF;
	Tue,  6 May 2025 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746540088;
	bh=Tyk81MBG5nXw08NMTkKPJq1sku3qX3311I7l2V8JHwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N9jTlZinzABgI7zIeJtl2ZfRWqZQZKPGEd47Dt3wxLDyUIiBeimMQKi0tLQHTnd7f
	 m7IfVyJFOn1Bod1jP2qb5wtRKTu8+B2SvEdauzd0ZM6AHkQkpf23b9/g0wyRyHckPp
	 fJ//4cZaVWYaGhxAf8GrObXMZhKAjbKbk9Ji0WclmDTBQ3rjrT3/0H//hLSpTVqZr0
	 EWWwBQnuNysJTs1rONnLvUeqcFXs/Ay0RaCVIoTnRyeUOqPm84nYf8/tNXROlzQ9CQ
	 OiHq1KMQASjcudGRfwfmPDTBc1EaBm0wrd1uqnlRY6mHkRiwiWuAax3QLqdGVtp+ae
	 YhxkB/Kfrb9Sg==
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso5698071b3a.0;
        Tue, 06 May 2025 07:01:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQEmU2LX4D8PHxZkh3ULpgeHecUvLSVzlmRGXs6noPLtSQNX22aixjONjNTyhE6scKc3LjGssObp2J@vger.kernel.org, AJvYcCUayqySb/eUiIqAe5uSiaknAdyPhLc3An0pJRo8ofdmfGuCh7pqJqmHIJUnei7aKnn65/oeBS7lmD66aTTm@vger.kernel.org, AJvYcCVuT+3O+5P/LGq0nHkv8LQLoHxAseLYDM/TwFK/2X2elzLntAq75wsWxb8D0jKVsTGkK0aaSYZSM6Q73Q==@vger.kernel.org, AJvYcCWu097E4HNEiOgntuGUfBgAUjX0wd0kfgPV0PZQ8qn4fGtOnggUUM0rPvfChEpzfGjE7hMBHXsyoZ4RaqF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YX7fOYvTP5lnLsXTgPzhdBjN4Jvv3QrQtQDXFDkRJs1xAkhM
	/fRIA69W/crjvtCLG7eMKsn1WnwTL2BZyf8X3JMyifHhQG+EpDPxtr9Ov9B3/3LwFWk9TlijJ0d
	cajMOh7i3wtq1c7x87UPDBBluao0=
X-Google-Smtp-Source: AGHT+IHBTswvMWMP3OzX/pedYkSRydC7Y4sOhxsrb2FM8KngPatI7fZ/EcSMYhZpCuYriB4OTCTrkwFrhu4eeY/jRjw=
X-Received: by 2002:a05:6820:8c3:b0:607:a412:10a8 with SMTP id
 006d021491bc7-6080032bd14mr7431951eaf.7.1746540068829; Tue, 06 May 2025
 07:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0j262Jorbb5--WY6KedR7CWvdTTYP10ZRZTqXhTNJ1GiA@mail.gmail.com> <20250506055054.GG25533@ranerica-svr.sc.intel.com>
In-Reply-To: <20250506055054.GG25533@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 May 2025 16:00:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gC8p1kwVpd8vZkWKoyVaT7Udzj0X5ux03TdJ3=2b8gyg@mail.gmail.com>
X-Gm-Features: ATxdqUFk154sgB8UHha-Nh4N8NYQp2big9nSiR7cqvhfYr3eqVkRovN_xU-pXZg
Message-ID: <CAJZ5v0gC8p1kwVpd8vZkWKoyVaT7Udzj0X5ux03TdJ3=2b8gyg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:46=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, May 05, 2025 at 03:07:43PM +0200, Rafael J. Wysocki wrote:
> > On Sat, May 3, 2025 at 9:10=E2=80=AFPM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > Add DeviceTree bindings for the wakeup mailbox used on Intel processo=
rs.
> > >
> > > x86 platforms commonly boot secondary CPUs using an INIT assert, de-a=
ssert
> > > followed by Start-Up IPI messages. The wakeup mailbox can be used whe=
n this
> > > mechanism unavailable.
> > >
> > > The wakeup mailbox offers more control to the operating system to boo=
t
> > > secondary CPUs than a spin-table. It allows the reuse of same wakeup =
vector
> > > for all CPUs while maintaining control over which CPUs to boot and wh=
en.
> > > While it is possible to achieve the same level of control using a spi=
n-
> > > table, it would require to specify a separate cpu-release-addr for ea=
ch
> > > secondary CPU.
> > >
> > > Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  - Implemented the mailbox as a reserved-memory node. Add to it a
> > >    `compatible` property. (Krzysztof)
> > >  - Explained the relationship between the mailbox and the `enable-meh=
od`
> > >    property of the CPU nodes.
> > >  - Expanded the documentation of the binding.
> > >
> > > Changes since v1:
> > >  - Added more details to the description of the binding.
> > >  - Added requirement a new requirement for cpu@N nodes to add an
> > >    `enable-method`.
> > > ---
> > >  .../reserved-memory/intel,wakeup-mailbox.yaml | 87 +++++++++++++++++=
++
> > >  1 file changed, 87 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reserved-memory=
/intel,wakeup-mailbox.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,=
wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/int=
el,wakeup-mailbox.yaml
> > > new file mode 100644
> > > index 000000000000..d97755b4673d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-=
mailbox.yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mail=
box.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Wakeup Mailbox for Intel processors
> > > +
> > > +description: |
> > > +  The Wakeup Mailbox provides a mechanism for the operating system t=
o wake up
> > > +  secondary CPUs on Intel processors. It is an alternative to the IN=
IT-!INIT-
> > > +  SIPI sequence used on most x86 systems.
> > > +
> > > +  Firmware must define the enable-method property in the CPU nodes a=
s
> > > +  "intel,wakeup-mailbox" to use the mailbox.
> > > +
> > > +  Firmware implements the wakeup mailbox as a 4KB-aligned memory reg=
ion of size
> > > +  of 4KB. It is memory that the firmware reserves so that each secon=
dary CPU can
> > > +  have the operating system send a single message to them. The firmw=
are is
> > > +  responsible for putting the secondary CPUs in a state to check the=
 mailbox.
> > > +
> > > +  The structure of the mailbox is as follows:
> > > +
> > > +  Field           Byte   Byte  Description
> > > +                 Length Offset
> > > +  ------------------------------------------------------------------=
------------
> > > +  Command          2      0    Command to wake up the secondary CPU:
> > > +                                        0: Noop
> > > +                                        1: Wakeup: Jump to the wakeu=
p_vector
> > > +                                        2-0xFFFF: Reserved:
> > > +  Reserved         2      2    Must be 0.
> > > +  APIC_ID          4      4    APIC ID of the secondary CPU to wake =
up.
> > > +  Wakeup_Vector    8      8    The wakeup address for the secondary =
CPU.
> > > +  ReservedForOs 2032     16    Reserved for OS use.
> > > +  ReservedForFW 2048   2048    Reserved for firmware use.
> > > +  ------------------------------------------------------------------=
------------
> > > +
> > > +  To wake up a secondary CPU, the operating system 1) prepares the w=
akeup
> > > +  routine; 2) populates the address of the wakeup routine address in=
to the
> > > +  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC =
ID of the
> > > +  secondary CPU; 4) writes Wakeup in the Command field. Upon receivi=
ng the
> > > +  Wakeup command, the secondary CPU acknowledges the command by writ=
ing Noop in
> > > +  the Command field and jumps to the Wakeup_Vector. The operating sy=
stem can
> > > +  send the next command only after the Command field is changed to N=
oop.
> > > +
> > > +  The secondary CPU will no longer check the mailbox after waking up=
. The
> > > +  secondary CPU must ignore the command if its APIC_ID written in th=
e mailbox
> > > +  does not match its own.
> > > +
> > > +  When entering the Wakeup_Vector, interrupts must be disabled and 6=
4-bit
> > > +  addressing mode must be enabled. Paging mode must be enabled. The =
virtual
> > > +  address of the Wakeup_Vector page must be equal to its physical ad=
dress.
> > > +  Segment selectors are not used.
> >
> > This interface is defined in the ACPI specification and all of the
> > above information is present there.
> >
> > Why are you copying it without acknowledging the source of it instead
> > of just saying where this interface is defined and pointing to its
> > definition?
>
> There was a discussion in the past about preferring a full description of
> the mailbox instead of references to ACPI [1]. I am happy to acknowledge
> the source in the changeset description. I explicitly acknowledge the ACP=
I
> specification in the cover letter.
>
> [1]. https://lore.kernel.org/all/20240809232928.GB25056@yjiang5-mobl.amr.=
corp.intel.com/

In which I clearly was not involved.

Acknowledgement in the cover letter is fine, but insufficient.

Also, there is the question regarding what happens when the ASWG
decides to update this part of the ACPI specification.  Is the DT
binding going to be updated too?

> >
> > > +
> > > +maintainers:
> > > +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > +
> > > +allOf:
> > > +  - $ref: reserved-memory.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: intel,wakeup-mailbox
> > > +
> > > +  alignment:
> > > +    description: The mailbox must be 4KB-aligned.
> > > +    const: 0x1000
> > > +
> > > +required:
> > > +  - compatible
> > > +  - alignment
> >
> > Why do you need the "alignment" property if the alignment is always the=
 same?
>
> I want to enforce a 4KB alignment. It can also be inferred from the
> address of the mailbox.
>
> Thanks and BR,
> Ricardo

