Return-Path: <linux-hyperv+bounces-5763-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B542ACDAC9
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DE41898485
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFC28B7ED;
	Wed,  4 Jun 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koJ88Zwr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912132236FC;
	Wed,  4 Jun 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028707; cv=none; b=P+4Bpdpo4+fFi8HK6V96tSBiOisdi4Xn8z7c5pFKR9kLHgYVBDBz3ax6il6DtaSjZjnXhvAVnUkA7n+mL2uzFbcu2dmQwNOfpIT0y9YTE6q1Eov5maqoS17B1uwBoDjWHvjUVIa/9BwO0rekeRbBRfOXBANlL7xtwaZa2DTV4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028707; c=relaxed/simple;
	bh=L6POkj6Zc9rHm2Dw3ygoSvNQMdfUMR+GWdHNNBQjGL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9PJ+HFjvsTdb8rq6yloQbmMFNc8JJuiWpZWwFRbhi6F74uVzpZJtkmOP5MDlSaftPQnXex76k/hQhqjVNE13RPdboRL3eSHwEZCXGUwKfU0ahGx+u4liDRSlvTN49IHx2HNypwUrMy5xwkQEmkL9TDY8Ao0MQN+5naHUEAC+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koJ88Zwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBE5C4CEF1;
	Wed,  4 Jun 2025 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749028707;
	bh=L6POkj6Zc9rHm2Dw3ygoSvNQMdfUMR+GWdHNNBQjGL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=koJ88ZwrCG2xECKhDZciOb7iaIWkxXgH3BVujnWsddjAMDG/ttsof5EZa0RS/OZxR
	 nm0KGrErvxTTYsEQPLcY6n4JfbhL7m/ahD/bdAD2YmyW+sC1rZ+pj49PYyxR4wbInm
	 Javvu3J3ANWOFop+HONy5VhxziLXfNNzwQGXEQCIkLK0w4+n5CzN3LeqsWq32rFbdl
	 IUnc8FDNqix6fgnPXH8ZwelMXr2of3B33KSxDml9veORzdsWt4+t8vIqw7xbdwbDkz
	 fMWWyluyYmz7feDXJlVmwc0pPAh0iBZxjMELq4pjFF06J8Sxlp0PbqaGHntfzeZax3
	 jPNlvo2IoXESQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60ef07eb7f4so1316217eaf.3;
        Wed, 04 Jun 2025 02:18:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPMXx6wwlrvrqC20HJm0c/n6fRTZQYOduXHQnbtUHunkr/xAPH+AIho6bvPoHeC6L0UyM8jSan57CyEFjt@vger.kernel.org, AJvYcCUfKuxI4Uhcpok9aUdTWq9fEQX1F6NjEF29GNLmwE52TVglRcKaHTwXYif0Im8BwP9kaE3SAIiZoXct@vger.kernel.org, AJvYcCWkiGpWv64pP7Z+zo0ZwbUxIGv4JOOax8h9/T1wBFZGXGS4h05tllfyC5Z582Dkm2pNVD7m4gXMR1EXWQ==@vger.kernel.org, AJvYcCXnSLLEb5NYt2ilBnlKMmA4l0SD6s6+BgGSAjTJmDHMfnx8dD86Q9+dyMUiO/m8PtUAzOksNW1PGfqyTJxH@vger.kernel.org
X-Gm-Message-State: AOJu0YxlToPe/0S4UjSbbP5NmFI2MlGtR8aznoXDlsXhWkH+ZyoRAnNx
	O6x5oUfXPbGis39sHCRDUIIijfZBKVcl4dB8If2rDkZXxW6T/pJHEje40lF1pBYTbd+VJYnUa2j
	+1G5PtrA+NdE4QBrDhTKXaz7uDnSPTko=
X-Google-Smtp-Source: AGHT+IEHf6/b3sknfI7B5TF1DbAX/pU2a7mlbOLC1WDbc+wR3jgFgOQtOPgyFLs72RKjBHezK39nvF0hDAZ+R3mneqM=
X-Received: by 2002:a05:6820:1888:b0:607:8929:4501 with SMTP id
 006d021491bc7-60f0c70133bmr1080114eaf.1.1749028706244; Wed, 04 Jun 2025
 02:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com> <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 11:18:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6Ej6Tg-4aS_B3Gg2Z5Bk0g_AA9wdG0FQmuq0ZqdP1og@mail.gmail.com>
X-Gm-Features: AX0GCFsqxcWS3EXNjsavGuMldwiD1CfU7AUN9_A3OZA77q-3k6GCKixlm62apTg
Message-ID: <CAJZ5v0i6Ej6Tg-4aS_B3Gg2Z5Bk0g_AA9wdG0FQmuq0ZqdP1og@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
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
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri@intel.com>, 
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 2:18=E2=80=AFAM Ricardo Neri
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
>  .../reserved-memory/intel,wakeup-mailbox.yaml      | 48 ++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wake=
up-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,w=
akeup-mailbox.yaml
> new file mode 100644
> index 000000000000..f18643805866
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mail=
box.yaml
> @@ -0,0 +1,48 @@
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
> +  Wakeup Structure of the ACPI specification.

Please make this more specific: Which specification version and what sectio=
n.

You may as well add a URL here too.

> +
> +  The implementation of the mailbox in platform firmware is described in=
 the
> +  Intel TDX Virtual Firmware Design Guide section 4.3.5.
> +
> +  See https://www.intel.com/content/www/us/en/content-details/733585/int=
el-tdx-virtual-firmware-design-guide.html
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

