Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184EC5B084F
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Sep 2022 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIGPUL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Sep 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIGPUJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Sep 2022 11:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3D1F2D7
        for <linux-hyperv@vger.kernel.org>; Wed,  7 Sep 2022 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662564005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHNdLB0NEs0hPJCPuKfDS5PXO0uKkxor3QlPHHKcdWM=;
        b=eO1pjAiBcATknSb0PaZfYCnysEh5OgJKH2NMhVCcSbzoIG8sYVg43MKfYw3h8a3LUxWJ2T
        cjwyURrL0yHuyRtZBUj7qyS68vruKkXHDIdSWzMEeSopspsCZ0fWJ9wFZJcLzHmt4kf28s
        svDE67/wj6bcWtIsF6gQzaAJsxmuZOc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-mka58-1xMo2ZrwcyI-Iq9Q-1; Wed, 07 Sep 2022 11:20:04 -0400
X-MC-Unique: mka58-1xMo2ZrwcyI-Iq9Q-1
Received: by mail-wm1-f71.google.com with SMTP id p19-20020a05600c1d9300b003a5c3141365so10382035wms.9
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Sep 2022 08:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CHNdLB0NEs0hPJCPuKfDS5PXO0uKkxor3QlPHHKcdWM=;
        b=xFEzw8PO3YgkaId6e0ora8juogdEwENANgqwnVOtgdhlz+vsdLyG6KLsUvy+XJYDns
         cDUVkjp56++mNrJKisfrn+PogzckkcjV/qf+2/ovCQnf+oDMTylsmnfLWBYG5HynLDUL
         1hQ20uIb+Sqwzi1Ui2r0sXFHsvcpY0mg7AV36Vk24icc5CkIUXPhAJggc3gFjtV7XoQd
         40r8LCWrEIU7arihLMcAGJumfZjwiars1NlwF5Qe1G/qOlybeei587QvymfzHKsKrCzy
         WUReRRpnDLdZ2KR0vjvf/lLxOf4Jp8Ly0D6lHAZHrffsVPR0QIJDuUvdwWwXzKrWNh4q
         /y4Q==
X-Gm-Message-State: ACgBeo2yEQkmpZzhZ2K/RCppNBESM38CrxooRgX3dD//GMaxxdklkqzH
        HpkwdrmaRtPpI4h2zS2QtW2NJQoqFR4WX6nOatHSQyazygRPBrQz3q69N95+u2f4bh5DPcaaY4y
        q8x1mERVOZpn9SV/YDH4Hggch
X-Received: by 2002:a5d:59ab:0:b0:228:28df:9193 with SMTP id p11-20020a5d59ab000000b0022828df9193mr2471685wrr.323.1662564003266;
        Wed, 07 Sep 2022 08:20:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR756qiCLKEbLM1iNnFKS+9y7GWIyNG66GDmPAE9ydBmmICwjU+sxM3SEVFU1scSKoLlwTZJ6g==
X-Received: by 2002:a5d:59ab:0:b0:228:28df:9193 with SMTP id p11-20020a5d59ab000000b0022828df9193mr2471659wrr.323.1662564002953;
        Wed, 07 Sep 2022 08:20:02 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003a840690609sm29360122wmc.36.2022.09.07.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:20:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     x86@kernel.org, hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        srivatsab@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com,
        willy@infradead.org, namit@vmware.com,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        jailhouse-dev@googlegroups.com, xen-devel@lists.xenproject.org,
        acrn-dev@lists.projectacrn.org, helgaas@kernel.org,
        bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH v2] x86/PCI: Prefer MMIO over PIO on VMware hypervisor
In-Reply-To: <1662448117-10807-1-git-send-email-akaher@vmware.com>
References: <1662448117-10807-1-git-send-email-akaher@vmware.com>
Date:   Wed, 07 Sep 2022 17:20:00 +0200
Message-ID: <8735d3rz33.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ajay Kaher <akaher@vmware.com> writes:

> During boot-time there are many PCI config reads, these could be performed
> either using Port IO instructions (PIO) or memory mapped I/O (MMIO).
>
> PIO are less efficient than MMIO, they require twice as many PCI accesses
> and PIO instructions are serializing. As a result, MMIO should be preferr=
ed
> when possible over PIO.
>
> Virtual Machine test result using VMware hypervisor
> 1 hundred thousand reads using raw_pci_read() took:
> PIO: 12.809 seconds
> MMIO: 8.517 seconds (~33.5% faster then PIO)
>
> Currently, when these reads are performed by a virtual machine, they all
> cause a VM-exit, and therefore each one of them induces a considerable
> overhead.
>
> This overhead can be further improved, by mapping MMIO region of virtual
> machine to memory area that holds the values that the =E2=80=9Cemulated h=
ardware=E2=80=9D
> is supposed to return. The memory region is mapped as "read-only=E2=80=9D=
 in the
