Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FF4C43F4
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiBYLwk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 06:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiBYLwi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 06:52:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C30113D56E
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Feb 2022 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645789924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TczmJXW3cf8MAYhPlLedjQbAu9sWmw7nekowqPG8i94=;
        b=UBxsCvimpcqwrTpXIfqCoksIqYLkrrreeYE+zT5NClQ0E+/Ox15B010DmLIzeevo2sLvzv
        z3KftHfCt6clAXO+HAVebUVxnYOfxDdcyYGsLc4uvp5UHj3vHWIsArJbjyW+ErA8pd9DNc
        TY4qcdURlh+4yk07aKzogrAxWoxSnDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-LeBIUwz7N9Om9FTLpMqEhQ-1; Fri, 25 Feb 2022 06:52:03 -0500
X-MC-Unique: LeBIUwz7N9Om9FTLpMqEhQ-1
Received: by mail-wr1-f72.google.com with SMTP id w2-20020adfbac2000000b001ea99ca4c50so807358wrg.11
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Feb 2022 03:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TczmJXW3cf8MAYhPlLedjQbAu9sWmw7nekowqPG8i94=;
        b=4qBR9BvmLwjm+FYV2RaKtFUCh+E2nADgCqEYWXNlv7QM4Hyow+d9ayOxZpUZKT31Mw
         aSzK9V55r8cSCAG5Xd0/GpKvhZQt/yEUXCExCIs98Fb/DbpBl/+As6Jzro23bxSQQEHw
         BQQo1tYeLH9zYsKU1plGIwh77iJ4WDdnzLQtHIQMfdAEgige3WcNeU5sAxUGFoLXds1F
         rQ9RaecVN7ctzQw4X3UCzHAXsg3xmqFwOIk99P+ZuLVPZJyFobeqQsHVQ1ey6mKC5FnG
         tjh06A7OJbQ8UYqQVSVGw/p1alRJ7Y7BHSxqwqe9H2T8k1Lr2Oo4hgJpjONgUDbOl5gC
         iohQ==
X-Gm-Message-State: AOAM533bguk1r6oTPvo+uOr4kqPDOlkW9zobKNJUYVynY1eXPd/Bh1MC
        YC4dIJwwbkp75jjd/1HxVXePI8oPquVIIJn4CznwGK8HzieJbbB7/l0H5uDG2TqnxCpwiBYom7S
        Q1w1Jvln58W7XGNrxha/nrmgA
X-Received: by 2002:a5d:4387:0:b0:1ed:a13a:ef0c with SMTP id i7-20020a5d4387000000b001eda13aef0cmr5798085wrq.62.1645789921688;
        Fri, 25 Feb 2022 03:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxdsOBZKB6TtVSCJiDjEoPKDv3L7GJlEpOUn3FGf1Qp9ppyCiHKrBp77TZNcXz9ACVbskxuQ==
X-Received: by 2002:a5d:4387:0:b0:1ed:a13a:ef0c with SMTP id i7-20020a5d4387000000b001eda13aef0cmr5798045wrq.62.1645789921416;
        Fri, 25 Feb 2022 03:52:01 -0800 (PST)
Received: from redhat.com ([2.55.145.157])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm2018112wrn.51.2022.02.25.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:52:00 -0800 (PST)
Date:   Fri, 25 Feb 2022 06:51:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        adrian@parity.io, dwmw@amazon.co.uk,
        Alexander Graf <graf@amazon.com>, colmmacc@amazon.com,
        raduweis@amazon.com, berrange@redhat.com,
        Laszlo Ersek <lersek@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>, ben@skyportsystems.com,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 2/2] virt: vmgenid: introduce driver for
 reinitializing RNG on VM fork
Message-ID: <20220225064445-mutt-send-email-mst@kernel.org>
References: <20220224133906.751587-1-Jason@zx2c4.com>
 <20220224133906.751587-3-Jason@zx2c4.com>
 <CAMj1kXE-2sknZD7o72G-ZARpfm4Q0m+im1pTLuPhPu6TkqKOPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXE-2sknZD7o72G-ZARpfm4Q0m+im1pTLuPhPu6TkqKOPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 25, 2022 at 12:24:05PM +0100, Ard Biesheuvel wrote:
