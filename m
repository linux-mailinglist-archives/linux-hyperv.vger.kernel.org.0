Return-Path: <linux-hyperv+bounces-5516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365CAB7406
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 20:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6621895155
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F90284663;
	Wed, 14 May 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW4PWdYm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20902283FD5;
	Wed, 14 May 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245525; cv=none; b=JBCCXTFOtxITTEF9U5jn9HaTqjMHrD2lFWYWIAQuVkqUxa9ZZSaOe5VSIGD7amQT34MtVkr128Dxxw3glT5DY3WbXzCslWAblZmjJEDgIoZ87OzuBm5fupG80fnNKZI1gWEgcxuusC6I9wfwUuX/fjhcFBnvvzpXsWrTcDaSmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245525; c=relaxed/simple;
	bh=LGi6DWjEpC9cOxvWmzOAj8f4i4+0/VuUdibXMe2cma4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSoMMBqgQSTez9FPxm+uE1h/PUFvs7BtXV8Qj/B5PBHrkimpDp2ng58ayQOX9ays2WgvW3OOVR23Zpo4eRda2hkgKZw7D4PhRRi9ptzl5jT8gxpH1XNeHgnZ9+9jsGRL3E+iWWi93ctFnaC7RTmHJDG5LnyoVeeBrSo3k/s4YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW4PWdYm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e4d235811so1276225ad.2;
        Wed, 14 May 2025 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245523; x=1747850323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz8UEmK4WSUnkB745SlVfM9IGUxFwWLlI6m1UkBfmaA=;
        b=DW4PWdYmlHpPs/B0Cv+jfRpoaSg8//69Ih4AwmQ8RzpbVi0S1GCituKn4FVM5V4xBa
         2DWNNHqW6S0A60FKsbOXwyJ1kw3Ty4K19+aN8REgFR4gG1lNLySgBavGc029kc8chcvw
         X+fkJvS09zeeMjsvdo7pspZ/BvBR9JyDLecBUVV+OS6OYgVYIEEkhfR9OcXcDny91ePj
         d3MpcAoK17typ8rfrVNCyCrtIcgOxX2luobzzbGcjDI1jnlJIOmb1Unvys9m4GXll0VU
         W+YatpJopYJicpsmghTnX+lmJ/aQXk1pqwVslu+jTJDGfsH/3BOb701LOQbcyy76WMAX
         WNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245523; x=1747850323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz8UEmK4WSUnkB745SlVfM9IGUxFwWLlI6m1UkBfmaA=;
        b=TkifhBZ7WB9If+deKjx7qkwpK/pCjMwWx13RR6NyA0elvJH0rB94wAkDxghIoOfWXZ
         mTQT1hX6u8QcCKrDd799Po7goNKmrWYwSoPiAd3a1IJG5c7up+f8PEpOEa/IPRgnpAtu
         V6obvnOCC7kE3YFNhmAeUXCLmveAIJCGWERSnsNNbfv9nb5k1mFlMzfKKyw4Uq8lKUra
         FS94ftNmW0Q8p5F1KbPJUsM7TSXP0Fw8lRyV3Q0UqATeuSwOV5bhXJxFQlk9A9v9NPZr
         J6nMQw1cAZz8fHbHqL8zEodTLIywhyJ0cQN1iU9RTPCxSzZwK5BztHwvrss/F3GLR9XG
         Wr2w==
X-Forwarded-Encrypted: i=1; AJvYcCVA2HWxm47a5qTC9pSMxF069Ei/wI0C9yxxskbl4DRz3Rkd1jmEQZlxA8mPMsPTkKFt7WUsvXhpgS94umE=@vger.kernel.org, AJvYcCVBzRZq9wHrJYAlo9O6Fnea9PP9jlNvA8JqnKuOzceoaFglHDWaaGCzDsfZznHZPO0Qa4t0NJG0heyqjQ==@vger.kernel.org, AJvYcCWp8bNDk+pW03Xkq5eJbu1/39hBKOmR38e8Z5Nbm9740meIXLeqbQ/w1gcQoihzBWhg5RHVjblikXfp@vger.kernel.org, AJvYcCX/l4Vlh4Z5wCmYD0Lo21HZS40uh0FnXBJ5jPba2nSigFqlN0JydV1hybzY+uYHega+gcRmR2JsvlkJH0GV@vger.kernel.org, AJvYcCXS0VGWM6OW30bZ5j7mYZCI+0SXczbDRnSfl5V7bZkQ6INN7WHP+TwDilj7J8K+lLrFaEUnDp/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yztnf3qAcmR7HISj2QE8YFKIMxuENVaNUhEyt47o4WqodEt/DO2
	+ntVSzDNCw+f6iHDLbyJ2mnQvUPw1hbT39AU4IkI/SMV9eOhJF7z
