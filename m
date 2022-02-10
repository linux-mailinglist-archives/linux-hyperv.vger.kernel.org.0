Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6844B025D
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Feb 2022 02:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBJBbx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 20:31:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBJBbw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 20:31:52 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78861264B;
        Wed,  9 Feb 2022 17:31:50 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b22so3379888qkk.12;
        Wed, 09 Feb 2022 17:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lsjXgBdwVzz1jdG2SwhM08O9CVRULh5B52r/5Wr4x8g=;
        b=RR/np8HQjvvq6qfHxqri8Xbfmv5/l6SfV/hHZ6reOzohJyFZybkQ3W0ONjBtJC5w7S
         XgMtOn1lz3tzXFiCXJ3a7VblIpf9ZNvYMMRxC4UVCYc4JH1UJGRbJSs8quS9BBykLYYI
         3unAmT2Fh7vENgeaXZYBG+r0HN6D1UI1uFEpeuaS4wP/UAuJi30s3hNVdJXZy3TakcJT
         zUkuqHExfZQfozQZRJVWK0JptRMEUBvUL/jtyenROATB2Oefv1B+mxK6EVoyYH18gg23
         XlAQ1neaaOaqRjPxRn2ZiAUEasMePHaYNcR0kBnfakbP84PWSns1DbguvjZ9mHZ/L4Td
         o3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lsjXgBdwVzz1jdG2SwhM08O9CVRULh5B52r/5Wr4x8g=;
        b=FbIOgwZVPOQ7/Rkvizp6iK7tAc/2a0SFNLe9w9p1w1J6X+Q0o/vUJfv0iL+taHhUI8
         NxfFiCLV4tiVAkqe20uQsZJJL/vaYRW0ZG5k2GDXBdKdbZwfDGhsoXZGHFLRH5J0p0+A
         CJ/8E3CaIHUonA0kOq3SXr15QgiO81BaQ9WV+xOvqesjkImGLwvGQHGAoHkpw6Nqxry4
         Es6xh9HiBpfA2Pn7JaAIKdlk/5kEK6i/dSOptBBdExhH3+Z8EfUj5E4YI4pi1ewzPTg0
         j2LYYACHLXy5/bAZ/bXgxYW49K3ffISoV9nu0le1RBE96sbtg54gWU88xVZe3SE+6zxw
         1kfg==
X-Gm-Message-State: AOAM532tcr6sH1RBYr5+nAu0GfN4bkZHGO6ma/544wAGKM8Ia8N60ZAe
        YNL1EoVlqbaNc42eSYnMVvo6v5XmoVNKa+uC
X-Google-Smtp-Source: ABdhPJwHZCEP2h/vyvh6lOBT3h8QbQ1oJD1skB/aP+eX9ddsY++wtTgFkcGltvPlampEjZlvTBG4QA==
X-Received: by 2002:a05:6638:2484:: with SMTP id x4mr2607894jat.245.1644453078675;
        Wed, 09 Feb 2022 16:31:18 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g8sm9620280ilc.10.2022.02.09.16.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:31:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC24127C0054;
        Wed,  9 Feb 2022 19:31:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 09 Feb 2022 19:31:16 -0500
X-ME-Sender: <xms:01wEYhOs_2pN2zC6yDh91fysr4drI1NvHufl5_iBspkssrCakEDH4g>
    <xme:01wEYj9y76YXJmVn5ko7jUwsxMiTdS6Z0CP87Lx6nbYlfoWDeOk5EwYy6aq7WZdsr
    cGz21eWPYCpH9ureA>
X-ME-Received: <xmr:01wEYgSXDCAGEl7kvhYG7x5UmyTYXR5rRMe-P60eT1w-bazHdaPuE3WSnDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepiedvhfdtfeetffeukeeljefgteegveejleevjeejjefhuedujeeihfelffeh
    fedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:01wEYttQnelQx44A4NduqJAq0Z_nWbrInmu4FQDBslflCdLx0GfRrA>
    <xmx:01wEYpfzx35BTVkRKN0fartAklKyD1vOgH7pv49rBMs6Q6gSC_G-Nw>
    <xmx:01wEYp39FqIgklnSNByUbw6IbnA8e2Fc_TKU2pjpvsETdh5_pJqE-A>
    <xmx:1FwEYs_bLLKVD1L9qCECUQZ0h3D3CHVxcapRcvJKOncCqDZGA9jVJIEO6qo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 19:31:14 -0500 (EST)
Date:   Thu, 10 Feb 2022 08:31:09 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: hv: Avoid the retarget interrupt hypercall in
 irq_unmask() on ARM64
Message-ID: <YgRczeswYb3GcJVf@tardis>
References: <20220209023722.2866009-1-boqun.feng@gmail.com>
 <20220209161220.GA559499@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220209161220.GA559499@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 09, 2022 at 10:12:20AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 09, 2022 at 10:37:20AM +0800, Boqun Feng wrote:
> > On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> > devices, and SPIs can be managed directly via GICD registers. Therefore
> > the retarget interrupt hypercall is not needed on ARM64.
> >=20
> > The retarget interrupt hypercall related code is now put in a helper
> > function and only called on x86.
> >=20
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-hyperv.c
> > index 20ea2ee330b8..80aa33ef5bf0 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1457,7 +1457,7 @@ static void hv_irq_mask(struct irq_data *data)
> >  }
> > =20
> >  /**
> > - * hv_irq_unmask() - "Unmask" the IRQ by setting its current
> > + * __hv_irq_unmask() - "Unmask" the IRQ by setting its current
> >   * affinity.
> >   * @data:	Describes the IRQ
> >   *
> > @@ -1466,7 +1466,7 @@ static void hv_irq_mask(struct irq_data *data)
> >   * is built out of this PCI bus's instance GUID and the function
> >   * number of the device.
> >   */
> > -static void hv_irq_unmask(struct irq_data *data)
> > +static void __hv_irq_unmask(struct irq_data *data)
> >  {
> >  	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
> >  	struct hv_retarget_device_interrupt *params;
> > @@ -1569,6 +1569,13 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	if (!hv_result_success(res) && hbus->state !=3D hv_pcibus_removing)
> >  		dev_err(&hbus->hdev->device,
> >  			"%s() failed: %#llx", __func__, res);
> > +}
> > +
> > +static void hv_irq_unmask(struct irq_data *data)
> > +{
> > +	/* Only use a hypercall on x86 */
>=20
> This comment isn't useful because it only repeats what we can already
> see from the "IS_ENABLED(CONFIG_X86)" below and it doesn't say
> anything about *why*.
>=20
> Didn't we just go though an exercise of adding interfaces for
> arch-specific things, i.e., 831c1ae725f7 ("PCI: hv: Make the code arch
> neutral by adding arch specific interfaces")?  Maybe this should be
> another such interface?
>=20
> If you add Hyper-V support for a third arch, this #ifdef will likely
> be silently incorrect.  If you add an interface, there's at least a
> clue that this needs to be evaluated.
>=20

You are right. I will make __hv_irq_unmask() as an arch-specific
interface in the next version (probably with a better name). Thank you!

Regards,
Boqun

> > +	if (IS_ENABLED(CONFIG_X86))
> > +		__hv_irq_unmask(data);
> > =20
> >  	if (data->parent_data->chip->irq_unmask)
> >  		irq_chip_unmask_parent(data);
> > --=20
> > 2.35.1
> >=20
