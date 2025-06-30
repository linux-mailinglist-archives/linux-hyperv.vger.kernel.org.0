Return-Path: <linux-hyperv+bounces-6054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64981AEE71A
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDDB177E17
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E831E1A3D;
	Mon, 30 Jun 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzSm/Ibw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865B43151;
	Mon, 30 Jun 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310132; cv=none; b=W5IC9LX1F2IXI5+9SnvZ+gEHS3MBnWUZ1CQu3lbLSGqeso4OB007U0V64ilMvu39/s+zYWRb8pswgny9jFhiPe2i689POGxpFvq4hLN0JYwACgL4OZiKodlpesoXVszB+GNOdH8fbUMHoj+fV8Fy5lSbbqMp6u1IU3kqns2Tpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310132; c=relaxed/simple;
	bh=DdHZAQF33pLN1I2cF0iHqvYvM8clVhjNG6ouagfGknM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EesfPmVvLRXXU3DPIQIykoH1/kbbr8qpRBlasXTG5Y4eB+lqzGlcLEgau84US8jq6ntNyeAp1FqwpRirA63bozqWZeB4YuEkrXFv1A42lIrRS13LfVOB7+HPcG7PKqDNRyqy56U6WOLeKSSVigDg+buOtFyzkg7ssWvXx9o3qI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzSm/Ibw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92263C4CEEB;
	Mon, 30 Jun 2025 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751310132;
	bh=DdHZAQF33pLN1I2cF0iHqvYvM8clVhjNG6ouagfGknM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gzSm/Ibw7//EfhK/ofC/U2l4KLOfd7YKKB1g67zSNdYpfeilLRmiW37BD5NCQiFll
	 Q6WXmVVpHKhhT6JHlzfb7oqtcHiKfsxTxsyyBmIJ8pUySFdRtGZ3AR3WkvsKyKobr4
	 e0Fmf07nIRe+Usi8WLt2CkupNaF48r/PJJBwcr8PG1Xkh1zWKKlgPAH9lgtgMpf6Fw
	 8dFVcytj4pAZEkt6WexGqgVyEvfrDKcSy+0t01Du/v5BVV/KRujgmdN0eUfqgA8CDU
	 8GKhbMB5dmDhX6KVNu3qIbdy8byNHacvzF4FaOkd0nYe2108v0SBiWxIlJ21T8Jtsd
	 cR4Fvq8Rtsm4A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60eefb805a4so506452eaf.2;
        Mon, 30 Jun 2025 12:02:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlhXDhYk+64RLUHkRdoVmgxpepvzpx0tf//i4wNyzSYUy0SwgFogLI5rk+M70Kq8jrL0K619Vl/SIttg==@vger.kernel.org, AJvYcCUtHrHj/bi7EEWj6YHZRWgBd1gc8xWVYPZWgBXG3Ttb5hfdB2hKEtKjfbZHueoMfBSVSYos2QIcjU7xAxB6@vger.kernel.org, AJvYcCUyYwhkvXSkA6/zDaH4wCwgMyaci6cjVv3/KsL6vpOg+QjHMywsquhCOi28yfiFnTYr1cGAar7H2Hh3HfwW@vger.kernel.org, AJvYcCWNbaMOFtxJEOF61ekukGO6xhqq4J/zQVbMxS0yH/Ghzicb6GuEf2yr/VQqVUwydskWKhLFjpIaH14A@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKiGo19tn/IwY9gS4CE1vsSn4LbJxXFQ44JG7d4O6N3d8sYUL
	qmAaon0v/33lxeaO2W5Def2ibKdcunuTlRzA8enj45YjgDhXbwYH15tMj057wR8gV3KwuJ+YuB2
	nV8EiqAMEGKGRycTqkUL1vad3cfxGXAs=
X-Google-Smtp-Source: AGHT+IFm2vHgb+BKZqHK5J/LOVulMiaZwngKIVHYspoXk0NcIChmSW6R/HuiJFUCHaquIAYnbbZGw+bmqzhkdJ2yxBQ=
X-Received: by 2002:a05:6820:270d:b0:611:4701:bcd2 with SMTP id
 006d021491bc7-611b9116603mr9956287eaf.6.1751310131833; Mon, 30 Jun 2025
 12:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com> <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 21:02:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_oifyhJq4WiOzS0fcexrjeChJhVyAthfQCX=6v_GumA@mail.gmail.com>
X-Gm-Features: Ac12FXyksNrv9JxF_gBnNjGxzTfNZOeM3Kqt38U6mwLvamITRF0pZ-6QBWI-N0s
Message-ID: <CAJZ5v0h_oifyhJq4WiOzS0fcexrjeChJhVyAthfQCX=6v_GumA@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 5:35=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> firmware for Intel processors.
>
> x86 platforms commonly boot secondary CPUs using an INIT assert, de-asser=
t
> followed by Start-Up IPI messages. The wakeup mailbox can be used when th=
is
> mechanism is unavailable.
>
> The wakeup mailbox offers more control to the operating system to boot
> secondary CPUs than a spin-table. It allows the reuse of same wakeup vect=
or
> for all CPUs while maintaining control over which CPUs to boot and when.
> While it is possible to achieve the same level of control using a spin-
> table, it would require to specify a separate `cpu-release-addr` for each
> secondary CPU.
>
> The operation and structure of the mailbox is described in the
> Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> that this structure does not specify how to publish the mailbox to the
> operating system (ACPI-based platform firmware uses a separate table). No
> ACPI table is needed in DeviceTree-based firmware to enumerate the mailbo=
x.
>
> Add a `compatible` property that the operating system can use to discover
> the mailbox. Nodes wanting to refer to the reserved memory usually define=
 a
> `memory-region` property. /cpus/cpu* nodes would want to refer to the
> mailbox, but they do not have such property defined in the DeviceTree
> specification. Moreover, it would imply that there is a memory region per
> CPU.
>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

LGTM from the ACPI specification cross-referencing perspective, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
>  .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++=
++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wake=
up-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,w=
akeup-mailbox.yaml
> new file mode 100644
> index 000000000000..a80d3bac44c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mail=
box.yaml
> @@ -0,0 +1,50 @@
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
> +  The structure and operation of the mailbox is described in the Multipr=
ocessor
> +  Wakeup Structure of the ACPI specification version 6.6 section 5.2.12.=
19 [1].
> +
> +  The implementation of the mailbox in platform firmware is described in=
 the
> +  Intel TDX Virtual Firmware Design Guide section 4.3.5 [2].
> +
> +  1: https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.=
html#multiprocessor-wakeup-structure
> +  2: https://www.intel.com/content/www/us/en/content-details/733585/inte=
l-tdx-virtual-firmware-design-guide.html
> +
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
> +required:
> +  - compatible
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
> +        wakeup-mailbox@ffff0000 {
> +            compatible =3D "intel,wakeup-mailbox";
> +            reg =3D <0x0 0xffff0000 0x1000>;
> +        };
> +    };
>
> --
> 2.43.0
>