X-Gm-Gg: ASbGncs72J1UFvZYfW+ooQTW0rlSfqeRMRwsD5uFaykcS7mHKckCw2HtJd6r5+2nuEu
	loxqhr0me/bBr2elGRJ1oYvKEHPattuqEhHG0ormwwnY8PMpUnkKYx+WVEHLYdJNows9rhawu/y
	CTzs+1PBrei467fZToo35D49atNOFf6uCEzDl+9m7A+yxIG0QSUGWvaXfgGjeukWDv36Gocpvh5
	T4w5M425wCb5w+PNPxzq+lzuo4pAfDmx8sS0Wk4hgHGkiGuk9MMNUSm5tN8/kXFVY5lMzqvnI03
	bDDNJW8uMUYSiHlRb2gZ9CgIa8LAuCeneATqsPawQPgFzfKpCWw=
X-Google-Smtp-Source: AGHT+IEeyGGKEKTQBjte0H1mQVkFdabAaUg0tK61x92eMxOEScpw39HrOLgRuI+uILMIjebb4cT/0A==
X-Received: by 2002:a17:902:d492:b0:223:619e:71da with SMTP id d9443c01a7336-231982c8c7dmr63004855ad.49.1747245523303;
        Wed, 14 May 2025 10:58:43 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc773e7aasm102346245ad.69.2025.05.14.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:58:42 -0700 (PDT)
Date: Wed, 14 May 2025 13:58:40 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Message-ID: <aCTZ0J8F7JkWMlYW@yury>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTK5PjV1n1EYOpi@yury>
 <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 14, 2025 at 05:26:45PM +0000, Michael Kelley wrote:
> > Hope that helps.
> 
> Yes, that helps! So the key to understanding "weight" is that
> NUMA locality is preferred over sibling dislocality.
> 
> This is a great summary!  All or most of it should go as a
> comment describing the function and what it is trying to do.

OK, please consider applying:

From abdf5cc6dabd7f433b1d1e66db86333a33a2cd15 Mon Sep 17 00:00:00 2001
From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Date: Wed, 14 May 2025 13:45:26 -0400
Subject: [PATCH] net: mana: explain irq_setup() algorithm

Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
added the irq_setup() function that distributes IRQs on CPUs according
to a tricky heuristic. The corresponding commit message explains the
heuristic.

Duplicate it in the source code to make available for readers without
digging git in history. Also, add more detailed explanation about how
the heuristics is implemented.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..f9e8d4d1ba3a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1288,6 +1288,47 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+/*
+ * Spread on CPUs with the following heuristics:
+ *
+ * 1. No more than one IRQ per CPU, if possible;
+ * 2. NUMA locality is the second priority;
+ * 3. Sibling dislocality is the last priority.
+ *
+ * Let's consider this topology:
+ *
+ * Node            0               1
+ * Core        0       1       2       3
+ * CPU       0   1   2   3   4   5   6   7
+ *
+ * The most performant IRQ distribution based on the above topology
+ * and heuristics may look like this:
+ *
+ * IRQ     Nodes   Cores   CPUs
+ * 0       1       0       0-1
+ * 1       1       1       2-3
+ * 2       1       0       0-1
+ * 3       1       1       2-3
+ * 4       2       2       4-5
+ * 5       2       3       6-7
+ * 6       2       2       4-5
+ * 7       2       3       6-7
+ *
+ * The heuristics is implemented as follows.
+ *
+ * The outer for_each() loop resets the 'weight' to the actual number
+ * of CPUs in the hop. Then inner for_each() loop decrements it by the
+ * number of sibling groups (cores) while assigning first set of IRQs
+ * to each group. IRQs 0 and 1 above are distributed this way.
+ *
+ * Now, because NUMA locality is more important, we should walk the
+ * same set of siblings and assign 2nd set of IRQs (2 and 3), and it's
+ * implemented by the medium while() loop. We do like this unless the
+ * number of IRQs assigned on this hop will not become equal to number
+ * of CPUs in the hop (weight == 0). Then we switch to the next hop and
+ * do the same thing.
+ */
+
 static int irq_setup(unsigned int *irqs, unsigned int len, int node)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
-- 
2.43.0


