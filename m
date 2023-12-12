Return-Path: <linux-hyperv+bounces-1321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8D80F2CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB431F20E8F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECF77F3D;
	Tue, 12 Dec 2023 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9sQ8j1f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA53CA;
	Tue, 12 Dec 2023 08:34:04 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5e266e8d39eso2066937b3.1;
        Tue, 12 Dec 2023 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702398844; x=1703003644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQQid16GHvnaAbZDXuQkDV5jUsLgdBWxDY6lNDo1oPs=;
        b=H9sQ8j1fiRZpYcqEEIN8G5ISwagxt8ZN/q5pDUYNwLbeBdWwX6MgQ1O0FpsbFnrB2N
         yy4Sx54ERsaIl4ZEP+JkNZyrfZvkM8kuGvWFzOLLDtzJjjLFf/4XZY8AKKR2zQ8eimCp
         154KRylzd4H0tiaohrch0AwttZhjLcZyiI0CQuCLyb6UzK8IiRa8mWs11PBNzPvimY/Q
         7sluQhhMxxnKcnEiYQjqsEm0DyD7aSA9fyWIDSlFRBVRQDUNV01Fe+Sc3GLDPX8tTpNP
         F6zGndn8woOXwbcyiHSwiOrjMvlaqODX03iIeqGiWuRY464fv+252Tn30dEVpmhSKHyW
         4afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398844; x=1703003644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQQid16GHvnaAbZDXuQkDV5jUsLgdBWxDY6lNDo1oPs=;
        b=GKx40R6aBIS0Qxe80kLOh3JCVQvUE0R9lxa3Qw6em26JmlfwakU1zDaIr30qidSjHC
         apTfw11LGqbYoNGViQB87Khn8IC7hBuQUwo7c8Cs7x82uE4qqwgsxBpVBLajw273ZKWx
         xRP4GOwBYo+k+/B1LORmyFIMmoF/5Po9GSqPvdOYzfmzn6T11NzlEDbzOSBgAUpJNM5b
         nhkiNofPFUT2/oy15oLmxEqb+P8ji0IePgSWJ0dzHehA40Qqepp++WY9q7fy4isTxqS2
         s0qcPnIoxHmCazClpP5jWwTB+8f2Ufv5/VDrNtU0h3x6a5OPq722AVshoerAnVdCTflT
         42Gg==
X-Gm-Message-State: AOJu0YzbXxx6aT7Cay2ArQ/XuNSig0qQOu1f4i496eFA1a7HZYNSMvX/
	Bk/UKtVYqkADEKyc2f2qA5tYvk1PCz9VrQ==
X-Google-Smtp-Source: AGHT+IGUMfA963Iva3P4h6VxRTz6ACMNoJFaBpjoNF2iLJIc3MZ40Jgs6Zf05O3kHPg2oOV2DUsu6g==
X-Received: by 2002:a0d:e28e:0:b0:5d3:37fe:54ce with SMTP id l136-20020a0de28e000000b005d337fe54cemr5304212ywe.8.1702398843573;
        Tue, 12 Dec 2023 08:34:03 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id d63-20020a0ddb42000000b005845e6f9b50sm566704ywe.113.2023.12.12.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:34:02 -0800 (PST)
Date: Tue, 12 Dec 2023 08:34:02 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <ZXiLetPnY5TlAQGY@yury-ThinkPad>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
 <20231212113856.GA17123@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212113856.GA17123@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

> > > > > +	rcu_read_lock();
> > > > > +	for_each_numa_hop_mask(next, next_node) {
> > > > > +		cpumask_andnot(curr, next, prev);
> > > > > +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> > > > > +			cpumask_copy(cpus, curr);
> > > > > +			for_each_cpu(cpu, cpus) {
> > > > > +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> > > > > +				if (++i == nvec)
> > > > > +					goto done;
> > > > 
> > > > Think what if you're passed with irq_setup(NULL, 0, 0).
> > > > That's why I suggested to place this check at the beginning.
> > > > 
> > > irq_setup() is a helper function for mana_gd_setup_irqs(), which already takes
> > > care of no NULL pointer for irqs, and 0 number of interrupts can not be passed.
> > > 
> > > nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > > if (nvec < 0)
> > > 	return nvec;
> > 
> > I know that. But still it's a bug. The common convention is that if a
> > 0-length array is passed to a function, it should not dereference the
> > pointer.
> > 
> I will add one if check in the begining of irq_setup() to verify the pointer
> and the nvec number.

Yes you can, but what for? This is an error anyways, and you don't
care about early return. So instead of adding and bearing extra logic,
I'd just swap 2 lines of existing code.