> On Thu, 24 Feb 2022 at 14:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > VM Generation ID is a feature from Microsoft, described at
> > <https://go.microsoft.com/fwlink/?LinkId=260709>, and supported by
> > Hyper-V and QEMU. Its usage is described in Microsoft's RNG whitepaper,
> > <https://aka.ms/win10rng>, as:
> >
> >     If the OS is running in a VM, there is a problem that most
> >     hypervisors can snapshot the state of the machine and later rewind
> >     the VM state to the saved state. This results in the machine running
> >     a second time with the exact same RNG state, which leads to serious
> >     security problems.  To reduce the window of vulnerability, Windows
> >     10 on a Hyper-V VM will detect when the VM state is reset, retrieve
> >     a unique (not random) value from the hypervisor, and reseed the root
> >     RNG with that unique value.  This does not eliminate the
> >     vulnerability, but it greatly reduces the time during which the RNG
> >     system will produce the same outputs as it did during a previous
> >     instantiation of the same VM state.
> >
> > Linux has the same issue, and given that vmgenid is supported already by
> > multiple hypervisors, we can implement more or less the same solution.
> > So this commit wires up the vmgenid ACPI notification to the RNG's newly
> > added add_vmfork_randomness() function.
> >
> > It can be used from qemu via the `-device vmgenid,guid=auto` parameter.
> > After setting that, use `savevm` in the monitor to save the VM state,
> > then quit QEMU, start it again, and use `loadvm`. That will trigger this
> > driver's notify function, which hands the new UUID to the RNG. This is
> > described in <https://git.qemu.org/?p=qemu.git;a=blob;f=docs/specs/vmgenid.txt>.
> > And there are hooks for this in libvirt as well, described in
> > <https://libvirt.org/formatdomain.html#general-metadata>.
> >
> > Note, however, that the treatment of this as a UUID is considered to be
> > an accidental QEMU nuance, per
> > <https://github.com/libguestfs/virt-v2v/blob/master/docs/vm-generation-id-across-hypervisors.txt>,
> > so this driver simply treats these bytes as an opaque 128-bit binary
> > blob, as per the spec. This doesn't really make a difference anyway,
> > considering that's how it ends up when handed to the RNG in the end.
> >
> > This driver builds on prior work from Adrian Catangiu at Amazon, and it
> > is my hope that that team can resume maintenance of this driver.
> >
> > Cc: Adrian Catangiu <adrian@parity.io>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/virt/Kconfig   |   9 +++
> >  drivers/virt/Makefile  |   1 +
> >  drivers/virt/vmgenid.c | 121 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 drivers/virt/vmgenid.c
> >
> > diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> > index 8061e8ef449f..d3276dc2095c 100644
> > --- a/drivers/virt/Kconfig
> > +++ b/drivers/virt/Kconfig
> 
> drivers/virt does not have a maintainer and this code needs one.
> 
> > @@ -13,6 +13,15 @@ menuconfig VIRT_DRIVERS
> >
> >  if VIRT_DRIVERS
> >
> > +config VMGENID
> > +       tristate "Virtual Machine Generation ID driver"
> > +       default y
> 
> Please make this default m - this code can run as a module and the
> feature it relies on is discoverable by udev

Or don't supply a default - I don't see why this has any preference.