> NPT/EPT, so reads from these regions would be treated as regular memory
> reads. Writes would still be trapped and emulated by the hypervisor.
>
> Virtual Machine test result with above changes in VMware hypervisor
> 1 hundred thousand read using raw_pci_read() took:
> PIO: 12.809 seconds
> MMIO: 0.010 seconds
>
> This helps to reduce virtual machine PCI scan and initialization time by
> ~65%. In our case it reduced to ~18 mSec from ~55 mSec.
>
> MMIO is also faster than PIO on bare-metal systems, but due to some bugs
> with legacy hardware and the smaller gains on bare-metal, it seems prudent
> not to change bare-metal behavior.

Out of curiosity, are we sure MMIO *always* works for other hypervisors
besides Vmware? Various Hyper-V version can probably be tested (were
they?) but with KVM it's much harder as PCI is emulated in VMM and
there's certainly more than 1 in existence...

>
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> ---
> v1 -> v2:
> Limit changes to apply only to VMs [Matthew W.]
> ---
>  arch/x86/pci/common.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index ddb7986..1e5a8f7 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -20,6 +20,7 @@
>  #include <asm/pci_x86.h>
>  #include <asm/setup.h>
>  #include <asm/irqdomain.h>
> +#include <asm/hypervisor.h>
>=20=20
>  unsigned int pci_probe =3D PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_=
CONF2 |
>  				PCI_PROBE_MMCONF;
> @@ -57,14 +58,58 @@ int raw_pci_write(unsigned int domain, unsigned int b=
us, unsigned int devfn,
>  	return -EINVAL;
>  }
>=20=20
> +#ifdef CONFIG_HYPERVISOR_GUEST
> +static int vm_raw_pci_read(unsigned int domain, unsigned int bus, unsign=
ed int devfn,
> +						int reg, int len, u32 *val)
> +{
> +	if (raw_pci_ext_ops)
> +		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> +	if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
> +		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
> +	return -EINVAL;
> +}
> +
> +static int vm_raw_pci_write(unsigned int domain, unsigned int bus, unsig=
ned int devfn,
> +						int reg, int len, u32 val)
> +{
> +	if (raw_pci_ext_ops)
> +		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
> +	if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
> +		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
> +	return -EINVAL;
> +}

These look exactly like raw_pci_read()/raw_pci_write() but with inverted
priority. We could've added a parameter but to be more flexible, I'd
suggest we add a 'priority' field to 'struct pci_raw_ops' and make
raw_pci_read()/raw_pci_write() check it before deciding what to use
first. To be on the safe side, you can leave raw_pci_ops's priority
higher than raw_pci_ext_ops's by default and only tweak it in
arch/x86/kernel/cpu/vmware.c=20

> +#endif /* CONFIG_HYPERVISOR_GUEST */
> +
>  static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, =
int size, u32 *value)
>  {
> +#ifdef CONFIG_HYPERVISOR_GUEST
> +	/*
> +	 * MMIO is faster than PIO, but due to some bugs with legacy
> +	 * hardware, it seems prudent to prefer MMIO for VMs and PIO
> +	 * for bare-metal.
> +	 */
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +		return vm_raw_pci_read(pci_domain_nr(bus), bus->number,
> +					 devfn, where, size, value);
> +#endif /* CONFIG_HYPERVISOR_GUEST */
> +
>  	return raw_pci_read(pci_domain_nr(bus), bus->number,
>  				 devfn, where, size, value);
>  }
>=20=20
>  static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,=
 int size, u32 value)
>  {
> +#ifdef CONFIG_HYPERVISOR_GUEST
> +	/*
> +	 * MMIO is faster than PIO, but due to some bugs with legacy
> +	 * hardware, it seems prudent to prefer MMIO for VMs and PIO
> +	 * for bare-metal.
> +	 */
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +		return vm_raw_pci_write(pci_domain_nr(bus), bus->number,
> +					  devfn, where, size, value);
> +#endif /* CONFIG_HYPERVISOR_GUEST */
> +
>  	return raw_pci_write(pci_domain_nr(bus), bus->number,
>  				  devfn, where, size, value);
>  }

--=20
Vitaly

