Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D729CFE7E
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfJHQEG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 12:04:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35653 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfJHQEG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 12:04:06 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x98G3unh020436;
        Wed, 9 Oct 2019 01:03:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x98G3unh020436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570550637;
        bh=wybdrSAUDiWttDrdYwmnM3PPCTy7GU0Fn5r1t39IAV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=stsY27QmY3e4cdjd26j3AwIR2go+/rLzbRRgGbZrpIS02vfgKk3A1y2mcdjVUX79g
         rOGdkw0ABhDPWk6atIw3FE2dcV5zottd+ucAhnIg4s/FIp+Van5kWdekfHfssUn4G2
         8tzzNK7mBrRTKl+iY8wYRjpcmoE55nROfRTWw4uYHl5oWSxpiX9zh3qX/HNHmN2+WF
         JZLZ7ly5d1UBbV8To1WclFXiudwECV3PQWwzXpFvE+IiqmAqzebOzkyTDNJjEVhlUX
         GMtJv5UU2XjqPuoOhvgKSs6DDCydQzCPiDTeHjDPMArr3t0AXqGHM74bLj328Gg7hX
         vxuGFR1e9Fnhg==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id m21so5342716ual.13;
        Tue, 08 Oct 2019 09:03:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUV3E/l/I5bOTc0/iRANZvFOkP2ygFywZeLyg5B/wWFpnZHkxjS
        1bVVgtBUkmId8JQyhcmbC1ynlr3pwqzm+/yjjh0=
X-Google-Smtp-Source: APXvYqxAKivaqtk30va8WrQGa0qaiwLZZ+L7SLNr+fd+sRgHvQEnmpEuBnc7hWFcbzyxQvrMZcXeMUkpcGU06JnVDMA=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr18556759uap.40.1570550635843;
 Tue, 08 Oct 2019 09:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191008131508.21189-1-liuw@liuw.name>
In-Reply-To: <20191008131508.21189-1-liuw@liuw.name>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 9 Oct 2019 01:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpszkwtp2mAfoPajkRi0SHPspivWn9sUsxO0oua2X6NQ@mail.gmail.com>
Message-ID: <CAK7LNAQpszkwtp2mAfoPajkRi0SHPspivWn9sUsxO0oua2X6NQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kconfig: add hvconfig for Linux on Hyper-V
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Kconfig List <linux-kbuild@vger.kernel.org>,
        Wei Liu <liuwe@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 8, 2019 at 10:15 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> From: Wei Liu <liuwe@microsoft.com>
>
> Add an config file snippet which enalbes additional options useful for
> running the kernel in a Hyper-V guest.
>
> The expected use case is a user provides an existing config file then
> executes `make hvconfig`. It will merge those options with the
> provided config file.
>
> Based on similar concept for Xen and KVM.
>
> Signed-off-by: Wei Liu <liuwe@microsoft.com>
> ---
> RFC: I only tested this on x86.  Although the config options included in
> hv_guest.config don't seem to be arch-specific, we should probably
> move the ones not yet implemented on Arm to an x86 specific config
> file.
> ---
>  Documentation/admin-guide/README.rst |  3 +++
>  kernel/configs/hv_guest.config       | 33 ++++++++++++++++++++++++++++
>  scripts/kconfig/Makefile             |  5 +++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 kernel/configs/hv_guest.config
>
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index cc6151fc0845..d5f4389a7a2f 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -224,6 +224,9 @@ Configuring the kernel
>       "make xenconfig"   Enable additional options for xen dom0 guest kernel
>                          support.
>
> +     "make hvconfig"    Enable additional options for Hyper-V guest kernel
> +                        support.
> +
>       "make tinyconfig"  Configure the tiniest possible kernel.
>
>     You can find more information on using the Linux kernel config tools
> diff --git a/kernel/configs/hv_guest.config b/kernel/configs/hv_guest.config
> new file mode 100644
> index 000000000000..0e71e34a2d4d
> --- /dev/null
> +++ b/kernel/configs/hv_guest.config
> @@ -0,0 +1,33 @@
> +CONFIG_NET=y
> +CONFIG_NET_CORE=y
> +CONFIG_NETDEVICES=y
> +CONFIG_BLOCK=y
> +CONFIG_BLK_DEV=y
> +CONFIG_NETWORK_FILESYSTEMS=y
> +CONFIG_INET=y
> +CONFIG_TTY=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_BINFMT_ELF=y
> +CONFIG_PCI=y
> +CONFIG_PCI_MSI=y
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_PARAVIRT=y
> +CONFIG_HYPERV=y
> +CONFIG_HYPERV_VSOCKETS=y
> +CONFIG_PCI_HYPERV=y
> +CONFIG_PCI_HYPERV_INTERFACE=y
> +CONFIG_HYPERV_STORAGE=y
> +CONFIG_HYPERV_NET=y
> +CONFIG_HYPERV_KEYBOARD=y
> +CONFIG_FB_HYPERV=y
> +CONFIG_HID_HYPERV_MOUSE=y
> +CONFIG_HYPERV=y
> +CONFIG_HYPERV_TIMER=y
> +CONFIG_HYPERV_UTILS=y
> +CONFIG_HYPERV_BALLOON=y
> +CONFIG_HYPERV_IOMMU=y
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index ef2f2336c469..2ee46301b22e 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -104,6 +104,10 @@ PHONY += xenconfig
>  xenconfig: xen.config
>         @:
>
> +PHONY += hvconfig
> +hvconfig: hv_guest.config
> +       @:
> +


Does this need to be hooked up to kconfig Makefile?

In my understanding, this code provides
"make hvconfig" as a shorthand for "make hv_guest.config"

Please do not do this.


See "xenconfig" as a bad example.

"make xenconfig" is a shorthand of "make xen.config".
This exists to save just one character typing.


If I allow this, people would push more and more random pointless shorthands,
which are essentially unrelated to kconfig.


kvmconfig and xenconfig are just historical mistakes.


Please drop the changes to scripts/kconfig/Makefile.

Also, please do not use misleading "kconfig:" for the subject prefix.
You can use the subject prefix "hyper-v:" or something.


Thanks.


>  PHONY += tinyconfig
>  tinyconfig:
>         $(Q)$(MAKE) -f $(srctree)/Makefile allnoconfig tiny.config
> @@ -138,6 +142,7 @@ help:
>         @echo  '                    default value without prompting'
>         @echo  '  kvmconfig       - Enable additional options for kvm guest kernel support'
>         @echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
> +       @echo  '  hvconfig        - Enable additional options for Hyper-V guest kernel support'
>         @echo  '  tinyconfig      - Configure the tiniest possible kernel'
>         @echo  '  testconfig      - Run Kconfig unit tests (requires python3 and pytest)'
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
