Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745D13C2972
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGITSL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 15:18:11 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42533 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITSL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 15:18:11 -0400
Received: by mail-wr1-f44.google.com with SMTP id r11so8261484wro.9;
        Fri, 09 Jul 2021 12:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pe1y794l4mjAhpeUAB5o7/eaZgmg4VuBK+ArLDxngI=;
        b=kTIVSzvwgqWRuRBLLz2lNg833E5xqKHEBkcMzE5zk/VKTo80iVH/4p2YvOxBQO6v6p
         kVdG8kYkVp3a4n+tRNDDodIlVQuoIaVqlbLgyZYhP3j9F98N5kYtWcy6lEj7Aga/8Ftr
         Ubau/6eoYxaR3asDff/uJz4hjxucqkCuf7VZogz/DUarRAG0L0inuaygwKwXzMdpL41K
         C3oeJrIOM0eu1A3HR7p0UoXOfM8Pm2WlY8C6EWnnwPn1Q2Rvyy9dGkhMENQW3qnNYzcg
         zU0HUEqT4tNh55q/O8dzPodpO9EjMtuHxDgiXyAcwJ12DRgvRRrqRZSUbKx+ALb+RxvA
         apmA==
X-Gm-Message-State: AOAM533IQ+uFNV5xlYlPAt2RrXqRUQ3/rimCm+hOMjzbGEX7T3beOtFZ
        IH4Zvde7hxsX3axFcapdEqs=
X-Google-Smtp-Source: ABdhPJyEJldATArnxS19lyD3QfM4/weciDnCmCrbLDF8cTqtbXo14co61cfReirRF3kTiSYKhkpPKg==
X-Received: by 2002:adf:a54b:: with SMTP id j11mr25842163wrb.305.1625858126260;
        Fri, 09 Jul 2021 12:15:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t22sm5824822wmi.22.2021.07.09.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 12:15:25 -0700 (PDT)
Date:   Fri, 9 Jul 2021 19:15:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] PCI: hv: Support for create interrupt
 v3
Message-ID: <20210709191524.vbtlyg42v77f5drw@liuwe-devbox-debian-v2>
References: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
 <20210709102434.c4hj4iehumf7qbj7@liuwe-devbox-debian-v2>
 <MW4PR21MB200200F17E1D0E4AEEA87D0DC0189@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB200200F17E1D0E4AEEA87D0DC0189@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 04:42:13PM +0000, Sunil Muthuswamy wrote:
> > > +/*
> > > + * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
> > > + *	Everything is the same as in 'hv_msi_desc2' except that the size
> > > + *	of the 'vector_count' field is larger to support bigger vector
> > > + *	values. For ex: LPI vectors on ARM.
> > > + */
> > > +struct hv_msi_desc3 {
> > > +	u32	vector;
> > > +	u8	delivery_mode;
> > > +	u8	reserved;
> > > +	u16	vector_count;
> > > +	u16	processor_count;
> > > +	u16	processor_array[32];
> > > +} __packed;
> > > +
> > >  /**
> > >   * struct tran_int_desc
> > >   * @reserved:		unused, padding
> > > @@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
> > >  	struct hv_msi_desc2 int_desc;
> > >  } __packed;
> > >
> > > +struct pci_create_interrupt3 {
> > > +	struct pci_message message_type;
> > > +	union win_slot_encoding wslot;
> > > +	struct hv_msi_desc3 int_desc;
> > > +} __packed;
> > > +
> > >  struct pci_delete_interrupt {
> > >  	struct pci_message message_type;
> > >  	union win_slot_encoding wslot;
> > > @@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
> > >  	return sizeof(*int_pkt);
> > >  }
> > >
> > > +static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *cpu,
> > > +				       u16 *count)
> > 
> > Isn't count redundant here? I don't see how this can be used safely for
> > passing back more than 1 cpu, since if cpu is pointing to an array, its
> > size is not specified.
> > 
> > Wei.
> 
> Yes, it is at the moment. But, the function can be extended in the future to take
> a size as well. But, it will always be 1 and I preferred keeping that information
> with the implementation. If you have preference, I can hard code that in the
> caller. It seems fine for me either ways.

Since this is not too much trouble I would rather you remove count and
then introduce it when it is needed.

Wei.

> 
> - Sunil
