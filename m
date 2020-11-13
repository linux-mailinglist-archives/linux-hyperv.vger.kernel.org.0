Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3E2B1F80
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMQFH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 11:05:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42354 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgKMQFG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 11:05:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id l1so10448886wrb.9;
        Fri, 13 Nov 2020 08:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4ql9FNmRg1ulh7tLlHhtumC28zCqSX+nR7tpMMBE7A=;
        b=HOWqLfBSOkB+sclZF5TAevlMzECtchP+7uF+7kyBd/n56858Fqy4EyQrLCEzVB/9Bp
         76oy2L/d1fww4KhQ0k1cgn4Lml854rNslS8f+9ggRpnSnFKB0lwtyX6JM9OCDR+Yf13c
         fJpZ9+YVlRtmtSvuyOY2XZAHoUIK+RNMbtasYlrbj8ATeIBRLkZFtXGTiNVZ+wNG811u
         sr8sw4sUm5RPL/6pZhpirpn5v8wkTGuYYNpv7ckTlF2Y3pnY0C1nAezNKA1IIntk3scK
         bm/IxkJbij+FOBwW74r4jRxkxN65rYzy2xuCRmnN34qL7c2pGO5cDpmoFujnNgdQYkeO
         RKLg==
X-Gm-Message-State: AOAM530JWfx7bE76ItgJXjBcyGFEq5viHvWiyNyC65LisYWEw0EJcWo0
        +y8zybS5F8CbR4WM9Z+Uqn4=
X-Google-Smtp-Source: ABdhPJzjCbgpjZG9+WEZtRMjNeRKyHNM2ptEuReJvG8nDUoV7ljAr7NZ8ayvXcIUpX1gJ2D2Qv3Ofg==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr4191440wrn.146.1605283500131;
        Fri, 13 Nov 2020 08:05:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o184sm10669845wmo.37.2020.11.13.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:04:59 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:04:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 17/17] x86/hyperv: handle IO-APIC when running as root
Message-ID: <20201113160458.fyalsxpse5bg25dd@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-18-wei.liu@kernel.org>
 <87v9eawm2e.fsf@vitty.brq.redhat.com>
 <20201113160158.idndhuygfgenxyhm@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113160158.idndhuygfgenxyhm@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 13, 2020 at 04:01:58PM +0000, Wei Liu wrote:
> On Thu, Nov 12, 2020 at 05:56:41PM +0100, Vitaly Kuznetsov wrote:
> [...]
> > > +static unsigned int hv_ioapic_startup_irq(struct irq_data *data)
> > > +{
> > > +	u16 status;
> > > +	struct IO_APIC_route_entry ire;
> > > +	u32 vector;
> > > +	struct irq_cfg *cfg;
> > > +	int ioapic;
> > > +	u8 ioapic_pin;
> > > +	int ioapic_id;
> > > +	int gsi;
> > > +	union entry_union eu;
> > > +	struct cpumask *affinity;
> > > +	int cpu, vcpu;
> > > +	struct hv_interrupt_entry entry;
> > > +	struct mp_chip_data *mp_data = data->chip_data;
> > > +
> > > +	gsi = data->irq;
> > > +	cfg = irqd_cfg(data);
> > > +	affinity = irq_data_get_effective_affinity_mask(data);
> > > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> > > +	vcpu = hv_cpu_number_to_vp_number(cpu);
> > > +
> > > +	vector = cfg->vector;
> > > +
> > > +	ioapic = mp_find_ioapic(gsi);
> > > +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> > > +	ioapic_id = mpc_ioapic_id(ioapic);
> > > +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> > > +
> > > +	/*
> > > +	 * Always try unmapping. We do not have visibility into which whether
> > > +	 * an IO-APIC has been mapped or not. We can't use chip_data because it
> > > +	 * already points to mp_data.
> > > +	 *
> > > +	 * We don't use retarget interrupt hypercalls here because Hyper-V
> > > +	 * doens't allow root to change the vector or specify VPs outside of
> > > +	 * the set that is initially used during mapping.
> > > +	 */
> > > +	status = hv_unmap_ioapic_interrupt(gsi);
> > > +
> > > +	if (!(status == HV_STATUS_SUCCESS || status == HV_STATUS_INVALID_PARAMETER)) {
> > > +		pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> > > +		return -1;
> > 
> > Nit: the function returns 'unsigned int' but I see other 'irq_startup'
> > routines return negative values too, however, they tend to returd
> > '-ESOMETHING' so maybe -EFAULT here?
> > 
> 
> The return type should've been int instead. That's what the function
> signature in struct irq_chip looks like.

Actually it is unsigned int. Oh well.

Wei.