> > +       depends on ACPI
> > +       help
> > +         Say Y here to use the hypervisor-provided Virtual Machine Generation ID
> > +         to reseed the RNG when the VM is cloned. This is highly recommended if
> > +         you intend to do any rollback / cloning / snapshotting of VMs.
> > +
> >  config FSL_HV_MANAGER
> >         tristate "Freescale hypervisor management driver"
> >         depends on FSL_SOC
> > diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> > index 3e272ea60cd9..108d0ffcc9aa 100644
> > --- a/drivers/virt/Makefile
> > +++ b/drivers/virt/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  obj-$(CONFIG_FSL_HV_MANAGER)   += fsl_hypervisor.o
> > +obj-$(CONFIG_VMGENID)          += vmgenid.o
> >  obj-y                          += vboxguest/
> >
> >  obj-$(CONFIG_NITRO_ENCLAVES)   += nitro_enclaves/
> > diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> > new file mode 100644
> > index 000000000000..5da4dc8f25e3
> > --- /dev/null
> > +++ b/drivers/virt/vmgenid.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Virtual Machine Generation ID driver
> > + *
> > + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > + * Copyright (C) 2020 Amazon. All rights reserved.
> > + * Copyright (C) 2018 Red Hat Inc. All rights reserved.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/random.h>
> > +
> > +ACPI_MODULE_NAME("vmgenid");
> > +
> > +enum { VMGENID_SIZE = 16 };
> > +
> > +static struct {
> > +       u8 this_id[VMGENID_SIZE];
> > +       u8 *next_id;
> > +} state;
> > +
> 
> This state is singular
> 
> 
> > +static int vmgenid_acpi_add(struct acpi_device *device)
> > +{
> 
> ... whereas this may be called for multiple instances of the device.
> This likely makes no sense, so it is better to reject it here.
> 
> Otherwise, the state should be allocated dynamically.
> 
> > +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
> > +       union acpi_object *pss;
> > +       phys_addr_t phys_addr;
> > +       acpi_status status;
> > +       int ret = 0;
> > +
> > +       if (!device)
> > +               return -EINVAL;
> > +
> > +       status = acpi_evaluate_object(device->handle, "ADDR", NULL, &buffer);
> > +       if (ACPI_FAILURE(status)) {
> > +               ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
> > +               return -ENODEV;
> > +       }
> > +       pss = buffer.pointer;
> > +       if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2 ||
> > +           pss->package.elements[0].type != ACPI_TYPE_INTEGER ||
> > +           pss->package.elements[1].type != ACPI_TYPE_INTEGER) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       phys_addr = (pss->package.elements[0].integer.value << 0) |
> > +                   (pss->package.elements[1].integer.value << 32);
> > +       state.next_id = acpi_os_map_memory(phys_addr, VMGENID_SIZE);
> 
> No need to use acpi_os_map_memory() here, plain memremap() should be fine.
> 
> > +       if (!state.next_id) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +       device->driver_data = &state;
> > +
> > +       memcpy(state.this_id, state.next_id, sizeof(state.this_id));
> > +       add_device_randomness(state.this_id, sizeof(state.this_id));
> > +
> > +out:
> > +       ACPI_FREE(buffer.pointer);
> > +       return ret;
> > +}
> > +
> > +static int vmgenid_acpi_remove(struct acpi_device *device)
> > +{
> > +       if (!device || acpi_driver_data(device) != &state)
> > +               return -EINVAL;
> > +       device->driver_data = NULL;
> > +       if (state.next_id)
> > +               acpi_os_unmap_memory(state.next_id, VMGENID_SIZE);
> 
> memunmap() here
> 
> > +       state.next_id = NULL;
> > +       return 0;
> > +}
> > +
> > +static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
> > +{
> > +       u8 old_id[VMGENID_SIZE];
> > +
> > +       if (!device || acpi_driver_data(device) != &state)
> > +               return;
> > +       memcpy(old_id, state.this_id, sizeof(old_id));
> > +       memcpy(state.this_id, state.next_id, sizeof(state.this_id));
> > +       if (!memcmp(old_id, state.this_id, sizeof(old_id)))
> > +               return;
> 
> Is this little dance really necessary? I.e., can we just do
> 
> add_vmfork_randomness(state.next_id, VMGENID_SIZE)
> 
> and be done with it?
> 
> And if we cannot, is it ok to just return without some kind of
> diagnostic message?
> 
> > +       add_vmfork_randomness(state.this_id, sizeof(state.this_id));
> > +}
> > +
> > +static const struct acpi_device_id vmgenid_ids[] = {
> > +       {"VMGENID", 0},
> > +       {"QEMUVGID", 0},
> > +       { },
> > +};
> > +
> > +static struct acpi_driver acpi_driver = {
> > +       .name = "vm_generation_id",
> > +       .ids = vmgenid_ids,
> > +       .owner = THIS_MODULE,
> > +       .ops = {
> > +               .add = vmgenid_acpi_add,
> > +               .remove = vmgenid_acpi_remove,
> > +               .notify = vmgenid_acpi_notify,
> > +       }
> > +};
> > +
> > +static int __init vmgenid_init(void)
> > +{
> > +       return acpi_bus_register_driver(&acpi_driver);
> > +}
> > +
> > +static void __exit vmgenid_exit(void)
> > +{
> > +       acpi_bus_unregister_driver(&acpi_driver);
> > +}
> > +
> > +module_init(vmgenid_init);
> > +module_exit(vmgenid_exit);
> > +
> > +MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
> > +MODULE_DESCRIPTION("Virtual Machine Generation ID");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.35.1
> >

